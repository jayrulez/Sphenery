using System.Collections;
using System;
namespace Sphenery.Framework.Jobs;

class JobGroup : Job
{
	private List<JobBase> mJobs = new .() ~ delete _;

	public this(StringView name, JobFlags flags = .None) : base(name, flags)
	{
	}

	public ~this()
	{
	}

	public override void Cancel()
	{
		if (State == .Running)
		{
			// Do not cancel a job that is already running
			return;
		}

		for (JobBase job in mJobs)
		{
			job.Cancel();
		}
		base.Cancel();
	}

	protected override void OnExecute()
	{
		for (JobBase job in mJobs)
		{
			job.[Friend]Execute();
		}
	}

	public void AddJob(JobBase job)
	{
		if (State != .Pending)
			Runtime.FatalError("Cannot add job to JobGroup unless the State is pending.");

		mJobs.Add(job);
	}
}