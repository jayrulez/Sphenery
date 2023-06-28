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
	public IWindowSystem WindowSystem => mWindowSystem;
	public IInputSystem InputSystem => mInputSystem;

	private readonly SDLWindowSystem mWindowSystem = new .(this) ~ delete _;
	private readonly SDLInputSystem mInputSystem = new .(this) ~ delete _;
	private readonly Application mApplication;

	public this(Application application)
	{
		mApplication = application;
	}
}