namespace Sedulous.Framework.Platform.Input;

/// <summary>
/// Represents the state of an input button.
/// </summary>
public enum ButtonState
{
    /// The button is up.
    Up = 0x0001,

    /// The button is down.
    Down = 0x0002,

    /// The button was pressed this frame.
    Pressed = 0x0004,

    /// The button was released this frame.
    Released = 0x0008,
}