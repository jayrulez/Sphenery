using System;
using System.Threading;
namespace Sedulous.Framework.Messaging;

struct MessageId : IEquatable<Self>, IHashable
{
	private static int mCounter;

	private int mValue;
	private String mName;

	public int Value => mValue;

	private this(String name, int value)
	{
		mName = name;
		mValue = value;
	}

	public static Self Acquire(String name)
	{
		int id = Interlocked.Increment(ref mCounter);

		return .(name, id);
	}

	public override void ToString(String str)
	{
		str.Append(mName ?? "INVALID");
	}

	/// <inheritdoc/>
	public int GetHashCode()
	{
	    return mValue.GetHashCode();
	}

	/// <summary>
	/// Compares two objects to determine whether they are equal.
	/// </summary>
	/// <param name="v1">The first value to compare.</param>
	/// <param name="v2">The second value to compare.</param>
	/// <returns><see langword="true"/> if the two values are equal; otherwise, <see langword="false"/>.</returns>
	public static bool operator ==(Self v1, Self v2)
	{
	    return v1.Equals(v2);
	}

	/// <summary>
	/// Compares two objects to determine whether they are unequal.
	/// </summary>
	/// <param name="v1">The first value to compare.</param>
	/// <param name="v2">The second value to compare.</param>
	/// <returns><see langword="true"/> if the two values are unequal; otherwise, <see langword="false"/>.</returns>
	public static bool operator !=(Self v1, Self v2)
	{
	    return !v1.Equals(v2);
	}

	/// <inheritdoc/>
	public bool Equals(Self other)
	{
	    return this.mValue == other.mValue;
	}
}