using System;
namespace Sphenery.Core.Logging.Abstractions;

interface ILogFormatter
{
	String Format { get; }

	void Format(ILogger logger, LogLevel logLevel, StringView message, String output);
}