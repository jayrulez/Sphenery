using Sedulous.Framework.Platform;
using System;
using SDL2;
namespace Sedulous.SDL.Platform;

class SDLWindow : IWindow
{
	private SDL.Window* mSDLNativeWindow;

	public int32 Id => mId;

	public StringView Title => mTitle;

	public int32 Width => mWidth;

	public int32 Height => mHeight;

	public bool Visible => mVisible;

	private int32 mId;
	private String mTitle = new .() ~ delete _;
	private int32 mWidth;
	private int32 mHeight;
	private bool mVisible;

	public this(StringView title, int32 width, int32 height, bool visible)
	{
		SDL.WindowFlags flags = SDL.WindowFlags.Resizable;
		if (visible)
			flags |= .Shown;

		mSDLNativeWindow = SDL.CreateWindow(mTitle.CStr(), .Undefined, .Undefined, (int32)width, (int32)height, flags);

		if (mSDLNativeWindow == null)
		{
			Runtime.FatalError("Failed to create SDL window.");
		}

		mId = (int32)SDL.GetWindowID(mSDLNativeWindow);

		SDL.SDL_SysWMinfo info = .();
		SDL.GetVersion(out info.version);
		SDL.GetWindowWMInfo(mSDLNativeWindow, ref info);
		SDL.SDL_SYSWM_TYPE subsystem = info.subsystem;
		switch (subsystem) {
		case SDL.SDL_SYSWM_TYPE.SDL_SYSWM_WINDOWS:
			/*OSNativeWindow = (void*)(int)info.info.win.window;
			SurfaceInfo = .(.()
				{
					Windows = .()
						{
							Hwnd = NativeWindow
						}
				}, .Windows);*/
			break;

		case SDL.SDL_SYSWM_TYPE.SDL_SYSWM_UNKNOWN: fallthrough;
		default:
			Runtime.FatalError("Subsystem not currently supported.");
		}
	}

	public ~this()
	{
		if (mSDLNativeWindow != null)
		{
			SDL.DestroyWindow(mSDLNativeWindow);
			mSDLNativeWindow = null;
		}
	}
}