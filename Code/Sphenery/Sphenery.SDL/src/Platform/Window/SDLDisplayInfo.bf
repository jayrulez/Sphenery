using Sphenery.Framework.Platform.Window;
using System.Collections;
using Sphenery.Framework;
using SDL2;
namespace Sphenery.SDL.Platform.Window;

class SDLDisplayInfo : IDisplayInfo
{
	// The list of display devices.  SDL2 never updates its device info, even if
	// devices are added or removed, so we only need to create this once.
	private readonly List<IDisplay> displays = new .() ~ DeleteContainerAndItems!(_);;
	
	/// <summary>
	/// Initializes a new instance of the OpenGLSpheneryDisplayInfo class.
	/// </summary>
	public this()
	{
	    //Contract.Require(context, nameof(context));
		int displayCount = SDL.GetNumVideoDisplays();
		for(int i = 0; i < displayCount; i++){
			this.displays.Add(new SDLDisplay(i));
		}
	}

	public ~this(){

	}

	/// <summary>
	/// Updates the state of the application's displays.
	/// </summary>
	/// <param name="time">Time elapsed since the last call to <see cref="FrameworkContext.Update(FrameworkTime)"/>.</param>
	public void Update(ApplicationTime time)
	{
	    for (var display in displays)
	        ((SDLDisplay)display).Update(time);
	}

	/// <inheritdoc/>
	public IDisplay this[int ix]
	{
	    get { return displays[ix]; }
	}

	/// <inheritdoc/>
	public IDisplay PrimaryDisplay
	{
	    get { return displays.Count == 0 ? null : displays[0]; }
	}

	/// <inheritdoc/>
	public int Count
	{
	    get { return displays.Count; }
	}

	/// <inheritdoc/>
	public List<IDisplay>.Enumerator GetEnumerator()
	{
	    return displays.GetEnumerator();
	}
}