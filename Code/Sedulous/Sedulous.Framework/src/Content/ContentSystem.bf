using System;
using Sedulous.Framework.Content.Assets;
using System.Collections;
namespace Sedulous.Framework.Content;

enum AssetLoadError
{
	LoaderNotFound,
	AssetLoaderAlreadyRegistered
}

class ContentSystem
{
	public Span<AssetLoader> AssetLoaders => mAssetLoaders;

	private List<AssetLoader> mAssetLoaders = new .() ~ delete _;
	private Dictionary<Type, AssetLoader> mAssetLoadersByAssetType = new .() ~ delete _;

	public Result<void, AssetLoadError> RegisterAssetLoader(AssetLoader assetLoader)
	{
		if (mAssetLoaders.Contains(assetLoader))
		{
			return .Err(.AssetLoaderAlreadyRegistered);
		}

		mAssetLoaders.Add(assetLoader);
		mAssetLoadersByAssetType[assetLoader.AssetType] = assetLoader;

		return .Ok;
	}

	public void RemoveAssetLoader<T>() where T : IAsset
	{
		Type assetType = typeof(T);
		if (mAssetLoadersByAssetType.ContainsKey(assetType))
		{
			mAssetLoadersByAssetType.Remove(assetType);
		}
		var foundIndex = mAssetLoaders.FindIndex(scope (loader) =>
			{
				return loader.AssetType == assetType;
			});

		if (foundIndex != -1)
		{
			mAssetLoaders.RemoveAt(foundIndex);
		}
	}

	public void RemoveAssetLoader(AssetLoader assetLoader)
	{
		Type assetType = assetLoader.AssetType;

		if (mAssetLoaders.Contains(assetLoader))
		{
			mAssetLoaders.Remove(assetLoader);
		}

		if (mAssetLoadersByAssetType.ContainsKey(assetType))
		{
			mAssetLoadersByAssetType.Remove(assetType);
		}
	}

	public Result<T, AssetLoadError> Load<T>(StringView path) where T : IAsset
	{
		switch (GetAssetLoader<T>())
		{
		case .Ok(let assetLoader):
			{
				var loadResult = assetLoader.Load(path);
				if (loadResult case .Err(let errorCode))
				{
					return .Err(errorCode);
				}

				return .Ok((T)loadResult.Value);
			}

		case .Err(let errorCode):

			return .Err(errorCode);
		}
	}

	private Result<AssetLoader, AssetLoadError> GetAssetLoader<T>() where T : IAsset
	{
		Type assetType = typeof(T);
		if (mAssetLoadersByAssetType.ContainsKey(assetType))
		{
			return .Ok(mAssetLoadersByAssetType[assetType]);
		}

		return .Err(.LoaderNotFound);
	}
}