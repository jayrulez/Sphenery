using Sphenery.Framework.Platform;
using Sphenery.Framework.Platform.Window;
using System;
using SDL2;
namespace Sphenery.SDL.Platform;

/// <summary>
/// Represents an implentation of <see cref="ScreenDensityService"/> using the SDL2 library.
/// </summary>
public sealed class SDLScreenDensityService : ScreenDensityService
{
    /// <summary>
    /// Initializes a new instance of the <see cref="SDL2ScreenDensityService"/> class.
    /// </summary>
    /// <param name="context">The Sedulous context.</param>
    /// <param name="display">The <see cref="IDisplay"/> for which to retrieve density information.</param>
    public this(IDisplay display)
        : base(display)
    {
        //Contract.Require(context, nameof(context));

        this.display = display;

        Refresh();
    }

    /// <inheritdoc/>
    public override bool Refresh()
    {
        var oldDensityX = densityX;
        var oldDensityY = densityY;
        var oldDensityScale = densityScale;
        var oldDensityBucket = densityBucket;

        float hdpi, vdpi;
        if (SDL.GetDisplayDPI(display.Index, ?, out hdpi, out vdpi) < 0)
                Runtime.FatalError("Failed to get display DPI.");  

        this.densityX = hdpi;
        this.densityY = vdpi;
        this.densityScale = hdpi / 96f;
        this.densityBucket = GuessBucketFromDensityScale(densityScale);

        return oldDensityX != densityX || oldDensityY != densityY || oldDensityScale != densityScale || oldDensityBucket != densityBucket;
    }

    /// <inheritdoc/>
    public override float DeviceScale
    {
        get { return 1f; }
    }

    /// <inheritdoc/>
    public override float DensityScale
    {
        get { return densityScale; }
    }

    /// <inheritdoc/>
    public override float DensityX
    {
        get { return densityX; }
    }

    /// <inheritdoc/>
    public override float DensityY
    {
        get { return densityY; }
    }

    /// <inheritdoc/>
    public override ScreenDensityBucket DensityBucket
    {
        get { return densityBucket; }
    }

    // State values.
    private readonly IDisplay display;
    private float densityX;
    private float densityY;
    private float densityScale;
    private ScreenDensityBucket densityBucket;
}