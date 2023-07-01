namespace Sedulous.RHI;

interface ICommandBuffer
{
	void* GetNativeObject(); // ID3D11DeviceContext*, ID3D12GraphicsCommandList* or VkCommandBuffer

	void SetDebugName(char8* name);
	Result Begin(IDescriptorPool descriptorPool, uint32 physicalDeviceIndex);
	Result End();

	void SetPipeline(IPipeline pipeline);
	void SetPipelineLayout(IPipelineLayout pipelineLayout);
	void SetDescriptorSet(uint32 setIndexInPipelineLayout, IDescriptorSet descriptorSet, uint32* dynamicConstantBufferOffsets);
	void SetConstants(uint32 pushConstantIndex, void* data, uint32 size);
	void SetDescriptorPool(IDescriptorPool descriptorPool);
	void PipelineBarrier(TransitionBarrierDesc* transitionBarriers, AliasingBarrierDesc* aliasingBarriers, BarrierDependency dependency);

	void BeginRenderPass(IFrameBuffer frameBuffer, RenderPassBeginFlag renderPassBeginFlag);
	void EndRenderPass();
	void SetViewports(Viewport* viewports, uint32 viewportNum);
	void SetScissors(Rect* rects, uint32 rectNum);
	void SetDepthBounds(float boundsMin, float boundsMax);
	void SetStencilReference(uint8 reference);
	void SetSamplePositions(SamplePosition* positions, uint32 positionNum);
	void ClearAttachments(ClearDesc* clearDescs, uint32 clearDescNum, Rect* rects, uint32 rectNum);
	void SetIndexBuffer(IBuffer buffer, uint64 offset, IndexType indexType);
	void SetVertexBuffers(uint32 baseSlot, uint32 bufferNum, IBuffer* buffers, uint64* offsets);

	void Draw(uint32 vertexNum, uint32 instanceNum, uint32 baseVertex, uint32 baseInstance);
	void DrawIndexed(uint32 indexNum, uint32 instanceNum, uint32 baseIndex, uint32 baseVertex, uint32 baseInstance);
	void DrawIndirect(IBuffer buffer, uint64 offset, uint32 drawNum, uint32 stride);
	void DrawIndexedIndirect(IBuffer buffer, uint64 offset, uint32 drawNum, uint32 stride);
	void Dispatch(uint32 x, uint32 y, uint32 z);
	void DispatchIndirect(IBuffer buffer, uint64 offset);
	void BeginQuery(IQueryPool queryPool, uint32 offset);
	void EndQuery(IQueryPool queryPool, uint32 offset);
	void BeginAnnotation(char8* name);
	void EndAnnotation();

	void ClearStorageBuffer(ClearStorageBufferDesc clearDesc);

	void ClearStorageTexture(ClearStorageTextureDesc clearDesc);

	void CopyBuffer(IBuffer dstBuffer, uint32 dstPhysicalDeviceIndex, uint64 dstOffset, IBuffer srcBuffer,
		uint32 srcPhysicalDeviceIndex, uint64 srcOffset, uint64 size);

	void CopyTexture(ITexture dstTexture, uint32 dstPhysicalDeviceIndex, TextureRegionDesc* dstRegionDesc,
		ITexture srcTexture, uint32 srcPhysicalDeviceIndex, TextureRegionDesc* srcRegionDesc);

	void UploadBufferToTexture(ITexture dstTexture, TextureRegionDesc dstRegionDesc, IBuffer srcBuffer,
		TextureDataLayoutDesc srcDataLayoutDesc);

	void ReadbackTextureToBuffer(IBuffer dstBuffer, ref TextureDataLayoutDesc dstDataLayoutDesc, ITexture srcTexture,
		TextureRegionDesc srcRegionDesc);

	void CopyQueries(IQueryPool queryPool, uint32 offset, uint32 num, IBuffer dstBuffer, uint64 dstOffset);
	void ResetQueries(IQueryPool queryPool, uint32 offset, uint32 num);

	void BuildTopLevelAccelerationStructure(uint32 instanceNum, IBuffer buffer, uint64 bufferOffset,
		AccelerationStructureBuildBits flags, IAccelerationStructure dst, IBuffer scratch, uint64 scratchOffset);

	void BuildBottomLevelAccelerationStructure(uint32 geometryObjectNum, GeometryObject* geometryObjects,
		AccelerationStructureBuildBits flags, IAccelerationStructure dst, IBuffer scratch, uint64 scratchOffset);

	void UpdateTopLevelAccelerationStructure(uint32 instanceNum, IBuffer buffer, uint64 bufferOffset,
		AccelerationStructureBuildBits flags, IAccelerationStructure dst, IAccelerationStructure src, IBuffer scratch,
		uint64 scratchOffset);

	void UpdateBottomLevelAccelerationStructure(uint32 geometryObjectNum, GeometryObject* geometryObjects,
		AccelerationStructureBuildBits flags, IAccelerationStructure dst, IAccelerationStructure src, IBuffer scratch,
		uint64 scratchOffset);

	void CopyAccelerationStructure(IAccelerationStructure dst, IAccelerationStructure src, CopyMode copyMode);

	void WriteAccelerationStructureSize(IAccelerationStructure* accelerationStructures,
		uint32 accelerationStructureNum, IQueryPool queryPool, uint32 queryPoolOffset);

	void DispatchRays(DispatchRaysDesc dispatchRaysDesc);
	void DispatchMeshTasks(uint32 x, uint32 y, uint32 z);
}