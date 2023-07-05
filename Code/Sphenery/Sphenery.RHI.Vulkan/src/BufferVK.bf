using Bulkan;
using System;
using System.Collections;
namespace Sphenery.RHI.Vulkan;

static{
	[Inline] public static VkDeviceAddress GetBufferDeviceAddress(IBuffer buffer, uint32 physicalDeviceIndex)
	{
	    readonly BufferVK bufferVK = (BufferVK)buffer;

	    return bufferVK != null ? bufferVK.GetDeviceAddress(physicalDeviceIndex) : 0;
	}
}

class BufferVK : IBuffer
{
    private DeviceVK m_Device;
    private VkBuffer[PHYSICAL_DEVICE_GROUP_MAX_SIZE] m_Handles = .();
    private VkDeviceAddress[PHYSICAL_DEVICE_GROUP_MAX_SIZE] m_DeviceAddresses = .();
    private uint64 m_Size = 0;
    private MemoryVK m_Memory = null;
    private uint64 m_MappedMemoryOffset = 0;
    private uint64 m_MappedRangeOffset = 0;
    private uint64 m_MappedRangeSize = 0;
    private bool m_OwnsNativeObjects = false;

	[Inline] public this(DeviceVK device)
	{
	    m_Device = device;
	}
	public ~this(){
		if (!m_OwnsNativeObjects)
		    return;

		if (m_Memory != null)
		    VulkanNative.vkDestroyBuffer(m_Device, m_Handles[0], m_Device.GetAllocationCallbacks());
		else
		{
		    for (uint32 i = 0; i < m_Handles.Count; i++)
		    {
		        if (m_Handles[i] != .Null)
		            VulkanNative.vkDestroyBuffer(m_Device, m_Handles[i], m_Device.GetAllocationCallbacks());
		    }
		}
	}

	[Inline] public VkBuffer GetHandle(uint32 physicalDeviceIndex)
	{ return m_Handles[physicalDeviceIndex]; }

	[Inline] public VkDeviceAddress GetDeviceAddress(uint32 physicalDeviceIndex)
	{ return m_DeviceAddresses[physicalDeviceIndex]; }

	[Inline] public DeviceVK GetDevice() 
	{ return m_Device; }

	[Inline] public uint64 GetSize()
	{ return m_Size; }


	public Result Create(BufferDesc bufferDesc){
		m_OwnsNativeObjects = true;
		m_Size = bufferDesc.size;

		readonly VkSharingMode sharingMode =
		    m_Device.IsConcurrentSharingModeEnabledForBuffers() ? .VK_SHARING_MODE_CONCURRENT : .VK_SHARING_MODE_EXCLUSIVE;

		readonly ref List<uint32> queueIndices = ref m_Device.GetConcurrentSharingModeQueueIndices();

		VkBufferCreateInfo info = .();
		info.sType = .VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
		info.size = bufferDesc.size;
		info.usage = GetBufferUsageFlags(bufferDesc.usageMask, bufferDesc.structureStride);
		info.sharingMode = sharingMode;
		info.queueFamilyIndexCount = (uint32)queueIndices.Count;
		info.pQueueFamilyIndices = queueIndices.Ptr;

		readonly uint32 physicalDeviceMask = GetPhysicalDeviceGroupMask(bufferDesc.physicalDeviceMask);

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
		    if ((1 << i) & physicalDeviceMask != 0)
		    {
		        readonly VkResult result = VulkanNative.vkCreateBuffer(m_Device, &info, m_Device.GetAllocationCallbacks(), &m_Handles[i]);

		        RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
		            "Can't create a buffer: vkCreateBuffer returned {0}.", (int32)result);
		    }
		}

		return Result.SUCCESS;
	}

	public Result Create(BufferVulkanDesc bufferDesc){
		m_OwnsNativeObjects = false;
		m_Memory = (MemoryVK)bufferDesc.memory;
		m_MappedMemoryOffset = bufferDesc.memoryOffset;
		m_Size = bufferDesc.bufferSize;

		uint32 physicalDeviceMask = GetPhysicalDeviceGroupMask(bufferDesc.physicalDeviceMask);

		if (m_Memory != null)
		    physicalDeviceMask = 0x1;

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
		    if ((1 << i) & physicalDeviceMask != 0)
		    {
		        m_Handles[i] = (VkBuffer)bufferDesc.vkBuffer;
		        m_DeviceAddresses[i] = (VkDeviceAddress)bufferDesc.deviceAddress;
		    }
		}

		return Result.SUCCESS;
	}

	public void SetHostMemory(MemoryVK memory, uint64 memoryOffset)
{
    m_Memory = memory;
    m_MappedMemoryOffset = memoryOffset;

    // No need to keep more than one instance of host buffer
    for (uint32 i = 1; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
    {
        if (m_Handles[i] != .Null)
            VulkanNative.vkDestroyBuffer(m_Device, m_Handles[i], m_Device.GetAllocationCallbacks());
        m_Handles[i] = m_Handles[0];
    }
}

	public void ReadDeviceAddress()
{
    VkBufferDeviceAddressInfo bufferDeviceAddressInfo = .();
    bufferDeviceAddressInfo.sType = .VK_STRUCTURE_TYPE_BUFFER_DEVICE_ADDRESS_INFO;

    if (VulkanNative.[Friend]vkGetBufferDeviceAddress_ptr == null)
        return;

    for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
    {
        if (m_Handles[i] != .Null)
        {
            bufferDeviceAddressInfo.buffer = m_Handles[i];
            m_DeviceAddresses[i] = VulkanNative.vkGetBufferDeviceAddress(m_Device, &bufferDeviceAddressInfo);
        }
    }
}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public void SetDebugName(char8* name){
		
		uint64[PHYSICAL_DEVICE_GROUP_MAX_SIZE] handles = .();
		for (uint i = 0; i < handles.Count; i++)
		    handles[i] = (uint64)m_Handles[i];

		m_Device.SetDebugNameToDeviceGroupObject(.VK_OBJECT_TYPE_BUFFER, &handles, name);
	}

	public void GetMemoryInfo(MemoryLocation memoryLocation, ref MemoryDesc memoryDesc)
{
    VkBuffer handle = .Null;
    for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize() && handle == .Null; i++)
        handle = m_Handles[i];

    VkMemoryDedicatedRequirements dedicatedRequirements = .(){
        sType = .VK_STRUCTURE_TYPE_MEMORY_DEDICATED_REQUIREMENTS,
        pNext = null
    };

    VkMemoryRequirements2 requirements = .(){
        sType = .VK_STRUCTURE_TYPE_MEMORY_REQUIREMENTS_2,
        pNext = &dedicatedRequirements
    };

    VkBufferMemoryRequirementsInfo2 info = .(){
        sType = .VK_STRUCTURE_TYPE_BUFFER_MEMORY_REQUIREMENTS_INFO_2,
        pNext = null,
        buffer = handle
    };

    VulkanNative.vkGetBufferMemoryRequirements2(m_Device, &info, &requirements);

    memoryDesc.mustBeDedicated = dedicatedRequirements.requiresDedicatedAllocation;
    memoryDesc.alignment = (uint32)requirements.memoryRequirements.alignment;
    memoryDesc.size = requirements.memoryRequirements.size;

    MemoryTypeUnpack unpack = .();
    readonly bool found = m_Device.GetMemoryType(memoryLocation, requirements.memoryRequirements.memoryTypeBits, ref unpack.info);
    CHECK(m_Device.GetLogger(), found, "Can't find suitable memory type: {0}", requirements.memoryRequirements.memoryTypeBits);

    unpack.info.isDedicated = dedicatedRequirements.requiresDedicatedAllocation ? 1 : 0;

    memoryDesc.type = unpack.type;
}

	public void* Map(uint64 offset, uint64 size)
{
    CHECK(m_Device.GetLogger(), m_Memory != null, "The buffer does not support memory mapping.");

    m_MappedRangeOffset = offset;
    m_MappedRangeSize = size;

	var size;
    if (size == WHOLE_SIZE)
        size = m_Size;

    return m_Memory.GetMappedMemory(0) + m_MappedMemoryOffset + offset;
}

	public void Unmap()
{
    // TODO: flush the range if the memory is not host coherent
    // if (m_Memory.IsHostCoherent())
    //     m_Memory.FlushMemoryRange(m_MappedMemoryOffset + m_MappedRangeOffset, m_MappedRangeSize);
}

	public uint64 GetNativeObject(uint32 physicalDeviceIndex)
	{
		return GetHandle(physicalDeviceIndex);
	}
}