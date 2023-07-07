using System;
namespace Sphenery.Framework.Assets;

interface IAssetImporter
{
	Type OutputType {get;}

	Result<Object, AssetSystemError> Import(StringView path);
}