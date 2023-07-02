using System.Collections;
using System;
namespace Sedulous.Framework.Platform;

class NativePointerRegistry
{
	private readonly Dictionary<String, void*> mPointersByName = new .() ~ DeleteDictionaryAndKeys!(_);

	public void Set(StringView name, void* pointer)
	{
		var tmpName = scope String(name);
		if (!mPointersByName.ContainsKey(tmpName))
		{
			mPointersByName.Add(new .(name), pointer);
		} else
		{
			mPointersByName[tmpName] = pointer;
		}
	}

	public void* Get(StringView name)
	{
		var tmpName = scope String(name);
		if (mPointersByName.ContainsKey(tmpName))
		{
			return mPointersByName[tmpName];
		}

		return null;
	}
}