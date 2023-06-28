using System;
namespace Sedulous.Core.Collections;

/// <summary>
/// Represents a pre-allocated pool of objects which can expand if all of its objects are consumed.
/// </summary>
/// <typeparam name="T">The type of item contained by the pool.</typeparam>
public class ExpandingPool<T> : Pool<T>
{
	/// <summary>
	/// Initializes a new instance of the <see cref="ExpandingPool{T}"/> class.
	/// </summary>
	/// <param name="capacity">The pool's initial capacity.</param>
	/// <param name="allocator">A function which allocates new instances of <typeparamref name="T"/>.</param>
	/// <param name="deallocator">An action which is performed on objects which are being returned to the pool.</param>
	public this(int32 capacity, delegate T() allocator = null, delegate void(T instance) deallocator = null)
		: this(capacity, int32.MaxValue, allocator, deallocator)
	{
	}

	/// <summary>
	/// Initializes a new instance of the <see cref="ExpandingPool{T}"/> class.
	/// </summary>
	/// <param name="capacity">The pool's initial capacity.</param>
	/// <param name="watermark">The pool's watermark value, which indicates the maximum size of the pool.</param>
	/// <param name="allocator">A function which allocates new instances of <typeparamref name="T"/>.</param>
	/// <param name="deallocator">An action which is performed on objects which are being returned to the pool.</param>
	public this(int32 capacity, int32 watermark, delegate T() allocator = null, delegate void(T instance) deallocator = null)
	{
		//Contract.EnsureRange(capacity >= 0, nameof(capacity));
		//Contract.EnsureRange(watermark >= 1, nameof(watermark));
		//Contract.EnsureRange(watermark >= capacity, nameof(watermark));

		this.watermark = watermark;
		this.allocator = allocator ?? CreateDefaultAllocator();
		this.deallocator = deallocator ?? CreateDefaultDestructor();
		for (var interfaceType in typeof(T).Interfaces)
		{
			if (interfaceType.TypeId == typeof(IDisposable).TypeId)
			{
				this.disposable = true;
				break;
			}
		}

		ExpandStorage(capacity);
	}

	public ~this()
	{
		if (storage != null)
		{
			if (deallocator != null)
			{
				for (var item in storage)
				{
					deallocator(item);
				}
			}
		}
	}

	/// <inheritdoc/>
	public override T Retrieve()
	{
		if (storage.Count == count)
		{
			if (storage.Count == watermark)
			{
				watermarkAllocations++;
				return allocator();
			}
			ExpandStorage();
		}
		return storage[count++];
	}

	/// <inheritdoc/>
	public override void Release(T instance)
	{
		if (watermarkAllocations + count == 0)
			Runtime.FatalError("PoolImbalance");

		// we don't want to deallocate since item is going back to pool to be reused.
		//deallocator?.Invoke(instance);

		if (count == 0)
		{
			watermarkAllocations--;
		}
		else
		{
			storage[--count] = instance;
		}
	}

	/// <inheritdoc/>
	public override void ReleaseRef(ref T instance)
	{
		if (watermarkAllocations + count == 0)
			Runtime.FatalError("PoolImbalance");
		
		// we don't want to deallocate since item is going back to pool to be reused.
		//deallocator?.Invoke(instance);

		if (count == 0)
		{
			watermarkAllocations--;
		}
		else
		{
			storage[--count] = instance;
			instance = default(T);
		}
	}

	/// <inheritdoc/>
	public override int32 Count
	{
		get { return count; }
	}

	/// <inheritdoc/>
	public override int32 Capacity
	{
		get { return (.)storage.Count; }
	}

	/// <summary>
	/// Gets the number of objects that were allocated as a result of reaching the pool's watermark.
	/// </summary>
	public int32 WatermarkAllocations
	{
		get { return watermarkAllocations; }
	}

	/// <summary>
	/// Gets the pool's watermark value, which indicates its maximum size.
	/// </summary>
	/// <remarks>Beyond this point, the pool will simply return newly-allocated objects instead of pooled objects. 
	/// Such objects should still be released back into the pool for bookkeeping purposes.</remarks>
	public int32 Watermark
	{
		get { return watermark; }
	}

	/// <summary>
	/// Disposes of all of the objects in the pool, if <typeparamref name="T"/> implements <see cref="System.IDisposable"/>.
	/// </summary>
	/// <param name="disposing"><see langword="true"/> if the object is being disposed; false if the object is being finalized.</param>
	protected override void Dispose(bool disposing)
	{
		if (disposing && disposable)
		{
			for (var item in storage)
			{
				if (let disposable = ((Object)item) as IDisposable)
				{
					disposable.Dispose();
				}
			}
		}
	}

	/// <summary>
	/// Expands the pool's storage capacity to a factor of the pool's current storage capacity.
	/// </summary>
	private void ExpandStorage()
	{
		int32 capacity = (int32)Math.Min(watermark, ((3 * storage.Count) / 2) + 1);
		ExpandStorage(capacity);
	}

	/// <summary>
	/// Expands the pool's storage such that it has at least the specified capacity.
	/// </summary>
	/// <param name="capacity">The target capacity after expansion.</param>
	private void ExpandStorage(int32 capacity)
	{
		if (this.storage != null && this.storage.Count >= capacity)
			return;

		var old = storage;
		var oldLength = old?.Count ?? 0;

		storage = new T[capacity];
		if (oldLength > 0)
		{
			Array.Copy(old, storage, old.Count);
		}

		for (int i = oldLength; i < storage.Count; i++)
			storage[i] = allocator();

		delete old;
	}

	// The underlying storage for the object pool.
	private readonly delegate T() allocator~ { if (_ != null) delete _; };
	private readonly delegate void(T instance) deallocator~ { if (_ != null) delete _; };
	private readonly bool disposable;
	private T[] storage~ { if (_ != null) delete _; };
	private int32 count;
	private int32 watermark;
	private int32 watermarkAllocations;
}