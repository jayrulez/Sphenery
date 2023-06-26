using System;
using Sedulous.SDL;
using Sedulous.Framework;
using Sedulous.Framework.Platform;
namespace Sample01_BasicApplication;

class Program : SDLApplicationHost
{
	private readonly SamplePlugin mSamplePlugin = new .() ~ delete _;

	public this(WindowConfiguration primaryWindowConfiguration) : base(primaryWindowConfiguration)
	{
	}

	protected override Application CreateApplication(ApplicationConfiguration configuration)
	{
		configuration.AddPlugin(mSamplePlugin);

		return new SampleApplication(configuration);
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