using System.Collections;
using System;
namespace Sedulous.RHI.Validation;

class QueryPoolVal : DeviceObjectVal<IQueryPool>, IQueryPool
{
	private List<uint64> m_DeviceState;
	private uint32 m_QueryNum;
	private QueryType m_QueryType;

	public this(DeviceVal device, IQueryPool queryPool, QueryType queryType, uint32 queryNum)
		: base(device, queryPool)
	{
		m_DeviceState = Allocate!<List<uint64>>(m_Device.GetAllocator());

		m_QueryType = queryType;
		m_QueryNum = queryNum;

		if (m_QueryNum != 0)
		{
			readonly uint batchNum = Math.Max(m_QueryNum >> 6, 1u);
			m_DeviceState.Resize((.)batchNum, 0);
		}
	}

	public ~this()
	{
		Deallocate!(m_Device.GetAllocator(), m_DeviceState);
	}

	public bool SetQueryState(uint32 offset, bool state) // TODO: not [Inline]
	{
		readonly uint batchIndex = offset >> 6;
		readonly uint64 batchValue = m_DeviceState[(.)batchIndex];
		readonly uint bitIndex = 1uL << (offset & 63);
		readonly uint64 maskBitValue = ~bitIndex;
		readonly uint64 bitValue = state ? bitIndex : 0;

		m_DeviceState[(.)batchIndex] = (batchValue & maskBitValue) | bitValue;

		return batchValue & bitIndex != 0;
	}

	public void ResetQueries(uint32 offset, uint32 number)
	{
		for (uint32 i = 0; i < number; i++)
			SetQueryState(offset + i, false);
	}

	[Inline] public uint32 GetQueryNum()
		{ return m_QueryNum; }

	[Inline] public QueryType GetQueryType()
		{ return m_QueryType; }

	[Inline] public bool IsImported()
		{ return m_QueryNum == 0; }

	//================================================================================================================
	// NRI
	//================================================================================================================
	public void SetDebugName(char8* name)
	{
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}

	public uint32 GetQuerySize()
	{
		return m_ImplObject.GetQuerySize();
	}
}