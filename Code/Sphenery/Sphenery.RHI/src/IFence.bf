namespace Sphenery.RHI;

interface IFence
{
	void SetDebugName(char8* name);
	uint64 GetFenceValue();
	void Wait(uint64 value);
	void QueueSignal(ICommandQueue commandQueue, uint64 value);
	void QueueWait(ICommandQueue commandQueue, uint64 value);
}