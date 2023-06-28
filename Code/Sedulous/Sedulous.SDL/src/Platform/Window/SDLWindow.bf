using Sedulous.Framework.Platform;
using System;
using SDL2;
using Sedulous.Framework.Platform.Window;
using Sedulous.Core.Mathematics;
namespace Sedulous.SDL.Platform.Window;

using internal Sedulous.SDL.Platform.Window;

class SDLWindow : IWindow
{
        // State values.
	private SDL.Window* mSDLNativeWindow;
        private WindowMode windowMode = WindowMode.Windowed;
        private WindowStatusFlags windowStatus = WindowStatusFlags.None;
	
	// Property values.
	private Point2? windowedPosition;
	private Size2? windowedClientSize;

	public int32 Id => mId;

	public StringView Title => mTitle;

	public int32 Width => mWidth;

	public int32 Height => mHeight;

	public bool Visible => mVisible;

	private int32 mId;
	private String mTitle = new .() ~ delete _;
	private int32 mWidth;
	private int32 mHeight;
	private bool mVisible;

	/// <inheritdoc/>
	public Size2 ClientSize
	{
	    get
	    {
	        //Contract.EnsureNotDisposed(this, Disposed);

	        SDL.GetWindowSize(mSDLNativeWindow, var w, var h);
	        return Size2(w, h);
	    }
	    set
	    {
	        //Contract.EnsureNotDisposed(this, Disposed);

	        if (GetWindowMode() == WindowMode.Windowed && GetWindowState() == WindowState.Normal)
	        {
	            windowedClientSize = value;
	        }

	        SDL.SetWindowSize(mSDLNativeWindow, value.Width, value.Height);
	    }
	}

	public this(StringView title, int32 width, int32 height, bool visible)
	{
		SDL.WindowFlags flags = SDL.WindowFlags.Resizable;
		if (visible)
			flags |= .Shown;

		mSDLNativeWindow = SDL.CreateWindow(mTitle.CStr(), .Undefined, .Undefined, (int32)width, (int32)height, flags);

		if (mSDLNativeWindow == null)
		{
			Runtime.FatalError("Failed to create SDL window.");
		}

		mId = (int32)SDL.GetWindowID(mSDLNativeWindow);

		SDL.SDL_SysWMinfo info = .();
		SDL.GetVersion(out info.version);
		SDL.GetWindowWMInfo(mSDLNativeWindow, ref info);
		SDL.SDL_SYSWM_TYPE subsystem = info.subsystem;
		switch (subsystem) {
		case SDL.SDL_SYSWM_TYPE.SDL_SYSWM_WINDOWS:
			/*OSNativeWindow = (void*)(int)info.info.win.window;
			SurfaceInfo = .(.()
				{
					Windows = .()
						{
							Hwnd = NativeWindow
						}
				}, .Windows);*/
			break;

		case SDL.SDL_SYSWM_TYPE.SDL_SYSWM_UNKNOWN: fallthrough;
		default:
			Runtime.FatalError("Subsystem not currently supported.");
		}
	}

	public ~this()
	{
		if (mSDLNativeWindow != null)
		{
			SDL.DestroyWindow(mSDLNativeWindow);
			mSDLNativeWindow = null;
		}
	}

	/// <inheritdoc/>
	public void WarpMouseWithinWindow(int32 x, int32 y)
	{
	    //Contract.EnsureNotDisposed(this, Disposed);

	    SDL.WarpMouseInWindow(mSDLNativeWindow, x, y);
	}

	/// <inheritdoc/>
	public void SetWindowMode(WindowMode mode)
	{
	    //Contract.EnsureNotDisposed(this, Disposed);

	    if (windowMode == mode)
	        return;

	    /*UpdateWindowedPosition(Position);
	    UpdateWindowedClientSize(ClientSize);

	    switch (mode)
	    {
	        case WindowMode.Windowed:
	            {
	                if (SDL.SetWindowFullscreen(mSDLNativeWindow, 0) < 0)
	                    Runtime.FatalError("Failed to set window fullscreen");

	                var x = windowedPosition?.X ?? FrameworkConfiguration.DefaultWindowPositionX;
	                var y = windowedPosition?.Y ?? FrameworkConfiguration.DefaultWindowPositionY;
	                var w = windowedClientSize?.Width ?? FrameworkConfiguration.DefaultWindowClientWidth;
	                var h = windowedClientSize?.Height ?? FrameworkConfiguration.DefaultWindowClientHeight;

	                if (!ApplyWin32FullscreenWindowedFix_Windowed())
	                    SDL.SetWindowBordered(mSDLNativeWindow, true);

	                SDL.SetWindowSize(mSDLNativeWindow, w, h);
	                SDL.SetWindowPosition(mSDLNativeWindow, x, y);

	                if (FrameworkContext.Platform == FrameworkPlatform.Windows)
	                    win32CachedStyle = IntPtr.Zero;
	            }
	            break;

	        case WindowMode.Fullscreen:
	            {
	                if (displayMode != null)
	                {
	                    if (displayMode.DisplayIndex.HasValue)
	                    {
	                        var display = FrameworkContext.GetPlatform().Displays[displayMode.DisplayIndex.Value];
	                        ChangeDisplay(display);
	                    }
	                }
	                else
	                {
	                    SetDesktopDisplayMode();
	                }

	                if (SDL.SetWindowFullscreen(mSDLNativeWindow, (uint32)SDL_WINDOW_FULLSCREEN) < 0)
	                    throw new SDL2Exception();

	                if (FrameworkContext.Platform == FrameworkPlatform.Windows)
	                    win32CachedStyle = IntPtr.Zero;
	            }
	            break;

	        case WindowMode.FullscreenWindowed:
	            {
	                if (SDL.SetWindowFullscreen(mSDLNativeWindow, 0) < 0)
	                    Runtime.FatalError("Failed to set window fullscreen");

	                var displayBounds = Display.Bounds;

	                if (!ApplyWin32FullscreenWindowedFix_FullscreenWindowed())
	                    SDL.SetWindowBordered(mSDLNativeWindow, false);

	                SDL.SetWindowSize(mSDLNativeWindow, displayBounds.Width, displayBounds.Height);
	                SDL.SetWindowPosition(mSDLNativeWindow, displayBounds.X, displayBounds.Y);
	            }
	            break;

	        default:
	            Runtime.FatalError("Unsupported mode.");
	    }

	    windowMode = mode;
	    UpdateMouseGrab();*/
	}

	/// <inheritdoc/>
	public WindowMode GetWindowMode()
	{
	    //Contract.EnsureNotDisposed(this, Disposed);

	    return windowMode;
	}

	/// <inheritdoc/>
	public void SetWindowState(WindowState state)
	{
	    switch (state)
	    {
	        case WindowState.Normal:
	            SDL.RestoreWindow(mSDLNativeWindow);
	            break;

	        case WindowState.Minimized:
	            SDL.MinimizeWindow(mSDLNativeWindow);
	            break;

	        case WindowState.Maximized:
	            SDL.MaximizeWindow(mSDLNativeWindow);
	            break;

	        default:
	            Runtime.FatalError("Unsupported state");
	    }
	}

	/// <inheritdoc/>
	public WindowState GetWindowState()
	{
	    //Contract.EnsureNotDisposed(this, Disposed);

	    SDL.WindowFlags flags = (.)SDL.GetWindowFlags(mSDLNativeWindow);

	    if ((flags & .Maximized) == .Maximized)
	        return WindowState.Maximized;

	    if ((flags & .Minimized) == .Minimized)
	        return WindowState.Minimized;

	    return WindowState.Normal;
	}
}