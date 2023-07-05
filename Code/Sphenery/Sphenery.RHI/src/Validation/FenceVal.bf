using System;
namespace Sphenery.RHI.Validation;

class FenceVal : DeviceObjectVal<IFence>, IFence
{
	[Inline] public this(DeviceVal device, IFence fence) : base(device, fence)
		{ }

	[Inline] public ~this()
		{ }

	//================================================================================================================
	// NRI
	//================================================================================================================

	public uint64 GetFenceValue()
	{
		return m_ImplObject.GetFenceValue();
	}

	public void QueueSignal(ICommandQueue commandQueue, uint64 value)
	{
		m_ImplObject.QueueSignal(((CommandQueueVal)commandQueue).GetImpl(), value);
	}

	public void QueueWait(ICommandQueue commandQueue, uint64 value)
	{
		m_ImplObject.QueueWait(((CommandQueueVal)commandQueue).GetImpl(), value);
	}

	public void Wait(uint64 value)
	{
		m_ImplObject.Wait(value);
	}

	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}
}