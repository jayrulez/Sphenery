using System.Collections;
using System;
using Sphenery.Core.Utilities;
using System.Threading;
namespace Sphenery.Framework.Assets;

class AssetProcessorRegistry
{
	private struct ProcessorsEntryKey : IHashable
	{
		public Type InputType { get; }
		public Type OutputType { get; }

		public this(Type inputType, Type outputType)
		{
			InputType = inputType;
			OutputType = outputType;
		}

		public int GetHashCode()
		{
			return HashHelper.CombineHash(InputType.GetTypeId(), OutputType.GetTypeId());
		}
	}

	private Dictionary<ProcessorsEntryKey, IAssetProcessor> mProcessorsByAssetType = new .() ~ delete _;

	private readonly Monitor mMonitor = new .() ~ delete _;

	public Result<void, AssetSystemError> RegisterProcessor(IAssetProcessor assetProcessor)
	{
		mMonitor.Enter();
		defer mMonitor.Exit();

		ProcessorsEntryKey key = .(assetProcessor.InputType, assetProcessor.OutputType);

		if(mProcessorsByAssetType.ContainsKey(key)){
			return .Err(.ProcessorAlreadyRegistered);
		}

		mProcessorsByAssetType[key] = assetProcessor;

		return .Ok;
	}

	public void UnregisterProcessor(IAssetProcessor assetProcessor)
	{
		mMonitor.Enter();
		defer mMonitor.Exit();

		ProcessorsEntryKey key = .(assetProcessor.InputType, assetProcessor.OutputType);

		if (mProcessorsByAssetType.ContainsKey(key))
		{
			mProcessorsByAssetType.Remove(key);
		}
	}

	public Result<IAssetProcessor, AssetSystemError> GetProcessor<TInputType, TOutputType>()
	{
		mMonitor.Enter();
		defer mMonitor.Exit();

		ProcessorsEntryKey key = .(typeof(TInputType), typeof(TOutputType));
		if (mProcessorsByAssetType.ContainsKey(key))
		{
			return .Ok(mProcessorsByAssetType[key]);
		}

		return .Err(.ProcessorNotFound);
	}

	public Result<IAssetProcessor, AssetSystemError> GetProcessor(Type inputType, Type outputType)
	{
		mMonitor.Enter();
		defer mMonitor.Exit();

		ProcessorsEntryKey key = .(inputType, outputType);
		if (mProcessorsByAssetType.ContainsKey(key))
		{
			return .Ok(mProcessorsByAssetType[key]);
		}

		return .Err(.ProcessorNotFound);
	}
}