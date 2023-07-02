using Sedulous.RHI.Helpers;
namespace Sedulous.RHI;

interface ICommandQueue
{
	void SetDebugName(char8* name);
	//void Signal(IFence fence, uint64 value);
	//void Wait(IFence fence, uint64 value);
	void Submit(QueueSubmitDesc queueSubmitDesc);
	Result ChangeResourceStates(TransitionBarrierDesc transitionBarriers);
	Result UploadData(TextureUploadDesc* textureUploadDescs, uint32 textureUploadDescNum,
		BufferUploadDesc* bufferUploadDescs, uint32 bufferUploadDescNum);
	Result WaitForIdle();
}