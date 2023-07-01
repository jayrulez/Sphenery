namespace Sedulous.RHI.Implementation;

abstract class Device
{
	protected readonly DeviceLogger m_Logger;
	protected readonly DeviceAllocator<uint8> m_Allocator;

	public this(DeviceLogger logger, DeviceAllocator<uint8> allocator)
	{
		m_Logger = logger;
		m_Allocator = allocator;
	}

	public DeviceLogger GetLogger()
		{ return m_Logger; }

	public DeviceAllocator<uint8> GetAllocator()
		{ return m_Allocator; }

	public abstract void Destroy();
}