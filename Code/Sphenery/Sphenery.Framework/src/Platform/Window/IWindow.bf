using System;
using Sphenery.Core.Mathematics;
using Sphenery.Core;
namespace Sphenery.Framework.Platform.Window;

/// <summary>
/// Represents the method that is called when an Sphenery window raises an event.
/// </summary>
/// <param name="window">The window that raised the event.</param>
public delegate void WindowEventHandler(IWindow window);

/// <summary>
/// Represents a window that is attached to an Framework context.
/// </summary>
interface IWindow
{
	NativePointerRegistry NativePointers {get;}
	IWindowSystem WindowSystem {get;}
	
	/// <summary>
	/// Gets the window's identifier within its windowing system.
	/// </summary>
	int32 Id { get; }

	/// <summary>
	/// Gets or sets the window's caption.
	/// </summary>
	StringView Title { get; }

	/// <summary>
	/// Gets or sets the scaling factor which is applied to the window.
	/// </summary>
	float WindowScale{ get; }

	/// <summary>
	/// Gets or sets the window's position.
	/// </summary>
	Point2 Position { get; set; }

	/// <summary>
	/// Gets or sets the position to which the window will be restored upon entering non-maximized windowed mode.
	/// </summary>
	Point2 WindowedPosition{ get; set; }

	/// <summary>
	/// Gets the window's drawable size. On high-density displays, this value may be larger than the value
	/// of <see cref="ClientSize"/> due to the distinction between logical and virtual pixels.
	/// </summary>
	Size2 DrawableSize{ get; }

	/// <summary>
	/// Gets or sets the window's client size.
	/// </summary>
	Size2 ClientSize { get; set; }

	/// <summary>
	/// Gets or sets the client size to which the window will be restored upon entering non-maximized windowed mode.
	/// </summary>
	Size2 WindowedClientSize{ get; set; }

	/// <summary>
	/// Gets or sets the window's minimum client size.
	/// </summary>
	Size2 MinimumClientSize{ get; set; }

	/// <summary>
	/// Gets or sets the window's maximum client size.
	/// </summary>
	Size2 MaximumClientSize{ get; set; }

	/// <summary>
	/// Gets or sets a value indicating whether this window's rendering is synchronized
	/// with the vertical retrace (i.e, whether vsync is enabled).
	/// </summary>
	bool SynchronizeWithVerticalRetrace{ get; set; }

	/// <summary>
	/// Gets a value indicating whether the window is currently active.
	/// </summary>
	bool Active{ get; }

	/// <summary>
	/// Gets or sets a value indicating whether this window is visible.
	/// </summary>
	bool Visible {get;}

	/// <summary>
	/// Gets a value indicating whether this window is resizable.
	/// </summary>
	bool Resizable{ get; }

	/// <summary>
	/// Gets a value indicating whether this window is borderless.
	/// </summary>
	bool Borderless{ get; }

	/// <summary>
	/// Gets or sets a value indicating whether this window grabs
	/// the mouse when it enters windowed mode.
	/// </summary>
	bool GrabsMouseWhenWindowed{ get; set; }

	/// <summary>
	/// Gets or sets a value indicating whether this window grabs
	/// the mouse when it enters fullscreen windowed mode.
	/// </summary>
	bool GrabsMouseWhenFullscreenWindowed{ get; set; }

	/// <summary>
	/// Gets or sets a value indicating whether this window grabs 
	/// the mouse when it enters fullscreen mode.
	/// </summary>
	bool GrabsMouseWhenFullscreen{ get; set; }

	/// <summary>
	/// Gets or sets a value (from 0.0f to 1.0f) representing the window's opacity.
	/// </summary>
	float Opacity{ get; set; }

	/// <summary>
	/// Gets or sets the window's icon.
	/// </summary>
	//Surface2D Icon { get; set; }

	/// <summary>
	/// Gets the window's current compositor.
	/// </summary>
	//Compositor Compositor { get; }

	/// <summary>
	/// Gets the display on which this window currently resides.
	/// </summary>
	IDisplay Display { get; }

	/// <summary>
	/// Warps the cursor to the specified position within this window.
	/// </summary>
	/// <param name="x">The x-coordinate within the window to which the mouse will be warped.</param>
	/// <param name="y">The y-coordinate within the window to which the mouse will be warped.</param>
	void WarpMouseWithinWindow(int32 x, int32 y);

	/// <summary>
	/// Sets the window's fullscreen display mode.
	/// </summary>
	/// <param name="displayMode">The <see cref="DisplayMode"/> to use when the window is in fullscreen mode,
	/// or <see langword="null"/> to use the desktop display mode.</param>
	void SetFullscreenDisplayMode(DisplayMode displayMode);

	/// <summary>
	/// Sets the window's fullscreen display mode.
	/// </summary>
	/// <param name="width">The width of the display in pixels when it is in fullscreen mode.</param>
	/// <param name="height">The height of the display in pixels when it is in fullscreen mode.</param>
	/// <param name="bpp">The bit depth of the display when it is in fullscreen mode.</param>
	/// <param name="refresh">The refresh rate of the display in hertz when it is in fullscreen mode.</param>
	/// <param name="displayIndex">The index of the display in which to place the window when it enters fullscreen mode,
	/// or <see langword="null"/> to keep the window in its current display.</param>
	void SetFullscreenDisplayMode(int32 width, int32 height, int32 bpp, int32 refresh, int32? displayIndex = null);

	/// <summary>
	/// Gets the window's fullscreen display mode.
	/// </summary>
	/// <returns>The <see cref="DisplayMode"/> used when the window is in fullscreen mode, 
	/// or <see langword="null"/> if the window is using the desktop display mode.</returns>
	DisplayMode GetFullscreenDisplayMode();

	/// <summary>
	/// Sets the window's bounds.
	/// </summary>
	/// <param name="bounds">The window's bounding rectangle.</param>
	/// <param name="scale">The window's scaling factor.</param>
	void SetWindowBounds(Rectangle bounds, float scale = 1f);

	/// <summary>
	/// Sets the client size to which the window will be restored upon entering non-maximized windowed mode,
	/// preserving its current position on the screen.
	/// </summary>
	/// <param name="size">The window's client size.</param>
	/// <param name="scale">The window's scaling factor.</param>
	void SetWindowedClientSize(Size2 size, float scale = 1f);

	/// <summary>
	/// Sets the client size to which the window will be restored upon entering non-maximized windowed mode,
	/// and centers the window on the screen.
	/// </summary>
	/// <param name="size">The window's client size.</param>
	/// <param name="scale">The window's scaling factor.</param>
	void SetWindowedClientSizeCentered(Size2 size, float scale = 1f);

	/// <summary>
	/// Sets the window's window mode.
	/// </summary>
	/// <param name="mode">The <see cref="WindowMode"/> value that represents the window mode to set.</param>
	void SetWindowMode(WindowMode mode);

	/// <summary>
	/// Gets the window's window mode.
	/// </summary>
	/// <returns>The <see cref="WindowMode"/> value that represents the window's current window mode.</returns>
	WindowMode GetWindowMode();

	/// <summary>
	/// Sets the window's maximization/minimization state.
	/// </summary>
	/// <param name="state">The <see cref="WindowState"/> value that represents the maximization/minimization state to set.</param>
	void SetWindowState(WindowState state);

	/// <summary>
	/// Gets the window's maximization/minimization state.
	/// </summary>
	/// <returns>The <see cref="WindowState"/> value that represents the window's maximization/minimization state.</returns>
	WindowState GetWindowState();

	/// <summary>
	/// Changes the window's compositor.
	/// </summary>
	/// <param name="compositor">The compositor to set at the window's current compositor.</param>
	/// <remarks>The previous compositor instance will be disposed.</remarks>
	//void ChangeCompositor(Compositor compositor);

	/// <summary>
	/// Moves the window to the center of the specified display.
	/// </summary>
	/// <param name="display">The display to which the window will be moved.</param>
	void ChangeDisplay(IDisplay display);

	/// <summary>
	/// Occurs when the window is shown.
	/// </summary>
	EventAccessor<WindowEventHandler> Shown {get;}

	/// <summary>
	/// Occurs when the window is hidden.
	/// </summary>
	EventAccessor<WindowEventHandler> Hidden {get;}

	/// <summary>
	/// Occurs when the window is minimized.
	/// </summary>
	EventAccessor<WindowEventHandler> Minimized {get;}

	/// <summary>
	/// Occurs when the window is maximized.
	/// </summary>
	EventAccessor<WindowEventHandler> Maximized {get;}

	/// <summary>
	/// Occurs when the window is restored.
	/// </summary>
	EventAccessor<WindowEventHandler> Restored {get;}
}