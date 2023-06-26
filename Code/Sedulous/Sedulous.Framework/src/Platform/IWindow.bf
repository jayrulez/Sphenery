using System;
namespace Sedulous.Framework.Platform;

interface IWindow
{
	public int32 Id { get; }
	public StringView Title { get; }
	public int32 Width { get; }
	public int32 Height { get; }
	public bool Visible {get;}
}