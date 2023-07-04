using Sedulous.RHI.Helpers;
namespace Sedulous.RHI;

interface IDevice
{
	void Destroy();

	DeviceLogger GetLogger();

	public DeviceAllocator<uint8> GetAllocator();

	readonly ref DeviceDesc GetDesc();

	void* GetNativeObject(); // ID3D11Device*, ID3D12Device* or VkDevice

	void SetDebugName(char8* name);
	Result GetCommandQueue(CommandQueueType commandQueueType, out ICommandQueue commandQueue);

	Result CreateCommandAllocator(ICommandQueue commandQueue, uint32 physicalDeviceMask, out ICommandAllocator commandAllocator);
	Result CreateDescriptorPool(DescriptorPoolDesc descriptorPoolDesc, out IDescriptorPool descriptorPool);
	Result CreateBuffer(BufferDesc bufferDesc, out IBuffer buffer);
	Result CreateTexture(TextureDesc textureDesc, out ITexture texture);
	Result CreateBufferView(BufferViewDesc bufferViewDesc, out IDescriptor bufferView);
	Result CreateTexture1DView(Texture1DViewDesc textureViewDesc, out IDescriptor textureView);
	Result CreateTexture2DView(Texture2DViewDesc textureViewDesc, out IDescriptor textureView);
	Result CreateTexture3DView(Texture3DViewDesc textureViewDesc, out IDescriptor textureView);
	Result CreateSampler(SamplerDesc samplerDesc, out IDescriptor sampler);
	Result CreatePipelineLayout(PipelineLayoutDesc pipelineLayoutDesc, out IPipelineLayout pipelineLayout);
	Result CreateGraphicsPipeline(GraphicsPipelineDesc graphicsPipelineDesc, out IPipeline pipeline);
	Result CreateComputePipeline(ComputePipelineDesc computePipelineDesc, out IPipeline pipeline);
	Result CreateFrameBuffer(FrameBufferDesc frameBufferDesc, out IFrameBuffer frameBuffer);
	Result CreateQueryPool(QueryPoolDesc queryPoolDesc, out IQueryPool queryPool);
	Result CreateFence(uint64 initialValue, out IFence fence);
	Result CreateSwapChain(SwapChainDesc swapChainDesc, out ISwapChain swapChain);
	Result CreateRayTracingPipeline(RayTracingPipelineDesc rayTracingPipelineDesc, out IPipeline pipeline);
	Result CreateAccelerationStructure(AccelerationStructureDesc accelerationStructureDesc, out IAccelerationStructure accelerationStructure);

	void DestroyCommandAllocator(ICommandAllocator commandAllocator);
	void DestroyCommandBuffer(ICommandBuffer commandBuffer);
	void DestroyDescriptorPool(IDescriptorPool descriptorPool);
	void DestroyBuffer(IBuffer buffer);
	void DestroyTexture(ITexture texture);
	void DestroyDescriptor(IDescriptor descriptor);
	void DestroyPipelineLayout(IPipelineLayout pipelineLayout);
	void DestroyPipeline(IPipeline pipeline);
	void DestroyFrameBuffer(IFrameBuffer frameBuffer);
	void DestroyQueryPool(IQueryPool queryPool);
	void DestroyFence(IFence fence);
	void DestroySwapChain(ISwapChain swapChain);
	void DestroyAccelerationStructure(IAccelerationStructure accelerationStructure);

	Result GetDisplays(Display* displays, ref uint32 displayNum);
	Result GetDisplaySize(ref Display display, ref uint16 width, ref uint16 height);

	Result AllocateMemory(uint32 physicalDeviceMask, MemoryType memoryType, uint64 size, out IMemory memory);
	Result BindBufferMemory(BufferMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum);
	Result BindTextureMemory(TextureMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum);
	Result BindAccelerationStructureMemory(AccelerationStructureMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum);
	void FreeMemory(IMemory memory);

	FormatSupportBits GetFormatSupport(Format format);
	uint32 CalculateAllocationNumber(ResourceGroupDesc resourceGroupDesc);
	Result AllocateAndBindMemory(ResourceGroupDesc resourceGroupDesc, IMemory* allocations);
}