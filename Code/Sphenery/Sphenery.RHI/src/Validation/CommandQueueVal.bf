using Sphenery.RHI.Helpers;
using System.Collections;
namespace Sphenery.RHI.Validation;

static{
	public static bool ValidateTransitionBarrierDesc(DeviceVal device, uint32 i, BufferTransitionBarrierDesc bufferTransitionBarrierDesc)
{
    RETURN_ON_FAILURE!(device.GetLogger(), bufferTransitionBarrierDesc.buffer != null, false,
        "Can't change resource state: 'transitionBarriers.buffers[{0}].buffer' is invalid.", i);

    readonly BufferVal bufferVal = (BufferVal)bufferTransitionBarrierDesc.buffer;

    RETURN_ON_FAILURE!(device.GetLogger(), bufferVal.IsBoundToMemory(), false,
        "Can't change resource state: 'transitionBarriers.buffers[{0}].buffer' is not bound to memory.", i);

    readonly BufferUsageBits usageMask = bufferVal.GetDesc().usageMask;

    RETURN_ON_FAILURE!(device.GetLogger(), IsAccessMaskSupported(usageMask, bufferTransitionBarrierDesc.prevAccess), false,
        "Can't change resource state: 'transitionBarriers.buffers[{0}].prevAccess' is not supported by usageMask of the buffer.", i);

    RETURN_ON_FAILURE!(device.GetLogger(), IsAccessMaskSupported(usageMask, bufferTransitionBarrierDesc.nextAccess), false,
        "Can't change resource state: 'transitionBarriers.buffers[{0}].nextAccess' is not supported by usageMask of the buffer.", i);

    return true;
}

	public static bool ValidateTransitionBarrierDesc(DeviceVal device, uint32 i, TextureTransitionBarrierDesc textureTransitionBarrierDesc)
{
    RETURN_ON_FAILURE!(device.GetLogger(), textureTransitionBarrierDesc.texture != null, false,
        "Can't change resource state: 'transitionBarriers.textures[{0}].texture' is invalid.", i);

    readonly TextureVal textureVal = (TextureVal)textureTransitionBarrierDesc.texture;

    RETURN_ON_FAILURE!(device.GetLogger(), textureVal.IsBoundToMemory(), false,
        "Can't change resource state: 'transitionBarriers.textures[{0}].texture' is not bound to memory.", i);

    readonly TextureUsageBits usageMask = textureVal.GetDesc().usageMask;

    RETURN_ON_FAILURE!(device.GetLogger(), IsAccessMaskSupported(usageMask, textureTransitionBarrierDesc.prevAccess), false,
        "Can't change resource state: 'transitionBarriers.textures[{0}].prevAccess' is not supported by usageMask of the texture.", i);

    RETURN_ON_FAILURE!(device.GetLogger(), IsAccessMaskSupported(usageMask, textureTransitionBarrierDesc.nextAccess), false,
        "Can't change resource state: 'transitionBarriers.textures[{0}].nextAccess' is not supported by usageMask of the texture.", i);

    RETURN_ON_FAILURE!(device.GetLogger(), IsTextureLayoutSupported(usageMask, textureTransitionBarrierDesc.prevLayout), false,
        "Can't change resource state: 'transitionBarriers.textures[{0}].prevLayout' is not supported by usageMask of the texture.", i);

    RETURN_ON_FAILURE!(device.GetLogger(), IsTextureLayoutSupported(usageMask, textureTransitionBarrierDesc.nextLayout), false,
        "Can't change resource state: 'transitionBarriers.textures[{0}].nextLayout' is not supported by usageMask of the texture.", i);

    return true;
}

	public static bool ValidateTextureUploadDesc(DeviceVal device, uint32 i, TextureUploadDesc textureUploadDesc)
{
    readonly uint32 subresourceNum = textureUploadDesc.arraySize * textureUploadDesc.mipNum;

    RETURN_ON_FAILURE!(device.GetLogger(), textureUploadDesc.texture != null, false,
        "Can't upload data: 'textureUploadDescs[{0}].texture' is invalid.", i);

    if (subresourceNum == 0 && textureUploadDesc.subresources != null)
    {
        REPORT_WARNING(device.GetLogger(), "No data to upload: the number of subresources in 'textureUploadDescs[{0}]' is 0.", i);
        return true;
    }

    if (textureUploadDesc.subresources == null)
        return true;

    readonly TextureVal textureVal = (TextureVal)textureUploadDesc.texture;

    RETURN_ON_FAILURE!(device.GetLogger(), textureUploadDesc.mipNum <= textureVal.GetDesc().mipNum, false,
        "Can't upload data: 'textureUploadDescs[{0}].mipNum' is invalid.", i);

    RETURN_ON_FAILURE!(device.GetLogger(), textureUploadDesc.arraySize <= textureVal.GetDesc().arraySize, false,
        "Can't upload data: 'textureUploadDescs[{0}].arraySize' is invalid.", i);

    RETURN_ON_FAILURE!(device.GetLogger(), textureUploadDesc.nextLayout < TextureLayout.MAX_NUM, false,
        "Can't upload data: 'textureUploadDescs[{0}].nextLayout' is invalid.", i);

    RETURN_ON_FAILURE!(device.GetLogger(), textureVal.IsBoundToMemory(), false,
        "Can't upload data: 'textureUploadDescs[{0}].texture' is not bound to memory.", i);

    for (uint32 j = 0; j < subresourceNum; j++)
    {
        readonly ref TextureSubresourceUploadDesc subresource = ref textureUploadDesc.subresources[j];

        if (subresource.sliceNum == 0)
        {
            REPORT_WARNING(device.GetLogger(), "No data to upload: the number of subresources in 'textureUploadDescs[{0}].subresources[{1}].sliceNum' is 0.", i, j);
            continue;
        }

        RETURN_ON_FAILURE!(device.GetLogger(), subresource.slices != null, false,
            "Can't upload data: 'textureUploadDescs[{0}].subresources[{1}].slices' is invalid.", i, j);

        RETURN_ON_FAILURE!(device.GetLogger(), subresource.rowPitch != 0, false,
            "Can't upload data: 'textureUploadDescs[{0}].subresources[{1}].rowPitch' is 0.", i, j);

        RETURN_ON_FAILURE!(device.GetLogger(), subresource.slicePitch != 0, false,
            "Can't upload data: 'textureUploadDescs[{0}].subresources[{1}].slicePitch' is 0.", i, j);
    }

    return true;
}

	public static bool ValidateBufferUploadDesc(DeviceVal device, uint32 i, BufferUploadDesc bufferUploadDesc)
{
    RETURN_ON_FAILURE!(device.GetLogger(), bufferUploadDesc.buffer != null, false,
        "Can't upload data: 'bufferUploadDescs[{0}].buffer' is invalid.", i);

    if (bufferUploadDesc.dataSize == 0)
    {
        REPORT_WARNING(device.GetLogger(), "No data to upload: 'bufferUploadDescs[{0}].dataSize' is 0.", i);
        return true;
    }

    RETURN_ON_FAILURE!(device.GetLogger(), bufferUploadDesc.data != null, false,
        "Can't upload data: 'bufferUploadDescs[{0}].data' is invalid.", i);

    readonly BufferVal bufferVal = (BufferVal)bufferUploadDesc.buffer;

    readonly uint64 rangeEnd = bufferUploadDesc.bufferOffset + bufferUploadDesc.dataSize;

    RETURN_ON_FAILURE!(device.GetLogger(), rangeEnd <= bufferVal.GetDesc().size, false,
        "Can't upload data: 'bufferUploadDescs[{0}].bufferOffset + bufferUploadDescs[{1}].dataSize' is out of bounds.", i, i);

    RETURN_ON_FAILURE!(device.GetLogger(), bufferVal.IsBoundToMemory(), false,
        "Can't upload data: 'bufferUploadDescs[{0}].buffer' is not bound to memory.", i);

    return true;
}

	public static Command* ReadCommand<Command>(ref uint8* begin, uint8* end)
	{
	    if (begin + sizeof(Command) <= end)
	    {
	        readonly Command* command = (Command*)begin;
	        begin += sizeof(Command);
	        return command;
	    }
	    return null;
	}
}

typealias ProcessValidationCommandMethod = function void (CommandQueueVal this, ref uint8* begin, uint8* end);

class CommandQueueVal : DeviceObjectVal<ICommandQueue>, ICommandQueue
{

	public this(DeviceVal device, ICommandQueue commandQueue)
		: base(device, commandQueue)
	{

	}

	//================================================================================================================
	// NRI
	//================================================================================================================
	public void SetDebugName(char8* name){
		m_Name.Set(scope .(name));
		m_ImplObject.SetDebugName(name);
	}

	public void Submit(QueueSubmitDesc queueSubmitDesc)
{
    ProcessValidationCommands((CommandBufferVal*)queueSubmitDesc.commandBuffers, queueSubmitDesc.commandBufferNum);

    var queueSubmitDescImpl = queueSubmitDesc;
    queueSubmitDescImpl.commandBuffers = STACK_ALLOC!<ICommandBuffer>(queueSubmitDesc.commandBufferNum);
    for (uint32 i = 0; i < queueSubmitDesc.commandBufferNum; i++)
        ((ICommandBuffer*)queueSubmitDescImpl.commandBuffers)[i] = NRI_GET_IMPL_PTR!<ICommandBuffer...>((CommandBufferVal)queueSubmitDesc.commandBuffers[i]);

    m_ImplObject.Submit(queueSubmitDescImpl);
}

	public Result WaitForIdle()
{
    return m_ImplObject.WaitForIdle();
}

	public Result ChangeResourceStates(TransitionBarrierDesc transitionBarriers)
{
    BufferTransitionBarrierDesc* bufferTransitionBarriers = STACK_ALLOC!<BufferTransitionBarrierDesc>(transitionBarriers.bufferNum);
    TextureTransitionBarrierDesc* textureTransitionBarriers = STACK_ALLOC!<TextureTransitionBarrierDesc>(transitionBarriers.textureNum);

    for (uint32 i = 0; i < transitionBarriers.bufferNum; i++)
    {
        if (!ValidateTransitionBarrierDesc(m_Device, i, transitionBarriers.buffers[i]))
            return Result.INVALID_ARGUMENT;

        readonly BufferVal bufferVal = (BufferVal)transitionBarriers.buffers[i].buffer;

        bufferTransitionBarriers[i] = transitionBarriers.buffers[i];
        bufferTransitionBarriers[i].buffer = bufferVal.GetImpl();
    }

    for (uint32 i = 0; i < transitionBarriers.textureNum; i++)
    {
        if (!ValidateTransitionBarrierDesc(m_Device, i, transitionBarriers.textures[i]))
            return Result.INVALID_ARGUMENT;

        readonly TextureVal textureVal = (TextureVal)transitionBarriers.textures[i].texture;

        textureTransitionBarriers[i] = transitionBarriers.textures[i];
        textureTransitionBarriers[i].texture = textureVal.GetImpl();
    }

    TransitionBarrierDesc transitionBarriersImpl = transitionBarriers;
    transitionBarriersImpl.buffers = bufferTransitionBarriers;
    transitionBarriersImpl.textures = textureTransitionBarriers;

    return m_ImplObject.ChangeResourceStates(transitionBarriersImpl);
}

	public Result UploadData(TextureUploadDesc* textureUploadDescs, uint32 textureUploadDescNum,
	    BufferUploadDesc* bufferUploadDescs, uint32 bufferUploadDescNum)
	{
	    RETURN_ON_FAILURE!(m_Device.GetLogger(), textureUploadDescNum == 0 || textureUploadDescs != null, Result.INVALID_ARGUMENT,
	        "Can't upload data: 'textureUploadDescs' is invalid.");

	    RETURN_ON_FAILURE!(m_Device.GetLogger(), bufferUploadDescNum == 0 || bufferUploadDescs != null, Result.INVALID_ARGUMENT,
	        "Can't upload data: 'bufferUploadDescs' is invalid.");

	    TextureUploadDesc* textureUploadDescsImpl = STACK_ALLOC!<TextureUploadDesc>(textureUploadDescNum);

	    for (uint32 i = 0; i < textureUploadDescNum; i++)
	    {
	        if (!ValidateTextureUploadDesc(m_Device, i, textureUploadDescs[i]))
	            return Result.INVALID_ARGUMENT;

	        readonly TextureVal textureVal = (TextureVal)textureUploadDescs[i].texture;

	        textureUploadDescsImpl[i] = textureUploadDescs[i];
	        textureUploadDescsImpl[i].texture = textureVal.GetImpl();
	    }

	    BufferUploadDesc* bufferUploadDescsImpl = STACK_ALLOC!<BufferUploadDesc>(bufferUploadDescNum);

	    for (uint32 i = 0; i < bufferUploadDescNum; i++)
	    {
	        if (!ValidateBufferUploadDesc(m_Device, i, bufferUploadDescs[i]))
	            return Result.INVALID_ARGUMENT;

	        readonly BufferVal bufferVal = (BufferVal)bufferUploadDescs[i].buffer;

	        bufferUploadDescsImpl[i] = bufferUploadDescs[i];
	        bufferUploadDescsImpl[i].buffer = bufferVal.GetImpl();
	    }

	    return m_ImplObject.UploadData(textureUploadDescsImpl, textureUploadDescNum, bufferUploadDescsImpl, bufferUploadDescNum);
	}
	
	private void ProcessValidationCommands(CommandBufferVal* commandBuffers, uint32 commandBufferNum)
{
    m_Device.GetMonitor().Enter();
	defer m_Device.GetMonitor().Exit();

    

    readonly ProcessValidationCommandMethod[?] table = .(
        => ProcessValidationCommandBeginQuery, // ValidationCommandType.BEGIN_QUERY
        => ProcessValidationCommandEndQuery,   // ValidationCommandType.END_QUERY
        => ProcessValidationCommandResetQuery  // ValidationCommandType.RESET_QUERY
    );

    for (uint i = 0; i < commandBufferNum; i++)
    {
        readonly List<uint8> buffer = commandBuffers[i].GetValidationCommands();
        /*readonly*/ uint8* begin = buffer.Ptr;
        readonly uint8* end = buffer.Ptr + buffer.Count;

        while (begin != end)
        {
            readonly ValidationCommandType type = *(ValidationCommandType*)begin;

            if (type == ValidationCommandType.NONE || type >= ValidationCommandType.MAX_NUM)
            {
                REPORT_ERROR(m_Device.GetLogger(), "Invalid validation command: {0}", (uint32)type);
                break;
            }

            readonly ProcessValidationCommandMethod method = table[(uint)type - 1];
            method(this, ref begin, end);
        }
    }
}

	private void ProcessValidationCommandBeginQuery(ref uint8* begin, uint8* end)
{
    readonly ValidationCommandUseQuery* command = ReadCommand<ValidationCommandUseQuery>(ref begin, end);
    CHECK(m_Device.GetLogger(), command != null, "ProcessValidationCommandBeginQuery() failed: can't parse command.");
    CHECK(m_Device.GetLogger(), command.queryPool != null, "ProcessValidationCommandBeginQuery() failed: query pool is invalid.");

    QueryPoolVal queryPool = (QueryPoolVal)command.queryPool;
    readonly bool used = queryPool.SetQueryState(command.queryPoolOffset, true);

    if (used)
    {
        REPORT_ERROR(m_Device.GetLogger(), "Can't begin query: it must be reset before use. (QueryPool='{0}', offset={1})",
            queryPool.GetDebugName().CStr(), command.queryPoolOffset);
    }
}

	private void ProcessValidationCommandEndQuery(ref uint8* begin, uint8* end)
{
    readonly ValidationCommandUseQuery* command = ReadCommand<ValidationCommandUseQuery>(ref begin, end);
    CHECK(m_Device.GetLogger(), command != null, "ProcessValidationCommandEndQuery() failed: can't parse command.");
    CHECK(m_Device.GetLogger(), command.queryPool != null, "ProcessValidationCommandEndQuery() failed: query pool is invalid.");

    QueryPoolVal queryPool = (QueryPoolVal)command.queryPool;
    readonly bool used = queryPool.SetQueryState(command.queryPoolOffset, true);

    if (queryPool.GetQueryType() == QueryType.TIMESTAMP)
    {
        if (used)
        {
            REPORT_ERROR(m_Device.GetLogger(), "Can't end query: it must be reset before use. (QueryPool='{0}', offset={1})",
                queryPool.GetDebugName().CStr(), command.queryPoolOffset);
        }
    }
    else
    {
        if (!used)
        {
            REPORT_ERROR(m_Device.GetLogger(), "Can't end query: it's not in active state. (QueryPool='{0}', offset={1})",
                queryPool.GetDebugName().CStr(), command.queryPoolOffset);
        }
    }
}

	private void ProcessValidationCommandResetQuery(ref uint8* begin, uint8* end)
{
    readonly ValidationCommandResetQuery* command = ReadCommand<ValidationCommandResetQuery>(ref begin, end);
    CHECK(m_Device.GetLogger(), command != null, "ProcessValidationCommandResetQuery() failed: can't parse command.");
    CHECK(m_Device.GetLogger(), command.queryPool != null, "ProcessValidationCommandResetQuery() failed: query pool is invalid.");

    QueryPoolVal queryPool = (QueryPoolVal)command.queryPool;
    queryPool.ResetQueries(command.queryPoolOffset, command.queryNum);
}
}