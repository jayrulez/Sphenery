using Sphenery.Core.Logging.Abstractions;
using Sphenery.Framework.Platform;
namespace Sphenery.Framework;

interface IApplicationHost
{
	ILogger Logger { get; }

	IPlatform Platform { get; }

	void Exit();
}