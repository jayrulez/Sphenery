using System;
namespace Sedulous.Core.Collections;

using internal Sedulous.Core.Collections;

/// <summary>
/// Represents the base class for pools.
/// </summary>
/// <typeparam name="T">The type of item contained by the pool.</typeparam>
public abstract class Pool<T> : IPool<T>, IPool, IDisposable
{
    /// <inheritdoc/>
    public void Dispose()
    {
        Dispose(true);
    }

#region IPool
	
	/// <inheritdoc/>
	Object IPool.Retrieve()
	{
	    return Retrieve();
	}

	/// <inheritdoc/>
	PooledObjectScope<Object> IPool.RetrieveScoped()
	{
	    return PooledObjectScope<Object>(this, Retrieve());
	}

	/// <inheritdoc/>
	void IPool.Release(Object instance)
	{
	    Release((T)instance);
	}

	/// <inheritdoc/>
	void IPool.ReleaseRef(ref Object instance)
	{
	    Release((T)instance);
	    instance = null;
	}
#endregion

#region IPool<T>
	/// <inheritdoc/>
	public abstract T Retrieve();

	public T IPool<T>.Retrieve()
	{
		return Retrieve();
	}

	public virtual PooledObjectScope<T> RetrieveScoped()
	{
	    return PooledObjectScope<T>(this, Retrieve());
	}

	public PooledObjectScope<T> IPool<T>.RetrieveScoped()
	{
		return RetrieveScoped();
	}

	/// <inheritdoc/>
	public abstract void Release(T instance);

	/// <inheritdoc/>
	public abstract void ReleaseRef(ref T instance);
#endregion

    /// <inheritdoc/>
    public abstract int32 Count { get; }

    /// <inheritdoc/>
    public abstract int32 Capacity { get; }

    /// <summary>
    /// Releases resources associated with the object.
    /// </summary>
    /// <param name="disposing"><see langword="true"/> if the object is being disposed; <see langword="false"/> if the object is being finalized.</param>
    protected virtual void Dispose(bool disposing)
    {

    }

	/// <summary>
	/// Creates a default allocator for the pooled type.
	/// </summary>
	/// <returns>The allocator that was created.</returns>
	protected static delegate T() CreateDefaultAllocator()
	{
	    return new () =>
		{
			var result = typeof(T).CreateObject();
			if (result case .Ok)
			{
				return (T)result.Get();
			}
			return default;
		};
	}
}