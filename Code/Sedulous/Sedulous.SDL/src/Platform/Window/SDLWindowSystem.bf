using Sedulous.Framework.Platform;
using System;
using System.Collections;
using Sedulous.Framework.Platform.Window;
namespace Sedulous.SDL.Platform.Window;

class SDLWindowSystem : IWindowSystem
{
	private SDLWindow mPrimaryWindow = null;
	private List<SDLWindow> mWindows = new .() ~ delete _;

	public IWindow PrimaryWindow => mPrimaryWindow;

	private readonly IPlatform mPlatform;

	public IPlatform Platform => mPlatform;

	public this(IPlatform platform)
	{
		mPlatform = platform;
	}

	public ~this()
	{
		for (var window in mWindows)
		{
			DestroyWindow(window);
		}
	}

	public Result<void> CreateWindow(StringView title, int32 width, int32 height, bool visible, out IWindow window)
	{
		var sdlWindow = new SDLWindow(title, width, height, visible);
		mWindows.Add(sdlWindow);

		window = sdlWindow;

		if (mPrimaryWindow == null)
		{
			mPrimaryWindow = sdlWindow;
		}

		return .Ok;
	}

	public void DestroyWindow(IWindow window)
	{
		if (let sdlWindow = window as SDLWindow)
		{
			if (mWindows.Contains(sdlWindow))
			{
				mWindows.Remove(sdlWindow);

				if (sdlWindow == mPrimaryWindow)
				{
					mPrimaryWindow = null;
				}

				delete sdlWindow;
			}
		}
	}

	public IWindow GetWindowById(int32 windowId)
	{
		for (var window in mWindows)
		{
			if (window.Id == windowId)
				return window;
		}
		return null;
	}
}