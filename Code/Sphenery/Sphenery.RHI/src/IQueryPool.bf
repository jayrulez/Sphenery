namespace Sphenery.RHI;

interface IQueryPool
{
	void SetDebugName(char8* name);
	uint32 GetQuerySize();
}