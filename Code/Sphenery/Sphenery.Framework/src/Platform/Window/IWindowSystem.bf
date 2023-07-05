using System;
namespace Sphenery.Framework.Platform.Window;

interface IWindowSystem
{
	//Span<IWindow> Windows { get; }

	IWindow PrimaryWindow { get; }

	Result<void> CreateWindow(StringView title, int32 width, int32 height, bool visible, out IWindow window);

	void DestroyWindow(IWindow window);

	IWindow GetWindowById(int32 windowId);

	IPlatform Platform {get;}
}