using System.Collections;
using System;
namespace Sedulous.Core.Collections;

/// <summary>
/// Represents a collection of expanding pools for different types.
/// </summary>
public sealed class ExpandingPoolRegistry
{
    /// <summary>
    /// Creates a pool for the specified type with the specified initial capacity and allocator.
    /// </summary>
    /// <typeparam name="T">The type of object for which to create an expanding pool.</typeparam>
    /// <param name="capacity">The pool's initial capacity.</param>
    /// <param name="allocator">The pool's instance allocator, if it must be created.</param>
    public void Create<T>(int32 capacity, delegate T() allocator = null)
    {
        Create<T>(capacity, int32.MaxValue, allocator);
    }

    /// <summary>
    /// Creates a pool for the specified type with the specified initial capacity and allocator.
    /// </summary>
    /// <typeparam name="T">The type of object for which to create an expanding pool.</typeparam>
    /// <param name="capacity">The pool's initial capacity.</param>
    /// <param name="watermark">The pool's watermark value, if it must be created.</param>
    /// <param name="allocator">The pool's instance allocator, if it must be created.</param>
    public void Create<T>(int32 capacity, int32 watermark, delegate T() allocator = null)
    {
        //Contract.EnsureRange(capacity >= 0, nameof(capacity));
        //Contract.EnsureRange(watermark >= 1, nameof(watermark));
        //Contract.EnsureRange(watermark >= capacity, nameof(watermark));

        if (pools.ContainsKey(typeof(T)))
            Runtime.FatalError(scope $"Pool Registry Already Contains Type '{typeof(T).GetFullName(.. scope .())}'.");

        pools[typeof(T)] = new ExpandingPool<T>(capacity, watermark, allocator);
    }

    /// <summary>
    /// Destroys the pool for the specified type.
    /// </summary>
    /// <typeparam name="T">The type of object for which to destroy an existing pool.</typeparam>
    public void Destroy<T>()
    {
        var pool = Get<T>();
        if (pool != null)
        {
            pool.Dispose();
            pools.Remove(typeof(T));
			delete pool;
        }
    }

    /// <summary>
    /// Destroys all of the registered pools.
    /// </summary>
    public void DestroyAll()
    {
        for (var pool in pools)
        {
            pool.value.Dispose();
			delete pool.value;
        }
        pools.Clear();
    }

    /// <summary>
    /// Gets the pool for the specified type.
    /// </summary>
    /// <param name="type">The type of object for which to retrieve a pool.</param>
    /// <returns>The pool for the specified type, or <see langword="null"/> if no such pool exists.</returns>
    public IPool Get(Type type)
    {
        //Contract.Require(type, nameof(type));

        IPool pool;
        pools.TryGetValue(type, out pool);
        return pool;
    }

    /// <summary>
    /// Gets the pool for the specified type.
    /// </summary>
    /// <typeparam name="T">The type of object for which to retrieve a pool.</typeparam>
    /// <returns>The pool for the specified type, or <see langword="null"/> if no such pool exists.</returns>
    public IPool<T> Get<T>()
    {
        IPool pool;
        pools.TryGetValue(typeof(T), out pool);
        return (IPool<T>)pool;
    }

    /// <summary>
    /// Gets the pool for the specified type. If the pool does not exist, it will be created
    /// with the specified initial capacity and allocator.
    /// </summary>
    /// <typeparam name="T">The type of object for which to retrieve a pool.</typeparam>
    /// <param name="capacity">The initial capacity of the pool, if it must be created.</param>
    /// <param name="allocator">The pool's instance allocator, if it must be created.</param>
    /// <returns>The pool for the specified type.</returns>
    public IPool<T> Get<T>(int32 capacity, delegate T() allocator = null)
    {
        return Get<T>(capacity, int32.MaxValue, allocator);
    }

    /// <summary>
    /// Gets the pool for the specified type. If the pool does not exist, it will be created
    /// with the specified initial capacity and allocator.
    /// </summary>
    /// <typeparam name="T">The type of object for which to retrieve a pool.</typeparam>
    /// <param name="capacity">The initial capacity of the pool, if it must be created.</param>
    /// <param name="watermark">The pool's watermark value, if it must be created.</param>
    /// <param name="allocator">The pool's instance allocator, if it must be created.</param>
    /// <returns>The pool for the specified type.</returns>
    public IPool<T> Get<T>(int32 capacity, int32 watermark, delegate T() allocator = null)
    {
        //Contract.EnsureRange(capacity >= 0, nameof(capacity));
        //Contract.EnsureRange(watermark >= 1, nameof(watermark));
        //Contract.EnsureRange(watermark >= capacity, nameof(watermark));

        IPool pool;
        if (!pools.TryGetValue(typeof(T), out pool))
        {
            pool = new ExpandingPool<T>(capacity, watermark, allocator);
            pools[typeof(T)] = pool;
        }
        return (IPool<T>)pool;
    }

    // The pools for each type.
    private readonly Dictionary<Type, IPool> pools = new .() ~ DeleteDictionaryAndValues!(_);
}