namespace Sphenery.Core.Logging.Abstractions;

enum LogLevel : uint8
{
	Trace = 0,
	Debug = 1,
	Information = 2,
	Warning = 3,
	Error = 4,
	Critical = 5,
	None = uint8.MaxValue,
}