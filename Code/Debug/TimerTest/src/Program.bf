using System;
using System.Diagnostics;
namespace TimerTest;

using internal TimerTest;

sealed class ApplicationTime
{
	public this()
	{
		this.ElapsedTime = TimeSpan.Zero;
		this.TotalTime   = TimeSpan.Zero;
	}

	public this(TimeSpan elapsedTime, TimeSpan totalTime)
	{
		this.ElapsedTime = elapsedTime;
		this.TotalTime   = totalTime;
	}

	public TimeSpan ElapsedTime { get; internal set; }

	public TimeSpan TotalTime { get; internal set; }

	public bool IsRunningSlowly { get; internal set; }
}

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

class Program
{
	public static void Main()
	{
		int count = 100000;

		var loopTimeTracker = scope ApplicationTimeTracker();
		var timer = scope Stopwatch();
		timer.Start();
		defer timer.Stop();

		while (count-- > 0)
		{
			var elapsed = timer.Elapsed.Ticks;
			timer.Restart();

			Update(loopTimeTracker.Increment(TimeSpan(elapsed), false));
		}
	}

	private static void Update(ApplicationTime time)
	{
		var fps = 1/((float)time.ElapsedTime.TotalSeconds);
		System.Diagnostics.Debug.WriteLine("FPS: {0}", fps);
	}
}