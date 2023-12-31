using System;
namespace Sphenery.Core.Logging.Abstractions;

interface ILogger
{
	LogLevel MimimumLogLevel { get; }
	String Name { get; }

	void Log(LogLevel logLevel, StringView format, params Object[] args);
}