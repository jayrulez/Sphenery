using Sphenery.Framework.Content.Assets;
using Sphenery.Framework.Content;
using System;
namespace Sphenery.Graphics;

class TextureAssetLoader : AssetLoader<TextureAsset>
{
	public override Result<Object, AssetLoadError> Load(StringView path)
	{
		return default;
	}
}