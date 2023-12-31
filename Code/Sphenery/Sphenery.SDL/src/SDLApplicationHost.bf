using Sphenery.Framework;
using SDL2;
using System;
using Sphenery.SDL.Platform;
using Sphenery.Framework.Platform;
using Sphenery.Core.Messaging;
using Sphenery.Framework.Messaging;
using Sphenery.Framework.Platform.Window;
using Sphenery.SDL.Platform.Window;
using Sphenery.SDL.Platform.Input;
using System.Diagnostics;
using Sphenery.Core.Logging.Abstractions;
namespace Sphenery.SDL;

using internal Sphenery.Framework;

abstract class SDLApplicationHost : IApplicationHost, IMessageSubscriber<MessageId>
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

	private SDLPlatform mPlatform = null;
	public IPlatform Platform => mPlatform;

	private SDLWindow mPrimaryWindow = null;
	private Application mApplication = null;
	private readonly ApplicationTimeTracker mHostUpdateTimeTracker = new .() ~ delete _;
	private readonly Stopwatch mTimer = new .() ~ delete _;

	private readonly ILogger mLogger;
	public ILogger Logger => mLogger;

	private readonly WindowConfiguration mPrimaryWindowConfiguration;

	public this(ILogger logger, WindowConfiguration primaryWindowConfiguration)
	{
		mLogger = logger;
		mPrimaryWindowConfiguration = primaryWindowConfiguration;
	}

	public ~this()
	{
	}

	void IMessageSubscriber<MessageId>.ReceiveMessage(MessageId type, MessageData data)
	{
		OnReceivedMessage(type, data);
	}

	protected abstract Application CreateApplication();

	protected abstract void DestroyApplication(Application application);

	protected virtual void OnInitializingApplication(ApplicationInitializer initializer){}

	public void RequestExit()
	{
		mExitRequested = true;
	}

	public void Run()
	{
		mTimer.Start();
		defer mTimer.Stop();
		mExitRequested = false;

		mApplication = CreateApplication();
		defer DestroyApplication(mApplication);

		mPlatform = new SDLPlatform(mApplication);
		defer delete mPlatform;

		SDL.SetEventFilter( => SDLEventFilter, Internal.UnsafeCastToPtr(mApplication));
		defer SDL.SetEventFilter(null, null);

		mApplication.Messages.Subscribe(this, ApplicationMessages.Quit);
		defer mApplication.Messages.Unsubscribe(this);

		mPlatform.WindowSystem.CreateWindow(
			title: mPrimaryWindowConfiguration.Title,
			width: mPrimaryWindowConfiguration.Width,
			height: mPrimaryWindowConfiguration.Height,
			visible: true,
			window: var mPrimaryWindow);
		defer mPlatform.WindowSystem.DestroyWindow(mPrimaryWindow);

		var initializer = scope ApplicationInitializer();

		OnInitializingApplication(initializer);

		mApplication.Initialize(initializer);
		defer mApplication.Shutdown();

		while (!mExitRequested)
		{
			if (let sdlInputSystem = mPlatform.InputSystem as SDLInputSystem)
			{
				sdlInputSystem.ResetDeviceStates();
			}

			if (!PumpEvents())
			{
				break;
			}

			mTimer.Restart();

			mApplication.Update();
		}
	}

	private bool PumpEvents()
	{
		while (SDL.PollEvent(let ev) != 0)
		{
			var sdlWindow = (SDLWindow)mPlatform.WindowSystem.GetWindowById((int32)ev.window.windowID);

			switch (ev.type) {
			case .Quit:
				mApplication.Messages.Publish(ApplicationMessages.Quit, null);
				return true;

			case .WindowEvent:
				{
					if (ev.window.windowEvent == .Close)
					{
						// If this is the primary window then stop running
						if (sdlWindow == (SDLWindow)mPlatform.WindowSystem.PrimaryWindow)
						{
							mApplication.Messages.Publish(ApplicationMessages.Quit, null);
							return true;
						}
					}
				}
				break;

			case .KeyDown,
				.KeyUp,
				.MouseButtonDown,
				.MouseButtonUp,
				.MouseMotion,
				.MouseWheel,
				.JoyAxisMotion,
				.JoyBallMotion,
				.JoyButtonDown,
				.JoyButtonUp,
				.JoyHatMotion,
				.ControllerAxismotion,
				.ControllerButtondown,
				.ControllerButtonup:
				/*if (IsHardwareInputDisabled)
				{
					continue;
				}*/
				break;

			default: break;
			}

			// Publish any SDL events to the message queue.
			var data = mApplication.Messages.CreateMessageData<SDLEventMessageData>();
			data.Event = ev;
			mApplication.Messages.Publish(SDLMessages.SDLEvent, data);
		}

		return true; // todo: return false if application is disposed
	}

	protected virtual void OnReceivedMessage(MessageId type, MessageData data)
	{
		switch (type)
		{
		case ApplicationMessages.Quit:
			RequestExit();
			break;
		}
	}

	private static int32 SDLEventFilter(void* userData, SDL.Event* event)
	{
		if (userData == null || event == null)
		{
			return 1;
		}

		Application application = (Application)Internal.UnsafeCastToObject(userData);

		switch (event.type)
		{
		case .AppTerminating:
			application.Messages.PublishImmediate(ApplicationMessages.ApplicationTerminating, null);
			return 0;

		case .AppWillEnterBackground:
			application.Messages.PublishImmediate(ApplicationMessages.ApplicationSuspending, null);
			return 0;

		case .AppDidEnterBackground:
			application.Messages.PublishImmediate(ApplicationMessages.ApplicationSuspended, null);
			return 0;

		case .AppWillEnterForeground:
			application.Messages.PublishImmediate(ApplicationMessages.ApplicationResuming, null);
			return 0;

		case .AppDidEnterForeground:
			application.Messages.PublishImmediate(ApplicationMessages.ApplicationResumed, null);
			return 0;

		case .AppLowMemory:
			application.Messages.PublishImmediate(ApplicationMessages.LowMemory, null);
			return 0;

		default: return 1;
		}
	}
}