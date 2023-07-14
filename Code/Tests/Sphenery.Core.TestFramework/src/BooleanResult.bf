using System;
namespace Sphenery.Core.TestFramework;

/// <summary>
/// Represents a unit test result containing a boolean value.
/// </summary>
public sealed class BooleanResult : IDisposable
{
    /// <summary>
    /// Initializes a new instance of the BooleanResult class.
    /// </summary>
    /// <param name="value">The value being examined.</param>
    internal this(bool value)
    {
        this.value = value;
    }

    /// <summary>
    /// Asserts that this value should be equal to the expected value.
    /// </summary>
    /// <param name="expected">The expected value.</param>
    /// <returns>The result object.</returns>
    public BooleanResult ShouldBe(bool expected, String error = Compiler.CallerExpression[0], String filePath = Compiler.CallerFilePath, int line = Compiler.CallerLineNum)
    {
        if (expected)
        {
            Test.Assert(value, error, filePath, line);
        }
        else
        {
            Test.Assert(!value, error, filePath, line);
        }
        return this;
    }
    
    /// <summary>
    /// Gets the underlying value.
    /// </summary>
    public bool Value
    {
        get { return value; }
    }

    // Property values.
    private readonly bool value;

	public void Dispose()
	{
		delete this;
	}
}