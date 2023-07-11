using Sphenery.Core.Messaging;
using Sphenery.Framework.Platform.Window;
namespace Sphenery.Framework.Messaging;

/// <summary>
/// Represents the message data for a Display Density Changed message.
/// </summary>
public sealed class DisplayDensityChangedMessageData : MessageData
{
    /// <summary>
    /// Gets or sets the display which changed density.
    /// </summary>
    public IDisplay Display
    {
        get;
        set;
    }
}