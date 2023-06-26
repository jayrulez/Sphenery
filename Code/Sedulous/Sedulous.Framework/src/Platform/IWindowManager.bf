using System;
namespace Sedulous.Framework.Platform;

interface IWindowManager
{
	//Span<IWindow> Windows { get; }

	IWindow PrimaryWindow { get; }

	Result<void> CreateWindow(StringView title, int32 width, int32 height, bool visible, out IWindow window);

	void DestroyWindow(IWindow window);

	IWindow GetWindowById(int32 windowId);
}