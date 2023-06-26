using System;
using System.Collections;
namespace Sedulous.Framework.Jobs;

abstract class Job : JobBase
{
	public this(StringView? name, JobFlags flags) : base(name, flags)
	{

	}

	
	protected override void Execute()
	{
		OnExecute();
	}

	protected abstract void OnExecute();
}

/*abstract class Job : RefCounted
{
	private readonly String mName = new .() ~ delete _;
	private readonly JobFlags mFlags = .None;
	private JobState mState = .Pending;
	private JobPriority mPriority = .Normal;

	private List<Job> mDependencies = new .() ~ delete _;
	private List<Job> mDependents = new .() ~ delete _;

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
		for (Job dependency in mDependencies)
		{
			dependency.ReleaseRef();
		}
	}

	public void AddDependency(Job dependency)
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
		for (Job dependency in mDependencies)
		{
			if (dependency.mState != .Completed)
				return false;
		}

		return IsPending();
	}

	protected abstract void Execute();

	public virtual void Cancel()
	{
		if (mState != .Completed && mState != .Canceled)
		{
			mState = .Canceled;

			for (Job dependent in mDependents)
			{
				dependent.Cancel();
			}
		}
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
}*/