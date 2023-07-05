using Sphenery.Core.Mathematics;
namespace Sphenery.Framework.Platform.Input.Touch;

using internal Sphenery.Framework.Platform.Input.Touch;

/// <summary>
/// Represents the parameters of an active touch input.
/// </summary>
public struct TouchInfo
{
    /// <summary>
    /// Initializes a new instance of the <see cref="TouchInfo"/> structure.
    /// </summary>
    /// <param name="timestamp">The timestamp, in ticks, at which the touch began.</param>
    /// <param name="touchID">The unique identifier of the touch event.</param>
    /// <param name="touchIndex">The index of the touch within the current gesture.</param>
    /// <param name="fingerID">The unique identifier of the finger which caused the touch event.</param>
    /// <param name="originX">The normalized x-coordinate at which the touch originated.</param>
    /// <param name="originY">The normalized x-coordinate at which the touch originated.</param>
    /// <param name="currentX">The normalized x-coordinate of the touch.</param>
    /// <param name="currentY">The normalized y-coordinate of the touch.</param>
    /// <param name="pressure">The normalized pressure of the touch.</param>
    /// <param name="isLongPress">A value indicating whether the touch is a long press.</param>
    public this(int64 timestamp, int64 touchID, int32 touchIndex, int64 fingerID,
        float originX, float originY, float currentX, float currentY, float pressure, bool isLongPress)
    {
        this.timestamp = timestamp;
        this.touchID = touchID;
        this.touchIndex = touchIndex;
        this.fingerID = fingerID;
        this.originX = originX;
        this.originY = originY;
        this.currentX = currentX;
        this.currentY = currentY;
        this.pressure = pressure;
        this.distance = 0;
        this.isLongPress = isLongPress;
    }

    /// <summary>
    /// Gets the timestamp, in ticks, at which the touch began.
    /// </summary>
    public int64 Timestamp
    {
        get { return timestamp; }
        internal set mut { timestamp = value; }
    }

    /// <summary>
    /// Gets the unique identifier of the touch event.
    /// </summary>
    public int64 TouchID
    {
        get { return touchID; }
        internal set mut { touchID = value; }
    }

    /// <summary>
    /// Gets the index of the touch within the current gesture.
    /// </summary>
    public int32 TouchIndex
    {
        get { return touchIndex; }
        internal set mut { touchIndex = value; }
    }

    /// <summary>
    /// Gets the internal identifier of the finger which caused the touch event.
    /// </summary>
    public int64 FingerID
    {
        get { return fingerID; }
        internal set mut { fingerID = value; }
    }

    /// <summary>
    /// Gets the normalized coordinates of the position at which the touch originated.
    /// </summary>
    public Point2F OriginPosition => Point2F(originX, originY);

    /// <summary>
    /// Gets the normalized x-coordinate at which the touch originated.
    /// </summary>
    public float OriginX
    {
        get { return originX; }
        internal set mut { originX = value; }
    }

    /// <summary>
    /// Gets the normalized y-coordinate at which the touch originated.
    /// </summary>
    public float OriginY
    {
        get { return originY; }
        internal set mut { originY = value; }
    }

    /// <summary>
    /// Gets the normalized coordinates of the touch's current position.
    /// </summary>
    public Point2F CurrentPosition => Point2F(currentX, currentY);

    /// <summary>
    /// Gets the normalized x-coordinate of the touch.
    /// </summary>
    public float CurrentX
    {
        get { return currentX; }
        internal set mut { currentX = value; }
    }

    /// <summary>
    /// Gets the normalized y-coordinate of the touch.
    /// </summary>
    public float CurrentY
    {
        get { return currentY; }
        internal set mut { currentY = value; }
    }

    /// <summary>
    /// Gets the normalized pressure of the touch.
    /// </summary>
    public float Pressure
    {
        get { return pressure; }
        internal set mut { pressure = value; }
    }

    /// <summary>
    /// Gets the total distance that the touch has moved.
    /// </summary>
    public float Distance
    {
        get { return distance; }
        internal set mut { distance = value; }
    }

    /// <summary>
    /// Gets a value indicating whether the touch is a long press.
    /// </summary>
    public bool IsLongPress
    {
        get { return isLongPress; }
        internal set mut { isLongPress = value; }
    }

    // Property values.
    private int64 timestamp;
    private int64 touchID;
    private int32 touchIndex;
    private int64 fingerID;
    private float originX;
    private float originY;
    private float currentX;
    private float currentY;
    private float pressure;
    private float distance;
    private bool isLongPress;
}