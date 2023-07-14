using System;

namespace Sphenery.Core.Mathematics;

/// <summary>
/// Contains useful mathematical functions.
/// </summary>
public static class MathUtil
{
    /// <summary>
    /// Gets a value indicating whether the specified <see cref="float"/> value is zero to within a reasonable approximation.
    /// </summary>
    /// <param name="value">The value to evaluate.</param>
    /// <returns><see langword="true"/> if the specified value is zero or approximately zero; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyZero(float value)
    {
        return Math.Abs(value) < 1E-7;
    }

    /// <summary>
    /// Gets a value indicating whether the specified <see cref="float"/> value is non-zero to within a reasonable approximation.
    /// </summary>
    /// <param name="value">The value to evaluate.</param>
    /// <returns><see langword="true"/> if the specified value is non-zero; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyNonZero(float value)
    {
        return Math.Abs(value) >= 1E-7;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is greater than <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is greater than <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyGreaterThan(float value1, float value2)
    {
        if (value1 == value2)
            return true;

        return Math.Abs(value1 - value2) >= 1E-7 && value1 > value2;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is greater than or equal to <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is greater than or equal to <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyGreaterThanOrEqual(float value1, float value2)
    {
        if (value1 == value2)
            return true;

        return Math.Abs(value1 - value2) < 1E-7 || value1 > value2;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is less than <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is less than <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyLessThan(float value1, float value2)
    {
        if (value1 == value2)
            return false;

        return Math.Abs(value1 - value2) >= 1E-7 && value1 < value2;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is less than or equal to <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is less than or equal to <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyLessThanOrEqualTo(float value1, float value2)
    {
        if (value1 == value2)
            return true;

        return Math.Abs(value1 - value2) < 1E-7 || value1 < value2;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is equal to <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is equal to <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool AreApproximatelyEqual(float value1, float value2)
    {
        if (value1 == value2)
            return true;

        return Math.Abs(value1 - value2) < 1E-7;
    }

    /// <summary>
    /// Gets a value indicating whether the specified <see cref="double"/> value is zero to within a reasonable approximation.
    /// </summary>
    /// <param name="value">The value to evaluate.</param>
    /// <returns><see langword="true"/> if the specified value is zero or approximately zero; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyZero(double value)
    {
        return Math.Abs(value) < 1E-15;
    }

    /// <summary>
    /// Gets a value indicating whether the specified <see cref="double"/> value is non-zero to within a reasonable approximation.
    /// </summary>
    /// <param name="value">The value to evaluate.</param>
    /// <returns><see langword="true"/> if the specified value is non-zero; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyNonZero(double value)
    {
        return Math.Abs(value) >= 1E-15;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is greater than <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is greater than <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyGreaterThan(double value1, double value2)
    {
        if (value1 == value2)
            return false;

        return Math.Abs(value1 - value2) >= 1E-15 && value1 > value2;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is greater than or equal to <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is greater than or equal to <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyGreaterThanOrEqual(double value1, double value2)
    {
        if (value1 == value2)
            return true;

        return Math.Abs(value1 - value2) < 1E-15 || value1 > value2;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is less than <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is less than <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyLessThan(double value1, double value2)
    {
        if (value1 == value2)
            return true;

        return Math.Abs(value1 - value2) >= 1E-15 && value1 < value2;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is less than or equal to <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is less than or equal to <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool IsApproximatelyLessThanOrEqualTo(double value1, double value2)
    {
        if (value1 == value2)
            return true;

        return Math.Abs(value1 - value2) < 1E-15 || value1 < value2;
    }

    /// <summary>
    /// Gets a value indicating whether <paramref name="value1"/> is equal to <paramref name="value2"/> to within a reasonable approximation.
    /// </summary>
    /// <param name="value1">The first value to evaluate.</param>
    /// <param name="value2">The second value to evaluate.</param>
    /// <returns><see langword="true"/> if <paramref name="value1"/> is equal to <paramref name="value2"/>; otherwise, <see langword="false"/>.</returns>
    public static bool AreApproximatelyEqual(double value1, double value2)
    {
        if (value1 == value2)
            return true;
        
        return Math.Abs(value1 - value2) < 1E-15;
    }        

    /// <summary>
    /// Finds the next power of two that is higher than the specified value.
    /// </summary>
    /// <param name="k">The value to evaluate.</param>
    /// <returns>The next power of two that is higher than the specified value.</returns>
    public static int32 FindNextPowerOfTwo(int32 k)
    {
		var k;
        k--;
        for (int i = 1; i < sizeof(int) * 8; i <<= 1)
        {
            k = k | k >> i;
        }
        return k + 1;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    public static uint8 Clamp(uint8 value, uint8 min, uint8 max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    public static int16 Clamp(int16 value, int16 min, int16 max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    public static int32 Clamp(int32 value, int32 min, int32 max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    public static int64 Clamp(int64 value, int64 min, int64 max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    
    public static uint16 Clamp(uint16 value, uint16 min, uint16 max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    
    public static uint32 Clamp(uint32 value, uint32 min, uint32 max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    
    public static uint64 Clamp(uint64 value, uint64 min, uint64 max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    public static float Clamp(float value, float min, float max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Clamps a value to the specified range.
    /// </summary>
    /// <param name="value">The value to clamp.</param>
    /// <param name="min">The minimum possible value.</param>
    /// <param name="max">The maximum possible value.</param>
    /// <returns>The clamped value.</returns>
    public static double Clamp(double value, double min, double max)
    {
        return (value > max) ? max : (value < min) ? min : value;
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static uint8 Lerp(uint8 value1, uint8 value2, float amount)
    {
        return (uint8)(value1 + ((value2 - value1) * amount));
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static int16 Lerp(int16 value1, int16 value2, float amount)
    {
        return (int16)(value1 + ((value2 - value1) * amount));
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static int32 Lerp(int32 value1, int32 value2, float amount)
    {
        return (int32)(value1 + ((value2 - value1) * amount));
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static int64 Lerp(int64 value1, int64 value2, float amount)
    {
        return (int64)(value1 + ((value2 - value1) * amount));
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static uint16 Lerp(uint16 value1, uint16 value2, float amount)
    {
        return (uint16)(value1 + ((value2 - value1) * amount));
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static uint32 Lerp(uint32 value1, uint32 value2, float amount)
    {
        return (uint32)(value1 + ((value2 - value1) * amount));
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static uint64 Lerp(uint64 value1, uint64 value2, float amount)
    {
        return (uint64)(value1 + ((value2 - value1) * amount));
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static float Lerp(float value1, float value2, float amount)
    {
        return value1 + ((value2 - value1) * amount);
    }

    /// <summary>
    /// Linearly interpolates between two values.
    /// </summary>
    /// <param name="value1">Source value.</param>
    /// <param name="value2">Source value.</param>
    /// <param name="amount">Value between 0 and 1 indicating the weight of value2.</param>
    /// <returns>Interpolated value.</returns>
    public static double Lerp(double value1, double value2, float amount)
    {
        return value1 + ((value2 - value1) * amount);
    }
}
