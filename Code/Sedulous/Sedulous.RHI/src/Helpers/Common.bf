using System;
namespace Sedulous.RHI.Helpers;

struct TextureSubresourceUploadDesc
{
	public void* slices;
	public uint32 sliceNum;
	public uint32 rowPitch;
	public uint32 slicePitch;
}

struct TextureUploadDesc
{
	public  TextureSubresourceUploadDesc* subresources;
	public ITexture texture;
	public AccessBits nextAccess;
	public TextureLayout nextLayout;
	public uint16 mipNum;
	public uint16 arraySize;
}

struct BufferUploadDesc
{
	public  void* data;
	public  uint64 dataSize;
	public IBuffer buffer;
	public uint64 bufferOffset;
	public AccessBits prevAccess;
	public AccessBits nextAccess;
}

struct ResourceGroupDesc
{
	public MemoryLocation memoryLocation;
	public ITexture* textures;
	public uint32 textureNum;
	public IBuffer* buffers;
	public uint32 bufferNum;
}

static
{
	[Inline]
	public static Format GetSupportedDepthFormat(IDevice device, uint32 minBits, bool stencil)
	{
		if (stencil)
		{
			if (minBits <= 24)
			{
				if (device.GetFormatSupport(.D24_UNORM_S8_UINT) & FormatSupportBits.DEPTH_STENCIL_ATTACHMENT != .UNSUPPORTED)
					return .D24_UNORM_S8_UINT;
			}
		}
		else
		{
			if (minBits <= 16)
			{
				if (device.GetFormatSupport(.D16_UNORM) & FormatSupportBits.DEPTH_STENCIL_ATTACHMENT != .UNSUPPORTED)
					return .D16_UNORM;
			}
			else if (minBits <= 24)
			{
				if (device.GetFormatSupport(.D24_UNORM_S8_UINT) & FormatSupportBits.DEPTH_STENCIL_ATTACHMENT != .UNSUPPORTED)
					return .D24_UNORM_S8_UINT;
			}

			if (device.GetFormatSupport(.D32_SFLOAT) & FormatSupportBits.DEPTH_STENCIL_ATTACHMENT != .UNSUPPORTED)
				return .D32_SFLOAT;
		}

		if (device.GetFormatSupport(.D32_SFLOAT_S8_UINT_X24) & FormatSupportBits.DEPTH_STENCIL_ATTACHMENT != .UNSUPPORTED)
			return .D32_SFLOAT_S8_UINT_X24;

		return .UNKNOWN;
	}

	[Inline]
	public static TextureDesc Texture1D(Format format, uint16 width, uint16 mipNum = 1, uint16 arraySize = 1, TextureUsageBits usageMask = .SHADER_RESOURCE)
	{
		TextureDesc textureDesc = .();
		textureDesc.type = .TEXTURE_1D;
		textureDesc.format = format;
		textureDesc.usageMask = usageMask;
		textureDesc.size[0] = width;
		textureDesc.size[1] = 1;
		textureDesc.size[2] = 1;
		textureDesc.mipNum = mipNum;
		textureDesc.arraySize = arraySize;
		textureDesc.sampleNum = 1;

		return textureDesc;
	}

	[Inline]
	public static TextureDesc Texture2D(Format format, uint16 width, uint16 height, uint16 mipNum = 1, uint16 arraySize = 1, TextureUsageBits usageMask = .SHADER_RESOURCE, uint8 sampleNum = 1)
	{
		TextureDesc textureDesc = .();
		textureDesc.type = .TEXTURE_2D;
		textureDesc.format = format;
		textureDesc.usageMask = usageMask;
		textureDesc.size[0] = width;
		textureDesc.size[1] = height;
		textureDesc.size[2] = 1;
		textureDesc.mipNum = mipNum;
		textureDesc.arraySize = arraySize;
		textureDesc.sampleNum = sampleNum;

		return textureDesc;
	}

	[Inline]
	public static TextureDesc Texture3D(Format format, uint16 width, uint16 height, uint16 depth, uint16 mipNum = 1, TextureUsageBits usageMask = .SHADER_RESOURCE)
	{
		TextureDesc textureDesc = .();
		textureDesc.type = .TEXTURE_3D;
		textureDesc.format = format;
		textureDesc.usageMask = usageMask;
		textureDesc.size[0] = width;
		textureDesc.size[1] = height;
		textureDesc.size[2] = depth;
		textureDesc.mipNum = mipNum;
		textureDesc.arraySize = 1;
		textureDesc.sampleNum = 1;

		return textureDesc;
	}

	[Inline]
	public static TextureTransitionBarrierDesc TextureTransition(ITexture texture, AccessBits prevAccess, AccessBits nextAccess, TextureLayout prevLayout, TextureLayout nextLayout,
		uint16 mipOffset = 0, uint16 mipNum = REMAINING_MIP_LEVELS, uint16 arrayOffset = 0, uint16 arraySize = REMAINING_ARRAY_LAYERS)
	{
		TextureTransitionBarrierDesc textureTransitionBarrierDesc = .();
		textureTransitionBarrierDesc.texture = texture;
		textureTransitionBarrierDesc.prevAccess = prevAccess;
		textureTransitionBarrierDesc.nextAccess = nextAccess;
		textureTransitionBarrierDesc.prevLayout = prevLayout;
		textureTransitionBarrierDesc.nextLayout = nextLayout;
		textureTransitionBarrierDesc.mipOffset = mipOffset;
		textureTransitionBarrierDesc.mipNum = mipNum;
		textureTransitionBarrierDesc.arrayOffset = arrayOffset;
		textureTransitionBarrierDesc.arraySize = arraySize;

		return textureTransitionBarrierDesc;
	}

	[Inline]
	public static TextureTransitionBarrierDesc TextureTransitionFromUnknown(ITexture texture, AccessBits nextAccess, TextureLayout nextLayout,
		uint16 mipOffset = 0, uint16 mipNum = REMAINING_MIP_LEVELS, uint16 arrayOffset = 0, uint16 arraySize = REMAINING_ARRAY_LAYERS)
	{
		TextureTransitionBarrierDesc textureTransitionBarrierDesc = .();
		textureTransitionBarrierDesc.texture = texture;
		textureTransitionBarrierDesc.prevAccess = .UNKNOWN;
		textureTransitionBarrierDesc.nextAccess = nextAccess;
		textureTransitionBarrierDesc.prevLayout = .UNKNOWN;
		textureTransitionBarrierDesc.nextLayout = nextLayout;
		textureTransitionBarrierDesc.mipOffset = mipOffset;
		textureTransitionBarrierDesc.mipNum = mipNum;
		textureTransitionBarrierDesc.arrayOffset = arrayOffset;
		textureTransitionBarrierDesc.arraySize = arraySize;

		return textureTransitionBarrierDesc;
	}

	[Inline]
	public static TextureTransitionBarrierDesc TextureTransitionFromState(ref TextureTransitionBarrierDesc prevState, AccessBits nextAccess, TextureLayout nextLayout,
		uint16 mipOffset = 0, uint16 mipNum = REMAINING_MIP_LEVELS)
	{
		prevState.mipOffset = mipOffset;
		prevState.mipNum = mipNum;
		prevState.prevAccess = prevState.nextAccess;
		prevState.nextAccess = nextAccess;
		prevState.prevLayout = prevState.nextLayout;
		prevState.nextLayout = nextLayout;

		return prevState;
	}
}