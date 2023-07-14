using System;

namespace Sphenery.Core.Mathematics;

extension Color
{
    /// <inheritdoc/>
    public int GetHashCode()
    {
        unchecked
        {
            var hash = 17;
            hash = hash * 23 + packedValue.GetHashCode();
            return hash;
        }
    }
    
    /// <summary>
    /// Compares two objects to determine whether they are equal.
    /// </summary>
    /// <param name="v1">The first value to compare.</param>
    /// <param name="v2">The second value to compare.</param>
    /// <returns><see langword="true"/> if the two values are equal; otherwise, <see langword="false"/>.</returns>
    public static bool operator ==(Color v1, Color v2)
    {
        return v1.Equals(v2);
    }
    
    /// <summary>
    /// Compares two objects to determine whether they are unequal.
    /// </summary>
    /// <param name="v1">The first value to compare.</param>
    /// <param name="v2">The second value to compare.</param>
    /// <returns><see langword="true"/> if the two values are unequal; otherwise, <see langword="false"/>.</returns>
    public static bool operator !=(Color v1, Color v2)
    {
        return !v1.Equals(v2);
    }
    
    /// <inheritdoc/>
    public bool Equals(Object other)
    {
		if(let x = other as Self?)
			return Equals(x);
		return false;
    }
    
    /// <inheritdoc/>
    public bool Equals(Color other)
    {
        return
            this.packedValue == other.packedValue;
    }
}
