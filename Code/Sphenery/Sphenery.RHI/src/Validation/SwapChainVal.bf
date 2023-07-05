using System.Collections;
namespace Sphenery.RHI.Validation;

class SwapChainVal : DeviceObjectVal<ISwapChain>, ISwapChain
{
	private /*mutable*/ List<TextureVal> m_Textures;
	private SwapChainDesc m_SwapChainDesc = .();

	public this(DeviceVal device, ISwapChain swapChain, SwapChainDesc swapChainDesc)
		: base(device, swapChain)
	{
		m_Textures = Allocate!<List<TextureVal>>(m_Device.GetAllocator());

		m_SwapChainDesc = swapChainDesc;
	}

	public ~this()
	{
		for (int i = 0; i < m_Textures.Count; i++)
			Deallocate!(m_Device.GetAllocator(), m_Textures[i]);

		Deallocate!(m_Device.GetAllocator(), m_Textures);
	}

		//================================================================================================================
		// NRI
		//================================================================================================================
	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}

	public ITexture* GetTextures(ref uint32 textureNum, ref Format format)
	{
		ITexture* textures = m_ImplObject.GetTextures(ref textureNum, ref format);

		TextureDesc textureDesc = .();
		textureDesc.type = TextureType.TEXTURE_2D;
		textureDesc.usageMask = TextureUsageBits.SHADER_RESOURCE | TextureUsageBits.COLOR_ATTACHMENT;
		textureDesc.format = format;
		textureDesc.size[0] = m_SwapChainDesc.width;
		textureDesc.size[1] = m_SwapChainDesc.height;
		textureDesc.size[2] = 1;
		textureDesc.mipNum = 1;
		textureDesc.arraySize = 1;
		textureDesc.sampleNum = 1;
		textureDesc.physicalDeviceMask = 0;

		m_Textures.Resize(textureNum);
		for (uint32 i = 0; i < textureNum; i++)
			m_Textures[i] = Allocate!<TextureVal>(m_Device.GetAllocator(), m_Device, textures[i], textureDesc);

		return (ITexture*)m_Textures.Ptr;
	}

	public uint32 AcquireNextTexture()
	{
		return m_ImplObject.AcquireNextTexture();
	}

	public Result Present()
	{
		return m_ImplObject.Present();
	}

	public Result SetHdrMetadata(HdrMetadata hdrMetadata)
	{
		return m_ImplObject.SetHdrMetadata(hdrMetadata);
	}
}