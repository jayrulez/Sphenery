using System;
namespace Sphenery.RHI.Validation;

class AccelerationStructureVal : DeviceObjectVal<IAccelerationStructure>, IAccelerationStructure
{
	private MemoryVal m_Memory = null;
	private bool m_IsBoundToMemory = false;

	public this(DeviceVal device, IAccelerationStructure accelerationStructure, bool isBoundToMemory)
		: base(device, accelerationStructure)
	{
		m_IsBoundToMemory = isBoundToMemory;
	}

	public ~this()
	{
		if (m_Memory != null)
			m_Memory.UnbindAccelerationStructure(this);

		m_Device.GetImpl().DestroyAccelerationStructure(m_ImplObject);
	}

	[Inline] public bool IsBoundToMemory()
	{
		return m_IsBoundToMemory;
	}
	[Inline] public void SetBoundToMemory(MemoryVal memory)
	{
		m_Memory = memory;
		m_IsBoundToMemory = true;
	}

		//================================================================================================================
		// NRI
		//================================================================================================================
	public void GetMemoryInfo(ref MemoryDesc memoryDesc)
	{
		m_ImplObject.GetMemoryInfo(ref memoryDesc);
		m_Device.RegisterMemoryType(memoryDesc.type, MemoryLocation.DEVICE);
	}

	public uint64 GetUpdateScratchBufferSize()
	{
		return m_ImplObject.GetUpdateScratchBufferSize();
	}

	public uint64 GetBuildScratchBufferSize()
	{
		return m_ImplObject.GetBuildScratchBufferSize();
	}

	public uint64 GetNativeHandle(uint32 physicalDeviceIndex)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), IsBoundToMemory(), 0,
			"Can't get AccelerationStructure handle: AccelerationStructure is not bound to memory.");

		return m_ImplObject.GetNativeHandle(physicalDeviceIndex);
	}

	public uint64 GetNativeObject(uint32 physicalDeviceIndex)
	{
		RETURN_ON_FAILURE!(m_Device.GetLogger(), IsBoundToMemory(), 0,
			"Can't get AccelerationStructure native object: AccelerationStructure is not bound to memory.");

		return m_ImplObject.GetNativeObject(physicalDeviceIndex);
	}

	public Result CreateDescriptor(uint32 physicalDeviceIndex, out IDescriptor descriptor)
	{
		descriptor = ?;
		IDescriptor descriptorImpl = null;
		readonly Result result = m_ImplObject.CreateDescriptor(physicalDeviceIndex, out descriptorImpl);

		if (result == Result.SUCCESS)
		{
			RETURN_ON_FAILURE!(m_Device.GetLogger(), descriptorImpl != null, Result.FAILURE, "Unexpected error: 'descriptorImpl' is null.");
			descriptor = (IDescriptor)Allocate!<DescriptorVal>(m_Device.GetAllocator(), m_Device, descriptorImpl, ResourceType.ACCELERATION_STRUCTURE);
		}

		return result;
	}

	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}
}