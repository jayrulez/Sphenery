using System;
namespace Sphenery.Framework.Assets;

abstract class AssetProcessor<TInput, TOutput> : IAssetProcessor
	where TInput : RefCounted
	where TOutput : RefCounted
{
	public Type InputType => typeof(TInput);

	public Type OutputType => typeof(TOutput);

	public Result<Object, AssetSystemError> Process(Object input)
	{
		Result<TOutput, AssetSystemError> response = OnProcess((TInput)input);
		return response;
	}

	protected abstract Result<TOutput, AssetSystemError> OnProcess(TInput input);
}