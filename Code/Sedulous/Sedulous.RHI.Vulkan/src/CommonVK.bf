namespace Sedulous.RHI.Vulkan;

typealias NRIVkCommandPool = uint64;
typealias NRIVkImage = uint64;
typealias NRIVkBuffer = uint64;
typealias NRIVkDeviceMemory = uint64;
typealias NRIVkQueryPool = uint64;
typealias NRIVkPipeline = uint64;
typealias NRIVkDescriptorPool = uint64;
typealias NRIVkImageView = uint64;
typealias NRIVkBufferView = uint64;
typealias NRIVkAccelerationStructureKHR = uint64;

typealias NRIVkInstance = void*;
typealias NRIVkPhysicalDevice = void*;
typealias NRIVkDevice = void*;
typealias NRIVkQueue = void*;
typealias NRIVkCommandBuffer = void*;
typealias NRIVkProcAddress = void*;

struct DeviceCreationVulkanDesc
{
	public NRIVkInstance vkInstance;
	public NRIVkDevice vkDevice;
	public NRIVkPhysicalDevice* vkPhysicalDevices;
	public uint32 deviceGroupSize;
	public uint32* queueFamilyIndices;
	public uint32 queueFamilyIndexNum;
	public CallbackInterface callbackInterface;
	public MemoryAllocatorInterface memoryAllocatorInterface;
	public SPIRVBindingOffsets spirvBindingOffsets;
	public char8* vulkanLoaderPath;
	public bool enableNRIValidation;
	public bool enableAPIValidation;
}

struct CommandQueueVulkanDesc
{
	public NRIVkQueue vkQueue;
	public uint32 familyIndex;
	public CommandQueueType commandQueueType;
}

struct CommandAllocatorVulkanDesc
{
	public NRIVkCommandPool vkCommandPool;
	public CommandQueueType commandQueueType;
}

struct CommandBufferVulkanDesc
{
	public NRIVkCommandBuffer vkCommandBuffer;
	public CommandQueueType commandQueueType;
}

struct BufferVulkanDesc
{
	public NRIVkBuffer vkBuffer;
	public IMemory memory;
	public uint64 bufferSize;
	public uint64 memoryOffset;
	public uint64 deviceAddress;
	public uint32 physicalDeviceMask;
}

struct TextureVulkanDesc
{
	public NRIVkImage vkImage;
	public uint32 vkFormat;
	public uint32 vkImageAspectFlags;
	public uint32 vkImageType;
	public uint16[3] size;
	public uint16 mipNum;
	public uint16 arraySize;
	public uint8 sampleNum;
	public uint32 physicalDeviceMask;
}

struct MemoryVulkanDesc
{
	public NRIVkDeviceMemory vkDeviceMemory;
	public uint64 size;
	public uint32 memoryTypeIndex;
	public uint32 physicalDeviceMask;
}

struct QueryPoolVulkanDesc
{
	public NRIVkQueryPool vkQueryPool;
	public uint32 vkQueryType;
	public uint32 physicalDeviceMask;
}

struct AccelerationStructureVulkanDesc
{
	public NRIVkAccelerationStructureKHR vkAccelerationStructure;
	public uint64 buildScratchSize;
	public uint64 updateScratchSize;
	public uint32 physicalDeviceMask;
}

interface IDeviceVK
{
	Result CreateCommandQueueVK(CommandQueueVulkanDesc commandQueueVulkanDesc, out ICommandQueue commandQueue);
	Result CreateCommandAllocatorVK(CommandAllocatorVulkanDesc commandAllocatorVulkanDesc, out ICommandAllocator commandAllocator);
	Result CreateCommandBufferVK(CommandBufferVulkanDesc commandBufferVulkanDesc, out ICommandBuffer commandBuffer);
	Result CreateDescriptorPoolVK(NRIVkDescriptorPool vkDescriptorPool, out IDescriptorPool descriptorPool);
	Result CreateBufferVK(BufferVulkanDesc bufferVulkanDesc, out IBuffer buffer);
	Result CreateTextureVK(TextureVulkanDesc textureVulkanDesc, out ITexture texture);
	Result CreateMemoryVK(MemoryVulkanDesc memoryVulkanDesc, out IMemory memory);
	Result CreateGraphicsPipelineVK(NRIVkPipeline vkPipeline, out IPipeline pipeline);
	Result CreateComputePipelineVK(NRIVkPipeline vkPipeline, out IPipeline pipeline);
	Result CreateQueryPoolVK(QueryPoolVulkanDesc queryPoolVulkanDesc, out IQueryPool queryPool);
	Result CreateAccelerationStructureVK(AccelerationStructureVulkanDesc accelerationStructureDesc, out IAccelerationStructure accelerationStructure);

	NRIVkPhysicalDevice GetVkPhysicalDevice();
	NRIVkInstance GetVkInstance();
	NRIVkProcAddress GetVkGetInstanceProcAddr();
	NRIVkProcAddress GetVkGetDeviceProcAddr();

}