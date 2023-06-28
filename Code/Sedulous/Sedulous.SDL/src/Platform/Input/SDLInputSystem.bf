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
namespace Sedulous.SDL.Platform.Input;

using internal Sedulous.Core;

class SDLInputSystem : IInputSystem, IMessageSubscriber<MessageId>
{
	private readonly IPlatform mPlatform;

	public IPlatform Platform => mPlatform;

	public this(IPlatform platform)
	{
		mPlatform = platform;
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

	public void ShowSoftwareKeyboard()
	{
	}

	public void ShowSoftwareKeyboard(KeyboardMode mode)
	{
	}

	public void HideSoftwareKeyboard()
	{
	}

	public bool IsKeyboardSupported()
	{
		return default;
	}

	public bool IsKeyboardRegistered()
	{
		return default;
	}

	public KeyboardDevice GetKeyboard()
	{
		return default;
	}

	public bool IsMouseSupported()
	{
		return default;
	}

	public bool IsMouseRegistered()
	{
		return default;
	}

	public MouseDevice GetMouse()
	{
		return default;
	}

	public int32 GetGamePadCount()
	{
		return default;
	}

	public bool IsGamePadSupported()
	{
		return default;
	}

	public bool IsGamePadConnected()
	{
		return default;
	}

	public bool IsGamePadConnected(int32 playerIndex)
	{
		return default;
	}

	public bool IsGamePadRegistered()
	{
		return default;
	}

	public bool IsGamePadRegistered(int32 playerIndex)
	{
		return default;
	}

	public GamePadDevice GetGamePadForPlayer(int32 playerIndex)
	{
		return default;
	}

	public GamePadDevice GetFirstConnectedGamePad()
	{
		return default;
	}

	public GamePadDevice GetFirstRegisteredGamePad()
	{
		return default;
	}

	public GamePadDevice GetPrimaryGamePad()
	{
		return default;
	}

	public bool IsTouchSupported()
	{
		return default;
	}

	public bool IsTouchDeviceConnected()
	{
		return default;
	}

	public bool IsTouchDeviceConnected(int32 index)
	{
		return default;
	}

	public bool IsTouchDeviceRegistered()
	{
		return default;
	}

	public bool IsTouchDeviceRegistered(int32 index)
	{
		return default;
	}

	public TouchDevice GetTouchDevice(int32 index)
	{
		return default;
	}

	public TouchDevice GetFirstConnectedTouchDevice()
	{
		return default;
	}

	public TouchDevice GetFirstRegisteredTouchDevice()
	{
		return default;
	}

	public TouchDevice GetPrimaryTouchDevice()
	{
		return default;
	}

	public bool EmulateMouseWithTouchInput
	{
		get
		{
			return default;
		}

		set
		{
		}
	}

	public bool IsMouseCursorAvailable
	{
		get
		{
			return default;
		}
	}

	/// <summary>
	/// Registers the specified device as having received user input.
	/// </summary>
	/// <param name="device">The device to register.</param>
	/// <returns><see langword="true"/> if the device was registered; otherwise, <see langword="false"/>.</returns>
	/*internal bool RegisterKeyboardDevice(SDLKeyboardDevice device)
	{
	    if (device.IsRegistered)
	        return false;

	    KeyboardRegistered?.Invoke(device);
	    return true;
	}*/

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

	public EventAccessor<KeyboardRegistrationEventHandler> KeyboardRegistered { get; } = new .() ~ delete _;

	public EventAccessor<MouseRegistrationEventHandler> MouseRegistered { get; } = new .() ~ delete _;

	public EventAccessor<GamePadConnectionEventHandler> GamePadConnected { get; } = new .() ~ delete _;

	public EventAccessor<GamePadConnectionEventHandler> GamePadDisconnected { get; } = new .() ~ delete _;

	public EventAccessor<GamePadRegistrationEventHandler> GamePadRegistered { get; } = new .() ~ delete _;

	public EventAccessor<TouchDeviceRegistrationEventHandler> TouchDeviceRegistered { get; } = new .() ~ delete _;
}