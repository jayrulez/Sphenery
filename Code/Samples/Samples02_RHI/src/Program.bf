using Sedulous.SDL;
using Sedulous.Core.Logging.Abstractions;
using Sedulous.Foundation.Logging.Debug;
using Sedulous.Framework.Platform.Window;
using Sedulous.Framework;
using System;
namespace Samples02_RHI;

class Program : SDLApplicationHost
{
	private readonly ILogger mLogger ~ delete _;

	public this(WindowConfiguration primaryWindowConfiguration) : base(mLogger = new DebugLogger(.Trace), primaryWindowConfiguration)
	{
	}

	protected override Application CreateApplication(ApplicationConfiguration configuration)
	{
		return new SampleApplication(this, configuration);
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