using System;
namespace Sedulous.RHI;

#region NRIDescs.h

static
{
	[Comptime]
	public static mixin SetBit(int index)
	{
		(1 << (index))
	}

	public const uint16 REMAINING_ARRAY_LAYERS = 0;
	public const uint16 REMAINING_MIP_LEVELS = 0;
	public const uint16 WHOLE_SIZE = 0;
	public const uint32 WHOLE_DEVICE_GROUP = 0;
	public const bool VARIABLE_DESCRIPTOR_NUM = true;
	public const bool DESCRIPTOR_ARRAY = true;
}

typealias MemoryType = uint32;

enum Result : uint8
{
	SUCCESS,
	FAILURE,
	INVALID_ARGUMENT,
	OUT_OF_MEMORY,
	UNSUPPORTED,
	DEVICE_LOST,
	SWAPCHAIN_RESIZE,

	MAX_NUM
}

enum Vendor : uint8
{
	UNKNOWN,
	NVIDIA,
	AMD,
	INTEL,

	MAX_NUM
}

enum GraphicsAPI : uint8
{
	D3D11,
	D3D12,
	VULKAN,

	MAX_NUM
}

enum CommandQueueType : uint8
{
	GRAPHICS,
	COMPUTE,
	COPY,

	MAX_NUM
}

enum MemoryLocation : uint8
{
	DEVICE,
	HOST_UPLOAD,
	HOST_READBACK,

	MAX_NUM
}

enum TextureType : uint8
{
	TEXTURE_1D,
	TEXTURE_2D,
	TEXTURE_3D,

	MAX_NUM
}

enum Texture1DViewType : uint8
{
	SHADER_RESOURCE_1D,
	SHADER_RESOURCE_1D_ARRAY,
	SHADER_RESOURCE_STORAGE_1D,
	SHADER_RESOURCE_STORAGE_1D_ARRAY,
	COLOR_ATTACHMENT,
	DEPTH_STENCIL_ATTACHMENT,

	MAX_NUM
}

enum Texture2DViewType : uint8
{
	SHADER_RESOURCE_2D,
	SHADER_RESOURCE_2D_ARRAY,
	SHADER_RESOURCE_CUBE,
	SHADER_RESOURCE_CUBE_ARRAY,
	SHADER_RESOURCE_STORAGE_2D,
	SHADER_RESOURCE_STORAGE_2D_ARRAY,
	COLOR_ATTACHMENT,
	DEPTH_STENCIL_ATTACHMENT,

	MAX_NUM
}

enum Texture3DViewType : uint8
{
	SHADER_RESOURCE_3D,
	SHADER_RESOURCE_STORAGE_3D,
	COLOR_ATTACHMENT,

	MAX_NUM
}

enum BufferViewType : uint8
{
	SHADER_RESOURCE,
	SHADER_RESOURCE_STORAGE,
	CONSTANT,

	MAX_NUM
}

enum DescriptorType : uint8
{
	SAMPLER,
	CONSTANT_BUFFER,
	TEXTURE,
	STORAGE_TEXTURE,
	BUFFER,
	STORAGE_BUFFER,
	STRUCTURED_BUFFER,
	STORAGE_STRUCTURED_BUFFER,
	ACCELERATION_STRUCTURE,

	MAX_NUM
}

enum VertexStreamStepRate : uint8
{
	PER_VERTEX,
	PER_INSTANCE,

	MAX_NUM
}

enum TextureLayout : uint8
{
	GENERAL,
	COLOR_ATTACHMENT,
	DEPTH_STENCIL,
	DEPTH_STENCIL_READONLY,
	DEPTH_READONLY,
	STENCIL_READONLY,
	SHADER_RESOURCE,
	PRESENT,
	UNKNOWN,

	MAX_NUM
}

enum ShaderStage : uint8
{
	ALL,
	VERTEX,
	TESS_CONTROL,
	TESS_EVALUATION,
	GEOMETRY,
	FRAGMENT,
	COMPUTE,
	RAYGEN,
	MISS,
	INTERSECTION,
	CLOSEST_HIT,
	ANY_HIT,
	CALLABLE,
	MESH_CONTROL,
	MESH_EVALUATION,

	MAX_NUM
}

enum BarrierDependency : uint8
{
	ALL_STAGES,
	GRAPHICS_STAGE,
	COMPUTE_STAGE,
	COPY_STAGE,
	RAYTRACING_STAGE,

	MAX_NUM
}

enum Topology : uint8
{
	POINT_LIST,
	LINE_LIST,
	LINE_STRIP,
	TRIANGLE_LIST,
	TRIANGLE_STRIP,
	LINE_LIST_WITH_ADJACENCY,
	LINE_STRIP_WITH_ADJACENCY,
	TRIANGLE_LIST_WITH_ADJACENCY,
	TRIANGLE_STRIP_WITH_ADJACENCY,
	PATCH_LIST,

	MAX_NUM
}

enum  FillMode : uint8
{
	SOLID,
	WIREFRAME,

	MAX_NUM
}

enum CullMode : uint8
{
	NONE,
	FRONT,
	BACK,

	MAX_NUM
}

enum LogicFunc : uint8
{
	NONE,
	CLEAR,
	AND,
	AND_REVERSE,
	COPY,
	AND_INVERTED,
	XOR,
	OR,
	NOR,
	EQUIVALENT,
	INVERT,
	OR_REVERSE,
	COPY_INVERTED,
	OR_INVERTED,
	NAND,
	SET,

	MAX_NUM
}

enum CompareFunc : uint8
{
	NONE,
	ALWAYS,
	NEVER,
	LESS,
	LESS_EQUAL,
	EQUAL,
	GREATER_EQUAL,
	GREATER,
	NOT_EQUAL,

	MAX_NUM
}

enum StencilFunc : uint8
{
	KEEP,
	ZERO,
	REPLACE,
	INCREMENT_AND_CLAMP,
	DECREMENT_AND_CLAMP,
	INVERT,
	INCREMENT_AND_WRAP,
	DECREMENT_AND_WRAP,

	MAX_NUM
}

enum BlendFactor : uint8
{
	ZERO,
	ONE,
	SRC_COLOR,
	ONE_MINUS_SRC_COLOR,
	DST_COLOR,
	ONE_MINUS_DST_COLOR,
	SRC_ALPHA,
	ONE_MINUS_SRC_ALPHA,
	DST_ALPHA,
	ONE_MINUS_DST_ALPHA,
	CONSTANT_COLOR,
	ONE_MINUS_CONSTANT_COLOR,
	CONSTANT_ALPHA,
	ONE_MINUS_CONSTANT_ALPHA,
	SRC_ALPHA_SATURATE,
	SRC1_COLOR,
	ONE_MINUS_SRC1_COLOR,
	SRC1_ALPHA,
	ONE_MINUS_SRC1_ALPHA,

	MAX_NUM
}

enum BlendFunc : uint8
{
	ADD,
	SUBTRACT,
	REVERSE_SUBTRACT,
	MIN,
	MAX,

	MAX_NUM
}

enum IndexType : uint8
{
	UINT16,
	UINT32,

	MAX_NUM
}

enum QueryType : uint8
{
	TIMESTAMP,
	OCCLUSION,
	PIPELINE_STATISTICS,
	ACCELERATION_STRUCTURE_COMPACTED_SIZE,

	MAX_NUM
}

enum Filter : uint8
{
	NEAREST,
	LINEAR,

	MAX_NUM
}

enum FilterExt : uint8
{
	NONE,
	MIN,
	MAX,

	MAX_NUM
}

enum AddressMode : uint8
{
	REPEAT,
	MIRRORED_REPEAT,
	CLAMP_TO_EDGE,
	CLAMP_TO_BORDER,

	MAX_NUM
}

enum BorderColor : uint8
{
	FLOAT_TRANSPARENT_BLACK,
	FLOAT_OPAQUE_BLACK,
	FLOAT_OPAQUE_WHITE,
	INT_TRANSPARENT_BLACK,
	INT_OPAQUE_BLACK,
	INT_OPAQUE_WHITE,

	MAX_NUM
}

enum Format : uint8
{
	UNKNOWN,

	R8_UNORM,
	R8_SNORM,
	R8_UINT,
	R8_SINT,

	RG8_UNORM,
	RG8_SNORM,
	RG8_UINT,
	RG8_SINT,

	BGRA8_UNORM,
	BGRA8_SRGB,

	RGBA8_UNORM,
	RGBA8_SNORM,
	RGBA8_UINT,
	RGBA8_SINT,
	RGBA8_SRGB,

	R16_UNORM,
	R16_SNORM,
	R16_UINT,
	R16_SINT,
	R16_SFLOAT,

	RG16_UNORM,
	RG16_SNORM,
	RG16_UINT,
	RG16_SINT,
	RG16_SFLOAT,

	RGBA16_UNORM,
	RGBA16_SNORM,
	RGBA16_UINT,
	RGBA16_SINT,
	RGBA16_SFLOAT,

	R32_UINT,
	R32_SINT,
	R32_SFLOAT,

	RG32_UINT,
	RG32_SINT,
	RG32_SFLOAT,

	RGB32_UINT,
	RGB32_SINT,
	RGB32_SFLOAT,

	RGBA32_UINT,
	RGBA32_SINT,
	RGBA32_SFLOAT,

	R10_G10_B10_A2_UNORM,
	R10_G10_B10_A2_UINT,
	R11_G11_B10_UFLOAT,
	R9_G9_B9_E5_UFLOAT,

	BC1_RGBA_UNORM,
	BC1_RGBA_SRGB,
	BC2_RGBA_UNORM,
	BC2_RGBA_SRGB,
	BC3_RGBA_UNORM,
	BC3_RGBA_SRGB,
	BC4_R_UNORM,
	BC4_R_SNORM,
	BC5_RG_UNORM,
	BC5_RG_SNORM,
	BC6H_RGB_UFLOAT,
	BC6H_RGB_SFLOAT,
	BC7_RGBA_UNORM,
	BC7_RGBA_SRGB,

	D16_UNORM,
	D24_UNORM_S8_UINT,
	D32_SFLOAT,
	D32_SFLOAT_S8_UINT_X24,

	R24_UNORM_X8,
	X24_R8_UINT,
	X32_R8_UINT_X24,
	R32_SFLOAT_X8_X24,

	MAX_NUM
}

enum AttachmentContentType : uint8
{
	COLOR,
	DEPTH,
	STENCIL,
	DEPTH_STENCIL,

	MAX_NUM
}

enum RenderPassBeginFlag : uint8
{
	NONE,
	SKIP_FRAME_BUFFER_CLEAR,

	MAX_NUM
}

enum PrimitiveRestart : uint8
{
	DISABLED,
	INDICES_UINT16,
	INDICES_UINT32,

	MAX_NUM
}

#pragma format disable
enum TextureUsageBits: uint16{

    NONE                                = 0,
    SHADER_RESOURCE                     = SetBit!(0),
    SHADER_RESOURCE_STORAGE             = SetBit!(1),
    COLOR_ATTACHMENT                    = SetBit!(2),
    DEPTH_STENCIL_ATTACHMENT            = SetBit!(3)
}

enum BufferUsageBits: uint16{

    NONE                                = 0,
    SHADER_RESOURCE                     = SetBit!(0),
    SHADER_RESOURCE_STORAGE             = SetBit!(1),
    VERTEX_BUFFER                       = SetBit!(2),
    INDEX_BUFFER                        = SetBit!(3),
    CONSTANT_BUFFER                     = SetBit!(4),
    ARGUMENT_BUFFER                     = SetBit!(5),
    RAY_TRACING_BUFFER                  = SetBit!(6),
    ACCELERATION_STRUCTURE_BUILD_READ   = SetBit!(7)
}

enum AccessBits: uint16{

    UNKNOWN                             = 0,
    VERTEX_BUFFER                       = SetBit!(0),
    INDEX_BUFFER                        = SetBit!(1),
    CONSTANT_BUFFER                     = SetBit!(2),
    ARGUMENT_BUFFER                     = SetBit!(3),
    SHADER_RESOURCE                     = SetBit!(4),
    SHADER_RESOURCE_STORAGE             = SetBit!(5),
    COLOR_ATTACHMENT                    = SetBit!(6),
    DEPTH_STENCIL_WRITE                 = SetBit!(7),
    DEPTH_STENCIL_READ                  = SetBit!(8),
    COPY_SOURCE                         = SetBit!(9),
    COPY_DESTINATION                    = SetBit!(10),
    ACCELERATION_STRUCTURE_READ         = SetBit!(11),
    ACCELERATION_STRUCTURE_WRITE        = SetBit!(12)
}

// Starts with 1 to unblock "1 << ShaderStage"
enum PipelineLayoutShaderStageBits: uint16{

    NONE                                = 0,
    VERTEX                              = SetBit!(1),
    TESS_CONTROL                        = SetBit!(2),
    TESS_EVALUATION                     = SetBit!(3),
    GEOMETRY                            = SetBit!(4),
    FRAGMENT                            = SetBit!(5),
    COMPUTE                             = SetBit!(6),
    RAYGEN                              = SetBit!(7),
    MISS                                = SetBit!(8),
    INTERSECTION                        = SetBit!(9),
    CLOSEST_HIT                         = SetBit!(10),
    ANY_HIT                             = SetBit!(11),
    CALLABLE                            = SetBit!(12),
    MESH_CONTROL                        = SetBit!(13),
    MESH_EVALUATION                     = SetBit!(14),

    ALL_GRAPHICS                        = (.VERTEX |. TESS_CONTROL |.TESS_EVALUATION |.GEOMETRY |.FRAGMENT |. MESH_CONTROL |.MESH_EVALUATION),

    ALL_RAY_TRACING                     = (.RAYGEN | .MISS | .INTERSECTION | .CLOSEST_HIT |.ANY_HIT |.CALLABLE)
}

enum PipelineStatsBits: uint16{

    INPUT_ASSEMBLY_VERTICES             = SetBit!(0),
    INPUT_ASSEMBLY_PRIMITIVES           = SetBit!(1),
    VERTEX_SHADER_INVOCATIONS           = SetBit!(2),
    GEOMETRY_SHADER_INVOCATIONS         = SetBit!(3),
    GEOMETRY_SHADER_PRIMITIVES          = SetBit!(4),
    CLIPPING_INVOCATIONS                = SetBit!(5),
    CLIPPING_PRIMITIVES                 = SetBit!(6),
    FRAGMENT_SHADER_INVOCATIONS         = SetBit!(7),
    TESS_CONTROL_SHADER_PATCHES         = SetBit!(8),
    TESS_EVALUATION_SHADER_INVOCATIONS  = SetBit!(9),
    COMPUTE_SHADER_INVOCATIONS          = SetBit!(10)
}

enum ColorWriteBits: uint8 {

    R                                   = SetBit!(0),
    G                                   = SetBit!(1),
    B                                   = SetBit!(2),
    A                                   = SetBit!(3),

    RGBA                                = (.R |.G |.B |.A)
}

enum ResourceViewBits: uint8 {

    READONLY_DEPTH                      = SetBit!(0),
    READONLY_STENCIL                    = SetBit!(1)
}

enum FormatSupportBits: uint8 {

    UNSUPPORTED                         = 0,
    TEXTURE                             = SetBit!(0),
    STORAGE_TEXTURE                     = SetBit!(1),
    BUFFER                              = SetBit!(2),
    STORAGE_BUFFER                      = SetBit!(3),
    COLOR_ATTACHMENT                    = SetBit!(4),
    DEPTH_STENCIL_ATTACHMENT            = SetBit!(5),
    VERTEX_BUFFER                       = SetBit!(6)
}

enum DescriptorSetBindingBits: uint8 {

    DEFAULT                             = 0,
    PARTIALLY_BOUND                     = SetBit!(0)
}
#pragma format restore

struct Rect
{
	public int32 left;
	public int32 top;
	public uint32 width;
	public uint32 height;
}

struct Viewport
{
	public float[2] offset;
	public float[2] size;
	public float depthRangeMin;
	public float depthRangeMax;
}

struct Color32f
{
	public float x;
	public float y;
	public float z;
	public float w;
}

struct Color32ui
{
	public uint32 x;
	public uint32 y;
	public uint32 z;
	public uint32 w;
}

struct Color32i
{
	public int32 x;
	public int32 y;
	public int32 z;
	public int32 w;
}

struct DepthStencilClearValue
{
	public float depth;
	public uint8 stencil;
}

[Union] struct ClearValueDesc
{
	public DepthStencilClearValue depthStencil;
	public Color32f color32f;
	public Color32ui color32ui;
	public Color32i color32i;
}

struct ClearDesc
{
	public ClearValueDesc value;
	public AttachmentContentType attachmentContentType;
	public uint32 colorAttachmentIndex;
}

struct ClearStorageBufferDesc
{
	/*const*/ public IDescriptor /***/ storageBuffer;
	public uint32 value;
	public uint32 setIndexInPipelineLayout;
	public uint32 rangeIndex;
	public uint32 offsetInRange;
}

struct ClearStorageTextureDesc
{
	/*const*/ public IDescriptor /***/ storageTexture;
	public ClearValueDesc value;
	public uint32 setIndexInPipelineLayout;
	public uint32 rangeIndex;
	public uint32 offsetInRange;
}

struct TextureRegionDesc
{
	public uint16[3] offset;
	public uint16[3] size;
	public uint16 mipOffset;
	public uint16 arrayOffset;
}

struct TextureDataLayoutDesc
{
	public uint64 offset;
	public uint32 rowPitch;
	public uint32 slicePitch;
}

struct QueueSubmitDesc
{
	/*const*/ public ICommandBuffer* /*const**/ commandBuffers;
	public uint32 commandBufferNum;
	public uint32 physicalDeviceIndex;
}

struct BufferMemoryBindingDesc
{
	public IMemory /***/ memory;
	public IBuffer /***/ buffer;
	public uint64 offset;
	public uint32 physicalDeviceMask;
}

struct TextureMemoryBindingDesc
{
	public IMemory /***/ memory;
	public ITexture /***/ texture;
	public uint64 offset;
	public uint32 physicalDeviceMask;
}

struct MemoryDesc
{
	public uint64 size;
	public uint32 alignment;
	public MemoryType type;
	public bool mustBeDedicated;
}

struct AddressModes
{
	public AddressMode u;
	public AddressMode v;
	public AddressMode w;
}

struct SamplerDesc
{
	public Filter magnification;
	public Filter minification;
	public Filter mip;
	public FilterExt filterExt;
	public uint32 anisotropy;
	public float mipBias;
	public float mipMin;
	public float mipMax;
	public AddressModes addressModes;
	public CompareFunc compareFunc;
	public BorderColor borderColor;
	public bool unnormalizedCoordinates;
}

struct TextureDesc
{
	public TextureType type;
	public TextureUsageBits usageMask;
	public Format format;
	public uint16[3] size;
	public uint16 mipNum;
	public uint16 arraySize;
	public uint8 sampleNum;
	public uint32 physicalDeviceMask;
}

struct BufferDesc
{
	public uint64 size;
	public uint32 structureStride;
	public BufferUsageBits usageMask;
	public uint32 physicalDeviceMask;
}

struct Texture1DViewDesc
{
	/*const*/ public ITexture /***/ texture;
	public Texture1DViewType viewType;
	public Format format;
	public uint16 mipOffset;
	public uint16 mipNum;
	public uint16 arrayOffset;
	public uint16 arraySize;
	public uint32 physicalDeviceMask;
	public ResourceViewBits flags;
}

struct Texture2DViewDesc
{
	/*const*/ public ITexture /***/ texture;
	public Texture2DViewType viewType;
	public Format format;
	public uint16 mipOffset;
	public uint16 mipNum;
	public uint16 arrayOffset;
	public uint16 arraySize;
	public uint32 physicalDeviceMask;
	public ResourceViewBits flags;
}

struct Texture3DViewDesc
{
	/*const*/ public ITexture /***/ texture;
	public Texture3DViewType viewType;
	public Format format;
	public uint16 mipOffset;
	public uint16 mipNum;
	public uint16 sliceOffset;
	public uint16 sliceNum;
	public uint32 physicalDeviceMask;
	public ResourceViewBits  flags;
}

struct BufferViewDesc
{
	/*const*/ public IBuffer /***/ buffer;
	public BufferViewType  viewType;
	public Format  format;
	public uint64 offset;
	public uint64 size;
	public uint32 physicalDeviceMask;
}

struct DescriptorPoolDesc
{
	public uint32 physicalDeviceMask;
	public uint32 descriptorSetMaxNum;
	public uint32 samplerMaxNum;
	public uint32 constantBufferMaxNum;
	public uint32 dynamicConstantBufferMaxNum;
	public uint32 textureMaxNum;
	public uint32 storageTextureMaxNum;
	public uint32 bufferMaxNum;
	public uint32 storageBufferMaxNum;
	public uint32 structuredBufferMaxNum;
	public uint32 storageStructuredBufferMaxNum;
	public uint32 accelerationStructureMaxNum;
}

struct TextureTransitionBarrierDesc
{
	/*const*/ public ITexture /***/ texture;
	public uint16 mipOffset;
	public uint16 mipNum;
	public uint16 arrayOffset;
	public uint16 arraySize;
	public AccessBits  prevAccess;
	public AccessBits  nextAccess;
	public TextureLayout  prevLayout;
	public TextureLayout  nextLayout;
}

struct BufferTransitionBarrierDesc
{
	/*const*/ public IBuffer /***/ buffer;
	public AccessBits  prevAccess;
	public AccessBits  nextAccess;
}

struct BufferAliasingBarrierDesc
{
	/*const*/ public IBuffer /***/ before;
	/*const*/ public IBuffer /***/ after;
	public AccessBits  nextAccess;
}

struct TextureAliasingBarrierDesc
{
	/*const*/ public ITexture /***/ before;
	/*const*/ public ITexture /***/ after;
	public AccessBits  nextAccess;
	public TextureLayout  nextLayout;
}

struct TransitionBarrierDesc
{
	/*const*/ public BufferTransitionBarrierDesc* buffers;
	/*const*/ public TextureTransitionBarrierDesc* textures;
	public uint32 bufferNum;
	public uint32 textureNum;
}

struct AliasingBarrierDesc
{
	/*const*/ public BufferAliasingBarrierDesc* buffers;
	/*const*/ public TextureAliasingBarrierDesc* textures;
	public uint32 bufferNum;
	public uint32 textureNum;
}

struct DescriptorRangeDesc
{
	public uint32 baseRegisterIndex;
	public uint32 descriptorNum;
	public DescriptorType  descriptorType;
	public ShaderStage  visibility;
	public bool isDescriptorNumVariable;
	public bool isArray;
}

struct DynamicConstantBufferDesc
{
	public uint32 registerIndex;
	public ShaderStage  visibility;
}

struct DescriptorSetDesc
{
	public uint32 registerSpace;
	/*const*/ public DescriptorRangeDesc* ranges;
	public uint32 rangeNum;
	/*const*/ public DynamicConstantBufferDesc* dynamicConstantBuffers;
	public uint32 dynamicConstantBufferNum;
	public DescriptorSetBindingBits  bindingMask;
}

struct DescriptorRangeUpdateDesc
{
	/*const*/ public IDescriptor* /*const**/ descriptors;
	public uint32 descriptorNum;
	public uint32 offsetInRange;
}

struct DescriptorSetCopyDesc
{
	/*const*/ public IDescriptorSet /***/ srcDescriptorSet;
	public uint32 baseSrcRange;
	public uint32 baseDstRange;
	public uint32 rangeNum;
	public uint32 baseSrcDynamicConstantBuffer;
	public uint32 baseDstDynamicConstantBuffer;
	public uint32 dynamicConstantBufferNum;
	public uint32 physicalDeviceMask;
}

struct PushConstantDesc
{
	public uint32 registerIndex;
	public uint32 size;
	public ShaderStage  visibility;
}

struct SPIRVBindingOffsets
{
	uint32 samplerOffset;
	uint32 textureOffset;
	uint32 constantBufferOffset;
	uint32 storageTextureAndBufferOffset;
}

struct ShaderDesc
{
	public ShaderStage  stage;
	public void* bytecode;
	public uint64 size;
	public char8* entryPointName;
}

struct VertexAttributeD3D
{
	public char8* semanticName;
	public uint32 semanticIndex;
}

struct VertexAttributeVK
{
	uint32 location;
}

struct VertexAttributeDesc
{
	public VertexAttributeD3D  d3d;
	public VertexAttributeVK  vk;
	uint32 offset;
	public Format  format;
	uint16 streamIndex;
}

struct VertexStreamDesc
{
	uint32 stride;
	uint16 bindingSlot;
	public VertexStreamStepRate  stepRate;
}

struct InputAssemblyDesc
{
	/*const*/ public VertexAttributeDesc* attributes;
	/*const*/ public VertexStreamDesc* streams;
	uint8 attributeNum;
	uint8 streamNum;
	public Topology  topology;
	uint8 tessControlPointNum;
	public PrimitiveRestart  primitiveRestart;
}

struct SamplePosition
{
	int8 x;
	int8 y;
}

struct RasterizationDesc
{
	uint32 viewportNum;
	int32 depthBiasConstantFactor;
	float depthBiasClamp;
	float depthBiasSlopeFactor;
	public FillMode  fillMode;
	public CullMode  cullMode;
	uint16 sampleMask;
	uint8 sampleNum;
	bool alphaToCoverage;
	bool frontCounterClockwise;
	bool depthClamp;
	bool antialiasedLines;
	bool rasterizerDiscard;
	bool conservativeRasterization;
}

struct StencilDesc
{
	public CompareFunc  compareFunc;
	public StencilFunc  fail;
	public StencilFunc  pass;
	public StencilFunc  depthFail;
}

struct BlendingDesc
{
	public BlendFactor  srcFactor;
	public BlendFactor  dstFactor;
	public BlendFunc  func;
}

struct ColorAttachmentDesc
{
	public Format  format;
	public BlendingDesc  colorBlend;
	public BlendingDesc  alphaBlend;
	public ColorWriteBits  colorWriteMask;
	bool blendEnabled;
}

// CompareFunc::NONE = depth/stencil test disabled
struct DepthAttachmentDesc
{
	public CompareFunc  compareFunc;
	bool write;
}

struct StencilAttachmentDesc
{
	public StencilDesc  front;
	public StencilDesc  back;
	uint8 reference;
	uint8 compareMask;
	uint8 writeMask;
}

struct OutputMergerDesc
{
	/*const*/ public ColorAttachmentDesc* color;
	public DepthAttachmentDesc  depth;
	public StencilAttachmentDesc  stencil;
	public Format  depthStencilFormat;
	public LogicFunc  colorLogicFunc;
	uint32 colorNum;
	public Color32f  blendConsts;
}

struct PipelineLayoutDesc
{
	/*const*/ public DescriptorSetDesc* descriptorSets;
	/*const*/ public PushConstantDesc* pushConstants;
	uint32 descriptorSetNum;
	uint32 pushConstantNum;
	public PipelineLayoutShaderStageBits  stageMask;
	bool ignoreGlobalSPIRVOffsets;
}

struct GraphicsPipelineDesc
{
	/*const*/ public IPipelineLayout /***/ pipelineLayout;
	/*const*/ public InputAssemblyDesc* inputAssembly;
	/*const*/ public RasterizationDesc* rasterization;
	/*const*/ public OutputMergerDesc* outputMerger;
	/*const*/ public ShaderDesc* shaderStages;
	uint32 shaderStageNum;
}

struct ComputePipelineDesc
{
	/*const*/ public IPipelineLayout /***/ pipelineLayout;
	public ShaderDesc  computeShader;
}

struct FrameBufferDesc
{
	/*const*/ public IDescriptor* /*const**/ colorAttachments;
	/*const*/ public IDescriptor /***/ depthStencilAttachment;
	/*const*/ public ClearValueDesc* colorClearValues;
	/*const*/ public ClearValueDesc* depthStencilClearValue;
	uint32 colorAttachmentNum;
	uint32 physicalDeviceMask;
	uint16[2] size;
	uint16 layerNum;
}

struct QueryPoolDesc
{
	public QueryType queryType;
	uint32 capacity;
	public PipelineStatsBits pipelineStatsMask;
	uint32 physicalDeviceMask;
}

struct PipelineStatisticsDesc
{
	uint64 inputVertices;
	uint64 inputPrimitives;
	uint64 vertexShaderInvocations;
	uint64 geometryShaderInvocations;
	uint64 geometryShaderPrimitives;
	uint64 rasterizerInPrimitives;
	uint64 rasterizerOutPrimitives;
	uint64 fragmentShaderInvocations;
	uint64 tessControlInvocations;
	uint64 tessEvaluationInvocations;
	uint64 computeShaderInvocations;
}

struct DeviceDesc
{
	// Common
	public GraphicsAPI graphicsAPI;
	public Vendor vendor;
	public uint16 nriVersionMajor;
	public uint16 nriVersionMinor;

	// Viewports
	public uint32 viewportMaxNum;
	public uint32 viewportSubPixelBits;
	public int32[2] viewportBoundsRange;

	// Framebuffer
	public uint32 frameBufferMaxDim;
	public uint32 frameBufferLayerMaxNum;
	public uint32 framebufferColorAttachmentMaxNum;

	// Multi-sampling
	public uint8 frameBufferColorSampleMaxNum;
	public uint8 frameBufferDepthSampleMaxNum;
	public uint8 frameBufferStencilSampleMaxNum;
	public uint8 frameBufferNoAttachmentsSampleMaxNum;
	public uint8 textureColorSampleMaxNum;
	public uint8 textureIntegerSampleMaxNum;
	public uint8 textureDepthSampleMaxNum;
	public uint8 textureStencilSampleMaxNum;
	public uint8 storageTextureSampleMaxNum;

	// Resource dimensions
	public uint32 texture1DMaxDim;
	public uint32 texture2DMaxDim;
	public uint32 texture3DMaxDim;
	public uint32 textureArrayMaxDim;
	public uint32 texelBufferMaxDim;

	// Memory
	public uint32 memoryAllocationMaxNum;
	public uint32 samplerAllocationMaxNum;
	public uint32 uploadBufferTextureRowAlignment;
	public uint32 uploadBufferTextureSliceAlignment;
	public uint32 typedBufferOffsetAlignment;
	public uint32 constantBufferOffsetAlignment;
	public uint32 constantBufferMaxRange;
	public uint32 storageBufferOffsetAlignment;
	public uint32 storageBufferMaxRange;
	public uint32 bufferTextureGranularity;
	public uint64 bufferMaxSize;
	public uint32 pushConstantsMaxSize;

	// Shader resources
	public uint32 boundDescriptorSetMaxNum;
	public uint32 perStageDescriptorSamplerMaxNum;
	public uint32 perStageDescriptorConstantBufferMaxNum;
	public uint32 perStageDescriptorStorageBufferMaxNum;
	public uint32 perStageDescriptorTextureMaxNum;
	public uint32 perStageDescriptorStorageTextureMaxNum;
	public uint32 perStageResourceMaxNum;

	// Descriptor set
	public uint32 descriptorSetSamplerMaxNum;
	public uint32 descriptorSetConstantBufferMaxNum;
	public uint32 descriptorSetStorageBufferMaxNum;
	public uint32 descriptorSetTextureMaxNum;
	public uint32 descriptorSetStorageTextureMaxNum;

	// Vertex shader
	public uint32 vertexShaderAttributeMaxNum;
	public uint32 vertexShaderStreamMaxNum;
	public uint32 vertexShaderOutputComponentMaxNum;

	// Tessellation control shader
	public float tessControlShaderGenerationMaxLevel;
	public uint32 tessControlShaderPatchPointMaxNum;
	public uint32 tessControlShaderPerVertexInputComponentMaxNum;
	public uint32 tessControlShaderPerVertexOutputComponentMaxNum;
	public uint32 tessControlShaderPerPatchOutputComponentMaxNum;
	public uint32 tessControlShaderTotalOutputComponentMaxNum;

	// Tessellation evaluation shader
	public uint32 tessEvaluationShaderInputComponentMaxNum;
	public uint32 tessEvaluationShaderOutputComponentMaxNum;

	// Geometry shader
	public uint32 geometryShaderInvocationMaxNum;
	public uint32 geometryShaderInputComponentMaxNum;
	public uint32 geometryShaderOutputComponentMaxNum;
	public uint32 geometryShaderOutputVertexMaxNum;
	public uint32 geometryShaderTotalOutputComponentMaxNum;

	// Fragment shader
	public uint32 fragmentShaderInputComponentMaxNum;
	public uint32 fragmentShaderOutputAttachmentMaxNum;
	public uint32 fragmentShaderDualSourceAttachmentMaxNum;
	public uint32 fragmentShaderCombinedOutputResourceMaxNum;

	// Compute shader
	public uint32 computeShaderSharedMemoryMaxSize;
	public uint32[3] computeShaderWorkGroupMaxNum;
	public uint32 computeShaderWorkGroupInvocationMaxNum;
	public uint32[3] computeShaderWorkGroupMaxDim;

	// Ray tracing
	public uint64 rayTracingShaderGroupIdentifierSize;
	public uint64 rayTracingShaderTableAligment;
	public uint64 rayTracingShaderTableMaxStride;
	public uint32 rayTracingShaderRecursionMaxDepth;
	public uint32 rayTracingGeometryObjectMaxNum;

	// Mesh shader
	public uint32 meshTaskWorkGroupInvocationMaxNum;
	public uint32[3] meshTaskWorkGroupMaxDim;
	public uint32 meshTaskTotalMemoryMaxSize;
	public uint32 meshTaskOutputMaxNum;
	public uint32 meshWorkGroupInvocationMaxNum;
	public uint32[3] meshWorkGroupMaxDim;
	public uint32 meshOutputVertexMaxNum;
	public uint32 meshOutputPrimitiveMaxNum;
	public uint32 meshMultiviewViewMaxNum;
	public uint32 meshOutputPerVertexGranularity;
	public uint32 meshOutputPerPrimitiveGranularity;

	// Other
	public uint64 timestampFrequencyHz;
	public uint32 subPixelPrecisionBits;
	public uint32 subTexelPrecisionBits;
	public uint32 mipmapPrecisionBits;
	public uint32 drawIndexedIndex16ValueMax;
	public uint32 drawIndexedIndex32ValueMax;
	public uint32 drawIndirectMaxNum;
	public float samplerLodBiasMin;
	public float samplerLodBiasMax;
	public float samplerAnisotropyMax;
	public int32 texelOffsetMin;
	public uint32 texelOffsetMax;
	public int32 texelGatherOffsetMin;
	public uint32 texelGatherOffsetMax;
	public uint32 clipDistanceMaxNum;
	public uint32 cullDistanceMaxNum;
	public uint32 combinedClipAndCullDistanceMaxNum;
	public uint8 conservativeRasterTier;
	public uint8 physicalDeviceNum;

	// Features support
	public bool isAPIValidationEnabled;
	public bool isTextureFilterMinMaxSupported;
	public bool isLogicOpSupported;
	public bool isDepthBoundsTestSupported;
	public bool isProgrammableSampleLocationsSupported;
	public bool isComputeQueueSupported;
	public bool isCopyQueueSupported;
	public bool isCopyQueueTimestampSupported;
	public bool isRegisterAliasingSupported;
	public bool isSubsetAllocationSupported;
	public bool isFloat16Supported;
}

#endregion

#region RayTracing

enum GeometryType : uint8
{
	TRIANGLES,
	AABBS,

	MAX_NUM
}

enum AccelerationStructureType : uint8
{
	TOP_LEVEL,
	BOTTOM_LEVEL,

	MAX_NUM
}

enum CopyMode : uint8
{
	CLONE,
	COMPACT,

	MAX_NUM
}

enum BottomLevelGeometryBits : uint32
{
	NONE                                = 0,
	OPAQUE_GEOMETRY                     = SetBit!(0),
	NO_DUPLICATE_ANY_HIT_INVOCATION     = SetBit!(1)
}

enum TopLevelInstanceBits : uint32
{
	NONE                                = 0,
	TRIANGLE_CULL_DISABLE               = SetBit!(0),
	TRIANGLE_FRONT_COUNTERCLOCKWISE     = SetBit!(1),
	FORCE_OPAQUE                        = SetBit!(2),
	FORCE_NON_OPAQUE                    = SetBit!(3)
}

enum AccelerationStructureBuildBits : uint32
{
	NONE                                = 0,
	ALLOW_UPDATE                        = SetBit!(0),
	ALLOW_COMPACTION                    = SetBit!(1),
	PREFER_FAST_TRACE                   = SetBit!(2),
	PREFER_FAST_BUILD                   = SetBit!(3),
	MINIMIZE_MEMORY                     = SetBit!(4)
}

struct ShaderLibrary
{
	public ShaderDesc* shaderDescs;
	public uint32 shaderNum;
}

struct ShaderGroupDesc
{
	public uint32[3] shaderIndices;
}

struct RayTracingPipelineDesc
{
	public IPipelineLayout /***/ pipelineLayout;
	public ShaderLibrary* shaderLibrary;
	public ShaderGroupDesc* shaderGroupDescs; // TODO: move to ShaderLibrary
	public uint32 shaderGroupDescNum;
	public uint32 recursionDepthMax;
	public uint32 payloadAttributeSizeMax;
	public uint32 intersectionAttributeSizeMax;
}

struct Triangles
{
	public IBuffer /***/ vertexBuffer;
	public uint64 vertexOffset;
	public uint32 vertexNum;
	public uint64 vertexStride;
	public Format vertexFormat;
	public IBuffer /***/ indexBuffer;
	public uint64 indexOffset;
	public uint32 indexNum;
	public IndexType indexType;
	public IBuffer /***/ transformBuffer;
	public uint64 transformOffset;
}

struct AABBs
{
	public IBuffer /***/ buffer;
	public uint32 boxNum;
	public uint32 stride;
	public uint64 offset;
}

struct GeometryObject
{
	public GeometryType type;
	public BottomLevelGeometryBits flags;
	public using private Shape shape;
	[Union] struct Shape
	{
		public Triangles triangles;
		public AABBs boxes;
	}
}

struct GeometryObjectInstance
{
	public float[3][4] transform;
	[Bitfield<uint32>(.Public, .Bits(24), "instanceId")]
	[Bitfield<uint32>(.Public, .Bits(8), "mask")]
	[Bitfield<uint32>(.Public, .Bits(24), "shaderBindingTableLocalOffset")]
	[Bitfield<TopLevelInstanceBits>(.Public, .Bits(8), "flags")]
	private uint64 _instanceBits;
	/*public uint32 instanceId;// : 24;
	public uint32 mask;// : 8;
	public uint32 shaderBindingTableLocalOffset;// : 24;
	public TopLevelInstanceBits flags;// : 8;*/
	public uint64 accelerationStructureHandle;
}

struct AccelerationStructureDesc
{
	public AccelerationStructureType type;
	public AccelerationStructureBuildBits flags;
	public uint32 physicalDeviceMask;
	public uint32 instanceOrGeometryObjectNum;
	public GeometryObject* geometryObjects;
}

struct AccelerationStructureMemoryBindingDesc
{
	public IMemory /***/ memory;
	public IAccelerationStructure /***/ accelerationStructure;
	public uint64 offset;
	public uint32 physicalDeviceMask;
}

struct StridedBufferRegion
{
	public BufferAliasingBarrierDesc* buffer;
	public uint64 offset;
	public uint64 size;
	public uint64 stride;
}

struct DispatchRaysDesc
{
	public StridedBufferRegion raygenShader;
	public StridedBufferRegion missShaders;
	public StridedBufferRegion hitShaderGroups;
	public StridedBufferRegion callableShaders;
	public uint32 width;
	public uint32 height;
	public uint32 depth;
}

#endregion

#region NRISwapChain.h

enum SwapChainFormat : uint8
{

	/* BT.709 - LDR https://en.wikipedia.org/wiki/Rec._709
	   BT.2020 - HDR https://en.wikipedia.org/wiki/Rec._2020
	   G10 - linear (gamma 1.0)
	   G22 - sRGB (gamma ~2.2)
	   G2084 - SMPTE ST.2084 (Perceptual Quantization) */

	BT709_G10_8BIT,
	BT709_G10_16BIT,
	BT709_G22_8BIT,
	BT709_G22_10BIT,
	BT2020_G2084_10BIT,

	MAX_NUM
}

enum WindowSystemType : uint8
{
	WINDOWS,
	X11,
	WAYLAND,
	METAL,

	MAX_NUM
}

struct WindowsWindow
{
	public void* hwnd; // HWND
}

struct X11Window
{
	public void* dpy; // Display*
	public uint64 window; // Window
}

struct WaylandWindow
{
	public void* display; // wl_display*
	public void* surface; // wl_surface*
}

struct MetalWindow
{
	public void* caMetalLayer;
}

[Union] struct Window
{
	public WindowsWindow windows;
	public X11Window x11;
	public WaylandWindow wayland;
	public MetalWindow metal;
}

struct Display;

// SwapChain buffers will be created as "color attachment" resources
struct SwapChainDesc
{
	public WindowSystemType windowSystemType;
	public Window window;
	public ICommandQueue /***/ commandQueue;
	public uint16 width;
	public uint16 height;
	public uint16 textureNum;
	public SwapChainFormat format;
	public uint32 verticalSyncInterval;
	public uint32 physicalDeviceIndex;
	public Display* display;
}

struct HdrMetadata
{
	public float[2] displayPrimaryRed;
	public float[2] displayPrimaryGreen;
	public float[2] displayPrimaryBlue;
	public float[2] whitePoint;
	public float luminanceMax;
	public float luminanceMin;
	public float contentLightLevelMax;
	public float frameAverageLightLevelMax;
}

#endregion

#region NRIDeviceCreation.h

enum Message : uint8
{
	TYPE_INFO,
	TYPE_WARNING,
	TYPE_ERROR,

	MAX_NUM,
}

struct MemoryAllocatorInterface
{
	public function void*(void* userArg, uint size, uint alignment) Allocate;
	public function void*(void* userArg, void* memory, uint size, uint alignment) Reallocate;
	public function void(void* userArg, void* memory) Free;
	public void* userArg;
}

struct CallbackInterface
{
	public function void(void* userArg, char8* message, Message messageType) MessageCallback;
	public function void(void* userArg) AbortExecution;
	public void* userArg;
}

struct PhysicalDeviceGroup
{
	public char8[128] description;
	public uint64 luid;
	public uint64 dedicatedVideoMemory;
	public uint32 deviceID;
	public Vendor vendor;
}

struct VulkanExtensions
{
	public char8** instanceExtensions;
	public uint32 instanceExtensionNum;
	public char8** deviceExtensions;
	public uint32 deviceExtensionNum;
}

struct DeviceCreationDesc
{
	public PhysicalDeviceGroup* physicalDeviceGroup;
	public CallbackInterface callbackInterface;
	public MemoryAllocatorInterface memoryAllocatorInterface;
	public GraphicsAPI graphicsAPI;
	public SPIRVBindingOffsets spirvBindingOffsets;
	public VulkanExtensions vulkanExtensions;
	public bool enableNRIValidation;
	public bool enableAPIValidation;
	public bool enableMGPU;
	public bool D3D11CommandBufferEmulation;
	public bool skipLiveObjectsReporting;
}

#endregion