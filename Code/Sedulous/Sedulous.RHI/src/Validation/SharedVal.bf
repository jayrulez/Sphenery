using System;
namespace Sedulous.RHI.Validation;

public abstract class DeviceObjectBaseVal
{
	protected DeviceVal m_Device;

	public this(DeviceVal device)
	{
		m_Device = device;
	}

	public DeviceVal GetDevice() => m_Device;
}

public abstract class DeviceObjectVal<T> : DeviceObjectBaseVal
{
	protected T m_ImplObject;
	protected String m_Name;

	public this(DeviceVal device, T object)
		: base(device)
	{
		m_ImplObject = object;

		m_Name = Allocate!<String>(m_Device.GetAllocator());
	}

	public ~this()
	{
		Deallocate!(m_Device.GetAllocator(), m_Name);
	}

	public T GetImpl() => m_ImplObject;

	public String GetDebugName() => m_Name;
}

static
{
	public static DeviceVal GetDeviceVal<T>(T object) where T : var
	{
		return ((DeviceObjectBaseVal)object).GetDevice();
	}

	public const char8*[?] DESCRIPTOR_TYPE_NAME = .(
		"SAMPLER",
		"CONSTANT_BUFFER",
		"TEXTURE",
		"STORAGE_TEXTURE",
		"BUFFER",
		"STORAGE_BUFFER",
		"STRUCTURED_BUFFER",
		"STORAGE_STRUCTURED_BUFFER",
		"ACCELERATION_STRUCTURE"
		);

	public static void Asserts()
	{
		Compiler.Assert(DESCRIPTOR_TYPE_NAME.Count == (uint32)DescriptorType.MAX_NUM, "descriptor type name array is out of date");
	}

	public static char8* GetDescriptorTypeName(DescriptorType descriptorType)
	{
		return DESCRIPTOR_TYPE_NAME[(uint32)descriptorType];
	}

	public static bool IsAccessMaskSupported(BufferUsageBits usageMask, AccessBits accessMask)
	{
	    BufferUsageBits requiredUsageMask = BufferUsageBits.NONE;

	    if (accessMask.HasFlag(AccessBits.VERTEX_BUFFER))
	        requiredUsageMask |= BufferUsageBits.VERTEX_BUFFER;

	    if (accessMask.HasFlag(AccessBits.INDEX_BUFFER))
	        requiredUsageMask |= BufferUsageBits.INDEX_BUFFER;

	    if (accessMask.HasFlag(AccessBits.CONSTANT_BUFFER))
	        requiredUsageMask |= BufferUsageBits.CONSTANT_BUFFER;

	    if (accessMask.HasFlag(AccessBits.ARGUMENT_BUFFER))
	        requiredUsageMask |= BufferUsageBits.ARGUMENT_BUFFER;

	    if (accessMask.HasFlag(AccessBits.SHADER_RESOURCE))
	        requiredUsageMask |= BufferUsageBits.SHADER_RESOURCE;

	    if (accessMask.HasFlag(AccessBits.SHADER_RESOURCE_STORAGE))
	        requiredUsageMask |= BufferUsageBits.SHADER_RESOURCE_STORAGE;

	    if (accessMask.HasFlag(AccessBits.COLOR_ATTACHMENT))
	        return false;

	    if (accessMask.HasFlag(AccessBits.DEPTH_STENCIL_WRITE))
	        return false;

	    if (accessMask.HasFlag(AccessBits.DEPTH_STENCIL_READ))
	        return false;

	    if (accessMask.HasFlag(AccessBits.ACCELERATION_STRUCTURE_READ))
	        return false;

	    if (accessMask.HasFlag(AccessBits.ACCELERATION_STRUCTURE_WRITE))
	        return false;

	    return (uint32)(requiredUsageMask & usageMask) == (uint32)requiredUsageMask;
	}

	public static bool IsAccessMaskSupported(TextureUsageBits usageMask, AccessBits accessMask)
	{
	    TextureUsageBits requiredUsageMask = TextureUsageBits.NONE;

	    if (accessMask.HasFlag(AccessBits.VERTEX_BUFFER))
	        return false;

	    if (accessMask.HasFlag(AccessBits.INDEX_BUFFER))
	        return false;

	    if (accessMask.HasFlag(AccessBits.CONSTANT_BUFFER))
	        return false;

	    if (accessMask.HasFlag(AccessBits.ARGUMENT_BUFFER))
	        return false;

	    if (accessMask.HasFlag(AccessBits.SHADER_RESOURCE))
	        requiredUsageMask |= TextureUsageBits.SHADER_RESOURCE;

	    if (accessMask.HasFlag(AccessBits.SHADER_RESOURCE_STORAGE))
	        requiredUsageMask |= TextureUsageBits.SHADER_RESOURCE_STORAGE;

	    if (accessMask.HasFlag(AccessBits.COLOR_ATTACHMENT))
	        requiredUsageMask |= TextureUsageBits.COLOR_ATTACHMENT;

	    if (accessMask.HasFlag(AccessBits.DEPTH_STENCIL_WRITE))
	        requiredUsageMask |= TextureUsageBits.DEPTH_STENCIL_ATTACHMENT;

	    if (accessMask.HasFlag(AccessBits.DEPTH_STENCIL_READ))
	        requiredUsageMask |= TextureUsageBits.DEPTH_STENCIL_ATTACHMENT;

	    if (accessMask.HasFlag(AccessBits.ACCELERATION_STRUCTURE_READ))
	        return false;

	    if (accessMask.HasFlag(AccessBits.ACCELERATION_STRUCTURE_WRITE))
	        return false;

	    return (uint32)(requiredUsageMask & usageMask) == (uint32)requiredUsageMask;
	}

	public const TextureUsageBits[(int)TextureLayout.MAX_NUM] TEXTURE_USAGE_FOR_TEXTURE_LAYOUT_TABLE = .(
		TextureUsageBits.NONE, // GENERAL
		TextureUsageBits.COLOR_ATTACHMENT, // COLOR_ATTACHMENT
		TextureUsageBits.DEPTH_STENCIL_ATTACHMENT, // DEPTH_STENCIL
		TextureUsageBits.DEPTH_STENCIL_ATTACHMENT, // DEPTH_STENCIL_READONLY
		TextureUsageBits.DEPTH_STENCIL_ATTACHMENT, // DEPTH_READONLY
		TextureUsageBits.DEPTH_STENCIL_ATTACHMENT, // STENCIL_READONLY
		TextureUsageBits.SHADER_RESOURCE, // SHADER_RESOURCE
		TextureUsageBits.NONE, // PRESENT
		TextureUsageBits.NONE // UNKNOWN
		);

	public static bool IsTextureLayoutSupported(TextureUsageBits usageMask, TextureLayout textureLayout)
	{
	    readonly TextureUsageBits requiredMask = TEXTURE_USAGE_FOR_TEXTURE_LAYOUT_TABLE[(uint)textureLayout];

	    return (uint32)(requiredMask & usageMask) == (uint32)requiredMask;
	}

	public static mixin NRI_GET_IMPL_PTR<TOut, TObj>(TObj object)
		where TObj : TOut, var
		where TOut : var
	{
		object != null ? object.GetImpl() : null
	}

	public static mixin NRI_GET_IMPL_REF<TOut, TObj>(TObj object)
		where TObj : var
		where TOut : var
	{
		(TOut)object.GetImpl()
	}
}