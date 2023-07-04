using Sedulous.Framework.Content.Assets;
using Sedulous.Framework.Content;
using System;
namespace Sedulous.Graphics;

class TextureAssetLoader : AssetLoader<TextureAsset>
{
	public override Result<Object, AssetLoadError> Load(StringView path)
	{
		return default;
	}
}