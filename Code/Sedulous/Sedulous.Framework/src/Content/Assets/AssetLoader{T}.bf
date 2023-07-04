using System;
namespace Sedulous.Framework.Content.Assets;

abstract class AssetLoader<T> : AssetLoader where T : IAsset
{
	public override Type AssetType => typeof(T);
}