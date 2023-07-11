using Sphenery.Framework.Platform.Window;
namespace Sphenery.SDL.Platform;

/// <summary>
/// Represents a service which is responsible for querying the screen's rotation.
/// </summary>
public abstract class ScreenRotationService
{
    /// <summary>
    /// Initializes a new instance of the <see cref="ScreenRotationService"/> class.
    /// </summary>
    /// <param name="display">The <see cref="IDisplay"/> for which to retrieve rotation information.</param>
    protected this(IDisplay display)
    {
        //Contract.Require(display, nameof(display));
    }

    /// <summary>
    /// Gets the screen's rotation on devices which can be rotated.
    /// </summary>
    public abstract ScreenRotation ScreenRotation
    {
        get;
    }
}