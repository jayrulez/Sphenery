using System.Collections;
using System;
namespace Sphenery.Core.TestFramework;

using internal Sphenery.Core.TestFramework;

abstract class CoreTestFramework
{
	private static List<IDisposable> sDisposableResults = new .() ~ DeleteContainerAndDisposeItems!(_);

	/// <summary>
	/// Wraps the specified unit test result for evaluation.
	/// </summary>
	/// <param name="obj">The object to wrap.</param>
	/// <returns>The wrapped object.</returns>
	protected static ObjectResult<T> TheResultingObject<T>(T obj) where T : class
	{
		var result = new ObjectResult<T>(obj);
		sDisposableResults.Add(result);
	    return result;
	}

	/// <summary>
	/// Wraps the specified unit test result for evaluation.
	/// </summary>
	/// <param name="value">The value to wrap.</param>
	/// <returns>The wrapped value.</returns>
	protected static ValueResult<T> TheResultingValue<T>(T value) where T : struct
	{
	    var result = new ValueResult<T>(value);
		sDisposableResults.Add(result);
	    return result;
	}

	/// <summary>
	/// Wraps the specified unit test result for evaluation.
	/// </summary>
	/// <param name="value">The value to wrap.</param>
	/// <returns>The wrapped value.</returns>
	protected static BooleanResult TheResultingValue(bool value)
	{
	    var result = new BooleanResult(value);
		sDisposableResults.Add(result);
	    return result;
	}

	/// <summary>
	/// Wraps the specified unit test result for evaluation.
	/// </summary>
	/// <param name="value">The value to wrap.</param>
	/// <returns>The wrapped value.</returns>
	protected static SingleResult TheResultingValue(float value)
	{
	    var result = new SingleResult(value);
		sDisposableResults.Add(result);
	    return result;
	}

	/// <summary>
	/// Wraps the specified unit test result for evaluation.
	/// </summary>
	/// <param name="value">The value to wrap.</param>
	/// <returns>The wrapped value.</returns>
	protected static DoubleResult TheResultingValue(double value)
	{
	    var result = new DoubleResult(value);
		sDisposableResults.Add(result);
	    return result;
	}
}