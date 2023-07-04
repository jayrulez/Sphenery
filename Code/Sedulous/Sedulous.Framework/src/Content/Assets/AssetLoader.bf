using System;
namespace Sedulous.Framework.Content.Assets;

abstract class AssetLoader
{
	public abstract Type AssetType {get;}

	public abstract Result<Object, AssetLoadError> Load(StringView path);
}