namespace Sedulous.RHI;

interface ISwapChain
{
	void SetDebugName(char8* name);
	ITexture* GetTextures(ref uint32 textureNum, ref Format format);
	uint32 AcquireNextTexture();
	Result Present();
	Result SetHdrMetadata(HdrMetadata hdrMetadata);
}