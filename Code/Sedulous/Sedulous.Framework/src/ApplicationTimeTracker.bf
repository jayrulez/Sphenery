using System;
namespace Sedulous.Framework;

using internal Sedulous.Framework;

sealed class ApplicationTimeTracker
{
	public ApplicationTime Reset()
	{
		mTime.ElapsedTime     = TimeSpan.Zero;
		mTime.TotalTime       = TimeSpan.Zero;
		mTime.IsRunningSlowly = false;
		return mTime;
	}

	public ApplicationTime Increment(TimeSpan ts, bool isRunningSlowly)
	{
		mTime.ElapsedTime = ts;
		mTime.TotalTime = mTime.TotalTime + ts;
		mTime.IsRunningSlowly = isRunningSlowly;
		return mTime;
	}

	public ApplicationTime Time => mTime;

	private readonly ApplicationTime mTime = new .() ~ delete _;
}