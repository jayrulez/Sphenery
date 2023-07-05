using System.Collections;
using System;
namespace Sphenery.Core.Messaging;

/// <summary>
/// Represents a message queue which exists entirely within the local process.
/// </summary>
/// <typeparam name="TMessageType">The type of message which is published by the queue.</typeparam>
extension LocalMessageQueue<TMessageType> : IMessageQueue<TMessageType> where TMessageType : IEquatable<TMessageType>, IHashable
{
	/// <summary>
	/// Represents a pending message in the message queue.
	/// </summary>
	protected class EnqueuedMessage
	{
	    /// <summary>
	    /// The message type.
	    /// </summary>
	    public TMessageType Type
	    {
	        get;
	        internal set;
	    }

	    /// <summary>
	    /// The message data.
	    /// </summary>
	    public MessageData Data
	    {
	        get;
	        internal set;
	    }
	}
}