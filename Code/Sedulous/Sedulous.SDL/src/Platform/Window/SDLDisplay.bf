using Sedulous.Framework.Platform.Window;
using Sedulous.Core.Mathematics;
using System;
using System.Collections;
using SDL2;
using Sedulous.Framework;
namespace Sedulous.SDL.Platform.Window;

class SDLDisplay : IDisplay
{
        // SDL2 display info.
        private readonly int displayIndex;
        private readonly String name = new .() ~ delete _;
        private readonly List<DisplayMode> displayModes = new .() ~ DeleteContainerAndItems!(_);
        private readonly DisplayMode desktopDisplayMode ~ delete _;

        // Services.
        //private readonly ScreenRotationService screenRotationService;
        //private readonly ScreenDensityService screenDensityService;

	/// <summary>
	/// Initializes a new instance of the OpenGLSedulousDisplay class.
	/// </summary>
	/// <param name="context">The Sedulous context.</param>
	/// <param name="displayIndex">The SDL2 display index that this object represents.</param>
	public this(int displayIndex)
	{
	    //Contract.Require(context, nameof(context));

	    this.displayIndex = displayIndex;

		int displayModesCount = SDL.GetNumDisplayModes((.)displayIndex);
		for(int modeIndex = 0; modeIndex < displayModesCount; modeIndex++){
			this.displayModes.Add(CreateDisplayModeFromSDL((.)displayIndex, (.)modeIndex));
		}

	    this.name.Set(scope String(SDL.GetDisplayName((.)displayIndex)));

	    SDL.SDL_DisplayMode sdlDesktopDisplayMode = .();
	    if (SDL.GetDesktopDisplayMode((.)displayIndex, out sdlDesktopDisplayMode) < 0)
	        Runtime.FatalError(scope $"Failed to get desktop display mode for display {displayIndex}.");

	    this.desktopDisplayMode = CreateDisplayModeFromSDL(sdlDesktopDisplayMode);

	    //this.screenRotationService = ScreenRotationService.Create(this);
	    //this.screenDensityService = ScreenDensityService.Create(this);
	}

	public Span<DisplayMode> GetSupportedDisplayModes()
	{
		return this.displayModes;
	}

	public double InchesToPixels(double inches)
	{
		return DipsToPixels(96.0 * inches);
	}

	public double PixelsToInches(double pixels)
	{
		return PixelsToDips(pixels) / 96.0;
	}

	public double DipsToPixels(double dips)
	{
		if (Double.PositiveInfinity ==dips)
		{
		    return Int32.MaxValue;
		}
		if (Double.NegativeInfinity == dips)
		{
		    return Int32.MinValue;
		}
		return dips * DensityScale;
	}

	public double PixelsToDips(double pixels)
	{
		return pixels / DensityScale;
	}

	public double InchesToDips(double inches)
	{
		return 96.0 * inches;
	}

	public double DipsToInches(double dips)
	{
		return dips / 96.0;
	}

	public Point2D InchesToPixels(Point2D inches)
	{
		var x = InchesToPixels(inches.X);
		var y = InchesToPixels(inches.Y);

		return Point2D(x, y);
	}

	public Point2D PixelsToInches(Point2D pixels)
	{
		var x = PixelsToInches(pixels.X);
		var y = PixelsToInches(pixels.Y);

		return Point2D(x, y);
	}

	public Point2D DipsToPixels(Point2D dips)
	{
		var x = DipsToPixels(dips.X);
		var y = DipsToPixels(dips.Y);

		return Point2D(x, y);
	}

	public Point2D PixelsToDips(Point2D pixels)
	{
		var x = PixelsToDips(pixels.X);
		var y = PixelsToDips(pixels.Y);

		return Point2D(x, y);
	}

	public Point2D InchesToDips(Point2D inches)
	{
		var x = InchesToDips(inches.X);
		var y = InchesToDips(inches.Y);

		return Point2D(x, y);
	}

	public Point2D DipsToInches(Point2D dips)
	{
		var x = DipsToInches(dips.X);
		var y = DipsToInches(dips.Y);

		return Point2D(x, y);
	}

	public Size2D InchesToPixels(Size2D inches)
	{
		var width = InchesToPixels(inches.Width);
		var height = InchesToPixels(inches.Height);

		return Size2D(width, height);
	}

	public Size2D PixelsToInches(Size2D pixels)
	{
		var width = PixelsToInches(pixels.Width);
		var height = PixelsToInches(pixels.Height);

		return Size2D(width, height);
	}

	public Size2D DipsToPixels(Size2D dips)
	{
		var width = DipsToPixels(dips.Width);
		var height = DipsToPixels(dips.Height);

		return Size2D(width, height);
	}

	public Size2D PixelsToDips(Size2D pixels)
	{
		var width = PixelsToDips(pixels.Width);
		var height = PixelsToDips(pixels.Height);

		return Size2D(width, height);
	}

	public Size2D InchesToDips(Size2D inches)
	{
		var width = InchesToDips(inches.Width);
		var height = InchesToDips(inches.Height);

		return Size2D(width, height);
	}

	public Size2D DipsToInches(Size2D dips)
	{
		var width = DipsToInches(dips.Width);
		var height = DipsToInches(dips.Height);

		return Size2D(width, height);
	}

	public RectangleD InchesToPixels(RectangleD inches)
	{
		var x = InchesToPixels(inches.X);
		var y = InchesToPixels(inches.Y);
		var width = InchesToPixels(inches.Width);
		var height = InchesToPixels(inches.Height);

		return RectangleD(x, y, width, height);
	}

	public RectangleD PixelsToInches(RectangleD pixels)
	{
		var x = PixelsToInches(pixels.X);
		var y = PixelsToInches(pixels.Y);
		var width = PixelsToInches(pixels.Width);
		var height = PixelsToInches(pixels.Height);

		return RectangleD(x, y, width, height);
	}

	public RectangleD DipsToPixels(RectangleD dips)
	{
		var x = DipsToPixels(dips.Left);
		var y = DipsToPixels(dips.Top);
		var width = DipsToPixels(dips.Width);
		var height = DipsToPixels(dips.Height);

		return RectangleD(x, y, width, height);
	}

	public RectangleD PixelsToDips(RectangleD pixels)
	{
		var x = PixelsToDips(pixels.X);
		var y = PixelsToDips(pixels.Y);
		var width = PixelsToDips(pixels.Width);
		var height = PixelsToDips(pixels.Height);

		return RectangleD(x, y, width, height);
	}

	public RectangleD InchesToDips(RectangleD inches)
	{
		var x = InchesToDips(inches.X);
		var y = InchesToDips(inches.Y);
		var width = InchesToDips(inches.Width);
		var height = InchesToDips(inches.Height);

		return RectangleD(x, y, width, height);
	}

	public RectangleD DipsToInches(RectangleD dips)
	{
		var x = DipsToInches(dips.X);
		var y = DipsToInches(dips.Y);
		var width = DipsToInches(dips.Width);
		var height = DipsToInches(dips.Height);

		return RectangleD(x, y, width, height);
	}

	public Vector2 InchesToPixels(Vector2 inches)
	{
		var x = (float)InchesToPixels(inches.X);
		var y = (float)InchesToPixels(inches.Y);

		return Vector2(x, y);
	}

	public Vector2 PixelsToInches(Vector2 pixels)
	{
		var x = (float)PixelsToInches(pixels.X);
		var y = (float)PixelsToInches(pixels.Y);

		return Vector2(x, y);
	}

	public Vector2 DipsToPixels(Vector2 dips)
	{
		var x = (float)DipsToPixels(dips.X);
		var y = (float)DipsToPixels(dips.Y);

		return Vector2(x, y);
	}

	public Vector2 PixelsToDips(Vector2 pixels)
	{
		var x = (float)PixelsToDips(pixels.X);
		var y = (float)PixelsToDips(pixels.Y);

		return Vector2(x, y);
	}

	public Vector2 InchesToDips(Vector2 inches)
	{
		var x = (float)InchesToDips(inches.X);
		var y = (float)InchesToDips(inches.Y);

		return Vector2(x, y);
	}

	public Vector2 DipsToInches(Vector2 dips)
	{
		var x = (float)DipsToInches(dips.X);
		var y = (float)DipsToInches(dips.Y);

		return Vector2(x, y);
	}

	/// <summary>
	/// Updates the display's state.
	/// </summary>
	/// <param name="time">Time elapsed since the last call to <see cref="FrameworkContext.Update(FrameworkTime)"/>.</param>
	public void Update(ApplicationTime time)
	{

	}

	public int32 Index
	{
		get
		{
			return (.)displayIndex;
		}
	}

	public System.String Name
	{
		get
		{
			return name;
		}
	}

	public Rectangle Bounds
	{
		get
		{
			SDL.Rect bounds = .();
			SDL.GetDisplayBounds((.)displayIndex, out bounds);

			return Rectangle(bounds.x, bounds.y, bounds.w, bounds.h);
		}
	}

	public ScreenRotation Rotation
	{
		get
		{
			return default; // todo sedulous
		}
	}

	public float DeviceScale
	{
		get
		{
			return default; // todo sedulous
		}
	}

	public float DensityScale
	{
		get
		{
			return default; // todo sedulous
		}
	}

	public float DpiX
	{
		get
		{
			return default; // todo sedulous
		}
	}

	public float DpiY
	{
		get
		{
			return default; // todo sedulous
		}
	}

	public ScreenDensityBucket DensityBucket
	{
		get
		{
			return default; // todo sedulous
		}
	}

	public DisplayMode DesktopDisplayMode
	{
		get
		{
			return desktopDisplayMode;
		}
	}

	/// <summary>
	/// Instructs the display to re-query its density information.
	/// </summary>
	internal void RefreshDensityInformation()
	{
	    /*var oldDensityBucket = screenDensityService.DensityBucket;
	    var oldDensityScale = screenDensityService.DensityScale;
	    var oldDensityX = screenDensityService.DensityX;
	    var oldDensityY = screenDensityService.DensityY;
	    var oldDeviceScale = screenDensityService.DeviceScale;

	    if (screenDensityService.Refresh())
	    {
	        var messageData = context.Messages.CreateMessageData<DisplayDensityChangedMessageData>();
	        messageData.Display = this;
	        context.Messages.Publish(FrameworkMessages.DisplayDensityChanged, messageData);
	    }*/
	}

	/// <summary>
	/// Creates an Sedulous DisplayMode object from the specified SDL2 display mode.
	/// </summary>
	private DisplayMode CreateDisplayModeFromSDL(SDL.SDL_DisplayMode mode)
	{
	    int32 bpp;
	    uint32 Rmask, Gmask, Bmask, Amask;
	    SDL.PixelFormatEnumToMasks((uint32)mode.format, out bpp, out Rmask, out Gmask,out Bmask, out Amask);

	    return new DisplayMode(mode.w, mode.h, bpp, mode.refresh_rate, Index);
	}

	/// <summary>
	/// Creates an Sedulous DisplayMode object from the specified SDL2 display mode.
	/// </summary>
	private DisplayMode CreateDisplayModeFromSDL(int32 displayIndex, int32 modeIndex)
	{
	    SDL.SDL_DisplayMode mode = .();
	    SDL.GetDisplayMode(displayIndex, modeIndex, out mode);

	    return CreateDisplayModeFromSDL(mode);
	}
}