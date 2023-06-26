namespace Sedulous.Framework.Input;

abstract class InputDevice
{
	public abstract bool IsRegistered { get; }

	public abstract void Update(ApplicationTime time);
}