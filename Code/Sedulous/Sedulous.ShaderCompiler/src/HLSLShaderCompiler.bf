using Dxc_Beef;
using System;
using System.Collections;
using System.IO;
using System.Diagnostics;
using Sedulous.RHI;
using static System.Windows.COM_IUnknown;
namespace Sedulous.ShaderCompiler;

public static
{
	public static void GetShaderTarget(ShaderStage stage, StringView model, String target)
	{
		switch (stage) {
		case .VERTEX:
			target.AppendF("vs_{}", model);
			break;

		case .TESS_CONTROL:
			target.AppendF("hs_{}", model);
			break;

		case .TESS_EVALUATION:
			target.AppendF("ds_{}", model);
			break;

		case .GEOMETRY:
			target.AppendF("gs_{}", model);
			break;

		case .FRAGMENT:
			target.AppendF("ps_{}", model);
			break;

		case .COMPUTE:
			target.AppendF("cs_{}", model);
			break;

		case .RAYGEN:
			target.AppendF("lib_{}", model);
			break;

		case .MISS:
			target.AppendF("lib_{}", model);
			break;

		case .INTERSECTION:
			target.AppendF("lib_{}", model); //
			break;

		case .CLOSEST_HIT:
			target.AppendF("lib_{}", model);
			break;

		case .ANY_HIT:
			target.AppendF("lib_{}", model);
			break;

		case .CALLABLE:
			target.AppendF("lib_{}", model); //
			break;

		case .MESH_CONTROL:
			target.AppendF("ms_{}", model); //
			break;

		case .MESH_EVALUATION:
			target.AppendF("as_{}", model); //

			break;
		case .ALL: fallthrough;
		case .MAX_NUM: fallthrough;
		default:
			Runtime.FatalError();
		}
	}
}

class HLSLShaderCompiler
{
	public static bool IsInitialized { get; private set; }
	private static IDxcLibrary* pLibrary = null;

	private static Result<void> Initialize()
	{
		if (IsInitialized)
			return .Ok;

		HResult result = Dxc.CreateInstance(out pLibrary);
		if (result != .OK)
			return .Err;

		IsInitialized = true;
		return .Ok;
	}

	public static this()
	{
		Initialize();
	}

	private const uint32 SPIRV_SPACES_NUM = 8;

	public Result<void> CompileShader(ShaderCompilationOptions options, List<uint8> compiledByteCode)
	{
		static String[?] optimizationLevels = .(
		    DXC_ARG_SKIP_OPTIMIZATIONS,
			DXC_ARG_OPTIMIZATION_LEVEL0,
		    DXC_ARG_OPTIMIZATION_LEVEL1,
		    DXC_ARG_OPTIMIZATION_LEVEL2,
		    DXC_ARG_OPTIMIZATION_LEVEL3,
		);

		// Gather SPIRV register shifts once
		static String[?] regShiftArgs = .(
		    "-fvk-s-shift",
		    "-fvk-t-shift",
		    "-fvk-b-shift",
		    "-fvk-u-shift",
		);

		int[?] regShiftVals = .(
			options.sRegShift,
			options.tRegShift,
			options.bRegShift,
			options.sRegShift,
		);

		List<String> regShifts = scope .();

	    for (int space = 0; space < SPIRV_SPACES_NUM; space++)
	    {
			for(int reg = 0; reg < 4; reg++){
				regShifts.Add(regShiftArgs[reg]);
				regShifts.Add(scope :: $"{regShiftVals[reg]}");
				regShifts.Add(scope :: $"{space}");
			}
	    }

		IDxcCompiler3* pCompiler = null;

		var result = Dxc.CreateInstance(out pCompiler);
		if (result != .OK)
			return .Err;

		uint32 codePage = 0;
		IDxcBlobEncoding* pSource = null;
		result = pLibrary.CreateBlobFromFile(options.shaderPath, &codePage, out pSource);
		if (result != .OK)
			return .Err;

		List<String> arguments = scope .();

		String target = GetShaderTarget(options.shaderStage, options.shaderModel, .. scope .());

		arguments.Add("-T");
		arguments.Add(target);

		arguments.Add("-E");
		arguments.Add(scope :: String(options.entryPoint));

		if (options.defines != null)
		{
			for (var define in options.defines)
			{
				arguments.Add(scope :: $"-D{define.key}={define.value}");
			}
		}

		if (options.outputType == .DXIL)
		{
			arguments.Add(scope :: $"-DDXIL");

			if (options.stripReflection)
				arguments.Add(scope :: $"-Qstrip_reflect");
		}

		if (options.outputType == .SPIRV)
		{
			arguments.Add(scope :: $"-DSPIRV");
			arguments.Add(scope :: $"-DVULKAN");

			arguments.Add(scope :: $"-spirv");
			arguments.Add(scope :: $"-fspv-target-env=vulkan1.2");
			arguments.Add(scope :: $"-fspv-extension=SPV_EXT_descriptor_indexing");
			arguments.Add(scope :: $"-fspv-extension=KHR");

			arguments.AddRange(regShifts);
		}

		arguments.Add(optimizationLevels[(.)options.optimizationLevel]);

		arguments.Add("-enable-16bit-types");

		if (options.warningsAreErrors)
		    arguments.Add(DXC_ARG_WARNINGS_ARE_ERRORS);

		if (options.allResourcesBound)
		    arguments.Add(DXC_ARG_ALL_RESOURCES_BOUND);

		if (options.matrixRowMajor)
		    arguments.Add(DXC_ARG_PACK_MATRIX_ROW_MAJOR);

		if(options.pdb){
			arguments.Add("/Zi");
			arguments.Add("/Qembed_debug");
		}

		DxcBuffer buffer = .()
			{
				Ptr = pSource.GetBufferPointer(),
				Size = pSource.GetBufferSize(),
				Encoding = 0
			};
		
		String shaderDir = Path.GetDirectoryPath(options.shaderPath, .. scope .());
		IncludeHandler includeHandler = .(pLibrary, shaderDir);

		List<StringView> compilerArgs = scope .();
		for(var arg in arguments){
			compilerArgs.Add(arg);
		}

		result = pCompiler.Compile(&buffer, compilerArgs, &includeHandler, ref IDxcResult.sIID, var ppResult);
		if (result != .OK)
			return .Err;

		IDxcResult* pResult = (.)ppResult;

		result = pResult.GetStatus(var status);

		if (status != .OK)
		{
			IDxcBlobEncoding* pErrors = null;
			result = pResult.GetErrorBuffer(out pErrors);
			if (pErrors != null && pErrors.GetBufferSize() > 0)
			{
				Debug.WriteLine(scope String((char8*)pErrors.GetBufferPointer()));
			}
			return .Err;
		}

		IDxcBlob* pBlob = null;

		result = pResult.GetResult(out pBlob);
		if (result != .OK)
			return .Err;

		compiledByteCode.AddRange(Span<uint8>((.)pBlob.GetBufferPointer(), pBlob.GetBufferSize()));

		return .Ok;
	}
}