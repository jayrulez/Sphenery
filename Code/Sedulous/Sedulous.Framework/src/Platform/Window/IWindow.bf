using System;
using Sedulous.Core.Mathematics;
namespace Sedulous.Framework.Platform.Window;

interface IWindow
{
	public int32 Id { get; }
	public StringView Title { get; }
	public int32 Width { get; }
	public int32 Height { get; }
	public bool Visible {get;}

	
	/// <summary>
	/// Gets or sets the window's client size.
	/// </summary>
	Size2 ClientSize
	{
	    get;
	    set;
	}

	/// <summary>
	/// Warps the cursor to the specified position within this window.
	/// </summary>
	/// <param name="x">The x-coordinate within the window to which the mouse will be warped.</param>
	/// <param name="y">The y-coordinate within the window to which the mouse will be warped.</param>
	void WarpMouseWithinWindow(int32 x, int32 y);

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
}