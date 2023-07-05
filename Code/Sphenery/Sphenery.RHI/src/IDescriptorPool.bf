namespace Sphenery.RHI;

interface IDescriptorPool
{
	void SetDebugName(char8* name);
	void Reset();

	Result AllocateDescriptorSets(IPipelineLayout pipelineLayout, uint32 setIndexInPipelineLayout, IDescriptorSet* descriptorSets,
		uint32 numberOfCopies, uint32 physicalDeviceMask, uint32 variableDescriptorNum);
}