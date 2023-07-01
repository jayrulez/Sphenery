namespace Sedulous.RHI;

interface IFence
{
	void SetDebugName(char8* name);
	uint64 GetFenceValue();
	void Wait(uint64 value);
}