namespace Sphenery.Framework.Platform.Input.GamePad;

/// Represents the directions in which a game pad joystick can be oriented.
public enum GamePadJoystickDirection
{
    /// The joystick is at rest.
    None,

    /// The joystick is pointed up.
    Up = 0x01,
     
    /// The joystick is pointed down.
    Down = 0x02,

    /// The joystick is pointed left.
    Left = 0x04,

    /// The joystick is pointed right.
    Right = 0x08,
}