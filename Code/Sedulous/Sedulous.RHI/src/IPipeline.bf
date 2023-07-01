namespace Sedulous.RHI;

interface IPipeline
{
	void SetDebugName(char8* name);
	Result WriteShaderGroupIdentifiers(uint32 baseShaderGroupIndex, uint32 shaderGroupNum, void* buffer);
}