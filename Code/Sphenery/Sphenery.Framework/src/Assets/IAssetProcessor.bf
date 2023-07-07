using System;
namespace Sphenery.Framework.Assets;

interface IAssetProcessor
{
	Type InputType {get;}
	Type OutputType {get;}

	Result<Object, AssetSystemError> Process(Object input);
}