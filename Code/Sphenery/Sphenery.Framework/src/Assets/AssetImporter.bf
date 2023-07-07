using System;
namespace Sphenery.Framework.Assets;

abstract class AssetImporter<T> : IAssetImporter where T : RefCounted
{
	public Type OutputType => typeof(T);

	public Result<Object, AssetSystemError> Import(StringView path)
	{
		return OnImport(path);
	}

	protected abstract Result<T, AssetSystemError> OnImport(StringView path);
}