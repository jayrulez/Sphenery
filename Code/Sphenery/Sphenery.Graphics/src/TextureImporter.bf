using Sphenery.Framework.Assets;
using System;
using System.Collections;
namespace Sphenery.Graphics;

class TextureImporter : AssetImporter<TextureAssetDescription>
{
	private List<StringView> mSupportedExtensions = new .() {".png"};
	public Span<StringView> SupportedExtensions => mSupportedExtensions;

	protected override Result<TextureAssetDescription, AssetSystemError> OnImport(StringView path)
	{
		return new TextureAssetDescription();
	}
}