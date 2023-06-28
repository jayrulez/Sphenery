using System;
namespace BeefBugs02;

using internal BeefBugs02;

public struct PooledObjectScope<T> : IDisposable
{
	/// Initializes a new instance of the <see cref="PooledObjectScope{T}"/> structure.
	/// @param pool The pool from which to retrieve an object.
	/// @param instance The object instance being managed by the scope.
	internal this(IPool pool, T instance)
	{
		this.pool = pool;
		this.instance = instance;
	}

	/// Releases the pooled object represented by this scope.
	public void Dispose()
	{
		pool.Release(instance);
	}

	/// Gets the pooled object represented by this scope.
	public T Object
	{
		get { return instance; }
	}

	// The pooled object represented by this scope.
	private readonly IPool pool;
	private readonly T instance;
}

public interface IPool : IDisposable
{
	/// Retrieves an object from the pool.
	/// @returns The object that was retrieved from the pool.
	Object Retrieve();

	/// Retrieves a scoped object from the pool.
	/// @returns A <see cref="PooledObjectScope{T}"/> that represents the lifetime of 
	/// the object that was retrieved from the pool.
	PooledObjectScope<Object> RetrieveScoped();

	/// Releases an object back into the pool.
	/// @returns The object to release.
	void Release(Object instance);

	/// Releases an object back into the pool.
	/// @returns The object to release.
	void ReleaseRef(ref Object instance);

	/// Gets the number of objects in the pool that are currently in use.
	int32 Count { get; }

	/// Gets the total number of objects in the pool.
	int32 Capacity { get; }
}

public interface IPool<T> : IDisposable
{
	/// Retrieves an object from the pool.
	/// @returns The object that was retrieved from the pool.
	T Retrieve();

	/// Retrieves a scoped object from the pool.
	/// @returns A <see cref="PooledObjectScope{T}"/> that represents the lifetime of 
	/// the object that was retrieved from the pool.
	PooledObjectScope<T> RetrieveScoped();

	/// Releases an object back into the pool.
	/// @param instance The object to release.
	void Release(T instance);

	/// Releases an object back into the pool.
	/// @param instance The object to release.
	void ReleaseRef(ref T instance);

	/// Gets the number of objects in the pool that are currently in use.
	int32 Count { get; }

	/// Gets the total number of objects in the pool.
	int32 Capacity { get; }
}

public abstract class Pool<T> : IPool<T>, IPool, IDisposable
{
	/// <inheritdoc/>
	public void Dispose()
	{
		Dispose(true);
	}

#region IPool

	Object IPool.Retrieve()
	{
		return Retrieve();
	}

	PooledObjectScope<Object> IPool.RetrieveScoped()
	{
		return PooledObjectScope<Object>(this, Retrieve());
	}

	void IPool.Release(Object instance)
	{
		Release((T)instance);
	}

	void IPool.ReleaseRef(ref Object instance)
	{
		Release((T)instance);
		instance = null;
	}
#endregion

#region IPool<T>
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

	public abstract void Release(T instance);

	public abstract void ReleaseRef(ref T instance);
#endregion

	public abstract int32 Count { get; }

	public abstract int32 Capacity { get; }

	/// Releases resources associated with the object.
	/// @param disposing true if the object is being disposed; false if the object is being finalized.
	protected virtual void Dispose(bool disposing)
	{
	}
}

class MyDisposable : IDisposable
{
	public void Dispose()
	{
	}
}

class Program
{
	public static void Main()
	{
		MyDisposable md = scope .();

		bool isDisposable = false;
		for (var interfaceType in typeof(MyDisposable).Interfaces)
		{
			if (interfaceType.TypeId == typeof(IDisposable).TypeId)
			{
				isDisposable = true;
			}
		}

		if (let disposable = ((Object)md) as IDisposable)
		{
			disposable.Dispose();
		}

		System.Diagnostics.Debug.WriteLine("IsDisposable: {0}", isDisposable);
	}
}