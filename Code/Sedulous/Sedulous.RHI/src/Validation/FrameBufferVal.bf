namespace Sedulous.RHI.Validation;

class FrameBufferVal : DeviceObjectVal<IFrameBuffer>, IFrameBuffer
{
	public this(DeviceVal device, IFrameBuffer frameBuffer) :
		base(device, frameBuffer)
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
}