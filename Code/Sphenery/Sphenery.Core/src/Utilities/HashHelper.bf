namespace Sphenery.Core.Utilities;

struct HashHelper
{
	private int mBase;
	private int mHashCode;

	public this(int startingHashCode, int @base = 397)
	{
		mHashCode = startingHashCode;
		mBase = @base;
	}

	public Self Combine(int hashCode) mut
	{
		mHashCode = (mHashCode * mBase) ^ hashCode;
		return this;
	}

	public int Get()
	{
		return mHashCode;
	}

	public static int CombineHash(int first, int second)
	{
		return (first * 397) ^ second;
	}
}