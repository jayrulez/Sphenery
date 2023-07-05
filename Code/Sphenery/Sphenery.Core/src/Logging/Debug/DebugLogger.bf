using Sphenery.Core.Logging.Abstractions;
using System;

namespace Sphenery.Foundation.Logging.Debug;

class DebugLogger : BaseLogger
{
	public this(LogLevel minimumLogLevel, String name = null, ILogFormatter formatter = null)
		: base(minimumLogLevel, name, formatter)
	{
	}

	protected override void LogMessage(LogLevel logLevel, StringView message)
	{
		Diagnostics.Debug.WriteLine(message);
	}
}