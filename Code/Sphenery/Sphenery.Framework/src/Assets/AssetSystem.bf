using System;
using Sphenery.Framework.Assets;
using System.Collections;
namespace Sphenery.Framework.Assets;

using internal Sphenery.Framework.Assets;

class AssetSystem
{
	private readonly AssetImporterRegistry mImporters = new .() ~ delete _;
	private readonly AssetProcessorRegistry mProcessors = new .() ~ delete _;

	public AssetImporterRegistry Importers => mImporters;
	public AssetProcessorRegistry Processors => mProcessors;

	private List<AssetManager> mManagers = new .() ~ delete _;

	public void CreateAssetManager(StringView rootPath, out AssetManager manager)
	{
		manager = new .(this, rootPath);

		mManagers.Add(manager);
	}

	public void DestroyAssetManager(AssetManager manager)
	{
		if (mManagers.Contains(manager))
		{
			mManagers.Remove(manager);
			delete manager;
		}
	}
}