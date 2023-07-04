using System;
namespace Sedulous.RHI.Validation;

class TextureVal : DeviceObjectVal<ITexture>, ITexture
{
	private MemoryVal m_Memory = null;
	private bool m_IsBoundToMemory = false;
	private TextureDesc m_TextureDesc = .();


	public this(DeviceVal device, ITexture texture, TextureDesc textureDesc)
		: base(device, texture)
	{
		m_TextureDesc = textureDesc;
	}

	public ~this()
	{
		if (m_Memory != null)
			m_Memory.UnbindTexture(this);
	}

	[Inline] public readonly ref TextureDesc GetDesc()
		{ return ref m_TextureDesc; }

	[Inline] public uint64 GetNativeObject(uint32 physicalDeviceIndex)
		{ return m_ImplObject.GetNativeObject(physicalDeviceIndex); }

	[Inline] public bool IsBoundToMemory()
		{ return m_IsBoundToMemory; }

	[Inline] public void SetBoundToMemory()
		{ m_IsBoundToMemory = true; }

	[Inline] public void SetBoundToMemory(MemoryVal memory)
	{
		m_Memory = memory;
		m_IsBoundToMemory = true;
	}

	//================================================================================================================
	// NRI
	//================================================================================================================
	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}

	public void GetMemoryInfo(MemoryLocation memoryLocation, ref MemoryDesc memoryDesc)
	{
		m_ImplObject.GetMemoryInfo(memoryLocation, ref memoryDesc);
		m_Device.RegisterMemoryType(memoryDesc.type, memoryLocation);
	}
}