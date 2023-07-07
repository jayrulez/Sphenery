using Sphenery.Framework.Assets;
using System;
namespace Sphenery.Graphics;

class TextureAssetDescription : RefCounted
{
}

class TextureAsset : RefCounted, IAsset
{
	public Guid AssetId { get; internal set; }
}