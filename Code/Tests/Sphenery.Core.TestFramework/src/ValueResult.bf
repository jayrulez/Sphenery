using System;
namespace Sphenery.Core.TestFramework;

/// <summary>
/// Represents a unit test result containing a value.
/// </summary>
public sealed class ValueResult<T> : IDisposable where T : struct
{
    /// <summary>
    /// Initializes a new instance of the ValueResult class.
    /// </summary>
    /// <param name="value">The value being examined.</param>
    internal this(T value)
    {
        this.value = value;
    }

    /// <summary>
    /// Asserts that the value satisfies the specified condition.
    /// </summary>
    /// <param name="condition">The condition against which to evaluate the value.</param>
    /// <returns>The result object.</returns>
    public ValueResult<T> ShouldSatisfyTheCondition(delegate bool(T) condition, String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        Test.Assert(condition(value), error, filePath, line);
        return this;
    }

    /// <summary>
    /// Asserts that this value should be equal to the expected value.
    /// </summary>
    /// <param name="expected">The expected value.</param>
    /// <returns>The result object.</returns>
    public ValueResult<T> ShouldBe(T expected, String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        Test.Assert(expected == value, error, filePath, line);
        return this;
    }

    /// <summary>
    /// Gets the underlying value.
    /// </summary>
    public T Value
    {
        get { return value; }
    }

    // Property values.
    private readonly T value;

	public void Dispose()
	{
		delete this;
	}
}