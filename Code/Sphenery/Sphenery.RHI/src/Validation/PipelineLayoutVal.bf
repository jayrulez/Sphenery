using System.Collections;
using System;
namespace Sphenery.RHI.Validation;

class PipelineLayoutVal : DeviceObjectVal<IPipelineLayout>, IPipelineLayout
{
	private PipelineLayoutDesc m_PipelineLayoutDesc;
	private List<DescriptorSetDesc> m_DescriptorSets;
	private List<PushConstantDesc> m_PushConstants;
	private List<DescriptorRangeDesc> m_DescriptorRangeDescs;
	private List<DynamicConstantBufferDesc> m_DynamicConstantBufferDescs;

	public this(DeviceVal device, IPipelineLayout pipelineLayout, PipelineLayoutDesc pipelineLayoutDesc)
		: base(device, pipelineLayout)
	{
		m_DescriptorSets = Allocate!<List<DescriptorSetDesc>>(m_Device.GetAllocator());
		m_PushConstants = Allocate!<List<PushConstantDesc>>(m_Device.GetAllocator());
		m_DescriptorRangeDescs = Allocate!<List<DescriptorRangeDesc>>(m_Device.GetAllocator());
		m_DynamicConstantBufferDescs = Allocate!<List<DynamicConstantBufferDesc>>(m_Device.GetAllocator());

		m_PipelineLayoutDesc = pipelineLayoutDesc;

		uint32 descriptorRangeDescNum = 0;
		uint32 dynamicConstantBufferDescNum = 0;

		for (uint32 i = 0; i < pipelineLayoutDesc.descriptorSetNum; i++)
		{
			descriptorRangeDescNum += pipelineLayoutDesc.descriptorSets[i].rangeNum;
			dynamicConstantBufferDescNum += pipelineLayoutDesc.descriptorSets[i].dynamicConstantBufferNum;
		}

		m_DescriptorSets.Insert(0, Span<DescriptorSetDesc>(pipelineLayoutDesc.descriptorSets, pipelineLayoutDesc.descriptorSetNum));

		m_PushConstants.Insert(0, Span<PushConstantDesc>(pipelineLayoutDesc.pushConstants, pipelineLayoutDesc.pushConstantNum));

		m_DescriptorRangeDescs.Reserve(descriptorRangeDescNum);
		m_DynamicConstantBufferDescs.Reserve(dynamicConstantBufferDescNum);

		for (uint32 i = 0; i < pipelineLayoutDesc.descriptorSetNum; i++)
		{
			readonly ref DescriptorSetDesc descriptorSetDesc = ref pipelineLayoutDesc.descriptorSets[i];

			m_DescriptorSets[i].ranges = m_DescriptorRangeDescs.Ptr + m_DescriptorRangeDescs.Count;
			m_DescriptorSets[i].dynamicConstantBuffers = m_DynamicConstantBufferDescs.Ptr + m_DynamicConstantBufferDescs.Count;

			m_DescriptorRangeDescs.AddRange(Span<DescriptorRangeDesc>(descriptorSetDesc.ranges, descriptorSetDesc.rangeNum));

			m_DynamicConstantBufferDescs.AddRange(Span<DynamicConstantBufferDesc>(descriptorSetDesc.dynamicConstantBuffers, descriptorSetDesc.dynamicConstantBufferNum));
		}

		m_PipelineLayoutDesc = pipelineLayoutDesc;

		m_PipelineLayoutDesc.descriptorSets = m_DescriptorSets.Ptr;
		m_PipelineLayoutDesc.pushConstants = m_PushConstants.Ptr;
	}

	public ~this()
	{
		Deallocate!(m_Device.GetAllocator(), m_PushConstants);
		Deallocate!(m_Device.GetAllocator(), m_DescriptorRangeDescs);
		Deallocate!(m_Device.GetAllocator(), m_DynamicConstantBufferDescs);
		Deallocate!(m_Device.GetAllocator(), m_DescriptorSets);
	}

	[Inline] public readonly ref PipelineLayoutDesc GetPipelineLayoutDesc()
		{ return ref m_PipelineLayoutDesc; }

	//================================================================================================================
	// NRI
	//================================================================================================================
	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}
}