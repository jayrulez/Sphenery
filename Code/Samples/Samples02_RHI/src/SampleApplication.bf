using Sedulous.Framework;
using Sedulous.RHI;
using Sedulous.RHI.Vulkan;
using System.Collections;
using System;
using Sedulous.RHI.Validation;
using Sedulous.ShaderCompiler;
using Sedulous.Graphics;
namespace Samples02_RHI;



class SampleApplication : Application
{
	private static SPIRVBindingOffsets SPIRV_BINDING_OFFSETS = .()
		{
			samplerOffset = 100,
			textureOffset = 200,
			constantBufferOffset = 300,
			storageTextureAndBufferOffset = 400
		};
	

	private IDevice mDevice;
	private DeviceLogger mDeviceLogger;
	private DeviceAllocator<uint8> mDeviceAllocator;

	private GraphicsRenderDelegate mGraphicsRenderDelegate;

	private GraphicsPlugin mGraphicsPlugin;

	public this(IApplicationHost host, ApplicationConfiguration configuration)
		: base(host, configuration)
	{
	}

	private static Result CreateDevice(DeviceCreationDesc desc, DeviceLogger logger, DeviceAllocator<uint8> allocator, out IDevice outDevice)
	{
		IDevice device = null;
		Result result = CreateDeviceVK(logger, allocator, desc, out device);
		if (result != .SUCCESS)
		{
			outDevice = ?;
			return result;
		}

		if (desc.enableNRIValidation)
		{
			IDevice deviceVal = null;

			result = CreateDeviceValidation(desc, logger, allocator, device, out deviceVal);
			if (result != .SUCCESS)
			{
				outDevice = ?;
				DestroyDeviceVK(device);
				return result;
			}

			outDevice = deviceVal;

			return .SUCCESS;
		} else
		{
			outDevice = device;

			return .SUCCESS;
		}
	}

	private static void DestroyDevice(IDevice device)
	{
		device.Destroy();
	}

	protected override void OnInitializing(ApplicationInitializer initializer)
	{
		Logger.LogInformation(nameof(OnInitializing));
		
		HLSLShaderCompiler shaderCompiler = scope .();

		List<uint8> fragmentShaderByteCode = scope .();
		{
			Result<void> compileResult = shaderCompiler.CompileShader(.()
				{
					shaderPath = "shaders/Triangle.fs.hlsl",
					shaderStage = .FRAGMENT,
					shaderModel = "6_5",
					entryPoint = "main",
					outputType = .SPIRV,
					sRegShift = SPIRV_BINDING_OFFSETS.samplerOffset,
					tRegShift = SPIRV_BINDING_OFFSETS.textureOffset,
					bRegShift = SPIRV_BINDING_OFFSETS.constantBufferOffset,
					uRegShift = SPIRV_BINDING_OFFSETS.storageTextureAndBufferOffset
				}, fragmentShaderByteCode);

			if (compileResult case .Err)
			{
				Runtime.FatalError("Fragment shader compilation failed.");
			}
		}
		List<uint8> vertexShaderByteCode = scope .();
		{
			Result<void> compileResult = shaderCompiler.CompileShader(.()
				{
					shaderPath = "shaders/Triangle.vs.hlsl",
					shaderStage = .VERTEX,
					shaderModel = "6_5",
					entryPoint = "main",
					outputType = .SPIRV,
					sRegShift = SPIRV_BINDING_OFFSETS.samplerOffset,
					tRegShift = SPIRV_BINDING_OFFSETS.textureOffset,
					bRegShift = SPIRV_BINDING_OFFSETS.constantBufferOffset,
					uRegShift = SPIRV_BINDING_OFFSETS.storageTextureAndBufferOffset
				}, vertexShaderByteCode);

			if (compileResult case .Err)
			{
				Runtime.FatalError("Fragment shader compilation failed.");
			}
		}

		mDeviceLogger = new .(.VULKAN, default);
		mDeviceAllocator = new .(MemoryAllocatorInterface());
		DeviceCreationDesc desc = .()
			{
				enableNRIValidation = true,
				spirvBindingOffsets = SPIRV_BINDING_OFFSETS
			};

		Result result = CreateDevice(desc, mDeviceLogger, mDeviceAllocator, out mDevice);
		if (result != .SUCCESS)
		{
			Runtime.FatalError(scope $"Device creation failed: {result}");
		}

		mGraphicsPlugin = new .(mDevice, Host.Platform.WindowSystem.PrimaryWindow);

		mGraphicsPlugin.OnRendering.Subscribe(mGraphicsRenderDelegate = new => this.RenderFrame);

		initializer.AddPlugin(mGraphicsPlugin);
	}

	protected override void OnInitialized()
	{
		Logger.LogInformation(nameof(OnInitialized));
	}

	protected override void OnShuttingdown()
	{
		Logger.LogInformation(nameof(OnShuttingdown));
	}

	protected override void OnShutdown()
	{
		Logger.LogInformation(nameof(OnShutdown));

		mGraphicsPlugin.OnRendering.Unsubscribe(mGraphicsRenderDelegate);

		delete mGraphicsPlugin;

		DestroyDevice(mDevice);
		delete mDeviceAllocator;
		delete mDeviceLogger;
	}

	private void RenderFrame(RenderFrame renderFrame)
	{
		readonly uint32 windowWidth = (.)mGraphicsPlugin.Window.ClientSize.Width;
		readonly uint32 windowHeight = (.)mGraphicsPlugin.Window.ClientSize.Height;

		var commandBuffer = renderFrame.CommandBuffer;
		{
			TextureTransitionBarrierDesc textureTransitionBarrierDesc = .();
			textureTransitionBarrierDesc.texture = renderFrame.BackBufferTexture;
			textureTransitionBarrierDesc.prevAccess = AccessBits.UNKNOWN;
			textureTransitionBarrierDesc.nextAccess = AccessBits.COLOR_ATTACHMENT;
			textureTransitionBarrierDesc.prevLayout = TextureLayout.UNKNOWN;
			textureTransitionBarrierDesc.nextLayout = TextureLayout.COLOR_ATTACHMENT;
			textureTransitionBarrierDesc.arraySize = 1;
			textureTransitionBarrierDesc.mipNum = 1;

			TransitionBarrierDesc transitionBarriers = .();
			transitionBarriers.textureNum = 1;
			transitionBarriers.textures = &textureTransitionBarrierDesc;
			commandBuffer.PipelineBarrier(&transitionBarriers, null, BarrierDependency.ALL_STAGES);

			commandBuffer.BeginRenderPass(renderFrame.FrameBuffer, RenderPassBeginFlag.NONE);
			{
				commandBuffer.BeginAnnotation("Clear");
				defer commandBuffer.EndAnnotation();

				ClearDesc clearDesc = .();
				clearDesc.colorAttachmentIndex = 0;

				clearDesc.value.color32f = .() { x = 1.0f, y = 0.0f, w = 0.0f, z = 1.0f };
				Rect rect1 = .() { left = 0, top = 0, width = windowWidth, height = windowHeight / 3 };
				commandBuffer.ClearAttachments(&clearDesc, 1, &rect1, 1);

				clearDesc.value.color32f = .() { x = 0.0f, y = 1.0f, z = 0.0f, w = 1.0f };
				Rect rect2 = .() { left = 0, top = (int32)windowHeight / 3, width = windowWidth, height = windowHeight / 3 };
				commandBuffer.ClearAttachments(&clearDesc, 1, &rect2, 1);

				clearDesc.value.color32f = .() { x = 0.0f, y = 0.0f, z = 1.0f, w = 1.0f };
				Rect rect3 = .() { left = 0, top = (int32)(windowHeight * 2) / 3, width = windowWidth, height = windowHeight / 3 };
				commandBuffer.ClearAttachments(&clearDesc, 1, &rect3, 1);
			}
			commandBuffer.EndRenderPass();

			textureTransitionBarrierDesc.prevAccess = textureTransitionBarrierDesc.nextAccess;
			textureTransitionBarrierDesc.nextAccess = AccessBits.UNKNOWN;
			textureTransitionBarrierDesc.prevLayout = textureTransitionBarrierDesc.nextLayout;
			textureTransitionBarrierDesc.nextLayout = TextureLayout.PRESENT;

			commandBuffer.PipelineBarrier(&transitionBarriers, null, BarrierDependency.ALL_STAGES);
		}
	}
}