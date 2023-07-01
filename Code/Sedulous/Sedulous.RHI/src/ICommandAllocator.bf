namespace Sedulous.RHI;

interface ICommandAllocator
{
	void SetDebugName(char8* name);
	Result CreateCommandBuffer(out ICommandBuffer commandBuffer);
	void Reset();
}