using System.Collections;
using System;
using System.Threading;
using Sphenery.Core.Collections;
namespace Sphenery.Core.Messaging;

/// <summary>
/// Represents a collection of message subscribers.
/// </summary>
/// <typeparam name="TMessageType">The type of message received by the subscribers in this collection.</typeparam>
public class SubscriberCollection<TMessageType> where TMessageType : IEquatable<TMessageType>, IHashable
{
	/// <summary>
	/// Pushes the specified message to all subscribers to the specified message type.
	/// </summary>
	/// <param name="messageType">The type of message being pushed.</param>
	/// <param name="data">The data for the message being pushed.</param>
	public void ReceiveMessage(TMessageType messageType, MessageData data)
	{
		var tempstorage = default(List<IMessageSubscriber<TMessageType>>);

		using (tempstoragePoolMonitor.Enter())
			tempstorage = tempstoragePool.Retrieve();

		for (var sub in this[messageType])
			tempstorage.Add(sub);

		for (var subscriber in tempstorage)
		{
			subscriber.ReceiveMessage(messageType, data);
		}

		using (tempstoragePoolMonitor.Enter())
			tempstoragePool.Release(tempstorage);
	}

	/// <summary>
	/// Purges the subscriber list associated with the specified message type.
	/// </summary>
	/// <param name="messageType">The type of message for which to purge subscribers.</param>
	public void Purge(TMessageType messageType)
	{
		subscribers.Remove(messageType);
	}

	/// <summary>
	/// Purges the subscriber lists associated with all message types.
	/// </summary>
	public void PurgeAll()
	{
		for (var subscriber in subscribers)
		{
			delete subscriber.value;
		}

		subscribers.Clear();
	}

	/// <summary>
	/// Removes the specified subscriber from all subscriber lists.
	/// </summary>
	/// <param name="subscriber">The subscriber to remove.</param>
	public void RemoveFromAll(IMessageSubscriber<TMessageType> subscriber)
	{
		//Contract.Require(subscriber, nameof(subscriber));

		for (var collection in subscribers)
		{
			collection.value.Remove(subscriber);
		}
	}

	/// <summary>
	/// Gets the set of subscribers which are subscribed to the specified message type.
	/// </summary>
	/// <param name="type">The type of message for which to get a subscriber list.</param>
	/// <returns>The set of subscribers which are subscribed to the specified message type.</returns>
	public HashSet<IMessageSubscriber<TMessageType>> this[TMessageType type]
	{
		get
		{
			HashSet<IMessageSubscriber<TMessageType>> subscribersToMessageType;
			if (!subscribers.TryGetValue(type, out subscribersToMessageType))
			{
				subscribersToMessageType = new HashSet<IMessageSubscriber<TMessageType>>();
				subscribers[type] = subscribersToMessageType;
			}
			return subscribersToMessageType;
		}
	}

	private readonly Monitor tempstoragePoolMonitor = new .() ~ delete _;

	// The underlying table of subscribers for each message type.
	private readonly Dictionary<TMessageType, HashSet<IMessageSubscriber<TMessageType>>> subscribers =
		new .() ~ DeleteDictionaryAndValues!(_);

	// A list which temporarily stores the list of subscribers while
	// publishing messages, so that the subscription table can be updated during enumeration.
	private readonly IPool<List<IMessageSubscriber<TMessageType>>> tempstoragePool =
		new ExpandingPool<List<IMessageSubscriber<TMessageType>>>(
		capacity: 1,
		allocator: new () => new List<IMessageSubscriber<TMessageType>>(),
		deallocator: new (item) =>
		{
			item.Clear();
			delete item;
		}
		) ~ { _.Dispose(); delete _; };
}