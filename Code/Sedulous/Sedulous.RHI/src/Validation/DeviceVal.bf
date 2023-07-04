using System;
using System.Collections;
using System.Threading;
using Sedulous.RHI.Helpers;
namespace Sedulous.RHI.Validation;

static
{
	public static Result CreateDeviceValidation(DeviceCreationDesc deviceCreationDesc, DeviceLogger logger, DeviceAllocator<uint8> allocator, IDevice device, out IDevice outDeviceVal)
	{
		DeviceVal deviceVal = Allocate!<DeviceVal>(allocator, logger, allocator, device);

		if (!deviceVal.Create())
		{
			Deallocate!(allocator, deviceVal);
			outDeviceVal = ?;
			return .FAILURE;
		}

		outDeviceVal = deviceVal;

		return .SUCCESS;
	}
}

class DeviceVal : IDevice
{
	private IDevice m_Device;
	private String m_Name;
	private CommandQueueVal[COMMAND_QUEUE_TYPE_NUM] m_CommandQueues = .();
	private Dictionary<MemoryType, MemoryLocation> m_MemoryTypeMap; // todo sedulous: unordered collection
	private Monitor m_Monitor = new .() ~ delete _;

	public this(DeviceLogger logger, DeviceAllocator<uint8> allocator, IDevice device)
	{
		m_Device = device;
		m_Name = Allocate!<String>(m_Device.GetAllocator());
		m_MemoryTypeMap = Allocate!<Dictionary<MemoryType, MemoryLocation>>(m_Device.GetAllocator());
	}

	public ~this()
	{
		for (uint i = 0; i < m_CommandQueues.Count; i++)
		{
			if (m_CommandQueues[i] != null)
				Deallocate!(GetAllocator(), m_CommandQueues[i]);
		}
		DeviceAllocator<uint8> allocator = m_Device.GetAllocator();

		((IDevice)m_Device).Destroy();

		Deallocate!(allocator, m_MemoryTypeMap);
		Deallocate!(allocator, m_Name);
	}

	public IDevice GetImpl()
	{
		return m_Device;
	}

	public void Destroy()
	{
		Deallocate!(GetAllocator(), this);
	}

	public virtual bool Create() => true;

	public void RegisterMemoryType(MemoryType memoryType, MemoryLocation memoryLocation)
	{
		using (m_Monitor.Enter())
		{
			m_MemoryTypeMap[memoryType] = memoryLocation;
		}
	}

	[Inline] public void* GetNativeObject()
		{ return m_Device.GetNativeObject(); }

	[Inline] public Monitor GetMonitor()
		{ return m_Monitor; }

	public DeviceLogger GetLogger()
	{
		return m_Device.GetLogger();
	}

	public DeviceAllocator<uint8> GetAllocator()
	{
		return m_Device.GetAllocator();
	}

	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_Device.SetDebugName(name);
	}

	public readonly ref DeviceDesc GetDesc()
	{
		return ref m_Device.GetDesc();
	}



	public Result GetCommandQueue(CommandQueueType commandQueueType, out ICommandQueue commandQueue)
	{
		commandQueue = ?;
		RETURN_ON_FAILURE!(GetLogger(), commandQueueType < CommandQueueType.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't get CommandQueue: 'commandQueueType' is invalid.");

		ICommandQueue commandQueueImpl;
		readonly Result result = m_Device.GetCommandQueue(commandQueueType, out commandQueueImpl);

		if (result == Result.SUCCESS)
		{
			readonly uint32 index = (uint32)commandQueueType;
			if (m_CommandQueues[index] == null)
				m_CommandQueues[index] = Allocate!<CommandQueueVal>(GetAllocator(), this, commandQueueImpl);

			commandQueue = (ICommandQueue)m_CommandQueues[index];
		}

		return result;
	}

	public Result CreateCommandAllocator(ICommandQueue commandQueue, uint32 physicalDeviceMask, out ICommandAllocator commandAllocator)
	{
		commandAllocator = ?;
		var commandQueueImpl = NRI_GET_IMPL_REF!<ICommandQueue...>((CommandQueueVal)commandQueue);

		ICommandAllocator commandAllocatorImpl = null;
		readonly Result result = m_Device.CreateCommandAllocator(commandQueueImpl, physicalDeviceMask, out commandAllocatorImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), commandAllocatorImpl != null, Result.FAILURE, "Unexpected error: 'commandAllocatorImpl' is NULL.");
			commandAllocator = (ICommandAllocator)Allocate!<CommandAllocatorVal>(GetAllocator(), this, commandAllocatorImpl);
		}

		return result;
	}

	public Result CreateDescriptorPool(DescriptorPoolDesc descriptorPoolDesc, out IDescriptorPool descriptorPool)
	{
		descriptorPool = ?;
		IDescriptorPool descriptorPoolImpl = null;
		readonly Result result = m_Device.CreateDescriptorPool(descriptorPoolDesc, out descriptorPoolImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), descriptorPoolImpl != null, Result.FAILURE, "Unexpected error: 'descriptorPoolImpl' is NULL.");
			descriptorPool = (IDescriptorPool)Allocate!<DescriptorPoolVal>(GetAllocator(), this, descriptorPoolImpl, descriptorPoolDesc);
		}

		return result;
	}

	public Result CreateBuffer(BufferDesc bufferDesc, out IBuffer buffer)
	{
		buffer = ?;
		RETURN_ON_FAILURE!(GetLogger(), bufferDesc.size > 0, Result.INVALID_ARGUMENT,
			"Can't create Buffer: 'bufferDesc.size' is 0.");

		IBuffer bufferImpl = null;
		readonly Result result = m_Device.CreateBuffer(bufferDesc, out bufferImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), bufferImpl != null, Result.FAILURE, "Unexpected error: 'bufferImpl' is NULL.");
			buffer = (IBuffer)Allocate!<BufferVal>(GetAllocator(), this, bufferImpl, bufferDesc);
		}

		return result;
	}

	public Result CreateTexture(TextureDesc textureDesc, out ITexture texture)
	{
		texture = ?;
		RETURN_ON_FAILURE!(GetLogger(), textureDesc.format > Format.UNKNOWN && textureDesc.format < Format.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Texture: 'textureDesc.format' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), textureDesc.sampleNum > 0, Result.INVALID_ARGUMENT,
			"Can't create Texture: 'textureDesc.sampleNum' is invalid.");

		ITexture textureImpl = null;
		readonly Result result = m_Device.CreateTexture(textureDesc, out textureImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), textureImpl != null, Result.FAILURE, "Unexpected error: 'textureImpl' is NULL.");
			texture = (ITexture)Allocate!<TextureVal>(GetAllocator(), this, textureImpl, textureDesc);
		}

		return result;
	}

	public Result CreateBufferView(BufferViewDesc bufferViewDesc, out IDescriptor bufferView)
	{
		bufferView = ?;
		RETURN_ON_FAILURE!(GetLogger(), bufferViewDesc.buffer != null, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'bufferViewDesc.buffer' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), bufferViewDesc.format < Format.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'bufferViewDesc.format' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), bufferViewDesc.viewType < BufferViewType.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'bufferViewDesc.viewType' is invalid");

		readonly ref BufferDesc bufferDesc = ref ((BufferVal)bufferViewDesc.buffer).GetDesc();

		RETURN_ON_FAILURE!(GetLogger(), bufferViewDesc.offset < bufferDesc.size, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'bufferViewDesc.offset' is invalid. (bufferViewDesc.offset={0}, bufferDesc.size={1})",
			bufferViewDesc.offset, bufferDesc.size);

		RETURN_ON_FAILURE!(GetLogger(), bufferViewDesc.offset + bufferViewDesc.size <= bufferDesc.size, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'bufferViewDesc.size' is invalid. (bufferViewDesc.offset={0}, bufferViewDesc.size={1}, bufferDesc.size={2})",
			bufferViewDesc.offset, bufferViewDesc.size, bufferDesc.size);

		var bufferViewDescImpl = bufferViewDesc;
		bufferViewDescImpl.buffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)bufferViewDesc.buffer);

		IDescriptor descriptorImpl = null;
		readonly Result result = m_Device.CreateBufferView(bufferViewDescImpl, out descriptorImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), descriptorImpl != null, Result.FAILURE, "Unexpected error: 'descriptorImpl' is NULL.");
			bufferView = (IDescriptor)Allocate!<DescriptorVal>(GetAllocator(), this, descriptorImpl, bufferViewDesc);
		}

		return result;
	}

	public Result CreateTexture1DView(Texture1DViewDesc textureViewDesc, out IDescriptor textureView)
	{
		textureView = ?;
		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.texture != null, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.texture' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.format > Format.UNKNOWN && textureViewDesc.format < Format.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.format' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.viewType < Texture1DViewType.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.viewType' is invalid.");

		readonly ref TextureDesc textureDesc = ref ((TextureVal)textureViewDesc.texture).GetDesc();

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.mipOffset < textureDesc.mipNum, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.mipOffset' is invalid. (textureViewDesc.mipOffset={0}, textureDesc.mipNum={1})",
			textureViewDesc.mipOffset, textureDesc.mipNum);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.mipOffset + textureViewDesc.mipNum <= textureDesc.mipNum, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.mipNum' is invalid. (textureViewDesc.mipOffset={0}, textureViewDesc.mipNum={1}, textureDesc.mipNum={2})",
			textureViewDesc.mipOffset, textureViewDesc.mipNum, textureDesc.mipNum);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.arrayOffset < textureDesc.arraySize, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.arrayOffset' is invalid. (textureViewDesc.arrayOffset={0}, textureDesc.arraySize={1})",
			textureViewDesc.arrayOffset, textureDesc.arraySize);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.arrayOffset + textureViewDesc.arraySize <= textureDesc.arraySize, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.arraySize' is invalid. (textureViewDesc.arrayOffset={0}, textureViewDesc.arraySize={1}, textureDesc.arraySize={2})",
			textureViewDesc.arrayOffset, textureViewDesc.arraySize, textureDesc.arraySize);

		var textureViewDescImpl = textureViewDesc;
		textureViewDescImpl.texture = NRI_GET_IMPL_PTR!<ITexture...>((TextureVal)textureViewDesc.texture);

		IDescriptor descriptorImpl = null;
		readonly Result result = m_Device.CreateTexture1DView(textureViewDescImpl, out descriptorImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), descriptorImpl != null, Result.FAILURE, "Unexpected error: 'descriptorImpl' is NULL.");
			textureView = (IDescriptor)Allocate!<DescriptorVal>(GetAllocator(), this, descriptorImpl, textureViewDesc);
		}

		return result;
	}

	public Result CreateTexture2DView(Texture2DViewDesc textureViewDesc, out IDescriptor textureView)
	{
		textureView = ?;
		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.texture != null, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.texture' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.format > Format.UNKNOWN && textureViewDesc.format < Format.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.format' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.viewType < Texture2DViewType.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.viewType' is invalid.");

		readonly ref TextureDesc textureDesc = ref ((TextureVal)textureViewDesc.texture).GetDesc();

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.mipOffset < textureDesc.mipNum, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.mipOffset' is invalid. (textureViewDesc.mipOffset={0}, textureDesc.mipNum={1})",
			textureViewDesc.mipOffset, textureDesc.mipNum);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.mipOffset + textureViewDesc.mipNum <= textureDesc.mipNum, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.mipNum' is invalid. (textureViewDesc.mipOffset={0}, textureViewDesc.mipNum={1}, textureDesc.mipNum={2})",
			textureViewDesc.mipOffset, textureViewDesc.mipNum, textureDesc.mipNum);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.arrayOffset < textureDesc.arraySize, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.arrayOffset' is invalid. (textureViewDesc.arrayOffset={0}, textureDesc.arraySize={1})",
			textureViewDesc.arrayOffset, textureDesc.arraySize);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.arrayOffset + textureViewDesc.arraySize <= textureDesc.arraySize, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.arraySize' is invalid. (textureViewDesc.arrayOffset={0}, textureViewDesc.arraySize={1}, textureDesc.arraySize={2})",
			textureViewDesc.arrayOffset, textureViewDesc.arraySize, textureDesc.arraySize);

		var textureViewDescImpl = textureViewDesc;
		textureViewDescImpl.texture = NRI_GET_IMPL_PTR!<ITexture...>((TextureVal)textureViewDesc.texture);

		IDescriptor descriptorImpl = null;
		readonly Result result = m_Device.CreateTexture2DView(textureViewDescImpl, out descriptorImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), descriptorImpl != null, Result.FAILURE, "Unexpected error: 'descriptorImpl' is NULL.");
			textureView = (IDescriptor)Allocate!<DescriptorVal>(GetAllocator(), this, descriptorImpl, textureViewDesc);
		}

		return result;
	}

	public Result CreateTexture3DView(Texture3DViewDesc textureViewDesc, out IDescriptor textureView)
	{
		textureView = ?;
		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.texture != null, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.texture' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.format > Format.UNKNOWN && textureViewDesc.format < Format.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.format' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.viewType < Texture3DViewType.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.viewType' is invalid.");

		readonly ref TextureDesc textureDesc = ref ((TextureVal)textureViewDesc.texture).GetDesc();

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.mipOffset < textureDesc.mipNum, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.mipOffset' is invalid. (textureViewDesc.mipOffset={0}, textureViewDesc.mipOffset={1})",
			textureViewDesc.mipOffset, textureDesc.mipNum);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.mipOffset + textureViewDesc.mipNum <= textureDesc.mipNum, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.mipNum' is invalid. (textureViewDesc.mipOffset={0}, textureViewDesc.mipNum={1}, textureDesc.mipNum={2})",
			textureViewDesc.mipOffset, textureViewDesc.mipNum, textureDesc.mipNum);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.sliceOffset < textureDesc.size[2], Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.arrayOffset' is invalid. (textureViewDesc.sliceOffset={0}, textureDesc.size[2]={1})",
			textureViewDesc.sliceOffset, textureDesc.size[2]);

		RETURN_ON_FAILURE!(GetLogger(), textureViewDesc.sliceOffset + textureViewDesc.sliceNum <= textureDesc.size[2], Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'textureViewDesc.arraySize' is invalid. (textureViewDesc.sliceOffset={0}, textureViewDesc.sliceNum={1}, textureDesc.size[2]={2})",
			textureViewDesc.sliceOffset, textureViewDesc.sliceNum, textureDesc.size[2]);

		var textureViewDescImpl = textureViewDesc;
		textureViewDescImpl.texture = NRI_GET_IMPL_PTR!<ITexture...>((TextureVal)textureViewDesc.texture);

		IDescriptor descriptorImpl = null;
		readonly Result result = m_Device.CreateTexture3DView(textureViewDescImpl, out descriptorImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), descriptorImpl != null, Result.FAILURE, "Unexpected error: 'descriptorImpl' is NULL.");
			textureView = (IDescriptor)Allocate!<DescriptorVal>(GetAllocator(), this, descriptorImpl, textureViewDesc);
		}

		return result;
	}

	public Result CreateSampler(SamplerDesc samplerDesc, out IDescriptor sampler)
	{
		sampler = ?;
		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.magnification < Filter.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.magnification' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.minification < Filter.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.magnification' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.mip < Filter.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.mip' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.filterExt < FilterExt.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.filterExt' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.addressModes.u < AddressMode.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.addressModes.u' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.addressModes.v < AddressMode.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.addressModes.v' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.addressModes.w < AddressMode.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.addressModes.w' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.compareFunc < CompareFunc.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.compareFunc' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), samplerDesc.borderColor < BorderColor.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create Descriptor: 'samplerDesc.borderColor' is invalid.");

		IDescriptor samplerImpl = null;
		readonly Result result = m_Device.CreateSampler(samplerDesc, out samplerImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), samplerImpl != null, Result.FAILURE, "Unexpected error: 'samplerImpl' is NULL.");
			sampler = (IDescriptor)Allocate!<DescriptorVal>(GetAllocator(), this, samplerImpl);
		}

		return result;
	}

	public Result CreatePipelineLayout(PipelineLayoutDesc pipelineLayoutDesc, out IPipelineLayout pipelineLayout)
	{
		pipelineLayout = ?;
		readonly bool isGraphics = pipelineLayoutDesc.stageMask.HasFlag(PipelineLayoutShaderStageBits.ALL_GRAPHICS);
		readonly bool isCompute = pipelineLayoutDesc.stageMask.HasFlag(PipelineLayoutShaderStageBits.COMPUTE);
		readonly bool isRayTracing = pipelineLayoutDesc.stageMask.HasFlag(PipelineLayoutShaderStageBits.ALL_RAY_TRACING);
		readonly uint32 supportedTypes = (uint32)(isGraphics ? 1 : 0) + (uint32)(isCompute ? 1 : 0) + (uint32)(isRayTracing ? 1 : 0);

		RETURN_ON_FAILURE!(GetLogger(), supportedTypes > 0, Result.INVALID_ARGUMENT,
			"Can't create pipeline layout: 'pipelineLayoutDesc.stageMask' is 0.");
		RETURN_ON_FAILURE!(GetLogger(), supportedTypes == 1, Result.INVALID_ARGUMENT,
			"Can't create pipeline layout: 'pipelineLayoutDesc.stageMask' is invalid, it can't be compatible with more than one type of pipeline.");

		for (uint32 i = 0; i < pipelineLayoutDesc.descriptorSetNum; i++)
		{
			readonly ref DescriptorSetDesc descriptorSetDesc = ref pipelineLayoutDesc.descriptorSets[i];

			for (uint32 j = 0; j < descriptorSetDesc.rangeNum; j++)
			{
				readonly ref DescriptorRangeDesc range = ref descriptorSetDesc.ranges[j];

				RETURN_ON_FAILURE!(GetLogger(), !range.isDescriptorNumVariable || range.isArray, Result.INVALID_ARGUMENT,
					"Can't create pipeline layout: 'pipelineLayoutDesc.descriptorSets[{0}].ranges[{1}]' is invalid, 'isArray' can't be false if 'isDescriptorNumVariable' is true.",
					i, j);

				RETURN_ON_FAILURE!(GetLogger(), range.descriptorNum > 0, Result.INVALID_ARGUMENT,
					"Can't create pipeline layout: 'pipelineLayoutDesc.descriptorSets[{0}].ranges[{1}].descriptorNum' can't be 0.",
					i, j);

				RETURN_ON_FAILURE!(GetLogger(), range.visibility < ShaderStage.MAX_NUM, Result.INVALID_ARGUMENT,
					"Can't create pipeline layout: 'pipelineLayoutDesc.descriptorSets[{0}].ranges[{1}].visibility' is invalid.",
					i, j);

				RETURN_ON_FAILURE!(GetLogger(), range.descriptorType < DescriptorType.MAX_NUM, Result.INVALID_ARGUMENT,
					"Can't create pipeline layout: 'pipelineLayoutDesc.descriptorSets[{0}].ranges[{1}].descriptorType' is invalid.",
					i, j);

				if (range.visibility != ShaderStage.ALL)
				{
					readonly PipelineLayoutShaderStageBits visibilityMask = (PipelineLayoutShaderStageBits)(1 << (uint32)range.visibility);
					readonly uint32 filteredVisibilityMask = (.)(visibilityMask & pipelineLayoutDesc.stageMask);

					RETURN_ON_FAILURE!(GetLogger(), (uint32)visibilityMask == filteredVisibilityMask, Result.INVALID_ARGUMENT,
						"Can't create pipeline layout: 'pipelineLayoutDesc.descriptorSets[{0}].ranges[{1}].visibility' is not compatible with 'pipelineLayoutDesc.stageMask'.", i, j);
				}
			}
		}

		IPipelineLayout pipelineLayoutImpl = null;
		readonly Result result = m_Device.CreatePipelineLayout(pipelineLayoutDesc, out pipelineLayoutImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), pipelineLayoutImpl != null, Result.FAILURE, "Unexpected error: 'pipelineLayoutImpl' is NULL.");
			pipelineLayout = (IPipelineLayout)Allocate!<PipelineLayoutVal>(GetAllocator(), this, pipelineLayoutImpl, pipelineLayoutDesc);
		}

		return result;
	}

	public Result CreateGraphicsPipeline(GraphicsPipelineDesc graphicsPipelineDesc, out IPipeline pipeline)
	{
		pipeline = ?;
		RETURN_ON_FAILURE!(GetLogger(), graphicsPipelineDesc.pipelineLayout != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'graphicsPipelineDesc.pipelineLayout' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), graphicsPipelineDesc.outputMerger != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'graphicsPipelineDesc.outputMerger' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), graphicsPipelineDesc.rasterization != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'graphicsPipelineDesc.rasterization' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), graphicsPipelineDesc.shaderStages != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'graphicsPipelineDesc.shaderStages' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), graphicsPipelineDesc.shaderStageNum > 0, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'graphicsPipelineDesc.shaderStageNum' is 0.");

	/*readonly*/ ShaderDesc* vertexShader = null;
		for (uint32 i = 0; i < graphicsPipelineDesc.shaderStageNum; i++)
		{
			readonly ShaderDesc* shaderDesc = graphicsPipelineDesc.shaderStages + i;

			if (shaderDesc.stage == ShaderStage.VERTEX)
				vertexShader = shaderDesc;

			RETURN_ON_FAILURE!(GetLogger(), shaderDesc.bytecode != null, Result.INVALID_ARGUMENT,
				"Can't create Pipeline: 'graphicsPipelineDesc.shaderStages[{0}].bytecode' is invalid.", i);

			RETURN_ON_FAILURE!(GetLogger(), shaderDesc.size != 0, Result.INVALID_ARGUMENT,
				"Can't create Pipeline: 'graphicsPipelineDesc.shaderStages[{0}].size' is 0.", i);

			RETURN_ON_FAILURE!(GetLogger(), shaderDesc.stage > ShaderStage.ALL && shaderDesc.stage < ShaderStage.COMPUTE, Result.INVALID_ARGUMENT,
				"Can't create Pipeline: 'graphicsPipelineDesc.shaderStages[{0}].stage' is invalid.", i);
		}

		if (graphicsPipelineDesc.inputAssembly != null)
		{
			RETURN_ON_FAILURE!(GetLogger(), graphicsPipelineDesc.inputAssembly.attributes == null || vertexShader != null, Result.INVALID_ARGUMENT,
				"Can't create Pipeline: vertex shader is not specified, but input assembly attributes provided.");

			readonly PipelineLayoutVal pipelineLayout = (PipelineLayoutVal)graphicsPipelineDesc.pipelineLayout;
			readonly PipelineLayoutShaderStageBits stageMask = pipelineLayout.GetPipelineLayoutDesc().stageMask;

			RETURN_ON_FAILURE!(GetLogger(), (stageMask & PipelineLayoutShaderStageBits.VERTEX) != 0, Result.INVALID_ARGUMENT,
				"Can't create Pipeline: vertex stage is not enabled in the pipeline layout.");
		}

		var graphicsPipelineDescImpl = graphicsPipelineDesc;
		graphicsPipelineDescImpl.pipelineLayout = NRI_GET_IMPL_PTR!<IPipelineLayout...>((PipelineLayoutVal)graphicsPipelineDesc.pipelineLayout);

		IPipeline pipelineImpl = null;
		readonly Result result = m_Device.CreateGraphicsPipeline(graphicsPipelineDescImpl, out pipelineImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), pipelineImpl != null, Result.FAILURE, "Unexpected error: 'pipelineImpl' is NULL.");
			pipeline = (IPipeline)Allocate!<PipelineVal>(GetAllocator(), this, pipelineImpl, graphicsPipelineDesc);
		}

		return result;
	}

	public Result CreateComputePipeline(ComputePipelineDesc computePipelineDesc, out IPipeline pipeline)
	{
		pipeline = ?;
		RETURN_ON_FAILURE!(GetLogger(), computePipelineDesc.pipelineLayout != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'computePipelineDesc.pipelineLayout' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), computePipelineDesc.computeShader.bytecode != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'computePipelineDesc.computeShader.bytecode' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), computePipelineDesc.computeShader.size != 0, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'computePipelineDesc.computeShader.size' is 0.");

		RETURN_ON_FAILURE!(GetLogger(), computePipelineDesc.computeShader.stage == ShaderStage.COMPUTE, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'computePipelineDesc.computeShader.stage' must be ShaderStage.COMPUTE.");

		var computePipelineDescImpl = computePipelineDesc;
		computePipelineDescImpl.pipelineLayout = NRI_GET_IMPL_PTR!<IPipelineLayout...>((PipelineLayoutVal)computePipelineDesc.pipelineLayout);

		IPipeline pipelineImpl = null;
		readonly Result result = m_Device.CreateComputePipeline(computePipelineDescImpl, out pipelineImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), pipelineImpl != null, Result.FAILURE, "Unexpected error: 'pipelineImpl' is NULL.");
			pipeline = (IPipeline)Allocate!<PipelineVal>(GetAllocator(), this, pipelineImpl, computePipelineDesc);
		}

		return result;
	}

	public Result CreateRayTracingPipeline(RayTracingPipelineDesc pipelineDesc, out IPipeline pipeline)
	{
		pipeline = ?;
		RETURN_ON_FAILURE!(GetLogger(), pipelineDesc.pipelineLayout != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'pipelineDesc.pipelineLayout' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), pipelineDesc.shaderLibrary != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'pipelineDesc.shaderLibrary' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), pipelineDesc.shaderGroupDescs != null, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'pipelineDesc.shaderGroupDescs' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), pipelineDesc.shaderGroupDescNum != 0, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'pipelineDesc.shaderGroupDescNum' is 0.");

		RETURN_ON_FAILURE!(GetLogger(), pipelineDesc.recursionDepthMax != 0, Result.INVALID_ARGUMENT,
			"Can't create Pipeline: 'pipelineDesc.recursionDepthMax' is 0.");

		for (uint32 i = 0; i < pipelineDesc.shaderLibrary.shaderNum; i++)
		{
			readonly ref ShaderDesc shaderDesc = ref pipelineDesc.shaderLibrary.shaderDescs[i];

			RETURN_ON_FAILURE!(GetLogger(), shaderDesc.bytecode != null, Result.INVALID_ARGUMENT,
				"Can't create Pipeline: 'pipelineDesc.shaderLibrary.shaderDescs[{0}].bytecode' is invalid.", i);

			RETURN_ON_FAILURE!(GetLogger(), shaderDesc.size != 0, Result.INVALID_ARGUMENT,
				"Can't create Pipeline: 'pipelineDesc.shaderLibrary.shaderDescs[{0}].size' is 0.", i);

			RETURN_ON_FAILURE!(GetLogger(), shaderDesc.stage > ShaderStage.COMPUTE && shaderDesc.stage < ShaderStage.MAX_NUM, Result.INVALID_ARGUMENT,
				"Can't create Pipeline: 'pipelineDesc.shaderLibrary.shaderDescs[{0}].stage' is invalid.", i);
		}

		var pipelineDescImpl = pipelineDesc;
		pipelineDescImpl.pipelineLayout = NRI_GET_IMPL_PTR!<IPipelineLayout...>((PipelineLayoutVal)pipelineDesc.pipelineLayout);

		IPipeline pipelineImpl = null;
		readonly Result result = m_Device.CreateRayTracingPipeline(pipelineDescImpl, out pipelineImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), pipelineImpl != null, Result.FAILURE, "Unexpected error: 'pipelineImpl' is NULL.");
			pipeline = (IPipeline)Allocate!<PipelineVal>(GetAllocator(), this, pipelineImpl);
		}

		return result;
	}

	public Result CreateFrameBuffer(FrameBufferDesc frameBufferDesc, out IFrameBuffer frameBuffer)
	{
		frameBuffer = ?;
		if (frameBufferDesc.colorAttachmentNum > 0)
		{
			RETURN_ON_FAILURE!(GetLogger(), frameBufferDesc.colorAttachments != null, Result.INVALID_ARGUMENT,
				"Can't create FrameBuffer: 'frameBufferDesc.colorAttachments' is invalid.");

			for (uint32 i = 0; i < frameBufferDesc.colorAttachmentNum; i++)
			{
				DescriptorVal descriptorVal = (DescriptorVal)frameBufferDesc.colorAttachments[i];

				RETURN_ON_FAILURE!(GetLogger(), descriptorVal.IsColorAttachment(), Result.INVALID_ARGUMENT,
					"Can't create FrameBuffer: 'frameBufferDesc.colorAttachments[{0}]' is not a color attachment descriptor.", i);
			}
		}

		if (frameBufferDesc.depthStencilAttachment != null)
		{
			DescriptorVal descriptorVal = (DescriptorVal)frameBufferDesc.depthStencilAttachment;
			RETURN_ON_FAILURE!(GetLogger(), descriptorVal.IsDepthStencilAttachment(), Result.INVALID_ARGUMENT,
				"Can't create FrameBuffer: 'frameBufferDesc.depthStencilAttachment' is not a depth stencil attachment descriptor.");
		}

		var frameBufferDescImpl = frameBufferDesc;
		if (frameBufferDesc.depthStencilAttachment != null)
			frameBufferDescImpl.depthStencilAttachment = NRI_GET_IMPL_PTR!<IDescriptor...>((DescriptorVal)frameBufferDesc.depthStencilAttachment);
		if (frameBufferDesc.colorAttachmentNum > 0)
		{
			frameBufferDescImpl.colorAttachments = STACK_ALLOC!<IDescriptor>(frameBufferDesc.colorAttachmentNum);
			for (uint32 i = 0; i < frameBufferDesc.colorAttachmentNum; i++)
				((IDescriptor*)frameBufferDescImpl.colorAttachments)[i] = NRI_GET_IMPL_PTR!<IDescriptor...>((DescriptorVal)frameBufferDesc.colorAttachments[i]);
		}

		IFrameBuffer frameBufferImpl = null;
		readonly Result result = m_Device.CreateFrameBuffer(frameBufferDescImpl, out frameBufferImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), frameBufferImpl != null, Result.FAILURE, "Unexpected error: 'frameBufferImpl' is NULL!");
			frameBuffer = (IFrameBuffer)Allocate!<FrameBufferVal>(GetAllocator(), this, frameBufferImpl);
		}

		return result;
	}

	public Result CreateQueryPool(QueryPoolDesc queryPoolDesc, out IQueryPool queryPool)
	{
		queryPool = ?;
		RETURN_ON_FAILURE!(GetLogger(), queryPoolDesc.queryType < QueryType.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create QueryPool: 'queryPoolDesc.queryType' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), queryPoolDesc.capacity > 0, Result.INVALID_ARGUMENT,
			"Can't create QueryPool: 'queryPoolDesc.capacity' is 0.");

		IQueryPool queryPoolImpl = null;
		readonly Result result = m_Device.CreateQueryPool(queryPoolDesc, out queryPoolImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), queryPoolImpl != null, Result.FAILURE, "Unexpected error: 'queryPoolImpl' is NULL!");
			queryPool = (IQueryPool)Allocate!<QueryPoolVal>(GetAllocator(), this, queryPoolImpl, queryPoolDesc.queryType,
				queryPoolDesc.capacity);
		}

		return result;
	}

	public Result CreateFence(uint64 initialValue, out IFence fence)
	{
		fence = ?;
		IFence fenceImpl;
		readonly Result result = m_Device.CreateFence(initialValue, out fenceImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), fenceImpl != null, Result.FAILURE, "Unexpected error: 'fenceImpl' is NULL!");
			fence = (IFence)Allocate!<FenceVal>(GetAllocator(), this, fenceImpl);
		}

		return result;
	}

	public Result CreateSwapChain(SwapChainDesc swapChainDesc, out ISwapChain swapChain)
	{
		swapChain = ?;
		RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.commandQueue != null, Result.INVALID_ARGUMENT,
			"Can't create SwapChain: 'swapChainDesc.commandQueue' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.windowSystemType < WindowSystemType.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create SwapChain: 'swapChainDesc.windowSystemType' is invalid.");

		if (swapChainDesc.windowSystemType == WindowSystemType.WINDOWS)
		{
			RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.window.windows.hwnd != null, Result.INVALID_ARGUMENT,
				"Can't create SwapChain: 'swapChainDesc.window.windows.hwnd' is invalid.");
		}
		else if (swapChainDesc.windowSystemType == WindowSystemType.X11)
		{
			RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.window.x11.dpy != null, Result.INVALID_ARGUMENT,
				"Can't create SwapChain: 'swapChainDesc.window.x11.dpy' is invalid.");
			RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.window.x11.window != 0, Result.INVALID_ARGUMENT,
				"Can't create SwapChain: 'swapChainDesc.window.x11.window' is invalid.");
		}
		else if (swapChainDesc.windowSystemType == WindowSystemType.WAYLAND)
		{
			RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.window.wayland.display != null, Result.INVALID_ARGUMENT,
				"Can't create SwapChain: 'swapChainDesc.window.wayland.display' is invalid.");
			RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.window.wayland.surface != null, Result.INVALID_ARGUMENT,
				"Can't create SwapChain: 'swapChainDesc.window.wayland.surface' is invalid.");
		}

		RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.width != 0, Result.INVALID_ARGUMENT,
			"Can't create SwapChain: 'swapChainDesc.width' is 0.");

		RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.height != 0, Result.INVALID_ARGUMENT,
			"Can't create SwapChain: 'swapChainDesc.height' is 0.");

		RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.textureNum > 0, Result.INVALID_ARGUMENT,
			"Can't create SwapChain: 'swapChainDesc.textureNum' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), swapChainDesc.format < SwapChainFormat.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't create SwapChain: 'swapChainDesc.format' is invalid.");

		var swapChainDescImpl = swapChainDesc;
		swapChainDescImpl.commandQueue = NRI_GET_IMPL_PTR!<ICommandQueue...>((CommandQueueVal)swapChainDesc.commandQueue);

		ISwapChain swapChainImpl;
		readonly Result result = m_Device.CreateSwapChain(swapChainDescImpl, out swapChainImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), swapChainImpl != null, Result.FAILURE, "Unexpected error: 'swapChainImpl' is NULL.");
			swapChain = (ISwapChain)Allocate!<SwapChainVal>(GetAllocator(), this, swapChainImpl, swapChainDesc);
		}

		return result;
	}

	public Result CreateAccelerationStructure(AccelerationStructureDesc accelerationStructureDesc, out IAccelerationStructure accelerationStructure)
	{
		accelerationStructure = ?;
		RETURN_ON_FAILURE!(GetLogger(), accelerationStructureDesc.instanceOrGeometryObjectNum != 0, Result.INVALID_ARGUMENT,
			"Can't create AccelerationStructure: 'accelerationStructureDesc.instanceOrGeometryObjectNum' is 0.");

		AccelerationStructureDesc accelerationStructureDescImpl = accelerationStructureDesc;

		List<GeometryObject> objectImplArray = Allocate!<List<GeometryObject>>(GetAllocator());
		defer { Deallocate!(GetAllocator(), objectImplArray); }
		if (accelerationStructureDesc.type == AccelerationStructureType.BOTTOM_LEVEL)
		{
			readonly uint32 geometryObjectNum = accelerationStructureDesc.instanceOrGeometryObjectNum;
			objectImplArray.Resize(geometryObjectNum);
			ConvertGeometryObjectsVal(objectImplArray.Ptr, accelerationStructureDesc.geometryObjects, geometryObjectNum);
			accelerationStructureDescImpl.geometryObjects = objectImplArray.Ptr;
		}

		IAccelerationStructure accelerationStructureImpl = null;
		readonly Result result = m_Device.CreateAccelerationStructure(accelerationStructureDescImpl, out accelerationStructureImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), accelerationStructureImpl != null, Result.FAILURE, "Unexpected error: 'accelerationStructureImpl' is NULL.");
			accelerationStructure = (IAccelerationStructure)Allocate!<AccelerationStructureVal>(GetAllocator(), this, accelerationStructureImpl, false);
		}

		return result;
	}

	public void DestroyCommandAllocator(ICommandAllocator commandAllocator)
	{
		m_Device.DestroyCommandAllocator(NRI_GET_IMPL_REF!<ICommandAllocator...>((CommandAllocatorVal)commandAllocator));
		Deallocate!(GetAllocator(), (CommandAllocatorVal)commandAllocator);
	}

	public void DestroyCommandBuffer(ICommandBuffer commandBuffer)
	{
		m_Device.DestroyCommandBuffer(NRI_GET_IMPL_REF!<ICommandBuffer...>((CommandBufferVal)commandBuffer));
		Deallocate!(GetAllocator(), (CommandBufferVal)commandBuffer);
	}

	public void DestroyDescriptorPool(IDescriptorPool descriptorPool)
	{
		m_Device.DestroyDescriptorPool(NRI_GET_IMPL_REF!<IDescriptorPool...>((DescriptorPoolVal)descriptorPool));
		Deallocate!(GetAllocator(), (DescriptorPoolVal)descriptorPool);
	}

	public void DestroyBuffer(IBuffer buffer)
	{
		m_Device.DestroyBuffer(NRI_GET_IMPL_REF!<IBuffer...>((BufferVal)buffer));
		Deallocate!(GetAllocator(), (BufferVal)buffer);
	}

	public void DestroyTexture(ITexture texture)
	{
		m_Device.DestroyTexture(NRI_GET_IMPL_REF!<ITexture...>((TextureVal)texture));
		Deallocate!(GetAllocator(), (TextureVal)texture);
	}

	public void DestroyDescriptor(IDescriptor descriptor)
	{
		m_Device.DestroyDescriptor(NRI_GET_IMPL_REF!<IDescriptor...>((DescriptorVal)descriptor));
		Deallocate!(GetAllocator(), (DescriptorVal)descriptor);
	}

	public void DestroyPipelineLayout(IPipelineLayout pipelineLayout)
	{
		m_Device.DestroyPipelineLayout(NRI_GET_IMPL_REF!<IPipelineLayout...>((PipelineLayoutVal)pipelineLayout));
		Deallocate!(GetAllocator(), (PipelineLayoutVal)pipelineLayout);
	}

	public void DestroyPipeline(IPipeline pipeline)
	{
		m_Device.DestroyPipeline(NRI_GET_IMPL_REF!<IPipeline...>((PipelineVal)pipeline));
		Deallocate!(GetAllocator(), (PipelineVal)pipeline);
	}

	public void DestroyFrameBuffer(IFrameBuffer frameBuffer)
	{
		m_Device.DestroyFrameBuffer(NRI_GET_IMPL_REF!<IFrameBuffer...>((FrameBufferVal)frameBuffer));
		Deallocate!(GetAllocator(), (FrameBufferVal)frameBuffer);
	}

	public void DestroyQueryPool(IQueryPool queryPool)
	{
		m_Device.DestroyQueryPool(NRI_GET_IMPL_REF!<IQueryPool...>((QueryPoolVal)queryPool));
		Deallocate!(GetAllocator(), (QueryPoolVal)queryPool);
	}

	public void DestroyFence(IFence fence)
	{
		m_Device.DestroyFence(NRI_GET_IMPL_REF!<IFence...>((FenceVal)fence));
		Deallocate!(GetAllocator(), (FenceVal)fence);
	}

	public void DestroySwapChain(ISwapChain swapChain)
	{
		m_Device.DestroySwapChain(NRI_GET_IMPL_REF!<ISwapChain...>((SwapChainVal)swapChain));
		Deallocate!(GetAllocator(), (SwapChainVal)swapChain);
	}

	public void DestroyAccelerationStructure(IAccelerationStructure accelerationStructure)
	{
		Deallocate!(GetAllocator(), (AccelerationStructureVal)accelerationStructure);
	}

	public Result AllocateMemory(uint32 physicalDeviceMask, MemoryType memoryType, uint64 size, out IMemory memory)
	{
		memory = ?;
		RETURN_ON_FAILURE!(GetLogger(), size > 0, Result.INVALID_ARGUMENT,
			"Can't allocate Memory: 'size' is 0.");

		bool hasMemoryType = false;
		MemoryLocation memoryLocation = .MAX_NUM;
		using (m_Monitor.Enter())
		{
			if (m_MemoryTypeMap.ContainsKey(memoryType))
			{
				hasMemoryType = true;
				memoryLocation = m_MemoryTypeMap[memoryType];
			}
		}

		RETURN_ON_FAILURE!(GetLogger(), hasMemoryType, Result.FAILURE,
			"Can't allocate Memory: 'memoryType' is invalid.");

		IMemory memoryImpl;
		readonly Result result = m_Device.AllocateMemory(physicalDeviceMask, memoryType, size, out memoryImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(GetLogger(), memoryImpl != null, Result.FAILURE, "Unexpected error: 'memoryImpl' is NULL!");
			memory = (IMemory)Allocate!<MemoryVal>(GetAllocator(), this, memoryImpl, size, memoryLocation);
		}

		return result;
	}

	public Result BindBufferMemory(BufferMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum)
	{
		if (memoryBindingDescNum == 0)
			return Result.SUCCESS;

		RETURN_ON_FAILURE!(GetLogger(), memoryBindingDescs != null, Result.INVALID_ARGUMENT,
			"Can't bind memory to buffers: 'memoryBindingDescs' is invalid.");

		BufferMemoryBindingDesc* memoryBindingDescsImpl = STACK_ALLOC!<BufferMemoryBindingDesc>(memoryBindingDescNum);

		for (uint32 i = 0; i < memoryBindingDescNum; i++)
		{
			ref BufferMemoryBindingDesc destDesc = ref memoryBindingDescsImpl[i];
			readonly ref BufferMemoryBindingDesc srcDesc = ref memoryBindingDescs[i];

			RETURN_ON_FAILURE!(GetLogger(), srcDesc.buffer != null, Result.INVALID_ARGUMENT,
				"Can't bind memory to buffers: 'memoryBindingDescs[{0}].buffer' is invalid.", i);
			RETURN_ON_FAILURE!(GetLogger(), srcDesc.memory != null, Result.INVALID_ARGUMENT,
				"Can't bind memory to buffers: 'memoryBindingDescs[{0}].memory' is invalid.", i);

			MemoryVal memory = (MemoryVal)srcDesc.memory;
			BufferVal buffer = (BufferVal)srcDesc.buffer;

			RETURN_ON_FAILURE!(GetLogger(), !buffer.IsBoundToMemory(), Result.INVALID_ARGUMENT,
				"Can't bind memory to buffers: 'memoryBindingDescs[{0}].buffer' is already bound to memory.", i);

			// Skip validation if memory has been created from GAPI object using a wrapper extension
			if (memory.GetMemoryLocation() == MemoryLocation.MAX_NUM)
				continue;

			MemoryDesc memoryDesc = .();
			buffer.GetMemoryInfo(memory.GetMemoryLocation(), ref memoryDesc);

			RETURN_ON_FAILURE!(GetLogger(), !memoryDesc.mustBeDedicated || srcDesc.offset == 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to buffers: 'memoryBindingDescs[{0}].offset' must be zero for dedicated allocation.", i);

			RETURN_ON_FAILURE!(GetLogger(), memoryDesc.alignment != 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to buffers: 'memoryBindingDescs[{0}].alignment' can't be zero.", i);

			RETURN_ON_FAILURE!(GetLogger(), srcDesc.offset % memoryDesc.alignment == 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to buffers: 'memoryBindingDescs[{0}].offset' is misaligned.", i);

			readonly uint64 rangeMax = srcDesc.offset + memoryDesc.size;
			readonly bool memorySizeIsUnknown = memory.GetSize() == 0;

			RETURN_ON_FAILURE!(GetLogger(), memorySizeIsUnknown || rangeMax <= memory.GetSize(), Result.INVALID_ARGUMENT,
				"Can't bind memory to buffers: 'memoryBindingDescs[{0}].offset' is invalid.", i);

			destDesc = srcDesc;
			destDesc.memory = memory.GetImpl();
			destDesc.buffer = buffer.GetImpl();
		}

		readonly Result result = m_Device.BindBufferMemory(memoryBindingDescsImpl, memoryBindingDescNum);

		if (result == Result.SUCCESS)
		{
			for (uint32 i = 0; i < memoryBindingDescNum; i++)
			{
				MemoryVal memory = (MemoryVal)memoryBindingDescs[i].memory;
				memory.BindBuffer((BufferVal)memoryBindingDescs[i].buffer);
			}
		}

		return result;
	}

	public Result BindTextureMemory(TextureMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum)
	{
		RETURN_ON_FAILURE!(GetLogger(), memoryBindingDescs != null || memoryBindingDescNum == 0, Result.INVALID_ARGUMENT,
			"Can't bind memory to textures: 'memoryBindingDescs' is a NULL.");

		TextureMemoryBindingDesc* memoryBindingDescsImpl = STACK_ALLOC!<TextureMemoryBindingDesc>(memoryBindingDescNum);

		for (uint32 i = 0; i < memoryBindingDescNum; i++)
		{
			ref TextureMemoryBindingDesc destDesc = ref memoryBindingDescsImpl[i];
			readonly ref TextureMemoryBindingDesc srcDesc = ref memoryBindingDescs[i];

			RETURN_ON_FAILURE!(GetLogger(), srcDesc.texture != null, Result.INVALID_ARGUMENT,
				"Can't bind memory to textures: 'memoryBindingDescs[{0}].texture' is invalid.", i);
			RETURN_ON_FAILURE!(GetLogger(), srcDesc.memory != null, Result.INVALID_ARGUMENT,
				"Can't bind memory to textures: 'memoryBindingDescs[{0}].memory' is invalid.", i);

			MemoryVal memory = (MemoryVal)srcDesc.memory;
			TextureVal texture = (TextureVal)srcDesc.texture;

			RETURN_ON_FAILURE!(GetLogger(), !texture.IsBoundToMemory(), Result.INVALID_ARGUMENT,
				"Can't bind memory to textures: 'memoryBindingDescs[{0}].texture' is already bound to memory.", i);

			// Skip validation if memory has been created from GAPI object using a wrapper extension
			if (memory.GetMemoryLocation() == MemoryLocation.MAX_NUM)
				continue;

			MemoryDesc memoryDesc = .();
			texture.GetMemoryInfo(memory.GetMemoryLocation(), ref memoryDesc);

			RETURN_ON_FAILURE!(GetLogger(), !memoryDesc.mustBeDedicated || srcDesc.offset == 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to textures: 'memoryBindingDescs[{0}].offset' must be zero for dedicated allocation.", i);

			RETURN_ON_FAILURE!(GetLogger(), memoryDesc.alignment != 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to textures: 'memoryBindingDescs[{0}].alignment' can't be zero.", i);

			RETURN_ON_FAILURE!(GetLogger(), srcDesc.offset % memoryDesc.alignment == 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to textures: 'memoryBindingDescs[{0}].offset' is misaligned.", i);

			readonly uint64 rangeMax = srcDesc.offset + memoryDesc.size;
			readonly bool memorySizeIsUnknown = memory.GetSize() == 0;

			RETURN_ON_FAILURE!(GetLogger(), memorySizeIsUnknown || rangeMax <= memory.GetSize(), Result.INVALID_ARGUMENT,
				"Can't bind memory to textures: 'memoryBindingDescs[{0}].offset' is invalid.", i);

			destDesc = srcDesc;
			destDesc.memory = memory.GetImpl();
			destDesc.texture = texture.GetImpl();
		}

		readonly Result result = m_Device.BindTextureMemory(memoryBindingDescsImpl, memoryBindingDescNum);

		if (result == Result.SUCCESS)
		{
			for (uint32 i = 0; i < memoryBindingDescNum; i++)
			{
				MemoryVal memory = (MemoryVal)memoryBindingDescs[i].memory;
				memory.BindTexture((TextureVal)memoryBindingDescs[i].texture);
			}
		}

		return result;
	}

	public Result BindAccelerationStructureMemory(AccelerationStructureMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum)
	{
		if (memoryBindingDescNum == 0)
			return Result.SUCCESS;

		RETURN_ON_FAILURE!(GetLogger(), memoryBindingDescs != null, Result.INVALID_ARGUMENT,
			"Can't bind memory to acceleration structures: 'memoryBindingDescs' is invalid.");

		AccelerationStructureMemoryBindingDesc* memoryBindingDescsImpl = STACK_ALLOC!<AccelerationStructureMemoryBindingDesc>(memoryBindingDescNum);
		for (uint32 i = 0; i < memoryBindingDescNum; i++)
		{
			ref AccelerationStructureMemoryBindingDesc destDesc = ref memoryBindingDescsImpl[i];
			readonly ref AccelerationStructureMemoryBindingDesc srcDesc = ref memoryBindingDescs[i];

			MemoryVal memory = (MemoryVal)srcDesc.memory;
			AccelerationStructureVal accelerationStructure = (AccelerationStructureVal)srcDesc.accelerationStructure;

			RETURN_ON_FAILURE!(GetLogger(), !accelerationStructure.IsBoundToMemory(), Result.INVALID_ARGUMENT,
				"Can't bind memory to acceleration structures: 'memoryBindingDescs[{0}].accelerationStructure' is already bound to memory.", i);

			MemoryDesc memoryDesc = .();
			accelerationStructure.GetMemoryInfo(ref memoryDesc);

			RETURN_ON_FAILURE!(GetLogger(), !memoryDesc.mustBeDedicated || srcDesc.offset == 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to acceleration structures: 'memoryBindingDescs[{0}].offset' must be zero for dedicated allocation.", i);

			RETURN_ON_FAILURE!(GetLogger(), memoryDesc.alignment != 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to acceleration structures: 'memoryBindingDescs[{0}].alignment' can't be zero.", i);

			RETURN_ON_FAILURE!(GetLogger(), srcDesc.offset % memoryDesc.alignment == 0, Result.INVALID_ARGUMENT,
				"Can't bind memory to acceleration structures: 'memoryBindingDescs[{0}].offset' is misaligned.", i);

			readonly uint64 rangeMax = srcDesc.offset + memoryDesc.size;
			readonly bool memorySizeIsUnknown = memory.GetSize() == 0;

			RETURN_ON_FAILURE!(GetLogger(), memorySizeIsUnknown || rangeMax <= memory.GetSize(), Result.INVALID_ARGUMENT,
				"Can't bind memory to acceleration structures: 'memoryBindingDescs[{0}].offset' is invalid.", i);

			destDesc = srcDesc;
			destDesc.memory = memory.GetImpl();
			destDesc.accelerationStructure = accelerationStructure.GetImpl();
		}

		readonly Result result = m_Device.BindAccelerationStructureMemory(memoryBindingDescsImpl, memoryBindingDescNum);

		if (result == Result.SUCCESS)
		{
			for (uint32 i = 0; i < memoryBindingDescNum; i++)
			{
				MemoryVal memory = (MemoryVal)memoryBindingDescs[i].memory;
				memory.BindAccelerationStructure((AccelerationStructureVal)memoryBindingDescs[i].accelerationStructure);
			}
		}

		return result;
	}

	public void FreeMemory(IMemory memory)
	{
		MemoryVal memoryVal = (MemoryVal)memory;

		if (memoryVal.HasBoundResources())
		{
			memoryVal.ReportBoundResources();
			REPORT_ERROR(GetLogger(), "Can't free Memory: some resources are still bound to the memory.");
			return;
		}

		m_Device.FreeMemory(NRI_GET_IMPL_REF!<IMemory...>((MemoryVal)memory));
		Deallocate!(GetAllocator(), (MemoryVal)memory);
	}

	public FormatSupportBits GetFormatSupport(Format format)
	{
		return m_Device.GetFormatSupport(format);
	}

	public Result GetDisplays(Display* displays, ref uint32 displayNum)
	{
		RETURN_ON_FAILURE!(GetLogger(), displayNum == 0 || displays != null, Result.INVALID_ARGUMENT,
			"Can't get displays: 'displays' is invalid.");

		return m_Device.GetDisplays(displays, ref displayNum);
	}

	public Result GetDisplaySize(ref Display display, ref uint16 width, ref uint16 height)
	{
		return m_Device.GetDisplaySize(ref display, ref width, ref height);
	}


	public uint32 CalculateAllocationNumber(ResourceGroupDesc resourceGroupDesc)
	{
		RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.memoryLocation < MemoryLocation.MAX_NUM, 0,
			"Can't calculate the number of allocations: 'resourceGroupDesc.memoryLocation' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.bufferNum == 0 || resourceGroupDesc.buffers != null, 0,
			"Can't calculate the number of allocations: 'resourceGroupDesc.buffers' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.textureNum == 0 || resourceGroupDesc.textures != null, 0,
			"Can't calculate the number of allocations: 'resourceGroupDesc.textures' is invalid.");

		IBuffer* buffersImpl = STACK_ALLOC!<IBuffer>(resourceGroupDesc.bufferNum);

		for (uint32 i = 0; i < resourceGroupDesc.bufferNum; i++)
		{
			RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.buffers[i] != null, 0,
				"Can't calculate the number of allocations: 'resourceGroupDesc.buffers[{0}]' is invalid.", i);

			BufferVal bufferVal = (BufferVal)resourceGroupDesc.buffers[i];
			buffersImpl[i] = (bufferVal.GetImpl());
		}

		ITexture* texturesImpl = STACK_ALLOC!<ITexture>(resourceGroupDesc.textureNum);

		for (uint32 i = 0; i < resourceGroupDesc.textureNum; i++)
		{
			RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.textures[i] != null, 0,
				"Can't calculate the number of allocations: 'resourceGroupDesc.textures[{0}]' is invalid.", i);

			TextureVal textureVal = (TextureVal)resourceGroupDesc.textures[i];
			texturesImpl[i] = (textureVal.GetImpl());
		}

		ResourceGroupDesc resourceGroupDescImpl = resourceGroupDesc;
		resourceGroupDescImpl.buffers = buffersImpl;
		resourceGroupDescImpl.textures = texturesImpl;

		return m_Device.CalculateAllocationNumber(resourceGroupDescImpl);
	}

	public Result AllocateAndBindMemory(ResourceGroupDesc resourceGroupDesc, IMemory* allocations)
	{
		RETURN_ON_FAILURE!(GetLogger(), allocations != null, Result.INVALID_ARGUMENT,
			"Can't allocate and bind memory: 'allocations' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.memoryLocation < MemoryLocation.MAX_NUM, Result.INVALID_ARGUMENT,
			"Can't allocate and bind memory: 'resourceGroupDesc.memoryLocation' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.bufferNum == 0 || resourceGroupDesc.buffers != null, Result.INVALID_ARGUMENT,
			"Can't allocate and bind memory: 'resourceGroupDesc.buffers' is invalid.");

		RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.textureNum == 0 || resourceGroupDesc.textures != null, Result.INVALID_ARGUMENT,
			"Can't allocate and bind memory: 'resourceGroupDesc.textures' is invalid.");

		IBuffer* buffersImpl = STACK_ALLOC!<IBuffer>(resourceGroupDesc.bufferNum);

		for (uint32 i = 0; i < resourceGroupDesc.bufferNum; i++)
		{
			RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.buffers[i] != null, Result.INVALID_ARGUMENT,
				"Can't allocate and bind memory: 'resourceGroupDesc.buffers[{0}]' is invalid.", i);

			BufferVal bufferVal = (BufferVal)resourceGroupDesc.buffers[i];
			buffersImpl[i] = (bufferVal.GetImpl());
		}

		ITexture* texturesImpl = STACK_ALLOC!<ITexture>(resourceGroupDesc.textureNum);

		for (uint32 i = 0; i < resourceGroupDesc.textureNum; i++)
		{
			RETURN_ON_FAILURE!(GetLogger(), resourceGroupDesc.textures[i] != null, Result.INVALID_ARGUMENT,
				"Can't allocate and bind memory: 'resourceGroupDesc.textures[{0}]' is invalid.", i);

			TextureVal textureVal = (TextureVal)resourceGroupDesc.textures[i];
			texturesImpl[i] = (textureVal.GetImpl());
		}

		readonly uint allocationNum = CalculateAllocationNumber(resourceGroupDesc);

		ResourceGroupDesc resourceGroupDescImpl = resourceGroupDesc;
		resourceGroupDescImpl.buffers = buffersImpl;
		resourceGroupDescImpl.textures = texturesImpl;

		readonly Result result = m_Device.AllocateAndBindMemory(resourceGroupDescImpl, allocations);

		if (result == Result.SUCCESS)
		{
			for (uint32 i = 0; i < resourceGroupDesc.bufferNum; i++)
			{
				BufferVal bufferVal = (BufferVal)resourceGroupDesc.buffers[i];
				bufferVal.SetBoundToMemory();
			}

			for (uint32 i = 0; i < resourceGroupDesc.textureNum; i++)
			{
				TextureVal textureVal = (TextureVal)resourceGroupDesc.textures[i];
				textureVal.SetBoundToMemory();
			}

			for (uint32 i = 0; i < allocationNum; i++)
			{
				RETURN_ON_FAILURE!(GetLogger(), allocations[i] != null, Result.FAILURE, "Unexpected error: 'memoryImpl' is invalid");
				allocations[i] = (IMemory)Allocate!<MemoryVal>(GetAllocator(), this, allocations[i], 0, resourceGroupDesc.memoryLocation);
			}
		}

		return result;
	}
}