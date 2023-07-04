using System.Collections;
using System;
namespace Sedulous.RHI.Validation;

enum ValidationCommandType : uint32
{
	NONE,
	BEGIN_QUERY,
	END_QUERY,
	RESET_QUERY,
	MAX_NUM
}

struct ValidationCommandUseQuery
{
	public ValidationCommandType type;
	public IQueryPool queryPool;
	public uint32 queryPoolOffset;
}

struct ValidationCommandResetQuery
{
	public ValidationCommandType type;
	public IQueryPool queryPool;
	public uint32 queryPoolOffset;
	public uint32 queryNum;
}

class CommandBufferVal : DeviceObjectVal<ICommandBuffer>, ICommandBuffer
{
	private List<uint8> m_ValidationCommands;
	private bool m_IsRecordingStarted = false;
	private bool m_IsWrapped = false;
	private IFrameBuffer m_FrameBuffer = null;
	private int32 m_AnnotationStack = 0;

	public this(DeviceVal device, ICommandBuffer commandBuffer, bool isWrapped)
		: base(device, commandBuffer)
	{
		m_ValidationCommands = Allocate!<List<uint8>>(m_Device.GetAllocator());

		m_IsWrapped = isWrapped;
		m_IsRecordingStarted = isWrapped;
	}

	public ~this()
	{
		Deallocate!(m_Device.GetAllocator(), m_ValidationCommands);
	}

	[Inline] public List<uint8> GetValidationCommands()
		{ return m_ValidationCommands; }

	[Inline] public void* GetNativeObject()
		{ return m_ImplObject.GetNativeObject(); }

	//================================================================================================================
	// NRI
	//================================================================================================================
	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}

	public Result Begin(IDescriptorPool descriptorPool, uint32 physicalDeviceIndex)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), !m_IsRecordingStarted, Result.FAILURE,
			"Can't begin recording of CommandBuffer: the command buffer is already in the recording state.");

		IDescriptorPool descriptorPoolImpl = null;
		if (descriptorPool != null)
			descriptorPoolImpl = NRI_GET_IMPL_PTR!<IDescriptorPool...>((DescriptorPoolVal)descriptorPool);

		Result result = m_ImplObject.Begin(descriptorPoolImpl, physicalDeviceIndex);
		if (result == Result.SUCCESS)
			m_IsRecordingStarted = true;

		m_ValidationCommands.Clear();

		return result;
	}

	public Result End()
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, Result.FAILURE,
			"Can't end command buffer: the command buffer must be in the recording state.");

		if (m_AnnotationStack > 0)
			REPORT_ERROR(m_Device.GetLogger(), "BeginAnnotation() is called more times than EndAnnotation()");
		else if (m_AnnotationStack < 0)
			REPORT_ERROR(m_Device.GetLogger(), "EndAnnotation() is called more times than BeginAnnotation()");

		Result result = m_ImplObject.End();

		if (result == Result.SUCCESS)
		{
			m_IsRecordingStarted = m_IsWrapped;
			m_FrameBuffer = null;
		}

		return result;
	}

	public void SetViewports(Viewport* viewports, uint32 viewportNum)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set viewports: the command buffer must be in the recording state.");

		if (viewportNum == 0)
			return;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), viewports != null, void(),
			"Can't set viewports: 'viewports' is invalid.");

		m_ImplObject.SetViewports(viewports, viewportNum);
	}

	public void SetScissors(Rect* rects, uint32 rectNum)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set scissors: the command buffer must be in the recording state.");

		if (rectNum == 0)
			return;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), rects != null, void(),
			"Can't set scissor rects: 'rects' is invalid.");

		m_ImplObject.SetScissors(rects, rectNum);
	}

	public void SetDepthBounds(float boundsMin, float boundsMax)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set depth bounds: the command buffer must be in the recording state.");

		m_ImplObject.SetDepthBounds(boundsMin, boundsMax);
	}

	public void SetStencilReference(uint8 reference)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set stencil reference: the command buffer must be in the recording state.");

		m_ImplObject.SetStencilReference(reference);
	}

	public void SetSamplePositions(SamplePosition* positions, uint32 positionNum)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set sample positions: the command buffer must be in the recording state.");

		m_ImplObject.SetSamplePositions(positions, positionNum);
	}

	public void ClearAttachments(ClearDesc* clearDescs, uint32 clearDescNum, Rect* rects, uint32 rectNum)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't clear attachments: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer != null, void(),
			"Can't clear attachments: no FrameBuffer bound.");

		m_ImplObject.ClearAttachments(clearDescs, clearDescNum, rects, rectNum);
	}

	public void ClearStorageBuffer(ClearStorageBufferDesc clearDesc)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't clear storage buffer: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't clear storage buffer: this operation is not allowed in render pass.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), clearDesc.storageBuffer != null, void(),
			"Can't clear storage buffer: 'clearDesc.storageBuffer' is invalid.");

		var clearDescImpl = clearDesc;
		clearDescImpl.storageBuffer = NRI_GET_IMPL_PTR!<IDescriptor...>((DescriptorVal)clearDesc.storageBuffer);

		m_ImplObject.ClearStorageBuffer(clearDescImpl);
	}

	public void ClearStorageTexture(ClearStorageTextureDesc clearDesc)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't clear storage texture: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't clear storage texture: this operation is not allowed in render pass.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), clearDesc.storageTexture != null, void(),
			"Can't clear storage texture: 'clearDesc.storageTexture' is invalid.");

		var clearDescImpl = clearDesc;
		clearDescImpl.storageTexture = NRI_GET_IMPL_PTR!<IDescriptor...>((DescriptorVal)clearDesc.storageTexture);

		m_ImplObject.ClearStorageTexture(clearDescImpl);
	}

	public void BeginRenderPass(IFrameBuffer frameBuffer, RenderPassBeginFlag renderPassBeginFlag)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't begin render pass: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't begin render pass: render pass already started.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), renderPassBeginFlag < RenderPassBeginFlag.MAX_NUM, void(),
			"Can't begin render pass: 'renderPassBeginFlag' is invalid.");

		m_FrameBuffer = frameBuffer;

		IFrameBuffer frameBufferImpl = NRI_GET_IMPL_REF!<IFrameBuffer...>((FrameBufferVal)frameBuffer);

		m_ImplObject.BeginRenderPass(frameBufferImpl, renderPassBeginFlag);
	}

	public void EndRenderPass()
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't end render pass: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer != null, void(),
			"Can't end render pass: no render pass.");

		m_FrameBuffer = null;

		m_ImplObject.EndRenderPass();
	}

	public void SetVertexBuffers(uint32 baseSlot, uint32 bufferNum, IBuffer* buffers, uint64* offsets)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set vertex buffers: the command buffer must be in the recording state.");

		IBuffer* buffersImpl = STACK_ALLOC!<IBuffer>(bufferNum);
		for (uint32 i = 0; i < bufferNum; i++)
			buffersImpl[i] = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)buffers[i]);

		m_ImplObject.SetVertexBuffers(baseSlot, bufferNum, buffersImpl, offsets);
	}

	public void SetIndexBuffer(IBuffer buffer, uint64 offset, IndexType indexType)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set index buffers: the command buffer must be in the recording state.");

		IBuffer bufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)buffer);

		m_ImplObject.SetIndexBuffer(bufferImpl, offset, indexType);
	}

	public void SetPipelineLayout(IPipelineLayout pipelineLayout)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set pipeline layout: the command buffer must be in the recording state.");

		IPipelineLayout pipelineLayoutImpl = NRI_GET_IMPL_REF!<IPipelineLayout...>((PipelineLayoutVal)pipelineLayout);

		m_ImplObject.SetPipelineLayout(pipelineLayoutImpl);
	}

	public void SetPipeline(IPipeline pipeline)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set pipeline: the command buffer must be in the recording state.");

		IPipeline pipelineImpl = NRI_GET_IMPL_REF!<IPipeline...>((PipelineVal)pipeline);

		m_ImplObject.SetPipeline(pipelineImpl);
	}

	public void SetDescriptorPool(IDescriptorPool descriptorPool)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set descriptor pool: the command buffer must be in the recording state.");

		IDescriptorPool descriptorPoolImpl = NRI_GET_IMPL_REF!<IDescriptorPool...>((DescriptorPoolVal)descriptorPool);

		m_ImplObject.SetDescriptorPool(descriptorPoolImpl);
	}

	public void SetDescriptorSet(uint32 setIndexInPipelineLayout, IDescriptorSet descriptorSet, uint32* dynamicConstantBufferOffsets)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set descriptor sets: the command buffer must be in the recording state.");

		IDescriptorSet descriptorSetImpl = NRI_GET_IMPL_REF!<IDescriptorSet...>((DescriptorSetVal)descriptorSet);

		m_ImplObject.SetDescriptorSet(setIndexInPipelineLayout, descriptorSetImpl, dynamicConstantBufferOffsets);
	}

	public void SetConstants(uint32 pushConstantIndex, void* data, uint32 size)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't set constants: the command buffer must be in the recording state.");

		m_ImplObject.SetConstants(pushConstantIndex, data, size);
	}

	public void Draw(uint32 vertexNum, uint32 instanceNum, uint32 baseVertex, uint32 baseInstance)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't record draw call: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer != null, void(),
			"Can't record draw call: this operation is allowed only inside render pass.");

		m_ImplObject.Draw(vertexNum, instanceNum, baseVertex, baseInstance);
	}

	public void DrawIndexed(uint32 indexNum, uint32 instanceNum, uint32 baseIndex, uint32 baseVertex, uint32 baseInstance)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't record draw call: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer != null, void(),
			"Can't record draw call: this operation is allowed only inside render pass.");

		m_ImplObject.DrawIndexed(indexNum, instanceNum, baseIndex, baseVertex, baseInstance);
	}

	public void DrawIndirect(IBuffer buffer, uint64 offset, uint32 drawNum, uint32 stride)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't record draw call: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer != null, void(),
			"Can't record draw call: this operation is allowed only inside render pass.");

		IBuffer bufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)buffer);

		m_ImplObject.DrawIndirect(bufferImpl, offset, drawNum, stride);
	}

	public void DrawIndexedIndirect(IBuffer buffer, uint64 offset, uint32 drawNum, uint32 stride)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't record draw call: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer != null, void(),
			"Can't record draw call: this operation is allowed only inside render pass.");

		IBuffer bufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)buffer);

		m_ImplObject.DrawIndexedIndirect(bufferImpl, offset, drawNum, stride);
	}

	public void CopyBuffer(IBuffer dstBuffer, uint32 dstPhysicalDeviceIndex, uint64 dstOffset, IBuffer srcBuffer, uint32 srcPhysicalDeviceIndex, uint64 srcOffset, uint64 size)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't copy buffer: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't copy buffer: this operation is allowed only outside render pass.");

		if (size == WHOLE_SIZE)
		{
			readonly ref BufferDesc dstDesc = ref ((BufferVal)dstBuffer).GetDesc();
			readonly ref BufferDesc srcDesc = ref ((BufferVal)srcBuffer).GetDesc();

			if (dstDesc.size != srcDesc.size)
			{
				REPORT_WARNING(m_Device.GetLogger(), "WHOLE_SIZE is used but 'dstBuffer' and 'srcBuffer' have diffenet sizes. 'srcDesc.size' bytes will be copied to the destination.");
				return;
			}
		}

		IBuffer dstBufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)dstBuffer);
		IBuffer srcBufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)srcBuffer);

		m_ImplObject.CopyBuffer(dstBufferImpl, dstPhysicalDeviceIndex, dstOffset, srcBufferImpl, srcPhysicalDeviceIndex,
			srcOffset, size);
	}

	public void CopyTexture(ITexture dstTexture, uint32 dstPhysicalDeviceIndex, TextureRegionDesc* dstRegionDesc, ITexture srcTexture, uint32 srcPhysicalDeviceIndex, TextureRegionDesc* srcRegionDesc)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't copy texture: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't copy texture: this operation is allowed only outside render pass.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), (dstRegionDesc == null && srcRegionDesc == null) || (dstRegionDesc != null && srcRegionDesc != null), void(),
			"Can't copy texture: 'dstRegionDesc' and 'srcRegionDesc' must be valid pointers or be both NULL.");

		ITexture dstTextureImpl = NRI_GET_IMPL_REF!<ITexture...>((TextureVal)dstTexture);
		ITexture srcTextureImpl = NRI_GET_IMPL_REF!<ITexture...>((TextureVal)srcTexture);

		m_ImplObject.CopyTexture(dstTextureImpl, dstPhysicalDeviceIndex, dstRegionDesc, srcTextureImpl, srcPhysicalDeviceIndex,
			srcRegionDesc);
	}

	public void UploadBufferToTexture(ITexture dstTexture, TextureRegionDesc dstRegionDesc, IBuffer srcBuffer, TextureDataLayoutDesc srcDataLayoutDesc)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't upload buffer to texture: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't upload buffer to texture: this operation is allowed only outside render pass.");

		ITexture dstTextureImpl = NRI_GET_IMPL_REF!<ITexture...>((TextureVal)dstTexture);
		IBuffer srcBufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)srcBuffer);

		m_ImplObject.UploadBufferToTexture(dstTextureImpl, dstRegionDesc, srcBufferImpl, srcDataLayoutDesc);
	}

	public void ReadbackTextureToBuffer(IBuffer dstBuffer, ref TextureDataLayoutDesc dstDataLayoutDesc, ITexture srcTexture, TextureRegionDesc srcRegionDesc)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't readback texture to buffer: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't readback texture to buffer: this operation is allowed only outside render pass.");

		IBuffer dstBufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)dstBuffer);
		ITexture srcTextureImpl = NRI_GET_IMPL_REF!<ITexture...>((TextureVal)srcTexture);

		m_ImplObject.ReadbackTextureToBuffer(dstBufferImpl, ref dstDataLayoutDesc, srcTextureImpl, srcRegionDesc);
	}

	public void Dispatch(uint32 x, uint32 y, uint32 z)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't record dispatch call: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't record dispatch call: this operation is allowed only outside render pass.");

		m_ImplObject.Dispatch(x, y, z);
	}

	public void DispatchIndirect(IBuffer buffer, uint64 offset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't record dispatch call: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't record dispatch call: this operation is allowed only outside render pass.");

		IBuffer bufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)buffer);

		m_ImplObject.DispatchIndirect(bufferImpl, offset);
	}

	public void PipelineBarrier(TransitionBarrierDesc* transitionBarriers, AliasingBarrierDesc* aliasingBarriers, BarrierDependency dependency)
	{
		var transitionBarriers;
		var aliasingBarriers;
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't record pipeline barrier: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't record pipeline barrier: this operation is allowed only outside render pass.");

		TransitionBarrierDesc transitionBarrierImpl;
		if (transitionBarriers != null)
		{
			transitionBarrierImpl = *transitionBarriers;

			for (uint32 i = 0; i < transitionBarriers.bufferNum; i++)
			{
				if (!ValidateBufferTransitionBarrierDesc(m_Device, i, transitionBarriers.buffers[i]))
					return;
			}

			for (uint32 i = 0; i < transitionBarriers.textureNum; i++)
			{
				if (!ValidateTextureTransitionBarrierDesc(m_Device, i, transitionBarriers.textures[i]))
					return;
			}

			transitionBarrierImpl.buffers = STACK_ALLOC!<BufferTransitionBarrierDesc>(transitionBarriers.bufferNum);
			Internal.MemCpy((void*)transitionBarrierImpl.buffers, transitionBarriers.buffers, sizeof(BufferTransitionBarrierDesc) * transitionBarriers.bufferNum);
			for (uint32 i = 0; i < transitionBarrierImpl.bufferNum; i++)
				((BufferTransitionBarrierDesc*)transitionBarrierImpl.buffers)[i].buffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)transitionBarriers.buffers[i].buffer);

			transitionBarrierImpl.textures = STACK_ALLOC!<TextureTransitionBarrierDesc>(transitionBarriers.textureNum);
			Internal.MemCpy((void*)transitionBarrierImpl.textures, transitionBarriers.textures, sizeof(TextureTransitionBarrierDesc) * transitionBarriers.textureNum);
			for (uint32 i = 0; i < transitionBarrierImpl.textureNum; i++)
				((TextureTransitionBarrierDesc*)transitionBarrierImpl.textures)[i].texture = NRI_GET_IMPL_PTR!<ITexture...>((TextureVal)transitionBarriers.textures[i].texture);

			transitionBarriers = &transitionBarrierImpl;
		}

		AliasingBarrierDesc aliasingBarriersImpl;
		if (aliasingBarriers != null)
		{
			aliasingBarriersImpl = *aliasingBarriers;

			aliasingBarriersImpl.buffers = STACK_ALLOC!<BufferAliasingBarrierDesc>(aliasingBarriers.bufferNum);
			Internal.MemCpy((void*)aliasingBarriersImpl.buffers, aliasingBarriers.buffers, sizeof(BufferAliasingBarrierDesc) * aliasingBarriers.bufferNum);
			for (uint32 i = 0; i < aliasingBarriersImpl.bufferNum; i++)
			{
				((BufferAliasingBarrierDesc*)aliasingBarriersImpl.buffers)[i].before = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)aliasingBarriers.buffers[i].before);
				((BufferAliasingBarrierDesc*)aliasingBarriersImpl.buffers)[i].after = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)aliasingBarriers.buffers[i].after);
			}

			aliasingBarriersImpl.textures = STACK_ALLOC!<TextureAliasingBarrierDesc>(aliasingBarriers.textureNum);
			Internal.MemCpy((void*)aliasingBarriersImpl.textures, aliasingBarriers.textures, sizeof(TextureAliasingBarrierDesc) * aliasingBarriers.textureNum);
			for (uint32 i = 0; i < aliasingBarriersImpl.textureNum; i++)
			{
				((TextureAliasingBarrierDesc*)aliasingBarriersImpl.textures)[i].before = NRI_GET_IMPL_PTR!<ITexture...>((TextureVal)aliasingBarriers.textures[i].before);
				((TextureAliasingBarrierDesc*)aliasingBarriersImpl.textures)[i].after = NRI_GET_IMPL_PTR!<ITexture...>((TextureVal)aliasingBarriers.textures[i].after);
			}

			aliasingBarriers = &aliasingBarriersImpl;
		}

		m_ImplObject.PipelineBarrier(transitionBarriers, aliasingBarriers, dependency);
	}

	public void BeginQuery(IQueryPool queryPool, uint32 offset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't begin query: the command buffer must be in the recording state.");

		readonly QueryPoolVal queryPoolVal = (QueryPoolVal)queryPool;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), queryPoolVal.GetQueryType() != QueryType.TIMESTAMP, void(),
			"Can't begin query: BeginQuery() is not supported for timestamp queries.");

		if (!queryPoolVal.IsImported())
		{
			RETURN_ON_FAILURE!(m_Device.GetLogger(), offset < queryPoolVal.GetQueryNum(), void(),
				"Can't begin query: the offset ('{0}') is out of range.", offset);

			ref ValidationCommandUseQuery validationCommand = ref AllocateValidationCommand<ValidationCommandUseQuery>();
			validationCommand.type = ValidationCommandType.BEGIN_QUERY;
			validationCommand.queryPool = (IQueryPool)queryPool;
			validationCommand.queryPoolOffset = offset;
		}

		IQueryPool queryPoolImpl = NRI_GET_IMPL_REF!<IQueryPool...>((QueryPoolVal)queryPool);

		m_ImplObject.BeginQuery(queryPoolImpl, offset);
	}

	public void EndQuery(IQueryPool queryPool, uint32 offset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't end query: the command buffer must be in the recording state.");

		readonly QueryPoolVal queryPoolVal = (QueryPoolVal)queryPool;

		if (!queryPoolVal.IsImported())
		{
			RETURN_ON_FAILURE!(m_Device.GetLogger(), offset < queryPoolVal.GetQueryNum(), void(),
				"Can't end query: the offset ('{0}') is out of range.", offset);

			ref ValidationCommandUseQuery validationCommand = ref AllocateValidationCommand<ValidationCommandUseQuery>();
			validationCommand.type = ValidationCommandType.END_QUERY;
			validationCommand.queryPool = (IQueryPool)queryPool;
			validationCommand.queryPoolOffset = offset;
		}

		IQueryPool queryPoolImpl = NRI_GET_IMPL_REF!<IQueryPool...>((QueryPoolVal)queryPool);

		m_ImplObject.EndQuery(queryPoolImpl, offset);
	}

	public void CopyQueries(IQueryPool queryPool, uint32 offset, uint32 num, IBuffer dstBuffer, uint64 dstOffset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't copy queries: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't copy queries: this operation is allowed only outside render pass.");

		readonly QueryPoolVal queryPoolVal = (QueryPoolVal)queryPool;

		if (!queryPoolVal.IsImported())
		{
			RETURN_ON_FAILURE!(m_Device.GetLogger(), offset + num <= queryPoolVal.GetQueryNum(), void(),
				"Can't copy queries: offset + num ('{0}') is out of range.", offset + num);
		}

		IQueryPool queryPoolImpl = NRI_GET_IMPL_REF!<IQueryPool...>((QueryPoolVal)queryPool);
		IBuffer dstBufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)dstBuffer);

		m_ImplObject.CopyQueries(queryPoolImpl, offset, num, dstBufferImpl, dstOffset);
	}

	public void ResetQueries(IQueryPool queryPool, uint32 offset, uint32 num)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't reset queries: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't reset queries: this operation is allowed only outside render pass.");

		readonly QueryPoolVal queryPoolVal = (QueryPoolVal)queryPool;

		if (!queryPoolVal.IsImported())
		{
			RETURN_ON_FAILURE!(m_Device.GetLogger(), offset + num <= queryPoolVal.GetQueryNum(), void(),
				"Can't reset queries: offset + num ('{0}') is out of range.", offset + num);

			ref ValidationCommandResetQuery validationCommand = ref AllocateValidationCommand<ValidationCommandResetQuery>();
			validationCommand.type = ValidationCommandType.RESET_QUERY;
			validationCommand.queryPool = (IQueryPool)queryPool;
			validationCommand.queryPoolOffset = offset;
			validationCommand.queryNum = num;
		}

		IQueryPool queryPoolImpl = NRI_GET_IMPL_REF!<IQueryPool...>((QueryPoolVal)queryPool);

		m_ImplObject.ResetQueries(queryPoolImpl, offset, num);
	}

	public void BeginAnnotation(char8* name)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't copy queries: the command buffer must be in the recording state.");

		m_AnnotationStack++;
		m_ImplObject.BeginAnnotation(name);
	}

	public void EndAnnotation()
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't copy queries: the command buffer must be in the recording state.");

		m_ImplObject.EndAnnotation();
		m_AnnotationStack--;
	}

	public void Destroy()
	{
		m_Device.GetImpl().DestroyCommandBuffer(m_ImplObject);
		Deallocate!(m_Device.GetAllocator(), this);
	}

	public void BuildTopLevelAccelerationStructure(uint32 instanceNum, IBuffer buffer, uint64 bufferOffset,
		AccelerationStructureBuildBits flags, IAccelerationStructure dst, IBuffer scratch, uint64 scratchOffset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't build TLAS: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't build TLAS: this operation is allowed only outside render pass.");

		BufferVal bufferVal = (BufferVal)buffer;
		BufferVal scratchVal = (BufferVal)scratch;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), bufferOffset < bufferVal.GetDesc().size, void(),
			"Can't update TLAS: 'bufferOffset' is out of bounds.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), scratchOffset < scratchVal.GetDesc().size, void(),
			"Can't update TLAS: 'scratchOffset' is out of bounds.");

		IAccelerationStructure dstImpl = NRI_GET_IMPL_REF!<IAccelerationStructure...>((AccelerationStructureVal)dst);
		IBuffer scratchImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)scratch);
		IBuffer bufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)buffer);

		m_ImplObject.BuildTopLevelAccelerationStructure(instanceNum, bufferImpl, bufferOffset, flags, dstImpl, scratchImpl, scratchOffset);
	}

	public void BuildBottomLevelAccelerationStructure(uint32 geometryObjectNum, GeometryObject* geometryObjects,
		AccelerationStructureBuildBits flags, IAccelerationStructure dst, IBuffer scratch, uint64 scratchOffset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't build BLAS: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't build BLAS: this operation is allowed only outside render pass.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), geometryObjects != null, void(),
			"Can't update BLAS: 'geometryObjects' is invalid.");

		BufferVal scratchVal = (BufferVal)scratch;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), scratchOffset < scratchVal.GetDesc().size, void(),
			"Can't build BLAS: 'scratchOffset' is out of bounds.");

		IAccelerationStructure dstImpl = NRI_GET_IMPL_REF!<IAccelerationStructure...>((AccelerationStructureVal)dst);
		IBuffer scratchImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)scratch);

		List<GeometryObject> objectImplArray = Allocate!<List<GeometryObject>>(m_Device.GetAllocator());
		defer { Deallocate!(m_Device.GetAllocator(), objectImplArray); }
		objectImplArray.Resize(geometryObjectNum);
		ConvertGeometryObjectsVal(objectImplArray.Ptr, geometryObjects, geometryObjectNum);

		m_ImplObject.BuildBottomLevelAccelerationStructure(geometryObjectNum, objectImplArray.Ptr, flags, dstImpl, scratchImpl, scratchOffset);
	}

	public void UpdateTopLevelAccelerationStructure(uint32 instanceNum, IBuffer buffer, uint64 bufferOffset,
		AccelerationStructureBuildBits flags, IAccelerationStructure dst, IAccelerationStructure src, IBuffer scratch, uint64 scratchOffset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't update TLAS: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't update TLAS: this operation is allowed only outside render pass.");

		BufferVal bufferVal = (BufferVal)buffer;
		BufferVal scratchVal = (BufferVal)scratch;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), bufferOffset < bufferVal.GetDesc().size, void(),
			"Can't update TLAS: 'bufferOffset' is out of bounds.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), scratchOffset < scratchVal.GetDesc().size, void(),
			"Can't update TLAS: 'scratchOffset' is out of bounds.");

		IAccelerationStructure dstImpl = NRI_GET_IMPL_REF!<IAccelerationStructure...>((AccelerationStructureVal)dst);
		IAccelerationStructure srcImpl = NRI_GET_IMPL_REF!<IAccelerationStructure...>((AccelerationStructureVal)src);
		IBuffer scratchImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)scratch);
		IBuffer bufferImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)buffer);

		m_ImplObject.UpdateTopLevelAccelerationStructure(instanceNum, bufferImpl, bufferOffset, flags, dstImpl, srcImpl, scratchImpl, scratchOffset);
	}


	public void UpdateBottomLevelAccelerationStructure(uint32 geometryObjectNum, GeometryObject* geometryObjects,
		AccelerationStructureBuildBits flags, IAccelerationStructure dst, IAccelerationStructure src, IBuffer scratch, uint64 scratchOffset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't update BLAS: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't update BLAS: this operation is allowed only outside render pass.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), geometryObjects != null, void(),
			"Can't update BLAS: 'geometryObjects' is invalid.");

		BufferVal scratchVal = (BufferVal)scratch;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), scratchOffset < scratchVal.GetDesc().size, void(),
			"Can't update BLAS: 'scratchOffset' is out of bounds.");

		IAccelerationStructure dstImpl = NRI_GET_IMPL_REF!<IAccelerationStructure...>((AccelerationStructureVal)dst);
		IAccelerationStructure srcImpl = NRI_GET_IMPL_REF!<IAccelerationStructure...>((AccelerationStructureVal)src);
		IBuffer scratchImpl = NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)scratch);

		List<GeometryObject> objectImplArray = Allocate!<List<GeometryObject>>(m_Device.GetAllocator());
		defer { Deallocate!(m_Device.GetAllocator(), objectImplArray); }
		objectImplArray.Resize(geometryObjectNum);
		ConvertGeometryObjectsVal(objectImplArray.Ptr, geometryObjects, geometryObjectNum);

		m_ImplObject.UpdateBottomLevelAccelerationStructure(geometryObjectNum, objectImplArray.Ptr, flags, dstImpl, srcImpl, scratchImpl, scratchOffset);
	}

	public void CopyAccelerationStructure(IAccelerationStructure dst, IAccelerationStructure src, CopyMode copyMode)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't copy AS: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't copy AS: this operation is allowed only outside render pass.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), copyMode < CopyMode.MAX_NUM, void(),
			"Can't copy AS: 'copyMode' is invalid.");

		IAccelerationStructure dstImpl = NRI_GET_IMPL_REF!<IAccelerationStructure...>((AccelerationStructureVal)dst);
		IAccelerationStructure srcImpl = NRI_GET_IMPL_REF!<IAccelerationStructure...>((AccelerationStructureVal)src);

		m_ImplObject.CopyAccelerationStructure(dstImpl, srcImpl, copyMode);
	}

	public void WriteAccelerationStructureSize(IAccelerationStructure* accelerationStructures, uint32 accelerationStructureNum, IQueryPool queryPool, uint32 queryOffset)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't write AS size: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't write AS size: this operation is allowed only outside render pass.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), accelerationStructures != null, void(),
			"Can't write AS size: 'accelerationStructures' is invalid.");

		IAccelerationStructure* accelerationStructureArray = STACK_ALLOC!<IAccelerationStructure>(accelerationStructureNum);
		for (uint32 i = 0; i < accelerationStructureNum; i++)
		{
			RETURN_ON_FAILURE!(m_Device.GetLogger(), accelerationStructures[i] != null, void(),
				"Can't write AS size: 'accelerationStructures[{0}]' is invalid.", i);

			accelerationStructureArray[i] = NRI_GET_IMPL_PTR!<IAccelerationStructure...>((AccelerationStructureVal)accelerationStructures[i]);
		}

		IQueryPool queryPoolImpl = NRI_GET_IMPL_REF!<IQueryPool...>((QueryPoolVal)queryPool);

		m_ImplObject.WriteAccelerationStructureSize(accelerationStructures, accelerationStructureNum, queryPoolImpl, queryOffset);
	}

	public void DispatchRays(DispatchRaysDesc dispatchRaysDesc)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_IsRecordingStarted, void(),
			"Can't record ray tracing dispatch: the command buffer must be in the recording state.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), m_FrameBuffer == null, void(),
			"Can't record ray tracing dispatch: this operation is allowed only outside render pass.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dispatchRaysDesc.raygenShader.buffer != null, void(),
			"Can't record ray tracing dispatch: 'dispatchRaysDesc.raygenShader.buffer' is invalid.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dispatchRaysDesc.raygenShader.size != 0, void(),
			"Can't record ray tracing dispatch: 'dispatchRaysDesc.raygenShader.size' is 0.");

		readonly uint64 SBTAlignment = m_Device.GetDesc().rayTracingShaderTableAligment;

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dispatchRaysDesc.raygenShader.offset % SBTAlignment == 0, void(),
			"Can't record ray tracing dispatch: 'dispatchRaysDesc.raygenShader.offset' is misaligned.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dispatchRaysDesc.missShaders.offset % SBTAlignment == 0, void(),
			"Can't record ray tracing dispatch: 'dispatchRaysDesc.missShaders.offset' is misaligned.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dispatchRaysDesc.hitShaderGroups.offset % SBTAlignment == 0, void(),
			"Can't record ray tracing dispatch: 'dispatchRaysDesc.hitShaderGroups.offset' is misaligned.");

		RETURN_ON_FAILURE!(m_Device.GetLogger(), dispatchRaysDesc.callableShaders.offset % SBTAlignment == 0, void(),
			"Can't record ray tracing dispatch: 'dispatchRaysDesc.callableShaders.offset' is misaligned.");

		var dispatchRaysDescImpl = dispatchRaysDesc;
		dispatchRaysDescImpl.raygenShader.buffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)dispatchRaysDesc.raygenShader.buffer);
		dispatchRaysDescImpl.missShaders.buffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)dispatchRaysDesc.missShaders.buffer);
		dispatchRaysDescImpl.hitShaderGroups.buffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)dispatchRaysDesc.hitShaderGroups.buffer);
		dispatchRaysDescImpl.callableShaders.buffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)dispatchRaysDesc.callableShaders.buffer);

		m_ImplObject.DispatchRays(dispatchRaysDescImpl);
	}

	public void DispatchMeshTasks(uint32 x, uint32 y, uint32 z)
	{
		m_ImplObject.DispatchMeshTasks(x, y, z);
	}

	private ref Command AllocateValidationCommand<Command>()
	{
		readonly uint commandSize = (.)sizeof(Command);
		readonly uint newSize = (uint)m_ValidationCommands.Count + commandSize;
		readonly uint capacity = (.)m_ValidationCommands.Capacity;

		if (newSize > capacity)
			m_ValidationCommands.Reserve((.)Math.Max(capacity + (capacity >> 1), newSize));

		readonly uint offset = (.)m_ValidationCommands.Count;
		m_ValidationCommands.Resize((.)newSize);

		return ref *(Command*)(m_ValidationCommands.Ptr + offset);
	}
}

static
{
	public static bool ValidateBufferTransitionBarrierDesc(DeviceVal device, uint32 i, BufferTransitionBarrierDesc bufferTransitionBarrierDesc)
	{
		RETURN_ON_FAILURE!(device.GetLogger(), bufferTransitionBarrierDesc.buffer != null, false,
			"Can't record pipeline barrier: 'transitionBarriers.buffers[{0}].buffer' is invalid.", i);

		readonly BufferVal bufferVal = (BufferVal)bufferTransitionBarrierDesc.buffer;

		RETURN_ON_FAILURE!(device.GetLogger(), IsAccessMaskSupported(bufferVal.GetDesc().usageMask, bufferTransitionBarrierDesc.prevAccess), false,
			"Can't record pipeline barrier: 'transitionBarriers.buffers[{0}].prevAccess' is not supported by the usage mask of the buffer ('{1}').",
			i, bufferVal.GetDebugName().CStr());

		RETURN_ON_FAILURE!(device.GetLogger(), IsAccessMaskSupported(bufferVal.GetDesc().usageMask, bufferTransitionBarrierDesc.nextAccess), false,
			"Can't record pipeline barrier: 'transitionBarriers.buffers[{0}].nextAccess' is not supported by the usage mask of the buffer ('{1}').",
			i, bufferVal.GetDebugName().CStr());

		return true;
	}

	public static bool ValidateTextureTransitionBarrierDesc(DeviceVal device, uint32 i, TextureTransitionBarrierDesc textureTransitionBarrierDesc)
	{
		RETURN_ON_FAILURE!(device.GetLogger(), textureTransitionBarrierDesc.texture != null, false,
			"Can't record pipeline barrier: 'transitionBarriers.textures[{0}].texture' is invalid.", i);

		readonly TextureVal textureVal = (TextureVal)textureTransitionBarrierDesc.texture;

		RETURN_ON_FAILURE!(device.GetLogger(), IsAccessMaskSupported(textureVal.GetDesc().usageMask, textureTransitionBarrierDesc.prevAccess), false,
			"Can't record pipeline barrier: 'transitionBarriers.textures[{0}].prevAccess' is not supported by the usage mask of the texture ('{1}').",
			i, textureVal.GetDebugName().CStr());

		RETURN_ON_FAILURE!(device.GetLogger(), IsAccessMaskSupported(textureVal.GetDesc().usageMask, textureTransitionBarrierDesc.nextAccess), false,
			"Can't record pipeline barrier: 'transitionBarriers.textures[{0}].nextAccess' is not supported by the usage mask of the texture ('{1}').",
			i, textureVal.GetDebugName().CStr());

		RETURN_ON_FAILURE!(device.GetLogger(), IsTextureLayoutSupported(textureVal.GetDesc().usageMask, textureTransitionBarrierDesc.prevLayout), false,
			"Can't record pipeline barrier: 'transitionBarriers.textures[{0}].prevLayout' is not supported by the usage mask of the texture ('{1}').",
			i, textureVal.GetDebugName().CStr());

		RETURN_ON_FAILURE!(device.GetLogger(), IsTextureLayoutSupported(textureVal.GetDesc().usageMask, textureTransitionBarrierDesc.nextLayout), false,
			"Can't record pipeline barrier: 'transitionBarriers.textures[{0}].nextLayout' is not supported by the usage mask of the texture ('{1}').",
			i, textureVal.GetDebugName().CStr());

		return true;
	}
}