using System;
using System.Collections;
using System.Threading;
namespace Sphenery.Framework.Assets;

class AssetImporterRegistry
{
	private readonly Monitor mMonitor = new .() ~ delete _;
	private Dictionary<String, IAssetImporter> mImportersByAssetType = new .() ~ DeleteDictionaryAndKeys!(_);

	public Result<void, AssetSystemError> RegisterImporter(StringView @extension, IAssetImporter assetImporter)
	{
		mMonitor.Enter();
		defer mMonitor.Exit();

		String key = scope .(@extension);

		if (mImportersByAssetType.ContainsKey(key))
		{
			return .Err(.ImporterAlreadyRegistered);
		}

		mImportersByAssetType[new .(key)] = assetImporter;

		return .Ok;
	}

	public Result<void, AssetSystemError> RegisterImporter(Span<StringView> extensions, IAssetImporter assetImporter)
	{
		Result<void, AssetSystemError> result = .Ok;
		for (var @extension in extensions)
		{
			result = RegisterImporter(@extension, assetImporter);
			if (result case .Err)
			{
				break;
			}
		}

		return result;
	}

	public void UnregisterImporter(StringView @extension)
	{
		mMonitor.Enter();
		defer mMonitor.Exit();

		if (mImportersByAssetType.TryGet(scope .(@extension), let key, let importer))
		{
			mImportersByAssetType.Remove(key);
			delete key;
		}
	}

	public void UnregisterImporter(IAssetImporter importer)
	{
		mMonitor.Enter();
		defer mMonitor.Exit();

		List<String> keysToRemove = scope .();

		for (var entry in mImportersByAssetType)
		{
			if (importer == entry.value)
			{
				keysToRemove.Add(entry.key);
			}
		}

		if (keysToRemove.Count > 0)
		{
			for (var keyToRemove in keysToRemove)
			{
				if (mImportersByAssetType.ContainsKey(keyToRemove))
				{
					mImportersByAssetType.Remove(keyToRemove);
					delete keyToRemove;
				}
			}
		}
	}

	public Result<IAssetImporter, AssetSystemError> GetImporter(StringView @extension)
	{
		mMonitor.Enter();
		defer mMonitor.Exit();

		String key = scope .(@extension);
		if (mImportersByAssetType.ContainsKey(key))
		{
			return .Ok(mImportersByAssetType[key]);
		}

		return .Err(.ImporterNotFound);
	}
}