namespace Sphenery.RHI.Helpers;

class ResourceStateChangeHelper
{
	private readonly IDevice m_Device;
	private readonly ICommandQueue m_CommandQueue;
	private ICommandAllocator m_CommandAllocator = null;
	private ICommandBuffer m_CommandBuffer = null;
	private readonly WaitIdleHelper m_WaitIdleHelper;

	public this(IDevice device, ICommandQueue commandQueue)
	{
		m_Device = device;
		m_CommandQueue = commandQueue;

		m_WaitIdleHelper = new .(m_Device, m_CommandQueue);

		if (m_Device.CreateCommandAllocator(commandQueue, WHOLE_DEVICE_GROUP, out m_CommandAllocator) == Result.SUCCESS)
			m_CommandAllocator.CreateCommandBuffer(out m_CommandBuffer);
	}

	public ~this()
	{
		if (m_CommandBuffer != null)
			m_Device.DestroyCommandBuffer(m_CommandBuffer);
		m_CommandBuffer = null;

		if (m_CommandAllocator != null)
			m_Device.DestroyCommandAllocator(m_CommandAllocator);
		m_CommandAllocator = null;

		delete m_WaitIdleHelper;
	}

	public Result ChangeStates(TransitionBarrierDesc transitionBarriers)
	{
		if (m_CommandBuffer == null)
			return Result.FAILURE;

		var transitionBarriers;

		readonly uint32 physicalDeviceNum = m_Device.GetDesc().physicalDeviceNum;

		for (uint32 i = 0; i < physicalDeviceNum; i++)
		{
			m_CommandBuffer.Begin(null, i);
			{
				m_CommandBuffer.PipelineBarrier(&transitionBarriers, null, BarrierDependency.ALL_STAGES);
			}
			m_CommandBuffer.End();

			QueueSubmitDesc queueSubmitDesc = .();
			queueSubmitDesc.physicalDeviceIndex = i;
			queueSubmitDesc.commandBufferNum = 1;
			queueSubmitDesc.commandBuffers = &m_CommandBuffer;

			m_CommandQueue.Submit(queueSubmitDesc);
		}

		return m_WaitIdleHelper.WaitIdle();
	}
}