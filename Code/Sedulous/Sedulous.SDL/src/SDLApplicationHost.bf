using Sedulous.Framework;
using SDL2;
using System;
using Sedulous.SDL.Platform;
using Sedulous.Framework.Platform;
namespace Sedulous.SDL;

using internal Sedulous.Framework;

abstract class SDLApplicationHost : IApplicationHost
{
	private static bool sSDLInitialized = false;

	static this()
	{
		if (SDL.Init(.Everything) < 0)
		{
			Runtime.FatalError(scope $"SDL initialization failed: {SDL.GetError()}");
		}
		sSDLInitialized = true;
	}

	static ~this()
	{
		if (sSDLInitialized)
		{
			SDL.Quit();
		}
	}

	private bool mExitRequested;

	private readonly SDLWindowSystem mWindowSystem = new .() ~ delete _;
	private SDLWindow mPrimaryWindow = null;

	private readonly WindowConfiguration mPrimaryWindowConfiguration;

	public this(WindowConfiguration primaryWindowConfiguration)
	{
		mPrimaryWindowConfiguration = primaryWindowConfiguration;
	}

	public ~this()
	{
	}

	protected abstract Application CreateApplication(ApplicationConfiguration configuration);

	protected abstract void DestroyApplication(Application application);

	public void Exit()
	{
		mExitRequested = true;
	}

	public void Run()
	{
		mExitRequested = false;

		var configuration = scope ApplicationConfiguration();

		var application = CreateApplication(configuration);
		defer DestroyApplication(application);

		mWindowSystem.WindowManager.CreateWindow(
			title: mPrimaryWindowConfiguration.Title,
			width: mPrimaryWindowConfiguration.Width,
			height: mPrimaryWindowConfiguration.Height,
			visible: true,
			window: var mPrimaryWindow);
		defer mWindowSystem.WindowManager.DestroyWindow(mPrimaryWindow);

		application.Initialize();
		defer application.Shutdown();

		while (!mExitRequested)
		{
			ProcessEvents();
			application.Update();
		}
	}

	private void ProcessEvents()
	{
		while (SDL.PollEvent(let ev) != 0)
		{
			var sdlWindow = (SDLWindow)mWindowSystem.WindowManager.GetWindowById((int32)ev.window.windowID);

			switch (ev.type) {
			case .Quit:
				Exit();
				return;

			case .WindowEvent:
				{
					if (ev.window.windowEvent == .Close)
					{
						// If this is the primary window then stop running
						if (sdlWindow == (SDLWindow)mWindowSystem.WindowManager.PrimaryWindow)
						{
							Exit();
							return;
						}
					}
				}
				break;

			default: break;
			}
		}
	}
}