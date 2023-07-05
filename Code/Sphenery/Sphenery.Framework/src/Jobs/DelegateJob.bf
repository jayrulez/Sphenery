using System;
namespace Sphenery.Framework.Jobs;

class DelegateJob : Job
{
	private delegate void() mJob = null ~ delete _;

	public this(delegate void() job, StringView? name, JobFlags flags) : base(name, flags)
	{
		mJob = job;
	}

	protected override void OnExecute()
	{
		mJob?.Invoke();
	}
}