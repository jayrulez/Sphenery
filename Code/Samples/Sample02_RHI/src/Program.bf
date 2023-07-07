using Sphenery.SDL;
using Sphenery.Core.Logging.Abstractions;
using Sphenery.Foundation.Logging.Debug;
using Sphenery.Framework.Platform.Window;
using Sphenery.Framework;
using System;
namespace Sample02_RHI;

class Program : SDLApplicationHost
{
	private readonly ILogger mLogger ~ delete _;

	public this(WindowConfiguration primaryWindowConfiguration) : base(mLogger = new DebugLogger(.Trace), primaryWindowConfiguration)
	{
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