using Sedulous.Framework.Platform.Input;
using Sedulous.Framework.Platform.Input.Mouse;
using Sedulous.Framework.Platform.Input.GamePad;
using Sedulous.Framework.Platform.Input.Touch;
using Sedulous.Core;
using Sedulous.Framework.Platform.Input.Keyboard;
using Sedulous.Core.Messaging;
using Sedulous.Framework.Messaging;
using SDL2;
using Sedulous.Framework.Platform;
using Sedulous.Framework;
namespace Sedulous.SDL.Platform.Input;

using internal Sedulous.Core;

class SDLInputSystem : IInputSystem, IMessageSubscriber<MessageId>
{
	private readonly IPlatform mPlatform;

	public IPlatform Platform => mPlatform;

	
	// Platform services.
	//private readonly SoftwareKeyboardService softwareKeyboardService;

	// Input devices.
	private SDLKeyboardDevice keyboard ~ delete _;
	private SDLMouseDevice mouse ~ delete _;
	//private GamePadDeviceInfo gamePadInfo;
	private SDLGamePadDevice primaryGamePad;
	//private TouchDeviceInfo touchInfo;
	private SDLTouchDevice primaryTouchDevice;     

	public this(IPlatform platform)
	{
		mPlatform = platform;

		//this.softwareKeyboardService = context.GetFactoryMethod<SoftwareKeyboardServiceFactory>()();

		this.keyboard = new SDLKeyboardDevice(this);
		this.mouse = new SDLMouseDevice(this);
		//this.gamePadInfo = new GamePadDeviceInfo(context);
		//this.gamePadInfo.GamePadConnected += OnGamePadConnected;
		//this.gamePadInfo.GamePadDisconnected += OnGamePadDisconnected;
		//this.touchInfo = new TouchDeviceInfo(context);

		//LoadGameControllerMappingDatabase(context);

		//context.Messages.Subscribe(this, FrameworkMessages.TextInputRegionChanged);
	}

	void IMessageSubscriber<MessageId>.ReceiveMessage(MessageId type, MessageData data)
	{
	    /*if (type == FrameworkMessages.TextInputRegionChanged)
	    {
	            var service = SoftwareKeyboardService.Create();
	            var region = service.TextInputRegion;
	            if (region.HasValue)
	            {
	                var rect = SDL.Rect()
	                {
	                    x = region.Value.X,
	                    y = region.Value.Y,
	                    w = region.Value.Width,
	                    h = region.Value.Height,
	                };
	                SDL_SetTextInputRect(&rect);
	            }
	            else
	            {
	                SDL_SetTextInputRect(null);
	            }
	    }*/
	}

	/// <summary>
	/// Resets the device's state in preparation for the next frame.
	/// </summary>
	public void ResetDeviceStates()
	{
	    //Contract.EnsureNotDisposed(this, Disposed);

	    this.keyboard.ResetDeviceState();
	    this.mouse.ResetDeviceState();
	    //this.gamePadInfo.ResetDeviceStates();
	    //this.touchInfo.ResetDeviceStates();
	}

	public void Update(ApplicationTime time)
	{
	    //Contract.EnsureNotDisposed(this, Disposed);

	    this.keyboard.Update(time);
	    this.mouse.Update(time);
	    //this.gamePadInfo.Update(time);
	    //this.touchInfo.Update(time);

	    //Updating?.Invoke(this, time);
	}

	public void ShowSoftwareKeyboard()
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		//softwareKeyboardService.ShowSoftwareKeyboard(KeyboardMode.Text);
	}

	public void ShowSoftwareKeyboard(KeyboardMode mode)
	{
            //Contract.EnsureNotDisposed(this, Disposed);
            
            //softwareKeyboardService.ShowSoftwareKeyboard(mode);
	}

	public void HideSoftwareKeyboard()
	{
            //Contract.EnsureNotDisposed(this, Disposed);

            //softwareKeyboardService.HideSoftwareKeyboard();
	}

	public bool IsKeyboardSupported()
	{
		return true;
	}

	public bool IsKeyboardRegistered()
	{
            return keyboard.IsRegistered;
	}

	public KeyboardDevice GetKeyboard()
	{
		return keyboard;
	}

	public bool IsMouseSupported()
	{
		return true;
	}

	public bool IsMouseRegistered()
	{
            return mouse.IsRegistered;
	}

	public MouseDevice GetMouse()
	{
            return mouse;
	}

	public int32 GetGamePadCount()
	{
		//return gamePadInfo.Count;
		return default;
	}

	public bool IsGamePadSupported()
	{
		return true;
	}

	public bool IsGamePadConnected()
	{
		/*Contract.EnsureNotDisposed(this, Disposed);

		return gamePadInfo.Count > 0;*/
		return default;
	}

	public bool IsGamePadConnected(int32 playerIndex)
	{
		/*Contract.EnsureNotDisposed(this, Disposed);
		Contract.EnsureRange(playerIndex >= 0, nameof(playerIndex));

		return gamePadInfo.GetGamePadForPlayer(playerIndex) != null;*/
		return default;
	}

	public bool IsGamePadRegistered()
	{
		/*Contract.EnsureNotDisposed(this, Disposed);

		for (int i = 0; i < gamePadInfo.Count; i++)
		{
		    if (gamePadInfo.GetGamePadForPlayer(i)?.IsRegistered ?? false)
		        return true;
		}

		return false;*/
		return default;
	}

	public bool IsGamePadRegistered(int32 playerIndex)
	{
		/*Contract.EnsureNotDisposed(this, Disposed);
		Contract.EnsureRange(playerIndex >= 0, nameof(playerIndex));

		return gamePadInfo.GetGamePadForPlayer(playerIndex)?.IsRegistered ?? false;*/
		return default;
	}

	public GamePadDevice GetGamePadForPlayer(int32 playerIndex)
	{
		/*Contract.EnsureNotDisposed(this, Disposed);

		return gamePadInfo.GetGamePadForPlayer(playerIndex);*/
		return default;
	}

	public GamePadDevice GetFirstConnectedGamePad()
	{
		/*Contract.EnsureNotDisposed(this, Disposed);

		return gamePadInfo.GetFirstConnectedGamePad();*/
		return default;
	}

	public GamePadDevice GetFirstRegisteredGamePad()
	{
		/*Contract.EnsureNotDisposed(this, Disposed);

		return gamePadInfo.GetFirstRegisteredGamePad();*/
		return default;
	}

	public GamePadDevice GetPrimaryGamePad()
	{
		/*Contract.EnsureNotDisposed(this, Disposed);

		return primaryGamePad;*/
		return default;
	}

	public bool IsTouchSupported()
	{
		/*Contract.EnsureNotDisposed(this, Disposed);

		return touchInfo.Count > 0;*/
		return default;
	}

	public bool IsTouchDeviceConnected()
	{
		/*Contract.EnsureNotDisposed(this, Disposed);

		return touchInfo.Count > 0;*/
		return default;
	}

	public bool IsTouchDeviceConnected(int32 index)
	{
		/*Contract.EnsureNotDisposed(this, Disposed);
		Contract.EnsureRange(index >= 0, nameof(index));

		return touchInfo.Count > index;*/
		return default;
	}

	public bool IsTouchDeviceRegistered()
	{
		//Contract.EnsureNotDisposed(this, Disposed);

		/*for (int i = 0; i < touchInfo.Count; i++)
		{
		    if (touchInfo.GetTouchDeviceByIndex(i).IsRegistered)
		        return true;
		}*/

		//return false;
		return default;
	}

	public bool IsTouchDeviceRegistered(int32 index)
	{
		//Contract.EnsureNotDisposed(this, Disposed);
		//Contract.EnsureRange(index >= 0, nameof(index));

		//return touchInfo.GetTouchDeviceByIndex(index).IsRegistered;
		return default;
	}

	public TouchDevice GetTouchDevice(int32 index)
	{
            //Contract.EnsureNotDisposed(this, Disposed);
            //Contract.EnsureRange(index >= 0, nameof(index));

            //return index >= touchInfo.Count ? null : touchInfo.GetTouchDeviceByIndex(index);
		return default;
	}

	public TouchDevice GetFirstConnectedTouchDevice()
	{
            //Contract.EnsureNotDisposed(this, Disposed);

            //return touchInfo.Count > 0 ? touchInfo.GetTouchDeviceByIndex(0) : null;
		return null;
	}

	public TouchDevice GetFirstRegisteredTouchDevice()
	{
            //Contract.EnsureNotDisposed(this, Disposed);

            /*for (int i = 0; i < touchInfo.Count; i++)
            {
                var device = touchInfo.GetTouchDeviceByIndex(i);
                if (device.IsRegistered)
                    return device;
            }*/

            return null;
	}

	public TouchDevice GetPrimaryTouchDevice()
	{
            //Contract.EnsureNotDisposed(this, Disposed);

            return default;//primaryTouchDevice;
	}

	public bool EmulateMouseWithTouchInput{get; set;} = true;

	public bool IsMouseCursorAvailable => mouse.IsRegistered || (EmulateMouseWithTouchInput && IsTouchDeviceRegistered());

	/// <summary>
	/// Registers the specified device as having received user input.
	/// </summary>
	/// <param name="device">The device to register.</param>
	/// <returns><see langword="true"/> if the device was registered; otherwise, <see langword="false"/>.</returns>
	internal bool RegisterKeyboardDevice(SDLKeyboardDevice device)
	{
	    if (device.IsRegistered)
	        return false;

	    KeyboardRegistered?.Invoke(device);
	    return true;
	}

	/// <summary>
	/// Registers the specified device as having received user input.
	/// </summary>
	/// <param name="device">The device to register.</param>
	/// <returns><see langword="true"/> if the device was registered; otherwise, <see langword="false"/>.</returns>
	internal bool RegisterMouseDevice(SDLMouseDevice device)
	{
	    if (device.IsRegistered)
	        return false;

	    MouseRegistered?.Invoke(device);            
	    return true;
	}

	/// <summary>
	/// Registers the specified device as having received user input.
	/// </summary>
	/// <param name="device">The device to register.</param>
	/// <returns><see langword="true"/> if the device was registered; otherwise, <see langword="false"/>.</returns>
	/*internal bool RegisterGamePadDevice(SDLGamePadDevice device)
	{
	    if (primaryGamePad == null)
	        primaryGamePad = device;

	    if (device.IsRegistered)
	        return false;

	    GamePadRegistered?.Invoke(device, device.PlayerIndex);
	    return true;
	}*/

	/// <summary>
	/// Registers the specified device as having received user input.
	/// </summary>
	/// <param name="device">The device to register.</param>
	/// <returns><see langword="true"/> if the device was registered; otherwise, <see langword="false"/>.</returns>
	/*internal bool RegisterTouchDevice(SDLTouchDevice device)
	{
	    if (primaryTouchDevice == null)
	        primaryTouchDevice = device;

	    if (device.IsRegistered)
	        return false;

	    TouchDeviceRegistered?.Invoke(device);
	    return true;
	}*/

	/// <inheritdoc/>
	/*protected override void Dispose(bool disposing)
	{
	    if (Disposed)
	        return;

	    if (disposing)
	    {
	        if (FrameworkContext != null && !FrameworkContext.Disposed)
	            FrameworkContext.Messages.Unsubscribe(this);

	        SafeDispose.DisposeRef(ref keyboard);
	        SafeDispose.DisposeRef(ref mouse);
	        SafeDispose.DisposeRef(ref gamePadInfo);
	        SafeDispose.DisposeRef(ref touchInfo);
	    }

	    base.Dispose(disposing);
	}*/

	/// <summary>
	/// Attempts to load gamecontrollerdb.txt, if it is located in the application's root directory. 
	/// </summary>
	/*private void LoadGameControllerMappingDatabase(FrameworkContext context)
	{
	    const string DatabasePath = "gamecontrollerdb.txt";

	    var fss = new Sedulous.Platform.FileSystemService();
	    if (fss.FileExists(DatabasePath))
	    {
	        using (var stream = fss.OpenRead(DatabasePath))
	        using (var wrapper = new SDL2StreamWrapper(stream))
	        {
	            if (SDL_GameControllerAddMappingsFromRW(wrapper.ToIntPtr(), 0) < 0)
	                throw new SDL2Exception();
	        }
	    }
	}*/

	/// <summary>
	/// Raises the <see cref="GamePadConnected"/> event.
	/// </summary>
	/// <param name="device">The device that was connected.</param>
	/// <param name="playerIndex">The player index associated with the game pad.</param>
	private void OnGamePadConnected(GamePadDevice device, int32 playerIndex)
	{
	    GamePadConnected?.Invoke(device, playerIndex);
	}

	/// <summary>
	/// Raises the <see cref="GamePadDisconnected"/> event.
	/// </summary>
	/// <param name="device">The device that was disconnected.</param>
	/// <param name="playerIndex">The player index associated with the game pad.</param>
	/*private void OnGamePadDisconnected(GamePadDevice device, int32 playerIndex)
	{
	    if (primaryGamePad == device)
	        primaryGamePad = null;

	    GamePadDisconnected?.Invoke(device, playerIndex);
	}*/

	public EventAccessor<KeyboardRegistrationEventHandler> KeyboardRegistered { get; } = new .() ~ delete _;

	public EventAccessor<MouseRegistrationEventHandler> MouseRegistered { get; } = new .() ~ delete _;

	public EventAccessor<GamePadConnectionEventHandler> GamePadConnected { get; } = new .() ~ delete _;

	public EventAccessor<GamePadConnectionEventHandler> GamePadDisconnected { get; } = new .() ~ delete _;

	public EventAccessor<GamePadRegistrationEventHandler> GamePadRegistered { get; } = new .() ~ delete _;

	public EventAccessor<TouchDeviceRegistrationEventHandler> TouchDeviceRegistered { get; } = new .() ~ delete _;
}