using System;
namespace Sedulous.Framework;

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