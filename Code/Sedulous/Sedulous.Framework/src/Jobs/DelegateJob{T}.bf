using System;
namespace Sedulous.Framework.Jobs;

class DelegateJob<T> : Job<T>
{
	private delegate T() mJob = null ~ delete _;

	public this(delegate T() job, StringView? name, JobFlags flags) : base(name, flags)
	{
		mJob = job;
	}

	protected override T OnExecute()
	{
		return mJob?.Invoke();
	}
}