namespace Sphenery.RHI;

interface ITexture
{
	uint64 GetNativeObject(uint32 physicalDeviceIndex); // ID3D11Resource*, ID3D12Resource* or VkImage

	void SetDebugName(char8* name);
	void GetMemoryInfo(MemoryLocation memoryLocation, ref MemoryDesc memoryDesc);
}