using System.Collections;
namespace Sphenery.Framework.Platform.Window;

/// <summary>
/// Provides access to information concerning the system's attached display devices.
/// </summary>
public interface IDisplayInfo : IEnumerable<IDisplay>
{
    /// <summary>
    /// Gets the display with the specified index.
    /// </summary>
    /// <param name="index">The index of the display to retrieve.</param>
    /// <returns>The display with the specified index.</returns>
    IDisplay this[int index] { get; }

    /// <summary>
    /// Gets the application's primary display device.
    /// </summary>
    IDisplay PrimaryDisplay { get; }

    /// <summary>
    /// Gets the number of connected displays.
    /// </summary>
    int Count { get; }
}