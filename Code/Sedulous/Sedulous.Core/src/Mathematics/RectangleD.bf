namespace Sedulous.Core.Mathematics;

struct RectangleD
{
	public double X;
	public double Y;
	public double Width;
	public double Height;

	public double Left => X;
	public double Top => Y;

	public this(double x, double y, double width, double height)
	{
		X = x;
		Y = y;
		Width = width;
		Height = height;
	}
}