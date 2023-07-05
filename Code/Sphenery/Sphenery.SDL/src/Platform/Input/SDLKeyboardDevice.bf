using Sphenery.Framework.Platform.Input.Keyboard;
using Sphenery.Framework.Platform.Input;
using Sphenery.Core.Messaging;
using Sphenery.Framework.Messaging;
using SDL2;
using System.Text;
using System;
namespace Sphenery.SDL.Platform.Input;

using internal Sphenery.SDL.Platform.Input;

class SDLKeyboardDevice : KeyboardDevice, IMessageSubscriber<MessageId>
{
		// State values.
	private readonly InternalButtonState[] states ~ delete _;
	private readonly String text = new .() ~ delete _;
	private bool isRegistered;

	public override bool IsRegistered => isRegistered;

	/// <summary>
	/// Initializes a new instance of the SDL2KeyboardDevice class.
	/// </summary>
	/// <param name="context">The Sphenery context.</param>
	public this(IInputSystem inputSystem) : base(inputSystem)
	{
		int32 numkeys = 0;
		SDL.GetKeyboardState(&numkeys);

		this.states = new InternalButtonState[numkeys];

		//InputSystem.Platform.Application.Messages.Subscribe(this, ApplicationMessages.SoftwareKeyboardShown);
		//InputSystem.Platform.Application.Messages.Subscribe(this, ApplicationMessages.SoftwareKeyboardHidden);

		InputSystem.Platform.Application.Messages.Subscribe(this, SDLMessages.SDLEvent);
	}

	public ~this()
	{
		InputSystem.Platform.Application.Messages.Unsubscribe(this);
	}

	void IMessageSubscriber<MessageId>.ReceiveMessage(MessageId type, MessageData data)
	{
		/*if (type == FrameworkMessages.SoftwareKeyboardShown)
		{
			SDL_StartTextInput();
		}
		else if (type == FrameworkMessages.SoftwareKeyboardHidden)
		{
			SDL_StopTextInput();
		}
		else*/
		if (type == SDLMessages.SDLEvent)
		{
			var evt = ((SDLEventMessageData)data).Event;
			switch (evt.type)
			{
			case .KeyDown:
				{
					if (!isRegistered)
						Register();

					OnKeyDown(ref evt.key);
				}
				break;

			case .KeyUp:
				{
					if (!isRegistered)
						Register();

					OnKeyUp(ref evt.key);
				}
				break;

			case .TextEditing:
				{
					if (!isRegistered)
						Register();

					OnTextEditing(ref evt.edit);
				}
				break;

			case .TextInput:
				{
					if (isRegistered)
						Register();

					OnTextInput(ref evt.text);
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
		for (int i = 0; i < states.Count; i++)
		{
			states[i].Reset();
		}
	}

	public override void Update(Sphenery.Framework.ApplicationTime time)
	{
	}

	public override bool IsButtonDown(Scancode button)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var scancode = (int)button;
		return states[scancode].Down;
	}

	public override bool IsButtonUp(Scancode button)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var scancode = (int)button;
		return states[scancode].Up;
	}

	public override bool IsButtonPressed(Scancode button, bool ignoreRepeats = true)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var scancode = (int)button;
		return states[scancode].Pressed || (!ignoreRepeats && states[scancode].Repeated);
	}

	public override bool IsButtonReleased(Scancode button)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var scancode = (int)button;
		return states[scancode].Released;
	}

	public override void GetTextInput(String sb, bool @append = false)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		if (!@append)
			sb.Length = 0;

		for (int i = 0; i < text.Length; i++)
		{
			sb.Append(text[i]);
		}
	}

	public override bool IsKeyDown(Key key)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var scancode = (int32)SDL.GetScancodeFromKey((SDL.Keycode)key);
		return states[scancode].Down;
	}

	public override bool IsKeyUp(Key key)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var scancode = (int32)SDL.GetScancodeFromKey((SDL.Keycode)key);
		return states[scancode].Up;
	}

	public override bool IsKeyPressed(Key key, bool ignoreRepeats = true)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var scancode = (int32)SDL.GetScancodeFromKey((SDL.Keycode)key);
		return states[scancode].Pressed || (!ignoreRepeats && states[scancode].Repeated);
	}

	public override bool IsKeyReleased(Key key)
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		var scancode = (int32)SDL.GetScancodeFromKey((SDL.Keycode)key);
		return states[scancode].Released;
	}

	public override ButtonState GetKeyState(Key key)
	{
		var state = IsKeyDown(key) ? ButtonState.Down : ButtonState.Up;

		if (IsKeyPressed(key))
			state |= ButtonState.Pressed;

		if (IsKeyReleased(key))
			state |= ButtonState.Released;

		return state;
	}

	public override bool IsNumLockDown => (SDL.GetModState() & SDL.KeyMod.Num) == SDL.KeyMod.Num;

	public override bool IsCapsLockDown => (SDL.GetModState() & SDL.KeyMod.Caps) == SDL.KeyMod.Caps;

	/// <summary>
	/// Handles SDL2's KEYDOWN event.
	/// </summary>
	private void OnKeyDown(ref SDL.KeyboardEvent evt)
	{
		var window = InputSystem.Platform.WindowSystem.GetWindowById((int32)evt.windowID);
		var mods   = evt.keysym.mod;
		var ctrl   = (mods & SDL.KeyMod.CTRL) != 0;
		var alt    = (mods & SDL.KeyMod.ALT) != 0;
		var shift  = (mods & SDL.KeyMod.SHIFT) != 0;
		var @repeat = evt.isRepeat > 0;

		states[(int)evt.keysym.scancode].OnDown(@repeat);

		if (!@repeat)
		{
			OnButtonPressed(window, (Scancode)evt.keysym.scancode);
		}
		OnKeyPressed(window, (Key)evt.keysym.sym, ctrl, alt, shift, @repeat);
	}

	/// <summary>
	/// Handles SDL2's KEYUP event.
	/// </summary>
	private void OnKeyUp(ref SDL.KeyboardEvent evt)
	{
		var window = InputSystem.Platform.WindowSystem.GetWindowById((int32)evt.windowID);

		states[(int)evt.keysym.scancode].OnUp();

		OnButtonReleased(window, (Scancode)evt.keysym.scancode);
		OnKeyReleased(window, (Key)evt.keysym.sym);
	}

	/// <summary>
	/// Handles SDL2's TEXTEDITING event.
	/// </summary>
	private void OnTextEditing(ref SDL.TextEditingEvent evt)
	{
		var window = InputSystem.Platform.WindowSystem.GetWindowById((int32)evt.windowID);
		uint8* input = (.)&evt.text;
		{
			if (GetTextUtf8(input))
			{
				OnTextEditing(window);
			}
		}
	}

	/// <summary>
	/// Handles SDL2's TEXTINPUT event.
	/// </summary>
	private void OnTextInput(ref SDL.TextInputEvent evt)
	{
		var window = InputSystem.Platform.WindowSystem.GetWindowById((int32)evt.windowID);
		uint8* input = &evt.text;
		{
			if (GetTextUtf8(input))
			{
				OnTextInput(window);
			}
		}
	}

	/// <summary>
	/// Stores inputted text (which is in UTF-8 format) to the textUtf8 member.
	/// </summary>
	/// <param name="input">A pointer to the inputted text.</param>
	/// <returns><see langword="true"/> if the input data was successfully stored; otherwise, <see langword="false"/>.</returns>
	private bool GetTextUtf8(uint8* input)
	{
		// Count the number of bytes in the UTF-8 text.
		var p = input;
		var byteCount = 0;
		while (*p++ != 0)
		{
			byteCount++;
		}

		if (byteCount == 0)
			return false;
		{
			String decodedStr = scope .();
			if (Encoding.UTF8.DecodeToUTF8(Span<uint8>(input, byteCount), decodedStr) case .Ok(let i))
			{
				text.Set(decodedStr);
			} else
			{
				return false;
			}
		}
		return true;
	}

	/// <summary>
	/// Flags the device as registered.
	/// </summary>
	private void Register()
	{
		var input = (SDLInputSystem)InputSystem;
		if (input.RegisterKeyboardDevice(this))
			isRegistered = true;
	}
}