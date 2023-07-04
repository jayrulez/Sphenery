using System;
namespace Sedulous.RHI.Validation;

class PipelineVal : DeviceObjectVal<IPipeline>, IPipeline
{
	private IPipelineLayout m_PipelineLayout = null;

	public this(DeviceVal device, IPipeline pipeline)
		: base(device, pipeline)
	{
	}

	public this(DeviceVal device, IPipeline pipeline, GraphicsPipelineDesc graphicsPipelineDesc)
		: base(device, pipeline)
	{
		m_PipelineLayout = graphicsPipelineDesc.pipelineLayout;
	}

	public this(DeviceVal device, IPipeline pipeline, ComputePipelineDesc computePipelineDesc)
		: base(device, pipeline)
	{
		m_PipelineLayout = computePipelineDesc.pipelineLayout;
	}

	public this(DeviceVal device, IPipeline pipeline, RayTracingPipelineDesc rayTracingPipelineDesc)
		: base(device, pipeline)
	{
		m_PipelineLayout = rayTracingPipelineDesc.pipelineLayout;
	}


	[Inline] public IPipelineLayout GetPipelineLayout()
		{ return m_PipelineLayout; }

	//================================================================================================================
	// NRI
	//================================================================================================================
	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}

	public Result WriteShaderGroupIdentifiers(uint32 baseShaderGroupIndex, uint32 shaderGroupNum, void* buffer)
	{
		return m_ImplObject.WriteShaderGroupIdentifiers(baseShaderGroupIndex, shaderGroupNum, buffer);
	}
}