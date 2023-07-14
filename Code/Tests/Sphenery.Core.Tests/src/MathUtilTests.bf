using Sphenery.Core.Mathematics;
using System;
using Sphenery.Core.TestFramework;
namespace Sphenery.Core.Tests;

class MathUtilTests : CoreTestFramework
{
	[Test]
	public static void MathUtil_ClampByte()
	{
	    var result1 = MathUtil.Clamp((uint8)123, (uint8)0, (uint8)44);
	    TheResultingValue(result1).ShouldBe(44);

	    var result2 = MathUtil.Clamp((uint8)0, (uint8)22, (uint8)255);
	    TheResultingValue(result2).ShouldBe(22);
	}

	[Test]
	public static void MathUtil_ClampInt16()
	{
	    var result1 = MathUtil.Clamp((int16)123, (int16)0, (int16)44);
	    TheResultingValue(result1).ShouldBe(44);

	    var result2 = MathUtil.Clamp((int16)0, (int16)22, (int16)255);
	    TheResultingValue(result2).ShouldBe(22);

	    var result3 = MathUtil.Clamp((int16)-44, (int16)-33, (int16)255);
	    TheResultingValue(result3).ShouldBe(-33);

	    var result4 = MathUtil.Clamp((int16)123, (int16)-1000, (int16)-25);
	    TheResultingValue(result4).ShouldBe(-25);
	}

	[Test]
	public static void MathUtil_ClampInt32()
	{
	    var result1 = MathUtil.Clamp((int32)123, (int32)0, (int32)44);
	    TheResultingValue(result1).ShouldBe(44);

	    var result2 = MathUtil.Clamp((int32)0, (int32)22, (int32)255);
	    TheResultingValue(result2).ShouldBe(22);

	    var result3 = MathUtil.Clamp(int32(-44), int32(-33), (int32)255);
	    TheResultingValue(result3).ShouldBe(-33);

	    var result4 = MathUtil.Clamp(int32(123), int32(-1000), int32(-25));
	    TheResultingValue(result4).ShouldBe(-25);
	}

	[Test]
	public static void MathUtil_ClampInt64()
	{
	    var result1 = MathUtil.Clamp((int64)123, (int64)0, (int64)44);
	    TheResultingValue(result1).ShouldBe(44);

	    var result2 = MathUtil.Clamp((int64)0, (int64)22, (int64)255);
	    TheResultingValue(result2).ShouldBe(22);

	    var result3 = MathUtil.Clamp(int64(-44), int64(-33), (int64)255);
	    TheResultingValue(result3).ShouldBe(-33);

	    var result4 = MathUtil.Clamp(int64(123), int64(-1000), int64(-25));
	    TheResultingValue(result4).ShouldBe(-25);
	}

	[Test]
	public static void MathUtil_ClampUInt16()
	{
	    var result1 = MathUtil.Clamp((uint16)123, (uint16)0, (uint16)44);
	    TheResultingValue(result1).ShouldBe(44);

	    var result2 = MathUtil.Clamp((uint16)0, (uint16)22, (uint16)255);
	    TheResultingValue(result2).ShouldBe(22);
	}

	[Test]
	public static void MathUtil_ClampUInt32()
	{
	    var result1 = MathUtil.Clamp((uint32)123, (uint32)0, (uint32)44);
	    TheResultingValue(result1).ShouldBe(44);

	    var result2 = MathUtil.Clamp((uint32)0, (uint32)22, (uint32)255);
	    TheResultingValue(result2).ShouldBe(22);
	}

	[Test]
	public static void MathUtil_ClampUInt64()
	{
	    var result1 = MathUtil.Clamp((uint64)123, (uint64)0, (uint64)44);
	    TheResultingValue(result1).ShouldBe(44);

	    var result2 = MathUtil.Clamp((uint64)0, (uint64)22, (uint64)255);
	    TheResultingValue(result2).ShouldBe(22);
	}

	[Test]
	public static void MathUtil_ClampSingle()
	{
	    var result1 = MathUtil.Clamp(123f, 0f, 44f);
	    TheResultingValue(result1).ShouldBe(44f);

	    var result2 = MathUtil.Clamp(0f, 22f, 255f);
	    TheResultingValue(result2).ShouldBe(22f);

	    var result3 = MathUtil.Clamp(-44f, -33f, 255f);
	    TheResultingValue(result3).ShouldBe(-33f);

	    var result4 = MathUtil.Clamp(123f, -1000f, -25f);
	    TheResultingValue(result4).ShouldBe(-25f);
	}

	[Test]
	public static void MathUtil_ClampDouble()
	{
	    var result1 = MathUtil.Clamp(123.0, 0.0, 44.0);
	    TheResultingValue(result1).ShouldBe(44.0);

	    var result2 = MathUtil.Clamp(0.0, 22.0, 255.0);
	    TheResultingValue(result2).ShouldBe(22.0);

	    var result3 = MathUtil.Clamp(-44.0, -33.0, 255.0);
	    TheResultingValue(result3).ShouldBe(-33.0);

	    var result4 = MathUtil.Clamp(123.0, -1000.0, -25.0);
	    TheResultingValue(result4).ShouldBe(-25.0);
	}

	[Test]
	public static void MathUtil_LerpByte()
	{
	    var result1 = MathUtil.Lerp((uint8)0, (uint8)100, 0.25f);
	    TheResultingValue(result1).ShouldBe(25);

	    var result2 = MathUtil.Lerp((uint8)0, (uint8)100, 0.75f);
	    TheResultingValue(result2).ShouldBe(75);
	}

	[Test]
	public static void MathUtil_LerpInt16()
	{
	    var result1 = MathUtil.Lerp((int16)0, (int16)100, 0.25f);
	    TheResultingValue(result1).ShouldBe(25);

	    var result2 = MathUtil.Lerp((int16)0, (int16)100, 0.75f);
	    TheResultingValue(result2).ShouldBe(75);

	    var result3 = MathUtil.Lerp((int16)-50, (int16)50, 0.25f);
	    TheResultingValue(result3).ShouldBe(-25);

	    var result4 = MathUtil.Lerp((int16)-50, (int16)50, 0.75f);
	    TheResultingValue(result4).ShouldBe(25);
	}

	[Test]
	public static void MathUtil_LerpInt32()
	{
	    var result1 = MathUtil.Lerp((int32)0, (int32)100, 0.25f);
	    TheResultingValue(result1).ShouldBe(25);

	    var result2 = MathUtil.Lerp((int32)0, (int32)100, 0.75f);
	    TheResultingValue(result2).ShouldBe(75);

	    var result3 = MathUtil.Lerp(int32(-50), (int32)50, 0.25f);
	    TheResultingValue(result3).ShouldBe(-25);

	    var result4 = MathUtil.Lerp(int32(-50), (int32)50, 0.75f);
	    TheResultingValue(result4).ShouldBe(25);
	}

	[Test]
	public static void MathUtil_LerpInt64()
	{
	    var result1 = MathUtil.Lerp((int64)0, (int64)100, 0.25f);
	    TheResultingValue(result1).ShouldBe(25);

	    var result2 = MathUtil.Lerp((int64)0, (int64)100, 0.75f);
	    TheResultingValue(result2).ShouldBe(75);

	    var result3 = MathUtil.Lerp(int64(-50), (int64)50, 0.25f);
	    TheResultingValue(result3).ShouldBe(-25);

	    var result4 = MathUtil.Lerp(int64(-50), (int64)50, 0.75f);
	    TheResultingValue(result4).ShouldBe(25);
	}

	[Test]
	public static void MathUtil_LerpUInt16()
	{
	    var result1 = MathUtil.Lerp((uint16)0, (uint16)100, 0.25f);
	    TheResultingValue(result1).ShouldBe(25);

	    var result2 = MathUtil.Lerp((uint16)0, (uint16)100, 0.75f);
	    TheResultingValue(result2).ShouldBe(75);
	}

	[Test]
	public static void MathUtil_LerpUInt32()
	{
	    var result1 = MathUtil.Lerp((uint32)0, (uint32)100, 0.25f);
	    TheResultingValue(result1).ShouldBe(25);

	    var result2 = MathUtil.Lerp((uint32)0, (uint32)100, 0.75f);
	    TheResultingValue(result2).ShouldBe(75);
	}

	[Test]
	public static void MathUtil_LerpUInt64()
	{
	    var result1 = MathUtil.Lerp((uint64)0, (uint64)100, 0.25f);
	    TheResultingValue(result1).ShouldBe(25);

	    var result2 = MathUtil.Lerp((uint64)0, (uint64)100, 0.75f);
	    TheResultingValue(result2).ShouldBe(75);
	}

	[Test]
	public static void MathUtil_LerpSingle()
	{
	    var result1 = MathUtil.Lerp(0f, 100f, 0.25f);
	    TheResultingValue(result1).ShouldBe(25f);

	    var result2 = MathUtil.Lerp(0f, 100f, 0.75f);
	    TheResultingValue(result2).ShouldBe(75f);

	    var result3 = MathUtil.Lerp(-50f, 50f, 0.25f);
	    TheResultingValue(result3).ShouldBe(-25f);

	    var result4 = MathUtil.Lerp(-50f, 50f, 0.75f);
	    TheResultingValue(result4).ShouldBe(25f);
	}

	[Test]
	public static void MathUtil_LerpDouble()
	{
	    var result1 = MathUtil.Lerp(0.0, 100.0, 0.25f);
	    TheResultingValue(result1).ShouldBe(25f);

	    var result2 = MathUtil.Lerp(0.0, 100.0, 0.75f);
	    TheResultingValue(result2).ShouldBe(75f);

	    var result3 = MathUtil.Lerp(-50.0, 50.0, 0.25f);
	    TheResultingValue(result3).ShouldBe(-25f);

	    var result4 = MathUtil.Lerp(-50.0, 50.0, 0.75f);
	    TheResultingValue(result4).ShouldBe(25f); 
	}
}