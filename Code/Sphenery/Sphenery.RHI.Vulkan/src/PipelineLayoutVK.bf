using Bulkan;
using System.Collections;
using System;
namespace Sphenery.RHI.Vulkan;

struct PushConstantRangeBindingDesc
{
	public VkShaderStageFlags flags;
	public uint32 offset;
}

struct RuntimeBindingInfo : IDisposable
{
	public List<bool> hasVariableDescriptorNum;
	public List<DescriptorRangeDesc> descriptorSetRangeDescs;
	public List<DynamicConstantBufferDesc> dynamicConstantBufferDescs;
	public List<DescriptorSetDesc> descriptorSetDescs;
	public List<PushConstantDesc> pushConstantDescs;
	public List<PushConstantRangeBindingDesc> pushConstantBindings;

	private DeviceAllocator<uint8> m_Allocator;

	public this(DeviceAllocator<uint8> allocator)
	{
		this.m_Allocator = allocator;

		hasVariableDescriptorNum = Allocate!<List<bool>>(m_Allocator);
		descriptorSetRangeDescs = Allocate!<List<DescriptorRangeDesc>>(m_Allocator);
		dynamicConstantBufferDescs = Allocate!<List<DynamicConstantBufferDesc>>(m_Allocator);
		descriptorSetDescs = Allocate!<List<DescriptorSetDesc>>(m_Allocator);
		pushConstantDescs = Allocate!<List<PushConstantDesc>>(m_Allocator);
		pushConstantBindings = Allocate!<List<PushConstantRangeBindingDesc>>(m_Allocator);
	}

	public void Dispose()
	{
		Deallocate!(m_Allocator, pushConstantBindings);
		Deallocate!(m_Allocator, pushConstantDescs);
		Deallocate!(m_Allocator, descriptorSetDescs);
		Deallocate!(m_Allocator, dynamicConstantBufferDescs);
		Deallocate!(m_Allocator, descriptorSetRangeDescs);
		Deallocate!(m_Allocator, hasVariableDescriptorNum);
	}
}

class PipelineLayoutVK : IPipelineLayout
{
	private readonly DeviceVK m_Device;
	private VkPipelineLayout m_Handle = .Null;
	private VkPipelineBindPoint m_PipelineBindPoint = /*VK_PIPELINE_BIND_POINT_MAX_ENUM*/ (VkPipelineBindPoint)0x7FFFFFFF;
	private RuntimeBindingInfo m_RuntimeBindingInfo;
	private List<VkDescriptorSetLayout> m_DescriptorSetLayouts;
	private List<uint32> m_DescriptorSetSpaces;

	[Inline] public this(DeviceVK device)
	{
		m_Device = device;

		m_RuntimeBindingInfo = .(m_Device.GetAllocator());
		m_DescriptorSetLayouts = Allocate!<List<VkDescriptorSetLayout>>(m_Device.GetAllocator());
		m_DescriptorSetSpaces = Allocate!<List<uint32>>(m_Device.GetAllocator());
	}
	public ~this()
	{
		readonly var allocationCallbacks = m_Device.GetAllocationCallbacks();

		if (m_Handle != .Null)
			VulkanNative.vkDestroyPipelineLayout(m_Device, m_Handle, allocationCallbacks);

		for (ref VkDescriptorSetLayout handle in ref m_DescriptorSetLayouts)
			VulkanNative.vkDestroyDescriptorSetLayout(m_Device, handle, allocationCallbacks);

		Deallocate!(m_Device.GetAllocator(), m_DescriptorSetSpaces);
		Deallocate!(m_Device.GetAllocator(), m_DescriptorSetLayouts);
		m_RuntimeBindingInfo.Dispose();
	}

	[Inline] public static implicit operator VkPipelineLayout(Self self)
		{ return self.m_Handle; }

	[Inline] public DeviceVK GetDevice()
		{ return m_Device; }

	[Inline] public readonly ref RuntimeBindingInfo GetRuntimeBindingInfo()
		{ return ref m_RuntimeBindingInfo; }

	[Inline] public VkDescriptorSetLayout GetDescriptorSetLayout(uint32 index)
		{ return m_DescriptorSetLayouts[index]; }

	[Inline] public VkPipelineBindPoint GetPipelineBindPoint()
		{ return m_PipelineBindPoint; }

	[Inline] public uint32 GetDescriptorSetSpace(uint32 setIndexInPipelineLayout)
		{ return m_DescriptorSetSpaces[setIndexInPipelineLayout]; }


	public Result Create(PipelineLayoutDesc pipelineLayoutDesc)
	{
		if (pipelineLayoutDesc.stageMask.HasFlag(PipelineLayoutShaderStageBits.ALL_GRAPHICS))
			m_PipelineBindPoint = .VK_PIPELINE_BIND_POINT_GRAPHICS;

		if (pipelineLayoutDesc.stageMask.HasFlag(PipelineLayoutShaderStageBits.COMPUTE))
			m_PipelineBindPoint = .VK_PIPELINE_BIND_POINT_COMPUTE;

		if (pipelineLayoutDesc.stageMask.HasFlag(PipelineLayoutShaderStageBits.ALL_RAY_TRACING))
			m_PipelineBindPoint = .VK_PIPELINE_BIND_POINT_RAY_TRACING_KHR;

		uint32[(uint32)DescriptorType.MAX_NUM] bindingOffsets = .();
		FillBindingOffsets(pipelineLayoutDesc.ignoreGlobalSPIRVOffsets, &bindingOffsets);

		// Create "in use" set layouts, calculate number of sets, copy "register space" for later use
		m_DescriptorSetSpaces.Resize(pipelineLayoutDesc.descriptorSetNum);
		m_DescriptorSetLayouts.Resize(pipelineLayoutDesc.descriptorSetNum);

		uint32 setNum = 0;
		for (uint32 i = 0; i < pipelineLayoutDesc.descriptorSetNum; i++)
		{
			m_DescriptorSetLayouts[i] = CreateSetLayout(pipelineLayoutDesc.descriptorSets[i], &bindingOffsets);
			m_DescriptorSetSpaces[i] = pipelineLayoutDesc.descriptorSets[i].registerSpace;

			setNum = Math.Max(setNum, pipelineLayoutDesc.descriptorSets[i].registerSpace);
		}
		setNum++;

		// Allocate temp memory for ALL "register spaces" making the entire range consecutive (thanks Vulkan API!)
		VkDescriptorSetLayout* descriptorSetLayouts = ALLOCATE_SCRATCH!<VkDescriptorSetLayout>(m_Device, setNum);

		// Create "empty" set layout (needed only if "register space" indices are not consecutive)
		if (setNum != pipelineLayoutDesc.descriptorSetNum)
		{
			VkDescriptorSetLayout emptyLayout = CreateSetLayout(.(), &bindingOffsets);
			m_DescriptorSetLayouts.Add(emptyLayout);

			for (uint32 i = 0; i < setNum; i++)
				descriptorSetLayouts[i] = emptyLayout;
		}

		// Populate descriptor set layouts
		for (uint32 i = 0; i < pipelineLayoutDesc.descriptorSetNum; i++)
		{
			uint32 setIndex = pipelineLayoutDesc.descriptorSets[i].registerSpace;
			descriptorSetLayouts[setIndex] = m_DescriptorSetLayouts[i];
		}

		// Push constants
		VkPushConstantRange* pushConstantRanges = ALLOCATE_SCRATCH!<VkPushConstantRange>(m_Device, pipelineLayoutDesc.pushConstantNum);
		FillPushConstantRanges(pipelineLayoutDesc, pushConstantRanges);

		// Create pipeline layout
		VkPipelineLayoutCreateInfo pipelineLayoutCreateInfo = .() { sType = .VK_STRUCTURE_TYPE_PIPELINE_LAYOUT_CREATE_INFO };
		pipelineLayoutCreateInfo.setLayoutCount = setNum;
		pipelineLayoutCreateInfo.pSetLayouts = descriptorSetLayouts;
		pipelineLayoutCreateInfo.pushConstantRangeCount = pipelineLayoutDesc.pushConstantNum;
		pipelineLayoutCreateInfo.pPushConstantRanges = pushConstantRanges;

		readonly VkResult result = VulkanNative.vkCreatePipelineLayout(m_Device, &pipelineLayoutCreateInfo, m_Device.GetAllocationCallbacks(), &m_Handle);

		// Cleanup
		FREE_SCRATCH!(m_Device, pushConstantRanges, pipelineLayoutDesc.pushConstantNum);
		FREE_SCRATCH!(m_Device, descriptorSetLayouts, setNum);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, Result.FAILURE,
			"Can't create a pipeline layout: vkCreatePipelineLayout returned {0}.", (int32)result);

		FillRuntimeBindingInfo(pipelineLayoutDesc, &bindingOffsets);

		return Result.SUCCESS;
	}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public void SetDebugName(char8* name)
	{
		m_Device.SetDebugNameToTrivialObject(.VK_OBJECT_TYPE_PIPELINE_LAYOUT, (uint64)m_Handle, name);
	}

	private void FillBindingOffsets(bool ignoreGlobalSPIRVOffsets, uint32* bindingOffsets)
	{
		SPIRVBindingOffsets spirvBindingOffsets;

		if (ignoreGlobalSPIRVOffsets)
			spirvBindingOffsets = .();
		else
			spirvBindingOffsets = m_Device.GetSPIRVBindingOffsets();

		bindingOffsets[(uint32)DescriptorType.SAMPLER] = spirvBindingOffsets.samplerOffset;
		bindingOffsets[(uint32)DescriptorType.CONSTANT_BUFFER] = spirvBindingOffsets.constantBufferOffset;
		bindingOffsets[(uint32)DescriptorType.TEXTURE] = spirvBindingOffsets.textureOffset;
		bindingOffsets[(uint32)DescriptorType.STORAGE_TEXTURE] = spirvBindingOffsets.storageTextureAndBufferOffset;
		bindingOffsets[(uint32)DescriptorType.BUFFER] = spirvBindingOffsets.textureOffset;
		bindingOffsets[(uint32)DescriptorType.STORAGE_BUFFER] = spirvBindingOffsets.storageTextureAndBufferOffset;
		bindingOffsets[(uint32)DescriptorType.STRUCTURED_BUFFER] = spirvBindingOffsets.textureOffset;
		bindingOffsets[(uint32)DescriptorType.STORAGE_STRUCTURED_BUFFER] = spirvBindingOffsets.storageTextureAndBufferOffset;
		bindingOffsets[(uint32)DescriptorType.ACCELERATION_STRUCTURE] = spirvBindingOffsets.textureOffset;
	}

	private VkDescriptorSetLayout CreateSetLayout(DescriptorSetDesc descriptorSetDesc, uint32* bindingOffsets)
	{
		uint32 bindingMaxNum = descriptorSetDesc.dynamicConstantBufferNum;

		for (uint32 i = 0; i < descriptorSetDesc.rangeNum; i++)
		{
			readonly ref DescriptorRangeDesc range = ref descriptorSetDesc.ranges[i];
			bindingMaxNum += range.isArray ? 1 : range.descriptorNum;
		}

		VkDescriptorSetLayoutBinding* bindings = ALLOCATE_SCRATCH!<VkDescriptorSetLayoutBinding>(m_Device, bindingMaxNum);
		VkDescriptorBindingFlags* bindingFlags = ALLOCATE_SCRATCH!<VkDescriptorBindingFlags>(m_Device, bindingMaxNum);
		VkDescriptorSetLayoutBinding* bindingsBegin = bindings;
		VkDescriptorBindingFlags* bindingFlagsBegin = bindingFlags;

		FillDescriptorBindings(descriptorSetDesc, bindingOffsets, ref bindings, ref bindingFlags);
		FillDynamicConstantBufferBindings(descriptorSetDesc, bindingOffsets, ref bindings, ref bindingFlags);

		readonly uint32 bindingNum = uint32(bindings - bindingsBegin);

		VkDescriptorSetLayoutBindingFlagsCreateInfo bindingFlagsInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_BINDING_FLAGS_CREATE_INFO,
				pNext = null,
				bindingCount = bindingNum,
				pBindingFlags = bindingFlagsBegin
			};

		VkDescriptorSetLayoutCreateInfo info = .()
			{
				sType = .VK_STRUCTURE_TYPE_DESCRIPTOR_SET_LAYOUT_CREATE_INFO,
				pNext = m_Device.IsDescriptorIndexingExtSupported() ? &bindingFlagsInfo : null,
				flags = (VkDescriptorSetLayoutCreateFlags)0,
				bindingCount = bindingNum,
				pBindings = bindingsBegin
			};

		VkDescriptorSetLayout handle = .Null;
		readonly VkResult result = VulkanNative.vkCreateDescriptorSetLayout(m_Device, &info, m_Device.GetAllocationCallbacks(), &handle);

		FREE_SCRATCH!(m_Device, bindingsBegin, bindingMaxNum);
		FREE_SCRATCH!(m_Device, bindingFlagsBegin, bindingMaxNum);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, 0,
			"Can't create the descriptor set layout: vkCreateDescriptorSetLayout returned {0}.", (int32)result);

		return handle;
	}

	private void FillDescriptorBindings(DescriptorSetDesc descriptorSetDesc, uint32* bindingOffsets,
		ref VkDescriptorSetLayoutBinding* bindings, ref VkDescriptorBindingFlags* bindingFlags)
	{
		readonly VkDescriptorBindingFlags commonBindingFlags = descriptorSetDesc.bindingMask.HasFlag(DescriptorSetBindingBits.PARTIALLY_BOUND) ?
			.VK_DESCRIPTOR_BINDING_PARTIALLY_BOUND_BIT : 0;

		const VkDescriptorBindingFlags variableSizedArrayFlags = .VK_DESCRIPTOR_BINDING_PARTIALLY_BOUND_BIT |
			.VK_DESCRIPTOR_BINDING_VARIABLE_DESCRIPTOR_COUNT_BIT;

		for (uint32 i = 0; i < descriptorSetDesc.rangeNum; i++)
		{
			readonly ref DescriptorRangeDesc range = ref descriptorSetDesc.ranges[i];

			readonly uint32 baseBindingIndex = range.baseRegisterIndex + bindingOffsets[(uint32)range.descriptorType];

			if (range.isArray)
			{
				*(bindingFlags++) = commonBindingFlags | (range.isDescriptorNumVariable ? variableSizedArrayFlags : 0);

				ref VkDescriptorSetLayoutBinding descriptorBinding = ref *(bindings++);
				descriptorBinding = .();
				descriptorBinding.binding = baseBindingIndex;
				descriptorBinding.descriptorType = GetDescriptorType(range.descriptorType);
				descriptorBinding.descriptorCount = range.descriptorNum;
				descriptorBinding.stageFlags = GetShaderStageFlags(range.visibility);
			}
			else
			{
				for (uint32 j = 0; j < range.descriptorNum; j++)
				{
					*(bindingFlags++) = commonBindingFlags;

					ref VkDescriptorSetLayoutBinding descriptorBinding = ref *(bindings++);
					descriptorBinding = .();
					descriptorBinding.binding = baseBindingIndex + j;
					descriptorBinding.descriptorType = GetDescriptorType(range.descriptorType);
					descriptorBinding.descriptorCount = 1;
					descriptorBinding.stageFlags = GetShaderStageFlags(range.visibility);
				}
			}
		}
	}

	private void FillDynamicConstantBufferBindings(DescriptorSetDesc descriptorSetDesc, uint32* bindingOffsets,
		ref VkDescriptorSetLayoutBinding* bindings, ref VkDescriptorBindingFlags* bindingFlags)
	{
		for (uint32 i = 0; i < descriptorSetDesc.dynamicConstantBufferNum; i++)
		{
			readonly ref DynamicConstantBufferDesc buffer = ref descriptorSetDesc.dynamicConstantBuffers[i];

			*(bindingFlags++) = 0;

			ref VkDescriptorSetLayoutBinding descriptorBinding = ref *(bindings++);
			descriptorBinding = .();
			descriptorBinding.binding = buffer.registerIndex + bindingOffsets[(uint32)DescriptorType.CONSTANT_BUFFER];
			descriptorBinding.descriptorType = .VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER_DYNAMIC;
			descriptorBinding.descriptorCount = 1;
			descriptorBinding.stageFlags = GetShaderStageFlags(buffer.visibility);
		}
	}

	private void FillPushConstantRanges(PipelineLayoutDesc pipelineLayoutDesc, VkPushConstantRange* pushConstantRanges)
	{
		uint32 offset = 0;

		for (uint32 i = 0; i < pipelineLayoutDesc.pushConstantNum; i++)
		{
			readonly ref PushConstantDesc pushConstantDesc = ref pipelineLayoutDesc.pushConstants[i];

			ref VkPushConstantRange range = ref pushConstantRanges[i];
			range = .();
			range.stageFlags = GetShaderStageFlags(pushConstantDesc.visibility);
			range.offset = offset;
			range.size = pushConstantDesc.size;

			offset += pushConstantDesc.size;
		}
	}

	private void FillRuntimeBindingInfo(PipelineLayoutDesc pipelineLayoutDesc, uint32* bindingOffsets)
	{
		ref RuntimeBindingInfo destination = ref m_RuntimeBindingInfo;
		readonly ref PipelineLayoutDesc source = ref pipelineLayoutDesc;

		destination.descriptorSetDescs.Insert(0, Span<DescriptorSetDesc>(source.descriptorSets, source.descriptorSetNum));

		destination.pushConstantDescs.Insert(0, Span<PushConstantDesc>(source.pushConstants, source.pushConstantNum));

		destination.pushConstantBindings.Resize(source.pushConstantNum);
		for (uint32 i = 0, offset = 0; i < source.pushConstantNum; i++)
		{
			destination.pushConstantBindings[i] = .() { flags = GetShaderStageFlags(source.pushConstants[i].visibility), offset = offset };
			offset += source.pushConstants[i].size;
		}

		uint rangeNum = 0;
		uint dynamicConstantBufferNum = 0;
		for (uint32 i = 0; i < source.descriptorSetNum; i++)
		{
			rangeNum += source.descriptorSets[i].rangeNum;
			dynamicConstantBufferNum += source.descriptorSets[i].dynamicConstantBufferNum;
		}

		destination.hasVariableDescriptorNum.Resize(source.descriptorSetNum);
		destination.descriptorSetRangeDescs.Reserve((.)rangeNum);
		destination.dynamicConstantBufferDescs.Reserve((.)dynamicConstantBufferNum);

		for (uint32 i = 0; i < source.descriptorSetNum; i++)
		{
			readonly ref DescriptorSetDesc descriptorSetDesc = ref source.descriptorSets[i];

			destination.hasVariableDescriptorNum[i] = false;

			destination.descriptorSetDescs[i].ranges =
				destination.descriptorSetRangeDescs.Ptr + destination.descriptorSetRangeDescs.Count;

			destination.descriptorSetDescs[i].dynamicConstantBuffers =
				destination.dynamicConstantBufferDescs.Ptr + destination.dynamicConstantBufferDescs.Count;

			// Copy descriptor range descs
			destination.descriptorSetRangeDescs.AddRange(Span<DescriptorRangeDesc>(descriptorSetDesc.ranges, descriptorSetDesc.rangeNum));

			// Fix descriptor range binding offsets and check for variable descriptor num
			DescriptorRangeDesc* ranges = destination.descriptorSetDescs[i].ranges;
			for (uint32 j = 0; j < descriptorSetDesc.rangeNum; j++)
			{
				ranges[j].baseRegisterIndex += bindingOffsets[(uint32)descriptorSetDesc.ranges[j].descriptorType];

				if (m_Device.IsDescriptorIndexingExtSupported() && descriptorSetDesc.ranges[j].isDescriptorNumVariable)
					destination.hasVariableDescriptorNum[i] = true;
			}

			// Copy dynamic constant buffer descs
			destination.dynamicConstantBufferDescs.AddRange(Span<DynamicConstantBufferDesc>(descriptorSetDesc.dynamicConstantBuffers, descriptorSetDesc.dynamicConstantBufferNum));

			// Copy dynamic constant buffer binding offsets
			DynamicConstantBufferDesc* dynamicConstantBuffers = destination.descriptorSetDescs[i].dynamicConstantBuffers;
			for (uint32 j = 0; j < descriptorSetDesc.dynamicConstantBufferNum; j++)
				dynamicConstantBuffers[j].registerIndex += bindingOffsets[(uint32)DescriptorType.CONSTANT_BUFFER];
		}
	}
}