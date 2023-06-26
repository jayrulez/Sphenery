using Sedulous.Framework;
using Sedulous.Core.Logging.Abstractions;
using Sedulous.Foundation.Logging.Debug;
namespace Sample01_BasicApplication;

class SampleApplication : Application
{
	private readonly ILogger mLogger ~ delete _;

	public this(ApplicationConfiguration configuration)
		: base(mLogger = new DebugLogger(.Trace), configuration)
	{
	}

	protected override void OnInitializing()
	{
		mLogger.LogInformation(nameof(OnInitializing));
	}

	protected override void OnInitialized()
	{
		mLogger.LogInformation(nameof(OnInitialized));
	}

	protected override void OnShuttingdown()
	{
		mLogger.LogInformation(nameof(OnShuttingdown));
	}

	protected override void OnShutdown()
	{
		mLogger.LogInformation(nameof(OnShutdown));
	}

	protected override void OnPreUpdate(ApplicationUpdateInfo info)
	{
		double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		mLogger.LogInformation("{0} {1} {2}", nameof(OnPreUpdate), info.Time.ElapsedTime, fps);
	}

	protected override void OnPostUpdate(ApplicationUpdateInfo info)
	{
		double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		mLogger.LogInformation("{0} {1} {2}", nameof(OnPostUpdate), info.Time.ElapsedTime, fps);
	}

	protected override void OnUpdate(ApplicationUpdateInfo info)
	{
		double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		mLogger.LogInformation("{0} {1} {2}", nameof(OnUpdate), info.Time.ElapsedTime, fps);
	}

	protected override void OnFixedUpdate(ApplicationUpdateInfo info)
	{
		double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		mLogger.LogInformation("{0} {1} {2}", nameof(OnFixedUpdate), info.Time.ElapsedTime, fps);
	}
}