using Sedulous.Core.Mathematics;
using Sedulous.Core;
using System;
namespace Sedulous.Framework.Input.GamePad;

using internal Sedulous.Core;

/// Represents the method that is called when a game pad button is pressed.
/// </summary>
/// <param name="device">The <see cref="GamePadDevice"/> that raised the event.</param>
/// <param name="button">The <see cref="GamePadButton"/> value that represents the button that was pressed.</param>
/// <param name="repeat">A value indicating whether this is a repeated button press.</param>
public delegate void GamePadButtonPressedEventHandler(GamePadDevice device, GamePadButton button, bool @repeat);

/// <summary>
/// Represents the method that is called when a game pad button is pressed.
/// </summary>
/// <param name="device">The <see cref="GamePadDevice"/> that raised the event.</param>
/// <param name="button">The <see cref="GamePadButton"/> value that represents the button that was released.</param>
public delegate void GamePadButtonReleasedEventHandler(GamePadDevice device, GamePadButton button);

/// <summary>
/// Represents the method that is called when a game pad axis changes its value.
/// </summary>
/// <param name="device">The <see cref="GamePadDevice"/> that raised the event.</param>
/// <param name="axis">The <see cref="GamePadAxis"/> value that represents the axis that changed.</param>
/// <param name="value">The axis' value.</param>
public delegate void GamePadAxisEventHandler(GamePadDevice device, GamePadAxis axis, float value);

/// <summary>
/// Represents the method that is called when a game pad axis is pressed.
/// </summary>
/// <param name="device">The <see cref="GamePadDevice"/> that raised the event.</param>
/// <param name="axis">The <see cref="GamePadAxis"/> value that represents the axis that was pressed.</param>
/// <param name="value">The axis' value.</param>
/// <param name="repeat">A value indicating whether this is a repeated axis press.</param>
public delegate void GamePadAxisPressedEventHandler(GamePadDevice device, GamePadAxis axis, float value, bool @repeat);

/// <summary>
/// Represents the method that is called when a game pad axis is released.
/// </summary>
/// <param name="device">The <see cref="GamePadDevice"/> that raised the event.</param>
/// <param name="axis">The <see cref="GamePadAxis"/> value that represents the axis that was released.</param>
/// <param name="value">The axis' value.</param>
public delegate void GamePadAxisReleasedEventHandler(GamePadDevice device, GamePadAxis axis, float value);

/// <summary>
/// Represents the method that is called when a game pad axis vector changes its value.
/// </summary>
/// <param name="device">The <see cref="GamePadDevice"/> that raised the event.</param>
/// <param name="vector">The axis' vector.</param>
public delegate void GamePadAxisVectorEventHandler(GamePadDevice device, Vector2 vector);

/// <summary>
/// Represents a game pad input device.
/// </summary>
public abstract class GamePadDevice : InputDevice<GamePadButton>
{
	/// Initializes a new instance of the <see cref="GamePadDevice"/> class.
	public this()
	{
		AxisDownThreshold = 0.9f;
	}

	/// <summary>
	/// Gets the direction in which the specified joystick is pointed, using the specified minimum threshold value.
	/// If no threshold is specified, the value of <see cref="AxisDownThreshold"/> is used instead.
	/// </summary>
	/// <param name="joystick">A <see cref="GamePadJoystick"/> value that represents the joystick to evaluate.</param>
	/// <param name="threshold">The threshold value at which the joystick is considered to be pointed in a particular direction.</param>
	/// <returns>A set of <see cref="GamePadJoystickDirection"/> values which represent the joystick's direction.</returns>
	public abstract GamePadJoystickDirection GetJoystickDirection(GamePadJoystick joystick, float? threshold = null);

	/// <summary>
	/// Gets the <see cref="GamePadJoystickDirection"/> value that corresponds to the state of the specified axis.
	/// </summary>
	/// <param name="axis">A <see cref="GamePadAxis"/> value to evaluate.</param>
	/// <param name="threshold">The threshold value at which an axis is considered to be pointed in a particular direction.</param>
	/// <returns>A set of <see cref="GamePadJoystickDirection"/> values which represent the specified axis' direction.</returns>
	public abstract GamePadJoystickDirection GetJoystickDirectionFromAxis(GamePadAxis axis, float? threshold = null);

	/// <summary>
	/// Gets the value of the specified game pad axis.
	/// </summary>
	/// <param name="axis">The <see cref="GamePadAxis"/> value to retrieve.</param>
	/// <returns>The value of the specified game pad axis.</returns>
	public abstract float GetAxisValue(GamePadAxis axis);

	/// <summary>
	/// Gets a value indicating whether the specified game pad axis is currently considered "down"
	/// in accordance with the <see cref="AxisDownThreshold"/> property.
	/// </summary>
	/// <param name="axis">The <see cref="GamePadAxis"/> to evaluate.</param>
	/// <returns><see langword="true"/> if the axis is down; otherwise, <see langword="false"/>.</returns>
	public abstract bool IsAxisDown(GamePadAxis axis);

	/// <summary>
	/// Gets a value indicating whether the specified game pad axis is currently considered "up"
	/// in accordance with the <see cref="AxisDownThreshold"/> property.
	/// </summary>
	/// <param name="axis">The <see cref="GamePadAxis"/> to evaluate.</param>
	/// <returns><see langword="true"/> if the axis is up; otherwise, <see langword="false"/>.</returns>
	public abstract bool IsAxisUp(GamePadAxis axis);

	/// <summary>
	/// Gets a value indicating whether the specified game pad axis is currently considered "pressed"
	/// in accordance with the <see cref="AxisDownThreshold"/> property.
	/// </summary>
	/// <param name="axis">The <see cref="GamePadAxis"/> to evaluate.</param>
	/// <returns><see langword="true"/> if the axis is pressed; otherwise, <see langword="false"/>.</returns>
	public abstract bool IsAxisPressed(GamePadAxis axis);

	/// <summary>
	/// Gets a value indicating whether the specified game pad axis is currently considered "released"
	/// in accordance with the <see cref="AxisDownThreshold"/> property.
	/// </summary>
	/// <param name="axis">The <see cref="GamePadAxis"/> to evaluate.</param>
	/// <returns><see langword="true"/> if the axis is released; otherwise, <see langword="false"/>.</returns>
	public abstract bool IsAxisReleased(GamePadAxis axis);

	/// <summary>
	/// Gets the device's name.
	/// </summary>
	public abstract String Name
	{
		get;
	}

	/// <summary>
	/// Gets the index of the player that corresponds to this device.
	/// </summary>
	public abstract int32 PlayerIndex
	{
		get;
	}

	/// <summary>
	/// Gets or sets the threshold at which an axis is considered to be "down."
	/// </summary>
	public abstract float AxisDownThreshold
	{
		get;
		set;
	}

	/// <summary>
	/// Gets the normalized value of the left trigger axis.
	/// </summary>
	public abstract float LeftTrigger
	{
		get;
	}

	/// <summary>
	/// Gets the normalized value of the right trigger axis.
	/// </summary>
	public abstract float RightTrigger
	{
		get;
	}

	/// <summary>
	/// Gets the normalized value of the left joystick x-axis.
	/// </summary>
	public abstract float LeftJoystickX
	{
		get;
	}

	/// <summary>
	/// Gets the normalized value of the left joystick y-axis.
	/// </summary>
	public abstract float LeftJoystickY
	{
		get;
	}

	/// <summary>
	/// Gets a vector representing the position of the left joystick.
	/// </summary>
	public abstract Vector2 LeftJoystickVector
	{
		get;
	}

	/// <summary>
	/// Gets the normalized value of the right joystick x-axis.
	/// </summary>
	public abstract float RightJoystickX
	{
		get;
	}

	/// <summary>
	/// Gets the normalized value of the right joystick y-axis.
	/// </summary>
	public abstract float RightJoystickY
	{
		get;
	}

	/// <summary>
	/// Gets a vector representing the position of the right joystick.
	/// </summary>
	public abstract Vector2 RightJoystickVector
	{
		get;
	}

	/// <summary>
	/// Occurs when one of the game pad's buttons is pressed.
	/// </summary>
	public EventAccessor<GamePadButtonPressedEventHandler> ButtonPressed { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when one of the game pad's buttons is released.
	/// </summary>
	public EventAccessor<GamePadButtonReleasedEventHandler> ButtonReleased { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when the value of one of the game pad's axes changes.
	/// </summary>
	public EventAccessor<GamePadAxisEventHandler> AxisChanged { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when one of the game pad's axes enters the "pressed" state, as determined by
	/// the value of the <see cref="AxisDownThreshold"/> property.
	/// </summary>
	public EventAccessor<GamePadAxisPressedEventHandler> AxisPressed { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when one of the game pad's axes leaves hte "pressed" state, as determined by
	/// the value of the <see cref="AxisDownThreshold"/> property.
	/// </summary>
	public EventAccessor<GamePadAxisReleasedEventHandler> AxisReleased { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when the value of the game pad's left joystick vector changes.
	/// </summary>
	public EventAccessor<GamePadAxisVectorEventHandler> LeftJoystickVectorChanged { get; } = new .() ~ delete _;

	/// <summary>
	/// Occurs when the value of the game pad's right joystick vector changes.
	/// </summary>
	public EventAccessor<GamePadAxisVectorEventHandler> RightJoystickVectorChanged { get; } = new .() ~ delete _;

	/// <summary>
	/// Raises the <see cref="ButtonPressed"/> event.
	/// </summary>
	/// <param name="button">The <see cref="GamePadButton"/> value that represents the button that was pressed.</param>
	/// <param name="repeat">A value indicating whether this is a repeated button press.</param>
	protected virtual void OnButtonPressed(GamePadButton button, bool @repeat) =>
		ButtonPressed?.Invoke(this, button, @repeat);

	/// <summary>
	/// Raises the <see cref="ButtonReleased"/> event.
	/// </summary>
	/// <param name="button">The <see cref="GamePadButton"/> value that represents the button that was pressed.</param>
	protected virtual void OnButtonReleased(GamePadButton button) =>
		ButtonReleased?.Invoke(this, button);

	/// <summary>
	/// Raises the AxisChanged event.
	/// </summary>
	/// <param name="axis">The <see cref="GamePadAxis"/> value that represents the axis that changed.</param>
	/// <param name="value">The axis' value.</param>
	protected virtual void OnAxisChanged(GamePadAxis axis, float value) =>
		AxisChanged?.Invoke(this, axis, value);

	/// <summary>
	/// Raises the <see cref="AxisPressed"/> event.
	/// </summary>
	/// <param name="axis">The <see cref="GamePadAxis"/> that was pressed.</param>
	/// <param name="value">The axis' value.</param>
	/// <param name="repeat">A value indicating whether this is a repeated axis press.</param>
	protected virtual void OnAxisPressed(GamePadAxis axis, float value, bool @repeat) =>
		AxisPressed?.Invoke(this, axis, value, @repeat);

	/// <summary>
	/// Raises the <see cref="AxisReleased"/> event.
	/// </summary>
	/// <param name="axis">The <see cref="GamePadAxis"/> that was released.</param>
	/// <param name="value">The axis' value.</param>
	protected virtual void OnAxisReleased(GamePadAxis axis, float value) =>
		AxisReleased?.Invoke(this, axis, value);

	/// <summary>
	/// Raises the LeftJoystickVectorChanged event.
	/// </summary>
	/// <param name="vector">The axis' vector.</param>
	protected virtual void OnLeftJoystickVectorChanged(Vector2 vector) =>
		LeftJoystickVectorChanged?.Invoke(this, vector);

	/// <summary>
	/// Raises the RightJoystickVectorChanged event.
	/// </summary>
	/// <param name="vector">The axis' vector.</param>
	protected virtual void OnRightJoystickVectorChanged(Vector2 vector) =>
		RightJoystickVectorChanged?.Invoke(this, vector);
}