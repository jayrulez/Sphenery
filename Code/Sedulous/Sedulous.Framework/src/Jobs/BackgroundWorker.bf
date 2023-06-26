using System.Threading;
using System;
namespace Sedulous.Framework.Jobs;

using internal Sedulous.Framework.Jobs;

internal class BackgroundWorker : Worker
{
	private readonly Thread mThread = null;

	public this(JobSystem jobSystem, StringView name)
		: base(jobSystem, name)
	{
		mThread = new Thread(new => this.ProcessJobsAsync);
		mThread.SetName(mName);
	}

	public ~this()
	{
		delete mThread;
	}

	protected override void OnStarting()
	{
		mThread.Start(false);
	}

	protected override void OnStopping()
	{
		mThread.Join();
	}

	protected override void OnPausing()
	{
		if (mThread.ThreadState == .Running)
			mThread.Suspend();
	}


	protected override void OnResuming()
	{
		mThread.Resume();
	}

	private void ProcessJobsAsync()
	{
		while (true)
		{
			if (mThread.ThreadState == .AbortRequested)
			{
				// todo
				// the worker needs to be stopped
				// Set the worker thread state to dead
			}

			if (!mIsRunning)
			{
				mState = .Dead;

				// Return any pending jobs to the job system if the worker dies
				using (mJobsMonitor.Enter())
				{
					while (mJobs.Count > 0)
					{
						var job = mJobs.PopFront();
						defer job.ReleaseRef();
						mJobSystem.AddJob(job);
					}
				}

				return;
			}

			ProcessJobs();
		}
	}
}