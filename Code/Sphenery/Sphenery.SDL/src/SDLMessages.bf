using Sphenery.Framework.Messaging;
namespace Sphenery.SDL;

static class SDLMessages
{
	/// <summary>
	/// An event indicating that an SDL event was raised.
	/// </summary>
	public static readonly MessageId SDLEvent = MessageId.Acquire(nameof(SDLEvent));
}