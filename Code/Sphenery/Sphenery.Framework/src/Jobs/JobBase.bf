using System;
using System.Collections;
namespace Sphenery.Framework.Jobs;

abstract class JobBase : RefCounted
{
	private readonly String mName = new .() ~ delete _;
	private readonly JobFlags mFlags = .None;
	protected JobState mState = .Pending;
	private JobPriority mPriority = .Normal;

	private List<JobBase> mDependencies = new .() ~ delete _;
	private List<JobBase> mDependents = new .() ~ delete _;

	public bool HasDependents => mDependents.Count > 0;

	public String Name => mName;
	public JobFlags Flags => mFlags;
	public JobState State => mState;
	public JobPriority Priority => mPriority;

	public this(StringView? name, JobFlags flags = .None)
	{
		if (name != null)
			mName.Set(name.Value);
		mFlags = flags;
	}

	public ~this()
	{
		for (JobBase dependency in mDependencies)
		{
			dependency.ReleaseRef();
		}
	}

	public void AddDependency(JobBase dependency)
	{
		if (dependency == this)
			Runtime.FatalError("Job cannot depend on itself.");

		if (dependency.mDependencies.Contains(this))
			Runtime.FatalError("The dependency already depends on the current job.");

		mDependencies.Add(dependency);
		dependency.AddRef();

		dependency.mDependents.Add(this);
	}

	public bool IsPending()
	{
		return mState == .Pending;
	}

	public bool IsReady()
	{
		for (JobBase dependency in mDependencies)
		{
			if (dependency.mState != .Completed)
				return false;
		}

		return IsPending();
	}

	public virtual void Cancel()
	{
		if (mState != .Completed && mState != .Canceled)
		{
			mState = .Canceled;

			for (JobBase dependent in mDependents)
			{
				dependent.Cancel();
			}
		}
	}

	protected virtual void Execute()
	{

	}

	internal void Run()
	{
		if (!IsReady())
		{
			// todo: maybe return a state so the caller can requeue if necessary
			return;
		}

		mState = .Running;

		Execute();

		// Job could have been canceled in execute method.
		if (mState != .Canceled)
			mState = .Completed;
	}
}