using Bulkan;
using System;
namespace Sedulous.RHI.Vulkan;

class MemoryVK : IMemory
{
	private DeviceVK m_Device;
	private VkDeviceMemory[PHYSICAL_DEVICE_GROUP_MAX_SIZE] m_Handles = .();
	private uint8*[PHYSICAL_DEVICE_GROUP_MAX_SIZE] m_MappedMemory = .();
	private MemoryType m_Type = MemoryType.MaxValue;
	private bool m_OwnsNativeObjects = false;

	[Inline] public this(DeviceVK device)
	{
		m_Device = device;
	}
	public ~this()
	{
		if (!m_OwnsNativeObjects)
			return;

		for (uint32 i = 0; i < m_Handles.Count; i++)
		{
			if (m_Handles[i] != .Null)
				VulkanNative.vkFreeMemory(m_Device, m_Handles[i], m_Device.GetAllocationCallbacks());
		}
	}

	[Inline] public VkDeviceMemory GetHandle(uint32 physicalDeviceIndex)
		{ return m_Handles[physicalDeviceIndex]; }

	[Inline] public DeviceVK GetDevice()
		{ return m_Device; }

	[Inline] public MemoryType GetMemoryType()
		{ return m_Type; }

	[Inline] public uint8* GetMappedMemory(uint32 physicalDeviceIndex)
		{ return m_MappedMemory[physicalDeviceIndex]; }


	public Result Create(uint32 physicalDeviceMask, MemoryType memoryType, uint64 size)
	{
		var physicalDeviceMask;
		m_OwnsNativeObjects = true;
		m_Type = memoryType;

		readonly MemoryTypeUnpack unpack = .() { type = memoryType };
		readonly ref MemoryTypeInfo memoryTypeInfo = ref unpack.info;

		readonly MemoryLocation memoryLocation = (MemoryLocation)memoryTypeInfo.location;

		// Dedicated allocation occurs on memory binding
		if (memoryTypeInfo.isDedicated == 1)
			return Result.SUCCESS;

		VkMemoryAllocateFlagsInfo flagsInfo = .() { sType = .VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_FLAGS_INFO };
		flagsInfo.flags = .VK_MEMORY_ALLOCATE_DEVICE_MASK_BIT;

		if (m_Device.IsBufferDeviceAddressSupported())
			flagsInfo.flags |= .VK_MEMORY_ALLOCATE_DEVICE_ADDRESS_BIT;

		VkMemoryAllocateInfo memoryInfo = .() {  sType = .VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO };
		memoryInfo.pNext = &flagsInfo;
		memoryInfo.allocationSize = size;
		memoryInfo.memoryTypeIndex = memoryTypeInfo.memoryTypeIndex;

		physicalDeviceMask = GetPhysicalDeviceGroupMask(physicalDeviceMask);

		// No need to allocate more than one instance of host memory
		if (IsHostVisibleMemory(memoryLocation))
		{
			physicalDeviceMask = 0x1;
			flagsInfo.flags &= ~.VK_MEMORY_ALLOCATE_DEVICE_MASK_BIT;
		}

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
			{
				flagsInfo.deviceMask = 1 << i;

				VkResult result = VulkanNative.vkAllocateMemory(m_Device, &memoryInfo, m_Device.GetAllocationCallbacks(), &m_Handles[i]);

				RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
					"Can't allocate a memory: vkAllocateMemory returned {0}.", (int32)result);

				if (IsHostVisibleMemory(memoryLocation))
				{
					result = VulkanNative.vkMapMemory(m_Device, m_Handles[i], 0, size, 0, (void**)&m_MappedMemory[i]);

					RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
						"Can't map the allocated memory: vkMapMemory returned {0}.", (int32)result);
				}
			}
		}

		return Result.SUCCESS;
	}

	public Result Create(MemoryVulkanDesc memoryDesc)
	{
		m_OwnsNativeObjects = false;

		MemoryTypeUnpack unpack = .();
		readonly bool found = m_Device.GetMemoryType(memoryDesc.memoryTypeIndex, ref unpack.info);
		CHECK(m_Device.GetLogger(), found, "Can't find memory type: {0}", memoryDesc.memoryTypeIndex);

		readonly VkDeviceMemory handle = (VkDeviceMemory)memoryDesc.vkDeviceMemory;
		readonly uint32 physicalDeviceMask = GetPhysicalDeviceGroupMask(memoryDesc.physicalDeviceMask);

		readonly ref MemoryTypeInfo memoryTypeInfo = ref unpack.info;

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
			{
				m_Handles[i] = handle;

				if (IsHostVisibleMemory((MemoryLocation)memoryTypeInfo.location))
				{
					readonly VkResult result = VulkanNative.vkMapMemory(m_Device, m_Handles[i], 0, memoryDesc.size, 0, (void**)&m_MappedMemory[i]);

					RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
						"Can't map the memory: vkMapMemory returned {0}.", (int32)result);
				}
			}
		}

		return Result.SUCCESS;
	}

	public Result CreateDedicated(BufferVK buffer, uint32 physicalDeviceMask)
	{
		var physicalDeviceMask;
		m_OwnsNativeObjects = true;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_Type != MemoryType.MaxValue, Result.FAILURE,
			"Can't allocate a dedicated memory: memory type is invalid.");

		readonly MemoryTypeUnpack unpack = .() { type = m_Type };
		readonly ref MemoryTypeInfo memoryTypeInfo = ref unpack.info;

		readonly MemoryLocation memoryLocation = (MemoryLocation)memoryTypeInfo.location;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), memoryTypeInfo.isDedicated == 1, Result.FAILURE,
			"Can't allocate a dedicated memory: memory type is not dedicated.");

		MemoryDesc memoryDesc = .();
		buffer.GetMemoryInfo(memoryLocation, ref memoryDesc);

		VkMemoryAllocateFlagsInfo flagsInfo = .() { sType = .VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_FLAGS_INFO };
		flagsInfo.flags = .VK_MEMORY_ALLOCATE_DEVICE_MASK_BIT | .VK_MEMORY_ALLOCATE_DEVICE_ADDRESS_BIT;

		VkMemoryDedicatedAllocateInfo dedicatedAllocateInfo = .() { sType = .VK_STRUCTURE_TYPE_MEMORY_DEDICATED_ALLOCATE_INFO };
		dedicatedAllocateInfo.pNext = &flagsInfo;

		VkMemoryAllocateInfo memoryInfo = .() { sType = .VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO };
		memoryInfo.pNext = &dedicatedAllocateInfo;
		memoryInfo.allocationSize = memoryDesc.size;
		memoryInfo.memoryTypeIndex = memoryTypeInfo.memoryTypeIndex;

		// No need to allocate two instances of host memory
		if (IsHostVisibleMemory(memoryLocation))
		{
			physicalDeviceMask = 0x1;
			flagsInfo.flags &= ~.VK_MEMORY_ALLOCATE_DEVICE_MASK_BIT;
		}

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
			{
				dedicatedAllocateInfo.buffer = buffer.GetHandle(i);
				flagsInfo.deviceMask = 1 << i;

				VkResult result = VulkanNative.vkAllocateMemory(m_Device, &memoryInfo, m_Device.GetAllocationCallbacks(), &m_Handles[i]);

				RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
					"Can't allocate a dedicated memory: vkAllocateMemory returned {0}.", (int32)result);

				if (IsHostVisibleMemory(memoryLocation))
				{
					result = VulkanNative.vkMapMemory(m_Device, m_Handles[i], 0, memoryDesc.size, 0, (void**)&m_MappedMemory[i]);

					RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
						"Can't map the allocated memory: vkMapMemory returned {0}.", (int32)result);
				}
			}
		}

		return Result.SUCCESS;
	}

	public Result CreateDedicated(TextureVK texture, uint32 physicalDeviceMask)
	{
		var physicalDeviceMask;
		m_OwnsNativeObjects = true;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_Type != MemoryType.MaxValue, Result.FAILURE,
			"Can't allocate a dedicated memory: invalid memory type.");

		readonly MemoryTypeUnpack unpack = .() { type = m_Type };
		readonly ref MemoryTypeInfo memoryTypeInfo = ref unpack.info;

		readonly MemoryLocation memoryLocation = (MemoryLocation)memoryTypeInfo.location;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), memoryTypeInfo.isDedicated == 1, Result.FAILURE,
			"Can't allocate a dedicated memory: the memory type is not dedicated.");

		MemoryDesc memoryDesc = .();
		texture.GetMemoryInfo((MemoryLocation)memoryTypeInfo.location, ref memoryDesc);

		VkMemoryAllocateFlagsInfo flagsInfo = .() {  sType = .VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_FLAGS_INFO };
		flagsInfo.flags = .VK_MEMORY_ALLOCATE_DEVICE_MASK_BIT;

		VkMemoryDedicatedAllocateInfo dedicatedAllocateInfo = .() {  sType = .VK_STRUCTURE_TYPE_MEMORY_DEDICATED_ALLOCATE_INFO };
		dedicatedAllocateInfo.pNext = &flagsInfo;

		VkMemoryAllocateInfo memoryInfo = .() { sType = .VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO };
		memoryInfo.pNext = &dedicatedAllocateInfo;
		memoryInfo.allocationSize = memoryDesc.size;
		memoryInfo.memoryTypeIndex = memoryTypeInfo.memoryTypeIndex;

		// No need to allocate two instances of host memory
		if (IsHostVisibleMemory(memoryLocation))
		{
			physicalDeviceMask = 0x1;
			dedicatedAllocateInfo.pNext = null;
		}

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
			{
				dedicatedAllocateInfo.image = texture.GetHandle(i);
				flagsInfo.deviceMask = 1 << i;

				VkResult result = VulkanNative.vkAllocateMemory(m_Device, &memoryInfo, m_Device.GetAllocationCallbacks(), &m_Handles[i]);

				RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
					"Can't allocate a dedicated memory: vkAllocateMemory returned {0}.", (int32)result);

				if (IsHostVisibleMemory(memoryLocation))
				{
					result = VulkanNative.vkMapMemory(m_Device, m_Handles[i], 0, memoryDesc.size, 0, (void**)&m_MappedMemory[i]);

					RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
						"Can't map the allocated memory: vkMapMemory returned {0}.", (int32)result);
				}
			}
		}

		return Result.SUCCESS;
	}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public void SetDebugName(char8* name)
	{
		uint64[PHYSICAL_DEVICE_GROUP_MAX_SIZE] handles = .();
		for (uint i = 0; i < handles.Count; i++)
			handles[i] = (uint64)m_Handles[i];

		m_Device.SetDebugNameToDeviceGroupObject(.VK_OBJECT_TYPE_DEVICE_MEMORY, &handles, name);
	}
}