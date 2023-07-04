namespace Sedulous.RHI.Validation;

class CommandAllocatorVal : DeviceObjectVal<ICommandAllocator>, ICommandAllocator
{
	public this(DeviceVal device, ICommandAllocator commandAllocator)
		: base(device, commandAllocator)
	{
	}

		//================================================================================================================
		// NRI
		//================================================================================================================
	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}

	public Result CreateCommandBuffer(out ICommandBuffer commandBuffer)
	{
		commandBuffer = ?;
		ICommandBuffer commandBufferImpl;
		readonly Result result = m_ImplObject.CreateCommandBuffer(out commandBufferImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(m_Device.GetLogger(), commandBufferImpl != null, Result.FAILURE, "Implementation failure: 'commandBufferImpl' is NULL!");
			commandBuffer = (ICommandBuffer)Allocate!<CommandBufferVal>(m_Device.GetAllocator(), m_Device, commandBufferImpl, false);
		}

		return result;
	}

	public void Reset()
	{
		m_ImplObject.Reset();
	}
}