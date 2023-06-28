using Sedulous.Framework;
using Sedulous.Core.Logging.Abstractions;
using Sedulous.Foundation.Logging.Debug;
using System.Threading;
namespace Sample01_BasicApplication;

class SampleApplication : Application
{
	public this(IApplicationHost host, ApplicationConfiguration configuration)
		: base(host, configuration)
	{
	}

	protected override void OnInitializing()
	{
		Logger.LogInformation(nameof(OnInitializing));
	}

	protected override void OnInitialized()
	{
		Logger.LogInformation(nameof(OnInitialized));

		JobSystem.AddJob(new () =>
			{
				Thread.Sleep(1000);
				Logger.LogInformation("Loading Task 1 finished.");
			}, "Load Task 1");

		JobSystem.AddJob(new () =>
			{
				//Thread.Sleep(1000);
				Logger.LogInformation("Loading Task 2 finished.");
			}, "Load Task 2");

		JobSystem.AddJob(new () =>
			{
				Logger.LogInformation("Loading on main thread started.");
				//Thread.Sleep(5000);
				Logger.LogInformation("Loading on main thread finished.");
			}, "Load Content", .RunOnMainThread);

		/*JobSystem.AddJob(new () =>
			{
				mLogger.LogInformation("Stop application.");
				Thread.Sleep(6000);
				//this.Exit();
				Logger.LogInformation("Stop application job completed.");
			}, "Stopping application", .RunOnMainThread);*/
	}

	protected override void OnShuttingdown()
	{
		Logger.LogInformation(nameof(OnShuttingdown));
	}

	protected override void OnShutdown()
	{
		Logger.LogInformation(nameof(OnShutdown));
	}

	protected override void OnPreUpdate(ApplicationUpdateInfo info)
	{
		//double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		//mLogger.LogInformation("{0} {1} {2}", nameof(OnPreUpdate), info.Time.ElapsedTime, fps);
	}

	protected override void OnPostUpdate(ApplicationUpdateInfo info)
	{
		//double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		//mLogger.LogInformation("{0} {1} {2}", nameof(OnPostUpdate), info.Time.ElapsedTime, fps);
	}

	protected override void OnUpdate(ApplicationUpdateInfo info)
	{
		if (Host.Platform.InputSystem.GetMouse().IsButtonClicked(.Left))
		{
			Logger.LogInformation("Left mouse button clicked.");
		}

		//double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		//mLogger.LogInformation("{0} {1} {2}", nameof(OnUpdate), info.Time.ElapsedTime, fps);
	}

	protected override void OnFixedUpdate(ApplicationUpdateInfo info)
	{
		//double fps = 1000 / info.Time.ElapsedTime.TotalMilliseconds;
		//mLogger.LogInformation("{0} {1} {2}", nameof(OnFixedUpdate), info.Time.ElapsedTime, fps);
	}
}