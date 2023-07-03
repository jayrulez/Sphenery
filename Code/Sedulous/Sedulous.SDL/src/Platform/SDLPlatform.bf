using Sedulous.Framework.Platform;
using Sedulous.SDL.Platform.Input;
using Sedulous.Framework.Platform.Input;
using Sedulous.Framework.Platform.Window;
using Sedulous.SDL.Platform.Window;
using Sedulous.Framework;
namespace Sedulous.SDL.Platform;

class SDLPlatform : IPlatform
{
	public Application Application => mApplication;
	public IDisplayInfo Displays => mDisplayInfo;
	public IWindowSystem WindowSystem => mWindowSystem;
	public IInputSystem InputSystem => mInputSystem;

	private readonly SDLDisplayInfo mDisplayInfo = new .() ~ delete _;
	private readonly SDLWindowSystem mWindowSystem ~ delete _;
	private readonly SDLInputSystem mInputSystem ~ delete _;
	private readonly Application mApplication;

	public this(Application application)
	{
		mApplication = application;
		mWindowSystem = new .(this);
		mInputSystem = new .(this);
	}
}