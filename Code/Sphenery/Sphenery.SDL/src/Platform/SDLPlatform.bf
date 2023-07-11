using Sphenery.Framework.Platform;
using Sphenery.SDL.Platform.Input;
using Sphenery.Framework.Platform.Input;
using Sphenery.Framework.Platform.Window;
using Sphenery.SDL.Platform.Window;
using Sphenery.Framework;
namespace Sphenery.SDL.Platform;

class SDLPlatform : IPlatform
{
	public Application Application => mApplication;
	public IDisplayInfo Displays => mDisplayInfo;
	public IWindowSystem WindowSystem => mWindowSystem;
	public IInputSystem InputSystem => mInputSystem;

	private readonly SDLDisplayInfo mDisplayInfo ~ delete _;
	private readonly SDLWindowSystem mWindowSystem ~ delete _;
	private readonly SDLInputSystem mInputSystem ~ delete _;
	private readonly Application mApplication;

	public this(Application application)
	{
		mApplication = application;
		mDisplayInfo = new .(this);
		mWindowSystem = new .(this);
		mInputSystem = new .(this);
	}
}