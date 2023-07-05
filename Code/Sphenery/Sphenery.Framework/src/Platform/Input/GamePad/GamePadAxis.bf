namespace Sphenery.Framework.Platform.Input.GamePad;

/// Represents the axes available on a <see cref="GamePadDevice"/>.
public enum GamePadAxis
{
    /// No game pad axis.
    None,

    /// The left joystick x-axis.
    LeftJoystickX,

    /// The left joystick y-axis.
    LeftJoystickY,

    /// The right joystick x-axis.
    RightJoystickX,

    /// The right joystick y-axis.
    RightJoystickY,

    /// The left trigger axis.
    LeftTrigger,

    /// The right trigger axis.
    RightTrigger,
}