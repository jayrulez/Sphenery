namespace Sedulous.Framework.Input;

abstract class InputDevice<T> : InputDevice
{
	/// <summary>
	/// Gets a value indicating whether the specified button is currently down.
	/// </summary>
	/// <param name="button">The button to evaluate.</param>
	/// <returns><see langword="true"/> if the button is down; otherwise, <see langword="false"/>.</returns>
	public abstract bool IsButtonDown(T button);

	/// <summary>
	/// Gets a value indicating whether the specified button is currently up.
	/// </summary>
	/// <param name="button">The button to evaluate.</param>
	/// <returns><see langword="true"/> if the button is up; otherwise, <see langword="false"/>.</returns>
	public abstract bool IsButtonUp(T button);

	/// <summary>
	/// Gets a value indicating whether the specified button is currently pressed.
	/// </summary>
	/// <param name="button">The button to evaluate.</param>
	/// <param name="ignoreRepeats">A value indicating whether to ignore repeated button press events on devices which support them.</param>
	/// <returns><see langword="true"/> if the button is pressed; otherwise, <see langword="false"/>.</returns>        
	public abstract bool IsButtonPressed(T button, bool ignoreRepeats = true);

	/// <summary>
	/// Gets a value indicating whether the specified button is currently released.
	/// </summary>
	/// <param name="button">The button to evaluate.</param>
	/// <returns><see langword="true"/> if the button is released; otherwise, <see langword="false"/>.</returns>
	public abstract bool IsButtonReleased(T button);

	/// <summary>
	/// Gets the current state of the specified button.
	/// </summary>
	/// <param name="button">The button for which to retrieve a state.</param>
	/// <returns>The current state of the specified button.</returns>
	public virtual ButtonState GetButtonState(T button)
	{
	    var state = IsButtonDown(button) ? ButtonState.Down : ButtonState.Up;

	    if (IsButtonPressed(button))
	        state |= ButtonState.Pressed;

	    if (IsButtonReleased(button))
	        state |= ButtonState.Released;

	    return state;
	}
}