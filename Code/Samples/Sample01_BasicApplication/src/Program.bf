using System;
using Sphenery.SDL;
using Sphenery.Framework;
using Sphenery.Framework.Platform;
using Sphenery.Framework.Platform.Window;
using Sphenery.Core.Logging.Abstractions;
using Sphenery.Foundation.Logging.Debug;
namespace Sample01_BasicApplication;

class Program : SDLApplicationHost
{
	private readonly SamplePlugin mSamplePlugin = new .() ~ delete _;
	private readonly ILogger mLogger ~ delete _;

	public this(WindowConfiguration primaryWindowConfiguration) : base(mLogger = new DebugLogger(.Trace), primaryWindowConfiguration)
	{
	}

	protected override void OnInitializingApplication(ApplicationInitializer initializer)
	{
		initializer.AddPlugin(mSamplePlugin);
		base.OnInitializingApplication(initializer);
	}

	protected override Application CreateApplication()
	{
		return new SampleApplication(this);
	}

	protected override void DestroyApplication(Application application)
	{
		delete application;
	}

	public static void Main(String[] args)
	{
		var host = new Program(.()
			{
				Title = "Sample01",
				Width = 1280,
				Height = 720
			});

		host.Run();

		delete host;
	}
}