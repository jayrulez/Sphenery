using Sphenery.Framework;
using Sphenery.RHI;
using System.Collections;
using System;
using Sphenery.Framework.Platform.Window;
using Sphenery.Core;
namespace Sphenery.Graphics;

using internal Sphenery.Graphics;

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

delegate void GraphicsRenderDelegate(RenderFrame renderFrame);

class GraphicsPlugin : Plugin
{
	private const uint32 BUFFERED_FRAME_MAX_NUM = 3;
	private const uint32 SWAP_CHAIN_TEXTURE_NUM  = BUFFERED_FRAME_MAX_NUM;

	private uint32 m_VsyncInterval = 0;

	private ISwapChain mSwapChain = null;
	private ICommandQueue mCommandQueue = null;
	private IFence mFrameFence = null;

	private Frame[BUFFERED_FRAME_MAX_NUM] m_Frames = .();
	private List<BackBuffer> m_SwapChainBuffers = new .() ~ delete _;

	private uint32 mFrameIndex = 0;

	private readonly IDevice mDevice;
	private readonly IWindow mWindow;
	private TextureAssetLoader mTextureAssetLoader;

	public IWindow Window => mWindow;

	private readonly ApplicationUpdateFunctionInfo mRenderUpdateFunction = .()
		{
			Priority = -1,
			Stage = .PostUpdate,
			Function = new => this.Frame
		} ~ delete _.Function;

	public readonly EventAccessor<GraphicsRenderDelegate> OnRendering {get;} = new .() ~ delete _;

	public this(IDevice device, IWindow window)
	{
		mDevice = device;
		mWindow = window;
	}

	public override void Initialize(Application application)
	{
		mTextureAssetLoader = new .();

		application.ContentSystem.RegisterAssetLoader(mTextureAssetLoader);

		application.RegisterUpdateFunction(mRenderUpdateFunction);

		// Command queue
		var result = mDevice.GetCommandQueue(CommandQueueType.GRAPHICS, out mCommandQueue);
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
							hwnd = mWindow.NativePointers.Get("hwnd")
						}
				};
			swapChainDesc.commandQueue = mCommandQueue;
			swapChainDesc.format = SwapChainFormat.BT709_G22_8BIT;
			swapChainDesc.verticalSyncInterval = m_VsyncInterval;
			swapChainDesc.width = (uint16)mWindow.ClientSize.Width;
			swapChainDesc.height = (uint16)mWindow.ClientSize.Height;
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

	public override void Shutdown(Application application)
	{
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

		application.UnregisterUpdateFunction(mRenderUpdateFunction);

		application.ContentSystem.RemoveAssetLoader(mTextureAssetLoader);
		delete mTextureAssetLoader;
	}

	private void Frame(ApplicationUpdateInfo info)
	{
		//info.Application.Logger.LogInformation("Graphics Plugin render update");

		readonly uint32 bufferedFrameIndex = mFrameIndex % BUFFERED_FRAME_MAX_NUM;
		/*readonly*/ ref Frame frame = ref m_Frames[bufferedFrameIndex];

		if (mFrameIndex >= BUFFERED_FRAME_MAX_NUM)
		{
			mFrameFence.Wait(1 + mFrameIndex - BUFFERED_FRAME_MAX_NUM);
			frame.commandAllocator.Reset();
		}

		readonly uint32 backBufferIndex = mSwapChain.AcquireNextTexture();
		readonly ref BackBuffer backBuffer = ref m_SwapChainBuffers[backBufferIndex];

		ICommandBuffer commandBuffer = frame.commandBuffer;
		commandBuffer.Begin(null, 0);
		var renderFrame = scope RenderFrame(mFrameIndex, commandBuffer, backBuffer);
		{
			OnRendering.[Friend]Invoke(renderFrame);
		}
		
		commandBuffer.End();

		QueueSubmitDesc queueSubmitDesc = .();
		queueSubmitDesc.commandBuffers = &frame.commandBuffer;
		queueSubmitDesc.commandBufferNum = 1;
		mCommandQueue.Submit(queueSubmitDesc);

		mSwapChain.Present();

		mFrameFence.QueueSignal(mCommandQueue, 1 + mFrameIndex);

		mFrameIndex++;
	}
}