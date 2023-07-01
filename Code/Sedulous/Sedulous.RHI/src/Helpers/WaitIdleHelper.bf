namespace Sedulous.RHI.Helpers;

class WaitIdleHelper
{
	private readonly IDevice m_Device;
	private readonly ICommandQueue m_CommandQueue;
	private IFence m_Fence = null;

	public this(IDevice device, ICommandQueue commandQueue)
	{
		m_Device = device;
		m_CommandQueue = commandQueue;

		m_Device.CreateFence(0, out m_Fence);
	}

	public ~this()
	{
		if (m_Fence != null)
			m_Device.DestroyFence(m_Fence);
		m_Fence = null;
	}

	public Result WaitIdle()
	{
		if (m_Fence == null)
			return Result.FAILURE;

		readonly uint32 physicalDeviceNum = m_Device.GetDesc().physicalDeviceNum;

		for (uint32 i = 0; i < physicalDeviceNum; i++)
		{
			m_CommandQueue.Signal(m_Fence, 1);
			m_Fence.Wait(1);
		}

		return Result.SUCCESS;
	}
}