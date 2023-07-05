using Sphenery.Framework.Messaging;
namespace Sphenery.Framework;

static class ApplicationMessages
{
	/// <summary>
	/// An event indicating that the application should exit.
	/// </summary>
	public static readonly MessageId Quit = MessageId.Acquire(nameof(Quit));

	/// <summary>
	/// An event indicating that the application is being terminated by the operating system.
	/// </summary>
	public static readonly MessageId ApplicationTerminating = MessageId.Acquire(nameof(ApplicationTerminating));

	/// <summary>
	/// An event indicating that the application is about to be suspended.
	/// </summary>
	public static readonly MessageId ApplicationSuspending = MessageId.Acquire(nameof(ApplicationSuspending));

	/// <summary>
	/// An event indicating that the application was suspended.
	/// </summary>
	public static readonly MessageId ApplicationSuspended = MessageId.Acquire(nameof(ApplicationSuspended));

	/// <summary>
	/// An event indicating that the application is about to resume after being suspended.
	/// </summary>
	public static readonly MessageId ApplicationResuming = MessageId.Acquire(nameof(ApplicationResuming));

	/// <summary>
	/// An event indicating that the application was resumed after being suspended.
	/// </summary>
	public static readonly MessageId ApplicationResumed = MessageId.Acquire(nameof(ApplicationResumed));

	/// <summary>
	/// An event indicating that the operation system is low on memory.
	/// </summary>
	public static readonly MessageId LowMemory = MessageId.Acquire(nameof(LowMemory));
}