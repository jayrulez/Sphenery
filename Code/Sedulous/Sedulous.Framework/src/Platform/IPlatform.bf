using Sedulous.Framework.Platform.Input;
using Sedulous.Framework.Platform.Window;
namespace Sedulous.Framework.Platform;

interface IPlatform
{
	Application Application { get; }
	IDisplayInfo Displays { get; }
	IWindowSystem WindowSystem { get; }
	IInputSystem InputSystem { get; }
}