using Sphenery.Core.Messaging;
using SDL2;
using System;
namespace Sphenery.SDL;

/// <summary>
/// Represents the message data for an SDL2Event message.
/// </summary>
[Reflect(.DefaultConstructor), AlwaysInclude(AssumeInstantiated=true)]
class SDLEventMessageData : MessageData
{
	/// <summary>
	/// Gets or sets the SDL event data.
	/// </summary>
	public SDL.Event Event { get; set; }

	public this(){}
}