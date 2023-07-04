using System.Collections;
using System;
using System.Threading;
using System.Diagnostics;
using Sedulous.Core;
using Sedulous.Core.Logging.Abstractions;
using Sedulous.Framework.Jobs;
using Sedulous.Core.Messaging;
using Sedulous.Framework.Messaging;
using Sedulous.Framework.Content;
namespace Sedulous.Framework;

using internal Sedulous.Core;

class Application : IMessageSubscriber<MessageId>
{
	private readonly Monitor mMonitor = new .() ~ delete _;

	private readonly IApplicationHost mHost;

	public readonly IApplicationHost Host => mHost;

	private readonly List<Plugin> mPlugins = new .() ~ delete _;

	// Current tick state.
	private static readonly TimeSpan MaxElapsedTime = TimeSpan.FromMilliseconds(500);
	private readonly Stopwatch mTickTimer = new .() ~ delete _;
	private readonly ApplicationTimeTracker mPreUpdateTimeTracker = new .() ~ delete _;
	private readonly ApplicationTimeTracker mPostUpdateTimeTracker = new .() ~ delete _;
	private readonly ApplicationTimeTracker mUpdateTimeTracker = new .() ~ delete _;
	private readonly ApplicationTimeTracker mFixedUpdateTimeTracker = new .() ~ delete _;
	private int64 mAccumulatedElapsedTime = 0;
	private int32 mLagFrames = 0;
	private bool mRunningSlowly = false;

	/// Gets the default value for TargetElapsedTime.
	public static TimeSpan DefaultTargetElapsedTime { get; } = TimeSpan(TimeSpan.TicksPerSecond / 60);

	/// Gets the default value for InactiveSleepTime.
	public static TimeSpan DefaultInactiveSleepTime { get; } = TimeSpan.FromMilliseconds(20);

	public TimeSpan TargetElapsedTime { get; set; } = DefaultTargetElapsedTime;
	public TimeSpan InactiveSleepTime { get; set; } = DefaultInactiveSleepTime;

	private bool mInitialized = false;
	private ApplicationState mState = .Stopped;

	public readonly EventAccessor<delegate void(ApplicationStateChangeInfo info)> StateChanged = new .() ~ delete _;

	private struct RegisteredUpdateFunctionInfo
	{
		public int Priority;
		public ApplicationUpdateFunction Function;
	}
	private Dictionary<ApplicationUpdateStage, List<RegisteredUpdateFunctionInfo>> mUpdateFunctions = new .() ~ delete _;
	private List<ApplicationUpdateFunctionInfo> mUpdateFunctionsToRegister = new .() ~ delete _;
	private List<ApplicationUpdateFunctionInfo> mUpdateFunctionsToUnregister = new .() ~ delete _;

	private readonly List<ApplicationUpdateFunctionInfo> mDefaultUpdateFunctionInfos = new .()
		{
			.() { Priority = -1, Stage = .PreUpdate, Function = new => this.OnPreUpdate },
			.() { Priority = -1, Stage = .PostUpdate, Function = new => this.OnPostUpdate },
			.() { Priority = -1, Stage = .Update, Function = new => this.OnUpdate },
			.() { Priority = -1, Stage = .FixedUpdate, Function = new => this.OnFixedUpdate }
		} ~
		{
			for (var info in _)
			{
				delete info.Function;
			}
			delete _;
		};

	private readonly ILogger mLogger;
	public ILogger Logger => mLogger;

	private readonly JobSystem mJobSystem = null;
	public JobSystem JobSystem => mJobSystem;

	private readonly ContentSystem mContentSystem = null;
	public ContentSystem ContentSystem => mContentSystem;

	// The application event queue.
	private readonly LocalMessageQueue<MessageId> mMessages = new .() ~ delete _;

	//public IMessageQueue<MessageId> Messages => mMessages;
	// exposing LocalMessageQueue<MessageId> instead of IMessageQueue<MessageId> because Beef does not allow
	// generic method dispatch on interfaces (which we need for CreateMessage)
	public LocalMessageQueue<MessageId> Messages => mMessages;

	public this(IApplicationHost host, ApplicationConfiguration configuration)
	{
		Enum.MapValues<ApplicationUpdateStage>(scope (member) =>
			{
				mUpdateFunctions.Add(member, new .());
			});

		mJobSystem = new .(this, 4);
		mContentSystem = new .();

		mHost = host;
		mLogger = host.Logger;
		mPlugins.AddRange(configuration.Plugins);
	}

	public ~this()
	{
		delete mContentSystem;
		delete mJobSystem;

		Enum.MapValues<ApplicationUpdateStage>(scope (member) =>
			{
				delete mUpdateFunctions[member];
			});
	}

	void IMessageSubscriber<MessageId>.ReceiveMessage(MessageId type, MessageData data)
	{
		OnReceivedMessage(type, data);
	}

	internal void SetState(ApplicationState state)
	{
		if (mState == state)
			return;

		ApplicationState previousState = mState;
		mState = state;

		StateChanged.Invoke(.()
			{
				Application = this,
				PreviousState = previousState,
				CurrentState = mState
			});
	}

	internal void Initialize()
	{
		if (mInitialized)
		{
			return;
		}
		mJobSystem.Startup();

		var initializer = scope ApplicationInitializer();

		OnInitializing(initializer);

		mPlugins.AddRange(initializer.Plugins);

		mTickTimer.Start();

		for (var plugin in mPlugins)
		{
			plugin.Initialize(this);
		}

		OnInitialized();
		RegisterUpdateFunctions(mDefaultUpdateFunctionInfos);

		mMessages.Subscribe(this, ApplicationMessages.Quit);
		mInitialized = true;
		SetState(.Running);
	}

	internal void Shutdown()
	{
		if (!mInitialized)
		{
			return;
		}

		mMessages.Unsubscribe(this, ApplicationMessages.Quit);

		UnregisterUpdateFunctions(mDefaultUpdateFunctionInfos);

		OnShuttingdown();

		for (var plugin in mPlugins)
		{
			plugin.Shutdown(this);
		}

		mTickTimer.Stop();

		OnShutdown();
		mInitialized = false;

		mJobSystem.Shutdown();
	}

	internal void Update()
	{
#region Update methods
		void SortUpdateFunctions()
		{
			Enum.MapValues<ApplicationUpdateStage>(scope (member) =>
				{
					mUpdateFunctions[member].Sort(scope (lhs, rhs) =>
						{
							if (lhs.Priority == rhs.Priority)
							{
								return 0;
							}
							return lhs.Priority > rhs.Priority ? 1 : -1;
						});
				});
		}

		void RunUpdateFunctions(ApplicationUpdateStage phase, ApplicationUpdateInfo info)
		{
			for (ref RegisteredUpdateFunctionInfo updateFunctionInfo in ref mUpdateFunctions[phase])
			{
				updateFunctionInfo.Function(info);
			}
		}

		void ProcessUpdateFunctionsToRegister()
		{
			if (mUpdateFunctionsToRegister.Count == 0)
				return;

			for (var info in mUpdateFunctionsToRegister)
			{
				mUpdateFunctions[info.Stage].Add(.()
					{
						Priority = info.Priority,
						Function = info.Function
					});
			}
			mUpdateFunctionsToRegister.Clear();
			SortUpdateFunctions();
		}

		void ProcessUpdateFunctionsToUnregister()
		{
			if (mUpdateFunctionsToUnregister.Count == 0)
				return;

			for (var info in mUpdateFunctionsToUnregister)
			{
				var index = mUpdateFunctions[info.Stage].FindIndex(scope (registered) =>
					{
						return info.Function == registered.Function;
					});

				if (index >= 0)
				{
					mUpdateFunctions[info.Stage].RemoveAt(index);
				}
			}
			mUpdateFunctionsToUnregister.Clear();
			SortUpdateFunctions();
		}
#endregion

		{
			ProcessMessages();
			mJobSystem.Update();
		}
		ProcessUpdateFunctionsToRegister();
		ProcessUpdateFunctionsToUnregister();

		if (InactiveSleepTime.Ticks > 0 && mState != .Running) // should be if host is suspended
			Thread.Sleep(InactiveSleepTime);

		var elapsedTicks = mTickTimer.Elapsed.Ticks;
		mTickTimer.Restart();

		mAccumulatedElapsedTime += elapsedTicks;
		if (mAccumulatedElapsedTime > MaxElapsedTime.Ticks)
			mAccumulatedElapsedTime = MaxElapsedTime.Ticks;

		// Pre-Update
		{
			RunUpdateFunctions(.PreUpdate, .()
				{
					Application = this,
					State = mState,
					Time = mPreUpdateTimeTracker.Increment(TimeSpan(elapsedTicks), false)
				});
		}

		// Fixed-Update
		{
			var fixedTicksToRun = (int32)(mAccumulatedElapsedTime / TargetElapsedTime.Ticks);
			if (fixedTicksToRun > 0)
			{
				mLagFrames += (fixedTicksToRun == 1) ? -1 : Math.Max(0, fixedTicksToRun - 1);

				if (mLagFrames == 0)
					mRunningSlowly = false;
				if (mLagFrames > 5)
					mRunningSlowly = true;

				var timeDeltaFixedUpdate = TargetElapsedTime;
				mAccumulatedElapsedTime -= fixedTicksToRun * TargetElapsedTime.Ticks;

				for (var i = 0; i < fixedTicksToRun; i++)
				{
					RunUpdateFunctions(.FixedUpdate, .()
						{
							Application = this,
							State = mState,
							Time = mFixedUpdateTimeTracker.Increment(timeDeltaFixedUpdate, mRunningSlowly)
						});
				}
			}
		}

		// Update
		{
			RunUpdateFunctions(.Update, .()
				{
					Application = this,
					State = mState,
					Time = mUpdateTimeTracker.Increment(TimeSpan(elapsedTicks), false)
				});
		}

		// Post-Update
		{
			RunUpdateFunctions(.PostUpdate, .()
				{
					Application = this,
					State = mState,
					Time = mPostUpdateTimeTracker.Increment(TimeSpan(elapsedTicks), false)
				});
		}

		{
			ProcessMessages();
		}
	}

	public void RegisterUpdateFunction(ApplicationUpdateFunctionInfo info)
	{
		mUpdateFunctionsToRegister.Add(info);
	}

	public void RegisterUpdateFunctions(Span<ApplicationUpdateFunctionInfo> infos)
	{
		for (var info in infos)
			mUpdateFunctionsToRegister.Add(info);
	}

	public void UnregisterUpdateFunction(ApplicationUpdateFunctionInfo info)
	{
		mUpdateFunctionsToUnregister.Add(info);
	}

	public void UnregisterUpdateFunctions(Span<ApplicationUpdateFunctionInfo> infos)
	{
		for (var info in infos)
			mUpdateFunctionsToUnregister.Add(info);
	}

	public Result<T> GetPlugin<T>() where T : Plugin
	{
		for (var plugin in mPlugins)
		{
			if (typeof(T) == plugin.GetType())
			{
				return .Ok((T)plugin);
			}
		}
		return .Err;
	}

	public bool TryGetPlugin<T>(out T outPlugin) where T : Plugin
	{
		for (var plugin in mPlugins)
		{
			if (typeof(T) == plugin.GetType())
			{
				outPlugin = (T)plugin;
				return true;
			}
		}
		outPlugin = ?;
		return false;
	}

	internal void ProcessMessages()
	{
	    mMessages.Process();
	}

	/// <summary>
	/// Occurs when the context receives a message from its queue.
	/// </summary>
	/// <param name="type">The message type.</param>
	/// <param name="data">The message data.</param>
	protected virtual void OnReceivedMessage(MessageId type, MessageData data)
	{
		Logger.LogInformation("MessageType: {0}", type.Value);
	}

#region Lifecycle methods
	protected virtual void OnInitializing(ApplicationInitializer initializer) { }
	protected virtual void OnInitialized() { }
	protected virtual void OnShuttingdown() { }
	protected virtual void OnShutdown() { }

	protected virtual void OnPreUpdate(ApplicationUpdateInfo info) { }
	protected virtual void OnPostUpdate(ApplicationUpdateInfo info) { }
	protected virtual void OnUpdate(ApplicationUpdateInfo info) { }
	protected virtual void OnFixedUpdate(ApplicationUpdateInfo info) { }
#endregion
}