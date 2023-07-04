using System;
namespace Sedulous.RHI.Validation;

class DescriptorSetVal : DeviceObjectVal<IDescriptorSet>, IDescriptorSet
{
	private DescriptorSetDesc* m_Desc;

	public this(DeviceVal device, IDescriptorSet descriptorSet, DescriptorSetDesc descriptorSetDesc)
		: base(device, descriptorSet)
	{
		m_Desc = &descriptorSetDesc;
	}

	[Inline] public readonly ref DescriptorSetDesc GetDesc()
		{ return ref *m_Desc; }

	//================================================================================================================
	// NRI
	//================================================================================================================
	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}

	public void UpdateDescriptorRanges(uint32 physicalDeviceMask, uint32 rangeOffset, uint32 rangeNum, DescriptorRangeUpdateDesc* rangeUpdateDescs)
	{
		if (rangeNum == 0)
			return;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), rangeUpdateDescs != null, void(),
			"Can't update descriptor ranges: 'rangeUpdateDescs' is invalid.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), rangeOffset < m_Desc.rangeNum, void(),
			"Can't update descriptor ranges: 'rangeOffset' is out of bounds. (rangeOffset={0}, rangeNum={1})", rangeOffset, m_Desc.rangeNum);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), rangeOffset + rangeNum <= m_Desc.rangeNum, void(),
			"Can't update descriptor ranges: 'rangeOffset' + 'rangeNum' is greater than the number of ranges. (rangeOffset={0}, rangeNum={1}, rangeNum={2})",
			rangeOffset, rangeNum, m_Desc.rangeNum);

		DescriptorRangeUpdateDesc* rangeUpdateDescsImpl = STACK_ALLOC!<DescriptorRangeUpdateDesc>(rangeNum);
		for (uint32 i = 0; i < rangeNum; i++)
		{
			readonly ref DescriptorRangeUpdateDesc updateDesc = ref rangeUpdateDescs[i];
			readonly ref DescriptorRangeDesc rangeDesc = ref m_Desc.ranges[rangeOffset + i];

			RETURN_ON_FAILURE!(m_Device.GetLogger(), updateDesc.descriptorNum != 0, void(),
				"Can't update descriptor ranges: 'rangeUpdateDescs[{0}].descriptorNum' is zero.", i);

			RETURN_ON_FAILURE!(m_Device.GetLogger(), updateDesc.offsetInRange < rangeDesc.descriptorNum, void(),
				"Can't update descriptor ranges: 'rangeUpdateDescs[{0}].offsetInRange' is greater than the number of descriptors. (offsetInRange={1}, rangeDescriptorNum={2}, descriptorType={3})",
				i, updateDesc.offsetInRange, rangeDesc.descriptorNum, GetDescriptorTypeName(rangeDesc.descriptorType));

			RETURN_ON_FAILURE!(m_Device.GetLogger(), updateDesc.offsetInRange + updateDesc.descriptorNum <= rangeDesc.descriptorNum, void(),
				"Can't update descriptor ranges: 'rangeUpdateDescs[{0}].offsetInRange' + 'rangeUpdateDescs[{1}].descriptorNum' is greater than the number of descriptors. (offsetInRange={2}, descriptorNum={3}, rangeDescriptorNum={4}, descriptorType={5})",
				i, i, updateDesc.offsetInRange, updateDesc.descriptorNum, rangeDesc.descriptorNum, GetDescriptorTypeName(rangeDesc.descriptorType));

			RETURN_ON_FAILURE!(m_Device.GetLogger(), updateDesc.descriptors != null, void(),
				"Can't update descriptor ranges: 'rangeUpdateDescs[{0}].descriptors' is invalid.", i);

			ref DescriptorRangeUpdateDesc dstDesc = ref rangeUpdateDescsImpl[i];

			dstDesc = updateDesc;
			dstDesc.descriptors = STACK_ALLOC!<IDescriptor>(updateDesc.descriptorNum);
			IDescriptor* descriptors = (IDescriptor*)dstDesc.descriptors;

			for (uint32 j = 0; j < updateDesc.descriptorNum; j++)
			{
				RETURN_ON_FAILURE!(m_Device.GetLogger(), updateDesc.descriptors[j] != null, void(),
					"Can't update descriptor ranges: 'rangeUpdateDescs[{0}].descriptors[{1}]' is invalid.", i, j);

				descriptors[j] = NRI_GET_IMPL_PTR!<IDescriptor...>((DescriptorVal)updateDesc.descriptors[j]);
			}
		}

		m_ImplObject.UpdateDescriptorRanges(physicalDeviceMask, rangeOffset, rangeNum, rangeUpdateDescsImpl);
	}

	public void UpdateDynamicConstantBuffers(uint32 physicalDeviceMask, uint32 baseBuffer, uint32 bufferNum, IDescriptor* descriptors)
	{
		if (bufferNum == 0)
			return;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), baseBuffer < m_Desc.dynamicConstantBufferNum, void(),
			"Can't update dynamic constant buffers: 'baseBuffer' is invalid. (baseBuffer={0}, dynamicConstantBufferNum={1})",
			baseBuffer, m_Desc.dynamicConstantBufferNum);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), baseBuffer + bufferNum <= m_Desc.dynamicConstantBufferNum, void(),
			"Can't update dynamic constant buffers: 'baseBuffer' + 'bufferNum' is greater than the number of buffers. (baseBuffer={0}, bufferNum={1}, dynamicConstantBufferNum={2})",
			baseBuffer, bufferNum, m_Desc.dynamicConstantBufferNum);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), descriptors != null, void(),
			"Can't update dynamic constant buffers: 'descriptors' is invalid.");

		IDescriptor* descriptorsImpl = STACK_ALLOC!<IDescriptor>(bufferNum);
		for (uint32 i = 0; i < bufferNum; i++)
		{
			RETURN_ON_FAILURE!(m_Device.GetLogger(), descriptors[i] != null, void(),
				"Can't update dynamic constant buffers: 'descriptors[{0}]' is invalid.", i);

			descriptorsImpl[i] = NRI_GET_IMPL_PTR!<IDescriptor...>((DescriptorVal)descriptors[i]);
		}

		m_ImplObject.UpdateDynamicConstantBuffers(physicalDeviceMask, baseBuffer, bufferNum, descriptorsImpl);
	}

	public void Copy(DescriptorSetCopyDesc descriptorSetCopyDesc)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), descriptorSetCopyDesc.srcDescriptorSet != null, void(),
			"Can't copy descriptor set: 'descriptorSetCopyDesc.srcDescriptorSet' is invalid.");

		DescriptorSetVal srcDescriptorSetVal = (DescriptorSetVal)descriptorSetCopyDesc.srcDescriptorSet;
		readonly ref DescriptorSetDesc srcDesc = ref srcDescriptorSetVal.GetDesc();

		RETURN_ON_FAILURE!(m_Device.GetLogger(), descriptorSetCopyDesc.baseSrcRange < srcDesc.rangeNum, void(),
			"Can't copy descriptor set: 'descriptorSetCopyDesc.baseSrcRange' is invalid.");

		bool srcRangeValid = descriptorSetCopyDesc.baseSrcRange + descriptorSetCopyDesc.rangeNum < srcDesc.rangeNum;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), srcRangeValid, void(),
			"Can't copy descriptor set: 'descriptorSetCopyDesc.rangeNum' is invalid.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), descriptorSetCopyDesc.baseDstRange < m_Desc.rangeNum, void(),
			"Can't copy descriptor set: 'descriptorSetCopyDesc.baseDstRange' is invalid.");

		bool dstRangeValid = descriptorSetCopyDesc.baseDstRange + descriptorSetCopyDesc.rangeNum < m_Desc.rangeNum;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dstRangeValid, void(),
			"Can't copy descriptor set: 'descriptorSetCopyDesc.rangeNum' is invalid.");

		readonly bool srcOffsetValid = descriptorSetCopyDesc.baseSrcDynamicConstantBuffer < srcDesc.dynamicConstantBufferNum;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), srcOffsetValid, void(),
			"Can't copy descriptor set: 'descriptorSetCopyDesc.baseSrcDynamicConstantBuffer' is invalid.");

		srcRangeValid = descriptorSetCopyDesc.baseSrcDynamicConstantBuffer +
			descriptorSetCopyDesc.dynamicConstantBufferNum < srcDesc.dynamicConstantBufferNum;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), srcRangeValid, void(),
			"Can't copy descriptor set: source range of dynamic constant buffers is invalid.");

		readonly bool dstOffsetValid = descriptorSetCopyDesc.baseDstDynamicConstantBuffer < m_Desc.dynamicConstantBufferNum;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dstOffsetValid, void(),
			"Can't copy descriptor set: 'descriptorSetCopyDesc.baseDstDynamicConstantBuffer' is invalid.");

		dstRangeValid = descriptorSetCopyDesc.baseDstDynamicConstantBuffer +
			descriptorSetCopyDesc.dynamicConstantBufferNum < m_Desc.dynamicConstantBufferNum;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dstRangeValid, void(),
			"Can't copy descriptor set: destination range of dynamic constant buffers is invalid.");

		var descriptorSetCopyDescImpl = descriptorSetCopyDesc;
		descriptorSetCopyDescImpl.srcDescriptorSet = NRI_GET_IMPL_PTR!<IDescriptorSet...>((DescriptorSetVal)descriptorSetCopyDesc.srcDescriptorSet);

		m_ImplObject.Copy(descriptorSetCopyDescImpl);
	}
}