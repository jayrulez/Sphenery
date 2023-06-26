using System;
using System.Threading;
using System.Collections;
namespace Sedulous.Framework.Jobs;

using internal Sedulous.Framework.Jobs;

internal abstract class Worker
{
	protected readonly JobSystem mJobSystem = null;
	protected readonly String mName = new .() ~ delete _;
	protected bool mIsRunning = false;
	protected WorkerState mState = .Paused;

	protected Monitor mJobsMonitor = new .() ~ delete _;
	protected Queue<JobBase> mJobs = new .() ~ delete _;

	public String Name => mName;
	public WorkerState State => mState;

	public this(JobSystem jobSystem, StringView name)
	{
		mJobSystem = jobSystem;
		mName.Set(name);
	}

	public ~this()
	{
	}

	protected virtual void OnStarting() { }

	public void Start()
	{
		if (mIsRunning)
		{
			mJobSystem.Logger.LogError("Start called on a worker '{}' that is already running.", mName);
			return;
		}

		OnStarting();

		mIsRunning = true;
	}

	protected virtual void OnStopping() { }

	public void Stop()
	{
		if (!mIsRunning)
		{
			mJobSystem.Logger.LogError("Stop called on a worker '{}' that is not running.", mName);
			return;
		}

		mIsRunning = false;

		// Ensure the last task is completed
		WaitForIdle();

		OnStopping();

		using (mJobsMonitor.Enter())
		{
			while (mJobs.Count > 0)
			{
				JobBase job = mJobs.PopFront();
				defer job.ReleaseRef();

				// return it to the job system and
				// then job system can decide what to do with it
				// job.Cancel();
				// mJobSystem.HandleProcessedJob(job, this);
				mJobSystem.AddJob(job);
			}
		}
	}

	public void WaitForIdle()
	{
		while (mState != .Idle)
		{
			if (mState == .Paused)
				Resume();
			Update();
		}
	}

	protected virtual void OnPausing() { }

	public void Pause()
	{
		using (mJobsMonitor.Enter())
		{
			if (mState == .Idle && mJobs.Count == 0)
			{
				OnPausing();
				mState = .Paused;
			} else
			{
				mJobSystem.Logger.LogWarning("Pause called on worker that is not idle. The worker will not be paused.");
			}
		}
	}

	protected virtual void OnResuming() { }

	public void Resume()
	{
		if (mState == .Paused)
		{
			OnResuming();
			mState = .Idle;
		} else
		{
			mJobSystem.Logger.LogWarning("Resume called on worker that is not paused.");
		}
	}

	public Result<void> QueueJobs(Span<JobBase> jobs)
	{
		if (mState == .Dead)
		{
			return .Err;
		}

		if (mState == .Paused)
			Resume();

		using (mJobsMonitor.Enter())
		{
			for (JobBase job in jobs)
			{
				mJobs.Add(job);
				job.AddRef();
			}
		}
		return .Ok;
	}

	public Result<void> QueueJob(JobBase job)
	{
		if (mState == .Dead)
		{
			return .Err;
		}

		if (mState == .Paused)
			Resume();

		using (mJobsMonitor.Enter())
		{
			mJobs.Add(job);
			job.AddRef();
		}

		return .Ok;
	}

	public virtual void Update()
	{
	}

	protected void ProcessJobs()
	{
		while (mJobs.Count > 0)
		{
			if (!mIsRunning)
			{
				break;
			}

			mState = .Busy;

			JobBase job = null;
			using (mJobsMonitor.Enter())
				job = mJobs.PopFront();
			defer job.ReleaseRef();

			if (!job.IsReady())
			{
				// if the job is not ready to run,
				// re-queue with the job system to free up this worker ASAP
				//QueueJob(job); // don't want to always queue on this worker, possibly lead to deadlock, we're already inside the monitor and QueueJob will request to enter the Monitor
				//mJobs.Add(job); // not desirable to always requeue on same worker

				mJobSystem.AddJob(job);
				continue;
			}

			mJobSystem.Logger.LogInformation("Worker: {} - Running job: {}.", mName, job.Name);
			job.[Friend]Run();

			mJobSystem.HandleProcessedJob(job, this);
		}

		mState = .Idle;
	}
}