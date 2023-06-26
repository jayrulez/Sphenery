using Sedulous.Framework.Platform;
namespace Sedulous.SDL.Platform;

class SDLWindowSystem : IWindowSystem
{
	public IWindowManager WindowManager => mWindowManager;

	private readonly SDLWindowManager mWindowManager = new .() ~ delete _;
}