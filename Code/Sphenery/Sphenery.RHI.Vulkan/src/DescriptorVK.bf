using Bulkan;
using System;
namespace Sphenery.RHI.Vulkan;


enum DescriptorTypeVK
{
	NONE = 0,
	BUFFER_VIEW,
	IMAGE_VIEW,
	SAMPLER,
	ACCELERATION_STRUCTURE
}

struct DescriptorBufferDesc
{
	public VkBuffer[PHYSICAL_DEVICE_GROUP_MAX_SIZE] handles = .();
	public uint64 offset;
	public uint64 size;
}

struct DescriptorTextureDesc
{
	public VkImage[PHYSICAL_DEVICE_GROUP_MAX_SIZE] handles = .();
	public TextureVK texture;
	public VkImageLayout imageLayout;
	public uint32 imageMipOffset;
	public uint32 imageMipNum;
	public uint32 imageArrayOffset;
	public uint32 imageArraySize;
	public VkImageAspectFlags imageAspectFlags;
}

static
{
	public static void FillTextureDesc<T>(T textureViewDesc, ref DescriptorTextureDesc descriptorTextureDesc) where T : var
	{
		readonly TextureVK texture = (TextureVK)textureViewDesc.texture;

		readonly uint32 mipLevelsLeft = texture.GetMipNum() - textureViewDesc.mipOffset;
		readonly uint32 arrayLayersLeft = texture.GetArraySize() - descriptorTextureDesc.imageArrayOffset;

		descriptorTextureDesc.texture = texture;
		descriptorTextureDesc.imageAspectFlags = texture.GetImageAspectFlags();
		descriptorTextureDesc.imageMipOffset = textureViewDesc.mipOffset;
		descriptorTextureDesc.imageMipNum = (textureViewDesc.mipNum == REMAINING_MIP_LEVELS) ? mipLevelsLeft : textureViewDesc.mipNum;
		descriptorTextureDesc.imageArrayOffset = textureViewDesc.arrayOffset;
		descriptorTextureDesc.imageArraySize = (textureViewDesc.arraySize == REMAINING_ARRAY_LAYERS) ? arrayLayersLeft : textureViewDesc.arraySize;
		descriptorTextureDesc.imageLayout = GetImageLayoutForView(textureViewDesc.viewType);
	}

	public static void FillTextureDesc(Texture3DViewDesc textureViewDesc, ref DescriptorTextureDesc descriptorTextureDesc)
	{
		readonly TextureVK texture = (TextureVK)textureViewDesc.texture;

		readonly uint32 mipLevelsLeft = texture.GetMipNum() - textureViewDesc.mipOffset;

		descriptorTextureDesc.texture = texture;
		descriptorTextureDesc.imageAspectFlags = texture.GetImageAspectFlags();
		descriptorTextureDesc.imageMipOffset = textureViewDesc.mipOffset;
		descriptorTextureDesc.imageMipNum = (textureViewDesc.mipNum == REMAINING_MIP_LEVELS) ? mipLevelsLeft : textureViewDesc.mipNum;
		descriptorTextureDesc.imageArrayOffset = 0;
		descriptorTextureDesc.imageArraySize = 1;
		descriptorTextureDesc.imageLayout = GetImageLayoutForView(textureViewDesc.viewType);
	}

	public static void FillImageSubresourceRange<T>(T textureViewDesc, ref VkImageSubresourceRange subresourceRange) where T : var
	{
		readonly TextureVK texture = (TextureVK)textureViewDesc.texture;

		subresourceRange = .()
			{
				aspectMask = texture.GetImageAspectFlags(),
				baseMipLevel = textureViewDesc.mipOffset,
				levelCount = (textureViewDesc.mipNum == REMAINING_MIP_LEVELS) ? VulkanNative.VK_REMAINING_MIP_LEVELS : textureViewDesc.mipNum,
				baseArrayLayer = textureViewDesc.arrayOffset,
				layerCount = (textureViewDesc.arraySize == REMAINING_ARRAY_LAYERS) ? VulkanNative.VK_REMAINING_ARRAY_LAYERS : textureViewDesc.arraySize
			};
	}

	public static void FillImageSubresourceRange(Texture3DViewDesc textureViewDesc, ref VkImageSubresourceRange subresourceRange)
	{
		readonly TextureVK texture = (TextureVK)textureViewDesc.texture;

		subresourceRange = .()
			{
				aspectMask = texture.GetImageAspectFlags(),
				baseMipLevel = textureViewDesc.mipOffset,
				levelCount = (textureViewDesc.mipNum == REMAINING_MIP_LEVELS) ? VulkanNative.VK_REMAINING_MIP_LEVELS : textureViewDesc.mipNum,
				baseArrayLayer = 0,
				layerCount = 1
			};
	}
}

class DescriptorVK : IDescriptor
{
	private DeviceVK m_Device;
	[Union] struct Resource
	{
		public VkBufferView[PHYSICAL_DEVICE_GROUP_MAX_SIZE] m_BufferViews = .();
		public VkImageView[PHYSICAL_DEVICE_GROUP_MAX_SIZE] m_ImageViews = .();
		public VkAccelerationStructureKHR[PHYSICAL_DEVICE_GROUP_MAX_SIZE] m_AccelerationStructures = .();
		public VkSampler m_Sampler;
	}
	[Union] struct Desc
	{
		public DescriptorBufferDesc m_BufferDesc;
		public DescriptorTextureDesc m_TextureDesc = .();
	}
	private using private Resource m_Resource;
	private using private Desc m_Desc;
	private DescriptorTypeVK m_Type = DescriptorTypeVK.NONE;
	private VkFormat m_Format = .VK_FORMAT_UNDEFINED;

	[Inline] public this(DeviceVK device)
	{
		m_Device = device;
		m_BufferViews.SetAll(.Null);
	}

	public ~this()
	{
		switch (m_Type)
		{
		case DescriptorTypeVK.NONE,
			DescriptorTypeVK.ACCELERATION_STRUCTURE:
			break;
		case DescriptorTypeVK.BUFFER_VIEW:
			for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
			{
				if (m_BufferViews[i] != .Null)
					VulkanNative.vkDestroyBufferView(m_Device, m_BufferViews[i], m_Device.GetAllocationCallbacks());
			}
			break;
		case DescriptorTypeVK.IMAGE_VIEW:
			for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
			{
				if (m_ImageViews[i] != .Null)
					VulkanNative.vkDestroyImageView(m_Device, m_ImageViews[i], m_Device.GetAllocationCallbacks());
			}
			break;
		case DescriptorTypeVK.SAMPLER:
			if (m_Sampler != .Null)
				VulkanNative.vkDestroySampler(m_Device, m_Sampler, m_Device.GetAllocationCallbacks());
			break;
		}
	}

	[Inline] public DeviceVK GetDevice()
		{ return m_Device; }

	[Inline] public VkBufferView GetBufferView(uint32 physicalDeviceIndex)
		{ return m_BufferViews[physicalDeviceIndex]; }

	[Inline] public VkImageView GetImageView(uint32 physicalDeviceIndex)
		{ return m_ImageViews[physicalDeviceIndex]; }

	[Inline] public readonly ref VkSampler GetSampler()
		{ return ref m_Sampler; }

	[Inline] public VkAccelerationStructureKHR GetAccelerationStructure(uint32 physicalDeviceIndex)
		{ return m_AccelerationStructures[physicalDeviceIndex]; }

	[Inline] public VkBuffer GetBuffer(uint32 physicalDeviceIndex)
		{ return m_BufferDesc.handles[physicalDeviceIndex]; }

	[Inline] public VkImage GetImage(uint32 physicalDeviceIndex)
		{ return m_TextureDesc.handles[physicalDeviceIndex]; }

	[Inline] public TextureVK GetTexture()
		{ return m_TextureDesc.texture; }

	[Inline] public DescriptorTypeVK GetDescriptorType()
		{ return m_Type; }

	[Inline] public VkFormat GetFormat()
		{ return m_Format; }

	[Inline] public VkImageLayout GetImageLayout()
		{ return m_TextureDesc.imageLayout; }

	[Inline] public readonly ref DescriptorTextureDesc GetTextureDesc()
		{ return ref m_TextureDesc; }

	[Inline] public readonly ref DescriptorBufferDesc GetBufferDesc()
		{ return ref m_BufferDesc; }

	[Inline] public void GetBufferInfo(uint32 physicalDeviceIndex, ref VkDescriptorBufferInfo info)
	{
		info.buffer = m_BufferDesc.handles[physicalDeviceIndex];
		info.offset = m_BufferDesc.offset;
		info.range = m_BufferDesc.size;
	}

	[Inline] public void GetImageSubresourceRange(ref VkImageSubresourceRange range)
	{
		range.aspectMask = m_TextureDesc.imageAspectFlags;
		range.baseMipLevel = m_TextureDesc.imageMipOffset;
		range.levelCount = m_TextureDesc.imageMipNum;
		range.baseArrayLayer = m_TextureDesc.imageArrayOffset;
		range.layerCount = m_TextureDesc.imageArraySize;
	}


	public Result Create(BufferViewDesc bufferViewDesc)
	{
		readonly BufferVK buffer = (BufferVK)bufferViewDesc.buffer;

		m_Type = DescriptorTypeVK.BUFFER_VIEW;
		m_Format = GetVkFormat((Format)bufferViewDesc.format);
		m_BufferDesc.offset = bufferViewDesc.offset;
		m_BufferDesc.size = (bufferViewDesc.size == WHOLE_SIZE) ? VulkanNative.VK_WHOLE_SIZE : bufferViewDesc.size;

		readonly uint32 physicalDeviceMask = GetPhysicalDeviceGroupMask(bufferViewDesc.physicalDeviceMask);

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
				m_BufferDesc.handles[i] = buffer.GetHandle(i);
		}

		if (bufferViewDesc.format == Format.UNKNOWN)
			return Result.SUCCESS;

		VkBufferViewCreateInfo info = .()
			{
				sType = .VK_STRUCTURE_TYPE_BUFFER_VIEW_CREATE_INFO,
				pNext = null,
				flags = (VkBufferViewCreateFlags)0,
				buffer = .Null,
				format = m_Format,
				offset = bufferViewDesc.offset,
				range = m_BufferDesc.size
			};

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
			{
				info.buffer = buffer.GetHandle(i);

				readonly VkResult result = VulkanNative.vkCreateBufferView(m_Device, &info, m_Device.GetAllocationCallbacks(), &m_BufferViews[i]);

				RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
					"Can't create a buffer view: vkCreateBufferView returned {0}.", (int32)result);
			}
		}

		return Result.SUCCESS;
	}

	public Result Create(Texture1DViewDesc textureViewDesc)
	{
		return CreateTextureView(textureViewDesc);
	}

	public Result Create(Texture2DViewDesc textureViewDesc)
	{
		return CreateTextureView(textureViewDesc);
	}

	public Result Create(Texture3DViewDesc textureViewDesc)
	{
		return CreateTextureView(textureViewDesc);
	}

	public Result Create(SamplerDesc samplerDesc)
	{
		m_Type = DescriptorTypeVK.SAMPLER;

		/*readonly*/ VkSamplerCreateInfo samplerInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_SAMPLER_CREATE_INFO,
				pNext = null,
				flags = (VkSamplerCreateFlags)0,
				magFilter = GetFilter(samplerDesc.magnification),
				minFilter = GetFilter(samplerDesc.minification),
				mipmapMode = GetSamplerMipmapMode(samplerDesc.minification),
				addressModeU = GetSamplerAddressMode(samplerDesc.addressModes.u),
				addressModeV = GetSamplerAddressMode(samplerDesc.addressModes.v),
				addressModeW = GetSamplerAddressMode(samplerDesc.addressModes.w),
				mipLodBias = samplerDesc.mipBias,
				anisotropyEnable = VkBool32(samplerDesc.anisotropy > 1.0f),
				maxAnisotropy = (float)samplerDesc.anisotropy,
				compareEnable = VkBool32(samplerDesc.compareFunc != CompareFunc.NONE),
				compareOp = GetCompareOp(samplerDesc.compareFunc),
				minLod = samplerDesc.mipMin,
				maxLod = samplerDesc.mipMax,
				borderColor = .VK_BORDER_COLOR_FLOAT_TRANSPARENT_BLACK,
				unnormalizedCoordinates = VkBool32(samplerDesc.unnormalizedCoordinates)
			};

		readonly VkResult result = VulkanNative.vkCreateSampler(m_Device, &samplerInfo, m_Device.GetAllocationCallbacks(), &m_Sampler);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't create a sampler: vkCreateSampler returned {0}.", (int32)result);

		return Result.SUCCESS;
	}

	public Result Create(VkAccelerationStructureKHR* accelerationStructures, uint32 physicalDeviceMask)
	{
		var physicalDeviceMask;
		m_Type = DescriptorTypeVK.ACCELERATION_STRUCTURE;

		physicalDeviceMask = GetPhysicalDeviceGroupMask(physicalDeviceMask);

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
				m_AccelerationStructures[i] = accelerationStructures[i];
		}

		return Result.SUCCESS;
	}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public void SetDebugName(char8* name)
	{
		uint64[PHYSICAL_DEVICE_GROUP_MAX_SIZE] handles = .();

		switch (m_Type)
		{
		case DescriptorTypeVK.BUFFER_VIEW:
			for (uint i = 0; i < handles.Count; i++)
				handles[i] = (uint64)m_BufferViews[i];
			m_Device.SetDebugNameToDeviceGroupObject(.VK_OBJECT_TYPE_BUFFER_VIEW, &handles, name);
			break;

		case DescriptorTypeVK.IMAGE_VIEW:
			for (uint i = 0; i < handles.Count; i++)
				handles[i] = (uint64)m_ImageViews[i];
			m_Device.SetDebugNameToDeviceGroupObject(.VK_OBJECT_TYPE_IMAGE_VIEW, &handles, name);
			break;

		case DescriptorTypeVK.SAMPLER:
			m_Device.SetDebugNameToTrivialObject(.VK_OBJECT_TYPE_SAMPLER, (uint64)m_Sampler, name);
			break;

		case DescriptorTypeVK.ACCELERATION_STRUCTURE:
			for (uint i = 0; i < handles.Count; i++)
				handles[i] = (uint64)m_AccelerationStructures[i];
			m_Device.SetDebugNameToDeviceGroupObject(.VK_OBJECT_TYPE_ACCELERATION_STRUCTURE_KHR, &handles, name);
			break;

		default:
			CHECK(m_Device.GetLogger(), false, "unexpected descriptor type in SetDebugName: %u", (uint32)m_Type);
			break;
		}
	}

	private Result CreateTextureView<T>(T textureViewDesc) where T : var
	{
		readonly TextureVK texture = (TextureVK)textureViewDesc.texture;

		VkImageViewUsageCreateInfo imageViewUsageCreateInfo = .();
		imageViewUsageCreateInfo.sType = .VK_STRUCTURE_TYPE_IMAGE_VIEW_USAGE_CREATE_INFO;
		imageViewUsageCreateInfo.usage = GetImageViewUsage(textureViewDesc.viewType);

		m_Type = DescriptorTypeVK.IMAGE_VIEW;
		m_Format = Sphenery.RHI.Vulkan.GetVkImageViewFormat(textureViewDesc.format);
		FillTextureDesc(textureViewDesc, ref m_TextureDesc);

		VkImageSubresourceRange subresource = .();
		FillImageSubresourceRange(textureViewDesc, ref subresource);

		VkImageViewCreateInfo imageViewCreateInfo = .();
		imageViewCreateInfo.sType = .VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
		imageViewCreateInfo.pNext = &imageViewUsageCreateInfo;
		imageViewCreateInfo.viewType = GetImageViewType(textureViewDesc.viewType);
		imageViewCreateInfo.format = m_Format;
		imageViewCreateInfo.subresourceRange = subresource;

		readonly uint32 physicalDeviceMask = GetPhysicalDeviceGroupMask(textureViewDesc.physicalDeviceMask);

		for (uint32 i = 0; i < m_Device.GetPhysicalDeviceGroupSize(); i++)
		{
			if (((1 << i) & physicalDeviceMask) != 0)
			{
				m_TextureDesc.handles[i] = texture.GetHandle(i);
				imageViewCreateInfo.image = texture.GetHandle(i);

				readonly VkResult result = VulkanNative.vkCreateImageView(m_Device, &imageViewCreateInfo, m_Device.GetAllocationCallbacks(), &m_ImageViews[i]);

				RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
					"Can't create a texture view: vkCreateImageView returned {0}.", (int32)result);
			}
		}

		return Result.SUCCESS;
	}


	public uint64 GetNativeObject(uint32 physicalDeviceIndex)
	{
		uint64 handle = 0;
		if (GetDescriptorType() == DescriptorTypeVK.BUFFER_VIEW)
			handle = (uint64)GetBufferView(physicalDeviceIndex);
		else if (GetDescriptorType() == DescriptorTypeVK.IMAGE_VIEW)
			handle = (uint64)GetImageView(physicalDeviceIndex);
		else if (GetDescriptorType() == DescriptorTypeVK.SAMPLER)
			handle = (uint64)GetSampler();
		else if (GetDescriptorType() == DescriptorTypeVK.ACCELERATION_STRUCTURE)
			handle = (uint64)GetAccelerationStructure(physicalDeviceIndex);

		return handle;
	}
}