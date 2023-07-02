using Bulkan;
using System;
namespace Sedulous.RHI.Vulkan;

class FenceVK : IFence
{
	private DeviceVK m_Device;
	private VkSemaphore m_Fence = .Null;

	[Inline] public this(DeviceVK device)
		{ m_Device = device; }
	public ~this()
	{
		if (m_Fence != .Null)
			VulkanNative.vkDestroySemaphore(m_Device, m_Fence, m_Device.GetAllocationCallbacks());
	}

	[Inline] public DeviceVK GetDevice()
		{ return m_Device; }


	public Result Create(uint64 initialValue)
	{
		VkSemaphoreTypeCreateInfo timelineCreateInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_SEMAPHORE_TYPE_CREATE_INFO,
				pNext = null,
				semaphoreType = .VK_SEMAPHORE_TYPE_TIMELINE,
				initialValue = initialValue
			};
		VkSemaphoreCreateInfo createInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_SEMAPHORE_CREATE_INFO,
				pNext = &timelineCreateInfo,
				flags = 0
			};

		VkResult result = VulkanNative.vkCreateSemaphore((VkDevice)m_Device, &createInfo, m_Device.GetAllocationCallbacks(), &m_Fence);

		RETURN_ON_FAILURE!(m_Device.GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't create a semaphore: VulkanNative.vkCreateSemaphore returned {0}.", (int32)result);

		return Result.SUCCESS;
	}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public void SetDebugName(char8* name)
	{
		m_Device.SetDebugNameToTrivialObject(.VK_OBJECT_TYPE_SEMAPHORE, (uint64)m_Fence, name);
	}

	public uint64 GetFenceValue()
	{
		{
			uint64 value = 0;

			VulkanNative.vkGetSemaphoreCounterValue((VkDevice)m_Device, m_Fence, &value);

			return value;
		}
	}

	public void QueueSignal(ICommandQueue commandQueue, uint64 value)
	{
		var value;
		VkTimelineSemaphoreSubmitInfo timelineInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_TIMELINE_SEMAPHORE_SUBMIT_INFO,
				pNext = null,
				waitSemaphoreValueCount = 0,
				pWaitSemaphoreValues = null,
				signalSemaphoreValueCount = 1,
				pSignalSemaphoreValues = &value
			};
		VkSubmitInfo submitInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_SUBMIT_INFO,
				pNext = &timelineInfo,
				waitSemaphoreCount = 0,
				pWaitSemaphores = null,
				pWaitDstStageMask = null,
				commandBufferCount = 0,
				pCommandBuffers = null,
				signalSemaphoreCount = 1,
				pSignalSemaphores = &m_Fence
			};

		VulkanNative.vkQueueSubmit((VkQueue)(CommandQueueVK)commandQueue, 1, &submitInfo, .Null);
	}

	public void QueueWait(ICommandQueue commandQueue, uint64 value)
	{
		var value;
		VkTimelineSemaphoreSubmitInfo timelineInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_TIMELINE_SEMAPHORE_SUBMIT_INFO,
				pNext = null,
				waitSemaphoreValueCount = 1,
				pWaitSemaphoreValues = &value,
				signalSemaphoreValueCount = 0,
				pSignalSemaphoreValues = null
			};
		VkSubmitInfo submitInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_SUBMIT_INFO,
				pNext = &timelineInfo,
				waitSemaphoreCount = 1,
				pWaitSemaphores = &m_Fence,
				pWaitDstStageMask = null,
				commandBufferCount = 0,
				pCommandBuffers = null,
				signalSemaphoreCount = 0,
				pSignalSemaphores = null
			};

		VulkanNative.vkQueueSubmit((VkQueue)(CommandQueueVK)commandQueue, 1, &submitInfo, .Null);
	}

	public void Wait(uint64 value)
	{
		var value;
		VkSemaphoreWaitInfo waitInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_SEMAPHORE_WAIT_INFO,
				pNext = null,
				flags = 0,
				semaphoreCount = 1,
				pSemaphores = &m_Fence,
				pValues = &value
			};

		VulkanNative.vkWaitSemaphores((VkDevice)m_Device, &waitInfo, DEFAULT_TIMEOUT);
	}
}