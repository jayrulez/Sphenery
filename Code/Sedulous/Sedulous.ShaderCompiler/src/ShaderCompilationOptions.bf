using System.Collections;
using System;
using Sedulous.RHI;
namespace Sedulous.ShaderCompiler;

struct ShaderCompilationOptions
{
	public StringView shaderPath;
	public ShaderStage shaderStage;
	public StringView entryPoint;
	public Dictionary<StringView, StringView> defines;
	public ShaderCompilerOutputType outputType;

	//public List<String> spirvExtensions = new .(){"SPV_EXT_descriptor_indexing", "KHR"};
	public StringView shaderModel = "6_5";
	//public StringView vulkanVersion = "1.3";
	// SPIRV: register shift for sampler (s#) resources
	public uint32 sRegShift = 100; // must be first (or change "DxcCompile" code)
	// SPIRV: register shift for texture (t#) resources
	public uint32 tRegShift = 200;
	// SPIRV: register shift for constant (b#) resources
	public uint32 bRegShift = 300;
	// SPIRV: register shift for UAV (u#) resources
	public uint32 uRegShift = 400;

	public ShaderCompilerOptimizationLevel optimizationLevel = .O3;
	public bool warningsAreErrors = false;
	public bool allResourcesBound = false;
	public bool pdb = false;
	public bool stripReflection = false;
	public bool matrixRowMajor = false;
	//public bool verbose = false;
}