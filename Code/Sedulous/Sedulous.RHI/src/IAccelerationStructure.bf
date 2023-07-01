namespace Sedulous.RHI;

interface IAccelerationStructure
{
	uint64 GetUpdateScratchBufferSize();

	uint64 GetBuildScratchBufferSize();

	uint64 GetNativeHandle(uint32 physicalDeviceIndex);
	uint64 GetNativeObject(uint32 physicalDeviceIndex); // ID3D12Resource* or VkAccelerationStructureKHR

	void SetDebugName(char8* name);
	void GetMemoryInfo(ref MemoryDesc memoryDesc);
	Result CreateDescriptor(uint32 physicalDeviceMask, out IDescriptor descriptor);
}