using System;
using System.Collections;
namespace Sedulous.Framework.Jobs;

abstract class Job<T> : JobBase
{
	private T mResult = default;
	public T Result { get => GetResult(); protected set; }

	public this(StringView? name, JobFlags flags) : base(name, flags)
	{
	}

	protected override void Execute()
	{
		mResult = OnExecute();
	}

	protected abstract T OnExecute();

	private T GetResult(){
		while(!(mState == .Completed || mState == .Canceled)){

		}
		return mResult;
	}
}