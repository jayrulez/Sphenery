using Bulkan;
using System;
namespace Sphenery.RHI.Vulkan;

struct SlabAllocator
{
	private uint8* m_CurrentOffset;
	private uint m_End;
	private uint8* m_Memory;

	[Inline] public this(void* memory, uint size)
	{
		m_CurrentOffset = (uint8*)memory;
		m_End = (uint)memory + size;
		m_Memory = (uint8*)memory;
	}

	[Inline] public T* Allocate<T>(ref uint32 number) mut
	{
		T* items = (T*)Align(m_CurrentOffset, (uint)alignof(T));
		readonly uint itemsLeft = (m_End - (uint)(void*)items) / (uint)sizeof(T);
		number = Math.Min<uint32>((uint32)itemsLeft, number);
		m_CurrentOffset = (uint8*)(items + number);
		return items;
	}

	[Inline] public void Reset() mut
		{ m_CurrentOffset = m_Memory; }

}

typealias WriteDescriptorsFunc = function bool(uint32 physicalDeviceIndex, DescriptorRangeDesc rangeDesc, DescriptorRangeUpdateDesc update,
	ref uint32 descriptorOffset, ref VkWriteDescriptorSet write, ref SlabAllocator slab);

static
{
	public static bool WriteTextures(uint32 physicalDeviceIndex, DescriptorRangeDesc rangeDesc, DescriptorRangeUpdateDesc update,
		ref uint32 descriptorOffset, ref VkWriteDescriptorSet write, ref SlabAllocator slab)
	{
		readonly uint32 totalItemNum = update.descriptorNum - descriptorOffset;
		uint32 itemNumForWriting = totalItemNum;
		VkDescriptorImageInfo* infoArray = slab.Allocate<VkDescriptorImageInfo>(ref itemNumForWriting);

		for (uint32 i = 0; i < itemNumForWriting; i++)
		{
			readonly DescriptorVK descriptorImpl = (DescriptorVK)update.descriptors[descriptorOffset + i];

			infoArray[i].imageView = descriptorImpl.GetImageView(physicalDeviceIndex);
			infoArray[i].imageLayout = descriptorImpl.GetImageLayout();
			infoArray[i].sampler = .Null;
		}

		write.descriptorType = GetDescriptorType(rangeDesc.descriptorType);
		write.pImageInfo = infoArray;
		write.descriptorCount = itemNumForWriting;

		descriptorOffset += itemNumForWriting;
		return itemNumForWriting == totalItemNum;
	}

	public static bool WriteTypedBuffers(uint32 physicalDeviceIndex, DescriptorRangeDesc rangeDesc, DescriptorRangeUpdateDesc update,
		ref uint32 descriptorOffset, ref VkWriteDescriptorSet write, ref SlabAllocator slab)
	{
		readonly uint32 totalItemNum = update.descriptorNum - descriptorOffset;
		uint32 itemNumForWriting = totalItemNum;
		VkBufferView* viewArray = slab.Allocate<VkBufferView>(ref itemNumForWriting);

		for (uint32 i = 0; i < itemNumForWriting; i++)
		{
			readonly DescriptorVK descriptorImpl = (DescriptorVK)update.descriptors[descriptorOffset + i];
			viewArray[i] = descriptorImpl.GetBufferView(physicalDeviceIndex);
		}

		write.descriptorType = GetDescriptorType(rangeDesc.descriptorType);
		write.pTexelBufferView = viewArray;
		write.descriptorCount = itemNumForWriting;

		descriptorOffset += itemNumForWriting;
		return itemNumForWriting == totalItemNum;
	}

	public static bool WriteBuffers(uint32 physicalDeviceIndex, DescriptorRangeDesc rangeDesc, DescriptorRangeUpdateDesc update,
		ref uint32 descriptorOffset, ref VkWriteDescriptorSet write, ref SlabAllocator slab)
	{
		readonly uint32 totalItemNum = update.descriptorNum - descriptorOffset;
		uint32 itemNumForWriting = totalItemNum;
		VkDescriptorBufferInfo* infoArray = slab.Allocate<VkDescriptorBufferInfo>(ref itemNumForWriting);

		for (uint32 i = 0; i < itemNumForWriting; i++)
		{
			readonly DescriptorVK descriptor = (DescriptorVK)update.descriptors[descriptorOffset + i];
			descriptor.GetBufferInfo(physicalDeviceIndex, ref infoArray[i]);
		}

		write.descriptorType = GetDescriptorType(rangeDesc.descriptorType);
		write.pBufferInfo = infoArray;
		write.descriptorCount = itemNumForWriting;

		descriptorOffset += itemNumForWriting;
		return itemNumForWriting == totalItemNum;
	}

	public static bool WriteSamplers(uint32 physicalDeviceIndex, DescriptorRangeDesc rangeDesc, DescriptorRangeUpdateDesc update,
		ref uint32 descriptorOffset, ref VkWriteDescriptorSet write, ref SlabAllocator slab)
	{
		//MaybeUnused(rangeDesc);
		//MaybeUnused(physicalDeviceIndex);

		readonly uint32 totalItemNum = update.descriptorNum - descriptorOffset;
		uint32 itemNumForWriting = totalItemNum;
		VkDescriptorImageInfo* infoArray = slab.Allocate<VkDescriptorImageInfo>(ref itemNumForWriting);

		for (uint32 i = 0; i < itemNumForWriting; i++)
		{
			readonly DescriptorVK descriptorImpl = (DescriptorVK)update.descriptors[descriptorOffset + i];
			infoArray[i].imageView = .Null;
			infoArray[i].imageLayout = .VK_IMAGE_LAYOUT_UNDEFINED;
			infoArray[i].sampler = descriptorImpl.GetSampler();
		}

		write.descriptorType = .VK_DESCRIPTOR_TYPE_SAMPLER;
		write.pImageInfo = infoArray;
		write.descriptorCount = itemNumForWriting;

		descriptorOffset += itemNumForWriting;
		return itemNumForWriting == totalItemNum;
	}

	public static bool WriteAccelerationStructures(uint32 physicalDeviceIndex, DescriptorRangeDesc rangeDesc, DescriptorRangeUpdateDesc update,
		ref uint32 descriptorOffset, ref VkWriteDescriptorSet write, ref SlabAllocator slab)
	{
		//MaybeUnused(rangeDesc);

		readonly uint32 totalItemNum = update.descriptorNum - descriptorOffset;
		uint32 itemNumForWriting = totalItemNum;

		uint32 infoNum = 1;
		VkWriteDescriptorSetAccelerationStructureKHR* info = slab.Allocate<VkWriteDescriptorSetAccelerationStructureKHR>(ref infoNum);

		if (infoNum != 1)
			return false;

		VkAccelerationStructureKHR* handles = slab.Allocate<VkAccelerationStructureKHR>(ref itemNumForWriting);

		info.sType = .VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET_ACCELERATION_STRUCTURE_KHR;
		info.pNext = null;
		info.accelerationStructureCount = itemNumForWriting;
		info.pAccelerationStructures = handles;

		for (uint32 i = 0; i < itemNumForWriting; i++)
		{
			readonly DescriptorVK descriptorImpl = (DescriptorVK)update.descriptors[descriptorOffset + i];
			handles[i] = descriptorImpl.GetAccelerationStructure(physicalDeviceIndex);
		}

		write.descriptorType = .VK_DESCRIPTOR_TYPE_ACCELERATION_STRUCTURE_KHR;
		write.pNext = info;
		write.descriptorCount = itemNumForWriting;

		descriptorOffset += itemNumForWriting;
		return itemNumForWriting == totalItemNum;
	}
#pragma format disable
	public static WriteDescriptorsFunc[(uint32)DescriptorType.MAX_NUM] WRITE_FUNCS = .(
	    => WriteSamplers,                   // SAMPLER
	    => WriteBuffers,                    // CONSTANT_BUFFER
	    => WriteTextures,                   // TEXTURE
	    => WriteTextures,                   // STORAGE_TEXTURE
	    => WriteTypedBuffers,               // BUFFER
	    => WriteTypedBuffers,               // STORAGE_BUFFER
	    => WriteBuffers,                    // STRUCTURED_BUFFER
	    => WriteBuffers,                    // STORAGE_STRUCTURED_BUFFER
	    => WriteAccelerationStructures     // ACCELERATION_STRUCTURE
	);
#pragma format restore
}

class DescriptorSetVK : IDescriptorSet
{
	private DeviceVK m_Device;
	private VkDescriptorSet[PHYSICAL_DEVICE_GROUP_MAX_SIZE] m_Handles = .();
	private DescriptorSetDesc* m_SetDesc = null;
	private uint32 m_DynamicConstantBufferNum = 0;

	[Inline] public this(DeviceVK device)
		{ m_Device = device; }

	[Inline] public VkDescriptorSet GetHandle(uint32 physicalDeviceIndex)
		{ return m_Handles[physicalDeviceIndex]; }

	[Inline] public DeviceVK GetDevice()
		{ return m_Device; }

	[Inline] public uint32 GetDynamicConstantBufferNum()
		{ return m_DynamicConstantBufferNum; }

	public void Create(VkDescriptorSet* handles, uint32 physicalDeviceMask, DescriptorSetDesc setDesc)
	{
		var setDesc;
		m_SetDesc = &setDesc;
		m_DynamicConstantBufferNum = setDesc.dynamicConstantBufferNum;

		uint32 handleIndex = 0;
		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
				m_Handles[i] = handles[handleIndex++];
		}
	}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public void SetDebugName(char8* name)
	{
		uint64[PHYSICAL_DEVICE_GROUP_MAX_SIZE] handles = .();
		for (uint i = 0; i < handles.Count; i++)
			handles[i] = (uint64)m_Handles[i];

		m_Device.SetDebugNameToDeviceGroupObject(.VK_OBJECT_TYPE_DESCRIPTOR_SET, &handles, name);
	}

	public void UpdateDescriptorRanges(uint32 physicalDeviceMask, uint32 rangeOffset, uint32 rangeNum, DescriptorRangeUpdateDesc* rangeUpdateDescs)
	{
		var physicalDeviceMask;
		const uint32 writesPerIteration = 1024;
		uint32 writeMaxNum = Math.Min<uint32>(writesPerIteration, rangeNum);

		VkWriteDescriptorSet* writes = STACK_ALLOC!<VkWriteDescriptorSet>(writeMaxNum);

		const uint slabSize = 32768;
		SlabAllocator slab = .(STACK_ALLOC!<uint8>(slabSize), slabSize);

		physicalDeviceMask = GetPhysicalDeviceGroupMask(physicalDeviceMask);

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (!(((1 << i) & physicalDeviceMask) != 0))
				continue;

			uint32 j = 0;
			uint32 descriptorOffset = 0;

			repeat
			{
				slab.Reset();
				bool slabHasFreeSpace = true;
				uint32 writeNum = 0;

				while (slabHasFreeSpace && j < rangeNum && writeNum < writeMaxNum)
				{
					readonly ref DescriptorRangeUpdateDesc update = ref rangeUpdateDescs[j];
					readonly ref DescriptorRangeDesc rangeDesc = ref m_SetDesc.ranges[rangeOffset + j];

					readonly uint32 bindingOffset = rangeDesc.isArray ? 0 : update.offsetInRange + descriptorOffset;
					readonly uint32 arrayOffset = rangeDesc.isArray ? update.offsetInRange + descriptorOffset : 0;

					ref VkWriteDescriptorSet write = ref writes[writeNum++];
					write = .();
					write.sType = .VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET;
					write.dstSet = m_Handles[i];
					write.dstBinding = rangeDesc.baseRegisterIndex + bindingOffset;
					write.dstArrayElement = arrayOffset;

					readonly uint32 index = (uint32)rangeDesc.descriptorType;
					slabHasFreeSpace = WRITE_FUNCS[index](i, rangeDesc, update, ref descriptorOffset, ref write, ref slab);

					j += (descriptorOffset == update.descriptorNum) ? 1 : 0;
					descriptorOffset = (descriptorOffset == update.descriptorNum) ? 0 : descriptorOffset;
				}

				VulkanNative.vkUpdateDescriptorSets(m_Device, writeNum, writes, 0, null);
			}
			while (j < rangeNum);
		}
	}

	public void UpdateDynamicConstantBuffers(uint32 physicalDeviceMask, uint32 bufferOffset, uint32 descriptorNum, IDescriptor* descriptors)
	{
		var physicalDeviceMask;
		readonly uint32 descriptorMaxNum = descriptorNum * m_Device.GetPhysicalDeviceGroupSize();

		VkWriteDescriptorSet* writes = STACK_ALLOC!<VkWriteDescriptorSet>(descriptorMaxNum);
		VkDescriptorBufferInfo* infos = STACK_ALLOC!<VkDescriptorBufferInfo>(descriptorMaxNum);
		uint32 writeNum = 0;

		physicalDeviceMask = GetPhysicalDeviceGroupMask(physicalDeviceMask);

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (!(((1 << i) & physicalDeviceMask) != 0))
				continue;

			for (uint32 j = 0; j < descriptorNum; j++)
			{
				readonly ref DynamicConstantBufferDesc bufferDesc = ref m_SetDesc.dynamicConstantBuffers[bufferOffset + j];

				ref VkDescriptorBufferInfo bufferInfo = ref infos[writeNum];
				readonly DescriptorVK descriptorImpl = (DescriptorVK)descriptors[j];
				descriptorImpl.GetBufferInfo(i, ref bufferInfo);

				writes[writeNum++] = .()
					{
						sType = .VK_STRUCTURE_TYPE_WRITE_DESCRIPTOR_SET,
						pNext = null,
						dstSet = m_Handles[i],
						dstBinding = bufferDesc.registerIndex,
						dstArrayElement = 0,
						descriptorCount = 1,
						descriptorType = .VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC,
						pImageInfo = null,
						pBufferInfo = &bufferInfo
					};
			}
		}

		VulkanNative.vkUpdateDescriptorSets(m_Device, writeNum, writes, 0, null);
	}

	public void Copy(DescriptorSetCopyDesc descriptorSetCopyDesc)
	{
		readonly uint32 descriptorRangeNum = descriptorSetCopyDesc.rangeNum + descriptorSetCopyDesc.dynamicConstantBufferNum;
		readonly uint32 copyMaxNum = descriptorRangeNum * m_Device.GetPhysicalDeviceGroupSize();

		VkCopyDescriptorSet* copies = STACK_ALLOC!<VkCopyDescriptorSet>(copyMaxNum);
		uint32 copyNum = 0;

		readonly DescriptorSetVK srcSetImpl = (DescriptorSetVK)descriptorSetCopyDesc.srcDescriptorSet;

		readonly uint32 physicalDeviceMask = GetPhysicalDeviceGroupMask(descriptorSetCopyDesc.physicalDeviceMask);

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (!(((1 << i) & physicalDeviceMask) != 0))
				continue;

			for (uint32 j = 0; j < descriptorSetCopyDesc.rangeNum; j++)
			{
				readonly ref DescriptorRangeDesc srcRangeDesc = ref srcSetImpl.m_SetDesc.ranges[descriptorSetCopyDesc.baseSrcRange + j];
				readonly ref DescriptorRangeDesc dstRangeDesc = ref m_SetDesc.ranges[descriptorSetCopyDesc.baseDstRange + j];

				copies[copyNum++] = .()
					{
						sType = .VK_STRUCTURE_TYPE_COPY_DESCRIPTOR_SET,
						pNext = null,
						srcSet = srcSetImpl.GetHandle(i),
						srcBinding = srcRangeDesc.baseRegisterIndex,
						srcArrayElement = 0,
						dstSet = m_Handles[i],
						dstBinding = dstRangeDesc.baseRegisterIndex,
						dstArrayElement = 0,
						descriptorCount = dstRangeDesc.descriptorNum
					};
			}

			for (uint32 j = 0; j < descriptorSetCopyDesc.dynamicConstantBufferNum; j++)
			{
				readonly uint32 srcBufferIndex = descriptorSetCopyDesc.baseSrcDynamicConstantBuffer + j;
				readonly ref DynamicConstantBufferDesc srcBuffer = ref srcSetImpl.m_SetDesc.dynamicConstantBuffers[srcBufferIndex];
				readonly ref DynamicConstantBufferDesc dstBuffer = ref m_SetDesc.dynamicConstantBuffers[srcBufferIndex];

				copies[copyNum++] = .()
					{
						sType = .VK_STRUCTURE_TYPE_COPY_DESCRIPTOR_SET,
						pNext = null,
						srcSet = srcSetImpl.GetHandle(i),
						srcBinding = srcBuffer.registerIndex,
						srcArrayElement = 0,
						dstSet = m_Handles[i],
						dstBinding = dstBuffer.registerIndex,
						dstArrayElement = 0,
						descriptorCount = 1
					};
			}
		}

		VulkanNative.vkUpdateDescriptorSets(m_Device, 0, null, copyNum, copies);
	}
}