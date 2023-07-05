using Sphenery.Framework.Platform;
using System;
using SDL2;
using Sphenery.Framework.Platform.Window;
using Sphenery.Core.Mathematics;
using Sphenery.Core;
namespace Sphenery.SDL.Platform.Window;

using internal Sphenery.SDL.Platform.Window;

class SDLWindow : IWindow
{
	private readonly NativePointerRegistry mNativePointers = new .() ~ delete _;

	// Property values.
	private int32 mId;
	private String mTitle = new .() ~ delete _;
	//private bool mVisible;
	private Point2? windowedPosition;
	private Size2? windowedClientSize;
	private bool grabsMouseWhenWindowed;
	private bool grabsMouseWhenFullscreenWindowed;
	private bool grabsMouseWhenFullscreen;
	//private Surface2D icon;

	private IWindowSystem mWindowSystem;
	public IWindowSystem WindowSystem => mWindowSystem;

	// State values.
	private SDL.Window* mSDLNativeWindow;
	private WindowMode windowMode = WindowMode.Windowed;
	private WindowStatusFlags windowStatus = WindowStatusFlags.None;
	private DisplayMode displayMode;

	public NativePointerRegistry NativePointers => mNativePointers;
	public int32 Id => mId;
	public StringView Title => mTitle;
	//public bool Visible => mVisible;

	/// <inheritdoc/>
	public float WindowScale { get; private set; }

	/// <inheritdoc/>
	public Point2 Position
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SDL.GetWindowPosition(mSDLNativeWindow, var x, var y);
			return Point2(x, y);
		}
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			if (GetWindowMode() == WindowMode.Windowed && GetWindowState() == WindowState.Normal)
				windowedPosition = value;

			SDL.SetWindowPosition(mSDLNativeWindow, value.X, value.Y);
		}
	}

	/// <inheritdoc/>
	public Point2 WindowedPosition
	{
		get => windowedPosition.GetValueOrDefault();
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			windowedPosition = value;
			if (GetWindowMode() == WindowMode.Windowed && GetWindowState() == WindowState.Normal)
			{
				SDL.SetWindowPosition(mSDLNativeWindow, value.X, value.Y);
			}
		}
	}

	/// <inheritdoc/>
	public Size2 DrawableSize
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			int32 w, h;

			var isOpenGLWindow = (this.windowStatus & WindowStatusFlags.OpenGL) == WindowStatusFlags.OpenGL;
			if (isOpenGLWindow)
			{
				SDL.GL_GetDrawableSize(mSDLNativeWindow, out w, out h);
			}
			else
			{
				SDL.GetWindowSize(mSDLNativeWindow, out w, out h);
			}

			return Size2(w, h);
		}
	}

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

	/// <inheritdoc/>
	public Size2 WindowedClientSize
	{
		get => windowedClientSize.GetValueOrDefault();
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			windowedClientSize = value;
			if (GetWindowMode() == WindowMode.Windowed && GetWindowState() == WindowState.Normal)
			{
				SDL.SetWindowSize(mSDLNativeWindow, value.Width, value.Height);
			}
		}
	}

	/// <inheritdoc/>
	public Size2 MinimumClientSize
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SDL.GetWindowMinimumSize(mSDLNativeWindow, var w, var h);
			return Size2(w, h);
		}
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SDL.SetWindowMinimumSize(mSDLNativeWindow, value.Width, value.Height);
		}
	}

	/// <inheritdoc/>
	public Size2 MaximumClientSize
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SDL.GetWindowMaximumSize(mSDLNativeWindow, var w, var h);
			return Size2(w, h);
		}
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SDL.SetWindowMaximumSize(mSDLNativeWindow, value.Width, value.Height);
		}
	}

	/// <inheritdoc/>
	public bool SynchronizeWithVerticalRetrace { get; set; } = true;

	/// <inheritdoc/>
	public bool Active =>
		(windowStatus & WindowStatusFlags.Focused) == WindowStatusFlags.Focused &&
		(windowStatus & WindowStatusFlags.Minimized) != WindowStatusFlags.Minimized;

	/// <inheritdoc/>
	public bool Visible
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SDL.WindowFlags flags = (.)SDL.GetWindowFlags(mSDLNativeWindow);
			return (flags & SDL.WindowFlags.Shown) == SDL.WindowFlags.Shown;
		}
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			if (value)
			{
				SDL.ShowWindow(mSDLNativeWindow);
			}
			else
			{
				SDL.HideWindow(mSDLNativeWindow);
			}
		}
	}

	/// <inheritdoc/>
	public bool Resizable
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SDL.WindowFlags flags = (.)SDL.GetWindowFlags(mSDLNativeWindow);
			return (flags & SDL.WindowFlags.Resizable) == SDL.WindowFlags.Resizable;
		}
	}

	/// <inheritdoc/>
	public bool Borderless
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SDL.WindowFlags flags = (.)SDL.GetWindowFlags(mSDLNativeWindow);
			return (flags & SDL.WindowFlags.Borderless) == SDL.WindowFlags.Borderless;
		}
	}

	/// <inheritdoc/>
	public bool Native { get; }

	/// <inheritdoc/>
	public bool GrabsMouseWhenWindowed
	{
		get => grabsMouseWhenWindowed;
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			grabsMouseWhenWindowed = value;
			UpdateMouseGrab();
		}
	}

	/// <inheritdoc/>
	public bool GrabsMouseWhenFullscreenWindowed
	{
		get => grabsMouseWhenFullscreenWindowed;
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			grabsMouseWhenFullscreenWindowed = value;
			UpdateMouseGrab();
		}
	}

	/// <inheritdoc/>
	public bool GrabsMouseWhenFullscreen
	{
		get => grabsMouseWhenFullscreen;
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			grabsMouseWhenFullscreen = value;
			UpdateMouseGrab();
		}
	}

	/// <inheritdoc/>
	public float Opacity
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			float opacity;
			SDL.GetWindowOpacity(mSDLNativeWindow, out opacity);
			return opacity;
		}
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);
			var value;
			value = Math.Clamp(value, 0.0f, 1.0f);
			SDL.SetWindowOpacity(mSDLNativeWindow, value);
		}
	}

	/// <inheritdoc/>
	/*
	public Surface2D Icon
	{
		get => icon;
		set
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			SetIcon(value ?? DefaultWindowIcon);
			icon = value;
		}
	}
	*/

	/// <inheritdoc/>
	//public Compositor Compositor { get; private set; }

	/// <inheritdoc/>
	public IDisplay Display
	{
		get
		{
			//Contract.EnsureNotDisposed(this, Disposed);

			var index = SDL.GetWindowDisplayIndex(mSDLNativeWindow);
			var platform = WindowSystem.Platform;
			if (platform != null)
				return platform.Displays[index];

			return null;
		}
	}

	public this(IWindowSystem windowSystem, StringView title, int32 width, int32 height, bool visible)
	{
		mWindowSystem = windowSystem;

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
			mNativePointers.Set("hwnd", (void*)(int)info.info.win.window);
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

		UpdateWindowedPosition(Position);
		UpdateWindowedClientSize(ClientSize);

		SDL.WindowFlags windowFlags = (.)SDL.GetWindowFlags(mSDLNativeWindow);

		if ((windowFlags & SDL.WindowFlags.OpenGL) == SDL.WindowFlags.OpenGL)
			this.windowStatus |= WindowStatusFlags.OpenGL;

		if ((windowFlags & SDL.WindowFlags.Vulkan) == SDL.WindowFlags.Vulkan)
			this.windowStatus |= WindowStatusFlags.Vulkan;

		if ((windowFlags & SDL.WindowFlags.InputFocus) == SDL.WindowFlags.InputFocus)
			this.windowStatus |= WindowStatusFlags.Focused;

		if ((windowFlags & SDL.WindowFlags.Minimized) == SDL.WindowFlags.Minimized)
			this.windowStatus |= WindowStatusFlags.Minimized;

		if ((windowFlags & SDL.WindowFlags.Hidden) == SDL.WindowFlags.Hidden && visible)
			this.windowStatus |= WindowStatusFlags.Unshown;

		this.WindowScale = Display?.DensityScale ?? 1f;
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
	public void SetFullscreenDisplayMode(DisplayMode displayMode)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		SetFullscreenDisplayModeInternal(displayMode);
	}

	/// <inheritdoc/>
	public void SetFullscreenDisplayMode(int32 width, int32 height, int32 bpp, int32 refresh, int32? displayIndex = null)
	{
		//Contract.EnsureNotDisposed(this, Disposed);
		//Contract.EnsureRange(width > 0, nameof(width));
		//Contract.EnsureRange(height > 0, nameof(height));
		//Contract.EnsureRange(bpp > 0, nameof(bpp));
		//Contract.EnsureRange(refresh > 0, nameof(refresh));

		if (displayIndex.HasValue)
		{
			var displayIndexValue = displayIndex.Value;
			if (displayIndexValue < 0 || displayIndexValue >= WindowSystem.Platform.Displays.Count)
				Runtime.FatalError(scope $"Display index {displayIndex} out of range.");
		}

		SetFullscreenDisplayModeInternal(new DisplayMode(width, height, bpp, refresh, displayIndex));
	}

	/// <inheritdoc/>
	public DisplayMode GetFullscreenDisplayMode()
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		return displayMode;
	}

	/// <inheritdoc/>
	public void SetWindowBounds(Rectangle bounds, float scale = 1f)
	{
		//Contract.EnsureNotDisposed(this, Disposed);
		//Contract.EnsureRange(scale >= 1f, nameof(scale));

		this.WindowedPosition = bounds.Location;
		this.WindowedClientSize = bounds.Size;
		this.WindowScale = scale;
	}

	/// <inheritdoc/>
	public void SetWindowedClientSize(Size2 size, float scale = 1f)
	{
		//Contract.EnsureNotDisposed(this, Disposed);
		//Contract.EnsureRange(scale >= 1f, nameof(scale));

		this.WindowedClientSize = size;
		this.WindowScale = scale;
	}

	/// <inheritdoc/>
	public void SetWindowedClientSizeCentered(Size2 size, float scale = 1f)
	{
		//Contract.EnsureNotDisposed(this, Disposed);
		//Contract.EnsureRange(scale >= 1f, nameof(scale));

		this.WindowedClientSize = size;
		this.WindowScale = scale;
		this.WindowedPosition = Point2((int32)SDL.WindowPos.Centered, (int32)SDL.WindowPos.Centered);
	}

	/// <inheritdoc/>
	public void SetWindowMode(WindowMode mode)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		if (windowMode == mode)
			return;

		UpdateWindowedPosition(Position);
		UpdateWindowedClientSize(ClientSize);
		switch (mode)
		{
		case WindowMode.Windowed:
			{
				if (SDL.SetWindowFullscreen(mSDLNativeWindow, 0) < 0)
					Runtime.FatalError("Failed to set window fullscreen");

				/*var x = windowedPosition?.X ?? FrameworkConfiguration.DefaultWindowPositionX;
				var y = windowedPosition?.Y ?? FrameworkConfiguration.DefaultWindowPositionY;
				var w = windowedClientSize?.Width ?? FrameworkConfiguration.DefaultWindowClientWidth;
				var h = windowedClientSize?.Height ?? FrameworkConfiguration.DefaultWindowClientHeight;

				if (!ApplyWin32FullscreenWindowedFix_Windowed())
					SDL.SetWindowBordered(mSDLNativeWindow, true);

				SDL.SetWindowSize(mSDLNativeWindow, w, h);
				SDL.SetWindowPosition(mSDLNativeWindow, x, y);

				if (FrameworkContext.Platform == FrameworkPlatform.Windows)
					win32CachedStyle = IntPtr.Zero;*/
			}
			break;

		case WindowMode.Fullscreen:
			{
				if (displayMode != null)
				{
					if (displayMode.DisplayIndex.HasValue)
					{
						//var display = FrameworkContext.GetPlatform().Displays[displayMode.DisplayIndex.Value];
						//ChangeDisplay(display);
					}
				}
				else
				{
					SetDesktopDisplayMode();
				}

				if (SDL.SetWindowFullscreen(mSDLNativeWindow, (uint32)SDL.WindowFlags.Fullscreen) < 0)
					Runtime.FatalError("Failed to set fullscreen");

				//if (FrameworkContext.Platform == FrameworkPlatform.Windows)
				//	win32CachedStyle = IntPtr.Zero;
			}
			break;

		case WindowMode.FullscreenWindowed:
			{
				if (SDL.SetWindowFullscreen(mSDLNativeWindow, 0) < 0)
					Runtime.FatalError("Failed to set window fullscreen");

				var displayBounds = Display.Bounds;

				//if (!ApplyWin32FullscreenWindowedFix_FullscreenWindowed())
				//	SDL.SetWindowBordered(mSDLNativeWindow, false);

				SDL.SetWindowSize(mSDLNativeWindow, displayBounds.Width, displayBounds.Height);
				SDL.SetWindowPosition(mSDLNativeWindow, displayBounds.X, displayBounds.Y);
			}
			break;

		default:
			Runtime.FatalError("Unsupported mode.");
		}
		windowMode = mode;
		UpdateMouseGrab();
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

	/// <inheritdoc/>
	/*public void ChangeCompositor(Compositor compositor)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		if (compositor.Window != this)
			throw new InvalidOperationException(FrameworkStrings.CompositorAssociatedWithWrongWindow);

		if (IsCurrentWindow)
			throw new InvalidOperationException(FrameworkStrings.CannotChangeCompositorWhileCurrent);

		this.Compositor?.Dispose();
		this.Compositor = compositor ?? DefaultCompositor.Create(this);
	}*/

	/// <inheritdoc/>
	public void ChangeDisplay(int32 displayIndex)
	{
		var displayIndex;
		//Contract.EnsureNotDisposed(this, Disposed);

		if (displayIndex < 0 || displayIndex >= WindowSystem.Platform.Displays.Count)
			displayIndex = 0;

		var display = WindowSystem.Platform.Displays[displayIndex];
		ChangeDisplay(display);
	}

	/// <inheritdoc/>
	public void ChangeDisplay(IDisplay display)
	{
		//Contract.EnsureNotDisposed(this, Disposed);
		//Contract.Require(display, nameof(display));

		if (Display == display)
			return;

		var x = display.Bounds.Center.X - (ClientSize.Width / 2);
		var y = display.Bounds.Center.Y - (ClientSize.Height / 2);

		Position = Point2(x, y);
	}

	/// <summary>
	/// Sets the window's fullscreen display mode.
	/// </summary>
	/// <param name="displayMode">The fullscreen display mode to set, or null to use the desktop display mode.</param>
	private void SetFullscreenDisplayModeInternal(DisplayMode displayMode)
	{
		var displayMode;
		if (displayMode == null)
		{
			SetDesktopDisplayMode();
		}
		else
		{
			SDL.SDL_DisplayMode sdlMode = .();
			sdlMode.w = displayMode.Width;
			sdlMode.h = displayMode.Height;
			sdlMode.refresh_rate = displayMode.RefreshRate;
			switch (displayMode.BitsPerPixel)
			{
			case 15:
				sdlMode.format = SDL.PIXELFORMAT_RGB555;
				break;

			case 16:
				sdlMode.format = SDL.PIXELFORMAT_RGB565;
				break;

			default:
				sdlMode.format = SDL.PIXELFORMAT_RGB888;
				break;
			}

			var wasFullscreen = windowMode == WindowMode.Fullscreen;
			if (wasFullscreen)
				SetWindowMode(WindowMode.Windowed);

			if (SDL.SetWindowDisplayMode(mSDLNativeWindow, ref sdlMode) < 0)
				Runtime.FatalError("Failed to set display mode.");

			if (wasFullscreen)
			{
				if (displayMode.DisplayIndex.HasValue)
				{
					ChangeDisplay(displayMode.DisplayIndex.Value);
				}
				SetWindowMode(WindowMode.Fullscreen);
			}

			if (SDL.GetWindowDisplayMode(mSDLNativeWindow, out sdlMode) < 0)
				Runtime.FatalError("GetWindowDisplayMode failed.");

			int32 bpp;
			uint32 Rmask, Gmask, Bmask, Amask;
			SDL.PixelFormatEnumToMasks((uint32)sdlMode.format, out bpp, out Rmask, out Gmask, out Bmask, out Amask);

			var displayIndex = displayMode.DisplayIndex;
			if (displayIndex.HasValue)
			{
				if (displayIndex < 0 || displayIndex >= WindowSystem.Platform.Displays.Count)
					displayIndex = null;
			}

			displayMode = new DisplayMode(sdlMode.w, sdlMode.h, bpp, sdlMode.refresh_rate, displayIndex);
		}
		this.displayMode = displayMode;
	}

	/// <summary>
	/// Sets the window's icon.
	/// </summary>
	/// <param name="surface">The surface that contains the icon to set.</param>
	/*private void SetIcon(Surface2D surface)
	{
		var surfptr = (surface == null) ? null : ((SDL2Surface2D)surface).NativePtr;
		SDL_SetWindowIcon(ptr, (IntPtr)surfptr);
	}*/

	public EventAccessor<WindowEventHandler> Shown { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when the window is hidden.
	/// </summary>
	public EventAccessor<WindowEventHandler> Hidden { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when the window is minimized.
	/// </summary>
	public EventAccessor<WindowEventHandler> Minimized { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when the window is maximized.
	/// </summary>
	public EventAccessor<WindowEventHandler> Maximized { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when the window is restored.
	/// </summary>
	public EventAccessor<WindowEventHandler> Restored { get; } = new .() ~ delete _;

	/// <summary>
	/// Raises the Shown event.
	/// </summary>
	private void OnShown() =>
		Shown?.[Friend]Invoke(this);

	/// <summary>
	/// Raises the Hidden event.
	/// </summary>
	private void OnHidden() =>
		Hidden?.[Friend]Invoke(this);

	/// <summary>
	/// Raises the Maximized event.
	/// </summary>
	private void OnMaximized() =>
		Maximized?.[Friend]Invoke(this);

	/// <summary>
	/// Raises the Minimized event.
	/// </summary>
	private void OnMinimized() =>
		Minimized?.[Friend]Invoke(this);

	/// <summary>
	/// Raises the Restored event.
	/// </summary>
	private void OnRestored() =>
		Restored?.[Friend]Invoke(this);

	/// <summary>
	/// Called when the window's DPI changes.
	/// </summary>
	private void HandleDpiChanged(float? reportedScale = null)
	{
		// Inform our display that it needs to re-query DPI information.
		((SDLDisplay)Display)?.RefreshDensityInformation();

		// On Windows, resize the window to match the new scale.
		/*if (FrameworkContext.Platform == FrameworkPlatform.Windows && FrameworkContext.Properties.SupportsHighDensityDisplayModes)
		{
			var factor = (reportedScale ?? Display.DensityScale) / WindowScale;

			SDL.GetWindowPosition(mSDLNativeWindow, var windowX, var windowY);
			SDL.GetWindowSize(mSDLNativeWindow, var windowW, var windowH);
			
			var size = Size2((int32)(windowW * factor), (int32)(windowH * factor));
			var bounds = Rectangle(windowX, windowY, windowW, windowH);
			Rectangle.Inflate(ref bounds, (int32)Math.Ceiling((size.Width - windowW) / 2.0), 0, out bounds);

			WindowedPosition = bounds.Location;
			WindowedClientSize = size;
		}*/
		WindowScale = (reportedScale ?? Display.DensityScale);

		// Inform the rest of the system that this window's DPI has changed.
		//var messageData = FrameworkContext.Messages.CreateMessageData<WindowDensityChangedMessageData>();
		//messageData.Window = this;
		//FrameworkContext.Messages.Publish(FrameworkMessages.WindowDensityChanged, messageData);
	}

	/// <summary>
	/// Updates the window's windowed position, if it is currently in the correct mode and state.
	/// </summary>
	/// <param name="position">The new windowed position.</param>
	private void UpdateWindowedPosition(Point2 position)
	{
		if (windowedPosition == null || (GetWindowState() == WindowState.Normal && GetWindowMode() == WindowMode.Windowed))
		{
			windowedPosition = position;
		}
	}

	/// <summary>
	/// Updates the window's windowed client size, if it is currently in the correct mode and state.
	/// </summary>
	/// <param name="size">The new windowed client size.</param>
	private void UpdateWindowedClientSize(Size2 size)
	{
		if (windowedClientSize == null || (GetWindowState() == WindowState.Normal && GetWindowMode() == WindowMode.Windowed))
		{
			windowedClientSize = size;
		}
	}

	/// <summary>
	/// Updates the window's mouse grab state.
	/// </summary>
	private void UpdateMouseGrab()
	{
		switch (windowMode)
		{
		case WindowMode.Windowed:
			SDL.SetWindowGrab(mSDLNativeWindow, grabsMouseWhenWindowed);
			break;

		case WindowMode.Fullscreen:
			SDL.SetWindowGrab(mSDLNativeWindow, grabsMouseWhenFullscreen);
			break;

		case WindowMode.FullscreenWindowed:
			SDL.SetWindowGrab(mSDLNativeWindow, grabsMouseWhenFullscreenWindowed);
			break;
		}
	}

	/// <summary>
	/// Sets the window to use the desktop display mode for its current display.
	/// </summary>
	private void SetDesktopDisplayMode()
	{
		SDL.SDL_DisplayMode mode = default;
		if (SDL.GetDesktopDisplayMode(Display.Index, out mode) < 0)
			Runtime.FatalError("Failed to set desktop display mode.");

		if (SDL.SetWindowDisplayMode(mSDLNativeWindow, ref mode) < 0)
			Runtime.FatalError("Failed to set display mode.");
	}
}