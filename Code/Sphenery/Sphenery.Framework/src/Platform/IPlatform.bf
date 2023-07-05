using Sphenery.Framework.Platform.Input;
using Sphenery.Framework.Platform.Window;
namespace Sphenery.Framework.Platform;

interface IPlatform
{
	Application Application { get; }
	IDisplayInfo Displays { get; }
	IWindowSystem WindowSystem { get; }
	IInputSystem InputSystem { get; }
}