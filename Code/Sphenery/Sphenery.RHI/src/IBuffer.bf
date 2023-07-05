namespace Sphenery.RHI;

interface IBuffer
{
	uint64 GetNativeObject(uint32 physicalDeviceIndex); // ID3D11Buffer*, ID3D12Resource* or VkBuffer

	void SetDebugName(char8* name);
	void GetMemoryInfo(MemoryLocation memoryLocation, ref MemoryDesc memoryDesc);
	void* Map(uint64 offset, uint64 size);
	void Unmap();
}