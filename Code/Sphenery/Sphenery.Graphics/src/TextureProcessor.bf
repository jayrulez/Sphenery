using Sphenery.Framework.Assets;
using System;
namespace Sphenery.Graphics;

class TextureProcessor : AssetProcessor<TextureAssetDescription, TextureAsset>
{
	protected override Result<TextureAsset, AssetSystemError> OnProcess(TextureAssetDescription input)
	{
		var textureAsset = new TextureAsset();
		return textureAsset;
	}
}