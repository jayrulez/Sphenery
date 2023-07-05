namespace Sphenery.RHI;

interface IDescriptor
{
	uint64 GetNativeObject(uint32 physicalDeviceIndex); // ID3D11View*, D3D12_CPU_DESCRIPTOR_HANDLE or VkImageView/VkBufferView

	void SetDebugName(char8* name);
}