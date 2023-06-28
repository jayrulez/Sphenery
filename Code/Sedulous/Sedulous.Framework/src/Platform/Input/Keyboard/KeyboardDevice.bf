using Sedulous.Framework.Platform;
using Sedulous.Core;
using System;
using Sedulous.Framework.Platform.Window;
namespace Sedulous.Framework.Platform.Input.Keyboard;

using internal Sedulous.Core;

/// <summary>
/// Represents the method that is called when a keyboard button is pressed or released.
/// </summary>
/// <param name="window">The window in which the input event took place.</param>
/// <param name="device">The <see cref="KeyboardDevice"/> that raised the event.</param>
/// <param name="scancode">The <see cref="Scancode"/> value that represents the key that was pressed.</param>
public delegate void KeyboardButtonEventHandler(IWindow window, KeyboardDevice device, Scancode scancode);

/// <summary>
/// Represents the method that is called when a keyboard key is pressed.
/// </summary>
/// <param name="window">The window in which the input event took place.</param>
/// <param name="device">The <see cref="KeyboardDevice"/> that raised the event.</param>
/// <param name="key">The <see cref="Key"/> value that represents the key that was pressed.</param>
/// <param name="ctrl">A value indicating whether the Control modifier is active.</param>
/// <param name="alt">A value indicating whether the Alt modifier is active.</param>
/// <param name="shift">A value indicating whether the Shift modifier is active.</param>
/// <param name="repeat">A value indicating whether this is a repeated key press.</param>
public delegate void KeyPressedEventHandler(IWindow window, KeyboardDevice device, Key key, bool ctrl, bool alt, bool shift, bool @repeat);

/// <summary>
/// Represents the method that is called when a keyboard key is released.
/// </summary>
/// <param name="window">The window in which the input event took place.</param>
/// <param name="device">The <see cref="KeyboardDevice"/> that raised the event.</param>
/// <param name="key">The <see cref="Key"/> value that represents the key that was released.</param>
public delegate void KeyReleasedEventHandler(IWindow window, KeyboardDevice device, Key key);

/// <summary>
/// Represents the method that is called when text input is available.
/// </summary>
/// <param name="window">The window in which the input event took place.</param>
/// <param name="device">The <see cref="KeyboardDevice"/> that raised the event.</param>
public delegate void TextInputEventHandler(IWindow window, KeyboardDevice device);

/// <summary>
/// Represents a keyboard device.
/// </summary>
public abstract class KeyboardDevice : InputDevice<Scancode>
{
    /// Initializes a new instance of the <see cref="KeyboardDevice"/> class.
    public this()
    {

    }

    /// <summary>
    /// Populates the specified <see cref="StringBuilder"/> with the most recent text input.
    /// </summary>
    /// <param name="sb">The <see cref="StringBuilder"/> to populate with text input data.</param>
    /// <param name="append">A value indicating whether to append the text input data to the existing data of <paramref name="sb"/>.</param>
    public abstract void GetTextInput(String sb, bool @append = false);

    /// <summary>
    /// Gets a value indicating whether the specified key is currently down.
    /// </summary>
    /// <param name="key">The <see cref="Key"/> to evaluate.</param>
    /// <returns><see langword="true"/> if the key is down; otherwise, <see langword="false"/>.</returns>
    public abstract bool IsKeyDown(Key key);

    /// <summary>
    /// Gets a value indicating whether the specified key is currently up.
    /// </summary>
    /// <param name="key">The <see cref="Key"/> to evaluate.</param>
    /// <returns><see langword="true"/> if the key is up; otherwise, <see langword="false"/>.</returns>
    public abstract bool IsKeyUp(Key key);

    /// <summary>
    /// Gets a value indicating whether the specified key is currently pressed.
    /// </summary>
    /// <remarks>Platforms may send multiple key press events while a key is held down.  Any such 
    /// event after the first is marked as a "repeat" event and should be handled accordingly.</remarks>
    /// <param name="key">The <see cref="Key"/> to evaluate.</param>
    /// <param name="ignoreRepeats">A value indicating whether to ignore repeated key press events on devices which support them.</param>
    /// <returns><see langword="true"/> if the key is pressed; otherwise, <see langword="false"/>.</returns>        
    public abstract bool IsKeyPressed(Key key, bool ignoreRepeats = true);

    /// <summary>
    /// Gets a value indicating whether the specified key is currently released.
    /// </summary>
    /// <param name="key">The <see cref="Key"/> to evaluate.</param>
    /// <returns><see langword="true"/> if the key is released; otherwise, <see langword="false"/>.</returns>
    public abstract bool IsKeyReleased(Key key);

    /// <summary>
    /// Gets the current state of the specified key.
    /// </summary>
    /// <param name="key">The <see cref="Key"/> for which to retrieve a state.</param>
    /// <returns>A <see cref="ButtonState"/> value indicating the state of the specified key.</returns>
    public abstract ButtonState GetKeyState(Key key);

    /// <summary>
    /// Gets a value indicating whether one of the Control modifier keys is currently down.
    /// </summary>
    public bool IsControlDown => IsKeyDown(Key.LeftControl) || IsKeyDown(Key.RightControl);

    /// <summary>
    /// Gets a value indicating whether one of the Alt modifier keys is currently down.
    /// </summary>
    public bool IsAltDown => IsKeyDown(Key.LeftAlt) || IsKeyDown(Key.RightAlt);

    /// <summary>
    /// Gets a value indicating whether one of the Shift modifier keys is currently down.
    /// </summary>
    public bool IsShiftDown => IsKeyDown(Key.LeftShift) || IsKeyDown(Key.RightShift);

    /// <summary>
    /// Gets a value indicating whether the Num Lock modifier is currently down.
    /// </summary>
    public abstract bool IsNumLockDown
    {
        get;
    }

    /// <summary>
    /// Gets a value indicating whether the Caps Lock modifier is currently down.
    /// </summary>
    public abstract bool IsCapsLockDown
    {
        get;
    }

    /// <summary>
    /// Occurs when a button is pressed.
    /// </summary>
    public EventAccessor<KeyboardButtonEventHandler> ButtonPressed {get;} = new .() ~ delete _;

    /// <summary>
    /// Occurs when a button is released.
    /// </summary>
    public EventAccessor< KeyboardButtonEventHandler> ButtonReleased{get;} = new .() ~ delete _;

    /// <summary>
    /// Occurs when a key is pressed.
    /// </summary>
    /// <remarks>Platforms may send multiple key press events while a key is held down. Any such 
    /// event after the first is marked as a "repeat" event and should be handled accordingly.</remarks>
    public EventAccessor< KeyPressedEventHandler> KeyPressed{get;} = new .() ~ delete _;

    /// <summary>
    /// Occurs when a key is released.
    /// </summary>
    public EventAccessor< KeyReleasedEventHandler> KeyReleased{get;} = new .() ~ delete _;

    /// <summary>
    /// Occurs when text input is available.
    /// </summary>
    public EventAccessor< TextInputEventHandler> TextInput{get;} = new .() ~ delete _;

    /// <summary>
    /// Occurs when text is being edited.
    /// </summary>
    public EventAccessor< TextInputEventHandler> TextEditing{get;} = new .() ~ delete _;

    /// <summary>
    /// Raises the <see cref="ButtonPressed"/> event.
    /// </summary>
    /// <param name="window">The window that raised the event.</param>
    /// <param name="scancode">The <see cref="Scancode"/> that represents the button that was pressed.</param>
    protected virtual void OnButtonPressed(IWindow window, Scancode scancode) =>
        ButtonPressed?.Invoke(window, this, scancode);

    /// <summary>
    /// Raises the <see cref="ButtonReleased"/> event.
    /// </summary>
    /// <param name="window">The window that raised the event.</param>
    /// <param name="scancode">The <see cref="Scancode"/> that represents the button that was released.</param>
    protected virtual void OnButtonReleased(IWindow window, Scancode scancode) =>
        ButtonReleased?.Invoke(window, this, scancode);

    /// <summary>
    /// Raises the <see cref="KeyPressed"/> event.
    /// </summary>
    /// <remarks>Platforms may send multiple key press events while a key is held down.  Any such 
    /// event after the first is marked as a "repeat" event and should be handled accordingly.</remarks>
    /// <param name="window">The window that raised the event.</param>
    /// <param name="key">The <see cref="Key"/> that was pressed.</param>
    /// <param name="ctrl">A value indicating whether the Control modifier is active.</param>
    /// <param name="alt">A value indicating whether the Alt modifier is active.</param>
    /// <param name="shift">A value indicating whether the Shift modifier is active.</param>
    /// <param name="repeat">A value indicating whether this is a repeated key press.</param>
    protected virtual void OnKeyPressed(IWindow window, Key key, bool ctrl, bool alt, bool shift, bool @repeat)
    {
        KeyPressed?.Invoke(window, this, key, ctrl, alt, shift, @repeat);
    }

    /// <summary>
    /// Raises the <see cref="KeyReleased"/> event.
    /// </summary>
    /// <param name="window">The window that raised the event.</param>
    /// <param name="key">The <see cref="Key"/> that was released.</param>
    protected virtual void OnKeyReleased(IWindow window, Key key)
    {
        KeyReleased?.Invoke(window, this, key);
    }

    /// <summary>
    /// Raises the <see cref="TextInput"/> event.
    /// </summary>
    /// <param name="window">The window that raised the event.</param>
    protected virtual void OnTextInput(IWindow window)
    {
        TextInput?.Invoke(window, this);
    }

    /// <summary>
    /// Raises the <see cref="TextEditing"/> event.
    /// </summary>
    /// <param name="window">The window that raised the event.</param>
    protected virtual void OnTextEditing(IWindow window)
    {
        TextEditing?.Invoke(window, this);
    }
}