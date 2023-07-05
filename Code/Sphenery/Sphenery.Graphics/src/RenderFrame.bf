using Sphenery.RHI;
namespace Sphenery.Graphics;

class RenderFrame
{
	private readonly ICommandBuffer mCommandBuffer = null;
	private readonly IFrameBuffer mFrameBuffer;
	private readonly ITexture mBackBufferTexture;
	private readonly uint32 mIndex;

	public ICommandBuffer CommandBuffer => mCommandBuffer;
	public IFrameBuffer FrameBuffer => mFrameBuffer;
	public ITexture BackBufferTexture => mBackBufferTexture;
	public uint32 FrameIndex => mIndex;

	internal this(uint32 frameIndex, ICommandBuffer commandBuffer, BackBuffer backBuffer){
		mIndex = frameIndex;
		mCommandBuffer = commandBuffer;

		mFrameBuffer = backBuffer.frameBuffer;
		mBackBufferTexture = backBuffer.texture;
	}
}