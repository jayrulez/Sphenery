using Sedulous.Framework;
using Sedulous.RHI;
using Sedulous.RHI.Vulkan;
namespace Samples02_RHI;

class SampleApplication : Application
{
	private IDevice mDevice;
	private DeviceLogger mDeviceLogger;
	private DeviceAllocator<uint8> mDeviceAllocator;

	public this(IApplicationHost host, ApplicationConfiguration configuration)
		: base(host, configuration)
	{
	}

	protected override void OnInitialized()
	{
		Logger.LogInformation(nameof(OnInitialized));
		
		mDeviceLogger = new .(.VULKAN, default);
		mDeviceAllocator = new .(MemoryAllocatorInterface());
		DeviceCreationDesc desc = .();

		CreateDeviceVK(mDeviceLogger, mDeviceAllocator, desc, out mDevice);
	}

	protected override void OnShutdown()
	{
		Logger.LogInformation(nameof(OnShutdown));

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
		//double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		//mLogger.LogInformation("{0} {1} {2}", nameof(OnUpdate), info.Time.ElapsedTime, fps);
	}
}