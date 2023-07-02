using Bulkan;
using System;
namespace Sedulous.RHI.Vulkan;

class PipelineVK : IPipeline
{
	private readonly DeviceVK m_Device;
	private VkPipeline m_Handle = .Null;
	private VkPipelineBindPoint m_BindPoint = (VkPipelineBindPoint)0;
	private VkRenderPass m_RenderPass = .Null;
	private bool m_OwnsNativeObjects = false;

	[Inline] public this(DeviceVK device)
		{ m_Device = device; }

	public ~this()
	{
		if (!m_OwnsNativeObjects)
			return;

		if (m_Handle != .Null)
			VulkanNative.vkDestroyPipeline(m_Device, m_Handle, m_Device.GetAllocationCallbacks());

		if (m_RenderPass != .Null)
			VulkanNative.vkDestroyRenderPass(m_Device, m_RenderPass, m_Device.GetAllocationCallbacks());
	}

	[Inline] public static implicit operator VkPipeline(Self self)
		{ return self.m_Handle; }

	[Inline] public DeviceVK GetDevice()
		{ return m_Device; }

	[Inline] public VkPipelineBindPoint GetBindPoint()
		{ return m_BindPoint; }


	public Result Create(GraphicsPipelineDesc graphicsPipelineDesc)
	{
		m_OwnsNativeObjects = true;
		m_BindPoint = .VK_PIPELINE_BIND_POINT_GRAPHICS;

		readonly PipelineLayoutVK pipelineLayoutVK = (PipelineLayoutVK)graphicsPipelineDesc.pipelineLayout;

		Result result = CreateRenderPass(graphicsPipelineDesc.outputMerger, graphicsPipelineDesc.rasterization);
		if (result != Result.SUCCESS)
			return result;

		VkPipelineVertexInputStateCreateInfo vertexInputState = .();
		VkPipelineInputAssemblyStateCreateInfo inputAssemblyState = .();
		VkPipelineTessellationStateCreateInfo tessellationState = .();
		VkPipelineViewportStateCreateInfo viewportState = .();
		VkPipelineRasterizationConservativeStateCreateInfoEXT consetvativeRasterizationState = .();
		VkPipelineRasterizationStateCreateInfo rasterizationState = .();
		VkPipelineMultisampleStateCreateInfo multisampleState = .();
		VkPipelineDepthStencilStateCreateInfo depthStencilState = .();
		VkPipelineColorBlendStateCreateInfo colorBlendState = .();
		VkPipelineDynamicStateCreateInfo dynamicState = .();

		VkPipelineShaderStageCreateInfo* stages = STACK_ALLOC!<VkPipelineShaderStageCreateInfo>(graphicsPipelineDesc.shaderStageNum);
		VkShaderModule* modules = STACK_ALLOC!<VkShaderModule>(graphicsPipelineDesc.shaderStageNum);
		VkShaderModule* modulesBegin = modules;

		readonly ref InputAssemblyDesc inputAssembly = ref *graphicsPipelineDesc.inputAssembly;
		vertexInputState.pVertexAttributeDescriptions = STACK_ALLOC!<VkVertexInputAttributeDescription>(inputAssembly.attributeNum);
		vertexInputState.pVertexBindingDescriptions = STACK_ALLOC!<VkVertexInputBindingDescription>(inputAssembly.streamNum);

		if (graphicsPipelineDesc.outputMerger != null)
			colorBlendState.pAttachments = STACK_ALLOC!<VkPipelineColorBlendAttachmentState>(graphicsPipelineDesc.outputMerger.colorNum);

		uint32 sampleMask = graphicsPipelineDesc.rasterization.sampleMask;
		multisampleState.pSampleMask = &sampleMask;

		for (uint32 i = 0; i < graphicsPipelineDesc.shaderStageNum; i++)
		{
			readonly ref ShaderDesc shaderDesc = ref graphicsPipelineDesc.shaderStages[i];
			Result res = SetupShaderStage(ref stages[i], shaderDesc, ref modules);
			if (res != Result.SUCCESS)
				return res;

			stages[i].pName = (shaderDesc.entryPointName == null) ? "main" : shaderDesc.entryPointName;
		}

		FillVertexInputState(graphicsPipelineDesc, ref vertexInputState);
		FillInputAssemblyState(graphicsPipelineDesc, ref inputAssemblyState);
		FillTessellationState(graphicsPipelineDesc, ref tessellationState);
		FillViewportState(graphicsPipelineDesc, ref viewportState);
		FillRasterizationState(graphicsPipelineDesc, ref rasterizationState, ref consetvativeRasterizationState);
		FillMultisampleState(graphicsPipelineDesc, ref multisampleState);
		FillDepthStencilState(graphicsPipelineDesc, ref depthStencilState);
		FillColorBlendState(graphicsPipelineDesc, ref colorBlendState);
		FillDynamicState(ref dynamicState);

		/*readonly*/ VkGraphicsPipelineCreateInfo info = .()
			{
				sType = .VK_STRUCTURE_TYPE_GRAPHICS_PIPELINE_CREATE_INFO,
				pNext = null,
				flags = (VkPipelineCreateFlags)0,
				stageCount = graphicsPipelineDesc.shaderStageNum,
				pStages = stages,
				pVertexInputState = &vertexInputState,
				pInputAssemblyState = &inputAssemblyState,
				pTessellationState = &tessellationState,
				pViewportState = &viewportState,
				pRasterizationState = &rasterizationState,
				pMultisampleState = &multisampleState,
				pDepthStencilState = &depthStencilState,
				pColorBlendState = &colorBlendState,
				pDynamicState = &dynamicState, // TODO: do we need dynamic state?
				layout = pipelineLayoutVK,
				renderPass = m_RenderPass,
				subpass = 0,
				basePipelineHandle = .Null,
				basePipelineIndex = -1
			};

		readonly VkResult vkResult = VulkanNative.vkCreateGraphicsPipelines(m_Device, .Null, 1, &info, m_Device.GetAllocationCallbacks(), &m_Handle);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), vkResult == .VK_SUCCESS, GetReturnCode(vkResult),
			"Can't create a graphics pipeline: vkCreateGraphicsPipelines returned %d.", (int32)vkResult);

		for (uint i = 0; i < graphicsPipelineDesc.shaderStageNum; i++)
			VulkanNative.vkDestroyShaderModule(m_Device, modulesBegin[i], m_Device.GetAllocationCallbacks());

		return Result.SUCCESS;
	}

	public Result Create(ComputePipelineDesc computePipelineDesc)
	{
		m_OwnsNativeObjects = true;
		m_BindPoint = .VK_PIPELINE_BIND_POINT_COMPUTE;

		readonly PipelineLayoutVK pipelineLayoutVK = (PipelineLayoutVK)computePipelineDesc.pipelineLayout;

		/*readonly*/ VkShaderModuleCreateInfo moduleInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO,
				pNext = null,
				flags = /*(VkShaderModuleCreateFlags)*/ 0,
				codeSize = (uint)computePipelineDesc.computeShader.size,
				pCode = (uint32*)computePipelineDesc.computeShader.bytecode
			};

		VkShaderModule module = .Null;
		VkResult result = VulkanNative.vkCreateShaderModule(m_Device, &moduleInfo, m_Device.GetAllocationCallbacks(), &module);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't create a compute pipeline: vkCreateShaderModule returned {0}.", (int32)result);

		VkPipelineShaderStageCreateInfo stage = .()
			{
				sType = .VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO,
				pNext = null,
				flags = (VkPipelineShaderStageCreateFlags)0,
				stage = .VK_SHADER_STAGE_COMPUTE_BIT,
				module = module,
				pName = (computePipelineDesc.computeShader.entryPointName == null) ? "main" : computePipelineDesc.computeShader.entryPointName,
				pSpecializationInfo = null
			};

		/*readonly*/ VkComputePipelineCreateInfo info = .()
			{
				sType = .VK_STRUCTURE_TYPE_COMPUTE_PIPELINE_CREATE_INFO,
				pNext = null,
				flags = (VkPipelineCreateFlags)0,
				stage = stage,
				layout = pipelineLayoutVK,
				basePipelineHandle = .Null,
				basePipelineIndex = -1
			};

		result = VulkanNative.vkCreateComputePipelines(m_Device, .Null, 1, &info, m_Device.GetAllocationCallbacks(), &m_Handle);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't create a compute pipeline: vkCreateComputePipelines returned {0}.", (int32)result);

		VulkanNative.vkDestroyShaderModule(m_Device, module, m_Device.GetAllocationCallbacks());

		return Result.SUCCESS;
	}

	public Result Create(RayTracingPipelineDesc rayTracingPipelineDesc)
	{
		m_OwnsNativeObjects = true;
		m_BindPoint = .VK_PIPELINE_BIND_POINT_RAY_TRACING_KHR;

		readonly PipelineLayoutVK pipelineLayoutVK = (PipelineLayoutVK)rayTracingPipelineDesc.pipelineLayout;

		readonly uint32 stageNum = rayTracingPipelineDesc.shaderLibrary.shaderNum;
		VkPipelineShaderStageCreateInfo* stages = STACK_ALLOC!<VkPipelineShaderStageCreateInfo>(stageNum);
		VkShaderModule* modules = STACK_ALLOC!<VkShaderModule>(stageNum);
		VkShaderModule* modulesBegin = modules;

		for (uint32 i = 0; i < stageNum; i++)
		{
			readonly ref ShaderDesc shaderDesc = ref rayTracingPipelineDesc.shaderLibrary.shaderDescs[i];
			Result result = SetupShaderStage(ref stages[i], shaderDesc, ref modules);
			if (result != Result.SUCCESS)
				return result;

			stages[i].pName = (shaderDesc.entryPointName == null) ? "main" : shaderDesc.entryPointName;
		}

		VkRayTracingShaderGroupCreateInfoKHR* groupArray = STACK_ALLOC!<VkRayTracingShaderGroupCreateInfoKHR>(rayTracingPipelineDesc.shaderGroupDescNum);
		for (uint32 i = 0; i < rayTracingPipelineDesc.shaderGroupDescNum; i++)
		{
			ref VkRayTracingShaderGroupCreateInfoKHR dstGroup = ref groupArray[i];
			readonly ref ShaderGroupDesc srcGroup = ref rayTracingPipelineDesc.shaderGroupDescs[i];

			dstGroup = .() { sType = .VK_STRUCTURE_TYPE_RAY_TRACING_SHADER_GROUP_CREATE_INFO_KHR };
			dstGroup.type = .VK_RAY_TRACING_SHADER_GROUP_TYPE_GENERAL_KHR;
			dstGroup.generalShader = VulkanNative.VK_SHADER_UNUSED_KHR;
			dstGroup.closestHitShader = VulkanNative.VK_SHADER_UNUSED_KHR;
			dstGroup.anyHitShader = VulkanNative.VK_SHADER_UNUSED_KHR;
			dstGroup.intersectionShader = VulkanNative.VK_SHADER_UNUSED_KHR;

			for (uint32 j = 0; j < srcGroup.shaderIndices.Count; j++)
			{
				if (srcGroup.shaderIndices[j] == 0)
					continue;

				readonly uint32 index = srcGroup.shaderIndices[j] - 1;
				readonly ref VkPipelineShaderStageCreateInfo stageInfo = ref stages[index];

				switch (stageInfo.stage)
				{
				case .VK_SHADER_STAGE_RAYGEN_BIT_KHR,
					.VK_SHADER_STAGE_MISS_BIT_KHR,
					.VK_SHADER_STAGE_CALLABLE_BIT_KHR:
					dstGroup.generalShader = index;
					break;

				case .VK_SHADER_STAGE_ANY_HIT_BIT_KHR:
					if (dstGroup.type != .VK_RAY_TRACING_SHADER_GROUP_TYPE_PROCEDURAL_HIT_GROUP_KHR)
						dstGroup.type = .VK_RAY_TRACING_SHADER_GROUP_TYPE_TRIANGLES_HIT_GROUP_KHR;
					dstGroup.anyHitShader = index;
					break;

				case .VK_SHADER_STAGE_CLOSEST_HIT_BIT_KHR:
					if (dstGroup.type != .VK_RAY_TRACING_SHADER_GROUP_TYPE_PROCEDURAL_HIT_GROUP_KHR)
						dstGroup.type = .VK_RAY_TRACING_SHADER_GROUP_TYPE_TRIANGLES_HIT_GROUP_KHR;
					dstGroup.closestHitShader = index;
					break;

				case .VK_SHADER_STAGE_INTERSECTION_BIT_KHR:
					dstGroup.type = .VK_RAY_TRACING_SHADER_GROUP_TYPE_PROCEDURAL_HIT_GROUP_KHR;
					dstGroup.intersectionShader = index;
					break;

				default:
					// already initialized
					break;
				}
			}
		}

		VkRayTracingPipelineCreateInfoKHR createInfo = .() { sType = .VK_STRUCTURE_TYPE_RAY_TRACING_PIPELINE_CREATE_INFO_KHR };

		createInfo.stageCount = stageNum;
		createInfo.pStages = stages;
		createInfo.maxPipelineRayRecursionDepth = rayTracingPipelineDesc.recursionDepthMax;
		createInfo.layout = pipelineLayoutVK;

		createInfo.groupCount = rayTracingPipelineDesc.shaderGroupDescNum;
		createInfo.pGroups = groupArray;

		createInfo.basePipelineIndex = -1;

		readonly VkResult vkResult = VulkanNative.vkCreateRayTracingPipelinesKHR(m_Device, .Null, .Null, 1, &createInfo,
			m_Device.GetAllocationCallbacks(), &m_Handle);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), vkResult == .VK_SUCCESS, GetReturnCode(vkResult),
			"Can't create a ray tracing pipeline: vkCreateRayTracingPipelinesKHR returned {0}.", (int32)vkResult);

		for (uint i = 0; i < stageNum; i++)
			VulkanNative.vkDestroyShaderModule(m_Device, modulesBegin[i], m_Device.GetAllocationCallbacks());

		return Result.SUCCESS;
	}

	public Result CreateGraphics(NRIVkPipeline vkPipeline)
	{
		m_OwnsNativeObjects = false;
		m_Handle = (VkPipeline)vkPipeline;
		m_BindPoint = .VK_PIPELINE_BIND_POINT_GRAPHICS;

		return Result.SUCCESS;
	}

	public Result CreateCompute(NRIVkPipeline vkPipeline)
	{
		m_OwnsNativeObjects = false;
		m_Handle = (VkPipeline)vkPipeline;
		m_BindPoint = .VK_PIPELINE_BIND_POINT_COMPUTE;

		return Result.SUCCESS;
	}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public void SetDebugName(char8* name)
	{
		m_Device.SetDebugNameToTrivialObject(.VK_OBJECT_TYPE_PIPELINE, (uint64)m_Handle, name);
	}

	public Result WriteShaderGroupIdentifiers(uint32 baseShaderGroupIndex, uint32 shaderGroupNum, void* buffer)
	{
		readonly uint dataSize = (uint)(shaderGroupNum * m_Device.GetDesc().rayTracingShaderGroupIdentifierSize);

		readonly VkResult result = VulkanNative.vkGetRayTracingShaderGroupHandlesKHR(m_Device, m_Handle, baseShaderGroupIndex, shaderGroupNum, dataSize, buffer);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't get shader group identifiers: vkGetRayTracingShaderGroupHandlesKHR returned {0}.", (int32)result);

		return Result.SUCCESS;
	}

	private Result SetupShaderStage(ref VkPipelineShaderStageCreateInfo stage, ShaderDesc shaderDesc, ref VkShaderModule* modules)
	{
		/*readonly*/ VkShaderModuleCreateInfo moduleInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_SHADER_MODULE_CREATE_INFO,
				pNext = null,
				flags = /*(VkShaderModuleCreateFlags)*/ 0,
				codeSize = (uint)shaderDesc.size,
				pCode = (uint32*)shaderDesc.bytecode
			};

		VkShaderModule module = .Null;
		readonly VkResult result = VulkanNative.vkCreateShaderModule(m_Device, &moduleInfo, m_Device.GetAllocationCallbacks(), &module);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't create a graphics shader module: vkCreateShaderModule returned {0}.", (int32)result);

		*(modules++) = module;

		stage = .()
			{
				sType = .VK_STRUCTURE_TYPE_PIPELINE_SHADER_STAGE_CREATE_INFO,
				pNext = null,
				flags = (VkPipelineShaderStageCreateFlags)0,
				stage = (VkShaderStageFlags)GetShaderStageFlags(shaderDesc.stage),
				module = module,
				pName = null,
				pSpecializationInfo = null
			};

		return Result.SUCCESS;
	}

	private Result CreateRenderPass(OutputMergerDesc* outputMerger, RasterizationDesc* rasterizationDesc)
	{
		bool hasDepthStencil = false;
		uint32 attachmentNum = 0;
		uint32 colorAttachmentNum = 0;
		VkAttachmentDescription* attachmentDescs = null;
		VkAttachmentReference* colorReferences = null;

		if (outputMerger != null)
		{
			hasDepthStencil = outputMerger.depthStencilFormat != Format.UNKNOWN;
			colorAttachmentNum = outputMerger.colorNum;
			attachmentNum = outputMerger.colorNum + (hasDepthStencil ? 1 : 0);
			attachmentDescs = STACK_ALLOC!<VkAttachmentDescription>(attachmentNum);

			readonly VkSampleCountFlags sampleNum = rasterizationDesc != null ?
				(VkSampleCountFlags)rasterizationDesc.sampleNum : .VK_SAMPLE_COUNT_1_BIT;

			for (uint32 i = 0; i < outputMerger.colorNum; i++)
			{
				attachmentDescs[i] = .()
					{
						flags = (VkAttachmentDescriptionFlags)0,
						format = GetVkFormat(outputMerger.color[i].format),
						samples = sampleNum,
						loadOp = .VK_ATTACHMENT_LOAD_OP_LOAD,
						storeOp = .VK_ATTACHMENT_STORE_OP_STORE,
						stencilLoadOp = .VK_ATTACHMENT_LOAD_OP_LOAD,
						stencilStoreOp = .VK_ATTACHMENT_STORE_OP_STORE,
						initialLayout = .VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
						finalLayout = .VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL
					};
			}

			if (hasDepthStencil)
			{
				attachmentDescs[outputMerger.colorNum] = .()
					{
						flags = (VkAttachmentDescriptionFlags)0,
						format = GetVkFormat(outputMerger.depthStencilFormat),
						samples = sampleNum,
						loadOp = .VK_ATTACHMENT_LOAD_OP_LOAD,
						storeOp = .VK_ATTACHMENT_STORE_OP_STORE,
						stencilLoadOp = .VK_ATTACHMENT_LOAD_OP_LOAD,
						stencilStoreOp = .VK_ATTACHMENT_STORE_OP_STORE,
						initialLayout = .VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
						finalLayout = .VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL
					};
			}

			colorReferences = STACK_ALLOC!<VkAttachmentReference>(outputMerger.colorNum);
			for (uint32 i = 0; i < outputMerger.colorNum; i++)
			{
				colorReferences[i] = .()
					{
						attachment = i,
						layout = .VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL
					};
			}
		}

		/*readonly*/ VkAttachmentReference depthReference = .()
			{
				attachment = colorAttachmentNum,
				layout = .VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL
			};

		/*readonly*/ VkSubpassDescription subpass = .()
			{
				flags = (VkSubpassDescriptionFlags)0,
				pipelineBindPoint = .VK_PIPELINE_BIND_POINT_GRAPHICS,
				inputAttachmentCount = 0,
				pInputAttachments = null,
				colorAttachmentCount = colorAttachmentNum,
				pColorAttachments = colorReferences,
				pResolveAttachments = null,
				pDepthStencilAttachment = hasDepthStencil ? &depthReference : null,
				preserveAttachmentCount = 0,
				pPreserveAttachments = null
			};

		/*readonly*/ VkRenderPassCreateInfo info = .()
			{
				sType = .VK_STRUCTURE_TYPE_RENDER_PASS_CREATE_INFO,
				pNext = null,
				flags = (VkRenderPassCreateFlags)0,
				attachmentCount = attachmentNum,
				pAttachments = attachmentDescs,
				subpassCount = 1,
				pSubpasses = &subpass,
				dependencyCount = 0,
				pDependencies = null
			};

		readonly VkResult result = VulkanNative.vkCreateRenderPass(m_Device, &info, m_Device.GetAllocationCallbacks(), &m_RenderPass);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't create a render pass for a pipeline: vkCreateRenderPass returned {0}.", (int32)result);

		return Result.SUCCESS;
	}

	private void FillVertexInputState(GraphicsPipelineDesc graphicsPipelineDesc, ref VkPipelineVertexInputStateCreateInfo state)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_VERTEX_INPUT_STATE_CREATE_INFO;

		readonly ref InputAssemblyDesc inputAssembly = ref *graphicsPipelineDesc.inputAssembly;
		state.vertexAttributeDescriptionCount = inputAssembly.attributeNum;
		state.vertexBindingDescriptionCount = inputAssembly.streamNum;

		VkVertexInputAttributeDescription* attributes = state.pVertexAttributeDescriptions;
		for (uint32 i = 0; i < inputAssembly.attributeNum; i++)
		{
			readonly ref VertexAttributeDesc attribute_desc = ref inputAssembly.attributes[i];
			attributes[i] = .()
				{
					location = (uint32)i,
					binding = attribute_desc.streamIndex,
					format = GetVkFormat(attribute_desc.format),
					offset = attribute_desc.offset
				};
		}

		VkVertexInputBindingDescription* streams = state.pVertexBindingDescriptions;
		for (uint32 i = 0; i < inputAssembly.streamNum; i++)
		{
			readonly ref VertexStreamDesc stream_desc = ref inputAssembly.streams[i];
			streams[i] = .()
				{
					binding = stream_desc.bindingSlot,
					stride = stream_desc.stride,
					inputRate = (stream_desc.stepRate == VertexStreamStepRate.PER_VERTEX) ? .VK_VERTEX_INPUT_RATE_VERTEX : .VK_VERTEX_INPUT_RATE_INSTANCE
				};
		}
	}

	private void FillInputAssemblyState(GraphicsPipelineDesc graphicsPipelineDesc, ref VkPipelineInputAssemblyStateCreateInfo state)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_INPUT_ASSEMBLY_STATE_CREATE_INFO;

		readonly ref InputAssemblyDesc inputAssembly = ref *graphicsPipelineDesc.inputAssembly;
		state.topology = GetTopology(inputAssembly.topology);
		state.primitiveRestartEnable = inputAssembly.primitiveRestart != PrimitiveRestart.DISABLED;
	}

	private void FillTessellationState(GraphicsPipelineDesc graphicsPipelineDesc, ref VkPipelineTessellationStateCreateInfo state)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_TESSELLATION_STATE_CREATE_INFO;
		state.patchControlPoints = graphicsPipelineDesc.inputAssembly.tessControlPointNum;
	}

	private void FillViewportState(GraphicsPipelineDesc graphicsPipelineDesc, ref VkPipelineViewportStateCreateInfo state)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_VIEWPORT_STATE_CREATE_INFO;

		state.viewportCount = 1;
		state.scissorCount = 1;

		if (graphicsPipelineDesc.rasterization == null)
			return;

		state.viewportCount = graphicsPipelineDesc.rasterization.viewportNum;
		state.scissorCount = graphicsPipelineDesc.rasterization.viewportNum;
	}

	private void FillRasterizationState(GraphicsPipelineDesc graphicsPipelineDesc, ref VkPipelineRasterizationStateCreateInfo state, ref VkPipelineRasterizationConservativeStateCreateInfoEXT conservativeRasterState)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_STATE_CREATE_INFO;

		if (graphicsPipelineDesc.rasterization == null)
			return;

		readonly ref RasterizationDesc rasterization = ref *graphicsPipelineDesc.rasterization;
		state.depthClampEnable = rasterization.depthClamp;
		state.rasterizerDiscardEnable = rasterization.rasterizerDiscard;
		state.polygonMode = GetPolygonMode(rasterization.fillMode);
		state.cullMode = GetCullMode(rasterization.cullMode);
		state.frontFace = rasterization.frontCounterClockwise ? .VK_FRONT_FACE_COUNTER_CLOCKWISE : .VK_FRONT_FACE_CLOCKWISE;
		state.depthBiasEnable = rasterization.depthBiasConstantFactor != 0.0f || rasterization.depthBiasSlopeFactor != 0.0f;
		state.depthBiasConstantFactor = GetDepthOffset(rasterization.depthBiasConstantFactor);
		state.depthBiasClamp = rasterization.depthBiasClamp;
		state.depthBiasSlopeFactor = rasterization.depthBiasSlopeFactor;
		state.lineWidth = 1.0f;

		if (graphicsPipelineDesc.rasterization.conservativeRasterization == false)
			return;

		conservativeRasterState.sType = .VK_STRUCTURE_TYPE_PIPELINE_RASTERIZATION_CONSERVATIVE_STATE_CREATE_INFO_EXT;
		conservativeRasterState.conservativeRasterizationMode = .VK_CONSERVATIVE_RASTERIZATION_MODE_OVERESTIMATE_EXT;
		conservativeRasterState.extraPrimitiveOverestimationSize = 0.0f;
		state.pNext = &conservativeRasterState;
	}

	private void FillMultisampleState(GraphicsPipelineDesc graphicsPipelineDesc, ref VkPipelineMultisampleStateCreateInfo state)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_MULTISAMPLE_STATE_CREATE_INFO;

		if (graphicsPipelineDesc.rasterization == null)
			return;

		readonly ref RasterizationDesc rasterization = ref *graphicsPipelineDesc.rasterization;
		state.rasterizationSamples = GetSampleCount(rasterization.sampleNum);
		state.sampleShadingEnable = false;
		state.minSampleShading = 0.0f;
		*state.pSampleMask = rasterization.sampleMask;
		state.alphaToCoverageEnable = rasterization.alphaToCoverage;
		state.alphaToOneEnable = false;
	}

	private void FillDepthStencilState(GraphicsPipelineDesc graphicsPipelineDesc, ref VkPipelineDepthStencilStateCreateInfo state)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_DEPTH_STENCIL_STATE_CREATE_INFO;

		if (graphicsPipelineDesc.outputMerger == null)
			return;

		readonly ref DepthAttachmentDesc depthDesc = ref graphicsPipelineDesc.outputMerger.depth;
		readonly ref StencilAttachmentDesc stencil = ref graphicsPipelineDesc.outputMerger.stencil;
		state.depthTestEnable = depthDesc.compareFunc != CompareFunc.NONE;
		state.depthWriteEnable = depthDesc.write;
		state.depthCompareOp = GetCompareOp(depthDesc.compareFunc);
		state.depthBoundsTestEnable = VulkanNative.VK_TRUE;
		state.stencilTestEnable = stencil.front.compareFunc != CompareFunc.NONE;
		state.minDepthBounds = 0.0f;
		state.maxDepthBounds = 1.0f;

		state.front.failOp = GetStencilOp(stencil.front.fail);
		state.front.passOp = GetStencilOp(stencil.front.pass);
		state.front.depthFailOp = GetStencilOp(stencil.front.depthFail);
		state.front.compareOp = GetCompareOp(stencil.front.compareFunc);
		state.front.compareMask = stencil.compareMask;
		state.front.writeMask = stencil.writeMask;
		state.front.reference = stencil.reference;

		state.back.failOp = GetStencilOp(stencil.back.fail);
		state.back.passOp = GetStencilOp(stencil.back.pass);
		state.back.depthFailOp = GetStencilOp(stencil.back.depthFail);
		state.back.compareOp = GetCompareOp(stencil.back.compareFunc);
		state.back.compareMask = stencil.compareMask;
		state.back.writeMask = stencil.writeMask;
		state.back.reference = stencil.reference;
	}

	private void FillColorBlendState(GraphicsPipelineDesc graphicsPipelineDesc, ref VkPipelineColorBlendStateCreateInfo state)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_COLOR_BLEND_STATE_CREATE_INFO;

		if (graphicsPipelineDesc.outputMerger == null)
			return;

		/*readonly*/ ref OutputMergerDesc outputMerger = ref *graphicsPipelineDesc.outputMerger;

		state.logicOpEnable = outputMerger.colorLogicFunc != LogicFunc.NONE;
		state.logicOp = GetLogicOp(outputMerger.colorLogicFunc);
		state.attachmentCount = outputMerger.colorNum;

		for (uint32 i = 0; i < 4; i++)
			state.blendConstants[i] = *(&outputMerger.blendConsts.x + i);

		VkPipelineColorBlendAttachmentState* attachments = state.pAttachments;
		for (uint32 i = 0; i < outputMerger.colorNum; i++)
		{
			readonly ref ColorAttachmentDesc attachmentDesc = ref outputMerger.color[i];

			attachments[i] = .()
				{
					blendEnable = VkBool32(attachmentDesc.blendEnabled),
					srcColorBlendFactor = GetBlendFactor(attachmentDesc.colorBlend.srcFactor),
					dstColorBlendFactor = GetBlendFactor(attachmentDesc.colorBlend.dstFactor),
					colorBlendOp = GetBlendOp(attachmentDesc.colorBlend.func),
					srcAlphaBlendFactor = GetBlendFactor(attachmentDesc.alphaBlend.srcFactor),
					dstAlphaBlendFactor = GetBlendFactor(attachmentDesc.alphaBlend.dstFactor),
					alphaBlendOp = GetBlendOp(attachmentDesc.alphaBlend.func),
					colorWriteMask = GetColorComponent(attachmentDesc.colorWriteMask)
				};
		}
	}

	private static VkDynamicState[4] DYNAMIC_STATE = .(
		.VK_DYNAMIC_STATE_VIEWPORT,
		.VK_DYNAMIC_STATE_SCISSOR,
		.VK_DYNAMIC_STATE_DEPTH_BOUNDS,
		.VK_DYNAMIC_STATE_STENCIL_REFERENCE
		);

	private void FillDynamicState(ref VkPipelineDynamicStateCreateInfo state)
	{
		state.sType = .VK_STRUCTURE_TYPE_PIPELINE_DYNAMIC_STATE_CREATE_INFO;

		state.dynamicStateCount = (uint32)DYNAMIC_STATE.Count;
		state.pDynamicStates = &DYNAMIC_STATE;
	}

	private void FillGroupIndices(RayTracingPipelineDesc rayTracingPipelineDesc, uint32* groupIndices)
	{
		for (uint32 i = 0; i < rayTracingPipelineDesc.shaderGroupDescNum; i++)
		{
			readonly ref ShaderGroupDesc shaderGroupDesc = ref rayTracingPipelineDesc.shaderGroupDescs[i];
			for (uint32 j = 0; i < shaderGroupDesc.shaderIndices.Count; j++)
			{
				if (shaderGroupDesc.shaderIndices[j] != 0)
					groupIndices[shaderGroupDesc.shaderIndices[j] - 1] = j;
			}
		}
	}
}