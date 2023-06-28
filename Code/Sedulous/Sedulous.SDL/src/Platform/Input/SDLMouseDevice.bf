using Sedulous.Core.Messaging;
using Sedulous.Framework.Platform.Input.Mouse;
using Sedulous.Framework.Messaging;
using Sedulous.Framework.Platform.Input;
using Sedulous.Framework.Platform.Window;
using SDL2;
using System;
using Sedulous.Core.Mathematics;
using Sedulous.Framework;
namespace Sedulous.SDL.Platform.Input;

using internal Sedulous.SDL.Platform.Input;

class SDLMouseDevice : MouseDevice, IMessageSubscriber<MessageId>
{
	// The device identifier of the touch-based mouse emulator.
	private const uint32 SDL_TOUCH_MOUSEID = ((uint32)(-1));

	// Property values.
	private int32 x;
	private int32 y;
	private int32 wheelDeltaX;
	private int32 wheelDeltaY;
	private bool isRegistered;
	private IWindow window;

	// State values.
	private InternalButtonState[] states;
	private uint32 buttonStateClicks;
	private uint32 buttonStateDoubleClicks;
	private bool ignoredFirstMouseMotionEvent;
	private bool relativeMode;


	public override bool IsRegistered => isRegistered;

	public override IWindow Window => window;

	public override Point2 Position => Point2(x, y);

	public override int32 X => x;

	public override int32 Y => y;

	public override int32 WheelDeltaX => wheelDeltaX;

	public override int32 WheelDeltaY => wheelDeltaY;

	public this(IInputSystem inputSystem) : base(inputSystem)
	{
		this.window = InputSystem.Platform.WindowSystem.PrimaryWindow;

		var buttonCount = Enum.GetCount<MouseButton>();
		this.states = new InternalButtonState[buttonCount];

		inputSystem.Platform.Application.Messages.Subscribe(this, SDLMessages.SDLEvent);
	}

	void IMessageSubscriber<MessageId>.ReceiveMessage(MessageId type, MessageData data)
	{
		if (type == SDLMessages.SDLEvent)
		{
			var evt = ((SDLEventMessageData)data).Event;
			switch (evt.type)
			{
			case .MouseMotion:
				{
					// HACK: On iOS, for some goddamn reason, SDL2 sends us a spurious motion event
					// with mouse ID 0 when you first touch the screen. This only seems to happen once
					// so let's just ignore it.
					if (!ignoredFirstMouseMotionEvent)
					{
						SetMousePositionFromDevicePosition(evt.motion.windowID);
						ignoredFirstMouseMotionEvent = true;
					}
					else
					{
						if (!isRegistered && evt.motion.which != SDL_TOUCH_MOUSEID)
							Register(evt.motion.windowID);

						OnMouseMotion(ref evt.motion);
					}
				}
				break;

			case .MouseButtonDown:
				{
					if (!isRegistered && evt.button.which != SDL_TOUCH_MOUSEID)
						Register(evt.button.windowID);

					OnMouseButtonDown(ref evt.button);
				}
				break;

			case .MouseButtonUp:
				{
					if (!isRegistered && evt.button.which != SDL_TOUCH_MOUSEID)
						Register(evt.button.windowID);

					OnMouseButtonUp(ref evt.button);
				}
				break;

			case .MouseWheel:
				{
					if (!isRegistered && evt.wheel.which != SDL_TOUCH_MOUSEID)
						Register(evt.wheel.windowID);

					OnMouseWheel(ref evt.wheel);
				}
				break;

			default: break;
			}
		}
	}
		/// <summary>
		/// Resets the device's state in preparation for the next frame.
		/// </summary>
	public void ResetDeviceState()
	{
		buttonStateClicks       = 0;
		buttonStateDoubleClicks = 0;

		for (int i = 0; i < states.Count; i++)
		{
			states[i].Reset();
		}
	}

	public override void Update(ApplicationTime time)
	{
	}

	public override void WarpToWindow(Sedulous.Framework.Platform.Window.IWindow window, int32 x, int32 y)
	{
			//Contract.EnsureNotDisposed(this, Disposed);
			//Contract.Require(window, nameof(window));

		window.WarpMouseWithinWindow(x, y);
	}

	public override void WarpToWindowCenter(Sedulous.Framework.Platform.Window.IWindow window)
	{
			//Contract.EnsureNotDisposed(this, Disposed);
			//Contract.Require(window, nameof(window));

		var size = window.ClientSize;
		window.WarpMouseWithinWindow(size.Width / 2, size.Height / 2);
	}

	public override void WarpToPrimaryWindow(int32 x, int32 y)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var primary = InputSystem.Platform.WindowSystem.PrimaryWindow;
		if (primary == null)
			Runtime.FatalError("NoPrimaryWindow");

		primary.WarpMouseWithinWindow(x, y);
	}

	public override void WarpToPrimaryWindowCenter()
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var primary = InputSystem.Platform.WindowSystem.PrimaryWindow;
		if (primary == null)
			Runtime.FatalError("NoPrimaryWindow");

		var size = primary.ClientSize;
		primary.WarpMouseWithinWindow(size.Width / 2, size.Height / 2);
	}

	public override Point2? GetPositionInWindow(IWindow window)
	{
		//Contract.Require(window, nameof(window));

		if (Window != window)
			return null;

		var spos = (Point2)Position;

		// todo
		/*var cpos = Window.Compositor.WindowToPoint(spos);

		return cpos;*/

		return spos;
	}

	public override bool IsButtonDown(MouseButton button)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		return states[(int)button].Down;
	}

	public override bool IsButtonUp(MouseButton button)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		return states[(int)button].Up;
	}

	public override bool IsButtonPressed(MouseButton button, bool ignoreRepeats = true)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		return states[(int)button].Pressed || (!ignoreRepeats && states[(int)button].Repeated);
	}

	public override bool IsButtonReleased(MouseButton button)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		return states[(int)button].Released;
	}

	public override bool IsButtonClicked(MouseButton button)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		return (buttonStateClicks & (uint32)SDL_BUTTON(button)) != 0;
	}

	public override bool IsButtonDoubleClicked(MouseButton button)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		return (buttonStateDoubleClicks & (uint32)SDL_BUTTON(button)) != 0;
	}

	public override bool GetIsRelativeModeEnabled()
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		return SDL.GetRelativeMouseMode();
	}

	public override bool SetIsRelativeModeEnabled(bool enabled)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var result = SDL.SetRelativeMouseMode(enabled);
		if (result == -1)
			return false;

		if (result < 0)
			Runtime.FatalError("Failed to set relative mouse mode.");

		relativeMode = enabled;
		return true;
	}

	/// <summary>
	/// Creates the SDL2 button state mask that corresponds to the specified button.
	/// </summary>
	/// <param name="button">The button for which to create a state mask.</param>
	/// <returns>The state mask for the specified button.</returns>
	private static int32 SDL_BUTTON(int32 button)
	{
		return 1 << (button - 1);
	}

	/// <summary>
	/// Creates the SDL2 button state mask that corresponds to the specified button.
	/// </summary>
	/// <param name="button">The button for which to create a state mask.</param>
	/// <returns>The state mask for the specified button.</returns>
	private static int32 SDL_BUTTON(MouseButton button)
	{
		switch (button)
		{
		case MouseButton.None:
			return 0;
		case MouseButton.Left:
			return SDL_BUTTON(1);
		case MouseButton.Middle:
			return SDL_BUTTON(2);
		case MouseButton.Right:
			return SDL_BUTTON(3);
		case MouseButton.XButton1:
			return SDL_BUTTON(4);
		case MouseButton.XButton2:
			return SDL_BUTTON(5);
		}
		//Runtime.FatalError("button");
	}

	/// <summary>
	/// Gets the Sedulous MouseButton value that corresponds to the specified SDL2 button value.
	/// </summary>
	/// <param name="value">The SDL2 button value to convert.</param>
	/// <returns>The Sedulous MouseButton value that corresponds to the specified SDL2 button value.</returns>
	private static MouseButton GetSedulousButton(int32 value)
	{
		if (value == 0)
			return MouseButton.None;

		switch ( /*(SDL_Button)*/value)
		{
		case SDL.SDL_BUTTON_LEFT:
			return MouseButton.Left;
		case SDL.SDL_BUTTON_MIDDLE:
			return MouseButton.Middle;
		case SDL.SDL_BUTTON_RIGHT:
			return MouseButton.Right;
		case SDL.SDL_BUTTON_X1:
			return MouseButton.XButton1;
		case SDL.SDL_BUTTON_X2:
			return MouseButton.XButton2;
		}
		Runtime.FatalError("value");
	}

	/// <summary>
	/// Handles SDL2's MOUSEMOTION event.
	/// </summary>
	private void OnMouseMotion(ref SDL.MouseMotionEvent evt)
	{
		if (!InputSystem.EmulateMouseWithTouchInput && evt.which == SDL_TOUCH_MOUSEID)
			return;

		if (relativeMode)
		{
			SetMousePosition(evt.windowID, evt.x, evt.y);
			OnMoved(window, evt.x, evt.y, evt.xrel, evt.yrel);
		}
		else
		{
			SetMousePosition(evt.windowID, evt.x, evt.y);
			OnMoved(window, evt.x, evt.y, evt.xrel, evt.yrel);
		}
	}

	/// <summary>
	/// Handles SDL2's MOUSEBUTTONDOWN event.
	/// </summary>
	private void OnMouseButtonDown(ref SDL.MouseButtonEvent evt)
	{
		if (!InputSystem.EmulateMouseWithTouchInput && evt.which == SDL_TOUCH_MOUSEID)
			return;

		var window = InputSystem.Platform.WindowSystem.GetWindowById((int32)evt.windowID);
		var button = GetSedulousButton(evt.button);

		this.states[(int)button].OnDown(false);

		OnButtonPressed(window, button);
	}

	/// <summary>
	/// Handles SDL2's MOUSEBUTTONUP event.
	/// </summary>
	private void OnMouseButtonUp(ref SDL.MouseButtonEvent evt)
	{
		if (!InputSystem.EmulateMouseWithTouchInput && evt.which == SDL_TOUCH_MOUSEID)
			return;

		var window = InputSystem.Platform.WindowSystem.GetWindowById((int32)evt.windowID);
		var button = GetSedulousButton(evt.button);

		this.states[(int)button].OnUp();

		if (evt.clicks == 1)
		{
			buttonStateClicks |= (uint32)SDL_BUTTON(evt.button);
			OnClick(window, button);
		}

		if (evt.clicks == 2)
		{
			buttonStateDoubleClicks |= (uint32)SDL_BUTTON(evt.button);
			OnDoubleClick(window, button);
		}

		OnButtonReleased(window, button);
	}

	/// <summary>
	/// Handles SDL2's MOUSEWHEEL event.
	/// </summary>
	private void OnMouseWheel(ref SDL.MouseWheelEvent evt)
	{
		if (!InputSystem.EmulateMouseWithTouchInput && evt.which == SDL_TOUCH_MOUSEID)
			return;

		var window = InputSystem.Platform.WindowSystem.GetWindowById((int32)evt.windowID);
		wheelDeltaX = evt.x;
		wheelDeltaY = evt.y;
		OnWheelScrolled(window, evt.x, evt.y);
	}

	/// <summary>
	/// Flags the device as registered.
	/// </summary>
	private void Register(uint32 windowID)
	{
		var input = (SDLInputSystem)InputSystem;
		if (input.RegisterMouseDevice(this))
		{
			isRegistered = true;
		}
	}

	/// <summary>
	/// Sets the mouse cursor's position within its window.
	/// </summary>
	private void SetMousePosition(uint32 windowID, int32 x, int32 y)
	{
		this.window = InputSystem.Platform.WindowSystem.GetWindowById((int32)windowID);

		/*if (FrameworkContext.Properties.SupportsHighDensityDisplayModes)
		{
			var scale = window?.Display.DeviceScale ?? 1f;
			this.x = (int32)(x * scale);
			this.y = (int32)(y * scale);
		}
		else*/
		{
			this.x = x;
			this.y = y;
		}
	}

	/// <summary>
	/// Sets the mouse cursor's position based on the device's physical position.
	/// </summary>
	private void SetMousePositionFromDevicePosition(uint32 windowID)
	{
		int32 x, y;
		SDL.GetMouseState(out x, out y);
		SetMousePosition(windowID, x, y);
	}
}