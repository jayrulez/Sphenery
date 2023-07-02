using Sedulous.Framework;
using Sedulous.RHI;
using Sedulous.RHI.Vulkan;
using System.Collections;
using System;
namespace Samples02_RHI;

struct Frame
{
	public ICommandAllocator commandAllocator;
	public ICommandBuffer commandBuffer;
}

struct BackBuffer
{
	public IFrameBuffer frameBuffer;
	public IDescriptor colorAttachment;
	public ITexture texture;
}

class SampleApplication : Application
{
	private const uint32 BUFFERED_FRAME_MAX_NUM = 3;
	private const uint32 SWAP_CHAIN_TEXTURE_NUM  = BUFFERED_FRAME_MAX_NUM;

	private IDevice mDevice;
	private DeviceLogger mDeviceLogger;
	private DeviceAllocator<uint8> mDeviceAllocator;

	private ISwapChain mSwapChain = null;
	private ICommandQueue mCommandQueue = null;
	private IFence mFrameFence = null;

	private Frame[BUFFERED_FRAME_MAX_NUM] m_Frames = .();
	private List<BackBuffer> m_SwapChainBuffers = new .() ~ delete _;

	private uint32 mFrameIndex = 0;

	public this(IApplicationHost host, ApplicationConfiguration configuration)
		: base(host, configuration)
	{
	}

	protected override void OnInitialized()
	{
		Logger.LogInformation(nameof(OnInitialized));
		var window = Host.Platform.WindowSystem.PrimaryWindow;

		mDeviceLogger = new .(.VULKAN, default);
		mDeviceAllocator = new .(MemoryAllocatorInterface());
		DeviceCreationDesc desc = .();

		CreateDeviceVK(mDeviceLogger, mDeviceAllocator, desc, out mDevice);

		Result result = .SUCCESS;

		// Command queue
		result = mDevice.GetCommandQueue(CommandQueueType.GRAPHICS, out mCommandQueue);
		if (result != .SUCCESS)
		{
			Runtime.FatalError(scope $"Error: {result}");
		}

		// Fences
		result = mDevice.CreateFence(0, out mFrameFence);
		if (result != .SUCCESS)
		{
			Runtime.FatalError(scope $"Error: {result}");
		}

		// Swap chain
		Format swapChainFormat = default;
		{
			SwapChainDesc swapChainDesc = .();
			swapChainDesc.windowSystemType = .WINDOWS;
			swapChainDesc.window = .()
				{
					windows = .()
						{
							hwnd = window.NativePointers.Get("hwnd")
						}
				};
			swapChainDesc.commandQueue = mCommandQueue;
			swapChainDesc.format = SwapChainFormat.BT709_G22_8BIT;
			swapChainDesc.verticalSyncInterval = 1; //m_VsyncInterval;
			swapChainDesc.width = (uint16)window.Width;
			swapChainDesc.height = (uint16)window.Height;
			swapChainDesc.textureNum = SWAP_CHAIN_TEXTURE_NUM;
			result = mDevice.CreateSwapChain(swapChainDesc, out mSwapChain);
			if (result != .SUCCESS)
			{
				Runtime.FatalError(scope $"Error: {result}");
			}

			uint32 swapChainTextureNum = 0;
			ITexture* swapChainTextures = mSwapChain.GetTextures(ref swapChainTextureNum, ref swapChainFormat);

			for (uint32 i = 0; i < swapChainTextureNum; i++)
			{
				Texture2DViewDesc textureViewDesc = .() { texture = swapChainTextures[i], viewType = Texture2DViewType.COLOR_ATTACHMENT, format = swapChainFormat };

				IDescriptor colorAttachment = null;
				mDevice.CreateTexture2DView(textureViewDesc, out colorAttachment);

				FrameBufferDesc frameBufferDesc = .();
				frameBufferDesc.colorAttachmentNum = 1;
				frameBufferDesc.colorAttachments = &colorAttachment;
				IFrameBuffer frameBuffer = null;
				mDevice.CreateFrameBuffer(frameBufferDesc, out frameBuffer);

				readonly BackBuffer backBuffer = .() { frameBuffer = frameBuffer, colorAttachment = colorAttachment, texture = swapChainTextures[i] };
				m_SwapChainBuffers.Add(backBuffer);
			}
		}

		// Buffered resources
		for (ref Frame frame in ref m_Frames)
		{
			result = mDevice.CreateCommandAllocator(mCommandQueue, WHOLE_DEVICE_GROUP, out frame.commandAllocator);
			if (result != .SUCCESS)
			{
				Runtime.FatalError(scope $"Error: {result}");
			}
			result = frame.commandAllocator.CreateCommandBuffer(out frame.commandBuffer);
			if (result != .SUCCESS)
			{
				Runtime.FatalError(scope $"Error: {result}");
			}
		}
	}

	protected override void OnShutdown()
	{
		Logger.LogInformation(nameof(OnShutdown));

		mCommandQueue.WaitForIdle();

		for (ref Frame frame in ref m_Frames)
		{
			mDevice.DestroyCommandBuffer(frame.commandBuffer);
			mDevice.DestroyCommandAllocator(frame.commandAllocator);
		}

		for (ref BackBuffer backBuffer in ref m_SwapChainBuffers)
		{
			mDevice.DestroyFrameBuffer(backBuffer.frameBuffer);
			mDevice.DestroyDescriptor(backBuffer.colorAttachment);
		}

		mDevice.DestroyFence(mFrameFence);
		mDevice.DestroySwapChain(mSwapChain);

		DestroyDeviceVK(mDevice);
		delete mDeviceAllocator;
		delete mDeviceLogger;
	}

	protected override void OnPostUpdate(ApplicationUpdateInfo info)
	{
		//double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		//mLogger.LogInformation("{0} {1} {2}", nameof(OnPostUpdate), info.Time.ElapsedTime, fps);
	}

	protected override void OnUpdate(ApplicationUpdateInfo info)
	{
		RenderFrame(mFrameIndex++);
	}

	private void RenderFrame(uint32 frameIndex)
	{
		var window = Host.Platform.WindowSystem.PrimaryWindow;

		readonly uint32 windowWidth = (.)window.Width;
		readonly uint32 windowHeight = (.)window.Height;
		readonly uint32 bufferedFrameIndex = frameIndex % BUFFERED_FRAME_MAX_NUM;
		/*readonly*/ ref Frame frame = ref m_Frames[bufferedFrameIndex];

		if (frameIndex >= BUFFERED_FRAME_MAX_NUM)
		{
			mFrameFence.Wait(1 + frameIndex - BUFFERED_FRAME_MAX_NUM);
			frame.commandAllocator.Reset();
		}

		readonly uint32 backBufferIndex = mSwapChain.AcquireNextTexture();
		readonly ref BackBuffer backBuffer = ref m_SwapChainBuffers[backBufferIndex];

		ICommandBuffer commandBuffer = frame.commandBuffer;
		commandBuffer.Begin(null, 0);
		{
			TextureTransitionBarrierDesc textureTransitionBarrierDesc = .();
			textureTransitionBarrierDesc.texture = backBuffer.texture;
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

			commandBuffer.BeginRenderPass(backBuffer.frameBuffer, RenderPassBeginFlag.NONE);
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
		commandBuffer.End();

		QueueSubmitDesc queueSubmitDesc = .();
		queueSubmitDesc.commandBuffers = &frame.commandBuffer;
		queueSubmitDesc.commandBufferNum = 1;
		mCommandQueue.Submit(queueSubmitDesc);

		mSwapChain.Present();

		mFrameFence.QueueSignal(mCommandQueue, 1 + frameIndex);
	}
}