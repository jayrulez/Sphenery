using Sphenery.Framework.Platform.Window;
namespace Sphenery.SDL.Platform;

/// <summary>
/// Represents an implementation of the <see cref="ScreenRotationService"/> class for SDL.
/// </summary>
public sealed class SDLScreenRotationService : ScreenRotationService
{
    /// <summary>
    /// Initializes a new instance of the <see cref="SDLScreenRotationService"/> class.
    /// </summary>
    /// <param name="display">The <see cref="IDisplay"/> for which to retrieve rotation information.</param>
    public this(IDisplay display)
        : base(display)
    {

    }

    /// <inheritdoc/>
    public override ScreenRotation ScreenRotation
    {
        get { return .Rotation0; }
    }
}