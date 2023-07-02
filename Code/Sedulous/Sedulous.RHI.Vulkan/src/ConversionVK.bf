using Bulkan;
using System;
namespace Sedulous.RHI.Vulkan;

static
{
	private const VkIndexType[(uint32)IndexType.MAX_NUM] INDEX_TYPE_TABLE = .(
		.VK_INDEX_TYPE_UINT16,
		.VK_INDEX_TYPE_UINT32
		);

	private const VkImageLayout[(uint32)TextureLayout.MAX_NUM] LAYOUT_TABLE = .(
		.VK_IMAGE_LAYOUT_GENERAL, // GENERAL,
		.VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL, // COLOR_ATTACHMENT,
		.VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL, // DEPTH_STENCIL,
		.VK_IMAGE_LAYOUT_DEPTH_STENCIL_READ_ONLY_OPTIMAL, // DEPTH_STENCIL_READONLY,
		.VK_IMAGE_LAYOUT_DEPTH_READ_ONLY_STENCIL_ATTACHMENT_OPTIMAL, // DEPTH_READONLY,
		.VK_IMAGE_LAYOUT_DEPTH_ATTACHMENT_STENCIL_READ_ONLY_OPTIMAL, // STENCIL_READONLY,
		.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL, // SHADER_RESOURCE,
		.VK_IMAGE_LAYOUT_PRESENT_SRC_KHR, // PRESENT,
		.VK_IMAGE_LAYOUT_UNDEFINED // UNKNOWN
		);

	public static VkBufferUsageFlags GetBufferUsageFlags(BufferUsageBits usageMask, uint32 structureStride)
	{
		VkBufferUsageFlags flags = .VK_BUFFER_USAGE_TRANSFER_SRC_BIT | .VK_BUFFER_USAGE_TRANSFER_DST_BIT |
			.VK_BUFFER_USAGE_SHADER_DEVICE_ADDRESS_BIT;

		if (usageMask.HasFlag(BufferUsageBits.VERTEX_BUFFER))
			flags |= .VK_BUFFER_USAGE_VERTEX_BUFFER_BIT;

		if (usageMask.HasFlag(BufferUsageBits.INDEX_BUFFER))
			flags |= .VK_BUFFER_USAGE_INDEX_BUFFER_BIT;

		if (usageMask.HasFlag(BufferUsageBits.CONSTANT_BUFFER))
			flags |= .VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT;

		if (usageMask.HasFlag(BufferUsageBits.ARGUMENT_BUFFER))
			flags |= .VK_BUFFER_USAGE_INDIRECT_BUFFER_BIT;

		// TODO: add more usage bits
		if (usageMask.HasFlag(BufferUsageBits.RAY_TRACING_BUFFER))
		{
			flags |= .VK_BUFFER_USAGE_SHADER_BINDING_TABLE_BIT_KHR | .VK_BUFFER_USAGE_ACCELERATION_STRUCTURE_STORAGE_BIT_KHR |
				.VK_BUFFER_USAGE_STORAGE_BUFFER_BIT;
		}

		if (usageMask.HasFlag(BufferUsageBits.ACCELERATION_STRUCTURE_BUILD_READ))
			flags |= .VK_BUFFER_USAGE_ACCELERATION_STRUCTURE_BUILD_INPUT_READ_ONLY_BIT_KHR;

		if (usageMask.HasFlag(BufferUsageBits.SHADER_RESOURCE))
		{
			if (structureStride == 0)
				flags |= .VK_BUFFER_USAGE_UNIFORM_TEXEL_BUFFER_BIT;
			else
				flags |= .VK_BUFFER_USAGE_STORAGE_BUFFER_BIT;
		}

		if (usageMask.HasFlag(BufferUsageBits.SHADER_RESOURCE_STORAGE))
		{
			if (structureStride == 0 && (usageMask & BufferUsageBits.RAY_TRACING_BUFFER) == 0)
				flags |= .VK_BUFFER_USAGE_STORAGE_TEXEL_BUFFER_BIT;
			else
				flags |= .VK_BUFFER_USAGE_STORAGE_BUFFER_BIT;
		}

		return flags;
	}

	public static VkIndexType GetIndexType(IndexType indexType)
	{
		return INDEX_TYPE_TABLE[(uint32)indexType];
	}

	public static VkImageLayout GetImageLayout(TextureLayout layout)
	{
		return LAYOUT_TABLE[(uint32)layout];
	}

	public static VkAccessFlags GetAccessFlags(AccessBits mask)
	{
		VkAccessFlags flags = 0;

		if (mask.HasFlag(AccessBits.VERTEX_BUFFER))
			flags |= .VK_ACCESS_VERTEX_ATTRIBUTE_READ_BIT;

		if (mask.HasFlag(AccessBits.INDEX_BUFFER))
			flags |= .VK_ACCESS_INDEX_READ_BIT;

		if (mask.HasFlag(AccessBits.CONSTANT_BUFFER))
			flags |= .VK_ACCESS_UNIFORM_READ_BIT;

		if (mask.HasFlag(AccessBits.ARGUMENT_BUFFER))
			flags |= .VK_ACCESS_INDIRECT_COMMAND_READ_BIT;

		if (mask.HasFlag(AccessBits.SHADER_RESOURCE))
			flags |= .VK_ACCESS_SHADER_READ_BIT;

		if (mask.HasFlag(AccessBits.SHADER_RESOURCE_STORAGE))
			flags |= .VK_ACCESS_SHADER_READ_BIT | .VK_ACCESS_SHADER_WRITE_BIT;

		if (mask.HasFlag(AccessBits.COLOR_ATTACHMENT))
			flags |= .VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT; // TODO: add READ bit too?

		if (mask.HasFlag(AccessBits.DEPTH_STENCIL_WRITE))
			flags |= .VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT;

		if (mask.HasFlag(AccessBits.DEPTH_STENCIL_READ))
			flags |= .VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_READ_BIT;

		if (mask.HasFlag(AccessBits.COPY_SOURCE))
			flags |= .VK_ACCESS_TRANSFER_READ_BIT;

		if (mask.HasFlag(AccessBits.COPY_DESTINATION))
			flags |= .VK_ACCESS_TRANSFER_WRITE_BIT;

		if (mask.HasFlag(AccessBits.ACCELERATION_STRUCTURE_READ))
			flags |= .VK_ACCESS_ACCELERATION_STRUCTURE_READ_BIT_KHR;

		if (mask.HasFlag(AccessBits.ACCELERATION_STRUCTURE_WRITE))
			flags |= .VK_ACCESS_ACCELERATION_STRUCTURE_WRITE_BIT_KHR;

		return flags;
	}

	private const VkDescriptorType[(uint32)DescriptorType.MAX_NUM] DESCRIPTOR_TYPES =
		.(
		.VK_DESCRIPTOR_TYPE_SAMPLER, // SAMPLER
		.VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER, // CONSTANT_BUFFER
		.VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE, // TEXTURE
		.VK_DESCRIPTOR_TYPE_STORAGE_IMAGE, // STORAGE_TEXTURE
		.VK_DESCRIPTOR_TYPE_UNIFORM_TEXEL_BUFFER, // BUFFER
		.VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, // STORAGE_BUFFER
		.VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, // STRUCTURED_BUFFER
		.VK_DESCRIPTOR_TYPE_STORAGE_BUFFER, // STORAGE_STRUCTURED_BUFFER
		.VK_DESCRIPTOR_TYPE_ACCELERATION_STRUCTURE_KHR // ACCELERATION_STRUCTURE
		);

	public static VkDescriptorType GetDescriptorType(DescriptorType type)
	{
		return DESCRIPTOR_TYPES[(uint32)type];
	}

	private const VkShaderStageFlags[(uint32)ShaderStage.MAX_NUM] SHADER_STAGE_TABLE = .(
		.VK_SHADER_STAGE_ALL, // ALL,
		.VK_SHADER_STAGE_VERTEX_BIT, // VERTEX,
		.VK_SHADER_STAGE_TESSELLATION_CONTROL_BIT, // TESS_CONTROL,
		.VK_SHADER_STAGE_TESSELLATION_EVALUATION_BIT, // TESS_EVALUATION,
		.VK_SHADER_STAGE_GEOMETRY_BIT, // GEOMETRY,
		.VK_SHADER_STAGE_FRAGMENT_BIT, // FRAGMENT,
		.VK_SHADER_STAGE_COMPUTE_BIT, // COMPUTE,
		.VK_SHADER_STAGE_RAYGEN_BIT_KHR, // RAYGEN,
		.VK_SHADER_STAGE_MISS_BIT_KHR, // MISS,
		.VK_SHADER_STAGE_INTERSECTION_BIT_KHR, // INTERSECTION,
		.VK_SHADER_STAGE_CLOSEST_HIT_BIT_KHR, // CLOSEST_HIT,
		.VK_SHADER_STAGE_ANY_HIT_BIT_KHR, // ANY_HIT
		.VK_SHADER_STAGE_CALLABLE_BIT_KHR, // CALLABLE
		.VK_SHADER_STAGE_TASK_BIT_EXT, // MESH_CONTROL
		.VK_SHADER_STAGE_MESH_BIT_EXT // MESH_EVALUATION
		);

	public static VkShaderStageFlags GetShaderStageFlags(ShaderStage stage)
	{
		return SHADER_STAGE_TABLE[(uint32)stage];
	}

	private const VkFormat[(uint32)Format.MAX_NUM] VK_IMAGE_VIEW_FORMAT = .(
		.VK_FORMAT_UNDEFINED, // UNKNOWN

		.VK_FORMAT_R8_UNORM, // R8_UNORM
		.VK_FORMAT_R8_SNORM, // R8_SNORM
		.VK_FORMAT_R8_UINT, // R8_UINT
		.VK_FORMAT_R8_SINT, // R8_SINT

		.VK_FORMAT_R8G8_UNORM, // RG8_UNORM
		.VK_FORMAT_R8G8_SNORM, // RG8_SNORM
		.VK_FORMAT_R8G8_UINT, // RG8_UINT
		.VK_FORMAT_R8G8_SINT, // RG8_SINT

		.VK_FORMAT_B8G8R8A8_UNORM, // BGRA8_UNORM
		.VK_FORMAT_B8G8R8A8_SRGB, // BGRA8_SRGB

		.VK_FORMAT_R8G8B8A8_UNORM, // RGBA8_UNORM
		.VK_FORMAT_R8G8B8A8_SNORM, // RGBA8_SNORM
		.VK_FORMAT_R8G8B8A8_UINT, // RGBA8_UINT
		.VK_FORMAT_R8G8B8A8_SINT, // RGBA8_SINT
		.VK_FORMAT_R8G8B8A8_SRGB, // RGBA8_SRGB

		.VK_FORMAT_R16_UNORM, // R16_UNORM
		.VK_FORMAT_R16_SNORM, // R16_SNORM
		.VK_FORMAT_R16_UINT, // R16_UINT
		.VK_FORMAT_R16_SINT, // R16_SINT
		.VK_FORMAT_R16_SFLOAT, // R16_SFLOAT

		.VK_FORMAT_R16G16_UNORM, // RG16_UNORM
		.VK_FORMAT_R16G16_SNORM, // RG16_SNORM
		.VK_FORMAT_R16G16_UINT, // RG16_UINT
		.VK_FORMAT_R16G16_SINT, // RG16_SINT
		.VK_FORMAT_R16G16_SFLOAT, // RG16_SFLOAT

		.VK_FORMAT_R16G16B16A16_UNORM, // RGBA16_UNORM
		.VK_FORMAT_R16G16B16A16_SNORM, // RGBA16_SNORM
		.VK_FORMAT_R16G16B16A16_UINT, // RGBA16_UINT
		.VK_FORMAT_R16G16B16A16_SINT, // RGBA16_SINT
		.VK_FORMAT_R16G16B16A16_SFLOAT, // RGBA16_SFLOAT

		.VK_FORMAT_R32_UINT, // R32_UINT
		.VK_FORMAT_R32_SINT, // R32_SINT
		.VK_FORMAT_R32_SFLOAT, // R32_SFLOAT

		.VK_FORMAT_R32G32_UINT, // RG32_UINT
		.VK_FORMAT_R32G32_SINT, // RG32_SINT
		.VK_FORMAT_R32G32_SFLOAT, // RG32_SFLOAT

		.VK_FORMAT_R32G32B32_UINT, // RGB32_UINT
		.VK_FORMAT_R32G32B32_SINT, // RGB32_SINT
		.VK_FORMAT_R32G32B32_SFLOAT, // RGB32_SFLOAT

		.VK_FORMAT_R32G32B32A32_UINT, // RGB32_UINT
		.VK_FORMAT_R32G32B32A32_SINT, // RGB32_SINT
		.VK_FORMAT_R32G32B32A32_SFLOAT, // RGB32_SFLOAT

		.VK_FORMAT_A2B10G10R10_UNORM_PACK32, // R10_G10_B10_A2_UNORM
		.VK_FORMAT_A2B10G10R10_UINT_PACK32, // R10_G10_B10_A2_UINT
		.VK_FORMAT_B10G11R11_UFLOAT_PACK32, // R11_G11_B10_UFLOAT
		.VK_FORMAT_E5B9G9R9_UFLOAT_PACK32, // R9_G9_B9_E5_UFLOAT

		.VK_FORMAT_BC1_RGBA_UNORM_BLOCK, // BC1_RGBA_UNORM
		.VK_FORMAT_BC1_RGBA_SRGB_BLOCK, // BC1_RGBA_SRGB
		.VK_FORMAT_BC2_UNORM_BLOCK, // BC2_RGBA_UNORM
		.VK_FORMAT_BC2_SRGB_BLOCK, // BC2_RGBA_SRGB
		.VK_FORMAT_BC3_UNORM_BLOCK, // BC3_RGBA_UNORM
		.VK_FORMAT_BC3_SRGB_BLOCK, // BC3_RGBA_SRGB
		.VK_FORMAT_BC4_UNORM_BLOCK, // BC4_R_UNORM
		.VK_FORMAT_BC4_SNORM_BLOCK, // BC4_R_SNORM
		.VK_FORMAT_BC5_UNORM_BLOCK, // BC5_RG_UNORM
		.VK_FORMAT_BC5_SNORM_BLOCK, // BC5_RG_SNORM
		.VK_FORMAT_BC6H_UFLOAT_BLOCK, // BC6H_RGB_UFLOAT
		.VK_FORMAT_BC6H_SFLOAT_BLOCK, // BC6H_RGB_SFLOAT
		.VK_FORMAT_BC7_UNORM_BLOCK, // BC7_RGBA_UNORM
		.VK_FORMAT_BC7_SRGB_BLOCK, // BC7_RGBA_SRGB

			// Depth-specific

		.VK_FORMAT_D16_UNORM, // D16_UNORM
		.VK_FORMAT_D24_UNORM_S8_UINT, // D24_UNORM_S8_UINT
		.VK_FORMAT_D32_SFLOAT, // D32_SFLOAT
		.VK_FORMAT_D32_SFLOAT_S8_UINT, // D32_SFLOAT_S8_UINT_X24_TYPELESS

		.VK_FORMAT_X8_D24_UNORM_PACK32, // D24_UNORM_X8_TYPELESS
		.VK_FORMAT_D24_UNORM_S8_UINT, // X24_TYPLESS_S8_UINT /// TODO: there is no such format in VK
		.VK_FORMAT_D32_SFLOAT_S8_UINT, // X32_TYPLESS_S8_UINT_X24_TYPELESS
		.VK_FORMAT_D32_SFLOAT_S8_UINT // D32_SFLOAT_X8_TYPLESS_X24_TYPELESS
		);

	private const VkImageCreateFlags[(uint)Format.MAX_NUM] IMAGE_CREATE_FLAGS = .(
		0, // UNKNOWN,

		0, // R8_UNORM,
		0, // R8_SNORM,
		0, // R8_UINT,
		0, // R8_SINT,

		0, // RG8_UNORM,
		0, // RG8_SNORM,
		0, // RG8_UINT,
		0, // RG8_SINT,

		0, // BGRA8_UNORM,
		.VK_IMAGE_CREATE_MUTABLE_FORMAT_BIT, // BGRA8_SRGB,

		0, // RGBA8_UNORM,
		0, // RGBA8_SNORM,
		0, // RGBA8_UINT,
		0, // RGBA8_SINT,
		.VK_IMAGE_CREATE_MUTABLE_FORMAT_BIT, // RGBA8_SRGB,

		0, // R16_UNORM,
		0, // R16_SNORM,
		0, // R16_UINT,
		0, // R16_SINT,
		0, // R16_SFLOAT,

		0, // RG16_UNORM,
		0, // RG16_SNORM,
		0, // RG16_UINT,
		0, // RG16_SINT,
		0, // RG16_SFLOAT,

		0, // RGBA16_UNORM,
		0, // RGBA16_SNORM,
		0, // RGBA16_UINT,
		0, // RGBA16_SINT,
		0, // RGBA16_SFLOAT,

		0, // R32_UINT,
		0, // R32_SINT,
		0, // R32_SFLOAT,

		0, // RG32_UINT,
		0, // RG32_SINT,
		0, // RG32_SFLOAT,

		0, // RGB32_UINT,
		0, // RGB32_SINT,
		0, // RGB32_SFLOAT,

		0, // RGBA32_UINT,
		0, // RGBA32_SINT,
		0, // RGBA32_SFLOAT,

		0, // R10_G10_B10_A2_UNORM,
		0, // R10_G10_B10_A2_UINT,
		0, // R11_G11_B10_UFLOAT,
		0, // R9_G9_B9_E5_UFLOAT,

		0, // BC1_RGBA_UNORM,
		0, // BC1_RGBA_SRGB,
		0, // BC2_RGBA_UNORM,
		0, // BC2_RGBA_SRGB,
		0, // BC3_RGBA_UNORM,
		0, // BC3_RGBA_SRGB,
		0, // BC4_R_UNORM,
		0, // BC4_R_SNORM,
		0, // BC5_RG_UNORM,
		0, // BC5_RG_SNORM,
		0, // BC6H_RGB_UFLOAT,
		0, // BC6H_RGB_SFLOAT,
		0, // BC7_RGBA_UNORM,
		0, // BC7_RGBA_SRGB,

		0, // D16_UNORM,
		0, // D24_UNORM_S8_UINT,
		0, // D32_SFLOAT,
		0, // D32_SFLOAT_S8_UINT_X24,

		0, // R24_UNORM_X8,
		0, // X24_R8_UINT,
		0, // X32_R8_UINT_X24,
		0 // R32_SFLOAT_X8_X24,
		);

	public static VkImageCreateFlags GetImageCreateFlags(Format format)
	{
		return IMAGE_CREATE_FLAGS[(uint)format];
	}

	[Inline] public static VkFormat GetVkFormat(Format format)
	{
		return (VkFormat)NRIFormatToVKFormat(format);
	}

	public static VkFormat GetVkImageViewFormat(Format format)
	{
		return VK_IMAGE_VIEW_FORMAT[(uint32)format];
	}

	private const VkPrimitiveTopology[(uint32)Topology.MAX_NUM] TOPOLOGIES = .(
		.VK_PRIMITIVE_TOPOLOGY_POINT_LIST, // POINT_LIST
		.VK_PRIMITIVE_TOPOLOGY_LINE_LIST, // LINE_LIST
		.VK_PRIMITIVE_TOPOLOGY_LINE_STRIP, // LINE_STRIP
		.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST, // TRIANGLE_LIST
		.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP, // TRIANGLE_STRIP
		.VK_PRIMITIVE_TOPOLOGY_LINE_LIST_WITH_ADJACENCY, // LINE_LIST_WITH_ADJACENCY
		.VK_PRIMITIVE_TOPOLOGY_LINE_STRIP_WITH_ADJACENCY, // LINE_STRIP_WITH_ADJACENCY
		.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST_WITH_ADJACENCY, // TRIANGLE_LIST_WITH_ADJACENCY
		.VK_PRIMITIVE_TOPOLOGY_TRIANGLE_STRIP_WITH_ADJACENCY, // TRIANGLE_STRIP_WITH_ADJACENCY
		.VK_PRIMITIVE_TOPOLOGY_PATCH_LIST // PATCH_LIST
		);

	public static VkPrimitiveTopology GetTopology(Topology topology)
	{
		return TOPOLOGIES[(uint32)topology];
	}

	private const VkCullModeFlags[(uint32)CullMode.MAX_NUM] CULL_MODES = .(
		.VK_CULL_MODE_NONE, // NONE
		.VK_CULL_MODE_FRONT_BIT, // FRONT
		.VK_CULL_MODE_BACK_BIT // BACK
		);

	public static VkCullModeFlags GetCullMode(CullMode cullMode)
	{
		return CULL_MODES[(uint32)cullMode];
	}

	private const VkPolygonMode[(uint32)FillMode.MAX_NUM] POLYGON_MODES = .(
		.VK_POLYGON_MODE_FILL, // SOLID
		.VK_POLYGON_MODE_LINE // WIREFRAME
		);

	public static VkPolygonMode GetPolygonMode(FillMode fillMode)
	{
		return POLYGON_MODES[(uint32)fillMode];
	}

	public static float GetDepthOffset(int32 depth)
	{
		return 0.0f; // TODO: implement correct conversion
	}

	public static VkSampleCountFlags GetSampleCount(uint32 sampleNum)
	{
		return (VkSampleCountFlags)sampleNum;
	}

	private const VkCompareOp[(uint32)CompareFunc.MAX_NUM] COMPARE_OP = .(
		.VK_COMPARE_OP_NEVER, // NONE
		.VK_COMPARE_OP_ALWAYS, // ALWAYS
		.VK_COMPARE_OP_NEVER, // NEVER
		.VK_COMPARE_OP_LESS, // LESS
		.VK_COMPARE_OP_LESS_OR_EQUAL, // LESS_EQUAL
		.VK_COMPARE_OP_EQUAL, // EQUAL
		.VK_COMPARE_OP_GREATER_OR_EQUAL, // GREATER_EQUAL
		.VK_COMPARE_OP_GREATER, // GREATER
		.VK_COMPARE_OP_NOT_EQUAL // NOT_EQUAL
		);

	public static VkCompareOp GetCompareOp(CompareFunc compareFunc)
	{
		return COMPARE_OP[(uint32)compareFunc];
	}

	private const VkStencilOp[(uint32)StencilFunc.MAX_NUM] STENCIL_OP = .(
		.VK_STENCIL_OP_KEEP, // KEEP,
		.VK_STENCIL_OP_ZERO, // ZERO,
		.VK_STENCIL_OP_REPLACE, // REPLACE,
		.VK_STENCIL_OP_INCREMENT_AND_CLAMP, // INCREMENT_AND_CLAMP,
		.VK_STENCIL_OP_DECREMENT_AND_CLAMP, // DECREMENT_AND_CLAMP,
		.VK_STENCIL_OP_INVERT, // INVERT,
		.VK_STENCIL_OP_INCREMENT_AND_WRAP, // INCREMENT_AND_WRAP,
		.VK_STENCIL_OP_DECREMENT_AND_WRAP // DECREMENT_AND_WRAP
		);

	public static VkStencilOp GetStencilOp(StencilFunc stencilFunc)
	{
		return STENCIL_OP[(uint32)stencilFunc];
	}

	private const VkLogicOp[(uint32)LogicFunc.MAX_NUM] LOGIC_OP = .( /*.VK_LOGIC_OP_MAX_ENUM*/(VkLogicOp)0x7FFFFFFF, // NONE
		.VK_LOGIC_OP_CLEAR, // CLEAR
		.VK_LOGIC_OP_AND, // AND
		.VK_LOGIC_OP_AND_REVERSE, // AND_REVERSE
		.VK_LOGIC_OP_COPY, // COPY
		.VK_LOGIC_OP_AND_INVERTED, // AND_INVERTED
		.VK_LOGIC_OP_XOR, // XOR
		.VK_LOGIC_OP_OR, // OR
		.VK_LOGIC_OP_NOR, // NOR
		.VK_LOGIC_OP_EQUIVALENT, // EQUIVALENT
		.VK_LOGIC_OP_INVERT, // INVERT
		.VK_LOGIC_OP_OR_REVERSE, // OR_REVERSE
		.VK_LOGIC_OP_COPY_INVERTED, // COPY_INVERTED
		.VK_LOGIC_OP_OR_INVERTED, // OR_INVERTED
		.VK_LOGIC_OP_NAND, // NAND
		.VK_LOGIC_OP_SET // SET
		);

	public static VkLogicOp GetLogicOp(LogicFunc logicFunc)
	{
		return LOGIC_OP[(uint32)logicFunc];
	}

	private const VkBlendFactor[(uint32)BlendFactor.MAX_NUM] BLEND_FACTOR = .(
		.VK_BLEND_FACTOR_ZERO, // ZERO
		.VK_BLEND_FACTOR_ONE, // ONE
		.VK_BLEND_FACTOR_SRC_COLOR, // SRC_COLOR
		.VK_BLEND_FACTOR_ONE_MINUS_SRC_COLOR, // ONE_MINUS_SRC_COLOR
		.VK_BLEND_FACTOR_DST_COLOR, // DST_COLOR
		.VK_BLEND_FACTOR_ONE_MINUS_DST_COLOR, // ONE_MINUS_DST_COLOR
		.VK_BLEND_FACTOR_SRC_ALPHA, // SRC_ALPHA
		.VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA, // ONE_MINUS_SRC_ALPHA
		.VK_BLEND_FACTOR_DST_ALPHA, // DST_ALPHA
		.VK_BLEND_FACTOR_ONE_MINUS_DST_ALPHA, // ONE_MINUS_DST_ALPHA
		.VK_BLEND_FACTOR_CONSTANT_COLOR, // CONSTANT_COLOR
		.VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_COLOR, // ONE_MINUS_CONSTANT_COLOR
		.VK_BLEND_FACTOR_CONSTANT_ALPHA, // CONSTANT_ALPHA
		.VK_BLEND_FACTOR_ONE_MINUS_CONSTANT_ALPHA, // ONE_MINUS_CONSTANT_ALPHA
		.VK_BLEND_FACTOR_SRC_ALPHA_SATURATE, // SRC_ALPHA_SATURATE
		.VK_BLEND_FACTOR_SRC1_COLOR, // SRC1_COLOR
		.VK_BLEND_FACTOR_ONE_MINUS_SRC1_COLOR, // ONE_MINUS_SRC1_COLOR
		.VK_BLEND_FACTOR_SRC1_ALPHA, // SRC1_ALPHA
		.VK_BLEND_FACTOR_ONE_MINUS_SRC1_ALPHA // ONE_MINUS_SRC1_ALPHA
		);

	public static VkBlendFactor GetBlendFactor(BlendFactor blendFactor)
	{
		return BLEND_FACTOR[(uint32)blendFactor];
	}

	private const VkBlendOp[(uint32)BlendFunc.MAX_NUM] BLEND_OP = .(
		.VK_BLEND_OP_ADD, // ADD
		.VK_BLEND_OP_SUBTRACT, // SUBTRACT
		.VK_BLEND_OP_REVERSE_SUBTRACT, // REVERSE_SUBTRACT
		.VK_BLEND_OP_MIN, // MIN
		.VK_BLEND_OP_MAX // MAX
		);

	public static VkBlendOp GetBlendOp(BlendFunc blendFunc)
	{
		return BLEND_OP[(uint32)blendFunc];
	}

	public static VkColorComponentFlags GetColorComponent(ColorWriteBits colorWriteMask)
	{
		return (VkColorComponentFlags)(colorWriteMask & ColorWriteBits.RGBA);
	}

	private const VkImageType[(uint32)TextureType.MAX_NUM] IMAGE_TYPES = .(
		.VK_IMAGE_TYPE_1D,
		.VK_IMAGE_TYPE_2D,
		.VK_IMAGE_TYPE_3D
		);

	public static VkImageType GetImageType(TextureType type)
	{
		return IMAGE_TYPES[(uint32)type];
	}

	public static VkImageUsageFlags GetImageUsageFlags(TextureUsageBits usageMask)
	{
		VkImageUsageFlags flags = .VK_IMAGE_USAGE_TRANSFER_SRC_BIT | .VK_IMAGE_USAGE_TRANSFER_DST_BIT;

		if (usageMask.HasFlag(TextureUsageBits.SHADER_RESOURCE))
			flags |= .VK_IMAGE_USAGE_SAMPLED_BIT;

		if (usageMask.HasFlag(TextureUsageBits.SHADER_RESOURCE_STORAGE))
			flags |= .VK_IMAGE_USAGE_STORAGE_BIT;

		if (usageMask.HasFlag(TextureUsageBits.COLOR_ATTACHMENT))
			flags |= .VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT;

		if (usageMask.HasFlag(TextureUsageBits.DEPTH_STENCIL_ATTACHMENT))
			flags |= .VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT;

		return flags;
	}

	public static VkImageAspectFlags GetImageAspectFlags(Format format)
	{
		switch (format)
		{
		case Format.D16_UNORM,
			Format.D32_SFLOAT,
			Format.R24_UNORM_X8,
			Format.R32_SFLOAT_X8_X24:
			return .VK_IMAGE_ASPECT_DEPTH_BIT;

		case Format.D24_UNORM_S8_UINT,
			Format.D32_SFLOAT_S8_UINT_X24:
			return .VK_IMAGE_ASPECT_DEPTH_BIT | .VK_IMAGE_ASPECT_STENCIL_BIT;

		case Format.X32_R8_UINT_X24,
			Format.X24_R8_UINT:
			return .VK_IMAGE_ASPECT_STENCIL_BIT;

		default:
			return .VK_IMAGE_ASPECT_COLOR_BIT;
		}
	}

	private const VkFilter[(uint32)Filter.MAX_NUM] FILTER = .(
		.VK_FILTER_NEAREST, // NEAREST
		.VK_FILTER_LINEAR // LINEAR
		);

	public static VkFilter GetFilter(Filter filter)
	{
		return FILTER[(uint32)filter];
	}

	private const VkSamplerMipmapMode[(uint32)Filter.MAX_NUM] SAMPLER_MIPMAP_MODE = .(
		.VK_SAMPLER_MIPMAP_MODE_NEAREST, // NEAREST
		.VK_SAMPLER_MIPMAP_MODE_LINEAR // LINEAR
		);

	public static VkSamplerMipmapMode GetSamplerMipmapMode(Filter filter)
	{
		return SAMPLER_MIPMAP_MODE[(uint32)filter];
	}

	private const VkSamplerAddressMode[(uint32)AddressMode.MAX_NUM] SAMPLER_ADDRESS_MODE = .(
		.VK_SAMPLER_ADDRESS_MODE_REPEAT, // REPEAT
		.VK_SAMPLER_ADDRESS_MODE_MIRRORED_REPEAT, // MIRRORED_REPEAT
		.VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_EDGE, // CLAMP_TO_EDGE
		.VK_SAMPLER_ADDRESS_MODE_CLAMP_TO_BORDER // CLAMP_TO_BORDER
		);

	public static VkSamplerAddressMode GetSamplerAddressMode(AddressMode addressMode)
	{
		return SAMPLER_ADDRESS_MODE[(uint32)addressMode];
	}

	private const VkQueryType[(uint32)QueryType.MAX_NUM] QUERY_TYPE = .(
		.VK_QUERY_TYPE_TIMESTAMP, // TIMESTAMP
		.VK_QUERY_TYPE_OCCLUSION, // OCCLUSION
		.VK_QUERY_TYPE_PIPELINE_STATISTICS, // PIPELINE_STATISTICS
		.VK_QUERY_TYPE_ACCELERATION_STRUCTURE_COMPACTED_SIZE_KHR // ACCELERATION_STRUCTURE_COMPACTED_SIZE
		);

	public static VkQueryType GetQueryType(QueryType queryType)
	{
		return QUERY_TYPE[(uint32)queryType];
	}

	public static VkQueryPipelineStatisticFlags GetQueryPipelineStatisticsFlags(PipelineStatsBits pipelineStatsMask)
	{
		VkQueryPipelineStatisticFlags flags = 0;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.INPUT_ASSEMBLY_VERTICES))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_VERTICES_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.INPUT_ASSEMBLY_PRIMITIVES))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_INPUT_ASSEMBLY_PRIMITIVES_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.VERTEX_SHADER_INVOCATIONS))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_VERTEX_SHADER_INVOCATIONS_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.GEOMETRY_SHADER_INVOCATIONS))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_INVOCATIONS_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.GEOMETRY_SHADER_PRIMITIVES))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_GEOMETRY_SHADER_PRIMITIVES_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.CLIPPING_INVOCATIONS))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_CLIPPING_INVOCATIONS_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.FRAGMENT_SHADER_INVOCATIONS))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_FRAGMENT_SHADER_INVOCATIONS_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.TESS_CONTROL_SHADER_PATCHES))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_CONTROL_SHADER_PATCHES_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.TESS_EVALUATION_SHADER_INVOCATIONS))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_TESSELLATION_EVALUATION_SHADER_INVOCATIONS_BIT;

		if (pipelineStatsMask.HasFlag(PipelineStatsBits.COMPUTE_SHADER_INVOCATIONS))
			flags |= .VK_QUERY_PIPELINE_STATISTIC_COMPUTE_SHADER_INVOCATIONS_BIT;

		return flags;
	}

	private const VkImageViewType[(uint32)Texture1DViewType.MAX_NUM] IMAGE_VIEW_TYPE_1D = .(
		.VK_IMAGE_VIEW_TYPE_1D, // SHADER_RESOURCE_1D,
		.VK_IMAGE_VIEW_TYPE_1D_ARRAY, // SHADER_RESOURCE_1D_ARRAY,
		.VK_IMAGE_VIEW_TYPE_1D, // SHADER_RESOURCE_STORAGE_1D,
		.VK_IMAGE_VIEW_TYPE_1D_ARRAY, // SHADER_RESOURCE_STORAGE_1D_ARRAY,
		.VK_IMAGE_VIEW_TYPE_1D, // COLOR_ATTACHMENT,
		.VK_IMAGE_VIEW_TYPE_1D // DEPTH_STENCIL_ATTACHMENT
		);

	private const VkImageViewType[(uint32)Texture2DViewType.MAX_NUM] IMAGE_VIEW_TYPE_2D = .(
		.VK_IMAGE_VIEW_TYPE_2D, // SHADER_RESOURCE_2D,
		.VK_IMAGE_VIEW_TYPE_2D_ARRAY, // SHADER_RESOURCE_2D_ARRAY,
		.VK_IMAGE_VIEW_TYPE_CUBE, // SHADER_RESOURCE_CUBE,
		.VK_IMAGE_VIEW_TYPE_CUBE_ARRAY, // SHADER_RESOURCE_CUBE_ARRAY,
		.VK_IMAGE_VIEW_TYPE_2D, // SHADER_RESOURCE_STORAGE_2D,
		.VK_IMAGE_VIEW_TYPE_2D_ARRAY, // SHADER_RESOURCE_STORAGE_2D_ARRAY,
		.VK_IMAGE_VIEW_TYPE_2D, // COLOR_ATTACHMENT,
		.VK_IMAGE_VIEW_TYPE_2D // DEPTH_STENCIL_ATTACHMENT
		);

	private const VkImageViewType[(uint32)Texture3DViewType.MAX_NUM] IMAGE_VIEW_TYPE_3D = .(
		.VK_IMAGE_VIEW_TYPE_3D, // SHADER_RESOURCE_3D,
		.VK_IMAGE_VIEW_TYPE_3D, // SHADER_RESOURCE_STORAGE_3D,
		.VK_IMAGE_VIEW_TYPE_3D // COLOR_ATTACHMENT
		);

	public static VkImageViewType GetImageViewType(Texture1DViewType type)
	{
		return IMAGE_VIEW_TYPE_1D[(uint32)type];
	}

	public static VkImageViewType GetImageViewType(Texture2DViewType type)
	{
		return IMAGE_VIEW_TYPE_2D[(uint32)type];
	}

	public static VkImageViewType GetImageViewType(Texture3DViewType type)
	{
		return IMAGE_VIEW_TYPE_3D[(uint32)type];
	}

	private const VkImageUsageFlags[(uint32)Texture1DViewType.MAX_NUM] IMAGE_VIEW_USAGE_1D = .(
		.VK_IMAGE_USAGE_SAMPLED_BIT, // SHADER_RESOURCE_1D,
		.VK_IMAGE_USAGE_SAMPLED_BIT, // SHADER_RESOURCE_1D_ARRAY,
		.VK_IMAGE_USAGE_STORAGE_BIT, // SHADER_RESOURCE_STORAGE_1D,
		.VK_IMAGE_USAGE_STORAGE_BIT, // SHADER_RESOURCE_STORAGE_1D_ARRAY,
		.VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT, // COLOR_ATTACHMENT,
		.VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT // DEPTH_STENCIL_ATTACHMENT
		);

	private const VkImageUsageFlags[(uint32)Texture2DViewType.MAX_NUM] IMAGE_VIEW_USAGE_2D = .(
		.VK_IMAGE_USAGE_SAMPLED_BIT, // SHADER_RESOURCE_2D,
		.VK_IMAGE_USAGE_SAMPLED_BIT, // SHADER_RESOURCE_2D_ARRAY,
		.VK_IMAGE_USAGE_SAMPLED_BIT, // SHADER_RESOURCE_CUBE,
		.VK_IMAGE_USAGE_SAMPLED_BIT, // SHADER_RESOURCE_CUBE_ARRAY,
		.VK_IMAGE_USAGE_STORAGE_BIT, // SHADER_RESOURCE_STORAGE_2D,
		.VK_IMAGE_USAGE_STORAGE_BIT, // SHADER_RESOURCE_STORAGE_2D_ARRAY,
		.VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT, // COLOR_ATTACHMENT,
		.VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT // DEPTH_STENCIL_ATTACHMENT
		);

	private const VkImageUsageFlags[(uint32)Texture3DViewType.MAX_NUM] IMAGE_VIEW_USAGE_3D = .(
		.VK_IMAGE_USAGE_SAMPLED_BIT, // SHADER_RESOURCE_3D,
		.VK_IMAGE_USAGE_STORAGE_BIT, // SHADER_RESOURCE_STORAGE_3D,
		.VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT // COLOR_ATTACHMENT
		);

	public static VkImageUsageFlags GetImageViewUsage(Texture1DViewType type)
	{
		return IMAGE_VIEW_USAGE_1D[(uint32)type];
	}

	public static VkImageUsageFlags GetImageViewUsage(Texture2DViewType type)
	{
		return IMAGE_VIEW_USAGE_2D[(uint32)type];
	}

	public static VkImageUsageFlags GetImageViewUsage(Texture3DViewType type)
	{
		return IMAGE_VIEW_USAGE_3D[(uint32)type];
	}

	private const VkImageLayout[(uint32)Texture1DViewType.MAX_NUM] IMAGE_LAYOUT_1D = .(
		.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL, // SHADER_RESOURCE_1D,
		.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL, // SHADER_RESOURCE_1D_ARRAY,
		.VK_IMAGE_LAYOUT_GENERAL, // SHADER_RESOURCE_STORAGE_1D,
		.VK_IMAGE_LAYOUT_GENERAL, // SHADER_RESOURCE_STORAGE_1D_ARRAY,
		.VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL, // COLOR_ATTACHMENT,
		.VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL // DEPTH_STENCIL_ATTACHMENT
		);

	private const VkImageLayout[(uint32)Texture2DViewType.MAX_NUM] IMAGE_LAYOUT_2D = .(
		.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL, // SHADER_RESOURCE_2D,
		.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL, // SHADER_RESOURCE_2D_ARRAY,
		.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL, // SHADER_RESOURCE_CUBE,
		.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL, // SHADER_RESOURCE_CUBE_ARRAY,
		.VK_IMAGE_LAYOUT_GENERAL, // SHADER_RESOURCE_STORAGE_2D,
		.VK_IMAGE_LAYOUT_GENERAL, // SHADER_RESOURCE_STORAGE_2D_ARRAY,
		.VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL, // COLOR_ATTACHMENT,
		.VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL // DEPTH_STENCIL_ATTACHMENT
		);

	private const VkImageLayout[(uint32)Texture3DViewType.MAX_NUM] IMAGE_LAYOUT_3D = .(
		.VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL, // SHADER_RESOURCE_3D,
		.VK_IMAGE_LAYOUT_GENERAL, // SHADER_RESOURCE_STORAGE_3D,
		.VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL // COLOR_ATTACHMENT
		);

	public static VkImageLayout GetImageLayoutForView(Texture1DViewType type)
	{
		return IMAGE_LAYOUT_1D[(uint32)type];
	}

	public static VkImageLayout GetImageLayoutForView(Texture2DViewType type)
	{
		return IMAGE_LAYOUT_2D[(uint32)type];
	}

	public static VkImageLayout GetImageLayoutForView(Texture3DViewType type)
	{
		return IMAGE_LAYOUT_3D[(uint32)type];
	}

	public static VkAccelerationStructureTypeKHR GetAccelerationStructureType(AccelerationStructureType type)
	{
		Compiler.Assert(VkAccelerationStructureTypeKHR.VK_ACCELERATION_STRUCTURE_TYPE_TOP_LEVEL_KHR == (uint32)AccelerationStructureType.TOP_LEVEL, "Enum mismatch.");
		Compiler.Assert(VkAccelerationStructureTypeKHR.VK_ACCELERATION_STRUCTURE_TYPE_BOTTOM_LEVEL_KHR == (uint32)AccelerationStructureType.BOTTOM_LEVEL, "Enum mismatch.");
		return (VkAccelerationStructureTypeKHR)type;
	}

	public static VkBuildAccelerationStructureFlagsKHR GetAccelerationStructureBuildFlags(AccelerationStructureBuildBits flags)
	{
		Compiler.Assert(VkBuildAccelerationStructureFlagsKHR.VK_BUILD_ACCELERATION_STRUCTURE_ALLOW_UPDATE_BIT_KHR == (uint32)AccelerationStructureBuildBits.ALLOW_UPDATE, "Enum mismatch.");
		Compiler.Assert(VkBuildAccelerationStructureFlagsKHR.VK_BUILD_ACCELERATION_STRUCTURE_ALLOW_COMPACTION_BIT_KHR == (uint32)AccelerationStructureBuildBits.ALLOW_COMPACTION, "Enum mismatch.");
		Compiler.Assert(VkBuildAccelerationStructureFlagsKHR.VK_BUILD_ACCELERATION_STRUCTURE_PREFER_FAST_TRACE_BIT_KHR == (uint32)AccelerationStructureBuildBits.PREFER_FAST_TRACE, "Enum mismatch.");
		Compiler.Assert(VkBuildAccelerationStructureFlagsKHR.VK_BUILD_ACCELERATION_STRUCTURE_PREFER_FAST_BUILD_BIT_KHR == (uint32)AccelerationStructureBuildBits.PREFER_FAST_BUILD, "Enum mismatch.");
		Compiler.Assert(VkBuildAccelerationStructureFlagsKHR.VK_BUILD_ACCELERATION_STRUCTURE_LOW_MEMORY_BIT_KHR == (uint32)AccelerationStructureBuildBits.MINIMIZE_MEMORY, "Enum mismatch.");
		return (VkBuildAccelerationStructureFlagsKHR)flags;
	}

	public static VkGeometryFlagsKHR GetGeometryFlags(BottomLevelGeometryBits geometryFlags)
	{
		Compiler.Assert(VkGeometryFlagsKHR.VK_GEOMETRY_OPAQUE_BIT_KHR == (uint32)BottomLevelGeometryBits.OPAQUE_GEOMETRY, "Enum mismatch.");
		Compiler.Assert(VkGeometryFlagsKHR.VK_GEOMETRY_NO_DUPLICATE_ANY_HIT_INVOCATION_BIT_KHR == (uint32)BottomLevelGeometryBits.NO_DUPLICATE_ANY_HIT_INVOCATION, "Enum mismatch.");
		return (VkGeometryFlagsKHR)geometryFlags;
	}

	public static VkGeometryTypeKHR GetGeometryType(GeometryType geometryType)
	{
		Compiler.Assert(VkGeometryTypeKHR.VK_GEOMETRY_TYPE_TRIANGLES_KHR == (uint32)GeometryType.TRIANGLES, "Enum mismatch.");
		Compiler.Assert(VkGeometryTypeKHR.VK_GEOMETRY_TYPE_AABBS_KHR == (uint32)GeometryType.AABBS, "Enum mismatch.");
		return (VkGeometryTypeKHR)geometryType;
	}

	public static VkCopyAccelerationStructureModeKHR GetCopyMode(CopyMode copyMode)
	{
		Compiler.Assert(VkCopyAccelerationStructureModeKHR.VK_COPY_ACCELERATION_STRUCTURE_MODE_CLONE_KHR == (uint32)CopyMode.CLONE, "Enum mismatch.");
		Compiler.Assert(VkCopyAccelerationStructureModeKHR.VK_COPY_ACCELERATION_STRUCTURE_MODE_COMPACT_KHR == (uint32)CopyMode.COMPACT, "Enum mismatch.");
		return (VkCopyAccelerationStructureModeKHR)copyMode;
	}

	public static void ConvertGeometryObjectSizesVK(uint32 physicalDeviceIndex, VkAccelerationStructureGeometryKHR* destObjects, uint32* primitiveNums, GeometryObject* sourceObjects, uint32 objectNum)
	{
		for (uint32 i = 0; i < objectNum; i++)
		{
		    readonly ref GeometryObject geometrySrc = ref sourceObjects[i];

		    uint32 triangleNum = geometrySrc.triangles.indexNum / 3;
		    triangleNum += (geometrySrc.triangles.indexNum == 0) ? geometrySrc.triangles.vertexNum / 3 : 0;

		    readonly uint32 boxNum = geometrySrc.boxes.boxNum;
		    primitiveNums[i] = geometrySrc.type == GeometryType.TRIANGLES ? triangleNum : boxNum;

		    readonly VkDeviceAddress transform = GetBufferDeviceAddress(geometrySrc.triangles.transformBuffer, physicalDeviceIndex) +
		        geometrySrc.triangles.transformOffset;

		    ref VkAccelerationStructureGeometryKHR geometryDst = ref destObjects[i];
		    geometryDst = .();
		    geometryDst.sType = .VK_STRUCTURE_TYPE_ACCELERATION_STRUCTURE_GEOMETRY_KHR;
		    geometryDst.flags = GetGeometryFlags(geometrySrc.flags);
		    geometryDst.geometryType = GetGeometryType(geometrySrc.type);
		    geometryDst.geometry.instances.sType = .VK_STRUCTURE_TYPE_ACCELERATION_STRUCTURE_GEOMETRY_INSTANCES_DATA_KHR;
		    geometryDst.geometry.aabbs.sType = .VK_STRUCTURE_TYPE_ACCELERATION_STRUCTURE_GEOMETRY_AABBS_DATA_KHR;
		    geometryDst.geometry.triangles.sType = .VK_STRUCTURE_TYPE_ACCELERATION_STRUCTURE_GEOMETRY_TRIANGLES_DATA_KHR;
		    geometryDst.geometry.triangles.maxVertex = geometrySrc.triangles.vertexNum;
		    geometryDst.geometry.triangles.indexType = GetIndexType(geometrySrc.triangles.indexType);
		    geometryDst.geometry.triangles.vertexFormat = GetVkFormat(geometrySrc.triangles.vertexFormat);
		    geometryDst.geometry.triangles.transformData.deviceAddress = transform;
		}
	}

	public static void ConvertGeometryObjectsVK(uint32 physicalDeviceIndex, VkAccelerationStructureGeometryKHR* destObjects, VkAccelerationStructureBuildRangeInfoKHR* ranges, GeometryObject* sourceObjects, uint32 objectNum)
	{
		for (uint32 i = 0; i < objectNum; i++)
		{
		    readonly ref GeometryObject geometrySrc = ref sourceObjects[i];

		    uint32 triangleNum = geometrySrc.triangles.indexNum / 3;
		    triangleNum += (geometrySrc.triangles.indexNum == 0) ? geometrySrc.triangles.vertexNum / 3 : 0;

		    readonly uint32 boxNum = geometrySrc.boxes.boxNum;

		    ranges[i] = .();
		    ranges[i].primitiveCount = geometrySrc.type == GeometryType.TRIANGLES ? triangleNum : boxNum;

		    readonly VkDeviceAddress aabbs = GetBufferDeviceAddress(geometrySrc.boxes.buffer, physicalDeviceIndex) +
		        geometrySrc.boxes.offset;

		    readonly VkDeviceAddress vertices = GetBufferDeviceAddress(geometrySrc.triangles.vertexBuffer, physicalDeviceIndex) +
		        geometrySrc.triangles.vertexOffset;

		    readonly VkDeviceAddress indices = GetBufferDeviceAddress(geometrySrc.triangles.indexBuffer, physicalDeviceIndex) +
		        geometrySrc.triangles.indexOffset;

		    readonly VkDeviceAddress transform = GetBufferDeviceAddress(geometrySrc.triangles.transformBuffer, physicalDeviceIndex) +
		        geometrySrc.triangles.transformOffset;

		    ref VkAccelerationStructureGeometryKHR geometryDst = ref destObjects[i];
		    geometryDst = .();
		    geometryDst.sType = .VK_STRUCTURE_TYPE_ACCELERATION_STRUCTURE_GEOMETRY_KHR;
		    geometryDst.flags = GetGeometryFlags(geometrySrc.flags);
		    geometryDst.geometryType = GetGeometryType(geometrySrc.type);
		    geometryDst.geometry.instances.sType = .VK_STRUCTURE_TYPE_ACCELERATION_STRUCTURE_GEOMETRY_INSTANCES_DATA_KHR;
		    geometryDst.geometry.aabbs.sType = .VK_STRUCTURE_TYPE_ACCELERATION_STRUCTURE_GEOMETRY_AABBS_DATA_KHR;
		    geometryDst.geometry.aabbs.data.deviceAddress = aabbs;
		    geometryDst.geometry.aabbs.stride = geometrySrc.boxes.stride;
		    geometryDst.geometry.triangles.sType = .VK_STRUCTURE_TYPE_ACCELERATION_STRUCTURE_GEOMETRY_TRIANGLES_DATA_KHR;
		    geometryDst.geometry.triangles.maxVertex = geometrySrc.triangles.vertexNum;
		    geometryDst.geometry.triangles.vertexData.deviceAddress = vertices;
		    geometryDst.geometry.triangles.vertexStride = geometrySrc.triangles.vertexStride;
		    geometryDst.geometry.triangles.vertexFormat = GetVkFormat(geometrySrc.triangles.vertexFormat);
		    geometryDst.geometry.triangles.indexData.deviceAddress = indices;
		    geometryDst.geometry.triangles.indexType = GetIndexType(geometrySrc.triangles.indexType);
		    geometryDst.geometry.triangles.transformData.deviceAddress = transform;
		}
	}

	private const TextureType[(uint32)TextureType.MAX_NUM] TEXTURE_TYPE_TABLE = .(
		TextureType.TEXTURE_1D, // VK_IMAGE_TYPE_1D
		TextureType.TEXTURE_2D, // VK_IMAGE_TYPE_2D
		TextureType.TEXTURE_3D // VK_IMAGE_TYPE_3D
		);

	public static TextureType GetTextureType(VkImageType type)
	{
		if ((uint)type < TEXTURE_TYPE_TABLE.Count)
			return TEXTURE_TYPE_TABLE[(uint32)type];

		return TextureType.MAX_NUM;
	}

	public static Result GetReturnCode(VkResult result)
	{
		switch (result)
		{
		case .VK_SUCCESS,
			.VK_EVENT_SET,
			.VK_EVENT_RESET:
			return Result.SUCCESS;

		case .VK_ERROR_DEVICE_LOST:
			return Result.DEVICE_LOST;

		case .VK_ERROR_SURFACE_LOST_KHR,
			.VK_ERROR_OUT_OF_DATE_KHR:
			return Result.SWAPCHAIN_RESIZE;

		case .VK_ERROR_NATIVE_WINDOW_IN_USE_KHR,
			.VK_ERROR_INCOMPATIBLE_DISPLAY_KHR,
			.VK_ERROR_FORMAT_NOT_SUPPORTED,
			.VK_ERROR_INCOMPATIBLE_DRIVER,
			.VK_ERROR_FEATURE_NOT_PRESENT,
			.VK_ERROR_EXTENSION_NOT_PRESENT,
			.VK_ERROR_LAYER_NOT_PRESENT:
			return Result.UNSUPPORTED;

		case .VK_ERROR_INVALID_EXTERNAL_HANDLE,
			.VK_ERROR_VALIDATION_FAILED_EXT,
			.VK_ERROR_NOT_PERMITTED_KHR,
			.VK_SUBOPTIMAL_KHR,
			.VK_ERROR_TOO_MANY_OBJECTS,
			.VK_ERROR_MEMORY_MAP_FAILED,
			.VK_ERROR_INITIALIZATION_FAILED,
			.VK_INCOMPLETE,
			.VK_TIMEOUT,
			.VK_NOT_READY:
			return Result.FAILURE;

		case .VK_ERROR_OUT_OF_HOST_MEMORY,
			.VK_ERROR_OUT_OF_DEVICE_MEMORY,
			.VK_ERROR_OUT_OF_POOL_MEMORY,
			.VK_ERROR_FRAGMENTATION,
			.VK_ERROR_FRAGMENTED_POOL:
			return Result.OUT_OF_MEMORY;

		default:
			return Result.FAILURE;
		}
	}

	private const VkFormat[(uint32)Format.MAX_NUM] VK_FORMAT = .(
		.VK_FORMAT_UNDEFINED, // UNKNOWN

		.VK_FORMAT_R8_UNORM, // R8_UNORM
		.VK_FORMAT_R8_SNORM, // R8_SNORM
		.VK_FORMAT_R8_UINT, // R8_UINT
		.VK_FORMAT_R8_SINT, // R8_SINT

		.VK_FORMAT_R8G8_UNORM, // RG8_UNORM
		.VK_FORMAT_R8G8_SNORM, // RG8_SNORM
		.VK_FORMAT_R8G8_UINT, // RG8_UINT
		.VK_FORMAT_R8G8_SINT, // RG8_SINT

		.VK_FORMAT_B8G8R8A8_UNORM, // BGRA8_UNORM
		.VK_FORMAT_B8G8R8A8_UNORM, // BGRA8_SRGB

		.VK_FORMAT_R8G8B8A8_UNORM, // RGBA8_UNORM
		.VK_FORMAT_R8G8B8A8_SNORM, // RGBA8_SNORM
		.VK_FORMAT_R8G8B8A8_UINT, // RGBA8_UINT
		.VK_FORMAT_R8G8B8A8_SINT, // RGBA8_SINT
		.VK_FORMAT_R8G8B8A8_UNORM, // RGBA8_SRGB

		.VK_FORMAT_R16_UNORM, // R16_UNORM
		.VK_FORMAT_R16_SNORM, // R16_SNORM
		.VK_FORMAT_R16_UINT, // R16_UINT
		.VK_FORMAT_R16_SINT, // R16_SINT
		.VK_FORMAT_R16_SFLOAT, // R16_SFLOAT

		.VK_FORMAT_R16G16_UNORM, // RG16_UNORM
		.VK_FORMAT_R16G16_SNORM, // RG16_SNORM
		.VK_FORMAT_R16G16_UINT, // RG16_UINT
		.VK_FORMAT_R16G16_SINT, // RG16_SINT
		.VK_FORMAT_R16G16_SFLOAT, // RG16_SFLOAT

		.VK_FORMAT_R16G16B16A16_UNORM, // RGBA16_UNORM
		.VK_FORMAT_R16G16B16A16_SNORM, // RGBA16_SNORM
		.VK_FORMAT_R16G16B16A16_UINT, // RGBA16_UINT
		.VK_FORMAT_R16G16B16A16_SINT, // RGBA16_SINT
		.VK_FORMAT_R16G16B16A16_SFLOAT, // RGBA16_SFLOAT

		.VK_FORMAT_R32_UINT, // R32_UINT
		.VK_FORMAT_R32_SINT, // R32_SINT
		.VK_FORMAT_R32_SFLOAT, // R32_SFLOAT

		.VK_FORMAT_R32G32_UINT, // RG32_UINT
		.VK_FORMAT_R32G32_SINT, // RG32_SINT
		.VK_FORMAT_R32G32_SFLOAT, // RG32_SFLOAT

		.VK_FORMAT_R32G32B32_UINT, // RGB32_UINT
		.VK_FORMAT_R32G32B32_SINT, // RGB32_SINT
		.VK_FORMAT_R32G32B32_SFLOAT, // RGB32_SFLOAT

		.VK_FORMAT_R32G32B32A32_UINT, // RGB32_UINT
		.VK_FORMAT_R32G32B32A32_SINT, // RGB32_SINT
		.VK_FORMAT_R32G32B32A32_SFLOAT, // RGB32_SFLOAT

		.VK_FORMAT_A2B10G10R10_UNORM_PACK32, // R10_G10_B10_A2_UNORM
		.VK_FORMAT_A2B10G10R10_UINT_PACK32, // R10_G10_B10_A2_UINT
		.VK_FORMAT_B10G11R11_UFLOAT_PACK32, // R11_G11_B10_UFLOAT
		.VK_FORMAT_E5B9G9R9_UFLOAT_PACK32, // R9_G9_B9_E5_UFLOAT

		.VK_FORMAT_BC1_RGBA_UNORM_BLOCK, // BC1_RGBA_UNORM
		.VK_FORMAT_BC1_RGBA_SRGB_BLOCK, // BC1_RGBA_SRGB
		.VK_FORMAT_BC2_UNORM_BLOCK, // BC2_RGBA_UNORM
		.VK_FORMAT_BC2_SRGB_BLOCK, // BC2_RGBA_SRGB
		.VK_FORMAT_BC3_UNORM_BLOCK, // BC3_RGBA_UNORM
		.VK_FORMAT_BC3_SRGB_BLOCK, // BC3_RGBA_SRGB
		.VK_FORMAT_BC4_UNORM_BLOCK, // BC4_R_UNORM
		.VK_FORMAT_BC4_SNORM_BLOCK, // BC4_R_SNORM
		.VK_FORMAT_BC5_UNORM_BLOCK, // BC5_RG_UNORM
		.VK_FORMAT_BC5_SNORM_BLOCK, // BC5_RG_SNORM
		.VK_FORMAT_BC6H_UFLOAT_BLOCK, // BC6H_RGB_UFLOAT
		.VK_FORMAT_BC6H_SFLOAT_BLOCK, // BC6H_RGB_SFLOAT
		.VK_FORMAT_BC7_UNORM_BLOCK, // BC7_RGBA_UNORM
		.VK_FORMAT_BC7_SRGB_BLOCK, // BC7_RGBA_SRGB

		// Depth-specific

		.VK_FORMAT_D16_UNORM, // D16_UNORM
		.VK_FORMAT_D24_UNORM_S8_UINT, // D24_UNORM_S8_UINT
		.VK_FORMAT_D32_SFLOAT, // D32_SFLOAT
		.VK_FORMAT_D32_SFLOAT_S8_UINT, // D32_SFLOAT_S8_UINT_X24_TYPELESS

		.VK_FORMAT_X8_D24_UNORM_PACK32, // D24_UNORM_X8_TYPELESS
		.VK_FORMAT_D24_UNORM_S8_UINT, // X24_TYPLESS_S8_UINT /// TODO: there is no such format in VK
		.VK_FORMAT_D32_SFLOAT_S8_UINT, // X32_TYPLESS_S8_UINT_X24_TYPELESS
		.VK_FORMAT_D32_SFLOAT_S8_UINT // D32_SFLOAT_X8_TYPLESS_X24_TYPELESS
		);

	public static uint32 NRIFormatToVKFormat(Format format)
	{
		return (uint32)VK_FORMAT[(uint32)format];
	}

	public static TextureType GetTextureTypeVK(uint32 vkImageType)
	{
	    return GetTextureType((VkImageType)vkImageType);
	}

	public static QueryType GetQueryTypeVK(uint32 queryTypeVK)
	{
	    if (queryTypeVK == (.)VkQueryType.VK_QUERY_TYPE_OCCLUSION)
	        return QueryType.OCCLUSION;

	    if (queryTypeVK == (.)VkQueryType.VK_QUERY_TYPE_PIPELINE_STATISTICS)
	        return QueryType.PIPELINE_STATISTICS;

	    if (queryTypeVK == (.)VkQueryType.VK_QUERY_TYPE_TIMESTAMP)
	        return QueryType.TIMESTAMP;

	    return QueryType.MAX_NUM;
	}
}