using Sphenery.Framework;
namespace Sample01_BasicApplication;

class SamplePlugin : Plugin
{
	private Application mApplication = null;

	private readonly ApplicationUpdateFunctionInfo mUpateFunctionInfo = .()
		{
			Priority = 0,
			Stage = .Update,
			Function = new => this.OnUpdate
		} ~ delete _.Function;

	private delegate void(ApplicationStateChangeInfo info) mStateChangedDelegate = new => this.OnStateChanged;

	public ~this()
	{
		delete mStateChangedDelegate;
	}

	public override void Initialize(Application application)
	{
		mApplication = application;

		mApplication.StateChanged.Subscribe(mStateChangedDelegate);

		mApplication.RegisterUpdateFunction(mUpateFunctionInfo);

		base.Initialize(application);
	}

	public override void Shutdown(Application application)
	{
		mApplication.UnregisterUpdateFunction(mUpateFunctionInfo);

		mApplication.StateChanged.Unsubscribe(mStateChangedDelegate, false);

		mApplication = null;
		base.Shutdown(application);
	}

	private void OnUpdate(ApplicationUpdateInfo info)
	{
		//mApplication.Logger.LogInformation("{0} {1} {2}", nameof(SamplePlugin), nameof(OnUpdate), info.Time.ElapsedTime);
	}

	private void OnStateChanged(ApplicationStateChangeInfo info)
	{
		//mApplication.Logger.LogInformation("{0} {1} {2} {}", nameof(SamplePlugin), nameof(OnStateChanged), info.PreviousState, info.CurrentState);
	}
}