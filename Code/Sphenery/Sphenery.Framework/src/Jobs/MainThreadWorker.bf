using System;
namespace Sphenery.Framework.Jobs;

using internal Sphenery.Framework.Jobs;

internal class MainThreadWorker : Worker
{
	public this(JobSystem jobSystem, StringView name)
		: base(jobSystem, name, .Persistent)
	{
	}

	public ~this()
	{
	}

	public override void Update()
	{
		ProcessJobs();
	}
}