using System;
using System.Collections;
namespace Sedulous.Framework;

class ApplicationConfiguration
{
	private List<Plugin> mPlugins = new .() ~ delete _;

	public Span<Plugin> Plugins => mPlugins;

	public Result<void> AddPlugin(Plugin plugin)
	{
		if (mPlugins.Contains(plugin))
		{
			return .Err;
		}

		mPlugins.Add(plugin);

		return .Ok;
	}
}