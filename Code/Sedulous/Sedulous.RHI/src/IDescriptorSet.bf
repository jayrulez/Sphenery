namespace Sedulous.RHI;

interface IDescriptorSet
{
	void SetDebugName(char8* name);
	void UpdateDescriptorRanges(uint32 physicalDeviceMask, uint32 rangeOffset, uint32 rangeNum, DescriptorRangeUpdateDesc* rangeUpdateDescs);
	void UpdateDynamicConstantBuffers(uint32 physicalDeviceMask, uint32 bufferOffset, uint32 descriptorNum, IDescriptor* descriptors);
	void Copy(DescriptorSetCopyDesc descriptorSetCopyDesc);
}