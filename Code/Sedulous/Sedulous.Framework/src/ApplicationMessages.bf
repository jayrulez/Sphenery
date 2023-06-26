using Sedulous.Framework.Messaging;
namespace Sedulous.Framework;

static class ApplicationMessages
{
	/// <summary>
	/// An event indicating that the application should exit.
	/// </summary>
	public static readonly MessageId Quit = MessageId.Acquire(nameof(Quit));
}