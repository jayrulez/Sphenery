namespace System;

extension Type
{
	public bool IsAssignableFrom(Type type)
	{
		return type == this || type.IsSubtypeOf(this);
	}
}