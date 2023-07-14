using System;
namespace Sphenery.Core.TestFramework;

/// <summary>
/// Represents a unit test result containing a 32-bit floating point value.
/// </summary>
public sealed class DoubleResult : IDisposable
{
    /// <summary>
    /// Initializes a new instance of the DoubleResult class.
    /// </summary>
    /// <param name="value">The value being examined.</param>
    internal this(double value)
    {
        this.value = value;
    }

    /// <summary>
    /// Asserts that the value satisfies the specified condition.
    /// </summary>
    /// <param name="condition">The condition against which to evaluate the value.</param>
    /// <returns>The result object.</returns>
    public DoubleResult ShouldSatisfyTheCondition(delegate bool(double) condition, String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        Test.Assert(condition(value), error, filePath, line);
        return this;
    }

    /// <summary>
    /// Asserts that this value should be equal to the expected value.
    /// </summary>
    /// <param name="expected">The expected value.</param>
    /// <returns>The result object.</returns>
    public DoubleResult ShouldBe(double expected, String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        if (delta.HasValue)
        {
            //Assert.AreEqual(expected, value, delta.Value);
            Test.Assert(expected.Equals(value), error, filePath, line);
        }
        else
        {
            Test.Assert(expected.Equals(value), error, filePath, line);
        }
        return this;
    }

    /// <summary>
    /// Specifies that subsequent comparisons should be within the specified delta.
    /// </summary>
    /// <param name="delta">The delta value to set.</param>
    /// <returns>The result object.</returns>
    public DoubleResult WithinDelta(double delta)
    {
        this.delta = delta;
        return this;
    }

    /// <summary>
    /// Gets the underlying value.
    /// </summary>
    public double Value
    {
        get { return value; }
    }

    // State values.
    private double value;
    private double? delta;

	public void Dispose()
	{
		delete this;
	}
}