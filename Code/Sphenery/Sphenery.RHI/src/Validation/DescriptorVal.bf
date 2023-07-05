using System;
namespace Sphenery.RHI.Validation;

enum ResourceType
{
    NONE,
    BUFFER,
    TEXTURE,
    SAMPLER,
    ACCELERATION_STRUCTURE
}

enum ResourceViewType
{
    NONE,
    COLOR_ATTACHMENT,
    DEPTH_STENCIL_ATTACHMENT,
    SHADER_RESOURCE,
    SHADER_RESOURCE_STORAGE,
    CONSTANT_BUFFER_VIEW
}

class DescriptorVal : DeviceObjectVal<IDescriptor>, IDescriptor
{
    private ResourceType m_ResourceType = ResourceType.NONE;
    private ResourceViewType m_ResourceViewType = ResourceViewType.NONE;

	public this(DeviceVal device, IDescriptor descriptor, ResourceType resourceType)
		: base(device, descriptor)
		{
			m_ResourceType = resourceType;
		}

		public this(DeviceVal device, IDescriptor descriptor, BufferViewDesc bufferViewDesc)
		: base(device, descriptor)
		{
			m_ResourceType = .BUFFER;
			switch(bufferViewDesc.viewType)
			 {
			 case BufferViewType.CONSTANT:
			     m_ResourceViewType = ResourceViewType.CONSTANT_BUFFER_VIEW;
			     break;
			 case BufferViewType.SHADER_RESOURCE:
			     m_ResourceViewType = ResourceViewType.SHADER_RESOURCE;
			     break;
			 case BufferViewType.SHADER_RESOURCE_STORAGE:
			     m_ResourceViewType = ResourceViewType.SHADER_RESOURCE_STORAGE;
			     break;
			 default:
			     CHECK(m_Device.GetLogger(), false, "unexpected BufferView type in DescriptorVal: {0}", (uint32)bufferViewDesc.viewType);
			     break;
			}
		}

		public this(DeviceVal device, IDescriptor descriptor, Texture1DViewDesc textureViewDesc)
		: base(device, descriptor)
		{
			m_ResourceType = .TEXTURE;
			switch(textureViewDesc.viewType)
			 {
			 case Texture1DViewType.SHADER_RESOURCE_1D,
				 Texture1DViewType.SHADER_RESOURCE_1D_ARRAY:
			     m_ResourceViewType = ResourceViewType.SHADER_RESOURCE;
			     break;
			 case Texture1DViewType.SHADER_RESOURCE_STORAGE_1D,
				 Texture1DViewType.SHADER_RESOURCE_STORAGE_1D_ARRAY:
			     m_ResourceViewType = ResourceViewType.SHADER_RESOURCE_STORAGE;
			     break;
			 case Texture1DViewType.COLOR_ATTACHMENT:
			     m_ResourceViewType = ResourceViewType.COLOR_ATTACHMENT;
			     break;
			 case Texture1DViewType.DEPTH_STENCIL_ATTACHMENT:
			     m_ResourceViewType = ResourceViewType.DEPTH_STENCIL_ATTACHMENT;
			     break;
			 default:
			     CHECK(m_Device.GetLogger(), false, "unexpected TextureView type in DescriptorVal: {0}", (uint32)textureViewDesc.viewType);
			     break;
			}
		}

		public this(DeviceVal device, IDescriptor descriptor, Texture2DViewDesc textureViewDesc)
		: base(device, descriptor)
		{
			m_ResourceType = .TEXTURE;
			switch(textureViewDesc.viewType)
			 {
			 case Texture2DViewType.SHADER_RESOURCE_2D,
				 Texture2DViewType.SHADER_RESOURCE_2D_ARRAY,
				 Texture2DViewType.SHADER_RESOURCE_CUBE,
				 Texture2DViewType.SHADER_RESOURCE_CUBE_ARRAY:
			     m_ResourceViewType = ResourceViewType.SHADER_RESOURCE;
			     break;
			 case Texture2DViewType.SHADER_RESOURCE_STORAGE_2D,
				 Texture2DViewType.SHADER_RESOURCE_STORAGE_2D_ARRAY:
			     m_ResourceViewType = ResourceViewType.SHADER_RESOURCE_STORAGE;
			     break;
			 case Texture2DViewType.COLOR_ATTACHMENT:
			     m_ResourceViewType = ResourceViewType.COLOR_ATTACHMENT;
			     break;
			 case Texture2DViewType.DEPTH_STENCIL_ATTACHMENT:
			     m_ResourceViewType = ResourceViewType.DEPTH_STENCIL_ATTACHMENT;
			     break;
			 default:
			     CHECK(m_Device.GetLogger(), false, "unexpected TextureView type in DescriptorVal: {0}", (uint32)textureViewDesc.viewType);
			     break;
			}
		}

		public this(DeviceVal device, IDescriptor descriptor, Texture3DViewDesc textureViewDesc)
		: base(device, descriptor)
		{
			m_ResourceType = .TEXTURE;
			switch(textureViewDesc.viewType)
			 {
			 case Texture3DViewType.SHADER_RESOURCE_3D:
			     m_ResourceViewType = ResourceViewType.SHADER_RESOURCE;
			     break;
			 case Texture3DViewType.SHADER_RESOURCE_STORAGE_3D:
			     m_ResourceViewType = ResourceViewType.SHADER_RESOURCE_STORAGE;
			     break;
			 case Texture3DViewType.COLOR_ATTACHMENT:
			     m_ResourceViewType = ResourceViewType.COLOR_ATTACHMENT;
			     break;
			 default:
			     CHECK(m_Device.GetLogger(), false, "unexpected TextureView type in DescriptorVal: {0}", (uint32)textureViewDesc.viewType);
			     break;
			}
		}

		public this(DeviceVal device, IDescriptor descriptor)
		: base(device, descriptor)
		{
			m_ResourceType = .SAMPLER;
		}

		[Inline] public uint64 GetNativeObject(uint32 physicalDeviceIndex)
		{ return m_ImplObject.GetNativeObject(physicalDeviceIndex); }

		[Inline] public bool IsBufferView()
		{ return m_ResourceType == ResourceType.BUFFER; }

		[Inline] public bool IsTextureView()
		{ return m_ResourceType == ResourceType.TEXTURE; }

		[Inline] public bool IsSampler()
		{ return m_ResourceType == ResourceType.SAMPLER; }

		[Inline] public bool IsAccelerationStructure()
		{ return m_ResourceType == ResourceType.ACCELERATION_STRUCTURE; }

		[Inline] public bool IsConstantBufferView()
		{ return m_ResourceType == ResourceType.BUFFER && m_ResourceViewType == ResourceViewType.CONSTANT_BUFFER_VIEW; }

		[Inline] public bool IsColorAttachment()
		{ return IsTextureView() && m_ResourceViewType == ResourceViewType.COLOR_ATTACHMENT; }

		[Inline] public bool IsDepthStencilAttachment()
		{ return IsTextureView() && m_ResourceViewType == ResourceViewType.DEPTH_STENCIL_ATTACHMENT; }

		[Inline] public bool IsShaderResource()
		{ return m_ResourceType != ResourceType.NONE && !IsSampler() && m_ResourceViewType == ResourceViewType.SHADER_RESOURCE; }

		[Inline] public bool IsShaderResourceStorage()
		{ return m_ResourceType != ResourceType.NONE && !IsSampler() && m_ResourceViewType == ResourceViewType.SHADER_RESOURCE_STORAGE; }

		//================================================================================================================
		// NRI
		//================================================================================================================
		public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}
}