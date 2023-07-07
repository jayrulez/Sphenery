using System;
using System.IO;
namespace Sphenery.Framework.Assets;

class AssetManager
{
	private readonly AssetSystem mAssetSystem;

	private readonly String mRootPath = new .() ~ delete _;

	internal this(AssetSystem assetSystem, StringView rootPath)
	{
		mAssetSystem = assetSystem;
		mRootPath.Set(rootPath);
	}

	public Result<TAssetType, AssetSystemError> Load<TAssetType>(StringView path)
	{
		String @extension = Path.GetExtension(path, .. scope .());

		var getImporter = mAssetSystem.Importers.GetImporter(@extension);
		if (getImporter case .Err(let errorCode))
		{
			return .Err(errorCode);
		}

		IAssetImporter importer = getImporter.Value;

		var getProcessor = mAssetSystem.Processors.GetProcessor(importer.OutputType, typeof(TAssetType));
		if (getProcessor case .Err(let errorCode))
		{
			return .Err(errorCode);
		}

		IAssetProcessor processor = getProcessor.Value;

		var importResult = importer.Import(path);
		if (importResult case .Err(let errorCode))
		{
			return .Err(errorCode);
		}

		var processResult = processor.Process(importResult.Value);
		if (processResult case .Err(let errorCode))
		{
			return .Err(errorCode);
		}

		return .Ok((TAssetType)processResult.Value);
	}
}