using Sedulous.Core.Logging.Abstractions;
using Sedulous.Framework.Platform;
namespace Sedulous.Framework;

interface IApplicationHost
{
	ILogger Logger { get; }

	IPlatform Platform { get; }

	void Exit();
}