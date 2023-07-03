namespace Sedulous.Core.Mathematics;

struct Rectangle
{
	public int32 X;
	public int32 Y;
	public int32 Width;
	public int32 Height;

	public int32 Left => X;
	public int32 Top => Y;

	public Point2 Location
	{
	    get { return Point2(X, Y); }
	    set mut
	    {
	        X = value.X;
	        Y = value.Y;
	    }
	}

	public Size2 Size
	{
	    get { return Size2(Width, Height); }
	    set mut
	    {
	        Width = value.Width;
	        Height = value.Height;
	    }
	}

	public Point2 Center
	{
	    get { return Point2(X + (Width / 2), Y + (Height / 2)); }
	}

	public this(int32 x, int32 y, int32 width, int32 height)
	{
		X = x;
		Y = y;
		Width = width;
		Height = height;
	}
}