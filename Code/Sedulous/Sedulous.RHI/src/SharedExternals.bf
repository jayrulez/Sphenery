using System;
namespace Sedulous.RHI;

static
{
	public const uint32 PHYSICAL_DEVICE_GROUP_MAX_SIZE = 4;
	public const uint32 COMMAND_QUEUE_TYPE_NUM = (uint32)CommandQueueType.MAX_NUM;

	public static void MessageCallback(void* userArg, char8* message, Message messageType)
	{
		//MaybeUnused(userArg);
		//MaybeUnused(messageType);

		System.Diagnostics.Debug.WriteLine(scope String(message));
	}

	public static void AbortExecution(void* userArg)
	{
		//MaybeUnused(userArg);

		System.Diagnostics.Debug.SafeBreak();
	}

	public static void CheckAndSetDefaultCallbacks(ref CallbackInterface callbackInterface)
	{
		if (callbackInterface.MessageCallback == null)
			callbackInterface.MessageCallback = => MessageCallback;

		if (callbackInterface.AbortExecution == null)
			callbackInterface.AbortExecution = => AbortExecution;
	}

	[Inline] public static Vendor GetVendorFromID(uint32 vendorID)
	{
		switch (vendorID)
		{
		case 0x10DE: return .NVIDIA;
		case 0x1002: return .AMD;
		case 0x8086: return .INTEL;
		}

		return .UNKNOWN;
	}

	public const FormatSupportBits COMMON_SUPPORT =
		FormatSupportBits.TEXTURE |
		FormatSupportBits.STORAGE_TEXTURE |
		FormatSupportBits.BUFFER |
		FormatSupportBits.STORAGE_BUFFER |
		FormatSupportBits.COLOR_ATTACHMENT |
		FormatSupportBits.VERTEX_BUFFER;

	public const FormatSupportBits COMMON_SUPPORT_WITHOUT_VERTEX =
		FormatSupportBits.TEXTURE |
		FormatSupportBits.STORAGE_TEXTURE |
		FormatSupportBits.BUFFER |
		FormatSupportBits.STORAGE_BUFFER |
		FormatSupportBits.COLOR_ATTACHMENT;

	public static char8*[uint32(Message.TYPE_ERROR) + 1] MESSAGE_TYPE_NAME =
		.(
		"INFO",
		"WARNING",
		"ERROR"
		);

	public static char8*[uint32(GraphicsAPI.VULKAN) + 1] GRAPHICS_API_NAME =
		.(
		"D3D11",
		"D3D12",
		"VULKAN"
		);


	public static uint32[(uint)Format.MAX_NUM] TEXEL_BLOCK_WIDTH = .(
		0, // UNKNOWN

		1, // R8_UNORM
		1, // R8_SNORM
		1, // R8_UINT
		1, // R8_SINT

		1, // RG8_UNORM
		1, // RG8_SNORM
		1, // RG8_UINT
		1, // RG8_SINT

		1, // BGRA8_UNORM
		1, // BGRA8_SRGB

		1, // RGBA8_UNORM
		1, // RGBA8_SNORM
		1, // RGBA8_UINT
		1, // RGBA8_SINT
		1, // RGBA8_SRGB

		1, // R16_UNORM
		1, // R16_SNORM
		1, // R16_UINT
		1, // R16_SINT
		1, // R16_SFLOAT

		1, // RG16_UNORM
		1, // RG16_SNORM
		1, // RG16_UINT
		1, // RG16_SINT
		1, // RG16_SFLOAT

		1, // RGBA16_UNORM
		1, // RGBA16_SNORM
		1, // RGBA16_UINT
		1, // RGBA16_SINT
		1, // RGBA16_SFLOAT

		1, // R32_UINT
		1, // R32_SINT
		1, // R32_SFLOAT

		1, // RG32_UINT
		1, // RG32_SINT
		1, // RG32_SFLOAT

		1, // RGB32_UINT
		1, // RGB32_SINT
		1, // RGB32_SFLOAT

		1, // RGBA32_UINT
		1, // RGBA32_SINT
		1, // RGBA32_SFLOAT

		1, // R10_G10_B10_A2_UNORM
		1, // R10_G10_B10_A2_UINT
		1, // R11_G11_B10_UFLOAT
		1, // R9_G9_B9_E5_UFLOAT

		4, // BC1_RGBA_UNORM
		4, // BC1_RGBA_SRGB
		4, // BC2_RGBA_UNORM
		4, // BC2_RGBA_SRGB
		4, // BC3_RGBA_UNORM
		4, // BC3_RGBA_SRGB
		4, // BC4_R_UNORM
		4, // BC4_R_SNORM
		4, // BC5_RG_UNORM
		4, // BC5_RG_SNORM
		4, // BC6H_RGB_UFLOAT
		4, // BC6H_RGB_SFLOAT
		4, // BC7_RGBA_UNORM
		4, // BC7_RGBA_SRGB

		// DEPTH_STENCIL_ATTACHMENT views
		1, // D16_UNORM
		1, // D24_UNORM_S8_UINT
		1, // D32_SFLOAT
		1, // D32_SFLOAT_S8_UINT_X24

		// Depth-stencil specific SHADER_RESOURCE views
		0, // R24_UNORM_X8
		0, // X24_R8_UINT
		0, // X32_R8_UINT_X24
		0 // R32_SFLOAT_X8_X24
		);

	public static uint32 GetTexelBlockWidth(Format format)
	{
		return TEXEL_BLOCK_WIDTH[(uint)format];
	}

	public static uint32[(uint)Format.MAX_NUM] TEXEL_BLOCK_SIZE = .(
		1, // UNKNOWN

		1, // R8_UNORM
		1, // R8_SNORM
		1, // R8_UINT
		1, // R8_SINT

		2, // RG8_UNORM
		2, // RG8_SNORM
		2, // RG8_UINT
		2, // RG8_SINT

		4, // BGRA8_UNORM
		4, // BGRA8_SRGB

		4, // RGBA8_UNORM
		4, // RGBA8_SNORM
		4, // RGBA8_UINT
		4, // RGBA8_SINT
		4, // RGBA8_SRGB

		2, // R16_UNORM
		2, // R16_SNORM
		2, // R16_UINT
		2, // R16_SINT
		2, // R16_SFLOAT

		4, // RG16_UNORM
		4, // RG16_SNORM
		4, // RG16_UINT
		4, // RG16_SINT
		4, // RG16_SFLOAT

		8, // RGBA16_UNORM
		8, // RGBA16_SNORM
		8, // RGBA16_UINT
		8, // RGBA16_SINT
		8, // RGBA16_SFLOAT

		4, // R32_UINT
		4, // R32_SINT
		4, // R32_SFLOAT

		8, // RG32_UINT
		8, // RG32_SINT
		8, // RG32_SFLOAT

		12, // RGB32_UINT
		12, // RGB32_SINT
		12, // RGB32_SFLOAT

		16, // RGBA32_UINT
		16, // RGBA32_SINT
		16, // RGBA32_SFLOAT

		4, // R10_G10_B10_A2_UNORM
		4, // R10_G10_B10_A2_UINT
		4, // R11_G11_B10_UFLOAT
		4, // R9_G9_B9_E5_UFLOAT

		8, // BC1_RGBA_UNORM
		8, // BC1_RGBA_SRGB
		16, // BC2_RGBA_UNORM
		16, // BC2_RGBA_SRGB
		16, // BC3_RGBA_UNORM
		16, // BC3_RGBA_SRGB
		8, // BC4_R_UNORM
		8, // BC4_R_SNORM
		16, // BC5_RG_UNORM
		16, // BC5_RG_SNORM
		16, // BC6H_RGB_UFLOAT
		16, // BC6H_RGB_SFLOAT
		16, // BC7_RGBA_UNORM
		16, // BC7_RGBA_SRGB

		// DEPTH_STENCIL_ATTACHMENT views
		2, // D16_UNORM
		4, // D24_UNORM_S8_UINT
		4, // D32_SFLOAT
		8, // D32_SFLOAT_S8_UINT_X24

		// Depth-stencil specific SHADER_RESOURCE views
		0, // R24_UNORM_X8
		0, // X24_R8_UINT
		0, // X32_R8_UINT_X24
		0 // R32_SFLOAT_X8_X24
		);

	public static uint32 GetTexelBlockSize(Format format)
	{
		return TEXEL_BLOCK_SIZE[(uint)format];
	}

#pragma format disable

	public static Format[100] DXGI_FORMAT_TABLE =
		.(
		    Format.UNKNOWN,                              // DXGI_FORMAT_UNKNOWN = 0,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R32G32B32A32_TYPELESS = 1,
		    Format.RGBA32_SFLOAT,                        // DXGI_FORMAT_R32G32B32A32_FLOAT = 2,
		    Format.RGBA32_UINT,                          // DXGI_FORMAT_R32G32B32A32_UINT = 3,
		    Format.RGBA32_SINT,                          // DXGI_FORMAT_R32G32B32A32_SINT = 4,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R32G32B32_TYPELESS = 5,
		    Format.RGB32_SFLOAT,                         // DXGI_FORMAT_R32G32B32_FLOAT = 6,
		    Format.RGB32_UINT,                           // DXGI_FORMAT_R32G32B32_UINT = 7,
		    Format.RGB32_SINT,                           // DXGI_FORMAT_R32G32B32_SINT = 8,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R16G16B16A16_TYPELESS = 9,
		    Format.RGBA16_SFLOAT,                        // DXGI_FORMAT_R16G16B16A16_FLOAT = 10,
		    Format.RGBA16_UNORM,                         // DXGI_FORMAT_R16G16B16A16_UNORM = 11,
		    Format.RGBA16_UINT,                          // DXGI_FORMAT_R16G16B16A16_UINT = 12,
		    Format.RGBA16_SNORM,                         // DXGI_FORMAT_R16G16B16A16_SNORM = 13,
		    Format.RGBA16_SINT,                          // DXGI_FORMAT_R16G16B16A16_SINT = 14,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R32G32_TYPELESS = 15,
		    Format.RG32_SFLOAT,                          // DXGI_FORMAT_R32G32_FLOAT = 16,
		    Format.RG32_UINT,                            // DXGI_FORMAT_R32G32_UINT = 17,
		    Format.RGB32_SINT,                           // DXGI_FORMAT_R32G32_SINT = 18,
		    Format.UNKNOWN,                              // DXGI_FORMAT_R32G8X24_TYPELESS = 19,
		    Format.D32_SFLOAT_S8_UINT_X24,               // DXGI_FORMAT_D32_FLOAT_S8X24_UINT = 20,
		    Format.R32_SFLOAT_X8_X24,                    // DXGI_FORMAT_R32_FLOAT_X8X24_TYPELESS = 21,
		    Format.X32_R8_UINT_X24,                      // DXGI_FORMAT_X32_TYPELESS_G8X24_UINT = 22,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R10G10B10A2_TYPELESS = 23,
		    Format.R10_G10_B10_A2_UNORM,                 // DXGI_FORMAT_R10G10B10A2_UNORM = 24,
		    Format.R10_G10_B10_A2_UINT,                  // DXGI_FORMAT_R10G10B10A2_UINT = 25,
		    Format.R11_G11_B10_UFLOAT,                   // DXGI_FORMAT_R11G11B10_FLOAT = 26,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R8G8B8A8_TYPELESS = 27,
		    Format.RGBA8_UNORM,                          // DXGI_FORMAT_R8G8B8A8_UNORM = 28,
		    Format.RGBA8_SRGB,                           // DXGI_FORMAT_R8G8B8A8_UNORM_SRGB = 29,
		    Format.RGBA8_UINT,                           // DXGI_FORMAT_R8G8B8A8_UINT = 30,
		    Format.RGBA8_SNORM,                          // DXGI_FORMAT_R8G8B8A8_SNORM = 31,
		    Format.RGBA8_SINT,                           // DXGI_FORMAT_R8G8B8A8_SINT = 32,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R16G16_TYPELESS = 33,
		    Format.RG16_SFLOAT,                          // DXGI_FORMAT_R16G16_FLOAT = 34,
		    Format.RG16_UNORM,                           // DXGI_FORMAT_R16G16_UNORM = 35,
		    Format.RG16_UINT,                            // DXGI_FORMAT_R16G16_UINT = 36,
		    Format.RG16_SNORM,                           // DXGI_FORMAT_R16G16_SNORM = 37,
		    Format.RG16_SINT,                            // DXGI_FORMAT_R16G16_SINT = 38,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R32_TYPELESS = 39,
		    Format.D32_SFLOAT,                           // DXGI_FORMAT_D32_FLOAT = 40,
		    Format.R32_SFLOAT,                           // DXGI_FORMAT_R32_FLOAT = 41,
		    Format.R32_UINT,                             // DXGI_FORMAT_R32_UINT = 42,
		    Format.R32_SINT,                             // DXGI_FORMAT_R32_SINT = 43,
		    Format.UNKNOWN,                              // DXGI_FORMAT_R24G8_TYPELESS = 44,
		    Format.D24_UNORM_S8_UINT,                    // DXGI_FORMAT_D24_UNORM_S8_UINT = 45,
		    Format.R24_UNORM_X8,                         // DXGI_FORMAT_R24_UNORM_X8_TYPELESS = 46,
		    Format.X24_R8_UINT,                          // DXGI_FORMAT_X24_TYPELESS_G8_UINT = 47,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R8G8_TYPELESS = 48,
		    Format.RG8_UNORM,                            // DXGI_FORMAT_R8G8_UNORM = 49,
		    Format.RG8_UINT,                             // DXGI_FORMAT_R8G8_UINT = 50,
		    Format.RG8_SNORM,                            // DXGI_FORMAT_R8G8_SNORM = 51,
		    Format.RG8_SINT,                             // DXGI_FORMAT_R8G8_SINT = 52,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R16_TYPELESS = 53,
		    Format.R16_SFLOAT,                           // DXGI_FORMAT_R16_FLOAT = 54,
		    Format.D16_UNORM,                            // DXGI_FORMAT_D16_UNORM = 55,
		    Format.R16_UNORM,                            // DXGI_FORMAT_R16_UNORM = 56,
		    Format.R16_UINT,                             // DXGI_FORMAT_R16_UINT = 57,
		    Format.R16_SNORM,                            // DXGI_FORMAT_R16_SNORM = 58,
		    Format.R16_SINT,                             // DXGI_FORMAT_R16_SINT = 59,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R8_TYPELESS = 60,
		    Format.R8_UNORM,                             // DXGI_FORMAT_R8_UNORM = 61,
		    Format.R8_UINT,                              // DXGI_FORMAT_R8_UINT = 62,
		    Format.R8_SNORM,                             // DXGI_FORMAT_R8_SNORM = 63,
		    Format.R8_SINT,                              // DXGI_FORMAT_R8_SINT = 64,
		    Format.UNKNOWN,                              // DXGI_FORMAT_A8_UNORM = 65,

		    Format.UNKNOWN,                              // DXGI_FORMAT_R1_UNORM = 66,
		    Format.R9_G9_B9_E5_UFLOAT,                   // DXGI_FORMAT_R9G9B9E5_SHAREDEXP = 67,
		    Format.UNKNOWN,                              // DXGI_FORMAT_R8G8_B8G8_UNORM = 68,
		    Format.UNKNOWN,                              // DXGI_FORMAT_G8R8_G8B8_UNORM = 69,
		    Format.UNKNOWN,                              // DXGI_FORMAT_BC1_TYPELESS = 70,
		    Format.BC1_RGBA_UNORM,                       // DXGI_FORMAT_BC1_UNORM = 71,
		    Format.BC1_RGBA_SRGB,                        // DXGI_FORMAT_BC1_UNORM_SRGB = 72,
		    Format.UNKNOWN,                              // DXGI_FORMAT_BC2_TYPELESS = 73,
		    Format.BC2_RGBA_UNORM,                       // DXGI_FORMAT_BC2_UNORM = 74,
		    Format.BC2_RGBA_SRGB,                        // DXGI_FORMAT_BC2_UNORM_SRGB = 75,
		    Format.UNKNOWN,                              // DXGI_FORMAT_BC3_TYPELESS = 76,
		    Format.BC3_RGBA_UNORM,                       // DXGI_FORMAT_BC3_UNORM = 77,
		    Format.BC3_RGBA_SRGB,                        // DXGI_FORMAT_BC3_UNORM_SRGB = 78,
		    Format.UNKNOWN,                              // DXGI_FORMAT_BC4_TYPELESS = 79,
		    Format.BC4_R_UNORM,                          // DXGI_FORMAT_BC4_UNORM = 80,
		    Format.BC4_R_SNORM,                          // DXGI_FORMAT_BC4_SNORM = 81,
		    Format.UNKNOWN,                              // DXGI_FORMAT_BC5_TYPELESS = 82,
		    Format.BC5_RG_UNORM,                         // DXGI_FORMAT_BC5_UNORM = 83,
		    Format.BC5_RG_SNORM,                         // DXGI_FORMAT_BC5_SNORM = 84,
		    Format.UNKNOWN,                              // DXGI_FORMAT_B5G6R5_UNORM = 85,
		    Format.UNKNOWN,                              // DXGI_FORMAT_B5G5R5A1_UNORM = 86,
		    Format.BGRA8_UNORM,                          // DXGI_FORMAT_B8G8R8A8_UNORM = 87,
		    Format.UNKNOWN,                              // DXGI_FORMAT_B8G8R8X8_UNORM = 88,
		    Format.UNKNOWN,                              // DXGI_FORMAT_R10G10B10_XR_BIAS_A2_UNORM = 89,
		    Format.UNKNOWN,                              // DXGI_FORMAT_B8G8R8A8_TYPELESS = 90,
		    Format.BGRA8_SRGB,                           // DXGI_FORMAT_B8G8R8A8_UNORM_SRGB = 91,
		    Format.UNKNOWN,                              // DXGI_FORMAT_B8G8R8X8_TYPELESS = 92,
		    Format.UNKNOWN,                              // DXGI_FORMAT_B8G8R8X8_UNORM_SRGB = 93,
		    Format.UNKNOWN,                              // DXGI_FORMAT_BC6H_TYPELESS = 94,
		    Format.BC6H_RGB_UFLOAT,                      // DXGI_FORMAT_BC6H_UF16 = 95,
		    Format.BC6H_RGB_SFLOAT,                      // DXGI_FORMAT_BC6H_SF16 = 96,
		    Format.UNKNOWN,                              // DXGI_FORMAT_BC7_TYPELESS = 97,
		    Format.BC7_RGBA_UNORM,                       // DXGI_FORMAT_BC7_UNORM = 98,
		    Format.BC7_RGBA_SRGB                        // DXGI_FORMAT_BC7_UNORM_SRGB = 99,
		);

#pragma format restore
	public static Format DXGIFormatToNRIFormat(uint32 dxgiFormat)
	{
		if (dxgiFormat < DXGI_FORMAT_TABLE.Count)
			return DXGI_FORMAT_TABLE[dxgiFormat];

		return Format.UNKNOWN;
	}

#pragma format disable

	// TODO: add packed formats and depth-specific
	public static Format[261] VK_FORMAT_TABLE = .(
	    Format.UNKNOWN, // VK_FORMAT_UNDEFINED = 0,
	    Format.UNKNOWN, // VK_FORMAT_R4G4_UNORM_PACK8 = 1,
	    Format.UNKNOWN, // VK_FORMAT_R4G4B4A4_UNORM_PACK16 = 2,
	    Format.UNKNOWN, // VK_FORMAT_B4G4R4A4_UNORM_PACK16 = 3,
	    Format.UNKNOWN, // VK_FORMAT_R5G6B5_UNORM_PACK16 = 4,
	    Format.UNKNOWN, // VK_FORMAT_B5G6R5_UNORM_PACK16 = 5,
	    Format.UNKNOWN, // VK_FORMAT_R5G5B5A1_UNORM_PACK16 = 6,
	    Format.UNKNOWN, // VK_FORMAT_B5G5R5A1_UNORM_PACK16 = 7,
	    Format.UNKNOWN, // VK_FORMAT_A1R5G5B5_UNORM_PACK16 = 8,
	    Format.R8_UNORM, // VK_FORMAT_R8_UNORM = 9,
	    Format.R8_SNORM, // VK_FORMAT_R8_SNORM = 10,
	    Format.UNKNOWN, // VK_FORMAT_R8_USCALED = 11,
	    Format.UNKNOWN, // VK_FORMAT_R8_SSCALED = 12,
	    Format.R8_UINT, // VK_FORMAT_R8_UINT = 13,
	    Format.R8_SINT, // VK_FORMAT_R8_SINT = 14,
	    Format.UNKNOWN, // VK_FORMAT_R8_SRGB = 15,
	    Format.RG8_UNORM, // VK_FORMAT_R8G8_UNORM = 16,
	    Format.RG8_SNORM, // VK_FORMAT_R8G8_SNORM = 17,
	    Format.UNKNOWN, // VK_FORMAT_R8G8_USCALED = 18,
	    Format.UNKNOWN, // VK_FORMAT_R8G8_SSCALED = 19,
	    Format.RG8_UINT, // VK_FORMAT_R8G8_UINT = 20,
	    Format.RG8_SINT, // VK_FORMAT_R8G8_SINT = 21,
	    Format.UNKNOWN, // VK_FORMAT_R8G8_SRGB = 22,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8_UNORM = 23,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8_SNORM = 24,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8_USCALED = 25,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8_SSCALED = 26,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8_UINT = 27,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8_SINT = 28,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8_SRGB = 29,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8_UNORM = 30,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8_SNORM = 31,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8_USCALED = 32,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8_SSCALED = 33,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8_UINT = 34,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8_SINT = 35,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8_SRGB = 36,
	    Format.RGBA8_UNORM, // VK_FORMAT_R8G8B8A8_UNORM = 37,
	    Format.RGBA8_SNORM, // VK_FORMAT_R8G8B8A8_SNORM = 38,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8A8_USCALED = 39,
	    Format.UNKNOWN, // VK_FORMAT_R8G8B8A8_SSCALED = 40,
	    Format.RGBA8_UINT, // VK_FORMAT_R8G8B8A8_UINT = 41,
	    Format.RGBA8_SINT, // VK_FORMAT_R8G8B8A8_SINT = 42,
	    Format.RGBA8_SRGB, // VK_FORMAT_R8G8B8A8_SRGB = 43,
	    Format.BGRA8_UNORM, // VK_FORMAT_B8G8R8A8_UNORM = 44,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8A8_SNORM = 45,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8A8_USCALED = 46,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8A8_SSCALED = 47,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8A8_UINT = 48,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8A8_SINT = 49,
	    Format.BGRA8_SRGB, // VK_FORMAT_B8G8R8A8_SRGB = 50,
	    Format.UNKNOWN, // VK_FORMAT_A8B8G8R8_UNORM_PACK32 = 51,
	    Format.UNKNOWN, // VK_FORMAT_A8B8G8R8_SNORM_PACK32 = 52,
	    Format.UNKNOWN, // VK_FORMAT_A8B8G8R8_USCALED_PACK32 = 53,
	    Format.UNKNOWN, // VK_FORMAT_A8B8G8R8_SSCALED_PACK32 = 54,
	    Format.UNKNOWN, // VK_FORMAT_A8B8G8R8_UINT_PACK32 = 55,
	    Format.UNKNOWN, // VK_FORMAT_A8B8G8R8_SINT_PACK32 = 56,
	    Format.UNKNOWN, // VK_FORMAT_A8B8G8R8_SRGB_PACK32 = 57,
	    Format.UNKNOWN, // VK_FORMAT_A2R10G10B10_UNORM_PACK32 = 58,
	    Format.UNKNOWN, // VK_FORMAT_A2R10G10B10_SNORM_PACK32 = 59,
	    Format.UNKNOWN, // VK_FORMAT_A2R10G10B10_USCALED_PACK32 = 60,
	    Format.UNKNOWN, // VK_FORMAT_A2R10G10B10_SSCALED_PACK32 = 61,
	    Format.UNKNOWN, // VK_FORMAT_A2R10G10B10_UINT_PACK32 = 62,
	    Format.UNKNOWN, // VK_FORMAT_A2R10G10B10_SINT_PACK32 = 63,
	    Format.R10_G10_B10_A2_UNORM, // VK_FORMAT_A2B10G10R10_UNORM_PACK32 = 64,
	    Format.UNKNOWN, // VK_FORMAT_A2B10G10R10_SNORM_PACK32 = 65,
	    Format.UNKNOWN, // VK_FORMAT_A2B10G10R10_USCALED_PACK32 = 66,
	    Format.UNKNOWN, // VK_FORMAT_A2B10G10R10_SSCALED_PACK32 = 67,
	    Format.R10_G10_B10_A2_UINT, // VK_FORMAT_A2B10G10R10_UINT_PACK32 = 68,
	    Format.UNKNOWN, // VK_FORMAT_A2B10G10R10_SINT_PACK32 = 69,
	    Format.R16_UNORM, // VK_FORMAT_R16_UNORM = 70,
	    Format.R16_SNORM, // VK_FORMAT_R16_SNORM = 71,
	    Format.UNKNOWN, // VK_FORMAT_R16_USCALED = 72,
	    Format.UNKNOWN, // VK_FORMAT_R16_SSCALED = 73,
	    Format.R16_UINT, // VK_FORMAT_R16_UINT = 74,
	    Format.R16_SINT, // VK_FORMAT_R16_SINT = 75,
	    Format.R16_SFLOAT, // VK_FORMAT_R16_SFLOAT = 76,
	    Format.RG16_UNORM, // VK_FORMAT_R16G16_UNORM = 77,
	    Format.RG16_SNORM, // VK_FORMAT_R16G16_SNORM = 78,
	    Format.UNKNOWN, // VK_FORMAT_R16G16_USCALED = 79,
	    Format.UNKNOWN, // VK_FORMAT_R16G16_SSCALED = 80,
	    Format.RG16_UINT, // VK_FORMAT_R16G16_UINT = 81,
	    Format.RG16_SINT, // VK_FORMAT_R16G16_SINT = 82,
	    Format.RG16_SFLOAT, // VK_FORMAT_R16G16_SFLOAT = 83,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16_UNORM = 84,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16_SNORM = 85,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16_USCALED = 86,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16_SSCALED = 87,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16_UINT = 88,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16_SINT = 89,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16_SFLOAT = 90,
	    Format.RGBA16_UNORM, // VK_FORMAT_R16G16B16A16_UNORM = 91,
	    Format.RGBA16_SNORM, // VK_FORMAT_R16G16B16A16_SNORM = 92,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16A16_USCALED = 93,
	    Format.UNKNOWN, // VK_FORMAT_R16G16B16A16_SSCALED = 94,
	    Format.RGBA16_UINT, // VK_FORMAT_R16G16B16A16_UINT = 95,
	    Format.RGBA16_SINT, // VK_FORMAT_R16G16B16A16_SINT = 96,
	    Format.RGBA16_SFLOAT, // VK_FORMAT_R16G16B16A16_SFLOAT = 97,
	    Format.R32_UINT, // VK_FORMAT_R32_UINT = 98,
	    Format.R32_SINT, // VK_FORMAT_R32_SINT = 99,
	    Format.R32_SFLOAT, // VK_FORMAT_R32_SFLOAT = 100,
	    Format.RG32_UINT, // VK_FORMAT_R32G32_UINT = 101,
	    Format.RG32_SINT, // VK_FORMAT_R32G32_SINT = 102,
	    Format.RG32_SFLOAT, // VK_FORMAT_R32G32_SFLOAT = 103,
	    Format.RGB32_UINT, // VK_FORMAT_R32G32B32_UINT = 104,
	    Format.RGB32_SINT, // VK_FORMAT_R32G32B32_SINT = 105,
	    Format.RGB32_SFLOAT, // VK_FORMAT_R32G32B32_SFLOAT = 106,
	    Format.RGBA32_UINT, // VK_FORMAT_R32G32B32A32_UINT = 107,
	    Format.RGBA32_SINT, // VK_FORMAT_R32G32B32A32_SINT = 108,
	    Format.RGBA32_SFLOAT, // VK_FORMAT_R32G32B32A32_SFLOAT = 109,
	    Format.UNKNOWN, // VK_FORMAT_R64_UINT = 110,
	    Format.UNKNOWN, // VK_FORMAT_R64_SINT = 111,
	    Format.UNKNOWN, // VK_FORMAT_R64_SFLOAT = 112,
	    Format.UNKNOWN, // VK_FORMAT_R64G64_UINT = 113,
	    Format.UNKNOWN, // VK_FORMAT_R64G64_SINT = 114,
	    Format.UNKNOWN, // VK_FORMAT_R64G64_SFLOAT = 115,
	    Format.UNKNOWN, // VK_FORMAT_R64G64B64_UINT = 116,
	    Format.UNKNOWN, // VK_FORMAT_R64G64B64_SINT = 117,
	    Format.UNKNOWN, // VK_FORMAT_R64G64B64_SFLOAT = 118,
	    Format.UNKNOWN, // VK_FORMAT_R64G64B64A64_UINT = 119,
	    Format.UNKNOWN, // VK_FORMAT_R64G64B64A64_SINT = 120,
	    Format.UNKNOWN, // VK_FORMAT_R64G64B64A64_SFLOAT = 121,
	    Format.R11_G11_B10_UFLOAT, // VK_FORMAT_B10G11R11_UFLOAT_PACK32 = 122,
	    Format.R9_G9_B9_E5_UFLOAT, // VK_FORMAT_E5B9G9R9_UFLOAT_PACK32 = 123,
	    Format.UNKNOWN, // VK_FORMAT_D16_UNORM = 124,
	    Format.UNKNOWN, // VK_FORMAT_X8_D24_UNORM_PACK32 = 125,
	    Format.UNKNOWN, // VK_FORMAT_D32_SFLOAT = 126,
	    Format.UNKNOWN, // VK_FORMAT_S8_UINT = 127,
	    Format.UNKNOWN, // VK_FORMAT_D16_UNORM_S8_UINT = 128,
	    Format.UNKNOWN, // VK_FORMAT_D24_UNORM_S8_UINT = 129,
	    Format.UNKNOWN, // VK_FORMAT_D32_SFLOAT_S8_UINT = 130,
	    Format.UNKNOWN, // VK_FORMAT_BC1_RGB_UNORM_BLOCK = 131,
	    Format.UNKNOWN, // VK_FORMAT_BC1_RGB_SRGB_BLOCK = 132,
	    Format.UNKNOWN, // VK_FORMAT_BC1_RGBA_UNORM_BLOCK = 133,
	    Format.UNKNOWN, // VK_FORMAT_BC1_RGBA_SRGB_BLOCK = 134,
	    Format.UNKNOWN, // VK_FORMAT_BC2_UNORM_BLOCK = 135,
	    Format.UNKNOWN, // VK_FORMAT_BC2_SRGB_BLOCK = 136,
	    Format.UNKNOWN, // VK_FORMAT_BC3_UNORM_BLOCK = 137,
	    Format.UNKNOWN, // VK_FORMAT_BC3_SRGB_BLOCK = 138,
	    Format.UNKNOWN, // VK_FORMAT_BC4_UNORM_BLOCK = 139,
	    Format.UNKNOWN, // VK_FORMAT_BC4_SNORM_BLOCK = 140,
	    Format.UNKNOWN, // VK_FORMAT_BC5_UNORM_BLOCK = 141,
	    Format.UNKNOWN, // VK_FORMAT_BC5_SNORM_BLOCK = 142,
	    Format.UNKNOWN, // VK_FORMAT_BC6H_UFLOAT_BLOCK = 143,
	    Format.UNKNOWN, // VK_FORMAT_BC6H_SFLOAT_BLOCK = 144,
	    Format.UNKNOWN, // VK_FORMAT_BC7_UNORM_BLOCK = 145,
	    Format.UNKNOWN, // VK_FORMAT_BC7_SRGB_BLOCK = 146,
	    Format.UNKNOWN, // VK_FORMAT_ETC2_R8G8B8_UNORM_BLOCK = 147,
	    Format.UNKNOWN, // VK_FORMAT_ETC2_R8G8B8_SRGB_BLOCK = 148,
	    Format.UNKNOWN, // VK_FORMAT_ETC2_R8G8B8A1_UNORM_BLOCK = 149,
	    Format.UNKNOWN, // VK_FORMAT_ETC2_R8G8B8A1_SRGB_BLOCK = 150,
	    Format.UNKNOWN, // VK_FORMAT_ETC2_R8G8B8A8_UNORM_BLOCK = 151,
	    Format.UNKNOWN, // VK_FORMAT_ETC2_R8G8B8A8_SRGB_BLOCK = 152,
	    Format.UNKNOWN, // VK_FORMAT_EAC_R11_UNORM_BLOCK = 153,
	    Format.UNKNOWN, // VK_FORMAT_EAC_R11_SNORM_BLOCK = 154,
	    Format.UNKNOWN, // VK_FORMAT_EAC_R11G11_UNORM_BLOCK = 155,
	    Format.UNKNOWN, // VK_FORMAT_EAC_R11G11_SNORM_BLOCK = 156,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_4x4_UNORM_BLOCK = 157,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_4x4_SRGB_BLOCK = 158,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_5x4_UNORM_BLOCK = 159,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_5x4_SRGB_BLOCK = 160,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_5x5_UNORM_BLOCK = 161,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_5x5_SRGB_BLOCK = 162,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_6x5_UNORM_BLOCK = 163,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_6x5_SRGB_BLOCK = 164,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_6x6_UNORM_BLOCK = 165,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_6x6_SRGB_BLOCK = 166,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_8x5_UNORM_BLOCK = 167,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_8x5_SRGB_BLOCK = 168,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_8x6_UNORM_BLOCK = 169,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_8x6_SRGB_BLOCK = 170,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_8x8_UNORM_BLOCK = 171,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_8x8_SRGB_BLOCK = 172,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_10x5_UNORM_BLOCK = 173,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_10x5_SRGB_BLOCK = 174,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_10x6_UNORM_BLOCK = 175,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_10x6_SRGB_BLOCK = 176,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_10x8_UNORM_BLOCK = 177,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_10x8_SRGB_BLOCK = 178,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_10x10_UNORM_BLOCK = 179,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_10x10_SRGB_BLOCK = 180,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_12x10_UNORM_BLOCK = 181,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_12x10_SRGB_BLOCK = 182,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_12x12_UNORM_BLOCK = 183,
	    Format.UNKNOWN, // VK_FORMAT_ASTC_12x12_SRGB_BLOCK = 184,
	    Format.UNKNOWN, // VK_FORMAT_G8B8G8R8_422_UNORM = 1000156000,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8G8_422_UNORM = 1000156001,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8_R8_3PLANE_420_UNORM = 1000156002,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8R8_2PLANE_420_UNORM = 1000156003,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8_R8_3PLANE_422_UNORM = 1000156004,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8R8_2PLANE_422_UNORM = 1000156005,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8_R8_3PLANE_444_UNORM = 1000156006,
	    Format.UNKNOWN, // VK_FORMAT_R10X6_UNORM_PACK16 = 1000156007,
	    Format.UNKNOWN, // VK_FORMAT_R10X6G10X6_UNORM_2PACK16 = 1000156008,
	    Format.UNKNOWN, // VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 = 1000156009,
	    Format.UNKNOWN, // VK_FORMAT_G10X6B10X6G10X6R10X6_422_UNORM_4PACK16 = 1000156010,
	    Format.UNKNOWN, // VK_FORMAT_B10X6G10X6R10X6G10X6_422_UNORM_4PACK16 = 1000156011,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16 = 1000156012,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16 = 1000156013,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16 = 1000156014,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16 = 1000156015,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16 = 1000156016,
	    Format.UNKNOWN, // VK_FORMAT_R12X4_UNORM_PACK16 = 1000156017,
	    Format.UNKNOWN, // VK_FORMAT_R12X4G12X4_UNORM_2PACK16 = 1000156018,
	    Format.UNKNOWN, // VK_FORMAT_R12X4G12X4B12X4A12X4_UNORM_4PACK16 = 1000156019,
	    Format.UNKNOWN, // VK_FORMAT_G12X4B12X4G12X4R12X4_422_UNORM_4PACK16 = 1000156020,
	    Format.UNKNOWN, // VK_FORMAT_B12X4G12X4R12X4G12X4_422_UNORM_4PACK16 = 1000156021,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16 = 1000156022,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16 = 1000156023,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16 = 1000156024,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16 = 1000156025,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16 = 1000156026,
	    Format.UNKNOWN, // VK_FORMAT_G16B16G16R16_422_UNORM = 1000156027,
	    Format.UNKNOWN, // VK_FORMAT_B16G16R16G16_422_UNORM = 1000156028,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16_R16_3PLANE_420_UNORM = 1000156029,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16R16_2PLANE_420_UNORM = 1000156030,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16_R16_3PLANE_422_UNORM = 1000156031,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16R16_2PLANE_422_UNORM = 1000156032,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16_R16_3PLANE_444_UNORM = 1000156033,
	    Format.UNKNOWN, // VK_FORMAT_PVRTC1_2BPP_UNORM_BLOCK_IMG = 1000054000,
	    Format.UNKNOWN, // VK_FORMAT_PVRTC1_4BPP_UNORM_BLOCK_IMG = 1000054001,
	    Format.UNKNOWN, // VK_FORMAT_PVRTC2_2BPP_UNORM_BLOCK_IMG = 1000054002,
	    Format.UNKNOWN, // VK_FORMAT_PVRTC2_4BPP_UNORM_BLOCK_IMG = 1000054003,
	    Format.UNKNOWN, // VK_FORMAT_PVRTC1_2BPP_SRGB_BLOCK_IMG = 1000054004,
	    Format.UNKNOWN, // VK_FORMAT_PVRTC1_4BPP_SRGB_BLOCK_IMG = 1000054005,
	    Format.UNKNOWN, // VK_FORMAT_PVRTC2_2BPP_SRGB_BLOCK_IMG = 1000054006,
	    Format.UNKNOWN, // VK_FORMAT_PVRTC2_4BPP_SRGB_BLOCK_IMG = 1000054007,
	    Format.UNKNOWN, // VK_FORMAT_G8B8G8R8_422_UNORM_KHR = VK_FORMAT_G8B8G8R8_422_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_B8G8R8G8_422_UNORM_KHR = VK_FORMAT_B8G8R8G8_422_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8_R8_3PLANE_420_UNORM_KHR = VK_FORMAT_G8_B8_R8_3PLANE_420_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8R8_2PLANE_420_UNORM_KHR = VK_FORMAT_G8_B8R8_2PLANE_420_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8_R8_3PLANE_422_UNORM_KHR = VK_FORMAT_G8_B8_R8_3PLANE_422_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8R8_2PLANE_422_UNORM_KHR = VK_FORMAT_G8_B8R8_2PLANE_422_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G8_B8_R8_3PLANE_444_UNORM_KHR = VK_FORMAT_G8_B8_R8_3PLANE_444_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_R10X6_UNORM_PACK16_KHR = VK_FORMAT_R10X6_UNORM_PACK16,
	    Format.UNKNOWN, // VK_FORMAT_R10X6G10X6_UNORM_2PACK16_KHR = VK_FORMAT_R10X6G10X6_UNORM_2PACK16,
	    Format.UNKNOWN, // VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16_KHR = VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G10X6B10X6G10X6R10X6_422_UNORM_4PACK16_KHR = VK_FORMAT_G10X6B10X6G10X6R10X6_422_UNORM_4PACK16,
	    Format.UNKNOWN, // VK_FORMAT_B10X6G10X6R10X6G10X6_422_UNORM_4PACK16_KHR = VK_FORMAT_B10X6G10X6R10X6G10X6_422_UNORM_4PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16_KHR = VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_420_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16_KHR = VK_FORMAT_G10X6_B10X6R10X6_2PLANE_420_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16_KHR = VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_422_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16_KHR = VK_FORMAT_G10X6_B10X6R10X6_2PLANE_422_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16_KHR = VK_FORMAT_G10X6_B10X6_R10X6_3PLANE_444_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_R12X4_UNORM_PACK16_KHR = VK_FORMAT_R12X4_UNORM_PACK16,
	    Format.UNKNOWN, // VK_FORMAT_R12X4G12X4_UNORM_2PACK16_KHR = VK_FORMAT_R12X4G12X4_UNORM_2PACK16,
	    Format.UNKNOWN, // VK_FORMAT_R12X4G12X4B12X4A12X4_UNORM_4PACK16_KHR = VK_FORMAT_R12X4G12X4B12X4A12X4_UNORM_4PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G12X4B12X4G12X4R12X4_422_UNORM_4PACK16_KHR = VK_FORMAT_G12X4B12X4G12X4R12X4_422_UNORM_4PACK16,
	    Format.UNKNOWN, // VK_FORMAT_B12X4G12X4R12X4G12X4_422_UNORM_4PACK16_KHR = VK_FORMAT_B12X4G12X4R12X4G12X4_422_UNORM_4PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16_KHR = VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_420_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16_KHR = VK_FORMAT_G12X4_B12X4R12X4_2PLANE_420_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16_KHR = VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_422_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16_KHR = VK_FORMAT_G12X4_B12X4R12X4_2PLANE_422_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16_KHR = VK_FORMAT_G12X4_B12X4_R12X4_3PLANE_444_UNORM_3PACK16,
	    Format.UNKNOWN, // VK_FORMAT_G16B16G16R16_422_UNORM_KHR = VK_FORMAT_G16B16G16R16_422_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_B16G16R16G16_422_UNORM_KHR = VK_FORMAT_B16G16R16G16_422_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16_R16_3PLANE_420_UNORM_KHR = VK_FORMAT_G16_B16_R16_3PLANE_420_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16R16_2PLANE_420_UNORM_KHR = VK_FORMAT_G16_B16R16_2PLANE_420_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16_R16_3PLANE_422_UNORM_KHR = VK_FORMAT_G16_B16_R16_3PLANE_422_UNORM,
	    Format.UNKNOWN, // VK_FORMAT_G16_B16R16_2PLANE_422_UNORM_KHR = VK_FORMAT_G16_B16R16_2PLANE_422_UNORM,
	    Format.UNKNOWN  // VK_FORMAT_G16_B16_R16_3PLANE_444_UNORM_KHR = VK_FORMAT_G16_B16_R16_3PLANE_444_UNORM,
	);

#pragma format restore

	public static Format VKFormatToNRIFormat(uint32 format)
	{
		if (format < VK_FORMAT_TABLE.Count)
			return VK_FORMAT_TABLE[format];

		return Format.UNKNOWN;
	}

	/*public static uint32 NRIFormatToDXGIFormatD3D11(Format format){

	}

	public static uint32 NRIFormatToDXGIFormatD3D12(Format format){

	}*/

	public static  uint32 GetPhysicalDeviceGroupMask(uint32 mask)
		{ return mask == WHOLE_DEVICE_GROUP ? 0xff : mask; }
}

static{
	public static mixin RETURN_ON_FAILURE<T>(DeviceLogger logger, bool condition, T returnCode, StringView format)
	{
		if (!condition)
		{
			logger.ReportMessage(.TYPE_ERROR, format);

			return returnCode;
		}
	}

	public static mixin RETURN_ON_FAILURE<T>(DeviceLogger logger, bool condition, T returnCode, StringView format, var arg1)
	{
		if (!condition)
		{
			logger.ReportMessage(.TYPE_ERROR, format, arg1);

			return returnCode;
		}
	}

	public static mixin RETURN_ON_FAILURE<T>(DeviceLogger logger, bool condition, T returnCode, StringView format, var arg1, var arg2)
	{
		if (!condition)
		{
			logger.ReportMessage(.TYPE_ERROR, format, arg1, arg2);

			return returnCode;
		}
	}

	public static mixin RETURN_ON_FAILURE<T>(DeviceLogger logger, bool condition, T returnCode, StringView format, var arg1, var arg2, var arg3)
	{
		if (!condition)
		{
			logger.ReportMessage(.TYPE_ERROR, format, arg1, arg2, arg3);

			return returnCode;
		}
	}

	public static mixin RETURN_ON_FAILURE<T>(DeviceLogger logger, bool condition, T returnCode, StringView format, var arg1, var arg2, var arg3, var arg4)
	{
		if (!condition)
		{
			logger.ReportMessage(.TYPE_ERROR, format, arg1, arg2, arg3, arg4);

			return returnCode;
		}
	}

	public static mixin RETURN_ON_FAILURE<T>(DeviceLogger logger, bool condition, T returnCode, StringView format, var arg1, var arg2, var arg3, var arg4, var arg5)
	{
		if (!condition)
		{
			logger.ReportMessage(.TYPE_ERROR, format, arg1, arg2, arg3, arg4, arg5);

			return returnCode;
		}
	}

	public static mixin RETURN_ON_FAILURE<T>(DeviceLogger logger, bool condition, T returnCode, StringView format, var arg1, var arg2, var arg3, var arg4, var arg5, var arg6)
	{
		if (!condition)
		{
			logger.ReportMessage(.TYPE_ERROR, format, arg1, arg2, arg3, arg4, arg5, arg6);

			return returnCode;
		}
	}

	/*public static mixin RETURN_ON_FAILURE<T>(DeviceLogger logger, bool condition, T returnCode, StringView format, params Object[] args)
	{
		if (!condition)
		{
			logger.ReportMessage(.TYPE_ERROR, format, params args);

			return returnCode;
		}
	}*/

	public static void REPORT_INFO(DeviceLogger logger, StringView format, params Object[] args)
	{
		logger.ReportMessage(.TYPE_INFO, format, params args);
	}

	public static void REPORT_WARNING(DeviceLogger logger, StringView format, params Object[] args)
	{
		logger.ReportMessage(.TYPE_WARNING, format, params args);
	}

	public static void REPORT_ERROR(DeviceLogger logger, StringView format, params Object[] args)
	{
		logger.ReportMessage(.TYPE_ERROR, format, params args);
	}

	public static void CHECK(DeviceLogger logger, bool condition, StringView format, params Object[] args)
	{
#if DEBUG
		if (!condition)
			logger.ReportMessage(.TYPE_ERROR, format, params args);
#endif
	}
}