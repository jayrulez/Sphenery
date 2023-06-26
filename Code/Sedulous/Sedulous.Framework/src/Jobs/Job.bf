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