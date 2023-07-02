using Bulkan;
using System;
using Sedulous.RHI.Helpers;
namespace Sedulous.RHI.Vulkan;

class CommandQueueVK : ICommandQueue
{
    private DeviceVK m_Device;
    private VkQueue m_Handle = .Null;
    private uint32 m_FamilyIndex = (uint32)-1;
    private CommandQueueType m_Type = (CommandQueueType)-1;

	[Inline] public this(DeviceVK device)
	{m_Device = device;}

	[Inline] public this(DeviceVK device, VkQueue queue, uint32 familyIndex, CommandQueueType type)
	{
	    m_Device = device;
	    m_FamilyIndex = familyIndex;
	    m_Type = type;
	    m_Handle = queue;
	}

	[Inline] public static implicit operator VkQueue(Self self)
	{ return self.m_Handle; }

	[Inline] public DeviceVK GetDevice()
	{ return m_Device; }

	[Inline] public uint32 GetFamilyIndex()
	{ return m_FamilyIndex; }

	[Inline] public CommandQueueType GetCommandQueueType()
	{ return m_Type; }

	public Result Create(CommandQueueVulkanDesc commandQueueDesc)
	{
	    m_Handle = (VkQueue)commandQueueDesc.vkQueue;
	    m_FamilyIndex = commandQueueDesc.familyIndex;
	    m_Type = commandQueueDesc.commandQueueType;

	    return Result.SUCCESS;
	}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public void SetDebugName(char8* name)
	{
	    m_Device.SetDebugNameToTrivialObject(.VK_OBJECT_TYPE_QUEUE, (uint64)m_Handle, name);
	}

	public void Submit(QueueSubmitDesc queueSubmitDesc)
	{
	    VkCommandBuffer* commandBuffers = STACK_ALLOC!<VkCommandBuffer>(queueSubmitDesc.commandBufferNum);

	    VkSubmitInfo submission = .(){
	        sType = .VK_STRUCTURE_TYPE_SUBMIT_INFO,
	        pNext = null,
	        waitSemaphoreCount = 0,
	        pWaitSemaphores = null,
	        pWaitDstStageMask = null,
	        commandBufferCount = queueSubmitDesc.commandBufferNum,
	        pCommandBuffers = commandBuffers,
	        signalSemaphoreCount = 0,
	        pSignalSemaphores = null
	    };

	    for (uint32 i = 0; i < queueSubmitDesc.commandBufferNum; i++)
	        *(commandBuffers++) = (CommandBufferVK)queueSubmitDesc.commandBuffers[i];

	    VkDeviceGroupSubmitInfo deviceGroupInfo = .();
	    uint32* commandBufferDeviceMasks = STACK_ALLOC!<uint32>(queueSubmitDesc.commandBufferNum);

	    if (m_Device.GetPhysicalDeviceGroupSize() > 1)
	    {
	        for (uint32 i = 0; i < queueSubmitDesc.commandBufferNum; i++)
	            commandBufferDeviceMasks[i] = 1u << queueSubmitDesc.physicalDeviceIndex;

	        deviceGroupInfo = .(){
	            sType = .VK_STRUCTURE_TYPE_DEVICE_GROUP_SUBMIT_INFO,
	            pNext = null,
	            waitSemaphoreCount = 0,
	            pWaitSemaphoreDeviceIndices = null,
	            commandBufferCount = queueSubmitDesc.commandBufferNum,
	            pCommandBufferDeviceMasks = commandBufferDeviceMasks,
	            signalSemaphoreCount = 0,
	            pSignalSemaphoreDeviceIndices = null
	        };

	        submission.pNext = &deviceGroupInfo;
	    }

	    readonly VkResult result = VulkanNative.vkQueueSubmit(m_Handle, 1, &submission, .Null);

	    RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, void(),
	        "Can't submit work to a command queue: vkQueueSubmit returned {0}.", (int32)result);
	}

	public Result ChangeResourceStates(TransitionBarrierDesc transitionBarriers)
	{
	    ResourceStateChangeHelper resourceStateChange = scope .(m_Device, (ICommandQueue)this);

	    return resourceStateChange.ChangeStates(transitionBarriers);
	}

	public Result UploadData(TextureUploadDesc* textureUploadDescs, uint32 textureUploadDescNum,
	    BufferUploadDesc* bufferUploadDescs, uint32 bufferUploadDescNum)
	{
	    DataUploadHelper helperDataUpload = scope .(m_Device, m_Device.GetAllocator(), (ICommandQueue)this);

	    return helperDataUpload.UploadData(textureUploadDescs, textureUploadDescNum, bufferUploadDescs, bufferUploadDescNum);
	}

	public Result WaitForIdle()
	{
	    VkResult result = VulkanNative.vkQueueWaitIdle(m_Handle);

	    RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
	        "Can't wait for idle: vkQueueWaitIdle returned {0}.", (int32)result);

	    return Result.SUCCESS;
	}
}