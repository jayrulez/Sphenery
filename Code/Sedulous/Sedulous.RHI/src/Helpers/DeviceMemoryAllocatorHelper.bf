using Sedulous.RHI.Implementation;
using System.Collections;
using System;
namespace Sedulous.RHI.Helpers;

class DeviceMemoryAllocatorHelper
{
	private struct MemoryTypeGroup : IDisposable
	{
		public List<IBuffer> buffers;
		public List<uint64> bufferOffsets;
		public List<ITexture> textures;
		public List<uint64> textureOffsets;
		public uint64 memoryOffset;

		private DeviceAllocator<uint8> allocator;

		public this(DeviceAllocator<uint8> stdAllocator)
		{
			allocator = stdAllocator;

			buffers = Allocate!<List<IBuffer>>(allocator);
			bufferOffsets = Allocate!<List<uint64>>(allocator);
			textures = Allocate!<List<ITexture>>(allocator);
			textureOffsets = Allocate!<List<uint64>>(allocator);
			memoryOffset = 0;
		}

		public void Dispose()
		{
			Deallocate!(allocator, textureOffsets);
			Deallocate!(allocator, textures);
			Deallocate!(allocator, bufferOffsets);
			Deallocate!(allocator, buffers);
		}
	}

	private readonly IDevice m_Device;
	private readonly DeviceAllocator<uint8> m_StdAllocator;

	private Dictionary<MemoryType, MemoryTypeGroup> m_Map;
	private List<IBuffer> m_DedicatedBuffers;
	private List<ITexture> m_DedicatedTextures;
	private List<BufferMemoryBindingDesc> m_BufferBindingDescs;
	private List<TextureMemoryBindingDesc> m_TextureBindingDescs;

	public this(IDevice device, DeviceAllocator<uint8> stdAllocator)
	{
		m_Device = device;
		m_StdAllocator = stdAllocator;

		m_Map = Allocate!<Dictionary<MemoryType, MemoryTypeGroup>>(m_StdAllocator);
		m_DedicatedBuffers = Allocate!<List<IBuffer>>(m_StdAllocator);
		m_DedicatedTextures = Allocate!<List<ITexture>>(m_StdAllocator);
		m_BufferBindingDescs = Allocate!<List<BufferMemoryBindingDesc>>(m_StdAllocator);
		m_TextureBindingDescs = Allocate!<List<TextureMemoryBindingDesc>>(m_StdAllocator);
	}

	public ~this()
	{
		Deallocate!(m_StdAllocator, m_TextureBindingDescs);
		Deallocate!(m_StdAllocator, m_BufferBindingDescs);
		Deallocate!(m_StdAllocator, m_DedicatedTextures);
		Deallocate!(m_StdAllocator, m_DedicatedBuffers);

		for (var entry in m_Map)
		{
			entry.value.Dispose();
		}
		Deallocate!(m_StdAllocator, m_Map);
	}

	public uint32 CalculateAllocationNumber(ResourceGroupDesc resourceGroupDesc)
	{
		for (var entry in m_Map)
		{
			entry.value.Dispose();
		}
		m_Map.Clear();
		m_DedicatedBuffers.Clear();
		m_DedicatedTextures.Clear();

		GroupByMemoryType(resourceGroupDesc.memoryLocation, resourceGroupDesc.buffers, resourceGroupDesc.bufferNum);
		GroupByMemoryType(resourceGroupDesc.memoryLocation, resourceGroupDesc.textures, resourceGroupDesc.textureNum);

		return uint32(m_Map.Count) + uint32(m_DedicatedBuffers.Count) + uint32(m_DedicatedTextures.Count);
	}

	public Result AllocateAndBindMemory(ResourceGroupDesc resourceGroupDesc, IMemory* allocations)
	{
		for (var entry in m_Map)
		{
			entry.value.Dispose();
		}
		m_Map.Clear();
		m_DedicatedBuffers.Clear();
		m_DedicatedTextures.Clear();
		m_BufferBindingDescs.Clear();
		m_TextureBindingDescs.Clear();

		uint allocationNum = 0;

		readonly Result result = TryToAllocateAndBindMemory(resourceGroupDesc, allocations, ref allocationNum);

		if (result != Result.SUCCESS)
		{
			for (uint i = 0; i < allocationNum; i++)
			{
				m_Device.FreeMemory(allocations[i]);
				allocations[i] = null;
			}
		}

		return result;
	}

	private Result TryToAllocateAndBindMemory(ResourceGroupDesc resourceGroupDesc, IMemory* allocations, ref uint allocationNum)
	{
		GroupByMemoryType(resourceGroupDesc.memoryLocation, resourceGroupDesc.buffers, resourceGroupDesc.bufferNum);
		GroupByMemoryType(resourceGroupDesc.memoryLocation, resourceGroupDesc.textures, resourceGroupDesc.textureNum);

		Result result = Result.SUCCESS;

		for (var it = m_Map.GetEnumerator(); it.MoveNext() && result == Result.SUCCESS;)
			result = ProcessMemoryTypeGroup(it.Key, ref it.Value, allocations, ref allocationNum);

		if (result != Result.SUCCESS)
			return result;

		result = ProcessDedicatedResources(resourceGroupDesc.memoryLocation, allocations, ref allocationNum);

		if (result != Result.SUCCESS)
			return result;

		result = m_Device.BindBufferMemory(m_BufferBindingDescs.Ptr, (uint32)m_BufferBindingDescs.Count);

		if (result != Result.SUCCESS)
			return result;

		result = m_Device.BindTextureMemory(m_TextureBindingDescs.Ptr, (uint32)m_TextureBindingDescs.Count);

		return result;
	}

	private Result ProcessMemoryTypeGroup(MemoryType memoryType, ref MemoryTypeGroup group, IMemory* allocations, ref uint allocationNum)
	{
		ref IMemory memory = ref allocations[allocationNum];

		readonly uint64 allocationSize = group.memoryOffset;

		readonly Result result = m_Device.AllocateMemory(WHOLE_DEVICE_GROUP, memoryType, allocationSize, out memory);
		if (result != Result.SUCCESS)
			return result;

		FillMemoryBindingDescs(group.buffers.Ptr, group.bufferOffsets.Ptr, (uint32)group.buffers.Count, memory);
		FillMemoryBindingDescs(group.textures.Ptr, group.textureOffsets.Ptr, (uint32)group.textures.Count, memory);
		allocationNum++;

		return Result.SUCCESS;
	}

	private Result ProcessDedicatedResources(MemoryLocation memoryLocation, IMemory* allocations, ref uint allocationNum)
	{
		/*const*/ uint64 zeroOffset = 0;
		MemoryDesc memoryDesc = .();

		for (int i = 0; i < m_DedicatedBuffers.Count; i++)
		{
			m_DedicatedBuffers[i].GetMemoryInfo(memoryLocation, ref memoryDesc);

			ref IMemory memory = ref allocations[allocationNum];

			readonly Result result = m_Device.AllocateMemory(WHOLE_DEVICE_GROUP, memoryDesc.type, memoryDesc.size, out memory);
			if (result != Result.SUCCESS)
				return result;

			FillMemoryBindingDescs(m_DedicatedBuffers.Ptr + i, &zeroOffset, 1, memory);
			allocationNum++;
		}

		for (int i = 0; i < m_DedicatedTextures.Count; i++)
		{
			m_DedicatedTextures[i].GetMemoryInfo(memoryLocation, ref memoryDesc);

			ref IMemory memory = ref allocations[allocationNum];

			readonly Result result = m_Device.AllocateMemory(WHOLE_DEVICE_GROUP, memoryDesc.type, memoryDesc.size, out memory);
			if (result != Result.SUCCESS)
				return result;

			FillMemoryBindingDescs(m_DedicatedTextures.Ptr + i, &zeroOffset, 1, memory);
			allocationNum++;
		}

		return Result.SUCCESS;
	}

	private void GroupByMemoryType(MemoryLocation memoryLocation, IBuffer* buffers, uint32 bufferNum)
	{
		MemoryDesc memoryDesc = .();

		for (uint32 i = 0; i < bufferNum; i++)
		{
			IBuffer buffer = buffers[i];
			buffer.GetMemoryInfo(memoryLocation, ref memoryDesc);

			if (memoryDesc.mustBeDedicated)
				m_DedicatedBuffers.Add(buffer);
			else
			{
				if (!m_Map.ContainsKey(memoryDesc.type))
				{
					m_Map.Add(memoryDesc.type, .(m_StdAllocator));
				}
				ref MemoryTypeGroup group = ref m_Map[memoryDesc.type];

				readonly uint64 offset = Align(group.memoryOffset, memoryDesc.alignment);

				group.buffers.Add(buffer);
				group.bufferOffsets.Add(offset);
				group.memoryOffset = offset + memoryDesc.size;
			}
		}
	}

	private void GroupByMemoryType(MemoryLocation memoryLocation, ITexture* textures, uint32 textureNum)
	{
		readonly ref DeviceDesc deviceDesc = ref m_Device.GetDesc();

		MemoryDesc memoryDesc = .();

		for (uint32 i = 0; i < textureNum; i++)
		{
			ITexture texture = textures[i];
			texture.GetMemoryInfo(memoryLocation, ref memoryDesc);

			if (memoryDesc.mustBeDedicated)
				m_DedicatedTextures.Add(texture);
			else
			{
				if (!m_Map.ContainsKey(memoryDesc.type))
				{
					m_Map.Add(memoryDesc.type, .(m_StdAllocator));
				}
				ref MemoryTypeGroup group = ref m_Map[memoryDesc.type];

				if (group.textures.IsEmpty && group.memoryOffset > 0)
					group.memoryOffset = Align(group.memoryOffset, deviceDesc.bufferTextureGranularity);

				readonly uint64 offset = Align(group.memoryOffset, memoryDesc.alignment);

				group.textures.Add(texture);
				group.textureOffsets.Add(offset);
				group.memoryOffset = offset + memoryDesc.size;
			}
		}
	}

	private void FillMemoryBindingDescs(IBuffer* buffers, uint64* bufferOffsets, uint32 bufferNum, IMemory memory)
	{
		for (uint32 i = 0; i < bufferNum; i++)
		{
			BufferMemoryBindingDesc desc = .();
			desc.memory = memory;
			desc.buffer = buffers[i];
			desc.offset = bufferOffsets[i];
			desc.physicalDeviceMask = WHOLE_DEVICE_GROUP;

			m_BufferBindingDescs.Add(desc);
		}
	}

	private void FillMemoryBindingDescs(ITexture* textures, uint64* textureOffsets, uint32 textureNum, IMemory memory)
	{
		for (uint32 i = 0; i < textureNum; i++)
		{
			TextureMemoryBindingDesc desc = .();
			desc.memory = memory;
			desc.texture = textures[i];
			desc.offset = textureOffsets[i];
			desc.physicalDeviceMask = WHOLE_DEVICE_GROUP;

			m_TextureBindingDescs.Add(desc);
		}
	}
}