using System;
namespace Sphenery.Core.TestFramework;

/// <summary>
/// Represents a unit test result containing an object reference.
/// </summary>
public sealed class ObjectResult<T> : IDisposable where T : class
{
    /// <summary>
    /// Initializes a new instance of the ObjectResult class.
    /// </summary>
    /// <param name="obj">The object being examined.</param>
    internal this(T obj)
    {
        this.obj = obj;
    }

    /// <summary>
    /// Asserts that the object satisfies the specified condition.
    /// </summary>
    /// <param name="condition">The condition against which to evaluate the object.</param>
    /// <returns>The result object.</returns>
    public ObjectResult<T> ShouldSatisfyTheCondition(delegate bool(T) condition, String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        Test.Assert(condition(obj), error, filePath, line);
        return this;
    }

    /// <summary>
    /// Asserts that this object should be equal to the expected object.
    /// </summary>
    /// <param name="expected">The expected object.</param>
    /// <returns>The result object.</returns>
    public ObjectResult<T> ShouldBe(T expected, String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        Test.Assert(obj == expected, error, filePath, line);
        return this;
    }

    /// <summary>
    /// Asserts that this object should be null.
    /// </summary>
    /// <returns>The result object.</returns>
    public ObjectResult<T> ShouldBeNull(String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        Test.Assert(obj == null, error, filePath, line);
        return this;
    }

    /// <summary>
    /// Asserts that this object should not be null.
    /// </summary>
    /// <returns>The result object.</returns>
    public ObjectResult<T> ShouldNotBeNull(String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        Test.Assert(obj != null, error, filePath, line);
        return this;
    }

    /// <summary>
    /// Gets the underlying object.
    /// </summary>
    public T Object
    {
        get { return obj; }
    }

    // Property values.
    private readonly T obj;

	public void Dispose()
	{
		delete this;
	}
}