using System.Collections;
using Sphenery.Core.Collections;
using System.Threading;
using System;
namespace Sphenery.Core.Messaging;

using internal Sphenery.Core.Messaging;

/// <summary>
/// Represents a message queue which exists entirely within the local process.
/// </summary>
/// <typeparam name="TMessageType">The type of message which is published by the queue.</typeparam>
public class LocalMessageQueue<TMessageType> : IMessageQueue<TMessageType> where TMessageType : IEquatable<TMessageType>, IHashable
{
	/// <summary>
	/// Initializes a new instance of the <see cref="LocalMessageQueue{TMessageType}"/> class with the default capacity.
	/// </summary>
	public this()
		: this(4)
	{
	}

	/// <summary>
	/// Initializes a new instance of the <see cref="LocalMessageQueue{TMessageType}"/> class with the specified initial capacity.
	/// </summary>
	/// <param name="capacity">The initial capacity of the message queue's pools.</param>
	public this(int32 capacity)
	{
		this.queue     = new Queue<EnqueuedMessage>(capacity);
		this.queuePool = new ExpandingPool<EnqueuedMessage>(capacity,
			new () => new EnqueuedMessage(),
			new (message) =>
			{
				delete message;
			});
	}

	public ~this()
	{
	}

	/// <summary>
	/// Creates or retrieves an instance of the specified message data type.
	/// The instance may be retrieved from a pool; if so, it will be returned to the pool 
	/// once it has been published.
	/// </summary>
	/// <typeparam name="TMessageData">The type of message data object to create.</typeparam>
	/// <returns>The instance that was created or retrieved.</returns>
	public TMessageData CreateMessageData<TMessageData>() where TMessageData : MessageData, new
	{
		TMessageData data;
		using (mMessageDataPoolMonitor.Enter())
		{
			data = messageDataPools.Get<TMessageData>(1).Retrieve();
		}
		data.Reset();
		return data;
	}

	/// <inheritdoc/>
	public void Subscribe(IMessageSubscriber<TMessageType> receiver, TMessageType type)
	{
		using (mSubscribersMonitor.Enter())
		{
			subscribers[type].Add(receiver);
		}
	}

	/// <inheritdoc/>
	public void Subscribe(IMessageSubscriber<TMessageType> receiver, params TMessageType[] types)
	{
		using (mSubscribersMonitor.Enter())
		{
			if (types != null)
			{
				for (var type in types)
				{
					subscribers[type].Add(receiver);
				}
			}
		}
	}

	/// <inheritdoc/>
	public void Unsubscribe(IMessageSubscriber<TMessageType> receiver)
	{
		using (mSubscribersMonitor.Enter())
		{
			subscribers.RemoveFromAll(receiver);
		}
	}

	/// <inheritdoc/>
	public void Unsubscribe(IMessageSubscriber<TMessageType> receiver, TMessageType type)
	{
		using (mSubscribersMonitor.Enter())
		{
			subscribers[type].Remove(receiver);
		}
	}

	/// <inheritdoc/>
	public void Publish(TMessageType type, MessageData data)
	{
		// If the specified data is potentially mergable, scan the queue
		// for an existing message that can be merged with it and perform the merge.
		if (data != null && data.IsMergeable)
		{
			using (mQueueMonitor.Enter())
			{
				for (var enqueuedMessage in queue)
				{
					if (enqueuedMessage.Type.Equals(type)) // todo: sedulous should be negated perhaps?
						continue;

					var merged = data.EvaluateMerge(enqueuedMessage.Data);
					if (merged != null)
					{
						if (!enqueuedMessage.Data.GetType().IsAssignableFrom(merged.GetType()))
							Runtime.FatalError("MessageMergeTypeConflict");

						enqueuedMessage.Data = merged;
						return;
					}
				}
			}
		}

		// If the message could not be merged, add it to the message queue.
		using (mQueueMonitor.Enter())
		{
			queue.Add(CreateEnqueuedMessage(type, data));
		}
	}

	/// <inheritdoc/>
	public void PublishImmediate(TMessageType type, MessageData data)
	{
		using (mSubscribersMonitor.Enter())
		{
			subscribers.ReceiveMessage(type, data);
		}
	}

	/// <inheritdoc/>
	internal void Process()
	{
		while (true)
		{
			// Retrieve the next message from the queue.
			EnqueuedMessage evt;
			using (mQueueMonitor.Enter())
			{
				if (queue.Count == 0)
				{
					break;
				}
				evt = queue.PopFront();
			}


			defer
			{
				if (evt.Data != null)
				{
					using (mMessageDataPoolMonitor.Enter())
					{
						var pool = messageDataPools.Get(evt.Data.GetType());
						if (pool == null)
						{
							Runtime.FatalError("Message Pool Not Found");
						}
						pool.Release(evt.Data);
					}
				}
				using (mQueueMonitor.Enter())
				{
					queuePool.Release(evt);
				}
			}

			// Broadcast the message to all subscribers.
			{
				using (mSubscribersMonitor.Enter())
				{
					subscribers.ReceiveMessage(evt.Type, evt.Data);
				}
			}
		}
	}

	/// <summary>
	/// Creates an enqueued message.
	/// </summary>
	/// <param name="type">The message type.</param>
	/// <param name="data">The message data.</param>
	/// <returns>The enqueued message.</returns>
	private EnqueuedMessage CreateEnqueuedMessage(TMessageType type, MessageData data)
	{
		var evt = queuePool.Retrieve();
		evt.Type = type;
		evt.Data = data;
		return evt;
	}

	// The queue's message data pools.
	private readonly ExpandingPoolRegistry messageDataPools = new .() ~ delete _;

	// The queue's pending messages.
	private readonly Queue<EnqueuedMessage> queue ~ delete _;
	private readonly IPool<EnqueuedMessage> queuePool ~ delete _;

	// The queue's subscriber registry.
	private readonly SubscriberCollection<TMessageType> subscribers = new .() ~ delete _;

	private readonly Monitor mQueueMonitor = new .() ~ delete _;
	private readonly Monitor mMessageDataPoolMonitor = new .() ~ delete _;
	private readonly Monitor mSubscribersMonitor = new .() ~ delete _;
}