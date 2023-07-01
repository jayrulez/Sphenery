using System;
using System.Collections;
using internal Bulkan;
namespace Bulkan;

public extension VulkanNative
{
	public typealias vkCreateInstanceFunction = function VkResult(VkInstanceCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkInstance* pInstance);
	private static vkCreateInstanceFunction vkCreateInstance_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateInstance(VkInstanceCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkInstance* pInstance)
		=> vkCreateInstance_ptr(pCreateInfo, pAllocator, pInstance);

	public typealias vkDestroyInstanceFunction = function void(VkInstance instance, VkAllocationCallbacks* pAllocator);
	private static vkDestroyInstanceFunction vkDestroyInstance_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyInstance(VkInstance instance, VkAllocationCallbacks* pAllocator)
		=> vkDestroyInstance_ptr(instance, pAllocator);

	public typealias vkEnumeratePhysicalDevicesFunction = function VkResult(VkInstance instance, uint32* pPhysicalDeviceCount, VkPhysicalDevice* pPhysicalDevices);
	private static vkEnumeratePhysicalDevicesFunction vkEnumeratePhysicalDevices_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEnumeratePhysicalDevices(VkInstance instance, uint32* pPhysicalDeviceCount, VkPhysicalDevice* pPhysicalDevices)
		=> vkEnumeratePhysicalDevices_ptr(instance, pPhysicalDeviceCount, pPhysicalDevices);

	public typealias vkGetPhysicalDeviceFeaturesFunction = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceFeatures* pFeatures);
	private static vkGetPhysicalDeviceFeaturesFunction vkGetPhysicalDeviceFeatures_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceFeatures(VkPhysicalDevice physicalDevice, VkPhysicalDeviceFeatures* pFeatures)
		=> vkGetPhysicalDeviceFeatures_ptr(physicalDevice, pFeatures);

	public typealias vkGetPhysicalDeviceFormatPropertiesFunction = function void(VkPhysicalDevice physicalDevice, VkFormat format, VkFormatProperties* pFormatProperties);
	private static vkGetPhysicalDeviceFormatPropertiesFunction vkGetPhysicalDeviceFormatProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceFormatProperties(VkPhysicalDevice physicalDevice, VkFormat format, VkFormatProperties* pFormatProperties)
		=> vkGetPhysicalDeviceFormatProperties_ptr(physicalDevice, format, pFormatProperties);

	public typealias vkGetPhysicalDeviceImageFormatPropertiesFunction = function VkResult(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkImageTiling tiling, VkImageUsageFlags usage, VkImageCreateFlags flags, VkImageFormatProperties* pImageFormatProperties);
	private static vkGetPhysicalDeviceImageFormatPropertiesFunction vkGetPhysicalDeviceImageFormatProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceImageFormatProperties(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkImageTiling tiling, VkImageUsageFlags usage, VkImageCreateFlags flags, VkImageFormatProperties* pImageFormatProperties)
		=> vkGetPhysicalDeviceImageFormatProperties_ptr(physicalDevice, format, type, tiling, usage, flags, pImageFormatProperties);

	public typealias vkGetPhysicalDevicePropertiesFunction = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceProperties* pProperties);
	private static vkGetPhysicalDevicePropertiesFunction vkGetPhysicalDeviceProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceProperties(VkPhysicalDevice physicalDevice, VkPhysicalDeviceProperties* pProperties)
		=> vkGetPhysicalDeviceProperties_ptr(physicalDevice, pProperties);

	public typealias vkGetPhysicalDeviceQueueFamilyPropertiesFunction = function void(VkPhysicalDevice physicalDevice, uint32* pQueueFamilyPropertyCount, VkQueueFamilyProperties* pQueueFamilyProperties);
	private static vkGetPhysicalDeviceQueueFamilyPropertiesFunction vkGetPhysicalDeviceQueueFamilyProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceQueueFamilyProperties(VkPhysicalDevice physicalDevice, uint32* pQueueFamilyPropertyCount, VkQueueFamilyProperties* pQueueFamilyProperties)
		=> vkGetPhysicalDeviceQueueFamilyProperties_ptr(physicalDevice, pQueueFamilyPropertyCount, pQueueFamilyProperties);

	public typealias vkGetPhysicalDeviceMemoryPropertiesFunction = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceMemoryProperties* pMemoryProperties);
	private static vkGetPhysicalDeviceMemoryPropertiesFunction vkGetPhysicalDeviceMemoryProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceMemoryProperties(VkPhysicalDevice physicalDevice, VkPhysicalDeviceMemoryProperties* pMemoryProperties)
		=> vkGetPhysicalDeviceMemoryProperties_ptr(physicalDevice, pMemoryProperties);

	public typealias vkGetInstanceProcAddrFunction = function void*(VkInstance instance, char8* pName);
	private static vkGetInstanceProcAddrFunction vkGetInstanceProcAddr_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void* vkGetInstanceProcAddr(VkInstance instance, char8* pName)
		=> vkGetInstanceProcAddr_ptr(instance, pName);

	public typealias vkGetDeviceProcAddrFunction = function void*(VkDevice device, char8* pName);
	private static vkGetDeviceProcAddrFunction vkGetDeviceProcAddr_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void* vkGetDeviceProcAddr(VkDevice device, char8* pName)
		=> vkGetDeviceProcAddr_ptr(device, pName);

	public typealias vkCreateDeviceFunction = function VkResult(VkPhysicalDevice physicalDevice, VkDeviceCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDevice* pDevice);
	private static vkCreateDeviceFunction vkCreateDevice_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDevice(VkPhysicalDevice physicalDevice, VkDeviceCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDevice* pDevice)
		=> vkCreateDevice_ptr(physicalDevice, pCreateInfo, pAllocator, pDevice);

	public typealias vkDestroyDeviceFunction = function void(VkDevice device, VkAllocationCallbacks* pAllocator);
	private static vkDestroyDeviceFunction vkDestroyDevice_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyDevice(VkDevice device, VkAllocationCallbacks* pAllocator)
		=> vkDestroyDevice_ptr(device, pAllocator);

	public typealias vkEnumerateInstanceExtensionPropertiesFunction = function VkResult(char8* pLayerName, uint32* pPropertyCount, VkExtensionProperties* pProperties);
	private static vkEnumerateInstanceExtensionPropertiesFunction vkEnumerateInstanceExtensionProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEnumerateInstanceExtensionProperties(char8* pLayerName, uint32* pPropertyCount, VkExtensionProperties* pProperties)
		=> vkEnumerateInstanceExtensionProperties_ptr(pLayerName, pPropertyCount, pProperties);

	public typealias vkEnumerateDeviceExtensionPropertiesFunction = function VkResult(VkPhysicalDevice physicalDevice, char8* pLayerName, uint32* pPropertyCount, VkExtensionProperties* pProperties);
	private static vkEnumerateDeviceExtensionPropertiesFunction vkEnumerateDeviceExtensionProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEnumerateDeviceExtensionProperties(VkPhysicalDevice physicalDevice, char8* pLayerName, uint32* pPropertyCount, VkExtensionProperties* pProperties)
		=> vkEnumerateDeviceExtensionProperties_ptr(physicalDevice, pLayerName, pPropertyCount, pProperties);

	public typealias vkEnumerateInstanceLayerPropertiesFunction = function VkResult(uint32* pPropertyCount, VkLayerProperties* pProperties);
	private static vkEnumerateInstanceLayerPropertiesFunction vkEnumerateInstanceLayerProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEnumerateInstanceLayerProperties(uint32* pPropertyCount, VkLayerProperties* pProperties)
		=> vkEnumerateInstanceLayerProperties_ptr(pPropertyCount, pProperties);

	public typealias vkEnumerateDeviceLayerPropertiesFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkLayerProperties* pProperties);
	private static vkEnumerateDeviceLayerPropertiesFunction vkEnumerateDeviceLayerProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEnumerateDeviceLayerProperties(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkLayerProperties* pProperties)
		=> vkEnumerateDeviceLayerProperties_ptr(physicalDevice, pPropertyCount, pProperties);

	public typealias vkGetDeviceQueueFunction = function void(VkDevice device, uint32 queueFamilyIndex, uint32 queueIndex, VkQueue* pQueue);
	private static vkGetDeviceQueueFunction vkGetDeviceQueue_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceQueue(VkDevice device, uint32 queueFamilyIndex, uint32 queueIndex, VkQueue* pQueue)
		=> vkGetDeviceQueue_ptr(device, queueFamilyIndex, queueIndex, pQueue);

	public typealias vkQueueSubmitFunction = function VkResult(VkQueue queue, uint32 submitCount, VkSubmitInfo* pSubmits, VkFence fence);
	private static vkQueueSubmitFunction vkQueueSubmit_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkQueueSubmit(VkQueue queue, uint32 submitCount, VkSubmitInfo* pSubmits, VkFence fence)
		=> vkQueueSubmit_ptr(queue, submitCount, pSubmits, fence);

	public typealias vkQueueWaitIdleFunction = function VkResult(VkQueue queue);
	private static vkQueueWaitIdleFunction vkQueueWaitIdle_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkQueueWaitIdle(VkQueue queue)
		=> vkQueueWaitIdle_ptr(queue);

	public typealias vkDeviceWaitIdleFunction = function VkResult(VkDevice device);
	private static vkDeviceWaitIdleFunction vkDeviceWaitIdle_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkDeviceWaitIdle(VkDevice device)
		=> vkDeviceWaitIdle_ptr(device);

	public typealias vkAllocateMemoryFunction = function VkResult(VkDevice device, VkMemoryAllocateInfo* pAllocateInfo, VkAllocationCallbacks* pAllocator, VkDeviceMemory* pMemory);
	private static vkAllocateMemoryFunction vkAllocateMemory_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAllocateMemory(VkDevice device, VkMemoryAllocateInfo* pAllocateInfo, VkAllocationCallbacks* pAllocator, VkDeviceMemory* pMemory)
		=> vkAllocateMemory_ptr(device, pAllocateInfo, pAllocator, pMemory);

	public typealias vkFreeMemoryFunction = function void(VkDevice device, VkDeviceMemory memory, VkAllocationCallbacks* pAllocator);
	private static vkFreeMemoryFunction vkFreeMemory_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkFreeMemory(VkDevice device, VkDeviceMemory memory, VkAllocationCallbacks* pAllocator)
		=> vkFreeMemory_ptr(device, memory, pAllocator);

	public typealias vkMapMemoryFunction = function VkResult(VkDevice device, VkDeviceMemory memory, uint64 offset, uint64 size, uint32 flags, void** ppData);
	private static vkMapMemoryFunction vkMapMemory_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkMapMemory(VkDevice device, VkDeviceMemory memory, uint64 offset, uint64 size, uint32 flags, void** ppData)
		=> vkMapMemory_ptr(device, memory, offset, size, flags, ppData);

	public typealias vkUnmapMemoryFunction = function void(VkDevice device, VkDeviceMemory memory);
	private static vkUnmapMemoryFunction vkUnmapMemory_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkUnmapMemory(VkDevice device, VkDeviceMemory memory)
		=> vkUnmapMemory_ptr(device, memory);

	public typealias vkFlushMappedMemoryRangesFunction = function VkResult(VkDevice device, uint32 memoryRangeCount, VkMappedMemoryRange* pMemoryRanges);
	private static vkFlushMappedMemoryRangesFunction vkFlushMappedMemoryRanges_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkFlushMappedMemoryRanges(VkDevice device, uint32 memoryRangeCount, VkMappedMemoryRange* pMemoryRanges)
		=> vkFlushMappedMemoryRanges_ptr(device, memoryRangeCount, pMemoryRanges);

	public typealias vkInvalidateMappedMemoryRangesFunction = function VkResult(VkDevice device, uint32 memoryRangeCount, VkMappedMemoryRange* pMemoryRanges);
	private static vkInvalidateMappedMemoryRangesFunction vkInvalidateMappedMemoryRanges_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkInvalidateMappedMemoryRanges(VkDevice device, uint32 memoryRangeCount, VkMappedMemoryRange* pMemoryRanges)
		=> vkInvalidateMappedMemoryRanges_ptr(device, memoryRangeCount, pMemoryRanges);

	public typealias vkGetDeviceMemoryCommitmentFunction = function void(VkDevice device, VkDeviceMemory memory, uint64* pCommittedMemoryInBytes);
	private static vkGetDeviceMemoryCommitmentFunction vkGetDeviceMemoryCommitment_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceMemoryCommitment(VkDevice device, VkDeviceMemory memory, uint64* pCommittedMemoryInBytes)
		=> vkGetDeviceMemoryCommitment_ptr(device, memory, pCommittedMemoryInBytes);

	public typealias vkBindBufferMemoryFunction = function VkResult(VkDevice device, VkBuffer buffer, VkDeviceMemory memory, uint64 memoryOffset);
	private static vkBindBufferMemoryFunction vkBindBufferMemory_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBindBufferMemory(VkDevice device, VkBuffer buffer, VkDeviceMemory memory, uint64 memoryOffset)
		=> vkBindBufferMemory_ptr(device, buffer, memory, memoryOffset);

	public typealias vkBindImageMemoryFunction = function VkResult(VkDevice device, VkImage image, VkDeviceMemory memory, uint64 memoryOffset);
	private static vkBindImageMemoryFunction vkBindImageMemory_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBindImageMemory(VkDevice device, VkImage image, VkDeviceMemory memory, uint64 memoryOffset)
		=> vkBindImageMemory_ptr(device, image, memory, memoryOffset);

	public typealias vkGetBufferMemoryRequirementsFunction = function void(VkDevice device, VkBuffer buffer, VkMemoryRequirements* pMemoryRequirements);
	private static vkGetBufferMemoryRequirementsFunction vkGetBufferMemoryRequirements_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetBufferMemoryRequirements(VkDevice device, VkBuffer buffer, VkMemoryRequirements* pMemoryRequirements)
		=> vkGetBufferMemoryRequirements_ptr(device, buffer, pMemoryRequirements);

	public typealias vkGetImageMemoryRequirementsFunction = function void(VkDevice device, VkImage image, VkMemoryRequirements* pMemoryRequirements);
	private static vkGetImageMemoryRequirementsFunction vkGetImageMemoryRequirements_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetImageMemoryRequirements(VkDevice device, VkImage image, VkMemoryRequirements* pMemoryRequirements)
		=> vkGetImageMemoryRequirements_ptr(device, image, pMemoryRequirements);

	public typealias vkGetImageSparseMemoryRequirementsFunction = function void(VkDevice device, VkImage image, uint32* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements* pSparseMemoryRequirements);
	private static vkGetImageSparseMemoryRequirementsFunction vkGetImageSparseMemoryRequirements_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetImageSparseMemoryRequirements(VkDevice device, VkImage image, uint32* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements* pSparseMemoryRequirements)
		=> vkGetImageSparseMemoryRequirements_ptr(device, image, pSparseMemoryRequirementCount, pSparseMemoryRequirements);

	public typealias vkGetPhysicalDeviceSparseImageFormatPropertiesFunction = function void(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkSampleCountFlags samples, VkImageUsageFlags usage, VkImageTiling tiling, uint32* pPropertyCount, VkSparseImageFormatProperties* pProperties);
	private static vkGetPhysicalDeviceSparseImageFormatPropertiesFunction vkGetPhysicalDeviceSparseImageFormatProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceSparseImageFormatProperties(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkSampleCountFlags samples, VkImageUsageFlags usage, VkImageTiling tiling, uint32* pPropertyCount, VkSparseImageFormatProperties* pProperties)
		=> vkGetPhysicalDeviceSparseImageFormatProperties_ptr(physicalDevice, format, type, samples, usage, tiling, pPropertyCount, pProperties);

	public typealias vkQueueBindSparseFunction = function VkResult(VkQueue queue, uint32 bindInfoCount, VkBindSparseInfo* pBindInfo, VkFence fence);
	private static vkQueueBindSparseFunction vkQueueBindSparse_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkQueueBindSparse(VkQueue queue, uint32 bindInfoCount, VkBindSparseInfo* pBindInfo, VkFence fence)
		=> vkQueueBindSparse_ptr(queue, bindInfoCount, pBindInfo, fence);

	public typealias vkCreateFenceFunction = function VkResult(VkDevice device, VkFenceCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkFence* pFence);
	private static vkCreateFenceFunction vkCreateFence_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateFence(VkDevice device, VkFenceCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkFence* pFence)
		=> vkCreateFence_ptr(device, pCreateInfo, pAllocator, pFence);

	public typealias vkDestroyFenceFunction = function void(VkDevice device, VkFence fence, VkAllocationCallbacks* pAllocator);
	private static vkDestroyFenceFunction vkDestroyFence_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyFence(VkDevice device, VkFence fence, VkAllocationCallbacks* pAllocator)
		=> vkDestroyFence_ptr(device, fence, pAllocator);

	public typealias vkResetFencesFunction = function VkResult(VkDevice device, uint32 fenceCount, VkFence* pFences);
	private static vkResetFencesFunction vkResetFences_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkResetFences(VkDevice device, uint32 fenceCount, VkFence* pFences)
		=> vkResetFences_ptr(device, fenceCount, pFences);

	public typealias vkGetFenceStatusFunction = function VkResult(VkDevice device, VkFence fence);
	private static vkGetFenceStatusFunction vkGetFenceStatus_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetFenceStatus(VkDevice device, VkFence fence)
		=> vkGetFenceStatus_ptr(device, fence);

	public typealias vkWaitForFencesFunction = function VkResult(VkDevice device, uint32 fenceCount, VkFence* pFences, VkBool32 waitAll, uint64 timeout);
	private static vkWaitForFencesFunction vkWaitForFences_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkWaitForFences(VkDevice device, uint32 fenceCount, VkFence* pFences, VkBool32 waitAll, uint64 timeout)
		=> vkWaitForFences_ptr(device, fenceCount, pFences, waitAll, timeout);

	public typealias vkCreateSemaphoreFunction = function VkResult(VkDevice device, VkSemaphoreCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSemaphore* pSemaphore);
	private static vkCreateSemaphoreFunction vkCreateSemaphore_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateSemaphore(VkDevice device, VkSemaphoreCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSemaphore* pSemaphore)
		=> vkCreateSemaphore_ptr(device, pCreateInfo, pAllocator, pSemaphore);

	public typealias vkDestroySemaphoreFunction = function void(VkDevice device, VkSemaphore semaphore, VkAllocationCallbacks* pAllocator);
	private static vkDestroySemaphoreFunction vkDestroySemaphore_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroySemaphore(VkDevice device, VkSemaphore semaphore, VkAllocationCallbacks* pAllocator)
		=> vkDestroySemaphore_ptr(device, semaphore, pAllocator);

	public typealias vkCreateEventFunction = function VkResult(VkDevice device, VkEventCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkEvent* pEvent);
	private static vkCreateEventFunction vkCreateEvent_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateEvent(VkDevice device, VkEventCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkEvent* pEvent)
		=> vkCreateEvent_ptr(device, pCreateInfo, pAllocator, pEvent);

	public typealias vkDestroyEventFunction = function void(VkDevice device, VkEvent event, VkAllocationCallbacks* pAllocator);
	private static vkDestroyEventFunction vkDestroyEvent_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyEvent(VkDevice device, VkEvent event, VkAllocationCallbacks* pAllocator)
		=> vkDestroyEvent_ptr(device, event, pAllocator);

	public typealias vkGetEventStatusFunction = function VkResult(VkDevice device, VkEvent event);
	private static vkGetEventStatusFunction vkGetEventStatus_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetEventStatus(VkDevice device, VkEvent event)
		=> vkGetEventStatus_ptr(device, event);

	public typealias vkSetEventFunction = function VkResult(VkDevice device, VkEvent event);
	private static vkSetEventFunction vkSetEvent_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkSetEvent(VkDevice device, VkEvent event)
		=> vkSetEvent_ptr(device, event);

	public typealias vkResetEventFunction = function VkResult(VkDevice device, VkEvent event);
	private static vkResetEventFunction vkResetEvent_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkResetEvent(VkDevice device, VkEvent event)
		=> vkResetEvent_ptr(device, event);

	public typealias vkCreateQueryPoolFunction = function VkResult(VkDevice device, VkQueryPoolCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkQueryPool* pQueryPool);
	private static vkCreateQueryPoolFunction vkCreateQueryPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateQueryPool(VkDevice device, VkQueryPoolCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkQueryPool* pQueryPool)
		=> vkCreateQueryPool_ptr(device, pCreateInfo, pAllocator, pQueryPool);

	public typealias vkDestroyQueryPoolFunction = function void(VkDevice device, VkQueryPool queryPool, VkAllocationCallbacks* pAllocator);
	private static vkDestroyQueryPoolFunction vkDestroyQueryPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyQueryPool(VkDevice device, VkQueryPool queryPool, VkAllocationCallbacks* pAllocator)
		=> vkDestroyQueryPool_ptr(device, queryPool, pAllocator);

	public typealias vkGetQueryPoolResultsFunction = function VkResult(VkDevice device, VkQueryPool queryPool, uint32 firstQuery, uint32 queryCount, uint dataSize, void* pData, uint64 stride, VkQueryResultFlags flags);
	private static vkGetQueryPoolResultsFunction vkGetQueryPoolResults_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetQueryPoolResults(VkDevice device, VkQueryPool queryPool, uint32 firstQuery, uint32 queryCount, uint dataSize, void* pData, uint64 stride, VkQueryResultFlags flags)
		=> vkGetQueryPoolResults_ptr(device, queryPool, firstQuery, queryCount, dataSize, pData, stride, flags);

	public typealias vkCreateBufferFunction = function VkResult(VkDevice device, VkBufferCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkBuffer* pBuffer);
	private static vkCreateBufferFunction vkCreateBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateBuffer(VkDevice device, VkBufferCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkBuffer* pBuffer)
		=> vkCreateBuffer_ptr(device, pCreateInfo, pAllocator, pBuffer);

	public typealias vkDestroyBufferFunction = function void(VkDevice device, VkBuffer buffer, VkAllocationCallbacks* pAllocator);
	private static vkDestroyBufferFunction vkDestroyBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyBuffer(VkDevice device, VkBuffer buffer, VkAllocationCallbacks* pAllocator)
		=> vkDestroyBuffer_ptr(device, buffer, pAllocator);

	public typealias vkCreateBufferViewFunction = function VkResult(VkDevice device, VkBufferViewCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkBufferView* pView);
	private static vkCreateBufferViewFunction vkCreateBufferView_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateBufferView(VkDevice device, VkBufferViewCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkBufferView* pView)
		=> vkCreateBufferView_ptr(device, pCreateInfo, pAllocator, pView);

	public typealias vkDestroyBufferViewFunction = function void(VkDevice device, VkBufferView bufferView, VkAllocationCallbacks* pAllocator);
	private static vkDestroyBufferViewFunction vkDestroyBufferView_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyBufferView(VkDevice device, VkBufferView bufferView, VkAllocationCallbacks* pAllocator)
		=> vkDestroyBufferView_ptr(device, bufferView, pAllocator);

	public typealias vkCreateImageFunction = function VkResult(VkDevice device, VkImageCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkImage* pImage);
	private static vkCreateImageFunction vkCreateImage_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateImage(VkDevice device, VkImageCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkImage* pImage)
		=> vkCreateImage_ptr(device, pCreateInfo, pAllocator, pImage);

	public typealias vkDestroyImageFunction = function void(VkDevice device, VkImage image, VkAllocationCallbacks* pAllocator);
	private static vkDestroyImageFunction vkDestroyImage_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyImage(VkDevice device, VkImage image, VkAllocationCallbacks* pAllocator)
		=> vkDestroyImage_ptr(device, image, pAllocator);

	public typealias vkGetImageSubresourceLayoutFunction = function void(VkDevice device, VkImage image, VkImageSubresource* pSubresource, VkSubresourceLayout* pLayout);
	private static vkGetImageSubresourceLayoutFunction vkGetImageSubresourceLayout_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetImageSubresourceLayout(VkDevice device, VkImage image, VkImageSubresource* pSubresource, VkSubresourceLayout* pLayout)
		=> vkGetImageSubresourceLayout_ptr(device, image, pSubresource, pLayout);

	public typealias vkCreateImageViewFunction = function VkResult(VkDevice device, VkImageViewCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkImageView* pView);
	private static vkCreateImageViewFunction vkCreateImageView_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateImageView(VkDevice device, VkImageViewCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkImageView* pView)
		=> vkCreateImageView_ptr(device, pCreateInfo, pAllocator, pView);

	public typealias vkDestroyImageViewFunction = function void(VkDevice device, VkImageView imageView, VkAllocationCallbacks* pAllocator);
	private static vkDestroyImageViewFunction vkDestroyImageView_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyImageView(VkDevice device, VkImageView imageView, VkAllocationCallbacks* pAllocator)
		=> vkDestroyImageView_ptr(device, imageView, pAllocator);

	public typealias vkCreateShaderModuleFunction = function VkResult(VkDevice device, VkShaderModuleCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkShaderModule* pShaderModule);
	private static vkCreateShaderModuleFunction vkCreateShaderModule_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateShaderModule(VkDevice device, VkShaderModuleCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkShaderModule* pShaderModule)
		=> vkCreateShaderModule_ptr(device, pCreateInfo, pAllocator, pShaderModule);

	public typealias vkDestroyShaderModuleFunction = function void(VkDevice device, VkShaderModule shaderModule, VkAllocationCallbacks* pAllocator);
	private static vkDestroyShaderModuleFunction vkDestroyShaderModule_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyShaderModule(VkDevice device, VkShaderModule shaderModule, VkAllocationCallbacks* pAllocator)
		=> vkDestroyShaderModule_ptr(device, shaderModule, pAllocator);

	public typealias vkCreatePipelineCacheFunction = function VkResult(VkDevice device, VkPipelineCacheCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkPipelineCache* pPipelineCache);
	private static vkCreatePipelineCacheFunction vkCreatePipelineCache_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreatePipelineCache(VkDevice device, VkPipelineCacheCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkPipelineCache* pPipelineCache)
		=> vkCreatePipelineCache_ptr(device, pCreateInfo, pAllocator, pPipelineCache);

	public typealias vkDestroyPipelineCacheFunction = function void(VkDevice device, VkPipelineCache pipelineCache, VkAllocationCallbacks* pAllocator);
	private static vkDestroyPipelineCacheFunction vkDestroyPipelineCache_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyPipelineCache(VkDevice device, VkPipelineCache pipelineCache, VkAllocationCallbacks* pAllocator)
		=> vkDestroyPipelineCache_ptr(device, pipelineCache, pAllocator);

	public typealias vkGetPipelineCacheDataFunction = function VkResult(VkDevice device, VkPipelineCache pipelineCache, uint* pDataSize, void* pData);
	private static vkGetPipelineCacheDataFunction vkGetPipelineCacheData_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPipelineCacheData(VkDevice device, VkPipelineCache pipelineCache, uint* pDataSize, void* pData)
		=> vkGetPipelineCacheData_ptr(device, pipelineCache, pDataSize, pData);

	public typealias vkMergePipelineCachesFunction = function VkResult(VkDevice device, VkPipelineCache dstCache, uint32 srcCacheCount, VkPipelineCache* pSrcCaches);
	private static vkMergePipelineCachesFunction vkMergePipelineCaches_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkMergePipelineCaches(VkDevice device, VkPipelineCache dstCache, uint32 srcCacheCount, VkPipelineCache* pSrcCaches)
		=> vkMergePipelineCaches_ptr(device, dstCache, srcCacheCount, pSrcCaches);

	public typealias vkCreateGraphicsPipelinesFunction = function VkResult(VkDevice device, VkPipelineCache pipelineCache, uint32 createInfoCount, VkGraphicsPipelineCreateInfo* pCreateInfos, VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines);
	private static vkCreateGraphicsPipelinesFunction vkCreateGraphicsPipelines_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateGraphicsPipelines(VkDevice device, VkPipelineCache pipelineCache, uint32 createInfoCount, VkGraphicsPipelineCreateInfo* pCreateInfos, VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines)
		=> vkCreateGraphicsPipelines_ptr(device, pipelineCache, createInfoCount, pCreateInfos, pAllocator, pPipelines);

	public typealias vkCreateComputePipelinesFunction = function VkResult(VkDevice device, VkPipelineCache pipelineCache, uint32 createInfoCount, VkComputePipelineCreateInfo* pCreateInfos, VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines);
	private static vkCreateComputePipelinesFunction vkCreateComputePipelines_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateComputePipelines(VkDevice device, VkPipelineCache pipelineCache, uint32 createInfoCount, VkComputePipelineCreateInfo* pCreateInfos, VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines)
		=> vkCreateComputePipelines_ptr(device, pipelineCache, createInfoCount, pCreateInfos, pAllocator, pPipelines);

	public typealias vkDestroyPipelineFunction = function void(VkDevice device, VkPipeline pipeline, VkAllocationCallbacks* pAllocator);
	private static vkDestroyPipelineFunction vkDestroyPipeline_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyPipeline(VkDevice device, VkPipeline pipeline, VkAllocationCallbacks* pAllocator)
		=> vkDestroyPipeline_ptr(device, pipeline, pAllocator);

	public typealias vkCreatePipelineLayoutFunction = function VkResult(VkDevice device, VkPipelineLayoutCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkPipelineLayout* pPipelineLayout);
	private static vkCreatePipelineLayoutFunction vkCreatePipelineLayout_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreatePipelineLayout(VkDevice device, VkPipelineLayoutCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkPipelineLayout* pPipelineLayout)
		=> vkCreatePipelineLayout_ptr(device, pCreateInfo, pAllocator, pPipelineLayout);

	public typealias vkDestroyPipelineLayoutFunction = function void(VkDevice device, VkPipelineLayout pipelineLayout, VkAllocationCallbacks* pAllocator);
	private static vkDestroyPipelineLayoutFunction vkDestroyPipelineLayout_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyPipelineLayout(VkDevice device, VkPipelineLayout pipelineLayout, VkAllocationCallbacks* pAllocator)
		=> vkDestroyPipelineLayout_ptr(device, pipelineLayout, pAllocator);

	public typealias vkCreateSamplerFunction = function VkResult(VkDevice device, VkSamplerCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSampler* pSampler);
	private static vkCreateSamplerFunction vkCreateSampler_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateSampler(VkDevice device, VkSamplerCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSampler* pSampler)
		=> vkCreateSampler_ptr(device, pCreateInfo, pAllocator, pSampler);

	public typealias vkDestroySamplerFunction = function void(VkDevice device, VkSampler sampler, VkAllocationCallbacks* pAllocator);
	private static vkDestroySamplerFunction vkDestroySampler_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroySampler(VkDevice device, VkSampler sampler, VkAllocationCallbacks* pAllocator)
		=> vkDestroySampler_ptr(device, sampler, pAllocator);

	public typealias vkCreateDescriptorSetLayoutFunction = function VkResult(VkDevice device, VkDescriptorSetLayoutCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDescriptorSetLayout* pSetLayout);
	private static vkCreateDescriptorSetLayoutFunction vkCreateDescriptorSetLayout_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDescriptorSetLayout(VkDevice device, VkDescriptorSetLayoutCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDescriptorSetLayout* pSetLayout)
		=> vkCreateDescriptorSetLayout_ptr(device, pCreateInfo, pAllocator, pSetLayout);

	public typealias vkDestroyDescriptorSetLayoutFunction = function void(VkDevice device, VkDescriptorSetLayout descriptorSetLayout, VkAllocationCallbacks* pAllocator);
	private static vkDestroyDescriptorSetLayoutFunction vkDestroyDescriptorSetLayout_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyDescriptorSetLayout(VkDevice device, VkDescriptorSetLayout descriptorSetLayout, VkAllocationCallbacks* pAllocator)
		=> vkDestroyDescriptorSetLayout_ptr(device, descriptorSetLayout, pAllocator);

	public typealias vkCreateDescriptorPoolFunction = function VkResult(VkDevice device, VkDescriptorPoolCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDescriptorPool* pDescriptorPool);
	private static vkCreateDescriptorPoolFunction vkCreateDescriptorPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDescriptorPool(VkDevice device, VkDescriptorPoolCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDescriptorPool* pDescriptorPool)
		=> vkCreateDescriptorPool_ptr(device, pCreateInfo, pAllocator, pDescriptorPool);

	public typealias vkDestroyDescriptorPoolFunction = function void(VkDevice device, VkDescriptorPool descriptorPool, VkAllocationCallbacks* pAllocator);
	private static vkDestroyDescriptorPoolFunction vkDestroyDescriptorPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyDescriptorPool(VkDevice device, VkDescriptorPool descriptorPool, VkAllocationCallbacks* pAllocator)
		=> vkDestroyDescriptorPool_ptr(device, descriptorPool, pAllocator);

	public typealias vkResetDescriptorPoolFunction = function VkResult(VkDevice device, VkDescriptorPool descriptorPool, uint32 flags);
	private static vkResetDescriptorPoolFunction vkResetDescriptorPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkResetDescriptorPool(VkDevice device, VkDescriptorPool descriptorPool, uint32 flags)
		=> vkResetDescriptorPool_ptr(device, descriptorPool, flags);

	public typealias vkAllocateDescriptorSetsFunction = function VkResult(VkDevice device, VkDescriptorSetAllocateInfo* pAllocateInfo, VkDescriptorSet* pDescriptorSets);
	private static vkAllocateDescriptorSetsFunction vkAllocateDescriptorSets_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAllocateDescriptorSets(VkDevice device, VkDescriptorSetAllocateInfo* pAllocateInfo, VkDescriptorSet* pDescriptorSets)
		=> vkAllocateDescriptorSets_ptr(device, pAllocateInfo, pDescriptorSets);

	public typealias vkFreeDescriptorSetsFunction = function VkResult(VkDevice device, VkDescriptorPool descriptorPool, uint32 descriptorSetCount, VkDescriptorSet* pDescriptorSets);
	private static vkFreeDescriptorSetsFunction vkFreeDescriptorSets_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkFreeDescriptorSets(VkDevice device, VkDescriptorPool descriptorPool, uint32 descriptorSetCount, VkDescriptorSet* pDescriptorSets)
		=> vkFreeDescriptorSets_ptr(device, descriptorPool, descriptorSetCount, pDescriptorSets);

	public typealias vkUpdateDescriptorSetsFunction = function void(VkDevice device, uint32 descriptorWriteCount, VkWriteDescriptorSet* pDescriptorWrites, uint32 descriptorCopyCount, VkCopyDescriptorSet* pDescriptorCopies);
	private static vkUpdateDescriptorSetsFunction vkUpdateDescriptorSets_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkUpdateDescriptorSets(VkDevice device, uint32 descriptorWriteCount, VkWriteDescriptorSet* pDescriptorWrites, uint32 descriptorCopyCount, VkCopyDescriptorSet* pDescriptorCopies)
		=> vkUpdateDescriptorSets_ptr(device, descriptorWriteCount, pDescriptorWrites, descriptorCopyCount, pDescriptorCopies);

	public typealias vkCreateFramebufferFunction = function VkResult(VkDevice device, VkFramebufferCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkFramebuffer* pFramebuffer);
	private static vkCreateFramebufferFunction vkCreateFramebuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateFramebuffer(VkDevice device, VkFramebufferCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkFramebuffer* pFramebuffer)
		=> vkCreateFramebuffer_ptr(device, pCreateInfo, pAllocator, pFramebuffer);

	public typealias vkDestroyFramebufferFunction = function void(VkDevice device, VkFramebuffer framebuffer, VkAllocationCallbacks* pAllocator);
	private static vkDestroyFramebufferFunction vkDestroyFramebuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyFramebuffer(VkDevice device, VkFramebuffer framebuffer, VkAllocationCallbacks* pAllocator)
		=> vkDestroyFramebuffer_ptr(device, framebuffer, pAllocator);

	public typealias vkCreateRenderPassFunction = function VkResult(VkDevice device, VkRenderPassCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkRenderPass* pRenderPass);
	private static vkCreateRenderPassFunction vkCreateRenderPass_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateRenderPass(VkDevice device, VkRenderPassCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkRenderPass* pRenderPass)
		=> vkCreateRenderPass_ptr(device, pCreateInfo, pAllocator, pRenderPass);

	public typealias vkDestroyRenderPassFunction = function void(VkDevice device, VkRenderPass renderPass, VkAllocationCallbacks* pAllocator);
	private static vkDestroyRenderPassFunction vkDestroyRenderPass_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyRenderPass(VkDevice device, VkRenderPass renderPass, VkAllocationCallbacks* pAllocator)
		=> vkDestroyRenderPass_ptr(device, renderPass, pAllocator);

	public typealias vkGetRenderAreaGranularityFunction = function void(VkDevice device, VkRenderPass renderPass, VkExtent2D* pGranularity);
	private static vkGetRenderAreaGranularityFunction vkGetRenderAreaGranularity_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetRenderAreaGranularity(VkDevice device, VkRenderPass renderPass, VkExtent2D* pGranularity)
		=> vkGetRenderAreaGranularity_ptr(device, renderPass, pGranularity);

	public typealias vkCreateCommandPoolFunction = function VkResult(VkDevice device, VkCommandPoolCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkCommandPool* pCommandPool);
	private static vkCreateCommandPoolFunction vkCreateCommandPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateCommandPool(VkDevice device, VkCommandPoolCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkCommandPool* pCommandPool)
		=> vkCreateCommandPool_ptr(device, pCreateInfo, pAllocator, pCommandPool);

	public typealias vkDestroyCommandPoolFunction = function void(VkDevice device, VkCommandPool commandPool, VkAllocationCallbacks* pAllocator);
	private static vkDestroyCommandPoolFunction vkDestroyCommandPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyCommandPool(VkDevice device, VkCommandPool commandPool, VkAllocationCallbacks* pAllocator)
		=> vkDestroyCommandPool_ptr(device, commandPool, pAllocator);

	public typealias vkResetCommandPoolFunction = function VkResult(VkDevice device, VkCommandPool commandPool, VkCommandPoolResetFlags flags);
	private static vkResetCommandPoolFunction vkResetCommandPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkResetCommandPool(VkDevice device, VkCommandPool commandPool, VkCommandPoolResetFlags flags)
		=> vkResetCommandPool_ptr(device, commandPool, flags);

	public typealias vkAllocateCommandBuffersFunction = function VkResult(VkDevice device, VkCommandBufferAllocateInfo* pAllocateInfo, VkCommandBuffer* pCommandBuffers);
	private static vkAllocateCommandBuffersFunction vkAllocateCommandBuffers_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAllocateCommandBuffers(VkDevice device, VkCommandBufferAllocateInfo* pAllocateInfo, VkCommandBuffer* pCommandBuffers)
		=> vkAllocateCommandBuffers_ptr(device, pAllocateInfo, pCommandBuffers);

	public typealias vkFreeCommandBuffersFunction = function void(VkDevice device, VkCommandPool commandPool, uint32 commandBufferCount, VkCommandBuffer* pCommandBuffers);
	private static vkFreeCommandBuffersFunction vkFreeCommandBuffers_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkFreeCommandBuffers(VkDevice device, VkCommandPool commandPool, uint32 commandBufferCount, VkCommandBuffer* pCommandBuffers)
		=> vkFreeCommandBuffers_ptr(device, commandPool, commandBufferCount, pCommandBuffers);

	public typealias vkBeginCommandBufferFunction = function VkResult(VkCommandBuffer commandBuffer, VkCommandBufferBeginInfo* pBeginInfo);
	private static vkBeginCommandBufferFunction vkBeginCommandBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBeginCommandBuffer(VkCommandBuffer commandBuffer, VkCommandBufferBeginInfo* pBeginInfo)
		=> vkBeginCommandBuffer_ptr(commandBuffer, pBeginInfo);

	public typealias vkEndCommandBufferFunction = function VkResult(VkCommandBuffer commandBuffer);
	private static vkEndCommandBufferFunction vkEndCommandBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEndCommandBuffer(VkCommandBuffer commandBuffer)
		=> vkEndCommandBuffer_ptr(commandBuffer);

	public typealias vkResetCommandBufferFunction = function VkResult(VkCommandBuffer commandBuffer, VkCommandBufferResetFlags flags);
	private static vkResetCommandBufferFunction vkResetCommandBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkResetCommandBuffer(VkCommandBuffer commandBuffer, VkCommandBufferResetFlags flags)
		=> vkResetCommandBuffer_ptr(commandBuffer, flags);

	public typealias vkCmdBindPipelineFunction = function void(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipeline pipeline);
	private static vkCmdBindPipelineFunction vkCmdBindPipeline_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindPipeline(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipeline pipeline)
		=> vkCmdBindPipeline_ptr(commandBuffer, pipelineBindPoint, pipeline);

	public typealias vkCmdSetViewportFunction = function void(VkCommandBuffer commandBuffer, uint32 firstViewport, uint32 viewportCount, VkViewport* pViewports);
	private static vkCmdSetViewportFunction vkCmdSetViewport_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetViewport(VkCommandBuffer commandBuffer, uint32 firstViewport, uint32 viewportCount, VkViewport* pViewports)
		=> vkCmdSetViewport_ptr(commandBuffer, firstViewport, viewportCount, pViewports);

	public typealias vkCmdSetScissorFunction = function void(VkCommandBuffer commandBuffer, uint32 firstScissor, uint32 scissorCount, VkRect2D* pScissors);
	private static vkCmdSetScissorFunction vkCmdSetScissor_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetScissor(VkCommandBuffer commandBuffer, uint32 firstScissor, uint32 scissorCount, VkRect2D* pScissors)
		=> vkCmdSetScissor_ptr(commandBuffer, firstScissor, scissorCount, pScissors);

	public typealias vkCmdSetLineWidthFunction = function void(VkCommandBuffer commandBuffer, float lineWidth);
	private static vkCmdSetLineWidthFunction vkCmdSetLineWidth_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetLineWidth(VkCommandBuffer commandBuffer, float lineWidth)
		=> vkCmdSetLineWidth_ptr(commandBuffer, lineWidth);

	public typealias vkCmdSetDepthBiasFunction = function void(VkCommandBuffer commandBuffer, float depthBiasConstantFactor, float depthBiasClamp, float depthBiasSlopeFactor);
	private static vkCmdSetDepthBiasFunction vkCmdSetDepthBias_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthBias(VkCommandBuffer commandBuffer, float depthBiasConstantFactor, float depthBiasClamp, float depthBiasSlopeFactor)
		=> vkCmdSetDepthBias_ptr(commandBuffer, depthBiasConstantFactor, depthBiasClamp, depthBiasSlopeFactor);

	public typealias vkCmdSetBlendConstantsFunction = function void(VkCommandBuffer commandBuffer, float[4] blendConstants);
	private static vkCmdSetBlendConstantsFunction vkCmdSetBlendConstants_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetBlendConstants(VkCommandBuffer commandBuffer, float[4] blendConstants)
		=> vkCmdSetBlendConstants_ptr(commandBuffer, blendConstants);

	public typealias vkCmdSetDepthBoundsFunction = function void(VkCommandBuffer commandBuffer, float minDepthBounds, float maxDepthBounds);
	private static vkCmdSetDepthBoundsFunction vkCmdSetDepthBounds_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthBounds(VkCommandBuffer commandBuffer, float minDepthBounds, float maxDepthBounds)
		=> vkCmdSetDepthBounds_ptr(commandBuffer, minDepthBounds, maxDepthBounds);

	public typealias vkCmdSetStencilCompareMaskFunction = function void(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32 compareMask);
	private static vkCmdSetStencilCompareMaskFunction vkCmdSetStencilCompareMask_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetStencilCompareMask(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32 compareMask)
		=> vkCmdSetStencilCompareMask_ptr(commandBuffer, faceMask, compareMask);

	public typealias vkCmdSetStencilWriteMaskFunction = function void(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32 writeMask);
	private static vkCmdSetStencilWriteMaskFunction vkCmdSetStencilWriteMask_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetStencilWriteMask(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32 writeMask)
		=> vkCmdSetStencilWriteMask_ptr(commandBuffer, faceMask, writeMask);

	public typealias vkCmdSetStencilReferenceFunction = function void(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32 reference);
	private static vkCmdSetStencilReferenceFunction vkCmdSetStencilReference_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetStencilReference(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, uint32 reference)
		=> vkCmdSetStencilReference_ptr(commandBuffer, faceMask, reference);

	public typealias vkCmdBindDescriptorSetsFunction = function void(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32 firstSet, uint32 descriptorSetCount, VkDescriptorSet* pDescriptorSets, uint32 dynamicOffsetCount, uint32* pDynamicOffsets);
	private static vkCmdBindDescriptorSetsFunction vkCmdBindDescriptorSets_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindDescriptorSets(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32 firstSet, uint32 descriptorSetCount, VkDescriptorSet* pDescriptorSets, uint32 dynamicOffsetCount, uint32* pDynamicOffsets)
		=> vkCmdBindDescriptorSets_ptr(commandBuffer, pipelineBindPoint, layout, firstSet, descriptorSetCount, pDescriptorSets, dynamicOffsetCount, pDynamicOffsets);

	public typealias vkCmdBindIndexBufferFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkIndexType indexType);
	private static vkCmdBindIndexBufferFunction vkCmdBindIndexBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindIndexBuffer(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkIndexType indexType)
		=> vkCmdBindIndexBuffer_ptr(commandBuffer, buffer, offset, indexType);

	public typealias vkCmdBindVertexBuffersFunction = function void(VkCommandBuffer commandBuffer, uint32 firstBinding, uint32 bindingCount, VkBuffer* pBuffers, uint64* pOffsets);
	private static vkCmdBindVertexBuffersFunction vkCmdBindVertexBuffers_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindVertexBuffers(VkCommandBuffer commandBuffer, uint32 firstBinding, uint32 bindingCount, VkBuffer* pBuffers, uint64* pOffsets)
		=> vkCmdBindVertexBuffers_ptr(commandBuffer, firstBinding, bindingCount, pBuffers, pOffsets);

	public typealias vkCmdDrawFunction = function void(VkCommandBuffer commandBuffer, uint32 vertexCount, uint32 instanceCount, uint32 firstVertex, uint32 firstInstance);
	private static vkCmdDrawFunction vkCmdDraw_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDraw(VkCommandBuffer commandBuffer, uint32 vertexCount, uint32 instanceCount, uint32 firstVertex, uint32 firstInstance)
		=> vkCmdDraw_ptr(commandBuffer, vertexCount, instanceCount, firstVertex, firstInstance);

	public typealias vkCmdDrawIndexedFunction = function void(VkCommandBuffer commandBuffer, uint32 indexCount, uint32 instanceCount, uint32 firstIndex, int32 vertexOffset, uint32 firstInstance);
	private static vkCmdDrawIndexedFunction vkCmdDrawIndexed_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawIndexed(VkCommandBuffer commandBuffer, uint32 indexCount, uint32 instanceCount, uint32 firstIndex, int32 vertexOffset, uint32 firstInstance)
		=> vkCmdDrawIndexed_ptr(commandBuffer, indexCount, instanceCount, firstIndex, vertexOffset, firstInstance);

	public typealias vkCmdDrawIndirectFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, uint32 drawCount, uint32 stride);
	private static vkCmdDrawIndirectFunction vkCmdDrawIndirect_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawIndirect(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, uint32 drawCount, uint32 stride)
		=> vkCmdDrawIndirect_ptr(commandBuffer, buffer, offset, drawCount, stride);

	public typealias vkCmdDrawIndexedIndirectFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, uint32 drawCount, uint32 stride);
	private static vkCmdDrawIndexedIndirectFunction vkCmdDrawIndexedIndirect_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawIndexedIndirect(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, uint32 drawCount, uint32 stride)
		=> vkCmdDrawIndexedIndirect_ptr(commandBuffer, buffer, offset, drawCount, stride);

	public typealias vkCmdDispatchFunction = function void(VkCommandBuffer commandBuffer, uint32 groupCountX, uint32 groupCountY, uint32 groupCountZ);
	private static vkCmdDispatchFunction vkCmdDispatch_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDispatch(VkCommandBuffer commandBuffer, uint32 groupCountX, uint32 groupCountY, uint32 groupCountZ)
		=> vkCmdDispatch_ptr(commandBuffer, groupCountX, groupCountY, groupCountZ);

	public typealias vkCmdDispatchIndirectFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset);
	private static vkCmdDispatchIndirectFunction vkCmdDispatchIndirect_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDispatchIndirect(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset)
		=> vkCmdDispatchIndirect_ptr(commandBuffer, buffer, offset);

	public typealias vkCmdCopyBufferFunction = function void(VkCommandBuffer commandBuffer, VkBuffer srcBuffer, VkBuffer dstBuffer, uint32 regionCount, VkBufferCopy* pRegions);
	private static vkCmdCopyBufferFunction vkCmdCopyBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyBuffer(VkCommandBuffer commandBuffer, VkBuffer srcBuffer, VkBuffer dstBuffer, uint32 regionCount, VkBufferCopy* pRegions)
		=> vkCmdCopyBuffer_ptr(commandBuffer, srcBuffer, dstBuffer, regionCount, pRegions);

	public typealias vkCmdCopyImageFunction = function void(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32 regionCount, VkImageCopy* pRegions);
	private static vkCmdCopyImageFunction vkCmdCopyImage_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyImage(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32 regionCount, VkImageCopy* pRegions)
		=> vkCmdCopyImage_ptr(commandBuffer, srcImage, srcImageLayout, dstImage, dstImageLayout, regionCount, pRegions);

	public typealias vkCmdBlitImageFunction = function void(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32 regionCount, VkImageBlit* pRegions, VkFilter filter);
	private static vkCmdBlitImageFunction vkCmdBlitImage_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBlitImage(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32 regionCount, VkImageBlit* pRegions, VkFilter filter)
		=> vkCmdBlitImage_ptr(commandBuffer, srcImage, srcImageLayout, dstImage, dstImageLayout, regionCount, pRegions, filter);

	public typealias vkCmdCopyBufferToImageFunction = function void(VkCommandBuffer commandBuffer, VkBuffer srcBuffer, VkImage dstImage, VkImageLayout dstImageLayout, uint32 regionCount, VkBufferImageCopy* pRegions);
	private static vkCmdCopyBufferToImageFunction vkCmdCopyBufferToImage_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyBufferToImage(VkCommandBuffer commandBuffer, VkBuffer srcBuffer, VkImage dstImage, VkImageLayout dstImageLayout, uint32 regionCount, VkBufferImageCopy* pRegions)
		=> vkCmdCopyBufferToImage_ptr(commandBuffer, srcBuffer, dstImage, dstImageLayout, regionCount, pRegions);

	public typealias vkCmdCopyImageToBufferFunction = function void(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkBuffer dstBuffer, uint32 regionCount, VkBufferImageCopy* pRegions);
	private static vkCmdCopyImageToBufferFunction vkCmdCopyImageToBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyImageToBuffer(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkBuffer dstBuffer, uint32 regionCount, VkBufferImageCopy* pRegions)
		=> vkCmdCopyImageToBuffer_ptr(commandBuffer, srcImage, srcImageLayout, dstBuffer, regionCount, pRegions);

	public typealias vkCmdUpdateBufferFunction = function void(VkCommandBuffer commandBuffer, VkBuffer dstBuffer, uint64 dstOffset, uint64 dataSize, void* pData);
	private static vkCmdUpdateBufferFunction vkCmdUpdateBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdUpdateBuffer(VkCommandBuffer commandBuffer, VkBuffer dstBuffer, uint64 dstOffset, uint64 dataSize, void* pData)
		=> vkCmdUpdateBuffer_ptr(commandBuffer, dstBuffer, dstOffset, dataSize, pData);

	public typealias vkCmdFillBufferFunction = function void(VkCommandBuffer commandBuffer, VkBuffer dstBuffer, uint64 dstOffset, uint64 size, uint32 data);
	private static vkCmdFillBufferFunction vkCmdFillBuffer_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdFillBuffer(VkCommandBuffer commandBuffer, VkBuffer dstBuffer, uint64 dstOffset, uint64 size, uint32 data)
		=> vkCmdFillBuffer_ptr(commandBuffer, dstBuffer, dstOffset, size, data);

	public typealias vkCmdClearColorImageFunction = function void(VkCommandBuffer commandBuffer, VkImage image, VkImageLayout imageLayout, VkClearColorValue* pColor, uint32 rangeCount, VkImageSubresourceRange* pRanges);
	private static vkCmdClearColorImageFunction vkCmdClearColorImage_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdClearColorImage(VkCommandBuffer commandBuffer, VkImage image, VkImageLayout imageLayout, VkClearColorValue* pColor, uint32 rangeCount, VkImageSubresourceRange* pRanges)
		=> vkCmdClearColorImage_ptr(commandBuffer, image, imageLayout, pColor, rangeCount, pRanges);

	public typealias vkCmdClearDepthStencilImageFunction = function void(VkCommandBuffer commandBuffer, VkImage image, VkImageLayout imageLayout, VkClearDepthStencilValue* pDepthStencil, uint32 rangeCount, VkImageSubresourceRange* pRanges);
	private static vkCmdClearDepthStencilImageFunction vkCmdClearDepthStencilImage_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdClearDepthStencilImage(VkCommandBuffer commandBuffer, VkImage image, VkImageLayout imageLayout, VkClearDepthStencilValue* pDepthStencil, uint32 rangeCount, VkImageSubresourceRange* pRanges)
		=> vkCmdClearDepthStencilImage_ptr(commandBuffer, image, imageLayout, pDepthStencil, rangeCount, pRanges);

	public typealias vkCmdClearAttachmentsFunction = function void(VkCommandBuffer commandBuffer, uint32 attachmentCount, VkClearAttachment* pAttachments, uint32 rectCount, VkClearRect* pRects);
	private static vkCmdClearAttachmentsFunction vkCmdClearAttachments_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdClearAttachments(VkCommandBuffer commandBuffer, uint32 attachmentCount, VkClearAttachment* pAttachments, uint32 rectCount, VkClearRect* pRects)
		=> vkCmdClearAttachments_ptr(commandBuffer, attachmentCount, pAttachments, rectCount, pRects);

	public typealias vkCmdResolveImageFunction = function void(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32 regionCount, VkImageResolve* pRegions);
	private static vkCmdResolveImageFunction vkCmdResolveImage_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdResolveImage(VkCommandBuffer commandBuffer, VkImage srcImage, VkImageLayout srcImageLayout, VkImage dstImage, VkImageLayout dstImageLayout, uint32 regionCount, VkImageResolve* pRegions)
		=> vkCmdResolveImage_ptr(commandBuffer, srcImage, srcImageLayout, dstImage, dstImageLayout, regionCount, pRegions);

	public typealias vkCmdSetEventFunction = function void(VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags stageMask);
	private static vkCmdSetEventFunction vkCmdSetEvent_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetEvent(VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags stageMask)
		=> vkCmdSetEvent_ptr(commandBuffer, event, stageMask);

	public typealias vkCmdResetEventFunction = function void(VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags stageMask);
	private static vkCmdResetEventFunction vkCmdResetEvent_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdResetEvent(VkCommandBuffer commandBuffer, VkEvent event, VkPipelineStageFlags stageMask)
		=> vkCmdResetEvent_ptr(commandBuffer, event, stageMask);

	public typealias vkCmdWaitEventsFunction = function void(VkCommandBuffer commandBuffer, uint32 eventCount, VkEvent* pEvents, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, uint32 memoryBarrierCount, VkMemoryBarrier* pMemoryBarriers, uint32 bufferMemoryBarrierCount, VkBufferMemoryBarrier* pBufferMemoryBarriers, uint32 imageMemoryBarrierCount, VkImageMemoryBarrier* pImageMemoryBarriers);
	private static vkCmdWaitEventsFunction vkCmdWaitEvents_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdWaitEvents(VkCommandBuffer commandBuffer, uint32 eventCount, VkEvent* pEvents, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, uint32 memoryBarrierCount, VkMemoryBarrier* pMemoryBarriers, uint32 bufferMemoryBarrierCount, VkBufferMemoryBarrier* pBufferMemoryBarriers, uint32 imageMemoryBarrierCount, VkImageMemoryBarrier* pImageMemoryBarriers)
		=> vkCmdWaitEvents_ptr(commandBuffer, eventCount, pEvents, srcStageMask, dstStageMask, memoryBarrierCount, pMemoryBarriers, bufferMemoryBarrierCount, pBufferMemoryBarriers, imageMemoryBarrierCount, pImageMemoryBarriers);

	public typealias vkCmdPipelineBarrierFunction = function void(VkCommandBuffer commandBuffer, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, VkDependencyFlags dependencyFlags, uint32 memoryBarrierCount, VkMemoryBarrier* pMemoryBarriers, uint32 bufferMemoryBarrierCount, VkBufferMemoryBarrier* pBufferMemoryBarriers, uint32 imageMemoryBarrierCount, VkImageMemoryBarrier* pImageMemoryBarriers);
	private static vkCmdPipelineBarrierFunction vkCmdPipelineBarrier_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdPipelineBarrier(VkCommandBuffer commandBuffer, VkPipelineStageFlags srcStageMask, VkPipelineStageFlags dstStageMask, VkDependencyFlags dependencyFlags, uint32 memoryBarrierCount, VkMemoryBarrier* pMemoryBarriers, uint32 bufferMemoryBarrierCount, VkBufferMemoryBarrier* pBufferMemoryBarriers, uint32 imageMemoryBarrierCount, VkImageMemoryBarrier* pImageMemoryBarriers)
		=> vkCmdPipelineBarrier_ptr(commandBuffer, srcStageMask, dstStageMask, dependencyFlags, memoryBarrierCount, pMemoryBarriers, bufferMemoryBarrierCount, pBufferMemoryBarriers, imageMemoryBarrierCount, pImageMemoryBarriers);

	public typealias vkCmdBeginQueryFunction = function void(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 query, VkQueryControlFlags flags);
	private static vkCmdBeginQueryFunction vkCmdBeginQuery_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginQuery(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 query, VkQueryControlFlags flags)
		=> vkCmdBeginQuery_ptr(commandBuffer, queryPool, query, flags);

	public typealias vkCmdEndQueryFunction = function void(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 query);
	private static vkCmdEndQueryFunction vkCmdEndQuery_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndQuery(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 query)
		=> vkCmdEndQuery_ptr(commandBuffer, queryPool, query);

	public typealias vkCmdResetQueryPoolFunction = function void(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 firstQuery, uint32 queryCount);
	private static vkCmdResetQueryPoolFunction vkCmdResetQueryPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdResetQueryPool(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 firstQuery, uint32 queryCount)
		=> vkCmdResetQueryPool_ptr(commandBuffer, queryPool, firstQuery, queryCount);

	public typealias vkCmdWriteTimestampFunction = function void(VkCommandBuffer commandBuffer, VkPipelineStageFlags pipelineStage, VkQueryPool queryPool, uint32 query);
	private static vkCmdWriteTimestampFunction vkCmdWriteTimestamp_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdWriteTimestamp(VkCommandBuffer commandBuffer, VkPipelineStageFlags pipelineStage, VkQueryPool queryPool, uint32 query)
		=> vkCmdWriteTimestamp_ptr(commandBuffer, pipelineStage, queryPool, query);

	public typealias vkCmdCopyQueryPoolResultsFunction = function void(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 firstQuery, uint32 queryCount, VkBuffer dstBuffer, uint64 dstOffset, uint64 stride, VkQueryResultFlags flags);
	private static vkCmdCopyQueryPoolResultsFunction vkCmdCopyQueryPoolResults_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyQueryPoolResults(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 firstQuery, uint32 queryCount, VkBuffer dstBuffer, uint64 dstOffset, uint64 stride, VkQueryResultFlags flags)
		=> vkCmdCopyQueryPoolResults_ptr(commandBuffer, queryPool, firstQuery, queryCount, dstBuffer, dstOffset, stride, flags);

	public typealias vkCmdPushConstantsFunction = function void(VkCommandBuffer commandBuffer, VkPipelineLayout layout, VkShaderStageFlags stageFlags, uint32 offset, uint32 size, void* pValues);
	private static vkCmdPushConstantsFunction vkCmdPushConstants_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdPushConstants(VkCommandBuffer commandBuffer, VkPipelineLayout layout, VkShaderStageFlags stageFlags, uint32 offset, uint32 size, void* pValues)
		=> vkCmdPushConstants_ptr(commandBuffer, layout, stageFlags, offset, size, pValues);

	public typealias vkCmdBeginRenderPassFunction = function void(VkCommandBuffer commandBuffer, VkRenderPassBeginInfo* pRenderPassBegin, VkSubpassContents contents);
	private static vkCmdBeginRenderPassFunction vkCmdBeginRenderPass_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginRenderPass(VkCommandBuffer commandBuffer, VkRenderPassBeginInfo* pRenderPassBegin, VkSubpassContents contents)
		=> vkCmdBeginRenderPass_ptr(commandBuffer, pRenderPassBegin, contents);

	public typealias vkCmdNextSubpassFunction = function void(VkCommandBuffer commandBuffer, VkSubpassContents contents);
	private static vkCmdNextSubpassFunction vkCmdNextSubpass_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdNextSubpass(VkCommandBuffer commandBuffer, VkSubpassContents contents)
		=> vkCmdNextSubpass_ptr(commandBuffer, contents);

	public typealias vkCmdEndRenderPassFunction = function void(VkCommandBuffer commandBuffer);
	private static vkCmdEndRenderPassFunction vkCmdEndRenderPass_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndRenderPass(VkCommandBuffer commandBuffer)
		=> vkCmdEndRenderPass_ptr(commandBuffer);

	public typealias vkCmdExecuteCommandsFunction = function void(VkCommandBuffer commandBuffer, uint32 commandBufferCount, VkCommandBuffer* pCommandBuffers);
	private static vkCmdExecuteCommandsFunction vkCmdExecuteCommands_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdExecuteCommands(VkCommandBuffer commandBuffer, uint32 commandBufferCount, VkCommandBuffer* pCommandBuffers)
		=> vkCmdExecuteCommands_ptr(commandBuffer, commandBufferCount, pCommandBuffers);

	public typealias vkEnumerateInstanceVersionFunction = function VkResult(uint32* pApiVersion);
	private static vkEnumerateInstanceVersionFunction vkEnumerateInstanceVersion_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEnumerateInstanceVersion(uint32* pApiVersion)
		=> vkEnumerateInstanceVersion_ptr(pApiVersion);

	public typealias vkBindBufferMemory2Function = function VkResult(VkDevice device, uint32 bindInfoCount, VkBindBufferMemoryInfo* pBindInfos);
	private static vkBindBufferMemory2Function vkBindBufferMemory2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBindBufferMemory2(VkDevice device, uint32 bindInfoCount, VkBindBufferMemoryInfo* pBindInfos)
		=> vkBindBufferMemory2_ptr(device, bindInfoCount, pBindInfos);

	public typealias vkBindImageMemory2Function = function VkResult(VkDevice device, uint32 bindInfoCount, VkBindImageMemoryInfo* pBindInfos);
	private static vkBindImageMemory2Function vkBindImageMemory2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBindImageMemory2(VkDevice device, uint32 bindInfoCount, VkBindImageMemoryInfo* pBindInfos)
		=> vkBindImageMemory2_ptr(device, bindInfoCount, pBindInfos);

	public typealias vkGetDeviceGroupPeerMemoryFeaturesFunction = function void(VkDevice device, uint32 heapIndex, uint32 localDeviceIndex, uint32 remoteDeviceIndex, VkPeerMemoryFeatureFlags* pPeerMemoryFeatures);
	private static vkGetDeviceGroupPeerMemoryFeaturesFunction vkGetDeviceGroupPeerMemoryFeatures_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceGroupPeerMemoryFeatures(VkDevice device, uint32 heapIndex, uint32 localDeviceIndex, uint32 remoteDeviceIndex, VkPeerMemoryFeatureFlags* pPeerMemoryFeatures)
		=> vkGetDeviceGroupPeerMemoryFeatures_ptr(device, heapIndex, localDeviceIndex, remoteDeviceIndex, pPeerMemoryFeatures);

	public typealias vkCmdSetDeviceMaskFunction = function void(VkCommandBuffer commandBuffer, uint32 deviceMask);
	private static vkCmdSetDeviceMaskFunction vkCmdSetDeviceMask_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDeviceMask(VkCommandBuffer commandBuffer, uint32 deviceMask)
		=> vkCmdSetDeviceMask_ptr(commandBuffer, deviceMask);

	public typealias vkCmdDispatchBaseFunction = function void(VkCommandBuffer commandBuffer, uint32 baseGroupX, uint32 baseGroupY, uint32 baseGroupZ, uint32 groupCountX, uint32 groupCountY, uint32 groupCountZ);
	private static vkCmdDispatchBaseFunction vkCmdDispatchBase_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDispatchBase(VkCommandBuffer commandBuffer, uint32 baseGroupX, uint32 baseGroupY, uint32 baseGroupZ, uint32 groupCountX, uint32 groupCountY, uint32 groupCountZ)
		=> vkCmdDispatchBase_ptr(commandBuffer, baseGroupX, baseGroupY, baseGroupZ, groupCountX, groupCountY, groupCountZ);

	public typealias vkEnumeratePhysicalDeviceGroupsFunction = function VkResult(VkInstance instance, uint32* pPhysicalDeviceGroupCount, VkPhysicalDeviceGroupProperties* pPhysicalDeviceGroupProperties);
	private static vkEnumeratePhysicalDeviceGroupsFunction vkEnumeratePhysicalDeviceGroups_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEnumeratePhysicalDeviceGroups(VkInstance instance, uint32* pPhysicalDeviceGroupCount, VkPhysicalDeviceGroupProperties* pPhysicalDeviceGroupProperties)
		=> vkEnumeratePhysicalDeviceGroups_ptr(instance, pPhysicalDeviceGroupCount, pPhysicalDeviceGroupProperties);

	public typealias vkGetImageMemoryRequirements2Function = function void(VkDevice device, VkImageMemoryRequirementsInfo2* pInfo, VkMemoryRequirements2* pMemoryRequirements);
	private static vkGetImageMemoryRequirements2Function vkGetImageMemoryRequirements2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetImageMemoryRequirements2(VkDevice device, VkImageMemoryRequirementsInfo2* pInfo, VkMemoryRequirements2* pMemoryRequirements)
		=> vkGetImageMemoryRequirements2_ptr(device, pInfo, pMemoryRequirements);

	public typealias vkGetBufferMemoryRequirements2Function = function void(VkDevice device, VkBufferMemoryRequirementsInfo2* pInfo, VkMemoryRequirements2* pMemoryRequirements);
	private static vkGetBufferMemoryRequirements2Function vkGetBufferMemoryRequirements2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetBufferMemoryRequirements2(VkDevice device, VkBufferMemoryRequirementsInfo2* pInfo, VkMemoryRequirements2* pMemoryRequirements)
		=> vkGetBufferMemoryRequirements2_ptr(device, pInfo, pMemoryRequirements);

	public typealias vkGetImageSparseMemoryRequirements2Function = function void(VkDevice device, VkImageSparseMemoryRequirementsInfo2* pInfo, uint32* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements2* pSparseMemoryRequirements);
	private static vkGetImageSparseMemoryRequirements2Function vkGetImageSparseMemoryRequirements2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetImageSparseMemoryRequirements2(VkDevice device, VkImageSparseMemoryRequirementsInfo2* pInfo, uint32* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements2* pSparseMemoryRequirements)
		=> vkGetImageSparseMemoryRequirements2_ptr(device, pInfo, pSparseMemoryRequirementCount, pSparseMemoryRequirements);

	public typealias vkGetPhysicalDeviceFeatures2Function = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceFeatures2* pFeatures);
	private static vkGetPhysicalDeviceFeatures2Function vkGetPhysicalDeviceFeatures2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceFeatures2(VkPhysicalDevice physicalDevice, VkPhysicalDeviceFeatures2* pFeatures)
		=> vkGetPhysicalDeviceFeatures2_ptr(physicalDevice, pFeatures);

	public typealias vkGetPhysicalDeviceProperties2Function = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceProperties2* pProperties);
	private static vkGetPhysicalDeviceProperties2Function vkGetPhysicalDeviceProperties2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceProperties2(VkPhysicalDevice physicalDevice, VkPhysicalDeviceProperties2* pProperties)
		=> vkGetPhysicalDeviceProperties2_ptr(physicalDevice, pProperties);

	public typealias vkGetPhysicalDeviceFormatProperties2Function = function void(VkPhysicalDevice physicalDevice, VkFormat format, VkFormatProperties2* pFormatProperties);
	private static vkGetPhysicalDeviceFormatProperties2Function vkGetPhysicalDeviceFormatProperties2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceFormatProperties2(VkPhysicalDevice physicalDevice, VkFormat format, VkFormatProperties2* pFormatProperties)
		=> vkGetPhysicalDeviceFormatProperties2_ptr(physicalDevice, format, pFormatProperties);

	public typealias vkGetPhysicalDeviceImageFormatProperties2Function = function VkResult(VkPhysicalDevice physicalDevice, VkPhysicalDeviceImageFormatInfo2* pImageFormatInfo, VkImageFormatProperties2* pImageFormatProperties);
	private static vkGetPhysicalDeviceImageFormatProperties2Function vkGetPhysicalDeviceImageFormatProperties2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceImageFormatProperties2(VkPhysicalDevice physicalDevice, VkPhysicalDeviceImageFormatInfo2* pImageFormatInfo, VkImageFormatProperties2* pImageFormatProperties)
		=> vkGetPhysicalDeviceImageFormatProperties2_ptr(physicalDevice, pImageFormatInfo, pImageFormatProperties);

	public typealias vkGetPhysicalDeviceQueueFamilyProperties2Function = function void(VkPhysicalDevice physicalDevice, uint32* pQueueFamilyPropertyCount, VkQueueFamilyProperties2* pQueueFamilyProperties);
	private static vkGetPhysicalDeviceQueueFamilyProperties2Function vkGetPhysicalDeviceQueueFamilyProperties2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceQueueFamilyProperties2(VkPhysicalDevice physicalDevice, uint32* pQueueFamilyPropertyCount, VkQueueFamilyProperties2* pQueueFamilyProperties)
		=> vkGetPhysicalDeviceQueueFamilyProperties2_ptr(physicalDevice, pQueueFamilyPropertyCount, pQueueFamilyProperties);

	public typealias vkGetPhysicalDeviceMemoryProperties2Function = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceMemoryProperties2* pMemoryProperties);
	private static vkGetPhysicalDeviceMemoryProperties2Function vkGetPhysicalDeviceMemoryProperties2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceMemoryProperties2(VkPhysicalDevice physicalDevice, VkPhysicalDeviceMemoryProperties2* pMemoryProperties)
		=> vkGetPhysicalDeviceMemoryProperties2_ptr(physicalDevice, pMemoryProperties);

	public typealias vkGetPhysicalDeviceSparseImageFormatProperties2Function = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceSparseImageFormatInfo2* pFormatInfo, uint32* pPropertyCount, VkSparseImageFormatProperties2* pProperties);
	private static vkGetPhysicalDeviceSparseImageFormatProperties2Function vkGetPhysicalDeviceSparseImageFormatProperties2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceSparseImageFormatProperties2(VkPhysicalDevice physicalDevice, VkPhysicalDeviceSparseImageFormatInfo2* pFormatInfo, uint32* pPropertyCount, VkSparseImageFormatProperties2* pProperties)
		=> vkGetPhysicalDeviceSparseImageFormatProperties2_ptr(physicalDevice, pFormatInfo, pPropertyCount, pProperties);

	public typealias vkTrimCommandPoolFunction = function void(VkDevice device, VkCommandPool commandPool, uint32 flags);
	private static vkTrimCommandPoolFunction vkTrimCommandPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkTrimCommandPool(VkDevice device, VkCommandPool commandPool, uint32 flags)
		=> vkTrimCommandPool_ptr(device, commandPool, flags);

	public typealias vkGetDeviceQueue2Function = function void(VkDevice device, VkDeviceQueueInfo2* pQueueInfo, VkQueue* pQueue);
	private static vkGetDeviceQueue2Function vkGetDeviceQueue2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceQueue2(VkDevice device, VkDeviceQueueInfo2* pQueueInfo, VkQueue* pQueue)
		=> vkGetDeviceQueue2_ptr(device, pQueueInfo, pQueue);

	public typealias vkCreateSamplerYcbcrConversionFunction = function VkResult(VkDevice device, VkSamplerYcbcrConversionCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSamplerYcbcrConversion* pYcbcrConversion);
	private static vkCreateSamplerYcbcrConversionFunction vkCreateSamplerYcbcrConversion_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateSamplerYcbcrConversion(VkDevice device, VkSamplerYcbcrConversionCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSamplerYcbcrConversion* pYcbcrConversion)
		=> vkCreateSamplerYcbcrConversion_ptr(device, pCreateInfo, pAllocator, pYcbcrConversion);

	public typealias vkDestroySamplerYcbcrConversionFunction = function void(VkDevice device, VkSamplerYcbcrConversion ycbcrConversion, VkAllocationCallbacks* pAllocator);
	private static vkDestroySamplerYcbcrConversionFunction vkDestroySamplerYcbcrConversion_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroySamplerYcbcrConversion(VkDevice device, VkSamplerYcbcrConversion ycbcrConversion, VkAllocationCallbacks* pAllocator)
		=> vkDestroySamplerYcbcrConversion_ptr(device, ycbcrConversion, pAllocator);

	public typealias vkCreateDescriptorUpdateTemplateFunction = function VkResult(VkDevice device, VkDescriptorUpdateTemplateCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDescriptorUpdateTemplate* pDescriptorUpdateTemplate);
	private static vkCreateDescriptorUpdateTemplateFunction vkCreateDescriptorUpdateTemplate_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDescriptorUpdateTemplate(VkDevice device, VkDescriptorUpdateTemplateCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDescriptorUpdateTemplate* pDescriptorUpdateTemplate)
		=> vkCreateDescriptorUpdateTemplate_ptr(device, pCreateInfo, pAllocator, pDescriptorUpdateTemplate);

	public typealias vkDestroyDescriptorUpdateTemplateFunction = function void(VkDevice device, VkDescriptorUpdateTemplate descriptorUpdateTemplate, VkAllocationCallbacks* pAllocator);
	private static vkDestroyDescriptorUpdateTemplateFunction vkDestroyDescriptorUpdateTemplate_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyDescriptorUpdateTemplate(VkDevice device, VkDescriptorUpdateTemplate descriptorUpdateTemplate, VkAllocationCallbacks* pAllocator)
		=> vkDestroyDescriptorUpdateTemplate_ptr(device, descriptorUpdateTemplate, pAllocator);

	public typealias vkUpdateDescriptorSetWithTemplateFunction = function void(VkDevice device, VkDescriptorSet descriptorSet, VkDescriptorUpdateTemplate descriptorUpdateTemplate, void* pData);
	private static vkUpdateDescriptorSetWithTemplateFunction vkUpdateDescriptorSetWithTemplate_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkUpdateDescriptorSetWithTemplate(VkDevice device, VkDescriptorSet descriptorSet, VkDescriptorUpdateTemplate descriptorUpdateTemplate, void* pData)
		=> vkUpdateDescriptorSetWithTemplate_ptr(device, descriptorSet, descriptorUpdateTemplate, pData);

	public typealias vkGetPhysicalDeviceExternalBufferPropertiesFunction = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceExternalBufferInfo* pExternalBufferInfo, VkExternalBufferProperties* pExternalBufferProperties);
	private static vkGetPhysicalDeviceExternalBufferPropertiesFunction vkGetPhysicalDeviceExternalBufferProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceExternalBufferProperties(VkPhysicalDevice physicalDevice, VkPhysicalDeviceExternalBufferInfo* pExternalBufferInfo, VkExternalBufferProperties* pExternalBufferProperties)
		=> vkGetPhysicalDeviceExternalBufferProperties_ptr(physicalDevice, pExternalBufferInfo, pExternalBufferProperties);

	public typealias vkGetPhysicalDeviceExternalFencePropertiesFunction = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceExternalFenceInfo* pExternalFenceInfo, VkExternalFenceProperties* pExternalFenceProperties);
	private static vkGetPhysicalDeviceExternalFencePropertiesFunction vkGetPhysicalDeviceExternalFenceProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceExternalFenceProperties(VkPhysicalDevice physicalDevice, VkPhysicalDeviceExternalFenceInfo* pExternalFenceInfo, VkExternalFenceProperties* pExternalFenceProperties)
		=> vkGetPhysicalDeviceExternalFenceProperties_ptr(physicalDevice, pExternalFenceInfo, pExternalFenceProperties);

	public typealias vkGetPhysicalDeviceExternalSemaphorePropertiesFunction = function void(VkPhysicalDevice physicalDevice, VkPhysicalDeviceExternalSemaphoreInfo* pExternalSemaphoreInfo, VkExternalSemaphoreProperties* pExternalSemaphoreProperties);
	private static vkGetPhysicalDeviceExternalSemaphorePropertiesFunction vkGetPhysicalDeviceExternalSemaphoreProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceExternalSemaphoreProperties(VkPhysicalDevice physicalDevice, VkPhysicalDeviceExternalSemaphoreInfo* pExternalSemaphoreInfo, VkExternalSemaphoreProperties* pExternalSemaphoreProperties)
		=> vkGetPhysicalDeviceExternalSemaphoreProperties_ptr(physicalDevice, pExternalSemaphoreInfo, pExternalSemaphoreProperties);

	public typealias vkGetDescriptorSetLayoutSupportFunction = function void(VkDevice device, VkDescriptorSetLayoutCreateInfo* pCreateInfo, VkDescriptorSetLayoutSupport* pSupport);
	private static vkGetDescriptorSetLayoutSupportFunction vkGetDescriptorSetLayoutSupport_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDescriptorSetLayoutSupport(VkDevice device, VkDescriptorSetLayoutCreateInfo* pCreateInfo, VkDescriptorSetLayoutSupport* pSupport)
		=> vkGetDescriptorSetLayoutSupport_ptr(device, pCreateInfo, pSupport);

	public typealias vkCmdDrawIndirectCountFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkBuffer countBuffer, uint64 countBufferOffset, uint32 maxDrawCount, uint32 stride);
	private static vkCmdDrawIndirectCountFunction vkCmdDrawIndirectCount_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawIndirectCount(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkBuffer countBuffer, uint64 countBufferOffset, uint32 maxDrawCount, uint32 stride)
		=> vkCmdDrawIndirectCount_ptr(commandBuffer, buffer, offset, countBuffer, countBufferOffset, maxDrawCount, stride);

	public typealias vkCmdDrawIndexedIndirectCountFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkBuffer countBuffer, uint64 countBufferOffset, uint32 maxDrawCount, uint32 stride);
	private static vkCmdDrawIndexedIndirectCountFunction vkCmdDrawIndexedIndirectCount_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawIndexedIndirectCount(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkBuffer countBuffer, uint64 countBufferOffset, uint32 maxDrawCount, uint32 stride)
		=> vkCmdDrawIndexedIndirectCount_ptr(commandBuffer, buffer, offset, countBuffer, countBufferOffset, maxDrawCount, stride);

	public typealias vkCreateRenderPass2Function = function VkResult(VkDevice device, VkRenderPassCreateInfo2* pCreateInfo, VkAllocationCallbacks* pAllocator, VkRenderPass* pRenderPass);
	private static vkCreateRenderPass2Function vkCreateRenderPass2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateRenderPass2(VkDevice device, VkRenderPassCreateInfo2* pCreateInfo, VkAllocationCallbacks* pAllocator, VkRenderPass* pRenderPass)
		=> vkCreateRenderPass2_ptr(device, pCreateInfo, pAllocator, pRenderPass);

	public typealias vkCmdBeginRenderPass2Function = function void(VkCommandBuffer commandBuffer, VkRenderPassBeginInfo* pRenderPassBegin, VkSubpassBeginInfo* pSubpassBeginInfo);
	private static vkCmdBeginRenderPass2Function vkCmdBeginRenderPass2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginRenderPass2(VkCommandBuffer commandBuffer, VkRenderPassBeginInfo* pRenderPassBegin, VkSubpassBeginInfo* pSubpassBeginInfo)
		=> vkCmdBeginRenderPass2_ptr(commandBuffer, pRenderPassBegin, pSubpassBeginInfo);

	public typealias vkCmdNextSubpass2Function = function void(VkCommandBuffer commandBuffer, VkSubpassBeginInfo* pSubpassBeginInfo, VkSubpassEndInfo* pSubpassEndInfo);
	private static vkCmdNextSubpass2Function vkCmdNextSubpass2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdNextSubpass2(VkCommandBuffer commandBuffer, VkSubpassBeginInfo* pSubpassBeginInfo, VkSubpassEndInfo* pSubpassEndInfo)
		=> vkCmdNextSubpass2_ptr(commandBuffer, pSubpassBeginInfo, pSubpassEndInfo);

	public typealias vkCmdEndRenderPass2Function = function void(VkCommandBuffer commandBuffer, VkSubpassEndInfo* pSubpassEndInfo);
	private static vkCmdEndRenderPass2Function vkCmdEndRenderPass2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndRenderPass2(VkCommandBuffer commandBuffer, VkSubpassEndInfo* pSubpassEndInfo)
		=> vkCmdEndRenderPass2_ptr(commandBuffer, pSubpassEndInfo);

	public typealias vkResetQueryPoolFunction = function void(VkDevice device, VkQueryPool queryPool, uint32 firstQuery, uint32 queryCount);
	private static vkResetQueryPoolFunction vkResetQueryPool_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkResetQueryPool(VkDevice device, VkQueryPool queryPool, uint32 firstQuery, uint32 queryCount)
		=> vkResetQueryPool_ptr(device, queryPool, firstQuery, queryCount);

	public typealias vkGetSemaphoreCounterValueFunction = function VkResult(VkDevice device, VkSemaphore semaphore, uint64* pValue);
	private static vkGetSemaphoreCounterValueFunction vkGetSemaphoreCounterValue_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSemaphoreCounterValue(VkDevice device, VkSemaphore semaphore, uint64* pValue)
		=> vkGetSemaphoreCounterValue_ptr(device, semaphore, pValue);

	public typealias vkWaitSemaphoresFunction = function VkResult(VkDevice device, VkSemaphoreWaitInfo* pWaitInfo, uint64 timeout);
	private static vkWaitSemaphoresFunction vkWaitSemaphores_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkWaitSemaphores(VkDevice device, VkSemaphoreWaitInfo* pWaitInfo, uint64 timeout)
		=> vkWaitSemaphores_ptr(device, pWaitInfo, timeout);

	public typealias vkSignalSemaphoreFunction = function VkResult(VkDevice device, VkSemaphoreSignalInfo* pSignalInfo);
	private static vkSignalSemaphoreFunction vkSignalSemaphore_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkSignalSemaphore(VkDevice device, VkSemaphoreSignalInfo* pSignalInfo)
		=> vkSignalSemaphore_ptr(device, pSignalInfo);

	public typealias vkGetBufferDeviceAddressFunction = function uint64(VkDevice device, VkBufferDeviceAddressInfo* pInfo);
	private static vkGetBufferDeviceAddressFunction vkGetBufferDeviceAddress_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static uint64 vkGetBufferDeviceAddress(VkDevice device, VkBufferDeviceAddressInfo* pInfo)
		=> vkGetBufferDeviceAddress_ptr(device, pInfo);

	public typealias vkGetBufferOpaqueCaptureAddressFunction = function uint64(VkDevice device, VkBufferDeviceAddressInfo* pInfo);
	private static vkGetBufferOpaqueCaptureAddressFunction vkGetBufferOpaqueCaptureAddress_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static uint64 vkGetBufferOpaqueCaptureAddress(VkDevice device, VkBufferDeviceAddressInfo* pInfo)
		=> vkGetBufferOpaqueCaptureAddress_ptr(device, pInfo);

	public typealias vkGetDeviceMemoryOpaqueCaptureAddressFunction = function uint64(VkDevice device, VkDeviceMemoryOpaqueCaptureAddressInfo* pInfo);
	private static vkGetDeviceMemoryOpaqueCaptureAddressFunction vkGetDeviceMemoryOpaqueCaptureAddress_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static uint64 vkGetDeviceMemoryOpaqueCaptureAddress(VkDevice device, VkDeviceMemoryOpaqueCaptureAddressInfo* pInfo)
		=> vkGetDeviceMemoryOpaqueCaptureAddress_ptr(device, pInfo);

	public typealias vkGetPhysicalDeviceToolPropertiesFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pToolCount, VkPhysicalDeviceToolProperties* pToolProperties);
	private static vkGetPhysicalDeviceToolPropertiesFunction vkGetPhysicalDeviceToolProperties_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceToolProperties(VkPhysicalDevice physicalDevice, uint32* pToolCount, VkPhysicalDeviceToolProperties* pToolProperties)
		=> vkGetPhysicalDeviceToolProperties_ptr(physicalDevice, pToolCount, pToolProperties);

	public typealias vkCreatePrivateDataSlotFunction = function VkResult(VkDevice device, VkPrivateDataSlotCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkPrivateDataSlot* pPrivateDataSlot);
	private static vkCreatePrivateDataSlotFunction vkCreatePrivateDataSlot_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreatePrivateDataSlot(VkDevice device, VkPrivateDataSlotCreateInfo* pCreateInfo, VkAllocationCallbacks* pAllocator, VkPrivateDataSlot* pPrivateDataSlot)
		=> vkCreatePrivateDataSlot_ptr(device, pCreateInfo, pAllocator, pPrivateDataSlot);

	public typealias vkDestroyPrivateDataSlotFunction = function void(VkDevice device, VkPrivateDataSlot privateDataSlot, VkAllocationCallbacks* pAllocator);
	private static vkDestroyPrivateDataSlotFunction vkDestroyPrivateDataSlot_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyPrivateDataSlot(VkDevice device, VkPrivateDataSlot privateDataSlot, VkAllocationCallbacks* pAllocator)
		=> vkDestroyPrivateDataSlot_ptr(device, privateDataSlot, pAllocator);

	public typealias vkSetPrivateDataFunction = function VkResult(VkDevice device, VkObjectType objectType, uint64 objectHandle, VkPrivateDataSlot privateDataSlot, uint64 data);
	private static vkSetPrivateDataFunction vkSetPrivateData_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkSetPrivateData(VkDevice device, VkObjectType objectType, uint64 objectHandle, VkPrivateDataSlot privateDataSlot, uint64 data)
		=> vkSetPrivateData_ptr(device, objectType, objectHandle, privateDataSlot, data);

	public typealias vkGetPrivateDataFunction = function void(VkDevice device, VkObjectType objectType, uint64 objectHandle, VkPrivateDataSlot privateDataSlot, uint64* pData);
	private static vkGetPrivateDataFunction vkGetPrivateData_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPrivateData(VkDevice device, VkObjectType objectType, uint64 objectHandle, VkPrivateDataSlot privateDataSlot, uint64* pData)
		=> vkGetPrivateData_ptr(device, objectType, objectHandle, privateDataSlot, pData);

	public typealias vkCmdSetEvent2Function = function void(VkCommandBuffer commandBuffer, VkEvent event, VkDependencyInfo* pDependencyInfo);
	private static vkCmdSetEvent2Function vkCmdSetEvent2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetEvent2(VkCommandBuffer commandBuffer, VkEvent event, VkDependencyInfo* pDependencyInfo)
		=> vkCmdSetEvent2_ptr(commandBuffer, event, pDependencyInfo);

	public typealias vkCmdResetEvent2Function = function void(VkCommandBuffer commandBuffer, VkEvent event, uint64 stageMask);
	private static vkCmdResetEvent2Function vkCmdResetEvent2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdResetEvent2(VkCommandBuffer commandBuffer, VkEvent event, uint64 stageMask)
		=> vkCmdResetEvent2_ptr(commandBuffer, event, stageMask);

	public typealias vkCmdWaitEvents2Function = function void(VkCommandBuffer commandBuffer, uint32 eventCount, VkEvent* pEvents, VkDependencyInfo* pDependencyInfos);
	private static vkCmdWaitEvents2Function vkCmdWaitEvents2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdWaitEvents2(VkCommandBuffer commandBuffer, uint32 eventCount, VkEvent* pEvents, VkDependencyInfo* pDependencyInfos)
		=> vkCmdWaitEvents2_ptr(commandBuffer, eventCount, pEvents, pDependencyInfos);

	public typealias vkCmdPipelineBarrier2Function = function void(VkCommandBuffer commandBuffer, VkDependencyInfo* pDependencyInfo);
	private static vkCmdPipelineBarrier2Function vkCmdPipelineBarrier2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdPipelineBarrier2(VkCommandBuffer commandBuffer, VkDependencyInfo* pDependencyInfo)
		=> vkCmdPipelineBarrier2_ptr(commandBuffer, pDependencyInfo);

	public typealias vkCmdWriteTimestamp2Function = function void(VkCommandBuffer commandBuffer, uint64 stage, VkQueryPool queryPool, uint32 query);
	private static vkCmdWriteTimestamp2Function vkCmdWriteTimestamp2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdWriteTimestamp2(VkCommandBuffer commandBuffer, uint64 stage, VkQueryPool queryPool, uint32 query)
		=> vkCmdWriteTimestamp2_ptr(commandBuffer, stage, queryPool, query);

	public typealias vkQueueSubmit2Function = function VkResult(VkQueue queue, uint32 submitCount, VkSubmitInfo2* pSubmits, VkFence fence);
	private static vkQueueSubmit2Function vkQueueSubmit2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkQueueSubmit2(VkQueue queue, uint32 submitCount, VkSubmitInfo2* pSubmits, VkFence fence)
		=> vkQueueSubmit2_ptr(queue, submitCount, pSubmits, fence);

	public typealias vkCmdCopyBuffer2Function = function void(VkCommandBuffer commandBuffer, VkCopyBufferInfo2* pCopyBufferInfo);
	private static vkCmdCopyBuffer2Function vkCmdCopyBuffer2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyBuffer2(VkCommandBuffer commandBuffer, VkCopyBufferInfo2* pCopyBufferInfo)
		=> vkCmdCopyBuffer2_ptr(commandBuffer, pCopyBufferInfo);

	public typealias vkCmdCopyImage2Function = function void(VkCommandBuffer commandBuffer, VkCopyImageInfo2* pCopyImageInfo);
	private static vkCmdCopyImage2Function vkCmdCopyImage2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyImage2(VkCommandBuffer commandBuffer, VkCopyImageInfo2* pCopyImageInfo)
		=> vkCmdCopyImage2_ptr(commandBuffer, pCopyImageInfo);

	public typealias vkCmdCopyBufferToImage2Function = function void(VkCommandBuffer commandBuffer, VkCopyBufferToImageInfo2* pCopyBufferToImageInfo);
	private static vkCmdCopyBufferToImage2Function vkCmdCopyBufferToImage2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyBufferToImage2(VkCommandBuffer commandBuffer, VkCopyBufferToImageInfo2* pCopyBufferToImageInfo)
		=> vkCmdCopyBufferToImage2_ptr(commandBuffer, pCopyBufferToImageInfo);

	public typealias vkCmdCopyImageToBuffer2Function = function void(VkCommandBuffer commandBuffer, VkCopyImageToBufferInfo2* pCopyImageToBufferInfo);
	private static vkCmdCopyImageToBuffer2Function vkCmdCopyImageToBuffer2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyImageToBuffer2(VkCommandBuffer commandBuffer, VkCopyImageToBufferInfo2* pCopyImageToBufferInfo)
		=> vkCmdCopyImageToBuffer2_ptr(commandBuffer, pCopyImageToBufferInfo);

	public typealias vkCmdBlitImage2Function = function void(VkCommandBuffer commandBuffer, VkBlitImageInfo2* pBlitImageInfo);
	private static vkCmdBlitImage2Function vkCmdBlitImage2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBlitImage2(VkCommandBuffer commandBuffer, VkBlitImageInfo2* pBlitImageInfo)
		=> vkCmdBlitImage2_ptr(commandBuffer, pBlitImageInfo);

	public typealias vkCmdResolveImage2Function = function void(VkCommandBuffer commandBuffer, VkResolveImageInfo2* pResolveImageInfo);
	private static vkCmdResolveImage2Function vkCmdResolveImage2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdResolveImage2(VkCommandBuffer commandBuffer, VkResolveImageInfo2* pResolveImageInfo)
		=> vkCmdResolveImage2_ptr(commandBuffer, pResolveImageInfo);

	public typealias vkCmdBeginRenderingFunction = function void(VkCommandBuffer commandBuffer, VkRenderingInfo* pRenderingInfo);
	private static vkCmdBeginRenderingFunction vkCmdBeginRendering_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginRendering(VkCommandBuffer commandBuffer, VkRenderingInfo* pRenderingInfo)
		=> vkCmdBeginRendering_ptr(commandBuffer, pRenderingInfo);

	public typealias vkCmdEndRenderingFunction = function void(VkCommandBuffer commandBuffer);
	private static vkCmdEndRenderingFunction vkCmdEndRendering_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndRendering(VkCommandBuffer commandBuffer)
		=> vkCmdEndRendering_ptr(commandBuffer);

	public typealias vkCmdSetCullModeFunction = function void(VkCommandBuffer commandBuffer, VkCullModeFlags cullMode);
	private static vkCmdSetCullModeFunction vkCmdSetCullMode_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCullMode(VkCommandBuffer commandBuffer, VkCullModeFlags cullMode)
		=> vkCmdSetCullMode_ptr(commandBuffer, cullMode);

	public typealias vkCmdSetFrontFaceFunction = function void(VkCommandBuffer commandBuffer, VkFrontFace frontFace);
	private static vkCmdSetFrontFaceFunction vkCmdSetFrontFace_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetFrontFace(VkCommandBuffer commandBuffer, VkFrontFace frontFace)
		=> vkCmdSetFrontFace_ptr(commandBuffer, frontFace);

	public typealias vkCmdSetPrimitiveTopologyFunction = function void(VkCommandBuffer commandBuffer, VkPrimitiveTopology primitiveTopology);
	private static vkCmdSetPrimitiveTopologyFunction vkCmdSetPrimitiveTopology_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetPrimitiveTopology(VkCommandBuffer commandBuffer, VkPrimitiveTopology primitiveTopology)
		=> vkCmdSetPrimitiveTopology_ptr(commandBuffer, primitiveTopology);

	public typealias vkCmdSetViewportWithCountFunction = function void(VkCommandBuffer commandBuffer, uint32 viewportCount, VkViewport* pViewports);
	private static vkCmdSetViewportWithCountFunction vkCmdSetViewportWithCount_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetViewportWithCount(VkCommandBuffer commandBuffer, uint32 viewportCount, VkViewport* pViewports)
		=> vkCmdSetViewportWithCount_ptr(commandBuffer, viewportCount, pViewports);

	public typealias vkCmdSetScissorWithCountFunction = function void(VkCommandBuffer commandBuffer, uint32 scissorCount, VkRect2D* pScissors);
	private static vkCmdSetScissorWithCountFunction vkCmdSetScissorWithCount_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetScissorWithCount(VkCommandBuffer commandBuffer, uint32 scissorCount, VkRect2D* pScissors)
		=> vkCmdSetScissorWithCount_ptr(commandBuffer, scissorCount, pScissors);

	public typealias vkCmdBindVertexBuffers2Function = function void(VkCommandBuffer commandBuffer, uint32 firstBinding, uint32 bindingCount, VkBuffer* pBuffers, uint64* pOffsets, uint64* pSizes, uint64* pStrides);
	private static vkCmdBindVertexBuffers2Function vkCmdBindVertexBuffers2_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindVertexBuffers2(VkCommandBuffer commandBuffer, uint32 firstBinding, uint32 bindingCount, VkBuffer* pBuffers, uint64* pOffsets, uint64* pSizes, uint64* pStrides)
		=> vkCmdBindVertexBuffers2_ptr(commandBuffer, firstBinding, bindingCount, pBuffers, pOffsets, pSizes, pStrides);

	public typealias vkCmdSetDepthTestEnableFunction = function void(VkCommandBuffer commandBuffer, VkBool32 depthTestEnable);
	private static vkCmdSetDepthTestEnableFunction vkCmdSetDepthTestEnable_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthTestEnable(VkCommandBuffer commandBuffer, VkBool32 depthTestEnable)
		=> vkCmdSetDepthTestEnable_ptr(commandBuffer, depthTestEnable);

	public typealias vkCmdSetDepthWriteEnableFunction = function void(VkCommandBuffer commandBuffer, VkBool32 depthWriteEnable);
	private static vkCmdSetDepthWriteEnableFunction vkCmdSetDepthWriteEnable_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthWriteEnable(VkCommandBuffer commandBuffer, VkBool32 depthWriteEnable)
		=> vkCmdSetDepthWriteEnable_ptr(commandBuffer, depthWriteEnable);

	public typealias vkCmdSetDepthCompareOpFunction = function void(VkCommandBuffer commandBuffer, VkCompareOp depthCompareOp);
	private static vkCmdSetDepthCompareOpFunction vkCmdSetDepthCompareOp_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthCompareOp(VkCommandBuffer commandBuffer, VkCompareOp depthCompareOp)
		=> vkCmdSetDepthCompareOp_ptr(commandBuffer, depthCompareOp);

	public typealias vkCmdSetDepthBoundsTestEnableFunction = function void(VkCommandBuffer commandBuffer, VkBool32 depthBoundsTestEnable);
	private static vkCmdSetDepthBoundsTestEnableFunction vkCmdSetDepthBoundsTestEnable_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthBoundsTestEnable(VkCommandBuffer commandBuffer, VkBool32 depthBoundsTestEnable)
		=> vkCmdSetDepthBoundsTestEnable_ptr(commandBuffer, depthBoundsTestEnable);

	public typealias vkCmdSetStencilTestEnableFunction = function void(VkCommandBuffer commandBuffer, VkBool32 stencilTestEnable);
	private static vkCmdSetStencilTestEnableFunction vkCmdSetStencilTestEnable_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetStencilTestEnable(VkCommandBuffer commandBuffer, VkBool32 stencilTestEnable)
		=> vkCmdSetStencilTestEnable_ptr(commandBuffer, stencilTestEnable);

	public typealias vkCmdSetStencilOpFunction = function void(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, VkStencilOp failOp, VkStencilOp passOp, VkStencilOp depthFailOp, VkCompareOp compareOp);
	private static vkCmdSetStencilOpFunction vkCmdSetStencilOp_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetStencilOp(VkCommandBuffer commandBuffer, VkStencilFaceFlags faceMask, VkStencilOp failOp, VkStencilOp passOp, VkStencilOp depthFailOp, VkCompareOp compareOp)
		=> vkCmdSetStencilOp_ptr(commandBuffer, faceMask, failOp, passOp, depthFailOp, compareOp);

	public typealias vkCmdSetRasterizerDiscardEnableFunction = function void(VkCommandBuffer commandBuffer, VkBool32 rasterizerDiscardEnable);
	private static vkCmdSetRasterizerDiscardEnableFunction vkCmdSetRasterizerDiscardEnable_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetRasterizerDiscardEnable(VkCommandBuffer commandBuffer, VkBool32 rasterizerDiscardEnable)
		=> vkCmdSetRasterizerDiscardEnable_ptr(commandBuffer, rasterizerDiscardEnable);

	public typealias vkCmdSetDepthBiasEnableFunction = function void(VkCommandBuffer commandBuffer, VkBool32 depthBiasEnable);
	private static vkCmdSetDepthBiasEnableFunction vkCmdSetDepthBiasEnable_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthBiasEnable(VkCommandBuffer commandBuffer, VkBool32 depthBiasEnable)
		=> vkCmdSetDepthBiasEnable_ptr(commandBuffer, depthBiasEnable);

	public typealias vkCmdSetPrimitiveRestartEnableFunction = function void(VkCommandBuffer commandBuffer, VkBool32 primitiveRestartEnable);
	private static vkCmdSetPrimitiveRestartEnableFunction vkCmdSetPrimitiveRestartEnable_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetPrimitiveRestartEnable(VkCommandBuffer commandBuffer, VkBool32 primitiveRestartEnable)
		=> vkCmdSetPrimitiveRestartEnable_ptr(commandBuffer, primitiveRestartEnable);

	public typealias vkGetDeviceBufferMemoryRequirementsFunction = function void(VkDevice device, VkDeviceBufferMemoryRequirements* pInfo, VkMemoryRequirements2* pMemoryRequirements);
	private static vkGetDeviceBufferMemoryRequirementsFunction vkGetDeviceBufferMemoryRequirements_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceBufferMemoryRequirements(VkDevice device, VkDeviceBufferMemoryRequirements* pInfo, VkMemoryRequirements2* pMemoryRequirements)
		=> vkGetDeviceBufferMemoryRequirements_ptr(device, pInfo, pMemoryRequirements);

	public typealias vkGetDeviceImageMemoryRequirementsFunction = function void(VkDevice device, VkDeviceImageMemoryRequirements* pInfo, VkMemoryRequirements2* pMemoryRequirements);
	private static vkGetDeviceImageMemoryRequirementsFunction vkGetDeviceImageMemoryRequirements_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceImageMemoryRequirements(VkDevice device, VkDeviceImageMemoryRequirements* pInfo, VkMemoryRequirements2* pMemoryRequirements)
		=> vkGetDeviceImageMemoryRequirements_ptr(device, pInfo, pMemoryRequirements);

	public typealias vkGetDeviceImageSparseMemoryRequirementsFunction = function void(VkDevice device, VkDeviceImageMemoryRequirements* pInfo, uint32* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements2* pSparseMemoryRequirements);
	private static vkGetDeviceImageSparseMemoryRequirementsFunction vkGetDeviceImageSparseMemoryRequirements_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceImageSparseMemoryRequirements(VkDevice device, VkDeviceImageMemoryRequirements* pInfo, uint32* pSparseMemoryRequirementCount, VkSparseImageMemoryRequirements2* pSparseMemoryRequirements)
		=> vkGetDeviceImageSparseMemoryRequirements_ptr(device, pInfo, pSparseMemoryRequirementCount, pSparseMemoryRequirements);

	public typealias vkGetCommandPoolMemoryConsumptionFunction = function void(VkDevice device, VkCommandPool commandPool, VkCommandBuffer commandBuffer, VkCommandPoolMemoryConsumption* pConsumption);
	private static vkGetCommandPoolMemoryConsumptionFunction vkGetCommandPoolMemoryConsumption_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetCommandPoolMemoryConsumption(VkDevice device, VkCommandPool commandPool, VkCommandBuffer commandBuffer, VkCommandPoolMemoryConsumption* pConsumption)
		=> vkGetCommandPoolMemoryConsumption_ptr(device, commandPool, commandBuffer, pConsumption);

	public typealias vkGetFaultDataFunction = function VkResult(VkDevice device, VkFaultQueryBehavior faultQueryBehavior, VkBool32* pUnrecordedFaults, uint32* pFaultCount, VkFaultData* pFaults);
	private static vkGetFaultDataFunction vkGetFaultData_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetFaultData(VkDevice device, VkFaultQueryBehavior faultQueryBehavior, VkBool32* pUnrecordedFaults, uint32* pFaultCount, VkFaultData* pFaults)
		=> vkGetFaultData_ptr(device, faultQueryBehavior, pUnrecordedFaults, pFaultCount, pFaults);

	public typealias vkDestroySurfaceKHRFunction = function void(VkInstance instance, VkSurfaceKHR surface, VkAllocationCallbacks* pAllocator);
	private static vkDestroySurfaceKHRFunction vkDestroySurfaceKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroySurfaceKHR(VkInstance instance, VkSurfaceKHR surface, VkAllocationCallbacks* pAllocator)
		=> vkDestroySurfaceKHR_ptr(instance, surface, pAllocator);

	public typealias vkGetPhysicalDeviceSurfaceSupportKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, VkSurfaceKHR surface, VkBool32* pSupported);
	private static vkGetPhysicalDeviceSurfaceSupportKHRFunction vkGetPhysicalDeviceSurfaceSupportKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSurfaceSupportKHR(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, VkSurfaceKHR surface, VkBool32* pSupported)
		=> vkGetPhysicalDeviceSurfaceSupportKHR_ptr(physicalDevice, queueFamilyIndex, surface, pSupported);

	public typealias vkGetPhysicalDeviceSurfaceCapabilitiesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, VkSurfaceCapabilitiesKHR* pSurfaceCapabilities);
	private static vkGetPhysicalDeviceSurfaceCapabilitiesKHRFunction vkGetPhysicalDeviceSurfaceCapabilitiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSurfaceCapabilitiesKHR(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, VkSurfaceCapabilitiesKHR* pSurfaceCapabilities)
		=> vkGetPhysicalDeviceSurfaceCapabilitiesKHR_ptr(physicalDevice, surface, pSurfaceCapabilities);

	public typealias vkGetPhysicalDeviceSurfaceFormatsKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32* pSurfaceFormatCount, VkSurfaceFormatKHR* pSurfaceFormats);
	private static vkGetPhysicalDeviceSurfaceFormatsKHRFunction vkGetPhysicalDeviceSurfaceFormatsKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSurfaceFormatsKHR(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32* pSurfaceFormatCount, VkSurfaceFormatKHR* pSurfaceFormats)
		=> vkGetPhysicalDeviceSurfaceFormatsKHR_ptr(physicalDevice, surface, pSurfaceFormatCount, pSurfaceFormats);

	public typealias vkGetPhysicalDeviceSurfacePresentModesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32* pPresentModeCount, VkPresentModeKHR* pPresentModes);
	private static vkGetPhysicalDeviceSurfacePresentModesKHRFunction vkGetPhysicalDeviceSurfacePresentModesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSurfacePresentModesKHR(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, uint32* pPresentModeCount, VkPresentModeKHR* pPresentModes)
		=> vkGetPhysicalDeviceSurfacePresentModesKHR_ptr(physicalDevice, surface, pPresentModeCount, pPresentModes);

	public typealias vkCreateSwapchainKHRFunction = function VkResult(VkDevice device, VkSwapchainCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSwapchainKHR* pSwapchain);
	private static vkCreateSwapchainKHRFunction vkCreateSwapchainKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateSwapchainKHR(VkDevice device, VkSwapchainCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSwapchainKHR* pSwapchain)
		=> vkCreateSwapchainKHR_ptr(device, pCreateInfo, pAllocator, pSwapchain);

	public typealias vkDestroySwapchainKHRFunction = function void(VkDevice device, VkSwapchainKHR swapchain, VkAllocationCallbacks* pAllocator);
	private static vkDestroySwapchainKHRFunction vkDestroySwapchainKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroySwapchainKHR(VkDevice device, VkSwapchainKHR swapchain, VkAllocationCallbacks* pAllocator)
		=> vkDestroySwapchainKHR_ptr(device, swapchain, pAllocator);

	public typealias vkGetSwapchainImagesKHRFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain, uint32* pSwapchainImageCount, VkImage* pSwapchainImages);
	private static vkGetSwapchainImagesKHRFunction vkGetSwapchainImagesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSwapchainImagesKHR(VkDevice device, VkSwapchainKHR swapchain, uint32* pSwapchainImageCount, VkImage* pSwapchainImages)
		=> vkGetSwapchainImagesKHR_ptr(device, swapchain, pSwapchainImageCount, pSwapchainImages);

	public typealias vkAcquireNextImageKHRFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain, uint64 timeout, VkSemaphore semaphore, VkFence fence, uint32* pImageIndex);
	private static vkAcquireNextImageKHRFunction vkAcquireNextImageKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAcquireNextImageKHR(VkDevice device, VkSwapchainKHR swapchain, uint64 timeout, VkSemaphore semaphore, VkFence fence, uint32* pImageIndex)
		=> vkAcquireNextImageKHR_ptr(device, swapchain, timeout, semaphore, fence, pImageIndex);

	public typealias vkQueuePresentKHRFunction = function VkResult(VkQueue queue, VkPresentInfoKHR* pPresentInfo);
	private static vkQueuePresentKHRFunction vkQueuePresentKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkQueuePresentKHR(VkQueue queue, VkPresentInfoKHR* pPresentInfo)
		=> vkQueuePresentKHR_ptr(queue, pPresentInfo);

	public typealias vkGetPhysicalDeviceDisplayPropertiesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkDisplayPropertiesKHR* pProperties);
	private static vkGetPhysicalDeviceDisplayPropertiesKHRFunction vkGetPhysicalDeviceDisplayPropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceDisplayPropertiesKHR(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkDisplayPropertiesKHR* pProperties)
		=> vkGetPhysicalDeviceDisplayPropertiesKHR_ptr(physicalDevice, pPropertyCount, pProperties);

	public typealias vkGetPhysicalDeviceDisplayPlanePropertiesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkDisplayPlanePropertiesKHR* pProperties);
	private static vkGetPhysicalDeviceDisplayPlanePropertiesKHRFunction vkGetPhysicalDeviceDisplayPlanePropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceDisplayPlanePropertiesKHR(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkDisplayPlanePropertiesKHR* pProperties)
		=> vkGetPhysicalDeviceDisplayPlanePropertiesKHR_ptr(physicalDevice, pPropertyCount, pProperties);

	public typealias vkGetDisplayPlaneSupportedDisplaysKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32 planeIndex, uint32* pDisplayCount, VkDisplayKHR* pDisplays);
	private static vkGetDisplayPlaneSupportedDisplaysKHRFunction vkGetDisplayPlaneSupportedDisplaysKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDisplayPlaneSupportedDisplaysKHR(VkPhysicalDevice physicalDevice, uint32 planeIndex, uint32* pDisplayCount, VkDisplayKHR* pDisplays)
		=> vkGetDisplayPlaneSupportedDisplaysKHR_ptr(physicalDevice, planeIndex, pDisplayCount, pDisplays);

	public typealias vkGetDisplayModePropertiesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkDisplayKHR display, uint32* pPropertyCount, VkDisplayModePropertiesKHR* pProperties);
	private static vkGetDisplayModePropertiesKHRFunction vkGetDisplayModePropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDisplayModePropertiesKHR(VkPhysicalDevice physicalDevice, VkDisplayKHR display, uint32* pPropertyCount, VkDisplayModePropertiesKHR* pProperties)
		=> vkGetDisplayModePropertiesKHR_ptr(physicalDevice, display, pPropertyCount, pProperties);

	public typealias vkCreateDisplayModeKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkDisplayKHR display, VkDisplayModeCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDisplayModeKHR* pMode);
	private static vkCreateDisplayModeKHRFunction vkCreateDisplayModeKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDisplayModeKHR(VkPhysicalDevice physicalDevice, VkDisplayKHR display, VkDisplayModeCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDisplayModeKHR* pMode)
		=> vkCreateDisplayModeKHR_ptr(physicalDevice, display, pCreateInfo, pAllocator, pMode);

	public typealias vkGetDisplayPlaneCapabilitiesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkDisplayModeKHR mode, uint32 planeIndex, VkDisplayPlaneCapabilitiesKHR* pCapabilities);
	private static vkGetDisplayPlaneCapabilitiesKHRFunction vkGetDisplayPlaneCapabilitiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDisplayPlaneCapabilitiesKHR(VkPhysicalDevice physicalDevice, VkDisplayModeKHR mode, uint32 planeIndex, VkDisplayPlaneCapabilitiesKHR* pCapabilities)
		=> vkGetDisplayPlaneCapabilitiesKHR_ptr(physicalDevice, mode, planeIndex, pCapabilities);

	public typealias vkCreateDisplayPlaneSurfaceKHRFunction = function VkResult(VkInstance instance, VkDisplaySurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateDisplayPlaneSurfaceKHRFunction vkCreateDisplayPlaneSurfaceKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDisplayPlaneSurfaceKHR(VkInstance instance, VkDisplaySurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateDisplayPlaneSurfaceKHR_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkCreateSharedSwapchainsKHRFunction = function VkResult(VkDevice device, uint32 swapchainCount, VkSwapchainCreateInfoKHR* pCreateInfos, VkAllocationCallbacks* pAllocator, VkSwapchainKHR* pSwapchains);
	private static vkCreateSharedSwapchainsKHRFunction vkCreateSharedSwapchainsKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateSharedSwapchainsKHR(VkDevice device, uint32 swapchainCount, VkSwapchainCreateInfoKHR* pCreateInfos, VkAllocationCallbacks* pAllocator, VkSwapchainKHR* pSwapchains)
		=> vkCreateSharedSwapchainsKHR_ptr(device, swapchainCount, pCreateInfos, pAllocator, pSwapchains);

	public typealias vkCreateXlibSurfaceKHRFunction = function VkResult(VkInstance instance, VkXlibSurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateXlibSurfaceKHRFunction vkCreateXlibSurfaceKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateXlibSurfaceKHR(VkInstance instance, VkXlibSurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateXlibSurfaceKHR_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetPhysicalDeviceXlibPresentationSupportKHRFunction = function VkBool32(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* dpy, void* visualID);
	private static vkGetPhysicalDeviceXlibPresentationSupportKHRFunction vkGetPhysicalDeviceXlibPresentationSupportKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkBool32 vkGetPhysicalDeviceXlibPresentationSupportKHR(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* dpy, void* visualID)
		=> vkGetPhysicalDeviceXlibPresentationSupportKHR_ptr(physicalDevice, queueFamilyIndex, dpy, visualID);

	public typealias vkCreateXcbSurfaceKHRFunction = function VkResult(VkInstance instance, VkXcbSurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateXcbSurfaceKHRFunction vkCreateXcbSurfaceKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateXcbSurfaceKHR(VkInstance instance, VkXcbSurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateXcbSurfaceKHR_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetPhysicalDeviceXcbPresentationSupportKHRFunction = function VkBool32(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* connection, void* visual_id);
	private static vkGetPhysicalDeviceXcbPresentationSupportKHRFunction vkGetPhysicalDeviceXcbPresentationSupportKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkBool32 vkGetPhysicalDeviceXcbPresentationSupportKHR(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* connection, void* visual_id)
		=> vkGetPhysicalDeviceXcbPresentationSupportKHR_ptr(physicalDevice, queueFamilyIndex, connection, visual_id);

	public typealias vkCreateWaylandSurfaceKHRFunction = function VkResult(VkInstance instance, VkWaylandSurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateWaylandSurfaceKHRFunction vkCreateWaylandSurfaceKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateWaylandSurfaceKHR(VkInstance instance, VkWaylandSurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateWaylandSurfaceKHR_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetPhysicalDeviceWaylandPresentationSupportKHRFunction = function VkBool32(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* display);
	private static vkGetPhysicalDeviceWaylandPresentationSupportKHRFunction vkGetPhysicalDeviceWaylandPresentationSupportKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkBool32 vkGetPhysicalDeviceWaylandPresentationSupportKHR(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* display)
		=> vkGetPhysicalDeviceWaylandPresentationSupportKHR_ptr(physicalDevice, queueFamilyIndex, display);

	public typealias vkCreateAndroidSurfaceKHRFunction = function VkResult(VkInstance instance, VkAndroidSurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateAndroidSurfaceKHRFunction vkCreateAndroidSurfaceKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateAndroidSurfaceKHR(VkInstance instance, VkAndroidSurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateAndroidSurfaceKHR_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkCreateWin32SurfaceKHRFunction = function VkResult(VkInstance instance, VkWin32SurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateWin32SurfaceKHRFunction vkCreateWin32SurfaceKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateWin32SurfaceKHR(VkInstance instance, VkWin32SurfaceCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateWin32SurfaceKHR_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetPhysicalDeviceWin32PresentationSupportKHRFunction = function VkBool32(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex);
	private static vkGetPhysicalDeviceWin32PresentationSupportKHRFunction vkGetPhysicalDeviceWin32PresentationSupportKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkBool32 vkGetPhysicalDeviceWin32PresentationSupportKHR(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex)
		=> vkGetPhysicalDeviceWin32PresentationSupportKHR_ptr(physicalDevice, queueFamilyIndex);

	public typealias vkCreateDebugReportCallbackEXTFunction = function VkResult(VkInstance instance, VkDebugReportCallbackCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDebugReportCallbackEXT* pCallback);
	private static vkCreateDebugReportCallbackEXTFunction vkCreateDebugReportCallbackEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDebugReportCallbackEXT(VkInstance instance, VkDebugReportCallbackCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDebugReportCallbackEXT* pCallback)
		=> vkCreateDebugReportCallbackEXT_ptr(instance, pCreateInfo, pAllocator, pCallback);

	public typealias vkDestroyDebugReportCallbackEXTFunction = function void(VkInstance instance, VkDebugReportCallbackEXT callback, VkAllocationCallbacks* pAllocator);
	private static vkDestroyDebugReportCallbackEXTFunction vkDestroyDebugReportCallbackEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyDebugReportCallbackEXT(VkInstance instance, VkDebugReportCallbackEXT callback, VkAllocationCallbacks* pAllocator)
		=> vkDestroyDebugReportCallbackEXT_ptr(instance, callback, pAllocator);

	public typealias vkDebugReportMessageEXTFunction = function void(VkInstance instance, VkDebugReportFlagsEXT flags, VkDebugReportObjectTypeEXT objectType, uint64 object, uint location, int32 messageCode, char8* pLayerPrefix, char8* pMessage);
	private static vkDebugReportMessageEXTFunction vkDebugReportMessageEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDebugReportMessageEXT(VkInstance instance, VkDebugReportFlagsEXT flags, VkDebugReportObjectTypeEXT objectType, uint64 object, uint location, int32 messageCode, char8* pLayerPrefix, char8* pMessage)
		=> vkDebugReportMessageEXT_ptr(instance, flags, objectType, object, location, messageCode, pLayerPrefix, pMessage);

	public typealias vkDebugMarkerSetObjectTagEXTFunction = function VkResult(VkDevice device, VkDebugMarkerObjectTagInfoEXT* pTagInfo);
	private static vkDebugMarkerSetObjectTagEXTFunction vkDebugMarkerSetObjectTagEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkDebugMarkerSetObjectTagEXT(VkDevice device, VkDebugMarkerObjectTagInfoEXT* pTagInfo)
		=> vkDebugMarkerSetObjectTagEXT_ptr(device, pTagInfo);

	public typealias vkDebugMarkerSetObjectNameEXTFunction = function VkResult(VkDevice device, VkDebugMarkerObjectNameInfoEXT* pNameInfo);
	private static vkDebugMarkerSetObjectNameEXTFunction vkDebugMarkerSetObjectNameEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkDebugMarkerSetObjectNameEXT(VkDevice device, VkDebugMarkerObjectNameInfoEXT* pNameInfo)
		=> vkDebugMarkerSetObjectNameEXT_ptr(device, pNameInfo);

	public typealias vkCmdDebugMarkerBeginEXTFunction = function void(VkCommandBuffer commandBuffer, VkDebugMarkerMarkerInfoEXT* pMarkerInfo);
	private static vkCmdDebugMarkerBeginEXTFunction vkCmdDebugMarkerBeginEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDebugMarkerBeginEXT(VkCommandBuffer commandBuffer, VkDebugMarkerMarkerInfoEXT* pMarkerInfo)
		=> vkCmdDebugMarkerBeginEXT_ptr(commandBuffer, pMarkerInfo);

	public typealias vkCmdDebugMarkerEndEXTFunction = function void(VkCommandBuffer commandBuffer);
	private static vkCmdDebugMarkerEndEXTFunction vkCmdDebugMarkerEndEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDebugMarkerEndEXT(VkCommandBuffer commandBuffer)
		=> vkCmdDebugMarkerEndEXT_ptr(commandBuffer);

	public typealias vkCmdDebugMarkerInsertEXTFunction = function void(VkCommandBuffer commandBuffer, VkDebugMarkerMarkerInfoEXT* pMarkerInfo);
	private static vkCmdDebugMarkerInsertEXTFunction vkCmdDebugMarkerInsertEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDebugMarkerInsertEXT(VkCommandBuffer commandBuffer, VkDebugMarkerMarkerInfoEXT* pMarkerInfo)
		=> vkCmdDebugMarkerInsertEXT_ptr(commandBuffer, pMarkerInfo);

	public typealias vkGetPhysicalDeviceVideoCapabilitiesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkVideoProfileInfoKHR* pVideoProfile, VkVideoCapabilitiesKHR* pCapabilities);
	private static vkGetPhysicalDeviceVideoCapabilitiesKHRFunction vkGetPhysicalDeviceVideoCapabilitiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceVideoCapabilitiesKHR(VkPhysicalDevice physicalDevice, VkVideoProfileInfoKHR* pVideoProfile, VkVideoCapabilitiesKHR* pCapabilities)
		=> vkGetPhysicalDeviceVideoCapabilitiesKHR_ptr(physicalDevice, pVideoProfile, pCapabilities);

	public typealias vkGetPhysicalDeviceVideoFormatPropertiesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkPhysicalDeviceVideoFormatInfoKHR* pVideoFormatInfo, uint32* pVideoFormatPropertyCount, VkVideoFormatPropertiesKHR* pVideoFormatProperties);
	private static vkGetPhysicalDeviceVideoFormatPropertiesKHRFunction vkGetPhysicalDeviceVideoFormatPropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceVideoFormatPropertiesKHR(VkPhysicalDevice physicalDevice, VkPhysicalDeviceVideoFormatInfoKHR* pVideoFormatInfo, uint32* pVideoFormatPropertyCount, VkVideoFormatPropertiesKHR* pVideoFormatProperties)
		=> vkGetPhysicalDeviceVideoFormatPropertiesKHR_ptr(physicalDevice, pVideoFormatInfo, pVideoFormatPropertyCount, pVideoFormatProperties);

	public typealias vkCreateVideoSessionKHRFunction = function VkResult(VkDevice device, VkVideoSessionCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkVideoSessionKHR* pVideoSession);
	private static vkCreateVideoSessionKHRFunction vkCreateVideoSessionKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateVideoSessionKHR(VkDevice device, VkVideoSessionCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkVideoSessionKHR* pVideoSession)
		=> vkCreateVideoSessionKHR_ptr(device, pCreateInfo, pAllocator, pVideoSession);

	public typealias vkDestroyVideoSessionKHRFunction = function void(VkDevice device, VkVideoSessionKHR videoSession, VkAllocationCallbacks* pAllocator);
	private static vkDestroyVideoSessionKHRFunction vkDestroyVideoSessionKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyVideoSessionKHR(VkDevice device, VkVideoSessionKHR videoSession, VkAllocationCallbacks* pAllocator)
		=> vkDestroyVideoSessionKHR_ptr(device, videoSession, pAllocator);

	public typealias vkGetVideoSessionMemoryRequirementsKHRFunction = function VkResult(VkDevice device, VkVideoSessionKHR videoSession, uint32* pMemoryRequirementsCount, VkVideoSessionMemoryRequirementsKHR* pMemoryRequirements);
	private static vkGetVideoSessionMemoryRequirementsKHRFunction vkGetVideoSessionMemoryRequirementsKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetVideoSessionMemoryRequirementsKHR(VkDevice device, VkVideoSessionKHR videoSession, uint32* pMemoryRequirementsCount, VkVideoSessionMemoryRequirementsKHR* pMemoryRequirements)
		=> vkGetVideoSessionMemoryRequirementsKHR_ptr(device, videoSession, pMemoryRequirementsCount, pMemoryRequirements);

	public typealias vkBindVideoSessionMemoryKHRFunction = function VkResult(VkDevice device, VkVideoSessionKHR videoSession, uint32 bindSessionMemoryInfoCount, VkBindVideoSessionMemoryInfoKHR* pBindSessionMemoryInfos);
	private static vkBindVideoSessionMemoryKHRFunction vkBindVideoSessionMemoryKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBindVideoSessionMemoryKHR(VkDevice device, VkVideoSessionKHR videoSession, uint32 bindSessionMemoryInfoCount, VkBindVideoSessionMemoryInfoKHR* pBindSessionMemoryInfos)
		=> vkBindVideoSessionMemoryKHR_ptr(device, videoSession, bindSessionMemoryInfoCount, pBindSessionMemoryInfos);

	public typealias vkCreateVideoSessionParametersKHRFunction = function VkResult(VkDevice device, VkVideoSessionParametersCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkVideoSessionParametersKHR* pVideoSessionParameters);
	private static vkCreateVideoSessionParametersKHRFunction vkCreateVideoSessionParametersKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateVideoSessionParametersKHR(VkDevice device, VkVideoSessionParametersCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkVideoSessionParametersKHR* pVideoSessionParameters)
		=> vkCreateVideoSessionParametersKHR_ptr(device, pCreateInfo, pAllocator, pVideoSessionParameters);

	public typealias vkUpdateVideoSessionParametersKHRFunction = function VkResult(VkDevice device, VkVideoSessionParametersKHR videoSessionParameters, VkVideoSessionParametersUpdateInfoKHR* pUpdateInfo);
	private static vkUpdateVideoSessionParametersKHRFunction vkUpdateVideoSessionParametersKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkUpdateVideoSessionParametersKHR(VkDevice device, VkVideoSessionParametersKHR videoSessionParameters, VkVideoSessionParametersUpdateInfoKHR* pUpdateInfo)
		=> vkUpdateVideoSessionParametersKHR_ptr(device, videoSessionParameters, pUpdateInfo);

	public typealias vkDestroyVideoSessionParametersKHRFunction = function void(VkDevice device, VkVideoSessionParametersKHR videoSessionParameters, VkAllocationCallbacks* pAllocator);
	private static vkDestroyVideoSessionParametersKHRFunction vkDestroyVideoSessionParametersKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyVideoSessionParametersKHR(VkDevice device, VkVideoSessionParametersKHR videoSessionParameters, VkAllocationCallbacks* pAllocator)
		=> vkDestroyVideoSessionParametersKHR_ptr(device, videoSessionParameters, pAllocator);

	public typealias vkCmdBeginVideoCodingKHRFunction = function void(VkCommandBuffer commandBuffer, VkVideoBeginCodingInfoKHR* pBeginInfo);
	private static vkCmdBeginVideoCodingKHRFunction vkCmdBeginVideoCodingKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginVideoCodingKHR(VkCommandBuffer commandBuffer, VkVideoBeginCodingInfoKHR* pBeginInfo)
		=> vkCmdBeginVideoCodingKHR_ptr(commandBuffer, pBeginInfo);

	public typealias vkCmdEndVideoCodingKHRFunction = function void(VkCommandBuffer commandBuffer, VkVideoEndCodingInfoKHR* pEndCodingInfo);
	private static vkCmdEndVideoCodingKHRFunction vkCmdEndVideoCodingKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndVideoCodingKHR(VkCommandBuffer commandBuffer, VkVideoEndCodingInfoKHR* pEndCodingInfo)
		=> vkCmdEndVideoCodingKHR_ptr(commandBuffer, pEndCodingInfo);

	public typealias vkCmdControlVideoCodingKHRFunction = function void(VkCommandBuffer commandBuffer, VkVideoCodingControlInfoKHR* pCodingControlInfo);
	private static vkCmdControlVideoCodingKHRFunction vkCmdControlVideoCodingKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdControlVideoCodingKHR(VkCommandBuffer commandBuffer, VkVideoCodingControlInfoKHR* pCodingControlInfo)
		=> vkCmdControlVideoCodingKHR_ptr(commandBuffer, pCodingControlInfo);

	public typealias vkCmdDecodeVideoKHRFunction = function void(VkCommandBuffer commandBuffer, VkVideoDecodeInfoKHR* pDecodeInfo);
	private static vkCmdDecodeVideoKHRFunction vkCmdDecodeVideoKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDecodeVideoKHR(VkCommandBuffer commandBuffer, VkVideoDecodeInfoKHR* pDecodeInfo)
		=> vkCmdDecodeVideoKHR_ptr(commandBuffer, pDecodeInfo);

	public typealias vkCmdBindTransformFeedbackBuffersEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 firstBinding, uint32 bindingCount, VkBuffer* pBuffers, uint64* pOffsets, uint64* pSizes);
	private static vkCmdBindTransformFeedbackBuffersEXTFunction vkCmdBindTransformFeedbackBuffersEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindTransformFeedbackBuffersEXT(VkCommandBuffer commandBuffer, uint32 firstBinding, uint32 bindingCount, VkBuffer* pBuffers, uint64* pOffsets, uint64* pSizes)
		=> vkCmdBindTransformFeedbackBuffersEXT_ptr(commandBuffer, firstBinding, bindingCount, pBuffers, pOffsets, pSizes);

	public typealias vkCmdBeginTransformFeedbackEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 firstCounterBuffer, uint32 counterBufferCount, VkBuffer* pCounterBuffers, uint64* pCounterBufferOffsets);
	private static vkCmdBeginTransformFeedbackEXTFunction vkCmdBeginTransformFeedbackEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginTransformFeedbackEXT(VkCommandBuffer commandBuffer, uint32 firstCounterBuffer, uint32 counterBufferCount, VkBuffer* pCounterBuffers, uint64* pCounterBufferOffsets)
		=> vkCmdBeginTransformFeedbackEXT_ptr(commandBuffer, firstCounterBuffer, counterBufferCount, pCounterBuffers, pCounterBufferOffsets);

	public typealias vkCmdEndTransformFeedbackEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 firstCounterBuffer, uint32 counterBufferCount, VkBuffer* pCounterBuffers, uint64* pCounterBufferOffsets);
	private static vkCmdEndTransformFeedbackEXTFunction vkCmdEndTransformFeedbackEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndTransformFeedbackEXT(VkCommandBuffer commandBuffer, uint32 firstCounterBuffer, uint32 counterBufferCount, VkBuffer* pCounterBuffers, uint64* pCounterBufferOffsets)
		=> vkCmdEndTransformFeedbackEXT_ptr(commandBuffer, firstCounterBuffer, counterBufferCount, pCounterBuffers, pCounterBufferOffsets);

	public typealias vkCmdBeginQueryIndexedEXTFunction = function void(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 query, VkQueryControlFlags flags, uint32 index);
	private static vkCmdBeginQueryIndexedEXTFunction vkCmdBeginQueryIndexedEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginQueryIndexedEXT(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 query, VkQueryControlFlags flags, uint32 index)
		=> vkCmdBeginQueryIndexedEXT_ptr(commandBuffer, queryPool, query, flags, index);

	public typealias vkCmdEndQueryIndexedEXTFunction = function void(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 query, uint32 index);
	private static vkCmdEndQueryIndexedEXTFunction vkCmdEndQueryIndexedEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndQueryIndexedEXT(VkCommandBuffer commandBuffer, VkQueryPool queryPool, uint32 query, uint32 index)
		=> vkCmdEndQueryIndexedEXT_ptr(commandBuffer, queryPool, query, index);

	public typealias vkCmdDrawIndirectByteCountEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 instanceCount, uint32 firstInstance, VkBuffer counterBuffer, uint64 counterBufferOffset, uint32 counterOffset, uint32 vertexStride);
	private static vkCmdDrawIndirectByteCountEXTFunction vkCmdDrawIndirectByteCountEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawIndirectByteCountEXT(VkCommandBuffer commandBuffer, uint32 instanceCount, uint32 firstInstance, VkBuffer counterBuffer, uint64 counterBufferOffset, uint32 counterOffset, uint32 vertexStride)
		=> vkCmdDrawIndirectByteCountEXT_ptr(commandBuffer, instanceCount, firstInstance, counterBuffer, counterBufferOffset, counterOffset, vertexStride);

	public typealias vkCreateCuModuleNVXFunction = function VkResult(VkDevice device, VkCuModuleCreateInfoNVX* pCreateInfo, VkAllocationCallbacks* pAllocator, VkCuModuleNVX* pModule);
	private static vkCreateCuModuleNVXFunction vkCreateCuModuleNVX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateCuModuleNVX(VkDevice device, VkCuModuleCreateInfoNVX* pCreateInfo, VkAllocationCallbacks* pAllocator, VkCuModuleNVX* pModule)
		=> vkCreateCuModuleNVX_ptr(device, pCreateInfo, pAllocator, pModule);

	public typealias vkCreateCuFunctionNVXFunction = function VkResult(VkDevice device, VkCuFunctionCreateInfoNVX* pCreateInfo, VkAllocationCallbacks* pAllocator, VkCuFunctionNVX* pFunction);
	private static vkCreateCuFunctionNVXFunction vkCreateCuFunctionNVX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateCuFunctionNVX(VkDevice device, VkCuFunctionCreateInfoNVX* pCreateInfo, VkAllocationCallbacks* pAllocator, VkCuFunctionNVX* pFunction)
		=> vkCreateCuFunctionNVX_ptr(device, pCreateInfo, pAllocator, pFunction);

	public typealias vkDestroyCuModuleNVXFunction = function void(VkDevice device, VkCuModuleNVX module, VkAllocationCallbacks* pAllocator);
	private static vkDestroyCuModuleNVXFunction vkDestroyCuModuleNVX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyCuModuleNVX(VkDevice device, VkCuModuleNVX module, VkAllocationCallbacks* pAllocator)
		=> vkDestroyCuModuleNVX_ptr(device, module, pAllocator);

	public typealias vkDestroyCuFunctionNVXFunction = function void(VkDevice device, VkCuFunctionNVX vkfunction, VkAllocationCallbacks* pAllocator);
	private static vkDestroyCuFunctionNVXFunction vkDestroyCuFunctionNVX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyCuFunctionNVX(VkDevice device, VkCuFunctionNVX vkfunction, VkAllocationCallbacks* pAllocator)
		=> vkDestroyCuFunctionNVX_ptr(device, vkfunction, pAllocator);

	public typealias vkCmdCuLaunchKernelNVXFunction = function void(VkCommandBuffer commandBuffer, VkCuLaunchInfoNVX* pLaunchInfo);
	private static vkCmdCuLaunchKernelNVXFunction vkCmdCuLaunchKernelNVX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCuLaunchKernelNVX(VkCommandBuffer commandBuffer, VkCuLaunchInfoNVX* pLaunchInfo)
		=> vkCmdCuLaunchKernelNVX_ptr(commandBuffer, pLaunchInfo);

	public typealias vkGetImageViewHandleNVXFunction = function uint32(VkDevice device, VkImageViewHandleInfoNVX* pInfo);
	private static vkGetImageViewHandleNVXFunction vkGetImageViewHandleNVX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static uint32 vkGetImageViewHandleNVX(VkDevice device, VkImageViewHandleInfoNVX* pInfo)
		=> vkGetImageViewHandleNVX_ptr(device, pInfo);

	public typealias vkGetImageViewAddressNVXFunction = function VkResult(VkDevice device, VkImageView imageView, VkImageViewAddressPropertiesNVX* pProperties);
	private static vkGetImageViewAddressNVXFunction vkGetImageViewAddressNVX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetImageViewAddressNVX(VkDevice device, VkImageView imageView, VkImageViewAddressPropertiesNVX* pProperties)
		=> vkGetImageViewAddressNVX_ptr(device, imageView, pProperties);

	public typealias vkGetShaderInfoAMDFunction = function VkResult(VkDevice device, VkPipeline pipeline, VkShaderStageFlags shaderStage, VkShaderInfoTypeAMD infoType, uint* pInfoSize, void* pInfo);
	private static vkGetShaderInfoAMDFunction vkGetShaderInfoAMD_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetShaderInfoAMD(VkDevice device, VkPipeline pipeline, VkShaderStageFlags shaderStage, VkShaderInfoTypeAMD infoType, uint* pInfoSize, void* pInfo)
		=> vkGetShaderInfoAMD_ptr(device, pipeline, shaderStage, infoType, pInfoSize, pInfo);

	public typealias vkCreateStreamDescriptorSurfaceGGPFunction = function VkResult(VkInstance instance, VkStreamDescriptorSurfaceCreateInfoGGP* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateStreamDescriptorSurfaceGGPFunction vkCreateStreamDescriptorSurfaceGGP_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateStreamDescriptorSurfaceGGP(VkInstance instance, VkStreamDescriptorSurfaceCreateInfoGGP* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateStreamDescriptorSurfaceGGP_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetPhysicalDeviceExternalImageFormatPropertiesNVFunction = function VkResult(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkImageTiling tiling, VkImageUsageFlags usage, VkImageCreateFlags flags, VkExternalMemoryHandleTypeFlagsNV externalHandleType, VkExternalImageFormatPropertiesNV* pExternalImageFormatProperties);
	private static vkGetPhysicalDeviceExternalImageFormatPropertiesNVFunction vkGetPhysicalDeviceExternalImageFormatPropertiesNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceExternalImageFormatPropertiesNV(VkPhysicalDevice physicalDevice, VkFormat format, VkImageType type, VkImageTiling tiling, VkImageUsageFlags usage, VkImageCreateFlags flags, VkExternalMemoryHandleTypeFlagsNV externalHandleType, VkExternalImageFormatPropertiesNV* pExternalImageFormatProperties)
		=> vkGetPhysicalDeviceExternalImageFormatPropertiesNV_ptr(physicalDevice, format, type, tiling, usage, flags, externalHandleType, pExternalImageFormatProperties);

	public typealias vkGetMemoryWin32HandleNVFunction = function VkResult(VkDevice device, VkDeviceMemory memory, VkExternalMemoryHandleTypeFlagsNV handleType, void* pHandle);
	private static vkGetMemoryWin32HandleNVFunction vkGetMemoryWin32HandleNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryWin32HandleNV(VkDevice device, VkDeviceMemory memory, VkExternalMemoryHandleTypeFlagsNV handleType, void* pHandle)
		=> vkGetMemoryWin32HandleNV_ptr(device, memory, handleType, pHandle);

	public typealias vkCreateViSurfaceNNFunction = function VkResult(VkInstance instance, VkViSurfaceCreateInfoNN* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateViSurfaceNNFunction vkCreateViSurfaceNN_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateViSurfaceNN(VkInstance instance, VkViSurfaceCreateInfoNN* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateViSurfaceNN_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetMemoryWin32HandleKHRFunction = function VkResult(VkDevice device, VkMemoryGetWin32HandleInfoKHR* pGetWin32HandleInfo, void* pHandle);
	private static vkGetMemoryWin32HandleKHRFunction vkGetMemoryWin32HandleKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryWin32HandleKHR(VkDevice device, VkMemoryGetWin32HandleInfoKHR* pGetWin32HandleInfo, void* pHandle)
		=> vkGetMemoryWin32HandleKHR_ptr(device, pGetWin32HandleInfo, pHandle);

	public typealias vkGetMemoryWin32HandlePropertiesKHRFunction = function VkResult(VkDevice device, VkExternalMemoryHandleTypeFlags handleType, void* handle, VkMemoryWin32HandlePropertiesKHR* pMemoryWin32HandleProperties);
	private static vkGetMemoryWin32HandlePropertiesKHRFunction vkGetMemoryWin32HandlePropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryWin32HandlePropertiesKHR(VkDevice device, VkExternalMemoryHandleTypeFlags handleType, void* handle, VkMemoryWin32HandlePropertiesKHR* pMemoryWin32HandleProperties)
		=> vkGetMemoryWin32HandlePropertiesKHR_ptr(device, handleType, handle, pMemoryWin32HandleProperties);

	public typealias vkGetMemoryFdKHRFunction = function VkResult(VkDevice device, VkMemoryGetFdInfoKHR* pGetFdInfo, int* pFd);
	private static vkGetMemoryFdKHRFunction vkGetMemoryFdKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryFdKHR(VkDevice device, VkMemoryGetFdInfoKHR* pGetFdInfo, int* pFd)
		=> vkGetMemoryFdKHR_ptr(device, pGetFdInfo, pFd);

	public typealias vkGetMemoryFdPropertiesKHRFunction = function VkResult(VkDevice device, VkExternalMemoryHandleTypeFlags handleType, int fd, VkMemoryFdPropertiesKHR* pMemoryFdProperties);
	private static vkGetMemoryFdPropertiesKHRFunction vkGetMemoryFdPropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryFdPropertiesKHR(VkDevice device, VkExternalMemoryHandleTypeFlags handleType, int fd, VkMemoryFdPropertiesKHR* pMemoryFdProperties)
		=> vkGetMemoryFdPropertiesKHR_ptr(device, handleType, fd, pMemoryFdProperties);

	public typealias vkImportSemaphoreWin32HandleKHRFunction = function VkResult(VkDevice device, VkImportSemaphoreWin32HandleInfoKHR* pImportSemaphoreWin32HandleInfo);
	private static vkImportSemaphoreWin32HandleKHRFunction vkImportSemaphoreWin32HandleKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkImportSemaphoreWin32HandleKHR(VkDevice device, VkImportSemaphoreWin32HandleInfoKHR* pImportSemaphoreWin32HandleInfo)
		=> vkImportSemaphoreWin32HandleKHR_ptr(device, pImportSemaphoreWin32HandleInfo);

	public typealias vkGetSemaphoreWin32HandleKHRFunction = function VkResult(VkDevice device, VkSemaphoreGetWin32HandleInfoKHR* pGetWin32HandleInfo, void* pHandle);
	private static vkGetSemaphoreWin32HandleKHRFunction vkGetSemaphoreWin32HandleKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSemaphoreWin32HandleKHR(VkDevice device, VkSemaphoreGetWin32HandleInfoKHR* pGetWin32HandleInfo, void* pHandle)
		=> vkGetSemaphoreWin32HandleKHR_ptr(device, pGetWin32HandleInfo, pHandle);

	public typealias vkImportSemaphoreFdKHRFunction = function VkResult(VkDevice device, VkImportSemaphoreFdInfoKHR* pImportSemaphoreFdInfo);
	private static vkImportSemaphoreFdKHRFunction vkImportSemaphoreFdKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkImportSemaphoreFdKHR(VkDevice device, VkImportSemaphoreFdInfoKHR* pImportSemaphoreFdInfo)
		=> vkImportSemaphoreFdKHR_ptr(device, pImportSemaphoreFdInfo);

	public typealias vkGetSemaphoreFdKHRFunction = function VkResult(VkDevice device, VkSemaphoreGetFdInfoKHR* pGetFdInfo, int* pFd);
	private static vkGetSemaphoreFdKHRFunction vkGetSemaphoreFdKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSemaphoreFdKHR(VkDevice device, VkSemaphoreGetFdInfoKHR* pGetFdInfo, int* pFd)
		=> vkGetSemaphoreFdKHR_ptr(device, pGetFdInfo, pFd);

	public typealias vkCmdPushDescriptorSetKHRFunction = function void(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32 set, uint32 descriptorWriteCount, VkWriteDescriptorSet* pDescriptorWrites);
	private static vkCmdPushDescriptorSetKHRFunction vkCmdPushDescriptorSetKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdPushDescriptorSetKHR(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32 set, uint32 descriptorWriteCount, VkWriteDescriptorSet* pDescriptorWrites)
		=> vkCmdPushDescriptorSetKHR_ptr(commandBuffer, pipelineBindPoint, layout, set, descriptorWriteCount, pDescriptorWrites);

	public typealias vkCmdBeginConditionalRenderingEXTFunction = function void(VkCommandBuffer commandBuffer, VkConditionalRenderingBeginInfoEXT* pConditionalRenderingBegin);
	private static vkCmdBeginConditionalRenderingEXTFunction vkCmdBeginConditionalRenderingEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginConditionalRenderingEXT(VkCommandBuffer commandBuffer, VkConditionalRenderingBeginInfoEXT* pConditionalRenderingBegin)
		=> vkCmdBeginConditionalRenderingEXT_ptr(commandBuffer, pConditionalRenderingBegin);

	public typealias vkCmdEndConditionalRenderingEXTFunction = function void(VkCommandBuffer commandBuffer);
	private static vkCmdEndConditionalRenderingEXTFunction vkCmdEndConditionalRenderingEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndConditionalRenderingEXT(VkCommandBuffer commandBuffer)
		=> vkCmdEndConditionalRenderingEXT_ptr(commandBuffer);

	public typealias vkCmdSetViewportWScalingNVFunction = function void(VkCommandBuffer commandBuffer, uint32 firstViewport, uint32 viewportCount, VkViewportWScalingNV* pViewportWScalings);
	private static vkCmdSetViewportWScalingNVFunction vkCmdSetViewportWScalingNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetViewportWScalingNV(VkCommandBuffer commandBuffer, uint32 firstViewport, uint32 viewportCount, VkViewportWScalingNV* pViewportWScalings)
		=> vkCmdSetViewportWScalingNV_ptr(commandBuffer, firstViewport, viewportCount, pViewportWScalings);

	public typealias vkReleaseDisplayEXTFunction = function VkResult(VkPhysicalDevice physicalDevice, VkDisplayKHR display);
	private static vkReleaseDisplayEXTFunction vkReleaseDisplayEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkReleaseDisplayEXT(VkPhysicalDevice physicalDevice, VkDisplayKHR display)
		=> vkReleaseDisplayEXT_ptr(physicalDevice, display);

	public typealias vkAcquireXlibDisplayEXTFunction = function VkResult(VkPhysicalDevice physicalDevice, void* dpy, VkDisplayKHR display);
	private static vkAcquireXlibDisplayEXTFunction vkAcquireXlibDisplayEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAcquireXlibDisplayEXT(VkPhysicalDevice physicalDevice, void* dpy, VkDisplayKHR display)
		=> vkAcquireXlibDisplayEXT_ptr(physicalDevice, dpy, display);

	public typealias vkGetRandROutputDisplayEXTFunction = function VkResult(VkPhysicalDevice physicalDevice, void* dpy, void* rrOutput, VkDisplayKHR* pDisplay);
	private static vkGetRandROutputDisplayEXTFunction vkGetRandROutputDisplayEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetRandROutputDisplayEXT(VkPhysicalDevice physicalDevice, void* dpy, void* rrOutput, VkDisplayKHR* pDisplay)
		=> vkGetRandROutputDisplayEXT_ptr(physicalDevice, dpy, rrOutput, pDisplay);

	public typealias vkGetPhysicalDeviceSurfaceCapabilities2EXTFunction = function VkResult(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, VkSurfaceCapabilities2EXT* pSurfaceCapabilities);
	private static vkGetPhysicalDeviceSurfaceCapabilities2EXTFunction vkGetPhysicalDeviceSurfaceCapabilities2EXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSurfaceCapabilities2EXT(VkPhysicalDevice physicalDevice, VkSurfaceKHR surface, VkSurfaceCapabilities2EXT* pSurfaceCapabilities)
		=> vkGetPhysicalDeviceSurfaceCapabilities2EXT_ptr(physicalDevice, surface, pSurfaceCapabilities);

	public typealias vkDisplayPowerControlEXTFunction = function VkResult(VkDevice device, VkDisplayKHR display, VkDisplayPowerInfoEXT* pDisplayPowerInfo);
	private static vkDisplayPowerControlEXTFunction vkDisplayPowerControlEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkDisplayPowerControlEXT(VkDevice device, VkDisplayKHR display, VkDisplayPowerInfoEXT* pDisplayPowerInfo)
		=> vkDisplayPowerControlEXT_ptr(device, display, pDisplayPowerInfo);

	public typealias vkRegisterDeviceEventEXTFunction = function VkResult(VkDevice device, VkDeviceEventInfoEXT* pDeviceEventInfo, VkAllocationCallbacks* pAllocator, VkFence* pFence);
	private static vkRegisterDeviceEventEXTFunction vkRegisterDeviceEventEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkRegisterDeviceEventEXT(VkDevice device, VkDeviceEventInfoEXT* pDeviceEventInfo, VkAllocationCallbacks* pAllocator, VkFence* pFence)
		=> vkRegisterDeviceEventEXT_ptr(device, pDeviceEventInfo, pAllocator, pFence);

	public typealias vkRegisterDisplayEventEXTFunction = function VkResult(VkDevice device, VkDisplayKHR display, VkDisplayEventInfoEXT* pDisplayEventInfo, VkAllocationCallbacks* pAllocator, VkFence* pFence);
	private static vkRegisterDisplayEventEXTFunction vkRegisterDisplayEventEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkRegisterDisplayEventEXT(VkDevice device, VkDisplayKHR display, VkDisplayEventInfoEXT* pDisplayEventInfo, VkAllocationCallbacks* pAllocator, VkFence* pFence)
		=> vkRegisterDisplayEventEXT_ptr(device, display, pDisplayEventInfo, pAllocator, pFence);

	public typealias vkGetSwapchainCounterEXTFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain, VkSurfaceCounterFlagsEXT counter, uint64* pCounterValue);
	private static vkGetSwapchainCounterEXTFunction vkGetSwapchainCounterEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSwapchainCounterEXT(VkDevice device, VkSwapchainKHR swapchain, VkSurfaceCounterFlagsEXT counter, uint64* pCounterValue)
		=> vkGetSwapchainCounterEXT_ptr(device, swapchain, counter, pCounterValue);

	public typealias vkGetRefreshCycleDurationGOOGLEFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain, VkRefreshCycleDurationGOOGLE* pDisplayTimingProperties);
	private static vkGetRefreshCycleDurationGOOGLEFunction vkGetRefreshCycleDurationGOOGLE_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetRefreshCycleDurationGOOGLE(VkDevice device, VkSwapchainKHR swapchain, VkRefreshCycleDurationGOOGLE* pDisplayTimingProperties)
		=> vkGetRefreshCycleDurationGOOGLE_ptr(device, swapchain, pDisplayTimingProperties);

	public typealias vkGetPastPresentationTimingGOOGLEFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain, uint32* pPresentationTimingCount, VkPastPresentationTimingGOOGLE* pPresentationTimings);
	private static vkGetPastPresentationTimingGOOGLEFunction vkGetPastPresentationTimingGOOGLE_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPastPresentationTimingGOOGLE(VkDevice device, VkSwapchainKHR swapchain, uint32* pPresentationTimingCount, VkPastPresentationTimingGOOGLE* pPresentationTimings)
		=> vkGetPastPresentationTimingGOOGLE_ptr(device, swapchain, pPresentationTimingCount, pPresentationTimings);

	public typealias vkCmdSetDiscardRectangleEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 firstDiscardRectangle, uint32 discardRectangleCount, VkRect2D* pDiscardRectangles);
	private static vkCmdSetDiscardRectangleEXTFunction vkCmdSetDiscardRectangleEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDiscardRectangleEXT(VkCommandBuffer commandBuffer, uint32 firstDiscardRectangle, uint32 discardRectangleCount, VkRect2D* pDiscardRectangles)
		=> vkCmdSetDiscardRectangleEXT_ptr(commandBuffer, firstDiscardRectangle, discardRectangleCount, pDiscardRectangles);

	public typealias vkCmdSetDiscardRectangleEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 discardRectangleEnable);
	private static vkCmdSetDiscardRectangleEnableEXTFunction vkCmdSetDiscardRectangleEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDiscardRectangleEnableEXT(VkCommandBuffer commandBuffer, VkBool32 discardRectangleEnable)
		=> vkCmdSetDiscardRectangleEnableEXT_ptr(commandBuffer, discardRectangleEnable);

	public typealias vkCmdSetDiscardRectangleModeEXTFunction = function void(VkCommandBuffer commandBuffer, VkDiscardRectangleModeEXT discardRectangleMode);
	private static vkCmdSetDiscardRectangleModeEXTFunction vkCmdSetDiscardRectangleModeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDiscardRectangleModeEXT(VkCommandBuffer commandBuffer, VkDiscardRectangleModeEXT discardRectangleMode)
		=> vkCmdSetDiscardRectangleModeEXT_ptr(commandBuffer, discardRectangleMode);

	public typealias vkSetHdrMetadataEXTFunction = function void(VkDevice device, uint32 swapchainCount, VkSwapchainKHR* pSwapchains, VkHdrMetadataEXT* pMetadata);
	private static vkSetHdrMetadataEXTFunction vkSetHdrMetadataEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkSetHdrMetadataEXT(VkDevice device, uint32 swapchainCount, VkSwapchainKHR* pSwapchains, VkHdrMetadataEXT* pMetadata)
		=> vkSetHdrMetadataEXT_ptr(device, swapchainCount, pSwapchains, pMetadata);

	public typealias vkGetSwapchainStatusKHRFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain);
	private static vkGetSwapchainStatusKHRFunction vkGetSwapchainStatusKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSwapchainStatusKHR(VkDevice device, VkSwapchainKHR swapchain)
		=> vkGetSwapchainStatusKHR_ptr(device, swapchain);

	public typealias vkImportFenceWin32HandleKHRFunction = function VkResult(VkDevice device, VkImportFenceWin32HandleInfoKHR* pImportFenceWin32HandleInfo);
	private static vkImportFenceWin32HandleKHRFunction vkImportFenceWin32HandleKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkImportFenceWin32HandleKHR(VkDevice device, VkImportFenceWin32HandleInfoKHR* pImportFenceWin32HandleInfo)
		=> vkImportFenceWin32HandleKHR_ptr(device, pImportFenceWin32HandleInfo);

	public typealias vkGetFenceWin32HandleKHRFunction = function VkResult(VkDevice device, VkFenceGetWin32HandleInfoKHR* pGetWin32HandleInfo, void* pHandle);
	private static vkGetFenceWin32HandleKHRFunction vkGetFenceWin32HandleKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetFenceWin32HandleKHR(VkDevice device, VkFenceGetWin32HandleInfoKHR* pGetWin32HandleInfo, void* pHandle)
		=> vkGetFenceWin32HandleKHR_ptr(device, pGetWin32HandleInfo, pHandle);

	public typealias vkImportFenceFdKHRFunction = function VkResult(VkDevice device, VkImportFenceFdInfoKHR* pImportFenceFdInfo);
	private static vkImportFenceFdKHRFunction vkImportFenceFdKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkImportFenceFdKHR(VkDevice device, VkImportFenceFdInfoKHR* pImportFenceFdInfo)
		=> vkImportFenceFdKHR_ptr(device, pImportFenceFdInfo);

	public typealias vkGetFenceFdKHRFunction = function VkResult(VkDevice device, VkFenceGetFdInfoKHR* pGetFdInfo, int* pFd);
	private static vkGetFenceFdKHRFunction vkGetFenceFdKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetFenceFdKHR(VkDevice device, VkFenceGetFdInfoKHR* pGetFdInfo, int* pFd)
		=> vkGetFenceFdKHR_ptr(device, pGetFdInfo, pFd);

	public typealias vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, uint32* pCounterCount, VkPerformanceCounterKHR* pCounters, VkPerformanceCounterDescriptionKHR* pCounterDescriptions);
	private static vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHRFunction vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, uint32* pCounterCount, VkPerformanceCounterKHR* pCounters, VkPerformanceCounterDescriptionKHR* pCounterDescriptions)
		=> vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR_ptr(physicalDevice, queueFamilyIndex, pCounterCount, pCounters, pCounterDescriptions);

	public typealias vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHRFunction = function void(VkPhysicalDevice physicalDevice, VkQueryPoolPerformanceCreateInfoKHR* pPerformanceQueryCreateInfo, uint32* pNumPasses);
	private static vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHRFunction vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR(VkPhysicalDevice physicalDevice, VkQueryPoolPerformanceCreateInfoKHR* pPerformanceQueryCreateInfo, uint32* pNumPasses)
		=> vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR_ptr(physicalDevice, pPerformanceQueryCreateInfo, pNumPasses);

	public typealias vkAcquireProfilingLockKHRFunction = function VkResult(VkDevice device, VkAcquireProfilingLockInfoKHR* pInfo);
	private static vkAcquireProfilingLockKHRFunction vkAcquireProfilingLockKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAcquireProfilingLockKHR(VkDevice device, VkAcquireProfilingLockInfoKHR* pInfo)
		=> vkAcquireProfilingLockKHR_ptr(device, pInfo);

	public typealias vkReleaseProfilingLockKHRFunction = function void(VkDevice device);
	private static vkReleaseProfilingLockKHRFunction vkReleaseProfilingLockKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkReleaseProfilingLockKHR(VkDevice device)
		=> vkReleaseProfilingLockKHR_ptr(device);

	public typealias vkGetPhysicalDeviceSurfaceCapabilities2KHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkPhysicalDeviceSurfaceInfo2KHR* pSurfaceInfo, VkSurfaceCapabilities2KHR* pSurfaceCapabilities);
	private static vkGetPhysicalDeviceSurfaceCapabilities2KHRFunction vkGetPhysicalDeviceSurfaceCapabilities2KHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSurfaceCapabilities2KHR(VkPhysicalDevice physicalDevice, VkPhysicalDeviceSurfaceInfo2KHR* pSurfaceInfo, VkSurfaceCapabilities2KHR* pSurfaceCapabilities)
		=> vkGetPhysicalDeviceSurfaceCapabilities2KHR_ptr(physicalDevice, pSurfaceInfo, pSurfaceCapabilities);

	public typealias vkGetPhysicalDeviceSurfaceFormats2KHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkPhysicalDeviceSurfaceInfo2KHR* pSurfaceInfo, uint32* pSurfaceFormatCount, VkSurfaceFormat2KHR* pSurfaceFormats);
	private static vkGetPhysicalDeviceSurfaceFormats2KHRFunction vkGetPhysicalDeviceSurfaceFormats2KHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSurfaceFormats2KHR(VkPhysicalDevice physicalDevice, VkPhysicalDeviceSurfaceInfo2KHR* pSurfaceInfo, uint32* pSurfaceFormatCount, VkSurfaceFormat2KHR* pSurfaceFormats)
		=> vkGetPhysicalDeviceSurfaceFormats2KHR_ptr(physicalDevice, pSurfaceInfo, pSurfaceFormatCount, pSurfaceFormats);

	public typealias vkGetPhysicalDeviceDisplayProperties2KHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkDisplayProperties2KHR* pProperties);
	private static vkGetPhysicalDeviceDisplayProperties2KHRFunction vkGetPhysicalDeviceDisplayProperties2KHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceDisplayProperties2KHR(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkDisplayProperties2KHR* pProperties)
		=> vkGetPhysicalDeviceDisplayProperties2KHR_ptr(physicalDevice, pPropertyCount, pProperties);

	public typealias vkGetPhysicalDeviceDisplayPlaneProperties2KHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkDisplayPlaneProperties2KHR* pProperties);
	private static vkGetPhysicalDeviceDisplayPlaneProperties2KHRFunction vkGetPhysicalDeviceDisplayPlaneProperties2KHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceDisplayPlaneProperties2KHR(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkDisplayPlaneProperties2KHR* pProperties)
		=> vkGetPhysicalDeviceDisplayPlaneProperties2KHR_ptr(physicalDevice, pPropertyCount, pProperties);

	public typealias vkGetDisplayModeProperties2KHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkDisplayKHR display, uint32* pPropertyCount, VkDisplayModeProperties2KHR* pProperties);
	private static vkGetDisplayModeProperties2KHRFunction vkGetDisplayModeProperties2KHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDisplayModeProperties2KHR(VkPhysicalDevice physicalDevice, VkDisplayKHR display, uint32* pPropertyCount, VkDisplayModeProperties2KHR* pProperties)
		=> vkGetDisplayModeProperties2KHR_ptr(physicalDevice, display, pPropertyCount, pProperties);

	public typealias vkGetDisplayPlaneCapabilities2KHRFunction = function VkResult(VkPhysicalDevice physicalDevice, VkDisplayPlaneInfo2KHR* pDisplayPlaneInfo, VkDisplayPlaneCapabilities2KHR* pCapabilities);
	private static vkGetDisplayPlaneCapabilities2KHRFunction vkGetDisplayPlaneCapabilities2KHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDisplayPlaneCapabilities2KHR(VkPhysicalDevice physicalDevice, VkDisplayPlaneInfo2KHR* pDisplayPlaneInfo, VkDisplayPlaneCapabilities2KHR* pCapabilities)
		=> vkGetDisplayPlaneCapabilities2KHR_ptr(physicalDevice, pDisplayPlaneInfo, pCapabilities);

	public typealias vkCreateIOSSurfaceMVKFunction = function VkResult(VkInstance instance, VkIOSSurfaceCreateInfoMVK* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateIOSSurfaceMVKFunction vkCreateIOSSurfaceMVK_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateIOSSurfaceMVK(VkInstance instance, VkIOSSurfaceCreateInfoMVK* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateIOSSurfaceMVK_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkCreateMacOSSurfaceMVKFunction = function VkResult(VkInstance instance, VkMacOSSurfaceCreateInfoMVK* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateMacOSSurfaceMVKFunction vkCreateMacOSSurfaceMVK_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateMacOSSurfaceMVK(VkInstance instance, VkMacOSSurfaceCreateInfoMVK* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateMacOSSurfaceMVK_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkSetDebugUtilsObjectNameEXTFunction = function VkResult(VkDevice device, VkDebugUtilsObjectNameInfoEXT* pNameInfo);
	private static vkSetDebugUtilsObjectNameEXTFunction vkSetDebugUtilsObjectNameEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkSetDebugUtilsObjectNameEXT(VkDevice device, VkDebugUtilsObjectNameInfoEXT* pNameInfo)
		=> vkSetDebugUtilsObjectNameEXT_ptr(device, pNameInfo);

	public typealias vkSetDebugUtilsObjectTagEXTFunction = function VkResult(VkDevice device, VkDebugUtilsObjectTagInfoEXT* pTagInfo);
	private static vkSetDebugUtilsObjectTagEXTFunction vkSetDebugUtilsObjectTagEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkSetDebugUtilsObjectTagEXT(VkDevice device, VkDebugUtilsObjectTagInfoEXT* pTagInfo)
		=> vkSetDebugUtilsObjectTagEXT_ptr(device, pTagInfo);

	public typealias vkQueueBeginDebugUtilsLabelEXTFunction = function void(VkQueue queue, VkDebugUtilsLabelEXT* pLabelInfo);
	private static vkQueueBeginDebugUtilsLabelEXTFunction vkQueueBeginDebugUtilsLabelEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkQueueBeginDebugUtilsLabelEXT(VkQueue queue, VkDebugUtilsLabelEXT* pLabelInfo)
		=> vkQueueBeginDebugUtilsLabelEXT_ptr(queue, pLabelInfo);

	public typealias vkQueueEndDebugUtilsLabelEXTFunction = function void(VkQueue queue);
	private static vkQueueEndDebugUtilsLabelEXTFunction vkQueueEndDebugUtilsLabelEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkQueueEndDebugUtilsLabelEXT(VkQueue queue)
		=> vkQueueEndDebugUtilsLabelEXT_ptr(queue);

	public typealias vkQueueInsertDebugUtilsLabelEXTFunction = function void(VkQueue queue, VkDebugUtilsLabelEXT* pLabelInfo);
	private static vkQueueInsertDebugUtilsLabelEXTFunction vkQueueInsertDebugUtilsLabelEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkQueueInsertDebugUtilsLabelEXT(VkQueue queue, VkDebugUtilsLabelEXT* pLabelInfo)
		=> vkQueueInsertDebugUtilsLabelEXT_ptr(queue, pLabelInfo);

	public typealias vkCmdBeginDebugUtilsLabelEXTFunction = function void(VkCommandBuffer commandBuffer, VkDebugUtilsLabelEXT* pLabelInfo);
	private static vkCmdBeginDebugUtilsLabelEXTFunction vkCmdBeginDebugUtilsLabelEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBeginDebugUtilsLabelEXT(VkCommandBuffer commandBuffer, VkDebugUtilsLabelEXT* pLabelInfo)
		=> vkCmdBeginDebugUtilsLabelEXT_ptr(commandBuffer, pLabelInfo);

	public typealias vkCmdEndDebugUtilsLabelEXTFunction = function void(VkCommandBuffer commandBuffer);
	private static vkCmdEndDebugUtilsLabelEXTFunction vkCmdEndDebugUtilsLabelEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEndDebugUtilsLabelEXT(VkCommandBuffer commandBuffer)
		=> vkCmdEndDebugUtilsLabelEXT_ptr(commandBuffer);

	public typealias vkCmdInsertDebugUtilsLabelEXTFunction = function void(VkCommandBuffer commandBuffer, VkDebugUtilsLabelEXT* pLabelInfo);
	private static vkCmdInsertDebugUtilsLabelEXTFunction vkCmdInsertDebugUtilsLabelEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdInsertDebugUtilsLabelEXT(VkCommandBuffer commandBuffer, VkDebugUtilsLabelEXT* pLabelInfo)
		=> vkCmdInsertDebugUtilsLabelEXT_ptr(commandBuffer, pLabelInfo);

	public typealias vkCreateDebugUtilsMessengerEXTFunction = function VkResult(VkInstance instance, VkDebugUtilsMessengerCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDebugUtilsMessengerEXT* pMessenger);
	private static vkCreateDebugUtilsMessengerEXTFunction vkCreateDebugUtilsMessengerEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDebugUtilsMessengerEXT(VkInstance instance, VkDebugUtilsMessengerCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkDebugUtilsMessengerEXT* pMessenger)
		=> vkCreateDebugUtilsMessengerEXT_ptr(instance, pCreateInfo, pAllocator, pMessenger);

	public typealias vkDestroyDebugUtilsMessengerEXTFunction = function void(VkInstance instance, VkDebugUtilsMessengerEXT messenger, VkAllocationCallbacks* pAllocator);
	private static vkDestroyDebugUtilsMessengerEXTFunction vkDestroyDebugUtilsMessengerEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyDebugUtilsMessengerEXT(VkInstance instance, VkDebugUtilsMessengerEXT messenger, VkAllocationCallbacks* pAllocator)
		=> vkDestroyDebugUtilsMessengerEXT_ptr(instance, messenger, pAllocator);

	public typealias vkSubmitDebugUtilsMessageEXTFunction = function void(VkInstance instance, VkDebugUtilsMessageSeverityFlagsEXT messageSeverity, VkDebugUtilsMessageTypeFlagsEXT messageTypes, VkDebugUtilsMessengerCallbackDataEXT* pCallbackData);
	private static vkSubmitDebugUtilsMessageEXTFunction vkSubmitDebugUtilsMessageEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkSubmitDebugUtilsMessageEXT(VkInstance instance, VkDebugUtilsMessageSeverityFlagsEXT messageSeverity, VkDebugUtilsMessageTypeFlagsEXT messageTypes, VkDebugUtilsMessengerCallbackDataEXT* pCallbackData)
		=> vkSubmitDebugUtilsMessageEXT_ptr(instance, messageSeverity, messageTypes, pCallbackData);

	public typealias vkGetAndroidHardwareBufferPropertiesANDROIDFunction = function VkResult(VkDevice device, void* buffer, VkAndroidHardwareBufferPropertiesANDROID* pProperties);
	private static vkGetAndroidHardwareBufferPropertiesANDROIDFunction vkGetAndroidHardwareBufferPropertiesANDROID_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetAndroidHardwareBufferPropertiesANDROID(VkDevice device, void* buffer, VkAndroidHardwareBufferPropertiesANDROID* pProperties)
		=> vkGetAndroidHardwareBufferPropertiesANDROID_ptr(device, buffer, pProperties);

	public typealias vkGetMemoryAndroidHardwareBufferANDROIDFunction = function VkResult(VkDevice device, VkMemoryGetAndroidHardwareBufferInfoANDROID* pInfo, void* pBuffer);
	private static vkGetMemoryAndroidHardwareBufferANDROIDFunction vkGetMemoryAndroidHardwareBufferANDROID_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryAndroidHardwareBufferANDROID(VkDevice device, VkMemoryGetAndroidHardwareBufferInfoANDROID* pInfo, void* pBuffer)
		=> vkGetMemoryAndroidHardwareBufferANDROID_ptr(device, pInfo, pBuffer);

	public typealias vkCmdSetSampleLocationsEXTFunction = function void(VkCommandBuffer commandBuffer, VkSampleLocationsInfoEXT* pSampleLocationsInfo);
	private static vkCmdSetSampleLocationsEXTFunction vkCmdSetSampleLocationsEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetSampleLocationsEXT(VkCommandBuffer commandBuffer, VkSampleLocationsInfoEXT* pSampleLocationsInfo)
		=> vkCmdSetSampleLocationsEXT_ptr(commandBuffer, pSampleLocationsInfo);

	public typealias vkGetPhysicalDeviceMultisamplePropertiesEXTFunction = function void(VkPhysicalDevice physicalDevice, VkSampleCountFlags samples, VkMultisamplePropertiesEXT* pMultisampleProperties);
	private static vkGetPhysicalDeviceMultisamplePropertiesEXTFunction vkGetPhysicalDeviceMultisamplePropertiesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetPhysicalDeviceMultisamplePropertiesEXT(VkPhysicalDevice physicalDevice, VkSampleCountFlags samples, VkMultisamplePropertiesEXT* pMultisampleProperties)
		=> vkGetPhysicalDeviceMultisamplePropertiesEXT_ptr(physicalDevice, samples, pMultisampleProperties);

	public typealias vkCreateAccelerationStructureKHRFunction = function VkResult(VkDevice device, VkAccelerationStructureCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkAccelerationStructureKHR* pAccelerationStructure);
	private static vkCreateAccelerationStructureKHRFunction vkCreateAccelerationStructureKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateAccelerationStructureKHR(VkDevice device, VkAccelerationStructureCreateInfoKHR* pCreateInfo, VkAllocationCallbacks* pAllocator, VkAccelerationStructureKHR* pAccelerationStructure)
		=> vkCreateAccelerationStructureKHR_ptr(device, pCreateInfo, pAllocator, pAccelerationStructure);

	public typealias vkDestroyAccelerationStructureKHRFunction = function void(VkDevice device, VkAccelerationStructureKHR accelerationStructure, VkAllocationCallbacks* pAllocator);
	private static vkDestroyAccelerationStructureKHRFunction vkDestroyAccelerationStructureKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyAccelerationStructureKHR(VkDevice device, VkAccelerationStructureKHR accelerationStructure, VkAllocationCallbacks* pAllocator)
		=> vkDestroyAccelerationStructureKHR_ptr(device, accelerationStructure, pAllocator);

	public typealias vkCmdBuildAccelerationStructuresKHRFunction = function void(VkCommandBuffer commandBuffer, uint32 infoCount, VkAccelerationStructureBuildGeometryInfoKHR* pInfos, VkAccelerationStructureBuildRangeInfoKHR** ppBuildRangeInfos);
	private static vkCmdBuildAccelerationStructuresKHRFunction vkCmdBuildAccelerationStructuresKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBuildAccelerationStructuresKHR(VkCommandBuffer commandBuffer, uint32 infoCount, VkAccelerationStructureBuildGeometryInfoKHR* pInfos, VkAccelerationStructureBuildRangeInfoKHR** ppBuildRangeInfos)
		=> vkCmdBuildAccelerationStructuresKHR_ptr(commandBuffer, infoCount, pInfos, ppBuildRangeInfos);

	public typealias vkCmdBuildAccelerationStructuresIndirectKHRFunction = function void(VkCommandBuffer commandBuffer, uint32 infoCount, VkAccelerationStructureBuildGeometryInfoKHR* pInfos, uint64* pIndirectDeviceAddresses, uint32* pIndirectStrides, uint32** ppMaxPrimitiveCounts);
	private static vkCmdBuildAccelerationStructuresIndirectKHRFunction vkCmdBuildAccelerationStructuresIndirectKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBuildAccelerationStructuresIndirectKHR(VkCommandBuffer commandBuffer, uint32 infoCount, VkAccelerationStructureBuildGeometryInfoKHR* pInfos, uint64* pIndirectDeviceAddresses, uint32* pIndirectStrides, uint32** ppMaxPrimitiveCounts)
		=> vkCmdBuildAccelerationStructuresIndirectKHR_ptr(commandBuffer, infoCount, pInfos, pIndirectDeviceAddresses, pIndirectStrides, ppMaxPrimitiveCounts);

	public typealias vkBuildAccelerationStructuresKHRFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, uint32 infoCount, VkAccelerationStructureBuildGeometryInfoKHR* pInfos, VkAccelerationStructureBuildRangeInfoKHR** ppBuildRangeInfos);
	private static vkBuildAccelerationStructuresKHRFunction vkBuildAccelerationStructuresKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBuildAccelerationStructuresKHR(VkDevice device, VkDeferredOperationKHR deferredOperation, uint32 infoCount, VkAccelerationStructureBuildGeometryInfoKHR* pInfos, VkAccelerationStructureBuildRangeInfoKHR** ppBuildRangeInfos)
		=> vkBuildAccelerationStructuresKHR_ptr(device, deferredOperation, infoCount, pInfos, ppBuildRangeInfos);

	public typealias vkCopyAccelerationStructureKHRFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyAccelerationStructureInfoKHR* pInfo);
	private static vkCopyAccelerationStructureKHRFunction vkCopyAccelerationStructureKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCopyAccelerationStructureKHR(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyAccelerationStructureInfoKHR* pInfo)
		=> vkCopyAccelerationStructureKHR_ptr(device, deferredOperation, pInfo);

	public typealias vkCopyAccelerationStructureToMemoryKHRFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyAccelerationStructureToMemoryInfoKHR* pInfo);
	private static vkCopyAccelerationStructureToMemoryKHRFunction vkCopyAccelerationStructureToMemoryKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCopyAccelerationStructureToMemoryKHR(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyAccelerationStructureToMemoryInfoKHR* pInfo)
		=> vkCopyAccelerationStructureToMemoryKHR_ptr(device, deferredOperation, pInfo);

	public typealias vkCopyMemoryToAccelerationStructureKHRFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyMemoryToAccelerationStructureInfoKHR* pInfo);
	private static vkCopyMemoryToAccelerationStructureKHRFunction vkCopyMemoryToAccelerationStructureKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCopyMemoryToAccelerationStructureKHR(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyMemoryToAccelerationStructureInfoKHR* pInfo)
		=> vkCopyMemoryToAccelerationStructureKHR_ptr(device, deferredOperation, pInfo);

	public typealias vkWriteAccelerationStructuresPropertiesKHRFunction = function VkResult(VkDevice device, uint32 accelerationStructureCount, VkAccelerationStructureKHR* pAccelerationStructures, VkQueryType queryType, uint dataSize, void* pData, uint stride);
	private static vkWriteAccelerationStructuresPropertiesKHRFunction vkWriteAccelerationStructuresPropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkWriteAccelerationStructuresPropertiesKHR(VkDevice device, uint32 accelerationStructureCount, VkAccelerationStructureKHR* pAccelerationStructures, VkQueryType queryType, uint dataSize, void* pData, uint stride)
		=> vkWriteAccelerationStructuresPropertiesKHR_ptr(device, accelerationStructureCount, pAccelerationStructures, queryType, dataSize, pData, stride);

	public typealias vkCmdCopyAccelerationStructureKHRFunction = function void(VkCommandBuffer commandBuffer, VkCopyAccelerationStructureInfoKHR* pInfo);
	private static vkCmdCopyAccelerationStructureKHRFunction vkCmdCopyAccelerationStructureKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyAccelerationStructureKHR(VkCommandBuffer commandBuffer, VkCopyAccelerationStructureInfoKHR* pInfo)
		=> vkCmdCopyAccelerationStructureKHR_ptr(commandBuffer, pInfo);

	public typealias vkCmdCopyAccelerationStructureToMemoryKHRFunction = function void(VkCommandBuffer commandBuffer, VkCopyAccelerationStructureToMemoryInfoKHR* pInfo);
	private static vkCmdCopyAccelerationStructureToMemoryKHRFunction vkCmdCopyAccelerationStructureToMemoryKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyAccelerationStructureToMemoryKHR(VkCommandBuffer commandBuffer, VkCopyAccelerationStructureToMemoryInfoKHR* pInfo)
		=> vkCmdCopyAccelerationStructureToMemoryKHR_ptr(commandBuffer, pInfo);

	public typealias vkCmdCopyMemoryToAccelerationStructureKHRFunction = function void(VkCommandBuffer commandBuffer, VkCopyMemoryToAccelerationStructureInfoKHR* pInfo);
	private static vkCmdCopyMemoryToAccelerationStructureKHRFunction vkCmdCopyMemoryToAccelerationStructureKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyMemoryToAccelerationStructureKHR(VkCommandBuffer commandBuffer, VkCopyMemoryToAccelerationStructureInfoKHR* pInfo)
		=> vkCmdCopyMemoryToAccelerationStructureKHR_ptr(commandBuffer, pInfo);

	public typealias vkGetAccelerationStructureDeviceAddressKHRFunction = function uint64(VkDevice device, VkAccelerationStructureDeviceAddressInfoKHR* pInfo);
	private static vkGetAccelerationStructureDeviceAddressKHRFunction vkGetAccelerationStructureDeviceAddressKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static uint64 vkGetAccelerationStructureDeviceAddressKHR(VkDevice device, VkAccelerationStructureDeviceAddressInfoKHR* pInfo)
		=> vkGetAccelerationStructureDeviceAddressKHR_ptr(device, pInfo);

	public typealias vkCmdWriteAccelerationStructuresPropertiesKHRFunction = function void(VkCommandBuffer commandBuffer, uint32 accelerationStructureCount, VkAccelerationStructureKHR* pAccelerationStructures, VkQueryType queryType, VkQueryPool queryPool, uint32 firstQuery);
	private static vkCmdWriteAccelerationStructuresPropertiesKHRFunction vkCmdWriteAccelerationStructuresPropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdWriteAccelerationStructuresPropertiesKHR(VkCommandBuffer commandBuffer, uint32 accelerationStructureCount, VkAccelerationStructureKHR* pAccelerationStructures, VkQueryType queryType, VkQueryPool queryPool, uint32 firstQuery)
		=> vkCmdWriteAccelerationStructuresPropertiesKHR_ptr(commandBuffer, accelerationStructureCount, pAccelerationStructures, queryType, queryPool, firstQuery);

	public typealias vkGetDeviceAccelerationStructureCompatibilityKHRFunction = function void(VkDevice device, VkAccelerationStructureVersionInfoKHR* pVersionInfo, VkAccelerationStructureCompatibilityKHR* pCompatibility);
	private static vkGetDeviceAccelerationStructureCompatibilityKHRFunction vkGetDeviceAccelerationStructureCompatibilityKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceAccelerationStructureCompatibilityKHR(VkDevice device, VkAccelerationStructureVersionInfoKHR* pVersionInfo, VkAccelerationStructureCompatibilityKHR* pCompatibility)
		=> vkGetDeviceAccelerationStructureCompatibilityKHR_ptr(device, pVersionInfo, pCompatibility);

	public typealias vkGetAccelerationStructureBuildSizesKHRFunction = function void(VkDevice device, VkAccelerationStructureBuildTypeKHR buildType, VkAccelerationStructureBuildGeometryInfoKHR* pBuildInfo, uint32* pMaxPrimitiveCounts, VkAccelerationStructureBuildSizesInfoKHR* pSizeInfo);
	private static vkGetAccelerationStructureBuildSizesKHRFunction vkGetAccelerationStructureBuildSizesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetAccelerationStructureBuildSizesKHR(VkDevice device, VkAccelerationStructureBuildTypeKHR buildType, VkAccelerationStructureBuildGeometryInfoKHR* pBuildInfo, uint32* pMaxPrimitiveCounts, VkAccelerationStructureBuildSizesInfoKHR* pSizeInfo)
		=> vkGetAccelerationStructureBuildSizesKHR_ptr(device, buildType, pBuildInfo, pMaxPrimitiveCounts, pSizeInfo);

	public typealias vkCmdTraceRaysKHRFunction = function void(VkCommandBuffer commandBuffer, VkStridedDeviceAddressRegionKHR* pRaygenShaderBindingTable, VkStridedDeviceAddressRegionKHR* pMissShaderBindingTable, VkStridedDeviceAddressRegionKHR* pHitShaderBindingTable, VkStridedDeviceAddressRegionKHR* pCallableShaderBindingTable, uint32 width, uint32 height, uint32 depth);
	private static vkCmdTraceRaysKHRFunction vkCmdTraceRaysKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdTraceRaysKHR(VkCommandBuffer commandBuffer, VkStridedDeviceAddressRegionKHR* pRaygenShaderBindingTable, VkStridedDeviceAddressRegionKHR* pMissShaderBindingTable, VkStridedDeviceAddressRegionKHR* pHitShaderBindingTable, VkStridedDeviceAddressRegionKHR* pCallableShaderBindingTable, uint32 width, uint32 height, uint32 depth)
		=> vkCmdTraceRaysKHR_ptr(commandBuffer, pRaygenShaderBindingTable, pMissShaderBindingTable, pHitShaderBindingTable, pCallableShaderBindingTable, width, height, depth);

	public typealias vkCreateRayTracingPipelinesKHRFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, VkPipelineCache pipelineCache, uint32 createInfoCount, VkRayTracingPipelineCreateInfoKHR* pCreateInfos, VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines);
	private static vkCreateRayTracingPipelinesKHRFunction vkCreateRayTracingPipelinesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateRayTracingPipelinesKHR(VkDevice device, VkDeferredOperationKHR deferredOperation, VkPipelineCache pipelineCache, uint32 createInfoCount, VkRayTracingPipelineCreateInfoKHR* pCreateInfos, VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines)
		=> vkCreateRayTracingPipelinesKHR_ptr(device, deferredOperation, pipelineCache, createInfoCount, pCreateInfos, pAllocator, pPipelines);

	public typealias vkGetRayTracingShaderGroupHandlesKHRFunction = function VkResult(VkDevice device, VkPipeline pipeline, uint32 firstGroup, uint32 groupCount, uint dataSize, void* pData);
	private static vkGetRayTracingShaderGroupHandlesKHRFunction vkGetRayTracingShaderGroupHandlesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetRayTracingShaderGroupHandlesKHR(VkDevice device, VkPipeline pipeline, uint32 firstGroup, uint32 groupCount, uint dataSize, void* pData)
		=> vkGetRayTracingShaderGroupHandlesKHR_ptr(device, pipeline, firstGroup, groupCount, dataSize, pData);

	public typealias vkGetRayTracingCaptureReplayShaderGroupHandlesKHRFunction = function VkResult(VkDevice device, VkPipeline pipeline, uint32 firstGroup, uint32 groupCount, uint dataSize, void* pData);
	private static vkGetRayTracingCaptureReplayShaderGroupHandlesKHRFunction vkGetRayTracingCaptureReplayShaderGroupHandlesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetRayTracingCaptureReplayShaderGroupHandlesKHR(VkDevice device, VkPipeline pipeline, uint32 firstGroup, uint32 groupCount, uint dataSize, void* pData)
		=> vkGetRayTracingCaptureReplayShaderGroupHandlesKHR_ptr(device, pipeline, firstGroup, groupCount, dataSize, pData);

	public typealias vkCmdTraceRaysIndirectKHRFunction = function void(VkCommandBuffer commandBuffer, VkStridedDeviceAddressRegionKHR* pRaygenShaderBindingTable, VkStridedDeviceAddressRegionKHR* pMissShaderBindingTable, VkStridedDeviceAddressRegionKHR* pHitShaderBindingTable, VkStridedDeviceAddressRegionKHR* pCallableShaderBindingTable, uint64 indirectDeviceAddress);
	private static vkCmdTraceRaysIndirectKHRFunction vkCmdTraceRaysIndirectKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdTraceRaysIndirectKHR(VkCommandBuffer commandBuffer, VkStridedDeviceAddressRegionKHR* pRaygenShaderBindingTable, VkStridedDeviceAddressRegionKHR* pMissShaderBindingTable, VkStridedDeviceAddressRegionKHR* pHitShaderBindingTable, VkStridedDeviceAddressRegionKHR* pCallableShaderBindingTable, uint64 indirectDeviceAddress)
		=> vkCmdTraceRaysIndirectKHR_ptr(commandBuffer, pRaygenShaderBindingTable, pMissShaderBindingTable, pHitShaderBindingTable, pCallableShaderBindingTable, indirectDeviceAddress);

	public typealias vkGetRayTracingShaderGroupStackSizeKHRFunction = function uint64(VkDevice device, VkPipeline pipeline, uint32 group, VkShaderGroupShaderKHR groupShader);
	private static vkGetRayTracingShaderGroupStackSizeKHRFunction vkGetRayTracingShaderGroupStackSizeKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static uint64 vkGetRayTracingShaderGroupStackSizeKHR(VkDevice device, VkPipeline pipeline, uint32 group, VkShaderGroupShaderKHR groupShader)
		=> vkGetRayTracingShaderGroupStackSizeKHR_ptr(device, pipeline, group, groupShader);

	public typealias vkCmdSetRayTracingPipelineStackSizeKHRFunction = function void(VkCommandBuffer commandBuffer, uint32 pipelineStackSize);
	private static vkCmdSetRayTracingPipelineStackSizeKHRFunction vkCmdSetRayTracingPipelineStackSizeKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetRayTracingPipelineStackSizeKHR(VkCommandBuffer commandBuffer, uint32 pipelineStackSize)
		=> vkCmdSetRayTracingPipelineStackSizeKHR_ptr(commandBuffer, pipelineStackSize);

	public typealias vkGetImageDrmFormatModifierPropertiesEXTFunction = function VkResult(VkDevice device, VkImage image, VkImageDrmFormatModifierPropertiesEXT* pProperties);
	private static vkGetImageDrmFormatModifierPropertiesEXTFunction vkGetImageDrmFormatModifierPropertiesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetImageDrmFormatModifierPropertiesEXT(VkDevice device, VkImage image, VkImageDrmFormatModifierPropertiesEXT* pProperties)
		=> vkGetImageDrmFormatModifierPropertiesEXT_ptr(device, image, pProperties);

	public typealias vkCreateValidationCacheEXTFunction = function VkResult(VkDevice device, VkValidationCacheCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkValidationCacheEXT* pValidationCache);
	private static vkCreateValidationCacheEXTFunction vkCreateValidationCacheEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateValidationCacheEXT(VkDevice device, VkValidationCacheCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkValidationCacheEXT* pValidationCache)
		=> vkCreateValidationCacheEXT_ptr(device, pCreateInfo, pAllocator, pValidationCache);

	public typealias vkDestroyValidationCacheEXTFunction = function void(VkDevice device, VkValidationCacheEXT validationCache, VkAllocationCallbacks* pAllocator);
	private static vkDestroyValidationCacheEXTFunction vkDestroyValidationCacheEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyValidationCacheEXT(VkDevice device, VkValidationCacheEXT validationCache, VkAllocationCallbacks* pAllocator)
		=> vkDestroyValidationCacheEXT_ptr(device, validationCache, pAllocator);

	public typealias vkMergeValidationCachesEXTFunction = function VkResult(VkDevice device, VkValidationCacheEXT dstCache, uint32 srcCacheCount, VkValidationCacheEXT* pSrcCaches);
	private static vkMergeValidationCachesEXTFunction vkMergeValidationCachesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkMergeValidationCachesEXT(VkDevice device, VkValidationCacheEXT dstCache, uint32 srcCacheCount, VkValidationCacheEXT* pSrcCaches)
		=> vkMergeValidationCachesEXT_ptr(device, dstCache, srcCacheCount, pSrcCaches);

	public typealias vkGetValidationCacheDataEXTFunction = function VkResult(VkDevice device, VkValidationCacheEXT validationCache, uint* pDataSize, void* pData);
	private static vkGetValidationCacheDataEXTFunction vkGetValidationCacheDataEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetValidationCacheDataEXT(VkDevice device, VkValidationCacheEXT validationCache, uint* pDataSize, void* pData)
		=> vkGetValidationCacheDataEXT_ptr(device, validationCache, pDataSize, pData);

	public typealias vkCmdBindShadingRateImageNVFunction = function void(VkCommandBuffer commandBuffer, VkImageView imageView, VkImageLayout imageLayout);
	private static vkCmdBindShadingRateImageNVFunction vkCmdBindShadingRateImageNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindShadingRateImageNV(VkCommandBuffer commandBuffer, VkImageView imageView, VkImageLayout imageLayout)
		=> vkCmdBindShadingRateImageNV_ptr(commandBuffer, imageView, imageLayout);

	public typealias vkCmdSetViewportShadingRatePaletteNVFunction = function void(VkCommandBuffer commandBuffer, uint32 firstViewport, uint32 viewportCount, VkShadingRatePaletteNV* pShadingRatePalettes);
	private static vkCmdSetViewportShadingRatePaletteNVFunction vkCmdSetViewportShadingRatePaletteNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetViewportShadingRatePaletteNV(VkCommandBuffer commandBuffer, uint32 firstViewport, uint32 viewportCount, VkShadingRatePaletteNV* pShadingRatePalettes)
		=> vkCmdSetViewportShadingRatePaletteNV_ptr(commandBuffer, firstViewport, viewportCount, pShadingRatePalettes);

	public typealias vkCmdSetCoarseSampleOrderNVFunction = function void(VkCommandBuffer commandBuffer, VkCoarseSampleOrderTypeNV sampleOrderType, uint32 customSampleOrderCount, VkCoarseSampleOrderCustomNV* pCustomSampleOrders);
	private static vkCmdSetCoarseSampleOrderNVFunction vkCmdSetCoarseSampleOrderNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCoarseSampleOrderNV(VkCommandBuffer commandBuffer, VkCoarseSampleOrderTypeNV sampleOrderType, uint32 customSampleOrderCount, VkCoarseSampleOrderCustomNV* pCustomSampleOrders)
		=> vkCmdSetCoarseSampleOrderNV_ptr(commandBuffer, sampleOrderType, customSampleOrderCount, pCustomSampleOrders);

	public typealias vkCreateAccelerationStructureNVFunction = function VkResult(VkDevice device, VkAccelerationStructureCreateInfoNV* pCreateInfo, VkAllocationCallbacks* pAllocator, VkAccelerationStructureNV* pAccelerationStructure);
	private static vkCreateAccelerationStructureNVFunction vkCreateAccelerationStructureNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateAccelerationStructureNV(VkDevice device, VkAccelerationStructureCreateInfoNV* pCreateInfo, VkAllocationCallbacks* pAllocator, VkAccelerationStructureNV* pAccelerationStructure)
		=> vkCreateAccelerationStructureNV_ptr(device, pCreateInfo, pAllocator, pAccelerationStructure);

	public typealias vkDestroyAccelerationStructureNVFunction = function void(VkDevice device, VkAccelerationStructureNV accelerationStructure, VkAllocationCallbacks* pAllocator);
	private static vkDestroyAccelerationStructureNVFunction vkDestroyAccelerationStructureNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyAccelerationStructureNV(VkDevice device, VkAccelerationStructureNV accelerationStructure, VkAllocationCallbacks* pAllocator)
		=> vkDestroyAccelerationStructureNV_ptr(device, accelerationStructure, pAllocator);

	public typealias vkGetAccelerationStructureMemoryRequirementsNVFunction = function void(VkDevice device, VkAccelerationStructureMemoryRequirementsInfoNV* pInfo, VkMemoryRequirements2* pMemoryRequirements);
	private static vkGetAccelerationStructureMemoryRequirementsNVFunction vkGetAccelerationStructureMemoryRequirementsNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetAccelerationStructureMemoryRequirementsNV(VkDevice device, VkAccelerationStructureMemoryRequirementsInfoNV* pInfo, VkMemoryRequirements2* pMemoryRequirements)
		=> vkGetAccelerationStructureMemoryRequirementsNV_ptr(device, pInfo, pMemoryRequirements);

	public typealias vkBindAccelerationStructureMemoryNVFunction = function VkResult(VkDevice device, uint32 bindInfoCount, VkBindAccelerationStructureMemoryInfoNV* pBindInfos);
	private static vkBindAccelerationStructureMemoryNVFunction vkBindAccelerationStructureMemoryNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBindAccelerationStructureMemoryNV(VkDevice device, uint32 bindInfoCount, VkBindAccelerationStructureMemoryInfoNV* pBindInfos)
		=> vkBindAccelerationStructureMemoryNV_ptr(device, bindInfoCount, pBindInfos);

	public typealias vkCmdBuildAccelerationStructureNVFunction = function void(VkCommandBuffer commandBuffer, VkAccelerationStructureInfoNV* pInfo, VkBuffer instanceData, uint64 instanceOffset, VkBool32 update, VkAccelerationStructureNV dst, VkAccelerationStructureNV src, VkBuffer scratch, uint64 scratchOffset);
	private static vkCmdBuildAccelerationStructureNVFunction vkCmdBuildAccelerationStructureNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBuildAccelerationStructureNV(VkCommandBuffer commandBuffer, VkAccelerationStructureInfoNV* pInfo, VkBuffer instanceData, uint64 instanceOffset, VkBool32 update, VkAccelerationStructureNV dst, VkAccelerationStructureNV src, VkBuffer scratch, uint64 scratchOffset)
		=> vkCmdBuildAccelerationStructureNV_ptr(commandBuffer, pInfo, instanceData, instanceOffset, update, dst, src, scratch, scratchOffset);

	public typealias vkCmdCopyAccelerationStructureNVFunction = function void(VkCommandBuffer commandBuffer, VkAccelerationStructureNV dst, VkAccelerationStructureNV src, VkCopyAccelerationStructureModeKHR mode);
	private static vkCmdCopyAccelerationStructureNVFunction vkCmdCopyAccelerationStructureNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyAccelerationStructureNV(VkCommandBuffer commandBuffer, VkAccelerationStructureNV dst, VkAccelerationStructureNV src, VkCopyAccelerationStructureModeKHR mode)
		=> vkCmdCopyAccelerationStructureNV_ptr(commandBuffer, dst, src, mode);

	public typealias vkCmdTraceRaysNVFunction = function void(VkCommandBuffer commandBuffer, VkBuffer raygenShaderBindingTableBuffer, uint64 raygenShaderBindingOffset, VkBuffer missShaderBindingTableBuffer, uint64 missShaderBindingOffset, uint64 missShaderBindingStride, VkBuffer hitShaderBindingTableBuffer, uint64 hitShaderBindingOffset, uint64 hitShaderBindingStride, VkBuffer callableShaderBindingTableBuffer, uint64 callableShaderBindingOffset, uint64 callableShaderBindingStride, uint32 width, uint32 height, uint32 depth);
	private static vkCmdTraceRaysNVFunction vkCmdTraceRaysNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdTraceRaysNV(VkCommandBuffer commandBuffer, VkBuffer raygenShaderBindingTableBuffer, uint64 raygenShaderBindingOffset, VkBuffer missShaderBindingTableBuffer, uint64 missShaderBindingOffset, uint64 missShaderBindingStride, VkBuffer hitShaderBindingTableBuffer, uint64 hitShaderBindingOffset, uint64 hitShaderBindingStride, VkBuffer callableShaderBindingTableBuffer, uint64 callableShaderBindingOffset, uint64 callableShaderBindingStride, uint32 width, uint32 height, uint32 depth)
		=> vkCmdTraceRaysNV_ptr(commandBuffer, raygenShaderBindingTableBuffer, raygenShaderBindingOffset, missShaderBindingTableBuffer, missShaderBindingOffset, missShaderBindingStride, hitShaderBindingTableBuffer, hitShaderBindingOffset, hitShaderBindingStride, callableShaderBindingTableBuffer, callableShaderBindingOffset, callableShaderBindingStride, width, height, depth);

	public typealias vkCreateRayTracingPipelinesNVFunction = function VkResult(VkDevice device, VkPipelineCache pipelineCache, uint32 createInfoCount, VkRayTracingPipelineCreateInfoNV* pCreateInfos, VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines);
	private static vkCreateRayTracingPipelinesNVFunction vkCreateRayTracingPipelinesNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateRayTracingPipelinesNV(VkDevice device, VkPipelineCache pipelineCache, uint32 createInfoCount, VkRayTracingPipelineCreateInfoNV* pCreateInfos, VkAllocationCallbacks* pAllocator, VkPipeline* pPipelines)
		=> vkCreateRayTracingPipelinesNV_ptr(device, pipelineCache, createInfoCount, pCreateInfos, pAllocator, pPipelines);

	public typealias vkGetAccelerationStructureHandleNVFunction = function VkResult(VkDevice device, VkAccelerationStructureNV accelerationStructure, uint dataSize, void* pData);
	private static vkGetAccelerationStructureHandleNVFunction vkGetAccelerationStructureHandleNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetAccelerationStructureHandleNV(VkDevice device, VkAccelerationStructureNV accelerationStructure, uint dataSize, void* pData)
		=> vkGetAccelerationStructureHandleNV_ptr(device, accelerationStructure, dataSize, pData);

	public typealias vkCmdWriteAccelerationStructuresPropertiesNVFunction = function void(VkCommandBuffer commandBuffer, uint32 accelerationStructureCount, VkAccelerationStructureNV* pAccelerationStructures, VkQueryType queryType, VkQueryPool queryPool, uint32 firstQuery);
	private static vkCmdWriteAccelerationStructuresPropertiesNVFunction vkCmdWriteAccelerationStructuresPropertiesNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdWriteAccelerationStructuresPropertiesNV(VkCommandBuffer commandBuffer, uint32 accelerationStructureCount, VkAccelerationStructureNV* pAccelerationStructures, VkQueryType queryType, VkQueryPool queryPool, uint32 firstQuery)
		=> vkCmdWriteAccelerationStructuresPropertiesNV_ptr(commandBuffer, accelerationStructureCount, pAccelerationStructures, queryType, queryPool, firstQuery);

	public typealias vkCompileDeferredNVFunction = function VkResult(VkDevice device, VkPipeline pipeline, uint32 shader);
	private static vkCompileDeferredNVFunction vkCompileDeferredNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCompileDeferredNV(VkDevice device, VkPipeline pipeline, uint32 shader)
		=> vkCompileDeferredNV_ptr(device, pipeline, shader);

	public typealias vkGetMemoryHostPointerPropertiesEXTFunction = function VkResult(VkDevice device, VkExternalMemoryHandleTypeFlags handleType, void* pHostPointer, VkMemoryHostPointerPropertiesEXT* pMemoryHostPointerProperties);
	private static vkGetMemoryHostPointerPropertiesEXTFunction vkGetMemoryHostPointerPropertiesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryHostPointerPropertiesEXT(VkDevice device, VkExternalMemoryHandleTypeFlags handleType, void* pHostPointer, VkMemoryHostPointerPropertiesEXT* pMemoryHostPointerProperties)
		=> vkGetMemoryHostPointerPropertiesEXT_ptr(device, handleType, pHostPointer, pMemoryHostPointerProperties);

	public typealias vkCmdWriteBufferMarkerAMDFunction = function void(VkCommandBuffer commandBuffer, VkPipelineStageFlags pipelineStage, VkBuffer dstBuffer, uint64 dstOffset, uint32 marker);
	private static vkCmdWriteBufferMarkerAMDFunction vkCmdWriteBufferMarkerAMD_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdWriteBufferMarkerAMD(VkCommandBuffer commandBuffer, VkPipelineStageFlags pipelineStage, VkBuffer dstBuffer, uint64 dstOffset, uint32 marker)
		=> vkCmdWriteBufferMarkerAMD_ptr(commandBuffer, pipelineStage, dstBuffer, dstOffset, marker);

	public typealias vkGetPhysicalDeviceCalibrateableTimeDomainsEXTFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pTimeDomainCount, VkTimeDomainEXT* pTimeDomains);
	private static vkGetPhysicalDeviceCalibrateableTimeDomainsEXTFunction vkGetPhysicalDeviceCalibrateableTimeDomainsEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceCalibrateableTimeDomainsEXT(VkPhysicalDevice physicalDevice, uint32* pTimeDomainCount, VkTimeDomainEXT* pTimeDomains)
		=> vkGetPhysicalDeviceCalibrateableTimeDomainsEXT_ptr(physicalDevice, pTimeDomainCount, pTimeDomains);

	public typealias vkGetCalibratedTimestampsEXTFunction = function VkResult(VkDevice device, uint32 timestampCount, VkCalibratedTimestampInfoEXT* pTimestampInfos, uint64* pTimestamps, uint64* pMaxDeviation);
	private static vkGetCalibratedTimestampsEXTFunction vkGetCalibratedTimestampsEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetCalibratedTimestampsEXT(VkDevice device, uint32 timestampCount, VkCalibratedTimestampInfoEXT* pTimestampInfos, uint64* pTimestamps, uint64* pMaxDeviation)
		=> vkGetCalibratedTimestampsEXT_ptr(device, timestampCount, pTimestampInfos, pTimestamps, pMaxDeviation);

	public typealias vkCmdDrawMeshTasksNVFunction = function void(VkCommandBuffer commandBuffer, uint32 taskCount, uint32 firstTask);
	private static vkCmdDrawMeshTasksNVFunction vkCmdDrawMeshTasksNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawMeshTasksNV(VkCommandBuffer commandBuffer, uint32 taskCount, uint32 firstTask)
		=> vkCmdDrawMeshTasksNV_ptr(commandBuffer, taskCount, firstTask);

	public typealias vkCmdDrawMeshTasksIndirectNVFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, uint32 drawCount, uint32 stride);
	private static vkCmdDrawMeshTasksIndirectNVFunction vkCmdDrawMeshTasksIndirectNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawMeshTasksIndirectNV(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, uint32 drawCount, uint32 stride)
		=> vkCmdDrawMeshTasksIndirectNV_ptr(commandBuffer, buffer, offset, drawCount, stride);

	public typealias vkCmdDrawMeshTasksIndirectCountNVFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkBuffer countBuffer, uint64 countBufferOffset, uint32 maxDrawCount, uint32 stride);
	private static vkCmdDrawMeshTasksIndirectCountNVFunction vkCmdDrawMeshTasksIndirectCountNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawMeshTasksIndirectCountNV(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkBuffer countBuffer, uint64 countBufferOffset, uint32 maxDrawCount, uint32 stride)
		=> vkCmdDrawMeshTasksIndirectCountNV_ptr(commandBuffer, buffer, offset, countBuffer, countBufferOffset, maxDrawCount, stride);

	public typealias vkCmdSetExclusiveScissorEnableNVFunction = function void(VkCommandBuffer commandBuffer, uint32 firstExclusiveScissor, uint32 exclusiveScissorCount, VkBool32* pExclusiveScissorEnables);
	private static vkCmdSetExclusiveScissorEnableNVFunction vkCmdSetExclusiveScissorEnableNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetExclusiveScissorEnableNV(VkCommandBuffer commandBuffer, uint32 firstExclusiveScissor, uint32 exclusiveScissorCount, VkBool32* pExclusiveScissorEnables)
		=> vkCmdSetExclusiveScissorEnableNV_ptr(commandBuffer, firstExclusiveScissor, exclusiveScissorCount, pExclusiveScissorEnables);

	public typealias vkCmdSetExclusiveScissorNVFunction = function void(VkCommandBuffer commandBuffer, uint32 firstExclusiveScissor, uint32 exclusiveScissorCount, VkRect2D* pExclusiveScissors);
	private static vkCmdSetExclusiveScissorNVFunction vkCmdSetExclusiveScissorNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetExclusiveScissorNV(VkCommandBuffer commandBuffer, uint32 firstExclusiveScissor, uint32 exclusiveScissorCount, VkRect2D* pExclusiveScissors)
		=> vkCmdSetExclusiveScissorNV_ptr(commandBuffer, firstExclusiveScissor, exclusiveScissorCount, pExclusiveScissors);

	public typealias vkCmdSetCheckpointNVFunction = function void(VkCommandBuffer commandBuffer, void* pCheckpointMarker);
	private static vkCmdSetCheckpointNVFunction vkCmdSetCheckpointNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCheckpointNV(VkCommandBuffer commandBuffer, void* pCheckpointMarker)
		=> vkCmdSetCheckpointNV_ptr(commandBuffer, pCheckpointMarker);

	public typealias vkGetQueueCheckpointDataNVFunction = function void(VkQueue queue, uint32* pCheckpointDataCount, VkCheckpointDataNV* pCheckpointData);
	private static vkGetQueueCheckpointDataNVFunction vkGetQueueCheckpointDataNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetQueueCheckpointDataNV(VkQueue queue, uint32* pCheckpointDataCount, VkCheckpointDataNV* pCheckpointData)
		=> vkGetQueueCheckpointDataNV_ptr(queue, pCheckpointDataCount, pCheckpointData);

	public typealias vkInitializePerformanceApiINTELFunction = function VkResult(VkDevice device, VkInitializePerformanceApiInfoINTEL* pInitializeInfo);
	private static vkInitializePerformanceApiINTELFunction vkInitializePerformanceApiINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkInitializePerformanceApiINTEL(VkDevice device, VkInitializePerformanceApiInfoINTEL* pInitializeInfo)
		=> vkInitializePerformanceApiINTEL_ptr(device, pInitializeInfo);

	public typealias vkUninitializePerformanceApiINTELFunction = function void(VkDevice device);
	private static vkUninitializePerformanceApiINTELFunction vkUninitializePerformanceApiINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkUninitializePerformanceApiINTEL(VkDevice device)
		=> vkUninitializePerformanceApiINTEL_ptr(device);

	public typealias vkCmdSetPerformanceMarkerINTELFunction = function VkResult(VkCommandBuffer commandBuffer, VkPerformanceMarkerInfoINTEL* pMarkerInfo);
	private static vkCmdSetPerformanceMarkerINTELFunction vkCmdSetPerformanceMarkerINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCmdSetPerformanceMarkerINTEL(VkCommandBuffer commandBuffer, VkPerformanceMarkerInfoINTEL* pMarkerInfo)
		=> vkCmdSetPerformanceMarkerINTEL_ptr(commandBuffer, pMarkerInfo);

	public typealias vkCmdSetPerformanceStreamMarkerINTELFunction = function VkResult(VkCommandBuffer commandBuffer, VkPerformanceStreamMarkerInfoINTEL* pMarkerInfo);
	private static vkCmdSetPerformanceStreamMarkerINTELFunction vkCmdSetPerformanceStreamMarkerINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCmdSetPerformanceStreamMarkerINTEL(VkCommandBuffer commandBuffer, VkPerformanceStreamMarkerInfoINTEL* pMarkerInfo)
		=> vkCmdSetPerformanceStreamMarkerINTEL_ptr(commandBuffer, pMarkerInfo);

	public typealias vkCmdSetPerformanceOverrideINTELFunction = function VkResult(VkCommandBuffer commandBuffer, VkPerformanceOverrideInfoINTEL* pOverrideInfo);
	private static vkCmdSetPerformanceOverrideINTELFunction vkCmdSetPerformanceOverrideINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCmdSetPerformanceOverrideINTEL(VkCommandBuffer commandBuffer, VkPerformanceOverrideInfoINTEL* pOverrideInfo)
		=> vkCmdSetPerformanceOverrideINTEL_ptr(commandBuffer, pOverrideInfo);

	public typealias vkAcquirePerformanceConfigurationINTELFunction = function VkResult(VkDevice device, VkPerformanceConfigurationAcquireInfoINTEL* pAcquireInfo, VkPerformanceConfigurationINTEL* pConfiguration);
	private static vkAcquirePerformanceConfigurationINTELFunction vkAcquirePerformanceConfigurationINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAcquirePerformanceConfigurationINTEL(VkDevice device, VkPerformanceConfigurationAcquireInfoINTEL* pAcquireInfo, VkPerformanceConfigurationINTEL* pConfiguration)
		=> vkAcquirePerformanceConfigurationINTEL_ptr(device, pAcquireInfo, pConfiguration);

	public typealias vkReleasePerformanceConfigurationINTELFunction = function VkResult(VkDevice device, VkPerformanceConfigurationINTEL configuration);
	private static vkReleasePerformanceConfigurationINTELFunction vkReleasePerformanceConfigurationINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkReleasePerformanceConfigurationINTEL(VkDevice device, VkPerformanceConfigurationINTEL configuration)
		=> vkReleasePerformanceConfigurationINTEL_ptr(device, configuration);

	public typealias vkQueueSetPerformanceConfigurationINTELFunction = function VkResult(VkQueue queue, VkPerformanceConfigurationINTEL configuration);
	private static vkQueueSetPerformanceConfigurationINTELFunction vkQueueSetPerformanceConfigurationINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkQueueSetPerformanceConfigurationINTEL(VkQueue queue, VkPerformanceConfigurationINTEL configuration)
		=> vkQueueSetPerformanceConfigurationINTEL_ptr(queue, configuration);

	public typealias vkGetPerformanceParameterINTELFunction = function VkResult(VkDevice device, VkPerformanceParameterTypeINTEL parameter, VkPerformanceValueINTEL* pValue);
	private static vkGetPerformanceParameterINTELFunction vkGetPerformanceParameterINTEL_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPerformanceParameterINTEL(VkDevice device, VkPerformanceParameterTypeINTEL parameter, VkPerformanceValueINTEL* pValue)
		=> vkGetPerformanceParameterINTEL_ptr(device, parameter, pValue);

	public typealias vkSetLocalDimmingAMDFunction = function void(VkDevice device, VkSwapchainKHR swapChain, VkBool32 localDimmingEnable);
	private static vkSetLocalDimmingAMDFunction vkSetLocalDimmingAMD_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkSetLocalDimmingAMD(VkDevice device, VkSwapchainKHR swapChain, VkBool32 localDimmingEnable)
		=> vkSetLocalDimmingAMD_ptr(device, swapChain, localDimmingEnable);

	public typealias vkCreateImagePipeSurfaceFUCHSIAFunction = function VkResult(VkInstance instance, VkImagePipeSurfaceCreateInfoFUCHSIA* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateImagePipeSurfaceFUCHSIAFunction vkCreateImagePipeSurfaceFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateImagePipeSurfaceFUCHSIA(VkInstance instance, VkImagePipeSurfaceCreateInfoFUCHSIA* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateImagePipeSurfaceFUCHSIA_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkCreateMetalSurfaceEXTFunction = function VkResult(VkInstance instance, VkMetalSurfaceCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateMetalSurfaceEXTFunction vkCreateMetalSurfaceEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateMetalSurfaceEXT(VkInstance instance, VkMetalSurfaceCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateMetalSurfaceEXT_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetPhysicalDeviceFragmentShadingRatesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pFragmentShadingRateCount, VkPhysicalDeviceFragmentShadingRateKHR* pFragmentShadingRates);
	private static vkGetPhysicalDeviceFragmentShadingRatesKHRFunction vkGetPhysicalDeviceFragmentShadingRatesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceFragmentShadingRatesKHR(VkPhysicalDevice physicalDevice, uint32* pFragmentShadingRateCount, VkPhysicalDeviceFragmentShadingRateKHR* pFragmentShadingRates)
		=> vkGetPhysicalDeviceFragmentShadingRatesKHR_ptr(physicalDevice, pFragmentShadingRateCount, pFragmentShadingRates);

	public typealias vkCmdSetFragmentShadingRateKHRFunction = function void(VkCommandBuffer commandBuffer, VkExtent2D* pFragmentSize, VkFragmentShadingRateCombinerOpKHR[2] combinerOps);
	private static vkCmdSetFragmentShadingRateKHRFunction vkCmdSetFragmentShadingRateKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetFragmentShadingRateKHR(VkCommandBuffer commandBuffer, VkExtent2D* pFragmentSize, VkFragmentShadingRateCombinerOpKHR[2] combinerOps)
		=> vkCmdSetFragmentShadingRateKHR_ptr(commandBuffer, pFragmentSize, combinerOps);

	public typealias vkWaitForPresentKHRFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain, uint64 presentId, uint64 timeout);
	private static vkWaitForPresentKHRFunction vkWaitForPresentKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkWaitForPresentKHR(VkDevice device, VkSwapchainKHR swapchain, uint64 presentId, uint64 timeout)
		=> vkWaitForPresentKHR_ptr(device, swapchain, presentId, timeout);

	public typealias vkGetPhysicalDeviceCooperativeMatrixPropertiesNVFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkCooperativeMatrixPropertiesNV* pProperties);
	private static vkGetPhysicalDeviceCooperativeMatrixPropertiesNVFunction vkGetPhysicalDeviceCooperativeMatrixPropertiesNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceCooperativeMatrixPropertiesNV(VkPhysicalDevice physicalDevice, uint32* pPropertyCount, VkCooperativeMatrixPropertiesNV* pProperties)
		=> vkGetPhysicalDeviceCooperativeMatrixPropertiesNV_ptr(physicalDevice, pPropertyCount, pProperties);

	public typealias vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNVFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pCombinationCount, VkFramebufferMixedSamplesCombinationNV* pCombinations);
	private static vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNVFunction vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV(VkPhysicalDevice physicalDevice, uint32* pCombinationCount, VkFramebufferMixedSamplesCombinationNV* pCombinations)
		=> vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV_ptr(physicalDevice, pCombinationCount, pCombinations);

	public typealias vkGetPhysicalDeviceSurfacePresentModes2EXTFunction = function VkResult(VkPhysicalDevice physicalDevice, VkPhysicalDeviceSurfaceInfo2KHR* pSurfaceInfo, uint32* pPresentModeCount, VkPresentModeKHR* pPresentModes);
	private static vkGetPhysicalDeviceSurfacePresentModes2EXTFunction vkGetPhysicalDeviceSurfacePresentModes2EXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSurfacePresentModes2EXT(VkPhysicalDevice physicalDevice, VkPhysicalDeviceSurfaceInfo2KHR* pSurfaceInfo, uint32* pPresentModeCount, VkPresentModeKHR* pPresentModes)
		=> vkGetPhysicalDeviceSurfacePresentModes2EXT_ptr(physicalDevice, pSurfaceInfo, pPresentModeCount, pPresentModes);

	public typealias vkAcquireFullScreenExclusiveModeEXTFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain);
	private static vkAcquireFullScreenExclusiveModeEXTFunction vkAcquireFullScreenExclusiveModeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAcquireFullScreenExclusiveModeEXT(VkDevice device, VkSwapchainKHR swapchain)
		=> vkAcquireFullScreenExclusiveModeEXT_ptr(device, swapchain);

	public typealias vkReleaseFullScreenExclusiveModeEXTFunction = function VkResult(VkDevice device, VkSwapchainKHR swapchain);
	private static vkReleaseFullScreenExclusiveModeEXTFunction vkReleaseFullScreenExclusiveModeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkReleaseFullScreenExclusiveModeEXT(VkDevice device, VkSwapchainKHR swapchain)
		=> vkReleaseFullScreenExclusiveModeEXT_ptr(device, swapchain);

	public typealias vkCreateHeadlessSurfaceEXTFunction = function VkResult(VkInstance instance, VkHeadlessSurfaceCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateHeadlessSurfaceEXTFunction vkCreateHeadlessSurfaceEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateHeadlessSurfaceEXT(VkInstance instance, VkHeadlessSurfaceCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateHeadlessSurfaceEXT_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkCmdSetLineStippleEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 lineStippleFactor, uint16 lineStipplePattern);
	private static vkCmdSetLineStippleEXTFunction vkCmdSetLineStippleEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetLineStippleEXT(VkCommandBuffer commandBuffer, uint32 lineStippleFactor, uint16 lineStipplePattern)
		=> vkCmdSetLineStippleEXT_ptr(commandBuffer, lineStippleFactor, lineStipplePattern);

	public typealias vkCreateDeferredOperationKHRFunction = function VkResult(VkDevice device, VkAllocationCallbacks* pAllocator, VkDeferredOperationKHR* pDeferredOperation);
	private static vkCreateDeferredOperationKHRFunction vkCreateDeferredOperationKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDeferredOperationKHR(VkDevice device, VkAllocationCallbacks* pAllocator, VkDeferredOperationKHR* pDeferredOperation)
		=> vkCreateDeferredOperationKHR_ptr(device, pAllocator, pDeferredOperation);

	public typealias vkDestroyDeferredOperationKHRFunction = function void(VkDevice device, VkDeferredOperationKHR operation, VkAllocationCallbacks* pAllocator);
	private static vkDestroyDeferredOperationKHRFunction vkDestroyDeferredOperationKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyDeferredOperationKHR(VkDevice device, VkDeferredOperationKHR operation, VkAllocationCallbacks* pAllocator)
		=> vkDestroyDeferredOperationKHR_ptr(device, operation, pAllocator);

	public typealias vkGetDeferredOperationMaxConcurrencyKHRFunction = function uint32(VkDevice device, VkDeferredOperationKHR operation);
	private static vkGetDeferredOperationMaxConcurrencyKHRFunction vkGetDeferredOperationMaxConcurrencyKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static uint32 vkGetDeferredOperationMaxConcurrencyKHR(VkDevice device, VkDeferredOperationKHR operation)
		=> vkGetDeferredOperationMaxConcurrencyKHR_ptr(device, operation);

	public typealias vkGetDeferredOperationResultKHRFunction = function VkResult(VkDevice device, VkDeferredOperationKHR operation);
	private static vkGetDeferredOperationResultKHRFunction vkGetDeferredOperationResultKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDeferredOperationResultKHR(VkDevice device, VkDeferredOperationKHR operation)
		=> vkGetDeferredOperationResultKHR_ptr(device, operation);

	public typealias vkDeferredOperationJoinKHRFunction = function VkResult(VkDevice device, VkDeferredOperationKHR operation);
	private static vkDeferredOperationJoinKHRFunction vkDeferredOperationJoinKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkDeferredOperationJoinKHR(VkDevice device, VkDeferredOperationKHR operation)
		=> vkDeferredOperationJoinKHR_ptr(device, operation);

	public typealias vkGetPipelineExecutablePropertiesKHRFunction = function VkResult(VkDevice device, VkPipelineInfoKHR* pPipelineInfo, uint32* pExecutableCount, VkPipelineExecutablePropertiesKHR* pProperties);
	private static vkGetPipelineExecutablePropertiesKHRFunction vkGetPipelineExecutablePropertiesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPipelineExecutablePropertiesKHR(VkDevice device, VkPipelineInfoKHR* pPipelineInfo, uint32* pExecutableCount, VkPipelineExecutablePropertiesKHR* pProperties)
		=> vkGetPipelineExecutablePropertiesKHR_ptr(device, pPipelineInfo, pExecutableCount, pProperties);

	public typealias vkGetPipelineExecutableStatisticsKHRFunction = function VkResult(VkDevice device, VkPipelineExecutableInfoKHR* pExecutableInfo, uint32* pStatisticCount, VkPipelineExecutableStatisticKHR* pStatistics);
	private static vkGetPipelineExecutableStatisticsKHRFunction vkGetPipelineExecutableStatisticsKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPipelineExecutableStatisticsKHR(VkDevice device, VkPipelineExecutableInfoKHR* pExecutableInfo, uint32* pStatisticCount, VkPipelineExecutableStatisticKHR* pStatistics)
		=> vkGetPipelineExecutableStatisticsKHR_ptr(device, pExecutableInfo, pStatisticCount, pStatistics);

	public typealias vkGetPipelineExecutableInternalRepresentationsKHRFunction = function VkResult(VkDevice device, VkPipelineExecutableInfoKHR* pExecutableInfo, uint32* pInternalRepresentationCount, VkPipelineExecutableInternalRepresentationKHR* pInternalRepresentations);
	private static vkGetPipelineExecutableInternalRepresentationsKHRFunction vkGetPipelineExecutableInternalRepresentationsKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPipelineExecutableInternalRepresentationsKHR(VkDevice device, VkPipelineExecutableInfoKHR* pExecutableInfo, uint32* pInternalRepresentationCount, VkPipelineExecutableInternalRepresentationKHR* pInternalRepresentations)
		=> vkGetPipelineExecutableInternalRepresentationsKHR_ptr(device, pExecutableInfo, pInternalRepresentationCount, pInternalRepresentations);

	public typealias vkMapMemory2KHRFunction = function VkResult(VkDevice device, VkMemoryMapInfoKHR* pMemoryMapInfo, void** ppData);
	private static vkMapMemory2KHRFunction vkMapMemory2KHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkMapMemory2KHR(VkDevice device, VkMemoryMapInfoKHR* pMemoryMapInfo, void** ppData)
		=> vkMapMemory2KHR_ptr(device, pMemoryMapInfo, ppData);

	public typealias vkUnmapMemory2KHRFunction = function VkResult(VkDevice device, VkMemoryUnmapInfoKHR* pMemoryUnmapInfo);
	private static vkUnmapMemory2KHRFunction vkUnmapMemory2KHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkUnmapMemory2KHR(VkDevice device, VkMemoryUnmapInfoKHR* pMemoryUnmapInfo)
		=> vkUnmapMemory2KHR_ptr(device, pMemoryUnmapInfo);

	public typealias vkReleaseSwapchainImagesEXTFunction = function VkResult(VkDevice device, VkReleaseSwapchainImagesInfoEXT* pReleaseInfo);
	private static vkReleaseSwapchainImagesEXTFunction vkReleaseSwapchainImagesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkReleaseSwapchainImagesEXT(VkDevice device, VkReleaseSwapchainImagesInfoEXT* pReleaseInfo)
		=> vkReleaseSwapchainImagesEXT_ptr(device, pReleaseInfo);

	public typealias vkGetGeneratedCommandsMemoryRequirementsNVFunction = function void(VkDevice device, VkGeneratedCommandsMemoryRequirementsInfoNV* pInfo, VkMemoryRequirements2* pMemoryRequirements);
	private static vkGetGeneratedCommandsMemoryRequirementsNVFunction vkGetGeneratedCommandsMemoryRequirementsNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetGeneratedCommandsMemoryRequirementsNV(VkDevice device, VkGeneratedCommandsMemoryRequirementsInfoNV* pInfo, VkMemoryRequirements2* pMemoryRequirements)
		=> vkGetGeneratedCommandsMemoryRequirementsNV_ptr(device, pInfo, pMemoryRequirements);

	public typealias vkCmdPreprocessGeneratedCommandsNVFunction = function void(VkCommandBuffer commandBuffer, VkGeneratedCommandsInfoNV* pGeneratedCommandsInfo);
	private static vkCmdPreprocessGeneratedCommandsNVFunction vkCmdPreprocessGeneratedCommandsNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdPreprocessGeneratedCommandsNV(VkCommandBuffer commandBuffer, VkGeneratedCommandsInfoNV* pGeneratedCommandsInfo)
		=> vkCmdPreprocessGeneratedCommandsNV_ptr(commandBuffer, pGeneratedCommandsInfo);

	public typealias vkCmdExecuteGeneratedCommandsNVFunction = function void(VkCommandBuffer commandBuffer, VkBool32 isPreprocessed, VkGeneratedCommandsInfoNV* pGeneratedCommandsInfo);
	private static vkCmdExecuteGeneratedCommandsNVFunction vkCmdExecuteGeneratedCommandsNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdExecuteGeneratedCommandsNV(VkCommandBuffer commandBuffer, VkBool32 isPreprocessed, VkGeneratedCommandsInfoNV* pGeneratedCommandsInfo)
		=> vkCmdExecuteGeneratedCommandsNV_ptr(commandBuffer, isPreprocessed, pGeneratedCommandsInfo);

	public typealias vkCmdBindPipelineShaderGroupNVFunction = function void(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipeline pipeline, uint32 groupIndex);
	private static vkCmdBindPipelineShaderGroupNVFunction vkCmdBindPipelineShaderGroupNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindPipelineShaderGroupNV(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipeline pipeline, uint32 groupIndex)
		=> vkCmdBindPipelineShaderGroupNV_ptr(commandBuffer, pipelineBindPoint, pipeline, groupIndex);

	public typealias vkCreateIndirectCommandsLayoutNVFunction = function VkResult(VkDevice device, VkIndirectCommandsLayoutCreateInfoNV* pCreateInfo, VkAllocationCallbacks* pAllocator, VkIndirectCommandsLayoutNV* pIndirectCommandsLayout);
	private static vkCreateIndirectCommandsLayoutNVFunction vkCreateIndirectCommandsLayoutNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateIndirectCommandsLayoutNV(VkDevice device, VkIndirectCommandsLayoutCreateInfoNV* pCreateInfo, VkAllocationCallbacks* pAllocator, VkIndirectCommandsLayoutNV* pIndirectCommandsLayout)
		=> vkCreateIndirectCommandsLayoutNV_ptr(device, pCreateInfo, pAllocator, pIndirectCommandsLayout);

	public typealias vkDestroyIndirectCommandsLayoutNVFunction = function void(VkDevice device, VkIndirectCommandsLayoutNV indirectCommandsLayout, VkAllocationCallbacks* pAllocator);
	private static vkDestroyIndirectCommandsLayoutNVFunction vkDestroyIndirectCommandsLayoutNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyIndirectCommandsLayoutNV(VkDevice device, VkIndirectCommandsLayoutNV indirectCommandsLayout, VkAllocationCallbacks* pAllocator)
		=> vkDestroyIndirectCommandsLayoutNV_ptr(device, indirectCommandsLayout, pAllocator);

	public typealias vkAcquireDrmDisplayEXTFunction = function VkResult(VkPhysicalDevice physicalDevice, int32 drmFd, VkDisplayKHR display);
	private static vkAcquireDrmDisplayEXTFunction vkAcquireDrmDisplayEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAcquireDrmDisplayEXT(VkPhysicalDevice physicalDevice, int32 drmFd, VkDisplayKHR display)
		=> vkAcquireDrmDisplayEXT_ptr(physicalDevice, drmFd, display);

	public typealias vkGetDrmDisplayEXTFunction = function VkResult(VkPhysicalDevice physicalDevice, int32 drmFd, uint32 connectorId, VkDisplayKHR* display);
	private static vkGetDrmDisplayEXTFunction vkGetDrmDisplayEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDrmDisplayEXT(VkPhysicalDevice physicalDevice, int32 drmFd, uint32 connectorId, VkDisplayKHR* display)
		=> vkGetDrmDisplayEXT_ptr(physicalDevice, drmFd, connectorId, display);

	public typealias vkCmdEncodeVideoKHRFunction = function void(VkCommandBuffer commandBuffer, VkVideoEncodeInfoKHR* pEncodeInfo);
	private static vkCmdEncodeVideoKHRFunction vkCmdEncodeVideoKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdEncodeVideoKHR(VkCommandBuffer commandBuffer, VkVideoEncodeInfoKHR* pEncodeInfo)
		=> vkCmdEncodeVideoKHR_ptr(commandBuffer, pEncodeInfo);

	public typealias vkCmdRefreshObjectsKHRFunction = function void(VkCommandBuffer commandBuffer, VkRefreshObjectListKHR* pRefreshObjects);
	private static vkCmdRefreshObjectsKHRFunction vkCmdRefreshObjectsKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdRefreshObjectsKHR(VkCommandBuffer commandBuffer, VkRefreshObjectListKHR* pRefreshObjects)
		=> vkCmdRefreshObjectsKHR_ptr(commandBuffer, pRefreshObjects);

	public typealias vkGetPhysicalDeviceRefreshableObjectTypesKHRFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32* pRefreshableObjectTypeCount, VkObjectType* pRefreshableObjectTypes);
	private static vkGetPhysicalDeviceRefreshableObjectTypesKHRFunction vkGetPhysicalDeviceRefreshableObjectTypesKHR_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceRefreshableObjectTypesKHR(VkPhysicalDevice physicalDevice, uint32* pRefreshableObjectTypeCount, VkObjectType* pRefreshableObjectTypes)
		=> vkGetPhysicalDeviceRefreshableObjectTypesKHR_ptr(physicalDevice, pRefreshableObjectTypeCount, pRefreshableObjectTypes);

	public typealias vkExportMetalObjectsEXTFunction = function void(VkDevice device, VkExportMetalObjectsInfoEXT* pMetalObjectsInfo);
	private static vkExportMetalObjectsEXTFunction vkExportMetalObjectsEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkExportMetalObjectsEXT(VkDevice device, VkExportMetalObjectsInfoEXT* pMetalObjectsInfo)
		=> vkExportMetalObjectsEXT_ptr(device, pMetalObjectsInfo);

	public typealias vkGetDescriptorSetLayoutSizeEXTFunction = function void(VkDevice device, VkDescriptorSetLayout layout, uint64* pLayoutSizeInBytes);
	private static vkGetDescriptorSetLayoutSizeEXTFunction vkGetDescriptorSetLayoutSizeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDescriptorSetLayoutSizeEXT(VkDevice device, VkDescriptorSetLayout layout, uint64* pLayoutSizeInBytes)
		=> vkGetDescriptorSetLayoutSizeEXT_ptr(device, layout, pLayoutSizeInBytes);

	public typealias vkGetDescriptorSetLayoutBindingOffsetEXTFunction = function void(VkDevice device, VkDescriptorSetLayout layout, uint32 binding, uint64* pOffset);
	private static vkGetDescriptorSetLayoutBindingOffsetEXTFunction vkGetDescriptorSetLayoutBindingOffsetEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDescriptorSetLayoutBindingOffsetEXT(VkDevice device, VkDescriptorSetLayout layout, uint32 binding, uint64* pOffset)
		=> vkGetDescriptorSetLayoutBindingOffsetEXT_ptr(device, layout, binding, pOffset);

	public typealias vkGetDescriptorEXTFunction = function void(VkDevice device, VkDescriptorGetInfoEXT* pDescriptorInfo, uint dataSize, void* pDescriptor);
	private static vkGetDescriptorEXTFunction vkGetDescriptorEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDescriptorEXT(VkDevice device, VkDescriptorGetInfoEXT* pDescriptorInfo, uint dataSize, void* pDescriptor)
		=> vkGetDescriptorEXT_ptr(device, pDescriptorInfo, dataSize, pDescriptor);

	public typealias vkCmdBindDescriptorBuffersEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 bufferCount, VkDescriptorBufferBindingInfoEXT* pBindingInfos);
	private static vkCmdBindDescriptorBuffersEXTFunction vkCmdBindDescriptorBuffersEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindDescriptorBuffersEXT(VkCommandBuffer commandBuffer, uint32 bufferCount, VkDescriptorBufferBindingInfoEXT* pBindingInfos)
		=> vkCmdBindDescriptorBuffersEXT_ptr(commandBuffer, bufferCount, pBindingInfos);

	public typealias vkCmdSetDescriptorBufferOffsetsEXTFunction = function void(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32 firstSet, uint32 setCount, uint32* pBufferIndices, uint64* pOffsets);
	private static vkCmdSetDescriptorBufferOffsetsEXTFunction vkCmdSetDescriptorBufferOffsetsEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDescriptorBufferOffsetsEXT(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32 firstSet, uint32 setCount, uint32* pBufferIndices, uint64* pOffsets)
		=> vkCmdSetDescriptorBufferOffsetsEXT_ptr(commandBuffer, pipelineBindPoint, layout, firstSet, setCount, pBufferIndices, pOffsets);

	public typealias vkCmdBindDescriptorBufferEmbeddedSamplersEXTFunction = function void(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32 set);
	private static vkCmdBindDescriptorBufferEmbeddedSamplersEXTFunction vkCmdBindDescriptorBufferEmbeddedSamplersEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindDescriptorBufferEmbeddedSamplersEXT(VkCommandBuffer commandBuffer, VkPipelineBindPoint pipelineBindPoint, VkPipelineLayout layout, uint32 set)
		=> vkCmdBindDescriptorBufferEmbeddedSamplersEXT_ptr(commandBuffer, pipelineBindPoint, layout, set);

	public typealias vkGetBufferOpaqueCaptureDescriptorDataEXTFunction = function VkResult(VkDevice device, VkBufferCaptureDescriptorDataInfoEXT* pInfo, void* pData);
	private static vkGetBufferOpaqueCaptureDescriptorDataEXTFunction vkGetBufferOpaqueCaptureDescriptorDataEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetBufferOpaqueCaptureDescriptorDataEXT(VkDevice device, VkBufferCaptureDescriptorDataInfoEXT* pInfo, void* pData)
		=> vkGetBufferOpaqueCaptureDescriptorDataEXT_ptr(device, pInfo, pData);

	public typealias vkGetImageOpaqueCaptureDescriptorDataEXTFunction = function VkResult(VkDevice device, VkImageCaptureDescriptorDataInfoEXT* pInfo, void* pData);
	private static vkGetImageOpaqueCaptureDescriptorDataEXTFunction vkGetImageOpaqueCaptureDescriptorDataEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetImageOpaqueCaptureDescriptorDataEXT(VkDevice device, VkImageCaptureDescriptorDataInfoEXT* pInfo, void* pData)
		=> vkGetImageOpaqueCaptureDescriptorDataEXT_ptr(device, pInfo, pData);

	public typealias vkGetImageViewOpaqueCaptureDescriptorDataEXTFunction = function VkResult(VkDevice device, VkImageViewCaptureDescriptorDataInfoEXT* pInfo, void* pData);
	private static vkGetImageViewOpaqueCaptureDescriptorDataEXTFunction vkGetImageViewOpaqueCaptureDescriptorDataEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetImageViewOpaqueCaptureDescriptorDataEXT(VkDevice device, VkImageViewCaptureDescriptorDataInfoEXT* pInfo, void* pData)
		=> vkGetImageViewOpaqueCaptureDescriptorDataEXT_ptr(device, pInfo, pData);

	public typealias vkGetSamplerOpaqueCaptureDescriptorDataEXTFunction = function VkResult(VkDevice device, VkSamplerCaptureDescriptorDataInfoEXT* pInfo, void* pData);
	private static vkGetSamplerOpaqueCaptureDescriptorDataEXTFunction vkGetSamplerOpaqueCaptureDescriptorDataEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSamplerOpaqueCaptureDescriptorDataEXT(VkDevice device, VkSamplerCaptureDescriptorDataInfoEXT* pInfo, void* pData)
		=> vkGetSamplerOpaqueCaptureDescriptorDataEXT_ptr(device, pInfo, pData);

	public typealias vkCmdSetFragmentShadingRateEnumNVFunction = function void(VkCommandBuffer commandBuffer, VkFragmentShadingRateNV shadingRate, VkFragmentShadingRateCombinerOpKHR[2] combinerOps);
	private static vkCmdSetFragmentShadingRateEnumNVFunction vkCmdSetFragmentShadingRateEnumNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetFragmentShadingRateEnumNV(VkCommandBuffer commandBuffer, VkFragmentShadingRateNV shadingRate, VkFragmentShadingRateCombinerOpKHR[2] combinerOps)
		=> vkCmdSetFragmentShadingRateEnumNV_ptr(commandBuffer, shadingRate, combinerOps);

	public typealias vkCmdDrawMeshTasksEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 groupCountX, uint32 groupCountY, uint32 groupCountZ);
	private static vkCmdDrawMeshTasksEXTFunction vkCmdDrawMeshTasksEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawMeshTasksEXT(VkCommandBuffer commandBuffer, uint32 groupCountX, uint32 groupCountY, uint32 groupCountZ)
		=> vkCmdDrawMeshTasksEXT_ptr(commandBuffer, groupCountX, groupCountY, groupCountZ);

	public typealias vkCmdDrawMeshTasksIndirectEXTFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, uint32 drawCount, uint32 stride);
	private static vkCmdDrawMeshTasksIndirectEXTFunction vkCmdDrawMeshTasksIndirectEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawMeshTasksIndirectEXT(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, uint32 drawCount, uint32 stride)
		=> vkCmdDrawMeshTasksIndirectEXT_ptr(commandBuffer, buffer, offset, drawCount, stride);

	public typealias vkCmdDrawMeshTasksIndirectCountEXTFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkBuffer countBuffer, uint64 countBufferOffset, uint32 maxDrawCount, uint32 stride);
	private static vkCmdDrawMeshTasksIndirectCountEXTFunction vkCmdDrawMeshTasksIndirectCountEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawMeshTasksIndirectCountEXT(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset, VkBuffer countBuffer, uint64 countBufferOffset, uint32 maxDrawCount, uint32 stride)
		=> vkCmdDrawMeshTasksIndirectCountEXT_ptr(commandBuffer, buffer, offset, countBuffer, countBufferOffset, maxDrawCount, stride);

	public typealias vkGetImageSubresourceLayout2EXTFunction = function void(VkDevice device, VkImage image, VkImageSubresource2EXT* pSubresource, VkSubresourceLayout2EXT* pLayout);
	private static vkGetImageSubresourceLayout2EXTFunction vkGetImageSubresourceLayout2EXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetImageSubresourceLayout2EXT(VkDevice device, VkImage image, VkImageSubresource2EXT* pSubresource, VkSubresourceLayout2EXT* pLayout)
		=> vkGetImageSubresourceLayout2EXT_ptr(device, image, pSubresource, pLayout);

	public typealias vkGetDeviceFaultInfoEXTFunction = function VkResult(VkDevice device, VkDeviceFaultCountsEXT* pFaultCounts, VkDeviceFaultInfoEXT* pFaultInfo);
	private static vkGetDeviceFaultInfoEXTFunction vkGetDeviceFaultInfoEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDeviceFaultInfoEXT(VkDevice device, VkDeviceFaultCountsEXT* pFaultCounts, VkDeviceFaultInfoEXT* pFaultInfo)
		=> vkGetDeviceFaultInfoEXT_ptr(device, pFaultCounts, pFaultInfo);

	public typealias vkAcquireWinrtDisplayNVFunction = function VkResult(VkPhysicalDevice physicalDevice, VkDisplayKHR display);
	private static vkAcquireWinrtDisplayNVFunction vkAcquireWinrtDisplayNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkAcquireWinrtDisplayNV(VkPhysicalDevice physicalDevice, VkDisplayKHR display)
		=> vkAcquireWinrtDisplayNV_ptr(physicalDevice, display);

	public typealias vkGetWinrtDisplayNVFunction = function VkResult(VkPhysicalDevice physicalDevice, uint32 deviceRelativeId, VkDisplayKHR* pDisplay);
	private static vkGetWinrtDisplayNVFunction vkGetWinrtDisplayNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetWinrtDisplayNV(VkPhysicalDevice physicalDevice, uint32 deviceRelativeId, VkDisplayKHR* pDisplay)
		=> vkGetWinrtDisplayNV_ptr(physicalDevice, deviceRelativeId, pDisplay);

	public typealias vkCreateDirectFBSurfaceEXTFunction = function VkResult(VkInstance instance, VkDirectFBSurfaceCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateDirectFBSurfaceEXTFunction vkCreateDirectFBSurfaceEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateDirectFBSurfaceEXT(VkInstance instance, VkDirectFBSurfaceCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateDirectFBSurfaceEXT_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetPhysicalDeviceDirectFBPresentationSupportEXTFunction = function VkBool32(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* dfb);
	private static vkGetPhysicalDeviceDirectFBPresentationSupportEXTFunction vkGetPhysicalDeviceDirectFBPresentationSupportEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkBool32 vkGetPhysicalDeviceDirectFBPresentationSupportEXT(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* dfb)
		=> vkGetPhysicalDeviceDirectFBPresentationSupportEXT_ptr(physicalDevice, queueFamilyIndex, dfb);

	public typealias vkCmdSetVertexInputEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 vertexBindingDescriptionCount, VkVertexInputBindingDescription2EXT* pVertexBindingDescriptions, uint32 vertexAttributeDescriptionCount, VkVertexInputAttributeDescription2EXT* pVertexAttributeDescriptions);
	private static vkCmdSetVertexInputEXTFunction vkCmdSetVertexInputEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetVertexInputEXT(VkCommandBuffer commandBuffer, uint32 vertexBindingDescriptionCount, VkVertexInputBindingDescription2EXT* pVertexBindingDescriptions, uint32 vertexAttributeDescriptionCount, VkVertexInputAttributeDescription2EXT* pVertexAttributeDescriptions)
		=> vkCmdSetVertexInputEXT_ptr(commandBuffer, vertexBindingDescriptionCount, pVertexBindingDescriptions, vertexAttributeDescriptionCount, pVertexAttributeDescriptions);

	public typealias vkGetMemoryZirconHandleFUCHSIAFunction = function VkResult(VkDevice device, VkMemoryGetZirconHandleInfoFUCHSIA* pGetZirconHandleInfo, void* pZirconHandle);
	private static vkGetMemoryZirconHandleFUCHSIAFunction vkGetMemoryZirconHandleFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryZirconHandleFUCHSIA(VkDevice device, VkMemoryGetZirconHandleInfoFUCHSIA* pGetZirconHandleInfo, void* pZirconHandle)
		=> vkGetMemoryZirconHandleFUCHSIA_ptr(device, pGetZirconHandleInfo, pZirconHandle);

	public typealias vkGetMemoryZirconHandlePropertiesFUCHSIAFunction = function VkResult(VkDevice device, VkExternalMemoryHandleTypeFlags handleType, void* zirconHandle, VkMemoryZirconHandlePropertiesFUCHSIA* pMemoryZirconHandleProperties);
	private static vkGetMemoryZirconHandlePropertiesFUCHSIAFunction vkGetMemoryZirconHandlePropertiesFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryZirconHandlePropertiesFUCHSIA(VkDevice device, VkExternalMemoryHandleTypeFlags handleType, void* zirconHandle, VkMemoryZirconHandlePropertiesFUCHSIA* pMemoryZirconHandleProperties)
		=> vkGetMemoryZirconHandlePropertiesFUCHSIA_ptr(device, handleType, zirconHandle, pMemoryZirconHandleProperties);

	public typealias vkImportSemaphoreZirconHandleFUCHSIAFunction = function VkResult(VkDevice device, VkImportSemaphoreZirconHandleInfoFUCHSIA* pImportSemaphoreZirconHandleInfo);
	private static vkImportSemaphoreZirconHandleFUCHSIAFunction vkImportSemaphoreZirconHandleFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkImportSemaphoreZirconHandleFUCHSIA(VkDevice device, VkImportSemaphoreZirconHandleInfoFUCHSIA* pImportSemaphoreZirconHandleInfo)
		=> vkImportSemaphoreZirconHandleFUCHSIA_ptr(device, pImportSemaphoreZirconHandleInfo);

	public typealias vkGetSemaphoreZirconHandleFUCHSIAFunction = function VkResult(VkDevice device, VkSemaphoreGetZirconHandleInfoFUCHSIA* pGetZirconHandleInfo, void* pZirconHandle);
	private static vkGetSemaphoreZirconHandleFUCHSIAFunction vkGetSemaphoreZirconHandleFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSemaphoreZirconHandleFUCHSIA(VkDevice device, VkSemaphoreGetZirconHandleInfoFUCHSIA* pGetZirconHandleInfo, void* pZirconHandle)
		=> vkGetSemaphoreZirconHandleFUCHSIA_ptr(device, pGetZirconHandleInfo, pZirconHandle);

	public typealias vkCreateBufferCollectionFUCHSIAFunction = function VkResult(VkDevice device, VkBufferCollectionCreateInfoFUCHSIA* pCreateInfo, VkAllocationCallbacks* pAllocator, VkBufferCollectionFUCHSIA* pCollection);
	private static vkCreateBufferCollectionFUCHSIAFunction vkCreateBufferCollectionFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateBufferCollectionFUCHSIA(VkDevice device, VkBufferCollectionCreateInfoFUCHSIA* pCreateInfo, VkAllocationCallbacks* pAllocator, VkBufferCollectionFUCHSIA* pCollection)
		=> vkCreateBufferCollectionFUCHSIA_ptr(device, pCreateInfo, pAllocator, pCollection);

	public typealias vkSetBufferCollectionImageConstraintsFUCHSIAFunction = function VkResult(VkDevice device, VkBufferCollectionFUCHSIA collection, VkImageConstraintsInfoFUCHSIA* pImageConstraintsInfo);
	private static vkSetBufferCollectionImageConstraintsFUCHSIAFunction vkSetBufferCollectionImageConstraintsFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkSetBufferCollectionImageConstraintsFUCHSIA(VkDevice device, VkBufferCollectionFUCHSIA collection, VkImageConstraintsInfoFUCHSIA* pImageConstraintsInfo)
		=> vkSetBufferCollectionImageConstraintsFUCHSIA_ptr(device, collection, pImageConstraintsInfo);

	public typealias vkSetBufferCollectionBufferConstraintsFUCHSIAFunction = function VkResult(VkDevice device, VkBufferCollectionFUCHSIA collection, VkBufferConstraintsInfoFUCHSIA* pBufferConstraintsInfo);
	private static vkSetBufferCollectionBufferConstraintsFUCHSIAFunction vkSetBufferCollectionBufferConstraintsFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkSetBufferCollectionBufferConstraintsFUCHSIA(VkDevice device, VkBufferCollectionFUCHSIA collection, VkBufferConstraintsInfoFUCHSIA* pBufferConstraintsInfo)
		=> vkSetBufferCollectionBufferConstraintsFUCHSIA_ptr(device, collection, pBufferConstraintsInfo);

	public typealias vkDestroyBufferCollectionFUCHSIAFunction = function void(VkDevice device, VkBufferCollectionFUCHSIA collection, VkAllocationCallbacks* pAllocator);
	private static vkDestroyBufferCollectionFUCHSIAFunction vkDestroyBufferCollectionFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyBufferCollectionFUCHSIA(VkDevice device, VkBufferCollectionFUCHSIA collection, VkAllocationCallbacks* pAllocator)
		=> vkDestroyBufferCollectionFUCHSIA_ptr(device, collection, pAllocator);

	public typealias vkGetBufferCollectionPropertiesFUCHSIAFunction = function VkResult(VkDevice device, VkBufferCollectionFUCHSIA collection, VkBufferCollectionPropertiesFUCHSIA* pProperties);
	private static vkGetBufferCollectionPropertiesFUCHSIAFunction vkGetBufferCollectionPropertiesFUCHSIA_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetBufferCollectionPropertiesFUCHSIA(VkDevice device, VkBufferCollectionFUCHSIA collection, VkBufferCollectionPropertiesFUCHSIA* pProperties)
		=> vkGetBufferCollectionPropertiesFUCHSIA_ptr(device, collection, pProperties);

	public typealias vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEIFunction = function VkResult(VkDevice device, VkRenderPass renderpass, VkExtent2D* pMaxWorkgroupSize);
	private static vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEIFunction vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI(VkDevice device, VkRenderPass renderpass, VkExtent2D* pMaxWorkgroupSize)
		=> vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI_ptr(device, renderpass, pMaxWorkgroupSize);

	public typealias vkCmdSubpassShadingHUAWEIFunction = function void(VkCommandBuffer commandBuffer);
	private static vkCmdSubpassShadingHUAWEIFunction vkCmdSubpassShadingHUAWEI_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSubpassShadingHUAWEI(VkCommandBuffer commandBuffer)
		=> vkCmdSubpassShadingHUAWEI_ptr(commandBuffer);

	public typealias vkCmdBindInvocationMaskHUAWEIFunction = function void(VkCommandBuffer commandBuffer, VkImageView imageView, VkImageLayout imageLayout);
	private static vkCmdBindInvocationMaskHUAWEIFunction vkCmdBindInvocationMaskHUAWEI_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindInvocationMaskHUAWEI(VkCommandBuffer commandBuffer, VkImageView imageView, VkImageLayout imageLayout)
		=> vkCmdBindInvocationMaskHUAWEI_ptr(commandBuffer, imageView, imageLayout);

	public typealias vkGetMemoryRemoteAddressNVFunction = function VkResult(VkDevice device, VkMemoryGetRemoteAddressInfoNV* pMemoryGetRemoteAddressInfo, void* pAddress);
	private static vkGetMemoryRemoteAddressNVFunction vkGetMemoryRemoteAddressNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemoryRemoteAddressNV(VkDevice device, VkMemoryGetRemoteAddressInfoNV* pMemoryGetRemoteAddressInfo, void* pAddress)
		=> vkGetMemoryRemoteAddressNV_ptr(device, pMemoryGetRemoteAddressInfo, pAddress);

	public typealias vkGetPipelinePropertiesEXTFunction = function VkResult(VkDevice device, VkPipelineInfoKHR* pPipelineInfo, VkBaseOutStructure* pPipelineProperties);
	private static vkGetPipelinePropertiesEXTFunction vkGetPipelinePropertiesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPipelinePropertiesEXT(VkDevice device, VkPipelineInfoKHR* pPipelineInfo, VkBaseOutStructure* pPipelineProperties)
		=> vkGetPipelinePropertiesEXT_ptr(device, pPipelineInfo, pPipelineProperties);

	public typealias vkGetFenceSciSyncFenceNVFunction = function VkResult(VkDevice device, VkFenceGetSciSyncInfoNV* pGetSciSyncHandleInfo, void* pHandle);
	private static vkGetFenceSciSyncFenceNVFunction vkGetFenceSciSyncFenceNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetFenceSciSyncFenceNV(VkDevice device, VkFenceGetSciSyncInfoNV* pGetSciSyncHandleInfo, void* pHandle)
		=> vkGetFenceSciSyncFenceNV_ptr(device, pGetSciSyncHandleInfo, pHandle);

	public typealias vkGetFenceSciSyncObjNVFunction = function VkResult(VkDevice device, VkFenceGetSciSyncInfoNV* pGetSciSyncHandleInfo, void* pHandle);
	private static vkGetFenceSciSyncObjNVFunction vkGetFenceSciSyncObjNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetFenceSciSyncObjNV(VkDevice device, VkFenceGetSciSyncInfoNV* pGetSciSyncHandleInfo, void* pHandle)
		=> vkGetFenceSciSyncObjNV_ptr(device, pGetSciSyncHandleInfo, pHandle);

	public typealias vkImportFenceSciSyncFenceNVFunction = function VkResult(VkDevice device, VkImportFenceSciSyncInfoNV* pImportFenceSciSyncInfo);
	private static vkImportFenceSciSyncFenceNVFunction vkImportFenceSciSyncFenceNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkImportFenceSciSyncFenceNV(VkDevice device, VkImportFenceSciSyncInfoNV* pImportFenceSciSyncInfo)
		=> vkImportFenceSciSyncFenceNV_ptr(device, pImportFenceSciSyncInfo);

	public typealias vkImportFenceSciSyncObjNVFunction = function VkResult(VkDevice device, VkImportFenceSciSyncInfoNV* pImportFenceSciSyncInfo);
	private static vkImportFenceSciSyncObjNVFunction vkImportFenceSciSyncObjNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkImportFenceSciSyncObjNV(VkDevice device, VkImportFenceSciSyncInfoNV* pImportFenceSciSyncInfo)
		=> vkImportFenceSciSyncObjNV_ptr(device, pImportFenceSciSyncInfo);

	public typealias vkGetPhysicalDeviceSciSyncAttributesNVFunction = function VkResult(VkPhysicalDevice physicalDevice, VkSciSyncAttributesInfoNV* pSciSyncAttributesInfo, void* pAttributes);
	private static vkGetPhysicalDeviceSciSyncAttributesNVFunction vkGetPhysicalDeviceSciSyncAttributesNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSciSyncAttributesNV(VkPhysicalDevice physicalDevice, VkSciSyncAttributesInfoNV* pSciSyncAttributesInfo, void* pAttributes)
		=> vkGetPhysicalDeviceSciSyncAttributesNV_ptr(physicalDevice, pSciSyncAttributesInfo, pAttributes);

	public typealias vkGetSemaphoreSciSyncObjNVFunction = function VkResult(VkDevice device, VkSemaphoreGetSciSyncInfoNV* pGetSciSyncInfo, void* pHandle);
	private static vkGetSemaphoreSciSyncObjNVFunction vkGetSemaphoreSciSyncObjNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetSemaphoreSciSyncObjNV(VkDevice device, VkSemaphoreGetSciSyncInfoNV* pGetSciSyncInfo, void* pHandle)
		=> vkGetSemaphoreSciSyncObjNV_ptr(device, pGetSciSyncInfo, pHandle);

	public typealias vkImportSemaphoreSciSyncObjNVFunction = function VkResult(VkDevice device, VkImportSemaphoreSciSyncInfoNV* pImportSemaphoreSciSyncInfo);
	private static vkImportSemaphoreSciSyncObjNVFunction vkImportSemaphoreSciSyncObjNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkImportSemaphoreSciSyncObjNV(VkDevice device, VkImportSemaphoreSciSyncInfoNV* pImportSemaphoreSciSyncInfo)
		=> vkImportSemaphoreSciSyncObjNV_ptr(device, pImportSemaphoreSciSyncInfo);

	public typealias vkGetMemorySciBufNVFunction = function VkResult(VkDevice device, VkMemoryGetSciBufInfoNV* pGetSciBufInfo, void* pHandle);
	private static vkGetMemorySciBufNVFunction vkGetMemorySciBufNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetMemorySciBufNV(VkDevice device, VkMemoryGetSciBufInfoNV* pGetSciBufInfo, void* pHandle)
		=> vkGetMemorySciBufNV_ptr(device, pGetSciBufInfo, pHandle);

	public typealias vkGetPhysicalDeviceExternalMemorySciBufPropertiesNVFunction = function VkResult(VkPhysicalDevice physicalDevice, VkExternalMemoryHandleTypeFlags handleType, void* handle, VkMemorySciBufPropertiesNV* pMemorySciBufProperties);
	private static vkGetPhysicalDeviceExternalMemorySciBufPropertiesNVFunction vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV(VkPhysicalDevice physicalDevice, VkExternalMemoryHandleTypeFlags handleType, void* handle, VkMemorySciBufPropertiesNV* pMemorySciBufProperties)
		=> vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV_ptr(physicalDevice, handleType, handle, pMemorySciBufProperties);

	public typealias vkGetPhysicalDeviceSciBufAttributesNVFunction = function VkResult(VkPhysicalDevice physicalDevice, void* pAttributes);
	private static vkGetPhysicalDeviceSciBufAttributesNVFunction vkGetPhysicalDeviceSciBufAttributesNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceSciBufAttributesNV(VkPhysicalDevice physicalDevice, void* pAttributes)
		=> vkGetPhysicalDeviceSciBufAttributesNV_ptr(physicalDevice, pAttributes);

	public typealias vkCmdSetPatchControlPointsEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 patchControlPoints);
	private static vkCmdSetPatchControlPointsEXTFunction vkCmdSetPatchControlPointsEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetPatchControlPointsEXT(VkCommandBuffer commandBuffer, uint32 patchControlPoints)
		=> vkCmdSetPatchControlPointsEXT_ptr(commandBuffer, patchControlPoints);

	public typealias vkCmdSetLogicOpEXTFunction = function void(VkCommandBuffer commandBuffer, VkLogicOp logicOp);
	private static vkCmdSetLogicOpEXTFunction vkCmdSetLogicOpEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetLogicOpEXT(VkCommandBuffer commandBuffer, VkLogicOp logicOp)
		=> vkCmdSetLogicOpEXT_ptr(commandBuffer, logicOp);

	public typealias vkCreateScreenSurfaceQNXFunction = function VkResult(VkInstance instance, VkScreenSurfaceCreateInfoQNX* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface);
	private static vkCreateScreenSurfaceQNXFunction vkCreateScreenSurfaceQNX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateScreenSurfaceQNX(VkInstance instance, VkScreenSurfaceCreateInfoQNX* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSurfaceKHR* pSurface)
		=> vkCreateScreenSurfaceQNX_ptr(instance, pCreateInfo, pAllocator, pSurface);

	public typealias vkGetPhysicalDeviceScreenPresentationSupportQNXFunction = function VkBool32(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* window);
	private static vkGetPhysicalDeviceScreenPresentationSupportQNXFunction vkGetPhysicalDeviceScreenPresentationSupportQNX_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkBool32 vkGetPhysicalDeviceScreenPresentationSupportQNX(VkPhysicalDevice physicalDevice, uint32 queueFamilyIndex, void* window)
		=> vkGetPhysicalDeviceScreenPresentationSupportQNX_ptr(physicalDevice, queueFamilyIndex, window);

	public typealias vkCmdSetColorWriteEnableEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 attachmentCount, VkBool32* pColorWriteEnables);
	private static vkCmdSetColorWriteEnableEXTFunction vkCmdSetColorWriteEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetColorWriteEnableEXT(VkCommandBuffer commandBuffer, uint32 attachmentCount, VkBool32* pColorWriteEnables)
		=> vkCmdSetColorWriteEnableEXT_ptr(commandBuffer, attachmentCount, pColorWriteEnables);

	public typealias vkCmdDrawMultiEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 drawCount, VkMultiDrawInfoEXT* pVertexInfo, uint32 instanceCount, uint32 firstInstance, uint32 stride);
	private static vkCmdDrawMultiEXTFunction vkCmdDrawMultiEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawMultiEXT(VkCommandBuffer commandBuffer, uint32 drawCount, VkMultiDrawInfoEXT* pVertexInfo, uint32 instanceCount, uint32 firstInstance, uint32 stride)
		=> vkCmdDrawMultiEXT_ptr(commandBuffer, drawCount, pVertexInfo, instanceCount, firstInstance, stride);

	public typealias vkCmdDrawMultiIndexedEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 drawCount, VkMultiDrawIndexedInfoEXT* pIndexInfo, uint32 instanceCount, uint32 firstInstance, uint32 stride, int32* pVertexOffset);
	private static vkCmdDrawMultiIndexedEXTFunction vkCmdDrawMultiIndexedEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawMultiIndexedEXT(VkCommandBuffer commandBuffer, uint32 drawCount, VkMultiDrawIndexedInfoEXT* pIndexInfo, uint32 instanceCount, uint32 firstInstance, uint32 stride, int32* pVertexOffset)
		=> vkCmdDrawMultiIndexedEXT_ptr(commandBuffer, drawCount, pIndexInfo, instanceCount, firstInstance, stride, pVertexOffset);

	public typealias vkCreateMicromapEXTFunction = function VkResult(VkDevice device, VkMicromapCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkMicromapEXT* pMicromap);
	private static vkCreateMicromapEXTFunction vkCreateMicromapEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateMicromapEXT(VkDevice device, VkMicromapCreateInfoEXT* pCreateInfo, VkAllocationCallbacks* pAllocator, VkMicromapEXT* pMicromap)
		=> vkCreateMicromapEXT_ptr(device, pCreateInfo, pAllocator, pMicromap);

	public typealias vkDestroyMicromapEXTFunction = function void(VkDevice device, VkMicromapEXT micromap, VkAllocationCallbacks* pAllocator);
	private static vkDestroyMicromapEXTFunction vkDestroyMicromapEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyMicromapEXT(VkDevice device, VkMicromapEXT micromap, VkAllocationCallbacks* pAllocator)
		=> vkDestroyMicromapEXT_ptr(device, micromap, pAllocator);

	public typealias vkCmdBuildMicromapsEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 infoCount, VkMicromapBuildInfoEXT* pInfos);
	private static vkCmdBuildMicromapsEXTFunction vkCmdBuildMicromapsEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBuildMicromapsEXT(VkCommandBuffer commandBuffer, uint32 infoCount, VkMicromapBuildInfoEXT* pInfos)
		=> vkCmdBuildMicromapsEXT_ptr(commandBuffer, infoCount, pInfos);

	public typealias vkBuildMicromapsEXTFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, uint32 infoCount, VkMicromapBuildInfoEXT* pInfos);
	private static vkBuildMicromapsEXTFunction vkBuildMicromapsEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBuildMicromapsEXT(VkDevice device, VkDeferredOperationKHR deferredOperation, uint32 infoCount, VkMicromapBuildInfoEXT* pInfos)
		=> vkBuildMicromapsEXT_ptr(device, deferredOperation, infoCount, pInfos);

	public typealias vkCopyMicromapEXTFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyMicromapInfoEXT* pInfo);
	private static vkCopyMicromapEXTFunction vkCopyMicromapEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCopyMicromapEXT(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyMicromapInfoEXT* pInfo)
		=> vkCopyMicromapEXT_ptr(device, deferredOperation, pInfo);

	public typealias vkCopyMicromapToMemoryEXTFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyMicromapToMemoryInfoEXT* pInfo);
	private static vkCopyMicromapToMemoryEXTFunction vkCopyMicromapToMemoryEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCopyMicromapToMemoryEXT(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyMicromapToMemoryInfoEXT* pInfo)
		=> vkCopyMicromapToMemoryEXT_ptr(device, deferredOperation, pInfo);

	public typealias vkCopyMemoryToMicromapEXTFunction = function VkResult(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyMemoryToMicromapInfoEXT* pInfo);
	private static vkCopyMemoryToMicromapEXTFunction vkCopyMemoryToMicromapEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCopyMemoryToMicromapEXT(VkDevice device, VkDeferredOperationKHR deferredOperation, VkCopyMemoryToMicromapInfoEXT* pInfo)
		=> vkCopyMemoryToMicromapEXT_ptr(device, deferredOperation, pInfo);

	public typealias vkWriteMicromapsPropertiesEXTFunction = function VkResult(VkDevice device, uint32 micromapCount, VkMicromapEXT* pMicromaps, VkQueryType queryType, uint dataSize, void* pData, uint stride);
	private static vkWriteMicromapsPropertiesEXTFunction vkWriteMicromapsPropertiesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkWriteMicromapsPropertiesEXT(VkDevice device, uint32 micromapCount, VkMicromapEXT* pMicromaps, VkQueryType queryType, uint dataSize, void* pData, uint stride)
		=> vkWriteMicromapsPropertiesEXT_ptr(device, micromapCount, pMicromaps, queryType, dataSize, pData, stride);

	public typealias vkCmdCopyMicromapEXTFunction = function void(VkCommandBuffer commandBuffer, VkCopyMicromapInfoEXT* pInfo);
	private static vkCmdCopyMicromapEXTFunction vkCmdCopyMicromapEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyMicromapEXT(VkCommandBuffer commandBuffer, VkCopyMicromapInfoEXT* pInfo)
		=> vkCmdCopyMicromapEXT_ptr(commandBuffer, pInfo);

	public typealias vkCmdCopyMicromapToMemoryEXTFunction = function void(VkCommandBuffer commandBuffer, VkCopyMicromapToMemoryInfoEXT* pInfo);
	private static vkCmdCopyMicromapToMemoryEXTFunction vkCmdCopyMicromapToMemoryEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyMicromapToMemoryEXT(VkCommandBuffer commandBuffer, VkCopyMicromapToMemoryInfoEXT* pInfo)
		=> vkCmdCopyMicromapToMemoryEXT_ptr(commandBuffer, pInfo);

	public typealias vkCmdCopyMemoryToMicromapEXTFunction = function void(VkCommandBuffer commandBuffer, VkCopyMemoryToMicromapInfoEXT* pInfo);
	private static vkCmdCopyMemoryToMicromapEXTFunction vkCmdCopyMemoryToMicromapEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyMemoryToMicromapEXT(VkCommandBuffer commandBuffer, VkCopyMemoryToMicromapInfoEXT* pInfo)
		=> vkCmdCopyMemoryToMicromapEXT_ptr(commandBuffer, pInfo);

	public typealias vkCmdWriteMicromapsPropertiesEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 micromapCount, VkMicromapEXT* pMicromaps, VkQueryType queryType, VkQueryPool queryPool, uint32 firstQuery);
	private static vkCmdWriteMicromapsPropertiesEXTFunction vkCmdWriteMicromapsPropertiesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdWriteMicromapsPropertiesEXT(VkCommandBuffer commandBuffer, uint32 micromapCount, VkMicromapEXT* pMicromaps, VkQueryType queryType, VkQueryPool queryPool, uint32 firstQuery)
		=> vkCmdWriteMicromapsPropertiesEXT_ptr(commandBuffer, micromapCount, pMicromaps, queryType, queryPool, firstQuery);

	public typealias vkGetDeviceMicromapCompatibilityEXTFunction = function void(VkDevice device, VkMicromapVersionInfoEXT* pVersionInfo, VkAccelerationStructureCompatibilityKHR* pCompatibility);
	private static vkGetDeviceMicromapCompatibilityEXTFunction vkGetDeviceMicromapCompatibilityEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDeviceMicromapCompatibilityEXT(VkDevice device, VkMicromapVersionInfoEXT* pVersionInfo, VkAccelerationStructureCompatibilityKHR* pCompatibility)
		=> vkGetDeviceMicromapCompatibilityEXT_ptr(device, pVersionInfo, pCompatibility);

	public typealias vkGetMicromapBuildSizesEXTFunction = function void(VkDevice device, VkAccelerationStructureBuildTypeKHR buildType, VkMicromapBuildInfoEXT* pBuildInfo, VkMicromapBuildSizesInfoEXT* pSizeInfo);
	private static vkGetMicromapBuildSizesEXTFunction vkGetMicromapBuildSizesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetMicromapBuildSizesEXT(VkDevice device, VkAccelerationStructureBuildTypeKHR buildType, VkMicromapBuildInfoEXT* pBuildInfo, VkMicromapBuildSizesInfoEXT* pSizeInfo)
		=> vkGetMicromapBuildSizesEXT_ptr(device, buildType, pBuildInfo, pSizeInfo);

	public typealias vkCmdDrawClusterHUAWEIFunction = function void(VkCommandBuffer commandBuffer, uint32 groupCountX, uint32 groupCountY, uint32 groupCountZ);
	private static vkCmdDrawClusterHUAWEIFunction vkCmdDrawClusterHUAWEI_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawClusterHUAWEI(VkCommandBuffer commandBuffer, uint32 groupCountX, uint32 groupCountY, uint32 groupCountZ)
		=> vkCmdDrawClusterHUAWEI_ptr(commandBuffer, groupCountX, groupCountY, groupCountZ);

	public typealias vkCmdDrawClusterIndirectHUAWEIFunction = function void(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset);
	private static vkCmdDrawClusterIndirectHUAWEIFunction vkCmdDrawClusterIndirectHUAWEI_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDrawClusterIndirectHUAWEI(VkCommandBuffer commandBuffer, VkBuffer buffer, uint64 offset)
		=> vkCmdDrawClusterIndirectHUAWEI_ptr(commandBuffer, buffer, offset);

	public typealias vkSetDeviceMemoryPriorityEXTFunction = function void(VkDevice device, VkDeviceMemory memory, float priority);
	private static vkSetDeviceMemoryPriorityEXTFunction vkSetDeviceMemoryPriorityEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkSetDeviceMemoryPriorityEXT(VkDevice device, VkDeviceMemory memory, float priority)
		=> vkSetDeviceMemoryPriorityEXT_ptr(device, memory, priority);

	public typealias vkGetDescriptorSetLayoutHostMappingInfoVALVEFunction = function void(VkDevice device, VkDescriptorSetBindingReferenceVALVE* pBindingReference, VkDescriptorSetLayoutHostMappingInfoVALVE* pHostMapping);
	private static vkGetDescriptorSetLayoutHostMappingInfoVALVEFunction vkGetDescriptorSetLayoutHostMappingInfoVALVE_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDescriptorSetLayoutHostMappingInfoVALVE(VkDevice device, VkDescriptorSetBindingReferenceVALVE* pBindingReference, VkDescriptorSetLayoutHostMappingInfoVALVE* pHostMapping)
		=> vkGetDescriptorSetLayoutHostMappingInfoVALVE_ptr(device, pBindingReference, pHostMapping);

	public typealias vkGetDescriptorSetHostMappingVALVEFunction = function void(VkDevice device, VkDescriptorSet descriptorSet, void** ppData);
	private static vkGetDescriptorSetHostMappingVALVEFunction vkGetDescriptorSetHostMappingVALVE_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetDescriptorSetHostMappingVALVE(VkDevice device, VkDescriptorSet descriptorSet, void** ppData)
		=> vkGetDescriptorSetHostMappingVALVE_ptr(device, descriptorSet, ppData);

	public typealias vkCmdCopyMemoryIndirectNVFunction = function void(VkCommandBuffer commandBuffer, uint64 copyBufferAddress, uint32 copyCount, uint32 stride);
	private static vkCmdCopyMemoryIndirectNVFunction vkCmdCopyMemoryIndirectNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyMemoryIndirectNV(VkCommandBuffer commandBuffer, uint64 copyBufferAddress, uint32 copyCount, uint32 stride)
		=> vkCmdCopyMemoryIndirectNV_ptr(commandBuffer, copyBufferAddress, copyCount, stride);

	public typealias vkCmdCopyMemoryToImageIndirectNVFunction = function void(VkCommandBuffer commandBuffer, uint64 copyBufferAddress, uint32 copyCount, uint32 stride, VkImage dstImage, VkImageLayout dstImageLayout, VkImageSubresourceLayers* pImageSubresources);
	private static vkCmdCopyMemoryToImageIndirectNVFunction vkCmdCopyMemoryToImageIndirectNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdCopyMemoryToImageIndirectNV(VkCommandBuffer commandBuffer, uint64 copyBufferAddress, uint32 copyCount, uint32 stride, VkImage dstImage, VkImageLayout dstImageLayout, VkImageSubresourceLayers* pImageSubresources)
		=> vkCmdCopyMemoryToImageIndirectNV_ptr(commandBuffer, copyBufferAddress, copyCount, stride, dstImage, dstImageLayout, pImageSubresources);

	public typealias vkCmdDecompressMemoryNVFunction = function void(VkCommandBuffer commandBuffer, uint32 decompressRegionCount, VkDecompressMemoryRegionNV* pDecompressMemoryRegions);
	private static vkCmdDecompressMemoryNVFunction vkCmdDecompressMemoryNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDecompressMemoryNV(VkCommandBuffer commandBuffer, uint32 decompressRegionCount, VkDecompressMemoryRegionNV* pDecompressMemoryRegions)
		=> vkCmdDecompressMemoryNV_ptr(commandBuffer, decompressRegionCount, pDecompressMemoryRegions);

	public typealias vkCmdDecompressMemoryIndirectCountNVFunction = function void(VkCommandBuffer commandBuffer, uint64 indirectCommandsAddress, uint64 indirectCommandsCountAddress, uint32 stride);
	private static vkCmdDecompressMemoryIndirectCountNVFunction vkCmdDecompressMemoryIndirectCountNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdDecompressMemoryIndirectCountNV(VkCommandBuffer commandBuffer, uint64 indirectCommandsAddress, uint64 indirectCommandsCountAddress, uint32 stride)
		=> vkCmdDecompressMemoryIndirectCountNV_ptr(commandBuffer, indirectCommandsAddress, indirectCommandsCountAddress, stride);

	public typealias vkCmdSetTessellationDomainOriginEXTFunction = function void(VkCommandBuffer commandBuffer, VkTessellationDomainOrigin domainOrigin);
	private static vkCmdSetTessellationDomainOriginEXTFunction vkCmdSetTessellationDomainOriginEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetTessellationDomainOriginEXT(VkCommandBuffer commandBuffer, VkTessellationDomainOrigin domainOrigin)
		=> vkCmdSetTessellationDomainOriginEXT_ptr(commandBuffer, domainOrigin);

	public typealias vkCmdSetDepthClampEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 depthClampEnable);
	private static vkCmdSetDepthClampEnableEXTFunction vkCmdSetDepthClampEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthClampEnableEXT(VkCommandBuffer commandBuffer, VkBool32 depthClampEnable)
		=> vkCmdSetDepthClampEnableEXT_ptr(commandBuffer, depthClampEnable);

	public typealias vkCmdSetPolygonModeEXTFunction = function void(VkCommandBuffer commandBuffer, VkPolygonMode polygonMode);
	private static vkCmdSetPolygonModeEXTFunction vkCmdSetPolygonModeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetPolygonModeEXT(VkCommandBuffer commandBuffer, VkPolygonMode polygonMode)
		=> vkCmdSetPolygonModeEXT_ptr(commandBuffer, polygonMode);

	public typealias vkCmdSetRasterizationSamplesEXTFunction = function void(VkCommandBuffer commandBuffer, VkSampleCountFlags rasterizationSamples);
	private static vkCmdSetRasterizationSamplesEXTFunction vkCmdSetRasterizationSamplesEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetRasterizationSamplesEXT(VkCommandBuffer commandBuffer, VkSampleCountFlags rasterizationSamples)
		=> vkCmdSetRasterizationSamplesEXT_ptr(commandBuffer, rasterizationSamples);

	public typealias vkCmdSetSampleMaskEXTFunction = function void(VkCommandBuffer commandBuffer, VkSampleCountFlags samples, uint32* pSampleMask);
	private static vkCmdSetSampleMaskEXTFunction vkCmdSetSampleMaskEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetSampleMaskEXT(VkCommandBuffer commandBuffer, VkSampleCountFlags samples, uint32* pSampleMask)
		=> vkCmdSetSampleMaskEXT_ptr(commandBuffer, samples, pSampleMask);

	public typealias vkCmdSetAlphaToCoverageEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 alphaToCoverageEnable);
	private static vkCmdSetAlphaToCoverageEnableEXTFunction vkCmdSetAlphaToCoverageEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetAlphaToCoverageEnableEXT(VkCommandBuffer commandBuffer, VkBool32 alphaToCoverageEnable)
		=> vkCmdSetAlphaToCoverageEnableEXT_ptr(commandBuffer, alphaToCoverageEnable);

	public typealias vkCmdSetAlphaToOneEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 alphaToOneEnable);
	private static vkCmdSetAlphaToOneEnableEXTFunction vkCmdSetAlphaToOneEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetAlphaToOneEnableEXT(VkCommandBuffer commandBuffer, VkBool32 alphaToOneEnable)
		=> vkCmdSetAlphaToOneEnableEXT_ptr(commandBuffer, alphaToOneEnable);

	public typealias vkCmdSetLogicOpEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 logicOpEnable);
	private static vkCmdSetLogicOpEnableEXTFunction vkCmdSetLogicOpEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetLogicOpEnableEXT(VkCommandBuffer commandBuffer, VkBool32 logicOpEnable)
		=> vkCmdSetLogicOpEnableEXT_ptr(commandBuffer, logicOpEnable);

	public typealias vkCmdSetColorBlendEnableEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 firstAttachment, uint32 attachmentCount, VkBool32* pColorBlendEnables);
	private static vkCmdSetColorBlendEnableEXTFunction vkCmdSetColorBlendEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetColorBlendEnableEXT(VkCommandBuffer commandBuffer, uint32 firstAttachment, uint32 attachmentCount, VkBool32* pColorBlendEnables)
		=> vkCmdSetColorBlendEnableEXT_ptr(commandBuffer, firstAttachment, attachmentCount, pColorBlendEnables);

	public typealias vkCmdSetColorBlendEquationEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 firstAttachment, uint32 attachmentCount, VkColorBlendEquationEXT* pColorBlendEquations);
	private static vkCmdSetColorBlendEquationEXTFunction vkCmdSetColorBlendEquationEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetColorBlendEquationEXT(VkCommandBuffer commandBuffer, uint32 firstAttachment, uint32 attachmentCount, VkColorBlendEquationEXT* pColorBlendEquations)
		=> vkCmdSetColorBlendEquationEXT_ptr(commandBuffer, firstAttachment, attachmentCount, pColorBlendEquations);

	public typealias vkCmdSetColorWriteMaskEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 firstAttachment, uint32 attachmentCount, VkColorComponentFlags* pColorWriteMasks);
	private static vkCmdSetColorWriteMaskEXTFunction vkCmdSetColorWriteMaskEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetColorWriteMaskEXT(VkCommandBuffer commandBuffer, uint32 firstAttachment, uint32 attachmentCount, VkColorComponentFlags* pColorWriteMasks)
		=> vkCmdSetColorWriteMaskEXT_ptr(commandBuffer, firstAttachment, attachmentCount, pColorWriteMasks);

	public typealias vkCmdSetRasterizationStreamEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 rasterizationStream);
	private static vkCmdSetRasterizationStreamEXTFunction vkCmdSetRasterizationStreamEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetRasterizationStreamEXT(VkCommandBuffer commandBuffer, uint32 rasterizationStream)
		=> vkCmdSetRasterizationStreamEXT_ptr(commandBuffer, rasterizationStream);

	public typealias vkCmdSetConservativeRasterizationModeEXTFunction = function void(VkCommandBuffer commandBuffer, VkConservativeRasterizationModeEXT conservativeRasterizationMode);
	private static vkCmdSetConservativeRasterizationModeEXTFunction vkCmdSetConservativeRasterizationModeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetConservativeRasterizationModeEXT(VkCommandBuffer commandBuffer, VkConservativeRasterizationModeEXT conservativeRasterizationMode)
		=> vkCmdSetConservativeRasterizationModeEXT_ptr(commandBuffer, conservativeRasterizationMode);

	public typealias vkCmdSetExtraPrimitiveOverestimationSizeEXTFunction = function void(VkCommandBuffer commandBuffer, float extraPrimitiveOverestimationSize);
	private static vkCmdSetExtraPrimitiveOverestimationSizeEXTFunction vkCmdSetExtraPrimitiveOverestimationSizeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetExtraPrimitiveOverestimationSizeEXT(VkCommandBuffer commandBuffer, float extraPrimitiveOverestimationSize)
		=> vkCmdSetExtraPrimitiveOverestimationSizeEXT_ptr(commandBuffer, extraPrimitiveOverestimationSize);

	public typealias vkCmdSetDepthClipEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 depthClipEnable);
	private static vkCmdSetDepthClipEnableEXTFunction vkCmdSetDepthClipEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthClipEnableEXT(VkCommandBuffer commandBuffer, VkBool32 depthClipEnable)
		=> vkCmdSetDepthClipEnableEXT_ptr(commandBuffer, depthClipEnable);

	public typealias vkCmdSetSampleLocationsEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 sampleLocationsEnable);
	private static vkCmdSetSampleLocationsEnableEXTFunction vkCmdSetSampleLocationsEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetSampleLocationsEnableEXT(VkCommandBuffer commandBuffer, VkBool32 sampleLocationsEnable)
		=> vkCmdSetSampleLocationsEnableEXT_ptr(commandBuffer, sampleLocationsEnable);

	public typealias vkCmdSetColorBlendAdvancedEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 firstAttachment, uint32 attachmentCount, VkColorBlendAdvancedEXT* pColorBlendAdvanced);
	private static vkCmdSetColorBlendAdvancedEXTFunction vkCmdSetColorBlendAdvancedEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetColorBlendAdvancedEXT(VkCommandBuffer commandBuffer, uint32 firstAttachment, uint32 attachmentCount, VkColorBlendAdvancedEXT* pColorBlendAdvanced)
		=> vkCmdSetColorBlendAdvancedEXT_ptr(commandBuffer, firstAttachment, attachmentCount, pColorBlendAdvanced);

	public typealias vkCmdSetProvokingVertexModeEXTFunction = function void(VkCommandBuffer commandBuffer, VkProvokingVertexModeEXT provokingVertexMode);
	private static vkCmdSetProvokingVertexModeEXTFunction vkCmdSetProvokingVertexModeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetProvokingVertexModeEXT(VkCommandBuffer commandBuffer, VkProvokingVertexModeEXT provokingVertexMode)
		=> vkCmdSetProvokingVertexModeEXT_ptr(commandBuffer, provokingVertexMode);

	public typealias vkCmdSetLineRasterizationModeEXTFunction = function void(VkCommandBuffer commandBuffer, VkLineRasterizationModeEXT lineRasterizationMode);
	private static vkCmdSetLineRasterizationModeEXTFunction vkCmdSetLineRasterizationModeEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetLineRasterizationModeEXT(VkCommandBuffer commandBuffer, VkLineRasterizationModeEXT lineRasterizationMode)
		=> vkCmdSetLineRasterizationModeEXT_ptr(commandBuffer, lineRasterizationMode);

	public typealias vkCmdSetLineStippleEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 stippledLineEnable);
	private static vkCmdSetLineStippleEnableEXTFunction vkCmdSetLineStippleEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetLineStippleEnableEXT(VkCommandBuffer commandBuffer, VkBool32 stippledLineEnable)
		=> vkCmdSetLineStippleEnableEXT_ptr(commandBuffer, stippledLineEnable);

	public typealias vkCmdSetDepthClipNegativeOneToOneEXTFunction = function void(VkCommandBuffer commandBuffer, VkBool32 negativeOneToOne);
	private static vkCmdSetDepthClipNegativeOneToOneEXTFunction vkCmdSetDepthClipNegativeOneToOneEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetDepthClipNegativeOneToOneEXT(VkCommandBuffer commandBuffer, VkBool32 negativeOneToOne)
		=> vkCmdSetDepthClipNegativeOneToOneEXT_ptr(commandBuffer, negativeOneToOne);

	public typealias vkCmdSetViewportWScalingEnableNVFunction = function void(VkCommandBuffer commandBuffer, VkBool32 viewportWScalingEnable);
	private static vkCmdSetViewportWScalingEnableNVFunction vkCmdSetViewportWScalingEnableNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetViewportWScalingEnableNV(VkCommandBuffer commandBuffer, VkBool32 viewportWScalingEnable)
		=> vkCmdSetViewportWScalingEnableNV_ptr(commandBuffer, viewportWScalingEnable);

	public typealias vkCmdSetViewportSwizzleNVFunction = function void(VkCommandBuffer commandBuffer, uint32 firstViewport, uint32 viewportCount, VkViewportSwizzleNV* pViewportSwizzles);
	private static vkCmdSetViewportSwizzleNVFunction vkCmdSetViewportSwizzleNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetViewportSwizzleNV(VkCommandBuffer commandBuffer, uint32 firstViewport, uint32 viewportCount, VkViewportSwizzleNV* pViewportSwizzles)
		=> vkCmdSetViewportSwizzleNV_ptr(commandBuffer, firstViewport, viewportCount, pViewportSwizzles);

	public typealias vkCmdSetCoverageToColorEnableNVFunction = function void(VkCommandBuffer commandBuffer, VkBool32 coverageToColorEnable);
	private static vkCmdSetCoverageToColorEnableNVFunction vkCmdSetCoverageToColorEnableNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCoverageToColorEnableNV(VkCommandBuffer commandBuffer, VkBool32 coverageToColorEnable)
		=> vkCmdSetCoverageToColorEnableNV_ptr(commandBuffer, coverageToColorEnable);

	public typealias vkCmdSetCoverageToColorLocationNVFunction = function void(VkCommandBuffer commandBuffer, uint32 coverageToColorLocation);
	private static vkCmdSetCoverageToColorLocationNVFunction vkCmdSetCoverageToColorLocationNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCoverageToColorLocationNV(VkCommandBuffer commandBuffer, uint32 coverageToColorLocation)
		=> vkCmdSetCoverageToColorLocationNV_ptr(commandBuffer, coverageToColorLocation);

	public typealias vkCmdSetCoverageModulationModeNVFunction = function void(VkCommandBuffer commandBuffer, VkCoverageModulationModeNV coverageModulationMode);
	private static vkCmdSetCoverageModulationModeNVFunction vkCmdSetCoverageModulationModeNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCoverageModulationModeNV(VkCommandBuffer commandBuffer, VkCoverageModulationModeNV coverageModulationMode)
		=> vkCmdSetCoverageModulationModeNV_ptr(commandBuffer, coverageModulationMode);

	public typealias vkCmdSetCoverageModulationTableEnableNVFunction = function void(VkCommandBuffer commandBuffer, VkBool32 coverageModulationTableEnable);
	private static vkCmdSetCoverageModulationTableEnableNVFunction vkCmdSetCoverageModulationTableEnableNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCoverageModulationTableEnableNV(VkCommandBuffer commandBuffer, VkBool32 coverageModulationTableEnable)
		=> vkCmdSetCoverageModulationTableEnableNV_ptr(commandBuffer, coverageModulationTableEnable);

	public typealias vkCmdSetCoverageModulationTableNVFunction = function void(VkCommandBuffer commandBuffer, uint32 coverageModulationTableCount, float* pCoverageModulationTable);
	private static vkCmdSetCoverageModulationTableNVFunction vkCmdSetCoverageModulationTableNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCoverageModulationTableNV(VkCommandBuffer commandBuffer, uint32 coverageModulationTableCount, float* pCoverageModulationTable)
		=> vkCmdSetCoverageModulationTableNV_ptr(commandBuffer, coverageModulationTableCount, pCoverageModulationTable);

	public typealias vkCmdSetShadingRateImageEnableNVFunction = function void(VkCommandBuffer commandBuffer, VkBool32 shadingRateImageEnable);
	private static vkCmdSetShadingRateImageEnableNVFunction vkCmdSetShadingRateImageEnableNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetShadingRateImageEnableNV(VkCommandBuffer commandBuffer, VkBool32 shadingRateImageEnable)
		=> vkCmdSetShadingRateImageEnableNV_ptr(commandBuffer, shadingRateImageEnable);

	public typealias vkCmdSetRepresentativeFragmentTestEnableNVFunction = function void(VkCommandBuffer commandBuffer, VkBool32 representativeFragmentTestEnable);
	private static vkCmdSetRepresentativeFragmentTestEnableNVFunction vkCmdSetRepresentativeFragmentTestEnableNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetRepresentativeFragmentTestEnableNV(VkCommandBuffer commandBuffer, VkBool32 representativeFragmentTestEnable)
		=> vkCmdSetRepresentativeFragmentTestEnableNV_ptr(commandBuffer, representativeFragmentTestEnable);

	public typealias vkCmdSetCoverageReductionModeNVFunction = function void(VkCommandBuffer commandBuffer, VkCoverageReductionModeNV coverageReductionMode);
	private static vkCmdSetCoverageReductionModeNVFunction vkCmdSetCoverageReductionModeNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetCoverageReductionModeNV(VkCommandBuffer commandBuffer, VkCoverageReductionModeNV coverageReductionMode)
		=> vkCmdSetCoverageReductionModeNV_ptr(commandBuffer, coverageReductionMode);

	public typealias vkGetShaderModuleIdentifierEXTFunction = function void(VkDevice device, VkShaderModule shaderModule, VkShaderModuleIdentifierEXT* pIdentifier);
	private static vkGetShaderModuleIdentifierEXTFunction vkGetShaderModuleIdentifierEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetShaderModuleIdentifierEXT(VkDevice device, VkShaderModule shaderModule, VkShaderModuleIdentifierEXT* pIdentifier)
		=> vkGetShaderModuleIdentifierEXT_ptr(device, shaderModule, pIdentifier);

	public typealias vkGetShaderModuleCreateInfoIdentifierEXTFunction = function void(VkDevice device, VkShaderModuleCreateInfo* pCreateInfo, VkShaderModuleIdentifierEXT* pIdentifier);
	private static vkGetShaderModuleCreateInfoIdentifierEXTFunction vkGetShaderModuleCreateInfoIdentifierEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkGetShaderModuleCreateInfoIdentifierEXT(VkDevice device, VkShaderModuleCreateInfo* pCreateInfo, VkShaderModuleIdentifierEXT* pIdentifier)
		=> vkGetShaderModuleCreateInfoIdentifierEXT_ptr(device, pCreateInfo, pIdentifier);

	public typealias vkGetPhysicalDeviceOpticalFlowImageFormatsNVFunction = function VkResult(VkPhysicalDevice physicalDevice, VkOpticalFlowImageFormatInfoNV* pOpticalFlowImageFormatInfo, uint32* pFormatCount, VkOpticalFlowImageFormatPropertiesNV* pImageFormatProperties);
	private static vkGetPhysicalDeviceOpticalFlowImageFormatsNVFunction vkGetPhysicalDeviceOpticalFlowImageFormatsNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetPhysicalDeviceOpticalFlowImageFormatsNV(VkPhysicalDevice physicalDevice, VkOpticalFlowImageFormatInfoNV* pOpticalFlowImageFormatInfo, uint32* pFormatCount, VkOpticalFlowImageFormatPropertiesNV* pImageFormatProperties)
		=> vkGetPhysicalDeviceOpticalFlowImageFormatsNV_ptr(physicalDevice, pOpticalFlowImageFormatInfo, pFormatCount, pImageFormatProperties);

	public typealias vkCreateOpticalFlowSessionNVFunction = function VkResult(VkDevice device, VkOpticalFlowSessionCreateInfoNV* pCreateInfo, VkAllocationCallbacks* pAllocator, VkOpticalFlowSessionNV* pSession);
	private static vkCreateOpticalFlowSessionNVFunction vkCreateOpticalFlowSessionNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateOpticalFlowSessionNV(VkDevice device, VkOpticalFlowSessionCreateInfoNV* pCreateInfo, VkAllocationCallbacks* pAllocator, VkOpticalFlowSessionNV* pSession)
		=> vkCreateOpticalFlowSessionNV_ptr(device, pCreateInfo, pAllocator, pSession);

	public typealias vkDestroyOpticalFlowSessionNVFunction = function void(VkDevice device, VkOpticalFlowSessionNV session, VkAllocationCallbacks* pAllocator);
	private static vkDestroyOpticalFlowSessionNVFunction vkDestroyOpticalFlowSessionNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyOpticalFlowSessionNV(VkDevice device, VkOpticalFlowSessionNV session, VkAllocationCallbacks* pAllocator)
		=> vkDestroyOpticalFlowSessionNV_ptr(device, session, pAllocator);

	public typealias vkBindOpticalFlowSessionImageNVFunction = function VkResult(VkDevice device, VkOpticalFlowSessionNV session, VkOpticalFlowSessionBindingPointNV bindingPoint, VkImageView view, VkImageLayout layout);
	private static vkBindOpticalFlowSessionImageNVFunction vkBindOpticalFlowSessionImageNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkBindOpticalFlowSessionImageNV(VkDevice device, VkOpticalFlowSessionNV session, VkOpticalFlowSessionBindingPointNV bindingPoint, VkImageView view, VkImageLayout layout)
		=> vkBindOpticalFlowSessionImageNV_ptr(device, session, bindingPoint, view, layout);

	public typealias vkCmdOpticalFlowExecuteNVFunction = function void(VkCommandBuffer commandBuffer, VkOpticalFlowSessionNV session, VkOpticalFlowExecuteInfoNV* pExecuteInfo);
	private static vkCmdOpticalFlowExecuteNVFunction vkCmdOpticalFlowExecuteNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdOpticalFlowExecuteNV(VkCommandBuffer commandBuffer, VkOpticalFlowSessionNV session, VkOpticalFlowExecuteInfoNV* pExecuteInfo)
		=> vkCmdOpticalFlowExecuteNV_ptr(commandBuffer, session, pExecuteInfo);

	public typealias vkCreateShadersEXTFunction = function VkResult(VkDevice device, uint32 createInfoCount, VkShaderCreateInfoEXT* pCreateInfos, VkAllocationCallbacks* pAllocator, VkShaderEXT* pShaders);
	private static vkCreateShadersEXTFunction vkCreateShadersEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateShadersEXT(VkDevice device, uint32 createInfoCount, VkShaderCreateInfoEXT* pCreateInfos, VkAllocationCallbacks* pAllocator, VkShaderEXT* pShaders)
		=> vkCreateShadersEXT_ptr(device, createInfoCount, pCreateInfos, pAllocator, pShaders);

	public typealias vkDestroyShaderEXTFunction = function void(VkDevice device, VkShaderEXT shader, VkAllocationCallbacks* pAllocator);
	private static vkDestroyShaderEXTFunction vkDestroyShaderEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroyShaderEXT(VkDevice device, VkShaderEXT shader, VkAllocationCallbacks* pAllocator)
		=> vkDestroyShaderEXT_ptr(device, shader, pAllocator);

	public typealias vkGetShaderBinaryDataEXTFunction = function VkResult(VkDevice device, VkShaderEXT shader, uint* pDataSize, void* pData);
	private static vkGetShaderBinaryDataEXTFunction vkGetShaderBinaryDataEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetShaderBinaryDataEXT(VkDevice device, VkShaderEXT shader, uint* pDataSize, void* pData)
		=> vkGetShaderBinaryDataEXT_ptr(device, shader, pDataSize, pData);

	public typealias vkCmdBindShadersEXTFunction = function void(VkCommandBuffer commandBuffer, uint32 stageCount, VkShaderStageFlags* pStages, VkShaderEXT* pShaders);
	private static vkCmdBindShadersEXTFunction vkCmdBindShadersEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdBindShadersEXT(VkCommandBuffer commandBuffer, uint32 stageCount, VkShaderStageFlags* pStages, VkShaderEXT* pShaders)
		=> vkCmdBindShadersEXT_ptr(commandBuffer, stageCount, pStages, pShaders);

	public typealias vkGetFramebufferTilePropertiesQCOMFunction = function VkResult(VkDevice device, VkFramebuffer framebuffer, uint32* pPropertiesCount, VkTilePropertiesQCOM* pProperties);
	private static vkGetFramebufferTilePropertiesQCOMFunction vkGetFramebufferTilePropertiesQCOM_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetFramebufferTilePropertiesQCOM(VkDevice device, VkFramebuffer framebuffer, uint32* pPropertiesCount, VkTilePropertiesQCOM* pProperties)
		=> vkGetFramebufferTilePropertiesQCOM_ptr(device, framebuffer, pPropertiesCount, pProperties);

	public typealias vkGetDynamicRenderingTilePropertiesQCOMFunction = function VkResult(VkDevice device, VkRenderingInfo* pRenderingInfo, VkTilePropertiesQCOM* pProperties);
	private static vkGetDynamicRenderingTilePropertiesQCOMFunction vkGetDynamicRenderingTilePropertiesQCOM_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkGetDynamicRenderingTilePropertiesQCOM(VkDevice device, VkRenderingInfo* pRenderingInfo, VkTilePropertiesQCOM* pProperties)
		=> vkGetDynamicRenderingTilePropertiesQCOM_ptr(device, pRenderingInfo, pProperties);

	public typealias vkCreateSemaphoreSciSyncPoolNVFunction = function VkResult(VkDevice device, VkSemaphoreSciSyncPoolCreateInfoNV* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSemaphoreSciSyncPoolNV* pSemaphorePool);
	private static vkCreateSemaphoreSciSyncPoolNVFunction vkCreateSemaphoreSciSyncPoolNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static VkResult vkCreateSemaphoreSciSyncPoolNV(VkDevice device, VkSemaphoreSciSyncPoolCreateInfoNV* pCreateInfo, VkAllocationCallbacks* pAllocator, VkSemaphoreSciSyncPoolNV* pSemaphorePool)
		=> vkCreateSemaphoreSciSyncPoolNV_ptr(device, pCreateInfo, pAllocator, pSemaphorePool);

	public typealias vkDestroySemaphoreSciSyncPoolNVFunction = function void(VkDevice device, VkSemaphoreSciSyncPoolNV semaphorePool, VkAllocationCallbacks* pAllocator);
	private static vkDestroySemaphoreSciSyncPoolNVFunction vkDestroySemaphoreSciSyncPoolNV_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkDestroySemaphoreSciSyncPoolNV(VkDevice device, VkSemaphoreSciSyncPoolNV semaphorePool, VkAllocationCallbacks* pAllocator)
		=> vkDestroySemaphoreSciSyncPoolNV_ptr(device, semaphorePool, pAllocator);

	public typealias vkCmdSetAttachmentFeedbackLoopEnableEXTFunction = function void(VkCommandBuffer commandBuffer, VkImageAspectFlags aspectMask);
	private static vkCmdSetAttachmentFeedbackLoopEnableEXTFunction vkCmdSetAttachmentFeedbackLoopEnableEXT_ptr;
	[CallingConvention(VulkanNative.CallConv)]
	public static void vkCmdSetAttachmentFeedbackLoopEnableEXT(VkCommandBuffer commandBuffer, VkImageAspectFlags aspectMask)
		=> vkCmdSetAttachmentFeedbackLoopEnableEXT_ptr(commandBuffer, aspectMask);

	public static void SetInstance(VkInstance instance)
	{
		mNativeLib.mInstance = instance;
	}

	public static Result<void> LoadFunction(StringView name, bool invokeErrorCallback = true)
	{
		switch (name) {
		case "vkCreateInstance":
			mNativeLib.LoadFunction("vkCreateInstance", out vkCreateInstance_ptr, invokeErrorCallback);
			if(vkCreateInstance_ptr == null)
				return .Err;
			break;

		case "vkDestroyInstance":
			mNativeLib.LoadFunction("vkDestroyInstance", out vkDestroyInstance_ptr, invokeErrorCallback);
			if(vkDestroyInstance_ptr == null)
				return .Err;
			break;

		case "vkEnumeratePhysicalDevices":
			mNativeLib.LoadFunction("vkEnumeratePhysicalDevices", out vkEnumeratePhysicalDevices_ptr, invokeErrorCallback);
			if(vkEnumeratePhysicalDevices_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceFeatures":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceFeatures", out vkGetPhysicalDeviceFeatures_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceFeatures_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceFormatProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceFormatProperties", out vkGetPhysicalDeviceFormatProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceFormatProperties_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceImageFormatProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceImageFormatProperties", out vkGetPhysicalDeviceImageFormatProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceImageFormatProperties_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceProperties", out vkGetPhysicalDeviceProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceProperties_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceQueueFamilyProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceQueueFamilyProperties", out vkGetPhysicalDeviceQueueFamilyProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceQueueFamilyProperties_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceMemoryProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceMemoryProperties", out vkGetPhysicalDeviceMemoryProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceMemoryProperties_ptr == null)
				return .Err;
			break;

		case "vkGetInstanceProcAddr":
			mNativeLib.LoadFunction("vkGetInstanceProcAddr", out vkGetInstanceProcAddr_ptr, invokeErrorCallback);
			if(vkGetInstanceProcAddr_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceProcAddr":
			mNativeLib.LoadFunction("vkGetDeviceProcAddr", out vkGetDeviceProcAddr_ptr, invokeErrorCallback);
			if(vkGetDeviceProcAddr_ptr == null)
				return .Err;
			break;

		case "vkCreateDevice":
			mNativeLib.LoadFunction("vkCreateDevice", out vkCreateDevice_ptr, invokeErrorCallback);
			if(vkCreateDevice_ptr == null)
				return .Err;
			break;

		case "vkDestroyDevice":
			mNativeLib.LoadFunction("vkDestroyDevice", out vkDestroyDevice_ptr, invokeErrorCallback);
			if(vkDestroyDevice_ptr == null)
				return .Err;
			break;

		case "vkEnumerateInstanceExtensionProperties":
			mNativeLib.LoadFunction("vkEnumerateInstanceExtensionProperties", out vkEnumerateInstanceExtensionProperties_ptr, invokeErrorCallback);
			if(vkEnumerateInstanceExtensionProperties_ptr == null)
				return .Err;
			break;

		case "vkEnumerateDeviceExtensionProperties":
			mNativeLib.LoadFunction("vkEnumerateDeviceExtensionProperties", out vkEnumerateDeviceExtensionProperties_ptr, invokeErrorCallback);
			if(vkEnumerateDeviceExtensionProperties_ptr == null)
				return .Err;
			break;

		case "vkEnumerateInstanceLayerProperties":
			mNativeLib.LoadFunction("vkEnumerateInstanceLayerProperties", out vkEnumerateInstanceLayerProperties_ptr, invokeErrorCallback);
			if(vkEnumerateInstanceLayerProperties_ptr == null)
				return .Err;
			break;

		case "vkEnumerateDeviceLayerProperties":
			mNativeLib.LoadFunction("vkEnumerateDeviceLayerProperties", out vkEnumerateDeviceLayerProperties_ptr, invokeErrorCallback);
			if(vkEnumerateDeviceLayerProperties_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceQueue":
			mNativeLib.LoadFunction("vkGetDeviceQueue", out vkGetDeviceQueue_ptr, invokeErrorCallback);
			if(vkGetDeviceQueue_ptr == null)
				return .Err;
			break;

		case "vkQueueSubmit":
			mNativeLib.LoadFunction("vkQueueSubmit", out vkQueueSubmit_ptr, invokeErrorCallback);
			if(vkQueueSubmit_ptr == null)
				return .Err;
			break;

		case "vkQueueWaitIdle":
			mNativeLib.LoadFunction("vkQueueWaitIdle", out vkQueueWaitIdle_ptr, invokeErrorCallback);
			if(vkQueueWaitIdle_ptr == null)
				return .Err;
			break;

		case "vkDeviceWaitIdle":
			mNativeLib.LoadFunction("vkDeviceWaitIdle", out vkDeviceWaitIdle_ptr, invokeErrorCallback);
			if(vkDeviceWaitIdle_ptr == null)
				return .Err;
			break;

		case "vkAllocateMemory":
			mNativeLib.LoadFunction("vkAllocateMemory", out vkAllocateMemory_ptr, invokeErrorCallback);
			if(vkAllocateMemory_ptr == null)
				return .Err;
			break;

		case "vkFreeMemory":
			mNativeLib.LoadFunction("vkFreeMemory", out vkFreeMemory_ptr, invokeErrorCallback);
			if(vkFreeMemory_ptr == null)
				return .Err;
			break;

		case "vkMapMemory":
			mNativeLib.LoadFunction("vkMapMemory", out vkMapMemory_ptr, invokeErrorCallback);
			if(vkMapMemory_ptr == null)
				return .Err;
			break;

		case "vkUnmapMemory":
			mNativeLib.LoadFunction("vkUnmapMemory", out vkUnmapMemory_ptr, invokeErrorCallback);
			if(vkUnmapMemory_ptr == null)
				return .Err;
			break;

		case "vkFlushMappedMemoryRanges":
			mNativeLib.LoadFunction("vkFlushMappedMemoryRanges", out vkFlushMappedMemoryRanges_ptr, invokeErrorCallback);
			if(vkFlushMappedMemoryRanges_ptr == null)
				return .Err;
			break;

		case "vkInvalidateMappedMemoryRanges":
			mNativeLib.LoadFunction("vkInvalidateMappedMemoryRanges", out vkInvalidateMappedMemoryRanges_ptr, invokeErrorCallback);
			if(vkInvalidateMappedMemoryRanges_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceMemoryCommitment":
			mNativeLib.LoadFunction("vkGetDeviceMemoryCommitment", out vkGetDeviceMemoryCommitment_ptr, invokeErrorCallback);
			if(vkGetDeviceMemoryCommitment_ptr == null)
				return .Err;
			break;

		case "vkBindBufferMemory":
			mNativeLib.LoadFunction("vkBindBufferMemory", out vkBindBufferMemory_ptr, invokeErrorCallback);
			if(vkBindBufferMemory_ptr == null)
				return .Err;
			break;

		case "vkBindImageMemory":
			mNativeLib.LoadFunction("vkBindImageMemory", out vkBindImageMemory_ptr, invokeErrorCallback);
			if(vkBindImageMemory_ptr == null)
				return .Err;
			break;

		case "vkGetBufferMemoryRequirements":
			mNativeLib.LoadFunction("vkGetBufferMemoryRequirements", out vkGetBufferMemoryRequirements_ptr, invokeErrorCallback);
			if(vkGetBufferMemoryRequirements_ptr == null)
				return .Err;
			break;

		case "vkGetImageMemoryRequirements":
			mNativeLib.LoadFunction("vkGetImageMemoryRequirements", out vkGetImageMemoryRequirements_ptr, invokeErrorCallback);
			if(vkGetImageMemoryRequirements_ptr == null)
				return .Err;
			break;

		case "vkGetImageSparseMemoryRequirements":
			mNativeLib.LoadFunction("vkGetImageSparseMemoryRequirements", out vkGetImageSparseMemoryRequirements_ptr, invokeErrorCallback);
			if(vkGetImageSparseMemoryRequirements_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSparseImageFormatProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSparseImageFormatProperties", out vkGetPhysicalDeviceSparseImageFormatProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSparseImageFormatProperties_ptr == null)
				return .Err;
			break;

		case "vkQueueBindSparse":
			mNativeLib.LoadFunction("vkQueueBindSparse", out vkQueueBindSparse_ptr, invokeErrorCallback);
			if(vkQueueBindSparse_ptr == null)
				return .Err;
			break;

		case "vkCreateFence":
			mNativeLib.LoadFunction("vkCreateFence", out vkCreateFence_ptr, invokeErrorCallback);
			if(vkCreateFence_ptr == null)
				return .Err;
			break;

		case "vkDestroyFence":
			mNativeLib.LoadFunction("vkDestroyFence", out vkDestroyFence_ptr, invokeErrorCallback);
			if(vkDestroyFence_ptr == null)
				return .Err;
			break;

		case "vkResetFences":
			mNativeLib.LoadFunction("vkResetFences", out vkResetFences_ptr, invokeErrorCallback);
			if(vkResetFences_ptr == null)
				return .Err;
			break;

		case "vkGetFenceStatus":
			mNativeLib.LoadFunction("vkGetFenceStatus", out vkGetFenceStatus_ptr, invokeErrorCallback);
			if(vkGetFenceStatus_ptr == null)
				return .Err;
			break;

		case "vkWaitForFences":
			mNativeLib.LoadFunction("vkWaitForFences", out vkWaitForFences_ptr, invokeErrorCallback);
			if(vkWaitForFences_ptr == null)
				return .Err;
			break;

		case "vkCreateSemaphore":
			mNativeLib.LoadFunction("vkCreateSemaphore", out vkCreateSemaphore_ptr, invokeErrorCallback);
			if(vkCreateSemaphore_ptr == null)
				return .Err;
			break;

		case "vkDestroySemaphore":
			mNativeLib.LoadFunction("vkDestroySemaphore", out vkDestroySemaphore_ptr, invokeErrorCallback);
			if(vkDestroySemaphore_ptr == null)
				return .Err;
			break;

		case "vkCreateEvent":
			mNativeLib.LoadFunction("vkCreateEvent", out vkCreateEvent_ptr, invokeErrorCallback);
			if(vkCreateEvent_ptr == null)
				return .Err;
			break;

		case "vkDestroyEvent":
			mNativeLib.LoadFunction("vkDestroyEvent", out vkDestroyEvent_ptr, invokeErrorCallback);
			if(vkDestroyEvent_ptr == null)
				return .Err;
			break;

		case "vkGetEventStatus":
			mNativeLib.LoadFunction("vkGetEventStatus", out vkGetEventStatus_ptr, invokeErrorCallback);
			if(vkGetEventStatus_ptr == null)
				return .Err;
			break;

		case "vkSetEvent":
			mNativeLib.LoadFunction("vkSetEvent", out vkSetEvent_ptr, invokeErrorCallback);
			if(vkSetEvent_ptr == null)
				return .Err;
			break;

		case "vkResetEvent":
			mNativeLib.LoadFunction("vkResetEvent", out vkResetEvent_ptr, invokeErrorCallback);
			if(vkResetEvent_ptr == null)
				return .Err;
			break;

		case "vkCreateQueryPool":
			mNativeLib.LoadFunction("vkCreateQueryPool", out vkCreateQueryPool_ptr, invokeErrorCallback);
			if(vkCreateQueryPool_ptr == null)
				return .Err;
			break;

		case "vkDestroyQueryPool":
			mNativeLib.LoadFunction("vkDestroyQueryPool", out vkDestroyQueryPool_ptr, invokeErrorCallback);
			if(vkDestroyQueryPool_ptr == null)
				return .Err;
			break;

		case "vkGetQueryPoolResults":
			mNativeLib.LoadFunction("vkGetQueryPoolResults", out vkGetQueryPoolResults_ptr, invokeErrorCallback);
			if(vkGetQueryPoolResults_ptr == null)
				return .Err;
			break;

		case "vkCreateBuffer":
			mNativeLib.LoadFunction("vkCreateBuffer", out vkCreateBuffer_ptr, invokeErrorCallback);
			if(vkCreateBuffer_ptr == null)
				return .Err;
			break;

		case "vkDestroyBuffer":
			mNativeLib.LoadFunction("vkDestroyBuffer", out vkDestroyBuffer_ptr, invokeErrorCallback);
			if(vkDestroyBuffer_ptr == null)
				return .Err;
			break;

		case "vkCreateBufferView":
			mNativeLib.LoadFunction("vkCreateBufferView", out vkCreateBufferView_ptr, invokeErrorCallback);
			if(vkCreateBufferView_ptr == null)
				return .Err;
			break;

		case "vkDestroyBufferView":
			mNativeLib.LoadFunction("vkDestroyBufferView", out vkDestroyBufferView_ptr, invokeErrorCallback);
			if(vkDestroyBufferView_ptr == null)
				return .Err;
			break;

		case "vkCreateImage":
			mNativeLib.LoadFunction("vkCreateImage", out vkCreateImage_ptr, invokeErrorCallback);
			if(vkCreateImage_ptr == null)
				return .Err;
			break;

		case "vkDestroyImage":
			mNativeLib.LoadFunction("vkDestroyImage", out vkDestroyImage_ptr, invokeErrorCallback);
			if(vkDestroyImage_ptr == null)
				return .Err;
			break;

		case "vkGetImageSubresourceLayout":
			mNativeLib.LoadFunction("vkGetImageSubresourceLayout", out vkGetImageSubresourceLayout_ptr, invokeErrorCallback);
			if(vkGetImageSubresourceLayout_ptr == null)
				return .Err;
			break;

		case "vkCreateImageView":
			mNativeLib.LoadFunction("vkCreateImageView", out vkCreateImageView_ptr, invokeErrorCallback);
			if(vkCreateImageView_ptr == null)
				return .Err;
			break;

		case "vkDestroyImageView":
			mNativeLib.LoadFunction("vkDestroyImageView", out vkDestroyImageView_ptr, invokeErrorCallback);
			if(vkDestroyImageView_ptr == null)
				return .Err;
			break;

		case "vkCreateShaderModule":
			mNativeLib.LoadFunction("vkCreateShaderModule", out vkCreateShaderModule_ptr, invokeErrorCallback);
			if(vkCreateShaderModule_ptr == null)
				return .Err;
			break;

		case "vkDestroyShaderModule":
			mNativeLib.LoadFunction("vkDestroyShaderModule", out vkDestroyShaderModule_ptr, invokeErrorCallback);
			if(vkDestroyShaderModule_ptr == null)
				return .Err;
			break;

		case "vkCreatePipelineCache":
			mNativeLib.LoadFunction("vkCreatePipelineCache", out vkCreatePipelineCache_ptr, invokeErrorCallback);
			if(vkCreatePipelineCache_ptr == null)
				return .Err;
			break;

		case "vkDestroyPipelineCache":
			mNativeLib.LoadFunction("vkDestroyPipelineCache", out vkDestroyPipelineCache_ptr, invokeErrorCallback);
			if(vkDestroyPipelineCache_ptr == null)
				return .Err;
			break;

		case "vkGetPipelineCacheData":
			mNativeLib.LoadFunction("vkGetPipelineCacheData", out vkGetPipelineCacheData_ptr, invokeErrorCallback);
			if(vkGetPipelineCacheData_ptr == null)
				return .Err;
			break;

		case "vkMergePipelineCaches":
			mNativeLib.LoadFunction("vkMergePipelineCaches", out vkMergePipelineCaches_ptr, invokeErrorCallback);
			if(vkMergePipelineCaches_ptr == null)
				return .Err;
			break;

		case "vkCreateGraphicsPipelines":
			mNativeLib.LoadFunction("vkCreateGraphicsPipelines", out vkCreateGraphicsPipelines_ptr, invokeErrorCallback);
			if(vkCreateGraphicsPipelines_ptr == null)
				return .Err;
			break;

		case "vkCreateComputePipelines":
			mNativeLib.LoadFunction("vkCreateComputePipelines", out vkCreateComputePipelines_ptr, invokeErrorCallback);
			if(vkCreateComputePipelines_ptr == null)
				return .Err;
			break;

		case "vkDestroyPipeline":
			mNativeLib.LoadFunction("vkDestroyPipeline", out vkDestroyPipeline_ptr, invokeErrorCallback);
			if(vkDestroyPipeline_ptr == null)
				return .Err;
			break;

		case "vkCreatePipelineLayout":
			mNativeLib.LoadFunction("vkCreatePipelineLayout", out vkCreatePipelineLayout_ptr, invokeErrorCallback);
			if(vkCreatePipelineLayout_ptr == null)
				return .Err;
			break;

		case "vkDestroyPipelineLayout":
			mNativeLib.LoadFunction("vkDestroyPipelineLayout", out vkDestroyPipelineLayout_ptr, invokeErrorCallback);
			if(vkDestroyPipelineLayout_ptr == null)
				return .Err;
			break;

		case "vkCreateSampler":
			mNativeLib.LoadFunction("vkCreateSampler", out vkCreateSampler_ptr, invokeErrorCallback);
			if(vkCreateSampler_ptr == null)
				return .Err;
			break;

		case "vkDestroySampler":
			mNativeLib.LoadFunction("vkDestroySampler", out vkDestroySampler_ptr, invokeErrorCallback);
			if(vkDestroySampler_ptr == null)
				return .Err;
			break;

		case "vkCreateDescriptorSetLayout":
			mNativeLib.LoadFunction("vkCreateDescriptorSetLayout", out vkCreateDescriptorSetLayout_ptr, invokeErrorCallback);
			if(vkCreateDescriptorSetLayout_ptr == null)
				return .Err;
			break;

		case "vkDestroyDescriptorSetLayout":
			mNativeLib.LoadFunction("vkDestroyDescriptorSetLayout", out vkDestroyDescriptorSetLayout_ptr, invokeErrorCallback);
			if(vkDestroyDescriptorSetLayout_ptr == null)
				return .Err;
			break;

		case "vkCreateDescriptorPool":
			mNativeLib.LoadFunction("vkCreateDescriptorPool", out vkCreateDescriptorPool_ptr, invokeErrorCallback);
			if(vkCreateDescriptorPool_ptr == null)
				return .Err;
			break;

		case "vkDestroyDescriptorPool":
			mNativeLib.LoadFunction("vkDestroyDescriptorPool", out vkDestroyDescriptorPool_ptr, invokeErrorCallback);
			if(vkDestroyDescriptorPool_ptr == null)
				return .Err;
			break;

		case "vkResetDescriptorPool":
			mNativeLib.LoadFunction("vkResetDescriptorPool", out vkResetDescriptorPool_ptr, invokeErrorCallback);
			if(vkResetDescriptorPool_ptr == null)
				return .Err;
			break;

		case "vkAllocateDescriptorSets":
			mNativeLib.LoadFunction("vkAllocateDescriptorSets", out vkAllocateDescriptorSets_ptr, invokeErrorCallback);
			if(vkAllocateDescriptorSets_ptr == null)
				return .Err;
			break;

		case "vkFreeDescriptorSets":
			mNativeLib.LoadFunction("vkFreeDescriptorSets", out vkFreeDescriptorSets_ptr, invokeErrorCallback);
			if(vkFreeDescriptorSets_ptr == null)
				return .Err;
			break;

		case "vkUpdateDescriptorSets":
			mNativeLib.LoadFunction("vkUpdateDescriptorSets", out vkUpdateDescriptorSets_ptr, invokeErrorCallback);
			if(vkUpdateDescriptorSets_ptr == null)
				return .Err;
			break;

		case "vkCreateFramebuffer":
			mNativeLib.LoadFunction("vkCreateFramebuffer", out vkCreateFramebuffer_ptr, invokeErrorCallback);
			if(vkCreateFramebuffer_ptr == null)
				return .Err;
			break;

		case "vkDestroyFramebuffer":
			mNativeLib.LoadFunction("vkDestroyFramebuffer", out vkDestroyFramebuffer_ptr, invokeErrorCallback);
			if(vkDestroyFramebuffer_ptr == null)
				return .Err;
			break;

		case "vkCreateRenderPass":
			mNativeLib.LoadFunction("vkCreateRenderPass", out vkCreateRenderPass_ptr, invokeErrorCallback);
			if(vkCreateRenderPass_ptr == null)
				return .Err;
			break;

		case "vkDestroyRenderPass":
			mNativeLib.LoadFunction("vkDestroyRenderPass", out vkDestroyRenderPass_ptr, invokeErrorCallback);
			if(vkDestroyRenderPass_ptr == null)
				return .Err;
			break;

		case "vkGetRenderAreaGranularity":
			mNativeLib.LoadFunction("vkGetRenderAreaGranularity", out vkGetRenderAreaGranularity_ptr, invokeErrorCallback);
			if(vkGetRenderAreaGranularity_ptr == null)
				return .Err;
			break;

		case "vkCreateCommandPool":
			mNativeLib.LoadFunction("vkCreateCommandPool", out vkCreateCommandPool_ptr, invokeErrorCallback);
			if(vkCreateCommandPool_ptr == null)
				return .Err;
			break;

		case "vkDestroyCommandPool":
			mNativeLib.LoadFunction("vkDestroyCommandPool", out vkDestroyCommandPool_ptr, invokeErrorCallback);
			if(vkDestroyCommandPool_ptr == null)
				return .Err;
			break;

		case "vkResetCommandPool":
			mNativeLib.LoadFunction("vkResetCommandPool", out vkResetCommandPool_ptr, invokeErrorCallback);
			if(vkResetCommandPool_ptr == null)
				return .Err;
			break;

		case "vkAllocateCommandBuffers":
			mNativeLib.LoadFunction("vkAllocateCommandBuffers", out vkAllocateCommandBuffers_ptr, invokeErrorCallback);
			if(vkAllocateCommandBuffers_ptr == null)
				return .Err;
			break;

		case "vkFreeCommandBuffers":
			mNativeLib.LoadFunction("vkFreeCommandBuffers", out vkFreeCommandBuffers_ptr, invokeErrorCallback);
			if(vkFreeCommandBuffers_ptr == null)
				return .Err;
			break;

		case "vkBeginCommandBuffer":
			mNativeLib.LoadFunction("vkBeginCommandBuffer", out vkBeginCommandBuffer_ptr, invokeErrorCallback);
			if(vkBeginCommandBuffer_ptr == null)
				return .Err;
			break;

		case "vkEndCommandBuffer":
			mNativeLib.LoadFunction("vkEndCommandBuffer", out vkEndCommandBuffer_ptr, invokeErrorCallback);
			if(vkEndCommandBuffer_ptr == null)
				return .Err;
			break;

		case "vkResetCommandBuffer":
			mNativeLib.LoadFunction("vkResetCommandBuffer", out vkResetCommandBuffer_ptr, invokeErrorCallback);
			if(vkResetCommandBuffer_ptr == null)
				return .Err;
			break;

		case "vkCmdBindPipeline":
			mNativeLib.LoadFunction("vkCmdBindPipeline", out vkCmdBindPipeline_ptr, invokeErrorCallback);
			if(vkCmdBindPipeline_ptr == null)
				return .Err;
			break;

		case "vkCmdSetViewport":
			mNativeLib.LoadFunction("vkCmdSetViewport", out vkCmdSetViewport_ptr, invokeErrorCallback);
			if(vkCmdSetViewport_ptr == null)
				return .Err;
			break;

		case "vkCmdSetScissor":
			mNativeLib.LoadFunction("vkCmdSetScissor", out vkCmdSetScissor_ptr, invokeErrorCallback);
			if(vkCmdSetScissor_ptr == null)
				return .Err;
			break;

		case "vkCmdSetLineWidth":
			mNativeLib.LoadFunction("vkCmdSetLineWidth", out vkCmdSetLineWidth_ptr, invokeErrorCallback);
			if(vkCmdSetLineWidth_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthBias":
			mNativeLib.LoadFunction("vkCmdSetDepthBias", out vkCmdSetDepthBias_ptr, invokeErrorCallback);
			if(vkCmdSetDepthBias_ptr == null)
				return .Err;
			break;

		case "vkCmdSetBlendConstants":
			mNativeLib.LoadFunction("vkCmdSetBlendConstants", out vkCmdSetBlendConstants_ptr, invokeErrorCallback);
			if(vkCmdSetBlendConstants_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthBounds":
			mNativeLib.LoadFunction("vkCmdSetDepthBounds", out vkCmdSetDepthBounds_ptr, invokeErrorCallback);
			if(vkCmdSetDepthBounds_ptr == null)
				return .Err;
			break;

		case "vkCmdSetStencilCompareMask":
			mNativeLib.LoadFunction("vkCmdSetStencilCompareMask", out vkCmdSetStencilCompareMask_ptr, invokeErrorCallback);
			if(vkCmdSetStencilCompareMask_ptr == null)
				return .Err;
			break;

		case "vkCmdSetStencilWriteMask":
			mNativeLib.LoadFunction("vkCmdSetStencilWriteMask", out vkCmdSetStencilWriteMask_ptr, invokeErrorCallback);
			if(vkCmdSetStencilWriteMask_ptr == null)
				return .Err;
			break;

		case "vkCmdSetStencilReference":
			mNativeLib.LoadFunction("vkCmdSetStencilReference", out vkCmdSetStencilReference_ptr, invokeErrorCallback);
			if(vkCmdSetStencilReference_ptr == null)
				return .Err;
			break;

		case "vkCmdBindDescriptorSets":
			mNativeLib.LoadFunction("vkCmdBindDescriptorSets", out vkCmdBindDescriptorSets_ptr, invokeErrorCallback);
			if(vkCmdBindDescriptorSets_ptr == null)
				return .Err;
			break;

		case "vkCmdBindIndexBuffer":
			mNativeLib.LoadFunction("vkCmdBindIndexBuffer", out vkCmdBindIndexBuffer_ptr, invokeErrorCallback);
			if(vkCmdBindIndexBuffer_ptr == null)
				return .Err;
			break;

		case "vkCmdBindVertexBuffers":
			mNativeLib.LoadFunction("vkCmdBindVertexBuffers", out vkCmdBindVertexBuffers_ptr, invokeErrorCallback);
			if(vkCmdBindVertexBuffers_ptr == null)
				return .Err;
			break;

		case "vkCmdDraw":
			mNativeLib.LoadFunction("vkCmdDraw", out vkCmdDraw_ptr, invokeErrorCallback);
			if(vkCmdDraw_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawIndexed":
			mNativeLib.LoadFunction("vkCmdDrawIndexed", out vkCmdDrawIndexed_ptr, invokeErrorCallback);
			if(vkCmdDrawIndexed_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawIndirect":
			mNativeLib.LoadFunction("vkCmdDrawIndirect", out vkCmdDrawIndirect_ptr, invokeErrorCallback);
			if(vkCmdDrawIndirect_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawIndexedIndirect":
			mNativeLib.LoadFunction("vkCmdDrawIndexedIndirect", out vkCmdDrawIndexedIndirect_ptr, invokeErrorCallback);
			if(vkCmdDrawIndexedIndirect_ptr == null)
				return .Err;
			break;

		case "vkCmdDispatch":
			mNativeLib.LoadFunction("vkCmdDispatch", out vkCmdDispatch_ptr, invokeErrorCallback);
			if(vkCmdDispatch_ptr == null)
				return .Err;
			break;

		case "vkCmdDispatchIndirect":
			mNativeLib.LoadFunction("vkCmdDispatchIndirect", out vkCmdDispatchIndirect_ptr, invokeErrorCallback);
			if(vkCmdDispatchIndirect_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyBuffer":
			mNativeLib.LoadFunction("vkCmdCopyBuffer", out vkCmdCopyBuffer_ptr, invokeErrorCallback);
			if(vkCmdCopyBuffer_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyImage":
			mNativeLib.LoadFunction("vkCmdCopyImage", out vkCmdCopyImage_ptr, invokeErrorCallback);
			if(vkCmdCopyImage_ptr == null)
				return .Err;
			break;

		case "vkCmdBlitImage":
			mNativeLib.LoadFunction("vkCmdBlitImage", out vkCmdBlitImage_ptr, invokeErrorCallback);
			if(vkCmdBlitImage_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyBufferToImage":
			mNativeLib.LoadFunction("vkCmdCopyBufferToImage", out vkCmdCopyBufferToImage_ptr, invokeErrorCallback);
			if(vkCmdCopyBufferToImage_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyImageToBuffer":
			mNativeLib.LoadFunction("vkCmdCopyImageToBuffer", out vkCmdCopyImageToBuffer_ptr, invokeErrorCallback);
			if(vkCmdCopyImageToBuffer_ptr == null)
				return .Err;
			break;

		case "vkCmdUpdateBuffer":
			mNativeLib.LoadFunction("vkCmdUpdateBuffer", out vkCmdUpdateBuffer_ptr, invokeErrorCallback);
			if(vkCmdUpdateBuffer_ptr == null)
				return .Err;
			break;

		case "vkCmdFillBuffer":
			mNativeLib.LoadFunction("vkCmdFillBuffer", out vkCmdFillBuffer_ptr, invokeErrorCallback);
			if(vkCmdFillBuffer_ptr == null)
				return .Err;
			break;

		case "vkCmdClearColorImage":
			mNativeLib.LoadFunction("vkCmdClearColorImage", out vkCmdClearColorImage_ptr, invokeErrorCallback);
			if(vkCmdClearColorImage_ptr == null)
				return .Err;
			break;

		case "vkCmdClearDepthStencilImage":
			mNativeLib.LoadFunction("vkCmdClearDepthStencilImage", out vkCmdClearDepthStencilImage_ptr, invokeErrorCallback);
			if(vkCmdClearDepthStencilImage_ptr == null)
				return .Err;
			break;

		case "vkCmdClearAttachments":
			mNativeLib.LoadFunction("vkCmdClearAttachments", out vkCmdClearAttachments_ptr, invokeErrorCallback);
			if(vkCmdClearAttachments_ptr == null)
				return .Err;
			break;

		case "vkCmdResolveImage":
			mNativeLib.LoadFunction("vkCmdResolveImage", out vkCmdResolveImage_ptr, invokeErrorCallback);
			if(vkCmdResolveImage_ptr == null)
				return .Err;
			break;

		case "vkCmdSetEvent":
			mNativeLib.LoadFunction("vkCmdSetEvent", out vkCmdSetEvent_ptr, invokeErrorCallback);
			if(vkCmdSetEvent_ptr == null)
				return .Err;
			break;

		case "vkCmdResetEvent":
			mNativeLib.LoadFunction("vkCmdResetEvent", out vkCmdResetEvent_ptr, invokeErrorCallback);
			if(vkCmdResetEvent_ptr == null)
				return .Err;
			break;

		case "vkCmdWaitEvents":
			mNativeLib.LoadFunction("vkCmdWaitEvents", out vkCmdWaitEvents_ptr, invokeErrorCallback);
			if(vkCmdWaitEvents_ptr == null)
				return .Err;
			break;

		case "vkCmdPipelineBarrier":
			mNativeLib.LoadFunction("vkCmdPipelineBarrier", out vkCmdPipelineBarrier_ptr, invokeErrorCallback);
			if(vkCmdPipelineBarrier_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginQuery":
			mNativeLib.LoadFunction("vkCmdBeginQuery", out vkCmdBeginQuery_ptr, invokeErrorCallback);
			if(vkCmdBeginQuery_ptr == null)
				return .Err;
			break;

		case "vkCmdEndQuery":
			mNativeLib.LoadFunction("vkCmdEndQuery", out vkCmdEndQuery_ptr, invokeErrorCallback);
			if(vkCmdEndQuery_ptr == null)
				return .Err;
			break;

		case "vkCmdResetQueryPool":
			mNativeLib.LoadFunction("vkCmdResetQueryPool", out vkCmdResetQueryPool_ptr, invokeErrorCallback);
			if(vkCmdResetQueryPool_ptr == null)
				return .Err;
			break;

		case "vkCmdWriteTimestamp":
			mNativeLib.LoadFunction("vkCmdWriteTimestamp", out vkCmdWriteTimestamp_ptr, invokeErrorCallback);
			if(vkCmdWriteTimestamp_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyQueryPoolResults":
			mNativeLib.LoadFunction("vkCmdCopyQueryPoolResults", out vkCmdCopyQueryPoolResults_ptr, invokeErrorCallback);
			if(vkCmdCopyQueryPoolResults_ptr == null)
				return .Err;
			break;

		case "vkCmdPushConstants":
			mNativeLib.LoadFunction("vkCmdPushConstants", out vkCmdPushConstants_ptr, invokeErrorCallback);
			if(vkCmdPushConstants_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginRenderPass":
			mNativeLib.LoadFunction("vkCmdBeginRenderPass", out vkCmdBeginRenderPass_ptr, invokeErrorCallback);
			if(vkCmdBeginRenderPass_ptr == null)
				return .Err;
			break;

		case "vkCmdNextSubpass":
			mNativeLib.LoadFunction("vkCmdNextSubpass", out vkCmdNextSubpass_ptr, invokeErrorCallback);
			if(vkCmdNextSubpass_ptr == null)
				return .Err;
			break;

		case "vkCmdEndRenderPass":
			mNativeLib.LoadFunction("vkCmdEndRenderPass", out vkCmdEndRenderPass_ptr, invokeErrorCallback);
			if(vkCmdEndRenderPass_ptr == null)
				return .Err;
			break;

		case "vkCmdExecuteCommands":
			mNativeLib.LoadFunction("vkCmdExecuteCommands", out vkCmdExecuteCommands_ptr, invokeErrorCallback);
			if(vkCmdExecuteCommands_ptr == null)
				return .Err;
			break;

		case "vkEnumerateInstanceVersion":
			mNativeLib.LoadFunction("vkEnumerateInstanceVersion", out vkEnumerateInstanceVersion_ptr, invokeErrorCallback);
			if(vkEnumerateInstanceVersion_ptr == null)
				return .Err;
			break;

		case "vkBindBufferMemory2":
			mNativeLib.LoadFunction("vkBindBufferMemory2", out vkBindBufferMemory2_ptr, invokeErrorCallback);
			if(vkBindBufferMemory2_ptr == null)
				return .Err;
			break;

		case "vkBindImageMemory2":
			mNativeLib.LoadFunction("vkBindImageMemory2", out vkBindImageMemory2_ptr, invokeErrorCallback);
			if(vkBindImageMemory2_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceGroupPeerMemoryFeatures":
			mNativeLib.LoadFunction("vkGetDeviceGroupPeerMemoryFeatures", out vkGetDeviceGroupPeerMemoryFeatures_ptr, invokeErrorCallback);
			if(vkGetDeviceGroupPeerMemoryFeatures_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDeviceMask":
			mNativeLib.LoadFunction("vkCmdSetDeviceMask", out vkCmdSetDeviceMask_ptr, invokeErrorCallback);
			if(vkCmdSetDeviceMask_ptr == null)
				return .Err;
			break;

		case "vkCmdDispatchBase":
			mNativeLib.LoadFunction("vkCmdDispatchBase", out vkCmdDispatchBase_ptr, invokeErrorCallback);
			if(vkCmdDispatchBase_ptr == null)
				return .Err;
			break;

		case "vkEnumeratePhysicalDeviceGroups":
			mNativeLib.LoadFunction("vkEnumeratePhysicalDeviceGroups", out vkEnumeratePhysicalDeviceGroups_ptr, invokeErrorCallback);
			if(vkEnumeratePhysicalDeviceGroups_ptr == null)
				return .Err;
			break;

		case "vkGetImageMemoryRequirements2":
			mNativeLib.LoadFunction("vkGetImageMemoryRequirements2", out vkGetImageMemoryRequirements2_ptr, invokeErrorCallback);
			if(vkGetImageMemoryRequirements2_ptr == null)
				return .Err;
			break;

		case "vkGetBufferMemoryRequirements2":
			mNativeLib.LoadFunction("vkGetBufferMemoryRequirements2", out vkGetBufferMemoryRequirements2_ptr, invokeErrorCallback);
			if(vkGetBufferMemoryRequirements2_ptr == null)
				return .Err;
			break;

		case "vkGetImageSparseMemoryRequirements2":
			mNativeLib.LoadFunction("vkGetImageSparseMemoryRequirements2", out vkGetImageSparseMemoryRequirements2_ptr, invokeErrorCallback);
			if(vkGetImageSparseMemoryRequirements2_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceFeatures2":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceFeatures2", out vkGetPhysicalDeviceFeatures2_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceFeatures2_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceProperties2":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceProperties2", out vkGetPhysicalDeviceProperties2_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceProperties2_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceFormatProperties2":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceFormatProperties2", out vkGetPhysicalDeviceFormatProperties2_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceFormatProperties2_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceImageFormatProperties2":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceImageFormatProperties2", out vkGetPhysicalDeviceImageFormatProperties2_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceImageFormatProperties2_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceQueueFamilyProperties2":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceQueueFamilyProperties2", out vkGetPhysicalDeviceQueueFamilyProperties2_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceQueueFamilyProperties2_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceMemoryProperties2":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceMemoryProperties2", out vkGetPhysicalDeviceMemoryProperties2_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceMemoryProperties2_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSparseImageFormatProperties2":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSparseImageFormatProperties2", out vkGetPhysicalDeviceSparseImageFormatProperties2_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSparseImageFormatProperties2_ptr == null)
				return .Err;
			break;

		case "vkTrimCommandPool":
			mNativeLib.LoadFunction("vkTrimCommandPool", out vkTrimCommandPool_ptr, invokeErrorCallback);
			if(vkTrimCommandPool_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceQueue2":
			mNativeLib.LoadFunction("vkGetDeviceQueue2", out vkGetDeviceQueue2_ptr, invokeErrorCallback);
			if(vkGetDeviceQueue2_ptr == null)
				return .Err;
			break;

		case "vkCreateSamplerYcbcrConversion":
			mNativeLib.LoadFunction("vkCreateSamplerYcbcrConversion", out vkCreateSamplerYcbcrConversion_ptr, invokeErrorCallback);
			if(vkCreateSamplerYcbcrConversion_ptr == null)
				return .Err;
			break;

		case "vkDestroySamplerYcbcrConversion":
			mNativeLib.LoadFunction("vkDestroySamplerYcbcrConversion", out vkDestroySamplerYcbcrConversion_ptr, invokeErrorCallback);
			if(vkDestroySamplerYcbcrConversion_ptr == null)
				return .Err;
			break;

		case "vkCreateDescriptorUpdateTemplate":
			mNativeLib.LoadFunction("vkCreateDescriptorUpdateTemplate", out vkCreateDescriptorUpdateTemplate_ptr, invokeErrorCallback);
			if(vkCreateDescriptorUpdateTemplate_ptr == null)
				return .Err;
			break;

		case "vkDestroyDescriptorUpdateTemplate":
			mNativeLib.LoadFunction("vkDestroyDescriptorUpdateTemplate", out vkDestroyDescriptorUpdateTemplate_ptr, invokeErrorCallback);
			if(vkDestroyDescriptorUpdateTemplate_ptr == null)
				return .Err;
			break;

		case "vkUpdateDescriptorSetWithTemplate":
			mNativeLib.LoadFunction("vkUpdateDescriptorSetWithTemplate", out vkUpdateDescriptorSetWithTemplate_ptr, invokeErrorCallback);
			if(vkUpdateDescriptorSetWithTemplate_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceExternalBufferProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceExternalBufferProperties", out vkGetPhysicalDeviceExternalBufferProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceExternalBufferProperties_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceExternalFenceProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceExternalFenceProperties", out vkGetPhysicalDeviceExternalFenceProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceExternalFenceProperties_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceExternalSemaphoreProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceExternalSemaphoreProperties", out vkGetPhysicalDeviceExternalSemaphoreProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceExternalSemaphoreProperties_ptr == null)
				return .Err;
			break;

		case "vkGetDescriptorSetLayoutSupport":
			mNativeLib.LoadFunction("vkGetDescriptorSetLayoutSupport", out vkGetDescriptorSetLayoutSupport_ptr, invokeErrorCallback);
			if(vkGetDescriptorSetLayoutSupport_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawIndirectCount":
			mNativeLib.LoadFunction("vkCmdDrawIndirectCount", out vkCmdDrawIndirectCount_ptr, invokeErrorCallback);
			if(vkCmdDrawIndirectCount_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawIndexedIndirectCount":
			mNativeLib.LoadFunction("vkCmdDrawIndexedIndirectCount", out vkCmdDrawIndexedIndirectCount_ptr, invokeErrorCallback);
			if(vkCmdDrawIndexedIndirectCount_ptr == null)
				return .Err;
			break;

		case "vkCreateRenderPass2":
			mNativeLib.LoadFunction("vkCreateRenderPass2", out vkCreateRenderPass2_ptr, invokeErrorCallback);
			if(vkCreateRenderPass2_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginRenderPass2":
			mNativeLib.LoadFunction("vkCmdBeginRenderPass2", out vkCmdBeginRenderPass2_ptr, invokeErrorCallback);
			if(vkCmdBeginRenderPass2_ptr == null)
				return .Err;
			break;

		case "vkCmdNextSubpass2":
			mNativeLib.LoadFunction("vkCmdNextSubpass2", out vkCmdNextSubpass2_ptr, invokeErrorCallback);
			if(vkCmdNextSubpass2_ptr == null)
				return .Err;
			break;

		case "vkCmdEndRenderPass2":
			mNativeLib.LoadFunction("vkCmdEndRenderPass2", out vkCmdEndRenderPass2_ptr, invokeErrorCallback);
			if(vkCmdEndRenderPass2_ptr == null)
				return .Err;
			break;

		case "vkResetQueryPool":
			mNativeLib.LoadFunction("vkResetQueryPool", out vkResetQueryPool_ptr, invokeErrorCallback);
			if(vkResetQueryPool_ptr == null)
				return .Err;
			break;

		case "vkGetSemaphoreCounterValue":
			mNativeLib.LoadFunction("vkGetSemaphoreCounterValue", out vkGetSemaphoreCounterValue_ptr, invokeErrorCallback);
			if(vkGetSemaphoreCounterValue_ptr == null)
				return .Err;
			break;

		case "vkWaitSemaphores":
			mNativeLib.LoadFunction("vkWaitSemaphores", out vkWaitSemaphores_ptr, invokeErrorCallback);
			if(vkWaitSemaphores_ptr == null)
				return .Err;
			break;

		case "vkSignalSemaphore":
			mNativeLib.LoadFunction("vkSignalSemaphore", out vkSignalSemaphore_ptr, invokeErrorCallback);
			if(vkSignalSemaphore_ptr == null)
				return .Err;
			break;

		case "vkGetBufferDeviceAddress":
			mNativeLib.LoadFunction("vkGetBufferDeviceAddress", out vkGetBufferDeviceAddress_ptr, invokeErrorCallback);
			if(vkGetBufferDeviceAddress_ptr == null)
				return .Err;
			break;

		case "vkGetBufferOpaqueCaptureAddress":
			mNativeLib.LoadFunction("vkGetBufferOpaqueCaptureAddress", out vkGetBufferOpaqueCaptureAddress_ptr, invokeErrorCallback);
			if(vkGetBufferOpaqueCaptureAddress_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceMemoryOpaqueCaptureAddress":
			mNativeLib.LoadFunction("vkGetDeviceMemoryOpaqueCaptureAddress", out vkGetDeviceMemoryOpaqueCaptureAddress_ptr, invokeErrorCallback);
			if(vkGetDeviceMemoryOpaqueCaptureAddress_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceToolProperties":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceToolProperties", out vkGetPhysicalDeviceToolProperties_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceToolProperties_ptr == null)
				return .Err;
			break;

		case "vkCreatePrivateDataSlot":
			mNativeLib.LoadFunction("vkCreatePrivateDataSlot", out vkCreatePrivateDataSlot_ptr, invokeErrorCallback);
			if(vkCreatePrivateDataSlot_ptr == null)
				return .Err;
			break;

		case "vkDestroyPrivateDataSlot":
			mNativeLib.LoadFunction("vkDestroyPrivateDataSlot", out vkDestroyPrivateDataSlot_ptr, invokeErrorCallback);
			if(vkDestroyPrivateDataSlot_ptr == null)
				return .Err;
			break;

		case "vkSetPrivateData":
			mNativeLib.LoadFunction("vkSetPrivateData", out vkSetPrivateData_ptr, invokeErrorCallback);
			if(vkSetPrivateData_ptr == null)
				return .Err;
			break;

		case "vkGetPrivateData":
			mNativeLib.LoadFunction("vkGetPrivateData", out vkGetPrivateData_ptr, invokeErrorCallback);
			if(vkGetPrivateData_ptr == null)
				return .Err;
			break;

		case "vkCmdSetEvent2":
			mNativeLib.LoadFunction("vkCmdSetEvent2", out vkCmdSetEvent2_ptr, invokeErrorCallback);
			if(vkCmdSetEvent2_ptr == null)
				return .Err;
			break;

		case "vkCmdResetEvent2":
			mNativeLib.LoadFunction("vkCmdResetEvent2", out vkCmdResetEvent2_ptr, invokeErrorCallback);
			if(vkCmdResetEvent2_ptr == null)
				return .Err;
			break;

		case "vkCmdWaitEvents2":
			mNativeLib.LoadFunction("vkCmdWaitEvents2", out vkCmdWaitEvents2_ptr, invokeErrorCallback);
			if(vkCmdWaitEvents2_ptr == null)
				return .Err;
			break;

		case "vkCmdPipelineBarrier2":
			mNativeLib.LoadFunction("vkCmdPipelineBarrier2", out vkCmdPipelineBarrier2_ptr, invokeErrorCallback);
			if(vkCmdPipelineBarrier2_ptr == null)
				return .Err;
			break;

		case "vkCmdWriteTimestamp2":
			mNativeLib.LoadFunction("vkCmdWriteTimestamp2", out vkCmdWriteTimestamp2_ptr, invokeErrorCallback);
			if(vkCmdWriteTimestamp2_ptr == null)
				return .Err;
			break;

		case "vkQueueSubmit2":
			mNativeLib.LoadFunction("vkQueueSubmit2", out vkQueueSubmit2_ptr, invokeErrorCallback);
			if(vkQueueSubmit2_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyBuffer2":
			mNativeLib.LoadFunction("vkCmdCopyBuffer2", out vkCmdCopyBuffer2_ptr, invokeErrorCallback);
			if(vkCmdCopyBuffer2_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyImage2":
			mNativeLib.LoadFunction("vkCmdCopyImage2", out vkCmdCopyImage2_ptr, invokeErrorCallback);
			if(vkCmdCopyImage2_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyBufferToImage2":
			mNativeLib.LoadFunction("vkCmdCopyBufferToImage2", out vkCmdCopyBufferToImage2_ptr, invokeErrorCallback);
			if(vkCmdCopyBufferToImage2_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyImageToBuffer2":
			mNativeLib.LoadFunction("vkCmdCopyImageToBuffer2", out vkCmdCopyImageToBuffer2_ptr, invokeErrorCallback);
			if(vkCmdCopyImageToBuffer2_ptr == null)
				return .Err;
			break;

		case "vkCmdBlitImage2":
			mNativeLib.LoadFunction("vkCmdBlitImage2", out vkCmdBlitImage2_ptr, invokeErrorCallback);
			if(vkCmdBlitImage2_ptr == null)
				return .Err;
			break;

		case "vkCmdResolveImage2":
			mNativeLib.LoadFunction("vkCmdResolveImage2", out vkCmdResolveImage2_ptr, invokeErrorCallback);
			if(vkCmdResolveImage2_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginRendering":
			mNativeLib.LoadFunction("vkCmdBeginRendering", out vkCmdBeginRendering_ptr, invokeErrorCallback);
			if(vkCmdBeginRendering_ptr == null)
				return .Err;
			break;

		case "vkCmdEndRendering":
			mNativeLib.LoadFunction("vkCmdEndRendering", out vkCmdEndRendering_ptr, invokeErrorCallback);
			if(vkCmdEndRendering_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCullMode":
			mNativeLib.LoadFunction("vkCmdSetCullMode", out vkCmdSetCullMode_ptr, invokeErrorCallback);
			if(vkCmdSetCullMode_ptr == null)
				return .Err;
			break;

		case "vkCmdSetFrontFace":
			mNativeLib.LoadFunction("vkCmdSetFrontFace", out vkCmdSetFrontFace_ptr, invokeErrorCallback);
			if(vkCmdSetFrontFace_ptr == null)
				return .Err;
			break;

		case "vkCmdSetPrimitiveTopology":
			mNativeLib.LoadFunction("vkCmdSetPrimitiveTopology", out vkCmdSetPrimitiveTopology_ptr, invokeErrorCallback);
			if(vkCmdSetPrimitiveTopology_ptr == null)
				return .Err;
			break;

		case "vkCmdSetViewportWithCount":
			mNativeLib.LoadFunction("vkCmdSetViewportWithCount", out vkCmdSetViewportWithCount_ptr, invokeErrorCallback);
			if(vkCmdSetViewportWithCount_ptr == null)
				return .Err;
			break;

		case "vkCmdSetScissorWithCount":
			mNativeLib.LoadFunction("vkCmdSetScissorWithCount", out vkCmdSetScissorWithCount_ptr, invokeErrorCallback);
			if(vkCmdSetScissorWithCount_ptr == null)
				return .Err;
			break;

		case "vkCmdBindVertexBuffers2":
			mNativeLib.LoadFunction("vkCmdBindVertexBuffers2", out vkCmdBindVertexBuffers2_ptr, invokeErrorCallback);
			if(vkCmdBindVertexBuffers2_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthTestEnable":
			mNativeLib.LoadFunction("vkCmdSetDepthTestEnable", out vkCmdSetDepthTestEnable_ptr, invokeErrorCallback);
			if(vkCmdSetDepthTestEnable_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthWriteEnable":
			mNativeLib.LoadFunction("vkCmdSetDepthWriteEnable", out vkCmdSetDepthWriteEnable_ptr, invokeErrorCallback);
			if(vkCmdSetDepthWriteEnable_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthCompareOp":
			mNativeLib.LoadFunction("vkCmdSetDepthCompareOp", out vkCmdSetDepthCompareOp_ptr, invokeErrorCallback);
			if(vkCmdSetDepthCompareOp_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthBoundsTestEnable":
			mNativeLib.LoadFunction("vkCmdSetDepthBoundsTestEnable", out vkCmdSetDepthBoundsTestEnable_ptr, invokeErrorCallback);
			if(vkCmdSetDepthBoundsTestEnable_ptr == null)
				return .Err;
			break;

		case "vkCmdSetStencilTestEnable":
			mNativeLib.LoadFunction("vkCmdSetStencilTestEnable", out vkCmdSetStencilTestEnable_ptr, invokeErrorCallback);
			if(vkCmdSetStencilTestEnable_ptr == null)
				return .Err;
			break;

		case "vkCmdSetStencilOp":
			mNativeLib.LoadFunction("vkCmdSetStencilOp", out vkCmdSetStencilOp_ptr, invokeErrorCallback);
			if(vkCmdSetStencilOp_ptr == null)
				return .Err;
			break;

		case "vkCmdSetRasterizerDiscardEnable":
			mNativeLib.LoadFunction("vkCmdSetRasterizerDiscardEnable", out vkCmdSetRasterizerDiscardEnable_ptr, invokeErrorCallback);
			if(vkCmdSetRasterizerDiscardEnable_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthBiasEnable":
			mNativeLib.LoadFunction("vkCmdSetDepthBiasEnable", out vkCmdSetDepthBiasEnable_ptr, invokeErrorCallback);
			if(vkCmdSetDepthBiasEnable_ptr == null)
				return .Err;
			break;

		case "vkCmdSetPrimitiveRestartEnable":
			mNativeLib.LoadFunction("vkCmdSetPrimitiveRestartEnable", out vkCmdSetPrimitiveRestartEnable_ptr, invokeErrorCallback);
			if(vkCmdSetPrimitiveRestartEnable_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceBufferMemoryRequirements":
			mNativeLib.LoadFunction("vkGetDeviceBufferMemoryRequirements", out vkGetDeviceBufferMemoryRequirements_ptr, invokeErrorCallback);
			if(vkGetDeviceBufferMemoryRequirements_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceImageMemoryRequirements":
			mNativeLib.LoadFunction("vkGetDeviceImageMemoryRequirements", out vkGetDeviceImageMemoryRequirements_ptr, invokeErrorCallback);
			if(vkGetDeviceImageMemoryRequirements_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceImageSparseMemoryRequirements":
			mNativeLib.LoadFunction("vkGetDeviceImageSparseMemoryRequirements", out vkGetDeviceImageSparseMemoryRequirements_ptr, invokeErrorCallback);
			if(vkGetDeviceImageSparseMemoryRequirements_ptr == null)
				return .Err;
			break;

		case "vkGetCommandPoolMemoryConsumption":
			mNativeLib.LoadFunction("vkGetCommandPoolMemoryConsumption", out vkGetCommandPoolMemoryConsumption_ptr, invokeErrorCallback);
			if(vkGetCommandPoolMemoryConsumption_ptr == null)
				return .Err;
			break;

		case "vkGetFaultData":
			mNativeLib.LoadFunction("vkGetFaultData", out vkGetFaultData_ptr, invokeErrorCallback);
			if(vkGetFaultData_ptr == null)
				return .Err;
			break;

		case "vkDestroySurfaceKHR":
			mNativeLib.LoadFunction("vkDestroySurfaceKHR", out vkDestroySurfaceKHR_ptr, invokeErrorCallback);
			if(vkDestroySurfaceKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSurfaceSupportKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSurfaceSupportKHR", out vkGetPhysicalDeviceSurfaceSupportKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSurfaceSupportKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSurfaceCapabilitiesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSurfaceCapabilitiesKHR", out vkGetPhysicalDeviceSurfaceCapabilitiesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSurfaceCapabilitiesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSurfaceFormatsKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSurfaceFormatsKHR", out vkGetPhysicalDeviceSurfaceFormatsKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSurfaceFormatsKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSurfacePresentModesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSurfacePresentModesKHR", out vkGetPhysicalDeviceSurfacePresentModesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSurfacePresentModesKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateSwapchainKHR":
			mNativeLib.LoadFunction("vkCreateSwapchainKHR", out vkCreateSwapchainKHR_ptr, invokeErrorCallback);
			if(vkCreateSwapchainKHR_ptr == null)
				return .Err;
			break;

		case "vkDestroySwapchainKHR":
			mNativeLib.LoadFunction("vkDestroySwapchainKHR", out vkDestroySwapchainKHR_ptr, invokeErrorCallback);
			if(vkDestroySwapchainKHR_ptr == null)
				return .Err;
			break;

		case "vkGetSwapchainImagesKHR":
			mNativeLib.LoadFunction("vkGetSwapchainImagesKHR", out vkGetSwapchainImagesKHR_ptr, invokeErrorCallback);
			if(vkGetSwapchainImagesKHR_ptr == null)
				return .Err;
			break;

		case "vkAcquireNextImageKHR":
			mNativeLib.LoadFunction("vkAcquireNextImageKHR", out vkAcquireNextImageKHR_ptr, invokeErrorCallback);
			if(vkAcquireNextImageKHR_ptr == null)
				return .Err;
			break;

		case "vkQueuePresentKHR":
			mNativeLib.LoadFunction("vkQueuePresentKHR", out vkQueuePresentKHR_ptr, invokeErrorCallback);
			if(vkQueuePresentKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceDisplayPropertiesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceDisplayPropertiesKHR", out vkGetPhysicalDeviceDisplayPropertiesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceDisplayPropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceDisplayPlanePropertiesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceDisplayPlanePropertiesKHR", out vkGetPhysicalDeviceDisplayPlanePropertiesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceDisplayPlanePropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetDisplayPlaneSupportedDisplaysKHR":
			mNativeLib.LoadFunction("vkGetDisplayPlaneSupportedDisplaysKHR", out vkGetDisplayPlaneSupportedDisplaysKHR_ptr, invokeErrorCallback);
			if(vkGetDisplayPlaneSupportedDisplaysKHR_ptr == null)
				return .Err;
			break;

		case "vkGetDisplayModePropertiesKHR":
			mNativeLib.LoadFunction("vkGetDisplayModePropertiesKHR", out vkGetDisplayModePropertiesKHR_ptr, invokeErrorCallback);
			if(vkGetDisplayModePropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateDisplayModeKHR":
			mNativeLib.LoadFunction("vkCreateDisplayModeKHR", out vkCreateDisplayModeKHR_ptr, invokeErrorCallback);
			if(vkCreateDisplayModeKHR_ptr == null)
				return .Err;
			break;

		case "vkGetDisplayPlaneCapabilitiesKHR":
			mNativeLib.LoadFunction("vkGetDisplayPlaneCapabilitiesKHR", out vkGetDisplayPlaneCapabilitiesKHR_ptr, invokeErrorCallback);
			if(vkGetDisplayPlaneCapabilitiesKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateDisplayPlaneSurfaceKHR":
			mNativeLib.LoadFunction("vkCreateDisplayPlaneSurfaceKHR", out vkCreateDisplayPlaneSurfaceKHR_ptr, invokeErrorCallback);
			if(vkCreateDisplayPlaneSurfaceKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateSharedSwapchainsKHR":
			mNativeLib.LoadFunction("vkCreateSharedSwapchainsKHR", out vkCreateSharedSwapchainsKHR_ptr, invokeErrorCallback);
			if(vkCreateSharedSwapchainsKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateXlibSurfaceKHR":
			mNativeLib.LoadFunction("vkCreateXlibSurfaceKHR", out vkCreateXlibSurfaceKHR_ptr, invokeErrorCallback);
			if(vkCreateXlibSurfaceKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceXlibPresentationSupportKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceXlibPresentationSupportKHR", out vkGetPhysicalDeviceXlibPresentationSupportKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceXlibPresentationSupportKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateXcbSurfaceKHR":
			mNativeLib.LoadFunction("vkCreateXcbSurfaceKHR", out vkCreateXcbSurfaceKHR_ptr, invokeErrorCallback);
			if(vkCreateXcbSurfaceKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceXcbPresentationSupportKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceXcbPresentationSupportKHR", out vkGetPhysicalDeviceXcbPresentationSupportKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceXcbPresentationSupportKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateWaylandSurfaceKHR":
			mNativeLib.LoadFunction("vkCreateWaylandSurfaceKHR", out vkCreateWaylandSurfaceKHR_ptr, invokeErrorCallback);
			if(vkCreateWaylandSurfaceKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceWaylandPresentationSupportKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceWaylandPresentationSupportKHR", out vkGetPhysicalDeviceWaylandPresentationSupportKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceWaylandPresentationSupportKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateAndroidSurfaceKHR":
			mNativeLib.LoadFunction("vkCreateAndroidSurfaceKHR", out vkCreateAndroidSurfaceKHR_ptr, invokeErrorCallback);
			if(vkCreateAndroidSurfaceKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateWin32SurfaceKHR":
			mNativeLib.LoadFunction("vkCreateWin32SurfaceKHR", out vkCreateWin32SurfaceKHR_ptr, invokeErrorCallback);
			if(vkCreateWin32SurfaceKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceWin32PresentationSupportKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceWin32PresentationSupportKHR", out vkGetPhysicalDeviceWin32PresentationSupportKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceWin32PresentationSupportKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateDebugReportCallbackEXT":
			mNativeLib.LoadFunction("vkCreateDebugReportCallbackEXT", out vkCreateDebugReportCallbackEXT_ptr, invokeErrorCallback);
			if(vkCreateDebugReportCallbackEXT_ptr == null)
				return .Err;
			break;

		case "vkDestroyDebugReportCallbackEXT":
			mNativeLib.LoadFunction("vkDestroyDebugReportCallbackEXT", out vkDestroyDebugReportCallbackEXT_ptr, invokeErrorCallback);
			if(vkDestroyDebugReportCallbackEXT_ptr == null)
				return .Err;
			break;

		case "vkDebugReportMessageEXT":
			mNativeLib.LoadFunction("vkDebugReportMessageEXT", out vkDebugReportMessageEXT_ptr, invokeErrorCallback);
			if(vkDebugReportMessageEXT_ptr == null)
				return .Err;
			break;

		case "vkDebugMarkerSetObjectTagEXT":
			mNativeLib.LoadFunction("vkDebugMarkerSetObjectTagEXT", out vkDebugMarkerSetObjectTagEXT_ptr, invokeErrorCallback);
			if(vkDebugMarkerSetObjectTagEXT_ptr == null)
				return .Err;
			break;

		case "vkDebugMarkerSetObjectNameEXT":
			mNativeLib.LoadFunction("vkDebugMarkerSetObjectNameEXT", out vkDebugMarkerSetObjectNameEXT_ptr, invokeErrorCallback);
			if(vkDebugMarkerSetObjectNameEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDebugMarkerBeginEXT":
			mNativeLib.LoadFunction("vkCmdDebugMarkerBeginEXT", out vkCmdDebugMarkerBeginEXT_ptr, invokeErrorCallback);
			if(vkCmdDebugMarkerBeginEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDebugMarkerEndEXT":
			mNativeLib.LoadFunction("vkCmdDebugMarkerEndEXT", out vkCmdDebugMarkerEndEXT_ptr, invokeErrorCallback);
			if(vkCmdDebugMarkerEndEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDebugMarkerInsertEXT":
			mNativeLib.LoadFunction("vkCmdDebugMarkerInsertEXT", out vkCmdDebugMarkerInsertEXT_ptr, invokeErrorCallback);
			if(vkCmdDebugMarkerInsertEXT_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceVideoCapabilitiesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceVideoCapabilitiesKHR", out vkGetPhysicalDeviceVideoCapabilitiesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceVideoCapabilitiesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceVideoFormatPropertiesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceVideoFormatPropertiesKHR", out vkGetPhysicalDeviceVideoFormatPropertiesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceVideoFormatPropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateVideoSessionKHR":
			mNativeLib.LoadFunction("vkCreateVideoSessionKHR", out vkCreateVideoSessionKHR_ptr, invokeErrorCallback);
			if(vkCreateVideoSessionKHR_ptr == null)
				return .Err;
			break;

		case "vkDestroyVideoSessionKHR":
			mNativeLib.LoadFunction("vkDestroyVideoSessionKHR", out vkDestroyVideoSessionKHR_ptr, invokeErrorCallback);
			if(vkDestroyVideoSessionKHR_ptr == null)
				return .Err;
			break;

		case "vkGetVideoSessionMemoryRequirementsKHR":
			mNativeLib.LoadFunction("vkGetVideoSessionMemoryRequirementsKHR", out vkGetVideoSessionMemoryRequirementsKHR_ptr, invokeErrorCallback);
			if(vkGetVideoSessionMemoryRequirementsKHR_ptr == null)
				return .Err;
			break;

		case "vkBindVideoSessionMemoryKHR":
			mNativeLib.LoadFunction("vkBindVideoSessionMemoryKHR", out vkBindVideoSessionMemoryKHR_ptr, invokeErrorCallback);
			if(vkBindVideoSessionMemoryKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateVideoSessionParametersKHR":
			mNativeLib.LoadFunction("vkCreateVideoSessionParametersKHR", out vkCreateVideoSessionParametersKHR_ptr, invokeErrorCallback);
			if(vkCreateVideoSessionParametersKHR_ptr == null)
				return .Err;
			break;

		case "vkUpdateVideoSessionParametersKHR":
			mNativeLib.LoadFunction("vkUpdateVideoSessionParametersKHR", out vkUpdateVideoSessionParametersKHR_ptr, invokeErrorCallback);
			if(vkUpdateVideoSessionParametersKHR_ptr == null)
				return .Err;
			break;

		case "vkDestroyVideoSessionParametersKHR":
			mNativeLib.LoadFunction("vkDestroyVideoSessionParametersKHR", out vkDestroyVideoSessionParametersKHR_ptr, invokeErrorCallback);
			if(vkDestroyVideoSessionParametersKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginVideoCodingKHR":
			mNativeLib.LoadFunction("vkCmdBeginVideoCodingKHR", out vkCmdBeginVideoCodingKHR_ptr, invokeErrorCallback);
			if(vkCmdBeginVideoCodingKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdEndVideoCodingKHR":
			mNativeLib.LoadFunction("vkCmdEndVideoCodingKHR", out vkCmdEndVideoCodingKHR_ptr, invokeErrorCallback);
			if(vkCmdEndVideoCodingKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdControlVideoCodingKHR":
			mNativeLib.LoadFunction("vkCmdControlVideoCodingKHR", out vkCmdControlVideoCodingKHR_ptr, invokeErrorCallback);
			if(vkCmdControlVideoCodingKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdDecodeVideoKHR":
			mNativeLib.LoadFunction("vkCmdDecodeVideoKHR", out vkCmdDecodeVideoKHR_ptr, invokeErrorCallback);
			if(vkCmdDecodeVideoKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdBindTransformFeedbackBuffersEXT":
			mNativeLib.LoadFunction("vkCmdBindTransformFeedbackBuffersEXT", out vkCmdBindTransformFeedbackBuffersEXT_ptr, invokeErrorCallback);
			if(vkCmdBindTransformFeedbackBuffersEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginTransformFeedbackEXT":
			mNativeLib.LoadFunction("vkCmdBeginTransformFeedbackEXT", out vkCmdBeginTransformFeedbackEXT_ptr, invokeErrorCallback);
			if(vkCmdBeginTransformFeedbackEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdEndTransformFeedbackEXT":
			mNativeLib.LoadFunction("vkCmdEndTransformFeedbackEXT", out vkCmdEndTransformFeedbackEXT_ptr, invokeErrorCallback);
			if(vkCmdEndTransformFeedbackEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginQueryIndexedEXT":
			mNativeLib.LoadFunction("vkCmdBeginQueryIndexedEXT", out vkCmdBeginQueryIndexedEXT_ptr, invokeErrorCallback);
			if(vkCmdBeginQueryIndexedEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdEndQueryIndexedEXT":
			mNativeLib.LoadFunction("vkCmdEndQueryIndexedEXT", out vkCmdEndQueryIndexedEXT_ptr, invokeErrorCallback);
			if(vkCmdEndQueryIndexedEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawIndirectByteCountEXT":
			mNativeLib.LoadFunction("vkCmdDrawIndirectByteCountEXT", out vkCmdDrawIndirectByteCountEXT_ptr, invokeErrorCallback);
			if(vkCmdDrawIndirectByteCountEXT_ptr == null)
				return .Err;
			break;

		case "vkCreateCuModuleNVX":
			mNativeLib.LoadFunction("vkCreateCuModuleNVX", out vkCreateCuModuleNVX_ptr, invokeErrorCallback);
			if(vkCreateCuModuleNVX_ptr == null)
				return .Err;
			break;

		case "vkCreateCuFunctionNVX":
			mNativeLib.LoadFunction("vkCreateCuFunctionNVX", out vkCreateCuFunctionNVX_ptr, invokeErrorCallback);
			if(vkCreateCuFunctionNVX_ptr == null)
				return .Err;
			break;

		case "vkDestroyCuModuleNVX":
			mNativeLib.LoadFunction("vkDestroyCuModuleNVX", out vkDestroyCuModuleNVX_ptr, invokeErrorCallback);
			if(vkDestroyCuModuleNVX_ptr == null)
				return .Err;
			break;

		case "vkDestroyCuFunctionNVX":
			mNativeLib.LoadFunction("vkDestroyCuFunctionNVX", out vkDestroyCuFunctionNVX_ptr, invokeErrorCallback);
			if(vkDestroyCuFunctionNVX_ptr == null)
				return .Err;
			break;

		case "vkCmdCuLaunchKernelNVX":
			mNativeLib.LoadFunction("vkCmdCuLaunchKernelNVX", out vkCmdCuLaunchKernelNVX_ptr, invokeErrorCallback);
			if(vkCmdCuLaunchKernelNVX_ptr == null)
				return .Err;
			break;

		case "vkGetImageViewHandleNVX":
			mNativeLib.LoadFunction("vkGetImageViewHandleNVX", out vkGetImageViewHandleNVX_ptr, invokeErrorCallback);
			if(vkGetImageViewHandleNVX_ptr == null)
				return .Err;
			break;

		case "vkGetImageViewAddressNVX":
			mNativeLib.LoadFunction("vkGetImageViewAddressNVX", out vkGetImageViewAddressNVX_ptr, invokeErrorCallback);
			if(vkGetImageViewAddressNVX_ptr == null)
				return .Err;
			break;

		case "vkGetShaderInfoAMD":
			mNativeLib.LoadFunction("vkGetShaderInfoAMD", out vkGetShaderInfoAMD_ptr, invokeErrorCallback);
			if(vkGetShaderInfoAMD_ptr == null)
				return .Err;
			break;

		case "vkCreateStreamDescriptorSurfaceGGP":
			mNativeLib.LoadFunction("vkCreateStreamDescriptorSurfaceGGP", out vkCreateStreamDescriptorSurfaceGGP_ptr, invokeErrorCallback);
			if(vkCreateStreamDescriptorSurfaceGGP_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceExternalImageFormatPropertiesNV":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceExternalImageFormatPropertiesNV", out vkGetPhysicalDeviceExternalImageFormatPropertiesNV_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceExternalImageFormatPropertiesNV_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryWin32HandleNV":
			mNativeLib.LoadFunction("vkGetMemoryWin32HandleNV", out vkGetMemoryWin32HandleNV_ptr, invokeErrorCallback);
			if(vkGetMemoryWin32HandleNV_ptr == null)
				return .Err;
			break;

		case "vkCreateViSurfaceNN":
			mNativeLib.LoadFunction("vkCreateViSurfaceNN", out vkCreateViSurfaceNN_ptr, invokeErrorCallback);
			if(vkCreateViSurfaceNN_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryWin32HandleKHR":
			mNativeLib.LoadFunction("vkGetMemoryWin32HandleKHR", out vkGetMemoryWin32HandleKHR_ptr, invokeErrorCallback);
			if(vkGetMemoryWin32HandleKHR_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryWin32HandlePropertiesKHR":
			mNativeLib.LoadFunction("vkGetMemoryWin32HandlePropertiesKHR", out vkGetMemoryWin32HandlePropertiesKHR_ptr, invokeErrorCallback);
			if(vkGetMemoryWin32HandlePropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryFdKHR":
			mNativeLib.LoadFunction("vkGetMemoryFdKHR", out vkGetMemoryFdKHR_ptr, invokeErrorCallback);
			if(vkGetMemoryFdKHR_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryFdPropertiesKHR":
			mNativeLib.LoadFunction("vkGetMemoryFdPropertiesKHR", out vkGetMemoryFdPropertiesKHR_ptr, invokeErrorCallback);
			if(vkGetMemoryFdPropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkImportSemaphoreWin32HandleKHR":
			mNativeLib.LoadFunction("vkImportSemaphoreWin32HandleKHR", out vkImportSemaphoreWin32HandleKHR_ptr, invokeErrorCallback);
			if(vkImportSemaphoreWin32HandleKHR_ptr == null)
				return .Err;
			break;

		case "vkGetSemaphoreWin32HandleKHR":
			mNativeLib.LoadFunction("vkGetSemaphoreWin32HandleKHR", out vkGetSemaphoreWin32HandleKHR_ptr, invokeErrorCallback);
			if(vkGetSemaphoreWin32HandleKHR_ptr == null)
				return .Err;
			break;

		case "vkImportSemaphoreFdKHR":
			mNativeLib.LoadFunction("vkImportSemaphoreFdKHR", out vkImportSemaphoreFdKHR_ptr, invokeErrorCallback);
			if(vkImportSemaphoreFdKHR_ptr == null)
				return .Err;
			break;

		case "vkGetSemaphoreFdKHR":
			mNativeLib.LoadFunction("vkGetSemaphoreFdKHR", out vkGetSemaphoreFdKHR_ptr, invokeErrorCallback);
			if(vkGetSemaphoreFdKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdPushDescriptorSetKHR":
			mNativeLib.LoadFunction("vkCmdPushDescriptorSetKHR", out vkCmdPushDescriptorSetKHR_ptr, invokeErrorCallback);
			if(vkCmdPushDescriptorSetKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginConditionalRenderingEXT":
			mNativeLib.LoadFunction("vkCmdBeginConditionalRenderingEXT", out vkCmdBeginConditionalRenderingEXT_ptr, invokeErrorCallback);
			if(vkCmdBeginConditionalRenderingEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdEndConditionalRenderingEXT":
			mNativeLib.LoadFunction("vkCmdEndConditionalRenderingEXT", out vkCmdEndConditionalRenderingEXT_ptr, invokeErrorCallback);
			if(vkCmdEndConditionalRenderingEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetViewportWScalingNV":
			mNativeLib.LoadFunction("vkCmdSetViewportWScalingNV", out vkCmdSetViewportWScalingNV_ptr, invokeErrorCallback);
			if(vkCmdSetViewportWScalingNV_ptr == null)
				return .Err;
			break;

		case "vkReleaseDisplayEXT":
			mNativeLib.LoadFunction("vkReleaseDisplayEXT", out vkReleaseDisplayEXT_ptr, invokeErrorCallback);
			if(vkReleaseDisplayEXT_ptr == null)
				return .Err;
			break;

		case "vkAcquireXlibDisplayEXT":
			mNativeLib.LoadFunction("vkAcquireXlibDisplayEXT", out vkAcquireXlibDisplayEXT_ptr, invokeErrorCallback);
			if(vkAcquireXlibDisplayEXT_ptr == null)
				return .Err;
			break;

		case "vkGetRandROutputDisplayEXT":
			mNativeLib.LoadFunction("vkGetRandROutputDisplayEXT", out vkGetRandROutputDisplayEXT_ptr, invokeErrorCallback);
			if(vkGetRandROutputDisplayEXT_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSurfaceCapabilities2EXT":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSurfaceCapabilities2EXT", out vkGetPhysicalDeviceSurfaceCapabilities2EXT_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSurfaceCapabilities2EXT_ptr == null)
				return .Err;
			break;

		case "vkDisplayPowerControlEXT":
			mNativeLib.LoadFunction("vkDisplayPowerControlEXT", out vkDisplayPowerControlEXT_ptr, invokeErrorCallback);
			if(vkDisplayPowerControlEXT_ptr == null)
				return .Err;
			break;

		case "vkRegisterDeviceEventEXT":
			mNativeLib.LoadFunction("vkRegisterDeviceEventEXT", out vkRegisterDeviceEventEXT_ptr, invokeErrorCallback);
			if(vkRegisterDeviceEventEXT_ptr == null)
				return .Err;
			break;

		case "vkRegisterDisplayEventEXT":
			mNativeLib.LoadFunction("vkRegisterDisplayEventEXT", out vkRegisterDisplayEventEXT_ptr, invokeErrorCallback);
			if(vkRegisterDisplayEventEXT_ptr == null)
				return .Err;
			break;

		case "vkGetSwapchainCounterEXT":
			mNativeLib.LoadFunction("vkGetSwapchainCounterEXT", out vkGetSwapchainCounterEXT_ptr, invokeErrorCallback);
			if(vkGetSwapchainCounterEXT_ptr == null)
				return .Err;
			break;

		case "vkGetRefreshCycleDurationGOOGLE":
			mNativeLib.LoadFunction("vkGetRefreshCycleDurationGOOGLE", out vkGetRefreshCycleDurationGOOGLE_ptr, invokeErrorCallback);
			if(vkGetRefreshCycleDurationGOOGLE_ptr == null)
				return .Err;
			break;

		case "vkGetPastPresentationTimingGOOGLE":
			mNativeLib.LoadFunction("vkGetPastPresentationTimingGOOGLE", out vkGetPastPresentationTimingGOOGLE_ptr, invokeErrorCallback);
			if(vkGetPastPresentationTimingGOOGLE_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDiscardRectangleEXT":
			mNativeLib.LoadFunction("vkCmdSetDiscardRectangleEXT", out vkCmdSetDiscardRectangleEXT_ptr, invokeErrorCallback);
			if(vkCmdSetDiscardRectangleEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDiscardRectangleEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetDiscardRectangleEnableEXT", out vkCmdSetDiscardRectangleEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetDiscardRectangleEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDiscardRectangleModeEXT":
			mNativeLib.LoadFunction("vkCmdSetDiscardRectangleModeEXT", out vkCmdSetDiscardRectangleModeEXT_ptr, invokeErrorCallback);
			if(vkCmdSetDiscardRectangleModeEXT_ptr == null)
				return .Err;
			break;

		case "vkSetHdrMetadataEXT":
			mNativeLib.LoadFunction("vkSetHdrMetadataEXT", out vkSetHdrMetadataEXT_ptr, invokeErrorCallback);
			if(vkSetHdrMetadataEXT_ptr == null)
				return .Err;
			break;

		case "vkGetSwapchainStatusKHR":
			mNativeLib.LoadFunction("vkGetSwapchainStatusKHR", out vkGetSwapchainStatusKHR_ptr, invokeErrorCallback);
			if(vkGetSwapchainStatusKHR_ptr == null)
				return .Err;
			break;

		case "vkImportFenceWin32HandleKHR":
			mNativeLib.LoadFunction("vkImportFenceWin32HandleKHR", out vkImportFenceWin32HandleKHR_ptr, invokeErrorCallback);
			if(vkImportFenceWin32HandleKHR_ptr == null)
				return .Err;
			break;

		case "vkGetFenceWin32HandleKHR":
			mNativeLib.LoadFunction("vkGetFenceWin32HandleKHR", out vkGetFenceWin32HandleKHR_ptr, invokeErrorCallback);
			if(vkGetFenceWin32HandleKHR_ptr == null)
				return .Err;
			break;

		case "vkImportFenceFdKHR":
			mNativeLib.LoadFunction("vkImportFenceFdKHR", out vkImportFenceFdKHR_ptr, invokeErrorCallback);
			if(vkImportFenceFdKHR_ptr == null)
				return .Err;
			break;

		case "vkGetFenceFdKHR":
			mNativeLib.LoadFunction("vkGetFenceFdKHR", out vkGetFenceFdKHR_ptr, invokeErrorCallback);
			if(vkGetFenceFdKHR_ptr == null)
				return .Err;
			break;

		case "vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR":
			mNativeLib.LoadFunction("vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR", out vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR_ptr, invokeErrorCallback);
			if(vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR", out vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR_ptr == null)
				return .Err;
			break;

		case "vkAcquireProfilingLockKHR":
			mNativeLib.LoadFunction("vkAcquireProfilingLockKHR", out vkAcquireProfilingLockKHR_ptr, invokeErrorCallback);
			if(vkAcquireProfilingLockKHR_ptr == null)
				return .Err;
			break;

		case "vkReleaseProfilingLockKHR":
			mNativeLib.LoadFunction("vkReleaseProfilingLockKHR", out vkReleaseProfilingLockKHR_ptr, invokeErrorCallback);
			if(vkReleaseProfilingLockKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSurfaceCapabilities2KHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSurfaceCapabilities2KHR", out vkGetPhysicalDeviceSurfaceCapabilities2KHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSurfaceCapabilities2KHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSurfaceFormats2KHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSurfaceFormats2KHR", out vkGetPhysicalDeviceSurfaceFormats2KHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSurfaceFormats2KHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceDisplayProperties2KHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceDisplayProperties2KHR", out vkGetPhysicalDeviceDisplayProperties2KHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceDisplayProperties2KHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceDisplayPlaneProperties2KHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceDisplayPlaneProperties2KHR", out vkGetPhysicalDeviceDisplayPlaneProperties2KHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceDisplayPlaneProperties2KHR_ptr == null)
				return .Err;
			break;

		case "vkGetDisplayModeProperties2KHR":
			mNativeLib.LoadFunction("vkGetDisplayModeProperties2KHR", out vkGetDisplayModeProperties2KHR_ptr, invokeErrorCallback);
			if(vkGetDisplayModeProperties2KHR_ptr == null)
				return .Err;
			break;

		case "vkGetDisplayPlaneCapabilities2KHR":
			mNativeLib.LoadFunction("vkGetDisplayPlaneCapabilities2KHR", out vkGetDisplayPlaneCapabilities2KHR_ptr, invokeErrorCallback);
			if(vkGetDisplayPlaneCapabilities2KHR_ptr == null)
				return .Err;
			break;

		case "vkCreateIOSSurfaceMVK":
			mNativeLib.LoadFunction("vkCreateIOSSurfaceMVK", out vkCreateIOSSurfaceMVK_ptr, invokeErrorCallback);
			if(vkCreateIOSSurfaceMVK_ptr == null)
				return .Err;
			break;

		case "vkCreateMacOSSurfaceMVK":
			mNativeLib.LoadFunction("vkCreateMacOSSurfaceMVK", out vkCreateMacOSSurfaceMVK_ptr, invokeErrorCallback);
			if(vkCreateMacOSSurfaceMVK_ptr == null)
				return .Err;
			break;

		case "vkSetDebugUtilsObjectNameEXT":
			mNativeLib.LoadFunction("vkSetDebugUtilsObjectNameEXT", out vkSetDebugUtilsObjectNameEXT_ptr, invokeErrorCallback);
			if(vkSetDebugUtilsObjectNameEXT_ptr == null)
				return .Err;
			break;

		case "vkSetDebugUtilsObjectTagEXT":
			mNativeLib.LoadFunction("vkSetDebugUtilsObjectTagEXT", out vkSetDebugUtilsObjectTagEXT_ptr, invokeErrorCallback);
			if(vkSetDebugUtilsObjectTagEXT_ptr == null)
				return .Err;
			break;

		case "vkQueueBeginDebugUtilsLabelEXT":
			mNativeLib.LoadFunction("vkQueueBeginDebugUtilsLabelEXT", out vkQueueBeginDebugUtilsLabelEXT_ptr, invokeErrorCallback);
			if(vkQueueBeginDebugUtilsLabelEXT_ptr == null)
				return .Err;
			break;

		case "vkQueueEndDebugUtilsLabelEXT":
			mNativeLib.LoadFunction("vkQueueEndDebugUtilsLabelEXT", out vkQueueEndDebugUtilsLabelEXT_ptr, invokeErrorCallback);
			if(vkQueueEndDebugUtilsLabelEXT_ptr == null)
				return .Err;
			break;

		case "vkQueueInsertDebugUtilsLabelEXT":
			mNativeLib.LoadFunction("vkQueueInsertDebugUtilsLabelEXT", out vkQueueInsertDebugUtilsLabelEXT_ptr, invokeErrorCallback);
			if(vkQueueInsertDebugUtilsLabelEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdBeginDebugUtilsLabelEXT":
			mNativeLib.LoadFunction("vkCmdBeginDebugUtilsLabelEXT", out vkCmdBeginDebugUtilsLabelEXT_ptr, invokeErrorCallback);
			if(vkCmdBeginDebugUtilsLabelEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdEndDebugUtilsLabelEXT":
			mNativeLib.LoadFunction("vkCmdEndDebugUtilsLabelEXT", out vkCmdEndDebugUtilsLabelEXT_ptr, invokeErrorCallback);
			if(vkCmdEndDebugUtilsLabelEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdInsertDebugUtilsLabelEXT":
			mNativeLib.LoadFunction("vkCmdInsertDebugUtilsLabelEXT", out vkCmdInsertDebugUtilsLabelEXT_ptr, invokeErrorCallback);
			if(vkCmdInsertDebugUtilsLabelEXT_ptr == null)
				return .Err;
			break;

		case "vkCreateDebugUtilsMessengerEXT":
			mNativeLib.LoadFunction("vkCreateDebugUtilsMessengerEXT", out vkCreateDebugUtilsMessengerEXT_ptr, invokeErrorCallback);
			if(vkCreateDebugUtilsMessengerEXT_ptr == null)
				return .Err;
			break;

		case "vkDestroyDebugUtilsMessengerEXT":
			mNativeLib.LoadFunction("vkDestroyDebugUtilsMessengerEXT", out vkDestroyDebugUtilsMessengerEXT_ptr, invokeErrorCallback);
			if(vkDestroyDebugUtilsMessengerEXT_ptr == null)
				return .Err;
			break;

		case "vkSubmitDebugUtilsMessageEXT":
			mNativeLib.LoadFunction("vkSubmitDebugUtilsMessageEXT", out vkSubmitDebugUtilsMessageEXT_ptr, invokeErrorCallback);
			if(vkSubmitDebugUtilsMessageEXT_ptr == null)
				return .Err;
			break;

		case "vkGetAndroidHardwareBufferPropertiesANDROID":
			mNativeLib.LoadFunction("vkGetAndroidHardwareBufferPropertiesANDROID", out vkGetAndroidHardwareBufferPropertiesANDROID_ptr, invokeErrorCallback);
			if(vkGetAndroidHardwareBufferPropertiesANDROID_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryAndroidHardwareBufferANDROID":
			mNativeLib.LoadFunction("vkGetMemoryAndroidHardwareBufferANDROID", out vkGetMemoryAndroidHardwareBufferANDROID_ptr, invokeErrorCallback);
			if(vkGetMemoryAndroidHardwareBufferANDROID_ptr == null)
				return .Err;
			break;

		case "vkCmdSetSampleLocationsEXT":
			mNativeLib.LoadFunction("vkCmdSetSampleLocationsEXT", out vkCmdSetSampleLocationsEXT_ptr, invokeErrorCallback);
			if(vkCmdSetSampleLocationsEXT_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceMultisamplePropertiesEXT":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceMultisamplePropertiesEXT", out vkGetPhysicalDeviceMultisamplePropertiesEXT_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceMultisamplePropertiesEXT_ptr == null)
				return .Err;
			break;

		case "vkCreateAccelerationStructureKHR":
			mNativeLib.LoadFunction("vkCreateAccelerationStructureKHR", out vkCreateAccelerationStructureKHR_ptr, invokeErrorCallback);
			if(vkCreateAccelerationStructureKHR_ptr == null)
				return .Err;
			break;

		case "vkDestroyAccelerationStructureKHR":
			mNativeLib.LoadFunction("vkDestroyAccelerationStructureKHR", out vkDestroyAccelerationStructureKHR_ptr, invokeErrorCallback);
			if(vkDestroyAccelerationStructureKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdBuildAccelerationStructuresKHR":
			mNativeLib.LoadFunction("vkCmdBuildAccelerationStructuresKHR", out vkCmdBuildAccelerationStructuresKHR_ptr, invokeErrorCallback);
			if(vkCmdBuildAccelerationStructuresKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdBuildAccelerationStructuresIndirectKHR":
			mNativeLib.LoadFunction("vkCmdBuildAccelerationStructuresIndirectKHR", out vkCmdBuildAccelerationStructuresIndirectKHR_ptr, invokeErrorCallback);
			if(vkCmdBuildAccelerationStructuresIndirectKHR_ptr == null)
				return .Err;
			break;

		case "vkBuildAccelerationStructuresKHR":
			mNativeLib.LoadFunction("vkBuildAccelerationStructuresKHR", out vkBuildAccelerationStructuresKHR_ptr, invokeErrorCallback);
			if(vkBuildAccelerationStructuresKHR_ptr == null)
				return .Err;
			break;

		case "vkCopyAccelerationStructureKHR":
			mNativeLib.LoadFunction("vkCopyAccelerationStructureKHR", out vkCopyAccelerationStructureKHR_ptr, invokeErrorCallback);
			if(vkCopyAccelerationStructureKHR_ptr == null)
				return .Err;
			break;

		case "vkCopyAccelerationStructureToMemoryKHR":
			mNativeLib.LoadFunction("vkCopyAccelerationStructureToMemoryKHR", out vkCopyAccelerationStructureToMemoryKHR_ptr, invokeErrorCallback);
			if(vkCopyAccelerationStructureToMemoryKHR_ptr == null)
				return .Err;
			break;

		case "vkCopyMemoryToAccelerationStructureKHR":
			mNativeLib.LoadFunction("vkCopyMemoryToAccelerationStructureKHR", out vkCopyMemoryToAccelerationStructureKHR_ptr, invokeErrorCallback);
			if(vkCopyMemoryToAccelerationStructureKHR_ptr == null)
				return .Err;
			break;

		case "vkWriteAccelerationStructuresPropertiesKHR":
			mNativeLib.LoadFunction("vkWriteAccelerationStructuresPropertiesKHR", out vkWriteAccelerationStructuresPropertiesKHR_ptr, invokeErrorCallback);
			if(vkWriteAccelerationStructuresPropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyAccelerationStructureKHR":
			mNativeLib.LoadFunction("vkCmdCopyAccelerationStructureKHR", out vkCmdCopyAccelerationStructureKHR_ptr, invokeErrorCallback);
			if(vkCmdCopyAccelerationStructureKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyAccelerationStructureToMemoryKHR":
			mNativeLib.LoadFunction("vkCmdCopyAccelerationStructureToMemoryKHR", out vkCmdCopyAccelerationStructureToMemoryKHR_ptr, invokeErrorCallback);
			if(vkCmdCopyAccelerationStructureToMemoryKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyMemoryToAccelerationStructureKHR":
			mNativeLib.LoadFunction("vkCmdCopyMemoryToAccelerationStructureKHR", out vkCmdCopyMemoryToAccelerationStructureKHR_ptr, invokeErrorCallback);
			if(vkCmdCopyMemoryToAccelerationStructureKHR_ptr == null)
				return .Err;
			break;

		case "vkGetAccelerationStructureDeviceAddressKHR":
			mNativeLib.LoadFunction("vkGetAccelerationStructureDeviceAddressKHR", out vkGetAccelerationStructureDeviceAddressKHR_ptr, invokeErrorCallback);
			if(vkGetAccelerationStructureDeviceAddressKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdWriteAccelerationStructuresPropertiesKHR":
			mNativeLib.LoadFunction("vkCmdWriteAccelerationStructuresPropertiesKHR", out vkCmdWriteAccelerationStructuresPropertiesKHR_ptr, invokeErrorCallback);
			if(vkCmdWriteAccelerationStructuresPropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceAccelerationStructureCompatibilityKHR":
			mNativeLib.LoadFunction("vkGetDeviceAccelerationStructureCompatibilityKHR", out vkGetDeviceAccelerationStructureCompatibilityKHR_ptr, invokeErrorCallback);
			if(vkGetDeviceAccelerationStructureCompatibilityKHR_ptr == null)
				return .Err;
			break;

		case "vkGetAccelerationStructureBuildSizesKHR":
			mNativeLib.LoadFunction("vkGetAccelerationStructureBuildSizesKHR", out vkGetAccelerationStructureBuildSizesKHR_ptr, invokeErrorCallback);
			if(vkGetAccelerationStructureBuildSizesKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdTraceRaysKHR":
			mNativeLib.LoadFunction("vkCmdTraceRaysKHR", out vkCmdTraceRaysKHR_ptr, invokeErrorCallback);
			if(vkCmdTraceRaysKHR_ptr == null)
				return .Err;
			break;

		case "vkCreateRayTracingPipelinesKHR":
			mNativeLib.LoadFunction("vkCreateRayTracingPipelinesKHR", out vkCreateRayTracingPipelinesKHR_ptr, invokeErrorCallback);
			if(vkCreateRayTracingPipelinesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetRayTracingShaderGroupHandlesKHR":
			mNativeLib.LoadFunction("vkGetRayTracingShaderGroupHandlesKHR", out vkGetRayTracingShaderGroupHandlesKHR_ptr, invokeErrorCallback);
			if(vkGetRayTracingShaderGroupHandlesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetRayTracingCaptureReplayShaderGroupHandlesKHR":
			mNativeLib.LoadFunction("vkGetRayTracingCaptureReplayShaderGroupHandlesKHR", out vkGetRayTracingCaptureReplayShaderGroupHandlesKHR_ptr, invokeErrorCallback);
			if(vkGetRayTracingCaptureReplayShaderGroupHandlesKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdTraceRaysIndirectKHR":
			mNativeLib.LoadFunction("vkCmdTraceRaysIndirectKHR", out vkCmdTraceRaysIndirectKHR_ptr, invokeErrorCallback);
			if(vkCmdTraceRaysIndirectKHR_ptr == null)
				return .Err;
			break;

		case "vkGetRayTracingShaderGroupStackSizeKHR":
			mNativeLib.LoadFunction("vkGetRayTracingShaderGroupStackSizeKHR", out vkGetRayTracingShaderGroupStackSizeKHR_ptr, invokeErrorCallback);
			if(vkGetRayTracingShaderGroupStackSizeKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdSetRayTracingPipelineStackSizeKHR":
			mNativeLib.LoadFunction("vkCmdSetRayTracingPipelineStackSizeKHR", out vkCmdSetRayTracingPipelineStackSizeKHR_ptr, invokeErrorCallback);
			if(vkCmdSetRayTracingPipelineStackSizeKHR_ptr == null)
				return .Err;
			break;

		case "vkGetImageDrmFormatModifierPropertiesEXT":
			mNativeLib.LoadFunction("vkGetImageDrmFormatModifierPropertiesEXT", out vkGetImageDrmFormatModifierPropertiesEXT_ptr, invokeErrorCallback);
			if(vkGetImageDrmFormatModifierPropertiesEXT_ptr == null)
				return .Err;
			break;

		case "vkCreateValidationCacheEXT":
			mNativeLib.LoadFunction("vkCreateValidationCacheEXT", out vkCreateValidationCacheEXT_ptr, invokeErrorCallback);
			if(vkCreateValidationCacheEXT_ptr == null)
				return .Err;
			break;

		case "vkDestroyValidationCacheEXT":
			mNativeLib.LoadFunction("vkDestroyValidationCacheEXT", out vkDestroyValidationCacheEXT_ptr, invokeErrorCallback);
			if(vkDestroyValidationCacheEXT_ptr == null)
				return .Err;
			break;

		case "vkMergeValidationCachesEXT":
			mNativeLib.LoadFunction("vkMergeValidationCachesEXT", out vkMergeValidationCachesEXT_ptr, invokeErrorCallback);
			if(vkMergeValidationCachesEXT_ptr == null)
				return .Err;
			break;

		case "vkGetValidationCacheDataEXT":
			mNativeLib.LoadFunction("vkGetValidationCacheDataEXT", out vkGetValidationCacheDataEXT_ptr, invokeErrorCallback);
			if(vkGetValidationCacheDataEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdBindShadingRateImageNV":
			mNativeLib.LoadFunction("vkCmdBindShadingRateImageNV", out vkCmdBindShadingRateImageNV_ptr, invokeErrorCallback);
			if(vkCmdBindShadingRateImageNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetViewportShadingRatePaletteNV":
			mNativeLib.LoadFunction("vkCmdSetViewportShadingRatePaletteNV", out vkCmdSetViewportShadingRatePaletteNV_ptr, invokeErrorCallback);
			if(vkCmdSetViewportShadingRatePaletteNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCoarseSampleOrderNV":
			mNativeLib.LoadFunction("vkCmdSetCoarseSampleOrderNV", out vkCmdSetCoarseSampleOrderNV_ptr, invokeErrorCallback);
			if(vkCmdSetCoarseSampleOrderNV_ptr == null)
				return .Err;
			break;

		case "vkCreateAccelerationStructureNV":
			mNativeLib.LoadFunction("vkCreateAccelerationStructureNV", out vkCreateAccelerationStructureNV_ptr, invokeErrorCallback);
			if(vkCreateAccelerationStructureNV_ptr == null)
				return .Err;
			break;

		case "vkDestroyAccelerationStructureNV":
			mNativeLib.LoadFunction("vkDestroyAccelerationStructureNV", out vkDestroyAccelerationStructureNV_ptr, invokeErrorCallback);
			if(vkDestroyAccelerationStructureNV_ptr == null)
				return .Err;
			break;

		case "vkGetAccelerationStructureMemoryRequirementsNV":
			mNativeLib.LoadFunction("vkGetAccelerationStructureMemoryRequirementsNV", out vkGetAccelerationStructureMemoryRequirementsNV_ptr, invokeErrorCallback);
			if(vkGetAccelerationStructureMemoryRequirementsNV_ptr == null)
				return .Err;
			break;

		case "vkBindAccelerationStructureMemoryNV":
			mNativeLib.LoadFunction("vkBindAccelerationStructureMemoryNV", out vkBindAccelerationStructureMemoryNV_ptr, invokeErrorCallback);
			if(vkBindAccelerationStructureMemoryNV_ptr == null)
				return .Err;
			break;

		case "vkCmdBuildAccelerationStructureNV":
			mNativeLib.LoadFunction("vkCmdBuildAccelerationStructureNV", out vkCmdBuildAccelerationStructureNV_ptr, invokeErrorCallback);
			if(vkCmdBuildAccelerationStructureNV_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyAccelerationStructureNV":
			mNativeLib.LoadFunction("vkCmdCopyAccelerationStructureNV", out vkCmdCopyAccelerationStructureNV_ptr, invokeErrorCallback);
			if(vkCmdCopyAccelerationStructureNV_ptr == null)
				return .Err;
			break;

		case "vkCmdTraceRaysNV":
			mNativeLib.LoadFunction("vkCmdTraceRaysNV", out vkCmdTraceRaysNV_ptr, invokeErrorCallback);
			if(vkCmdTraceRaysNV_ptr == null)
				return .Err;
			break;

		case "vkCreateRayTracingPipelinesNV":
			mNativeLib.LoadFunction("vkCreateRayTracingPipelinesNV", out vkCreateRayTracingPipelinesNV_ptr, invokeErrorCallback);
			if(vkCreateRayTracingPipelinesNV_ptr == null)
				return .Err;
			break;

		case "vkGetAccelerationStructureHandleNV":
			mNativeLib.LoadFunction("vkGetAccelerationStructureHandleNV", out vkGetAccelerationStructureHandleNV_ptr, invokeErrorCallback);
			if(vkGetAccelerationStructureHandleNV_ptr == null)
				return .Err;
			break;

		case "vkCmdWriteAccelerationStructuresPropertiesNV":
			mNativeLib.LoadFunction("vkCmdWriteAccelerationStructuresPropertiesNV", out vkCmdWriteAccelerationStructuresPropertiesNV_ptr, invokeErrorCallback);
			if(vkCmdWriteAccelerationStructuresPropertiesNV_ptr == null)
				return .Err;
			break;

		case "vkCompileDeferredNV":
			mNativeLib.LoadFunction("vkCompileDeferredNV", out vkCompileDeferredNV_ptr, invokeErrorCallback);
			if(vkCompileDeferredNV_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryHostPointerPropertiesEXT":
			mNativeLib.LoadFunction("vkGetMemoryHostPointerPropertiesEXT", out vkGetMemoryHostPointerPropertiesEXT_ptr, invokeErrorCallback);
			if(vkGetMemoryHostPointerPropertiesEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdWriteBufferMarkerAMD":
			mNativeLib.LoadFunction("vkCmdWriteBufferMarkerAMD", out vkCmdWriteBufferMarkerAMD_ptr, invokeErrorCallback);
			if(vkCmdWriteBufferMarkerAMD_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceCalibrateableTimeDomainsEXT":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceCalibrateableTimeDomainsEXT", out vkGetPhysicalDeviceCalibrateableTimeDomainsEXT_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceCalibrateableTimeDomainsEXT_ptr == null)
				return .Err;
			break;

		case "vkGetCalibratedTimestampsEXT":
			mNativeLib.LoadFunction("vkGetCalibratedTimestampsEXT", out vkGetCalibratedTimestampsEXT_ptr, invokeErrorCallback);
			if(vkGetCalibratedTimestampsEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawMeshTasksNV":
			mNativeLib.LoadFunction("vkCmdDrawMeshTasksNV", out vkCmdDrawMeshTasksNV_ptr, invokeErrorCallback);
			if(vkCmdDrawMeshTasksNV_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawMeshTasksIndirectNV":
			mNativeLib.LoadFunction("vkCmdDrawMeshTasksIndirectNV", out vkCmdDrawMeshTasksIndirectNV_ptr, invokeErrorCallback);
			if(vkCmdDrawMeshTasksIndirectNV_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawMeshTasksIndirectCountNV":
			mNativeLib.LoadFunction("vkCmdDrawMeshTasksIndirectCountNV", out vkCmdDrawMeshTasksIndirectCountNV_ptr, invokeErrorCallback);
			if(vkCmdDrawMeshTasksIndirectCountNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetExclusiveScissorEnableNV":
			mNativeLib.LoadFunction("vkCmdSetExclusiveScissorEnableNV", out vkCmdSetExclusiveScissorEnableNV_ptr, invokeErrorCallback);
			if(vkCmdSetExclusiveScissorEnableNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetExclusiveScissorNV":
			mNativeLib.LoadFunction("vkCmdSetExclusiveScissorNV", out vkCmdSetExclusiveScissorNV_ptr, invokeErrorCallback);
			if(vkCmdSetExclusiveScissorNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCheckpointNV":
			mNativeLib.LoadFunction("vkCmdSetCheckpointNV", out vkCmdSetCheckpointNV_ptr, invokeErrorCallback);
			if(vkCmdSetCheckpointNV_ptr == null)
				return .Err;
			break;

		case "vkGetQueueCheckpointDataNV":
			mNativeLib.LoadFunction("vkGetQueueCheckpointDataNV", out vkGetQueueCheckpointDataNV_ptr, invokeErrorCallback);
			if(vkGetQueueCheckpointDataNV_ptr == null)
				return .Err;
			break;

		case "vkInitializePerformanceApiINTEL":
			mNativeLib.LoadFunction("vkInitializePerformanceApiINTEL", out vkInitializePerformanceApiINTEL_ptr, invokeErrorCallback);
			if(vkInitializePerformanceApiINTEL_ptr == null)
				return .Err;
			break;

		case "vkUninitializePerformanceApiINTEL":
			mNativeLib.LoadFunction("vkUninitializePerformanceApiINTEL", out vkUninitializePerformanceApiINTEL_ptr, invokeErrorCallback);
			if(vkUninitializePerformanceApiINTEL_ptr == null)
				return .Err;
			break;

		case "vkCmdSetPerformanceMarkerINTEL":
			mNativeLib.LoadFunction("vkCmdSetPerformanceMarkerINTEL", out vkCmdSetPerformanceMarkerINTEL_ptr, invokeErrorCallback);
			if(vkCmdSetPerformanceMarkerINTEL_ptr == null)
				return .Err;
			break;

		case "vkCmdSetPerformanceStreamMarkerINTEL":
			mNativeLib.LoadFunction("vkCmdSetPerformanceStreamMarkerINTEL", out vkCmdSetPerformanceStreamMarkerINTEL_ptr, invokeErrorCallback);
			if(vkCmdSetPerformanceStreamMarkerINTEL_ptr == null)
				return .Err;
			break;

		case "vkCmdSetPerformanceOverrideINTEL":
			mNativeLib.LoadFunction("vkCmdSetPerformanceOverrideINTEL", out vkCmdSetPerformanceOverrideINTEL_ptr, invokeErrorCallback);
			if(vkCmdSetPerformanceOverrideINTEL_ptr == null)
				return .Err;
			break;

		case "vkAcquirePerformanceConfigurationINTEL":
			mNativeLib.LoadFunction("vkAcquirePerformanceConfigurationINTEL", out vkAcquirePerformanceConfigurationINTEL_ptr, invokeErrorCallback);
			if(vkAcquirePerformanceConfigurationINTEL_ptr == null)
				return .Err;
			break;

		case "vkReleasePerformanceConfigurationINTEL":
			mNativeLib.LoadFunction("vkReleasePerformanceConfigurationINTEL", out vkReleasePerformanceConfigurationINTEL_ptr, invokeErrorCallback);
			if(vkReleasePerformanceConfigurationINTEL_ptr == null)
				return .Err;
			break;

		case "vkQueueSetPerformanceConfigurationINTEL":
			mNativeLib.LoadFunction("vkQueueSetPerformanceConfigurationINTEL", out vkQueueSetPerformanceConfigurationINTEL_ptr, invokeErrorCallback);
			if(vkQueueSetPerformanceConfigurationINTEL_ptr == null)
				return .Err;
			break;

		case "vkGetPerformanceParameterINTEL":
			mNativeLib.LoadFunction("vkGetPerformanceParameterINTEL", out vkGetPerformanceParameterINTEL_ptr, invokeErrorCallback);
			if(vkGetPerformanceParameterINTEL_ptr == null)
				return .Err;
			break;

		case "vkSetLocalDimmingAMD":
			mNativeLib.LoadFunction("vkSetLocalDimmingAMD", out vkSetLocalDimmingAMD_ptr, invokeErrorCallback);
			if(vkSetLocalDimmingAMD_ptr == null)
				return .Err;
			break;

		case "vkCreateImagePipeSurfaceFUCHSIA":
			mNativeLib.LoadFunction("vkCreateImagePipeSurfaceFUCHSIA", out vkCreateImagePipeSurfaceFUCHSIA_ptr, invokeErrorCallback);
			if(vkCreateImagePipeSurfaceFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkCreateMetalSurfaceEXT":
			mNativeLib.LoadFunction("vkCreateMetalSurfaceEXT", out vkCreateMetalSurfaceEXT_ptr, invokeErrorCallback);
			if(vkCreateMetalSurfaceEXT_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceFragmentShadingRatesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceFragmentShadingRatesKHR", out vkGetPhysicalDeviceFragmentShadingRatesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceFragmentShadingRatesKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdSetFragmentShadingRateKHR":
			mNativeLib.LoadFunction("vkCmdSetFragmentShadingRateKHR", out vkCmdSetFragmentShadingRateKHR_ptr, invokeErrorCallback);
			if(vkCmdSetFragmentShadingRateKHR_ptr == null)
				return .Err;
			break;

		case "vkWaitForPresentKHR":
			mNativeLib.LoadFunction("vkWaitForPresentKHR", out vkWaitForPresentKHR_ptr, invokeErrorCallback);
			if(vkWaitForPresentKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceCooperativeMatrixPropertiesNV":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceCooperativeMatrixPropertiesNV", out vkGetPhysicalDeviceCooperativeMatrixPropertiesNV_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceCooperativeMatrixPropertiesNV_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV", out vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSurfacePresentModes2EXT":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSurfacePresentModes2EXT", out vkGetPhysicalDeviceSurfacePresentModes2EXT_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSurfacePresentModes2EXT_ptr == null)
				return .Err;
			break;

		case "vkAcquireFullScreenExclusiveModeEXT":
			mNativeLib.LoadFunction("vkAcquireFullScreenExclusiveModeEXT", out vkAcquireFullScreenExclusiveModeEXT_ptr, invokeErrorCallback);
			if(vkAcquireFullScreenExclusiveModeEXT_ptr == null)
				return .Err;
			break;

		case "vkReleaseFullScreenExclusiveModeEXT":
			mNativeLib.LoadFunction("vkReleaseFullScreenExclusiveModeEXT", out vkReleaseFullScreenExclusiveModeEXT_ptr, invokeErrorCallback);
			if(vkReleaseFullScreenExclusiveModeEXT_ptr == null)
				return .Err;
			break;

		case "vkCreateHeadlessSurfaceEXT":
			mNativeLib.LoadFunction("vkCreateHeadlessSurfaceEXT", out vkCreateHeadlessSurfaceEXT_ptr, invokeErrorCallback);
			if(vkCreateHeadlessSurfaceEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetLineStippleEXT":
			mNativeLib.LoadFunction("vkCmdSetLineStippleEXT", out vkCmdSetLineStippleEXT_ptr, invokeErrorCallback);
			if(vkCmdSetLineStippleEXT_ptr == null)
				return .Err;
			break;

		case "vkCreateDeferredOperationKHR":
			mNativeLib.LoadFunction("vkCreateDeferredOperationKHR", out vkCreateDeferredOperationKHR_ptr, invokeErrorCallback);
			if(vkCreateDeferredOperationKHR_ptr == null)
				return .Err;
			break;

		case "vkDestroyDeferredOperationKHR":
			mNativeLib.LoadFunction("vkDestroyDeferredOperationKHR", out vkDestroyDeferredOperationKHR_ptr, invokeErrorCallback);
			if(vkDestroyDeferredOperationKHR_ptr == null)
				return .Err;
			break;

		case "vkGetDeferredOperationMaxConcurrencyKHR":
			mNativeLib.LoadFunction("vkGetDeferredOperationMaxConcurrencyKHR", out vkGetDeferredOperationMaxConcurrencyKHR_ptr, invokeErrorCallback);
			if(vkGetDeferredOperationMaxConcurrencyKHR_ptr == null)
				return .Err;
			break;

		case "vkGetDeferredOperationResultKHR":
			mNativeLib.LoadFunction("vkGetDeferredOperationResultKHR", out vkGetDeferredOperationResultKHR_ptr, invokeErrorCallback);
			if(vkGetDeferredOperationResultKHR_ptr == null)
				return .Err;
			break;

		case "vkDeferredOperationJoinKHR":
			mNativeLib.LoadFunction("vkDeferredOperationJoinKHR", out vkDeferredOperationJoinKHR_ptr, invokeErrorCallback);
			if(vkDeferredOperationJoinKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPipelineExecutablePropertiesKHR":
			mNativeLib.LoadFunction("vkGetPipelineExecutablePropertiesKHR", out vkGetPipelineExecutablePropertiesKHR_ptr, invokeErrorCallback);
			if(vkGetPipelineExecutablePropertiesKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPipelineExecutableStatisticsKHR":
			mNativeLib.LoadFunction("vkGetPipelineExecutableStatisticsKHR", out vkGetPipelineExecutableStatisticsKHR_ptr, invokeErrorCallback);
			if(vkGetPipelineExecutableStatisticsKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPipelineExecutableInternalRepresentationsKHR":
			mNativeLib.LoadFunction("vkGetPipelineExecutableInternalRepresentationsKHR", out vkGetPipelineExecutableInternalRepresentationsKHR_ptr, invokeErrorCallback);
			if(vkGetPipelineExecutableInternalRepresentationsKHR_ptr == null)
				return .Err;
			break;

		case "vkMapMemory2KHR":
			mNativeLib.LoadFunction("vkMapMemory2KHR", out vkMapMemory2KHR_ptr, invokeErrorCallback);
			if(vkMapMemory2KHR_ptr == null)
				return .Err;
			break;

		case "vkUnmapMemory2KHR":
			mNativeLib.LoadFunction("vkUnmapMemory2KHR", out vkUnmapMemory2KHR_ptr, invokeErrorCallback);
			if(vkUnmapMemory2KHR_ptr == null)
				return .Err;
			break;

		case "vkReleaseSwapchainImagesEXT":
			mNativeLib.LoadFunction("vkReleaseSwapchainImagesEXT", out vkReleaseSwapchainImagesEXT_ptr, invokeErrorCallback);
			if(vkReleaseSwapchainImagesEXT_ptr == null)
				return .Err;
			break;

		case "vkGetGeneratedCommandsMemoryRequirementsNV":
			mNativeLib.LoadFunction("vkGetGeneratedCommandsMemoryRequirementsNV", out vkGetGeneratedCommandsMemoryRequirementsNV_ptr, invokeErrorCallback);
			if(vkGetGeneratedCommandsMemoryRequirementsNV_ptr == null)
				return .Err;
			break;

		case "vkCmdPreprocessGeneratedCommandsNV":
			mNativeLib.LoadFunction("vkCmdPreprocessGeneratedCommandsNV", out vkCmdPreprocessGeneratedCommandsNV_ptr, invokeErrorCallback);
			if(vkCmdPreprocessGeneratedCommandsNV_ptr == null)
				return .Err;
			break;

		case "vkCmdExecuteGeneratedCommandsNV":
			mNativeLib.LoadFunction("vkCmdExecuteGeneratedCommandsNV", out vkCmdExecuteGeneratedCommandsNV_ptr, invokeErrorCallback);
			if(vkCmdExecuteGeneratedCommandsNV_ptr == null)
				return .Err;
			break;

		case "vkCmdBindPipelineShaderGroupNV":
			mNativeLib.LoadFunction("vkCmdBindPipelineShaderGroupNV", out vkCmdBindPipelineShaderGroupNV_ptr, invokeErrorCallback);
			if(vkCmdBindPipelineShaderGroupNV_ptr == null)
				return .Err;
			break;

		case "vkCreateIndirectCommandsLayoutNV":
			mNativeLib.LoadFunction("vkCreateIndirectCommandsLayoutNV", out vkCreateIndirectCommandsLayoutNV_ptr, invokeErrorCallback);
			if(vkCreateIndirectCommandsLayoutNV_ptr == null)
				return .Err;
			break;

		case "vkDestroyIndirectCommandsLayoutNV":
			mNativeLib.LoadFunction("vkDestroyIndirectCommandsLayoutNV", out vkDestroyIndirectCommandsLayoutNV_ptr, invokeErrorCallback);
			if(vkDestroyIndirectCommandsLayoutNV_ptr == null)
				return .Err;
			break;

		case "vkAcquireDrmDisplayEXT":
			mNativeLib.LoadFunction("vkAcquireDrmDisplayEXT", out vkAcquireDrmDisplayEXT_ptr, invokeErrorCallback);
			if(vkAcquireDrmDisplayEXT_ptr == null)
				return .Err;
			break;

		case "vkGetDrmDisplayEXT":
			mNativeLib.LoadFunction("vkGetDrmDisplayEXT", out vkGetDrmDisplayEXT_ptr, invokeErrorCallback);
			if(vkGetDrmDisplayEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdEncodeVideoKHR":
			mNativeLib.LoadFunction("vkCmdEncodeVideoKHR", out vkCmdEncodeVideoKHR_ptr, invokeErrorCallback);
			if(vkCmdEncodeVideoKHR_ptr == null)
				return .Err;
			break;

		case "vkCmdRefreshObjectsKHR":
			mNativeLib.LoadFunction("vkCmdRefreshObjectsKHR", out vkCmdRefreshObjectsKHR_ptr, invokeErrorCallback);
			if(vkCmdRefreshObjectsKHR_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceRefreshableObjectTypesKHR":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceRefreshableObjectTypesKHR", out vkGetPhysicalDeviceRefreshableObjectTypesKHR_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceRefreshableObjectTypesKHR_ptr == null)
				return .Err;
			break;

		case "vkExportMetalObjectsEXT":
			mNativeLib.LoadFunction("vkExportMetalObjectsEXT", out vkExportMetalObjectsEXT_ptr, invokeErrorCallback);
			if(vkExportMetalObjectsEXT_ptr == null)
				return .Err;
			break;

		case "vkGetDescriptorSetLayoutSizeEXT":
			mNativeLib.LoadFunction("vkGetDescriptorSetLayoutSizeEXT", out vkGetDescriptorSetLayoutSizeEXT_ptr, invokeErrorCallback);
			if(vkGetDescriptorSetLayoutSizeEXT_ptr == null)
				return .Err;
			break;

		case "vkGetDescriptorSetLayoutBindingOffsetEXT":
			mNativeLib.LoadFunction("vkGetDescriptorSetLayoutBindingOffsetEXT", out vkGetDescriptorSetLayoutBindingOffsetEXT_ptr, invokeErrorCallback);
			if(vkGetDescriptorSetLayoutBindingOffsetEXT_ptr == null)
				return .Err;
			break;

		case "vkGetDescriptorEXT":
			mNativeLib.LoadFunction("vkGetDescriptorEXT", out vkGetDescriptorEXT_ptr, invokeErrorCallback);
			if(vkGetDescriptorEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdBindDescriptorBuffersEXT":
			mNativeLib.LoadFunction("vkCmdBindDescriptorBuffersEXT", out vkCmdBindDescriptorBuffersEXT_ptr, invokeErrorCallback);
			if(vkCmdBindDescriptorBuffersEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDescriptorBufferOffsetsEXT":
			mNativeLib.LoadFunction("vkCmdSetDescriptorBufferOffsetsEXT", out vkCmdSetDescriptorBufferOffsetsEXT_ptr, invokeErrorCallback);
			if(vkCmdSetDescriptorBufferOffsetsEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdBindDescriptorBufferEmbeddedSamplersEXT":
			mNativeLib.LoadFunction("vkCmdBindDescriptorBufferEmbeddedSamplersEXT", out vkCmdBindDescriptorBufferEmbeddedSamplersEXT_ptr, invokeErrorCallback);
			if(vkCmdBindDescriptorBufferEmbeddedSamplersEXT_ptr == null)
				return .Err;
			break;

		case "vkGetBufferOpaqueCaptureDescriptorDataEXT":
			mNativeLib.LoadFunction("vkGetBufferOpaqueCaptureDescriptorDataEXT", out vkGetBufferOpaqueCaptureDescriptorDataEXT_ptr, invokeErrorCallback);
			if(vkGetBufferOpaqueCaptureDescriptorDataEXT_ptr == null)
				return .Err;
			break;

		case "vkGetImageOpaqueCaptureDescriptorDataEXT":
			mNativeLib.LoadFunction("vkGetImageOpaqueCaptureDescriptorDataEXT", out vkGetImageOpaqueCaptureDescriptorDataEXT_ptr, invokeErrorCallback);
			if(vkGetImageOpaqueCaptureDescriptorDataEXT_ptr == null)
				return .Err;
			break;

		case "vkGetImageViewOpaqueCaptureDescriptorDataEXT":
			mNativeLib.LoadFunction("vkGetImageViewOpaqueCaptureDescriptorDataEXT", out vkGetImageViewOpaqueCaptureDescriptorDataEXT_ptr, invokeErrorCallback);
			if(vkGetImageViewOpaqueCaptureDescriptorDataEXT_ptr == null)
				return .Err;
			break;

		case "vkGetSamplerOpaqueCaptureDescriptorDataEXT":
			mNativeLib.LoadFunction("vkGetSamplerOpaqueCaptureDescriptorDataEXT", out vkGetSamplerOpaqueCaptureDescriptorDataEXT_ptr, invokeErrorCallback);
			if(vkGetSamplerOpaqueCaptureDescriptorDataEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetFragmentShadingRateEnumNV":
			mNativeLib.LoadFunction("vkCmdSetFragmentShadingRateEnumNV", out vkCmdSetFragmentShadingRateEnumNV_ptr, invokeErrorCallback);
			if(vkCmdSetFragmentShadingRateEnumNV_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawMeshTasksEXT":
			mNativeLib.LoadFunction("vkCmdDrawMeshTasksEXT", out vkCmdDrawMeshTasksEXT_ptr, invokeErrorCallback);
			if(vkCmdDrawMeshTasksEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawMeshTasksIndirectEXT":
			mNativeLib.LoadFunction("vkCmdDrawMeshTasksIndirectEXT", out vkCmdDrawMeshTasksIndirectEXT_ptr, invokeErrorCallback);
			if(vkCmdDrawMeshTasksIndirectEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawMeshTasksIndirectCountEXT":
			mNativeLib.LoadFunction("vkCmdDrawMeshTasksIndirectCountEXT", out vkCmdDrawMeshTasksIndirectCountEXT_ptr, invokeErrorCallback);
			if(vkCmdDrawMeshTasksIndirectCountEXT_ptr == null)
				return .Err;
			break;

		case "vkGetImageSubresourceLayout2EXT":
			mNativeLib.LoadFunction("vkGetImageSubresourceLayout2EXT", out vkGetImageSubresourceLayout2EXT_ptr, invokeErrorCallback);
			if(vkGetImageSubresourceLayout2EXT_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceFaultInfoEXT":
			mNativeLib.LoadFunction("vkGetDeviceFaultInfoEXT", out vkGetDeviceFaultInfoEXT_ptr, invokeErrorCallback);
			if(vkGetDeviceFaultInfoEXT_ptr == null)
				return .Err;
			break;

		case "vkAcquireWinrtDisplayNV":
			mNativeLib.LoadFunction("vkAcquireWinrtDisplayNV", out vkAcquireWinrtDisplayNV_ptr, invokeErrorCallback);
			if(vkAcquireWinrtDisplayNV_ptr == null)
				return .Err;
			break;

		case "vkGetWinrtDisplayNV":
			mNativeLib.LoadFunction("vkGetWinrtDisplayNV", out vkGetWinrtDisplayNV_ptr, invokeErrorCallback);
			if(vkGetWinrtDisplayNV_ptr == null)
				return .Err;
			break;

		case "vkCreateDirectFBSurfaceEXT":
			mNativeLib.LoadFunction("vkCreateDirectFBSurfaceEXT", out vkCreateDirectFBSurfaceEXT_ptr, invokeErrorCallback);
			if(vkCreateDirectFBSurfaceEXT_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceDirectFBPresentationSupportEXT":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceDirectFBPresentationSupportEXT", out vkGetPhysicalDeviceDirectFBPresentationSupportEXT_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceDirectFBPresentationSupportEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetVertexInputEXT":
			mNativeLib.LoadFunction("vkCmdSetVertexInputEXT", out vkCmdSetVertexInputEXT_ptr, invokeErrorCallback);
			if(vkCmdSetVertexInputEXT_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryZirconHandleFUCHSIA":
			mNativeLib.LoadFunction("vkGetMemoryZirconHandleFUCHSIA", out vkGetMemoryZirconHandleFUCHSIA_ptr, invokeErrorCallback);
			if(vkGetMemoryZirconHandleFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryZirconHandlePropertiesFUCHSIA":
			mNativeLib.LoadFunction("vkGetMemoryZirconHandlePropertiesFUCHSIA", out vkGetMemoryZirconHandlePropertiesFUCHSIA_ptr, invokeErrorCallback);
			if(vkGetMemoryZirconHandlePropertiesFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkImportSemaphoreZirconHandleFUCHSIA":
			mNativeLib.LoadFunction("vkImportSemaphoreZirconHandleFUCHSIA", out vkImportSemaphoreZirconHandleFUCHSIA_ptr, invokeErrorCallback);
			if(vkImportSemaphoreZirconHandleFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkGetSemaphoreZirconHandleFUCHSIA":
			mNativeLib.LoadFunction("vkGetSemaphoreZirconHandleFUCHSIA", out vkGetSemaphoreZirconHandleFUCHSIA_ptr, invokeErrorCallback);
			if(vkGetSemaphoreZirconHandleFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkCreateBufferCollectionFUCHSIA":
			mNativeLib.LoadFunction("vkCreateBufferCollectionFUCHSIA", out vkCreateBufferCollectionFUCHSIA_ptr, invokeErrorCallback);
			if(vkCreateBufferCollectionFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkSetBufferCollectionImageConstraintsFUCHSIA":
			mNativeLib.LoadFunction("vkSetBufferCollectionImageConstraintsFUCHSIA", out vkSetBufferCollectionImageConstraintsFUCHSIA_ptr, invokeErrorCallback);
			if(vkSetBufferCollectionImageConstraintsFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkSetBufferCollectionBufferConstraintsFUCHSIA":
			mNativeLib.LoadFunction("vkSetBufferCollectionBufferConstraintsFUCHSIA", out vkSetBufferCollectionBufferConstraintsFUCHSIA_ptr, invokeErrorCallback);
			if(vkSetBufferCollectionBufferConstraintsFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkDestroyBufferCollectionFUCHSIA":
			mNativeLib.LoadFunction("vkDestroyBufferCollectionFUCHSIA", out vkDestroyBufferCollectionFUCHSIA_ptr, invokeErrorCallback);
			if(vkDestroyBufferCollectionFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkGetBufferCollectionPropertiesFUCHSIA":
			mNativeLib.LoadFunction("vkGetBufferCollectionPropertiesFUCHSIA", out vkGetBufferCollectionPropertiesFUCHSIA_ptr, invokeErrorCallback);
			if(vkGetBufferCollectionPropertiesFUCHSIA_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI":
			mNativeLib.LoadFunction("vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI", out vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI_ptr, invokeErrorCallback);
			if(vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI_ptr == null)
				return .Err;
			break;

		case "vkCmdSubpassShadingHUAWEI":
			mNativeLib.LoadFunction("vkCmdSubpassShadingHUAWEI", out vkCmdSubpassShadingHUAWEI_ptr, invokeErrorCallback);
			if(vkCmdSubpassShadingHUAWEI_ptr == null)
				return .Err;
			break;

		case "vkCmdBindInvocationMaskHUAWEI":
			mNativeLib.LoadFunction("vkCmdBindInvocationMaskHUAWEI", out vkCmdBindInvocationMaskHUAWEI_ptr, invokeErrorCallback);
			if(vkCmdBindInvocationMaskHUAWEI_ptr == null)
				return .Err;
			break;

		case "vkGetMemoryRemoteAddressNV":
			mNativeLib.LoadFunction("vkGetMemoryRemoteAddressNV", out vkGetMemoryRemoteAddressNV_ptr, invokeErrorCallback);
			if(vkGetMemoryRemoteAddressNV_ptr == null)
				return .Err;
			break;

		case "vkGetPipelinePropertiesEXT":
			mNativeLib.LoadFunction("vkGetPipelinePropertiesEXT", out vkGetPipelinePropertiesEXT_ptr, invokeErrorCallback);
			if(vkGetPipelinePropertiesEXT_ptr == null)
				return .Err;
			break;

		case "vkGetFenceSciSyncFenceNV":
			mNativeLib.LoadFunction("vkGetFenceSciSyncFenceNV", out vkGetFenceSciSyncFenceNV_ptr, invokeErrorCallback);
			if(vkGetFenceSciSyncFenceNV_ptr == null)
				return .Err;
			break;

		case "vkGetFenceSciSyncObjNV":
			mNativeLib.LoadFunction("vkGetFenceSciSyncObjNV", out vkGetFenceSciSyncObjNV_ptr, invokeErrorCallback);
			if(vkGetFenceSciSyncObjNV_ptr == null)
				return .Err;
			break;

		case "vkImportFenceSciSyncFenceNV":
			mNativeLib.LoadFunction("vkImportFenceSciSyncFenceNV", out vkImportFenceSciSyncFenceNV_ptr, invokeErrorCallback);
			if(vkImportFenceSciSyncFenceNV_ptr == null)
				return .Err;
			break;

		case "vkImportFenceSciSyncObjNV":
			mNativeLib.LoadFunction("vkImportFenceSciSyncObjNV", out vkImportFenceSciSyncObjNV_ptr, invokeErrorCallback);
			if(vkImportFenceSciSyncObjNV_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSciSyncAttributesNV":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSciSyncAttributesNV", out vkGetPhysicalDeviceSciSyncAttributesNV_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSciSyncAttributesNV_ptr == null)
				return .Err;
			break;

		case "vkGetSemaphoreSciSyncObjNV":
			mNativeLib.LoadFunction("vkGetSemaphoreSciSyncObjNV", out vkGetSemaphoreSciSyncObjNV_ptr, invokeErrorCallback);
			if(vkGetSemaphoreSciSyncObjNV_ptr == null)
				return .Err;
			break;

		case "vkImportSemaphoreSciSyncObjNV":
			mNativeLib.LoadFunction("vkImportSemaphoreSciSyncObjNV", out vkImportSemaphoreSciSyncObjNV_ptr, invokeErrorCallback);
			if(vkImportSemaphoreSciSyncObjNV_ptr == null)
				return .Err;
			break;

		case "vkGetMemorySciBufNV":
			mNativeLib.LoadFunction("vkGetMemorySciBufNV", out vkGetMemorySciBufNV_ptr, invokeErrorCallback);
			if(vkGetMemorySciBufNV_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV", out vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceSciBufAttributesNV":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceSciBufAttributesNV", out vkGetPhysicalDeviceSciBufAttributesNV_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceSciBufAttributesNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetPatchControlPointsEXT":
			mNativeLib.LoadFunction("vkCmdSetPatchControlPointsEXT", out vkCmdSetPatchControlPointsEXT_ptr, invokeErrorCallback);
			if(vkCmdSetPatchControlPointsEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetLogicOpEXT":
			mNativeLib.LoadFunction("vkCmdSetLogicOpEXT", out vkCmdSetLogicOpEXT_ptr, invokeErrorCallback);
			if(vkCmdSetLogicOpEXT_ptr == null)
				return .Err;
			break;

		case "vkCreateScreenSurfaceQNX":
			mNativeLib.LoadFunction("vkCreateScreenSurfaceQNX", out vkCreateScreenSurfaceQNX_ptr, invokeErrorCallback);
			if(vkCreateScreenSurfaceQNX_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceScreenPresentationSupportQNX":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceScreenPresentationSupportQNX", out vkGetPhysicalDeviceScreenPresentationSupportQNX_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceScreenPresentationSupportQNX_ptr == null)
				return .Err;
			break;

		case "vkCmdSetColorWriteEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetColorWriteEnableEXT", out vkCmdSetColorWriteEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetColorWriteEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawMultiEXT":
			mNativeLib.LoadFunction("vkCmdDrawMultiEXT", out vkCmdDrawMultiEXT_ptr, invokeErrorCallback);
			if(vkCmdDrawMultiEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawMultiIndexedEXT":
			mNativeLib.LoadFunction("vkCmdDrawMultiIndexedEXT", out vkCmdDrawMultiIndexedEXT_ptr, invokeErrorCallback);
			if(vkCmdDrawMultiIndexedEXT_ptr == null)
				return .Err;
			break;

		case "vkCreateMicromapEXT":
			mNativeLib.LoadFunction("vkCreateMicromapEXT", out vkCreateMicromapEXT_ptr, invokeErrorCallback);
			if(vkCreateMicromapEXT_ptr == null)
				return .Err;
			break;

		case "vkDestroyMicromapEXT":
			mNativeLib.LoadFunction("vkDestroyMicromapEXT", out vkDestroyMicromapEXT_ptr, invokeErrorCallback);
			if(vkDestroyMicromapEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdBuildMicromapsEXT":
			mNativeLib.LoadFunction("vkCmdBuildMicromapsEXT", out vkCmdBuildMicromapsEXT_ptr, invokeErrorCallback);
			if(vkCmdBuildMicromapsEXT_ptr == null)
				return .Err;
			break;

		case "vkBuildMicromapsEXT":
			mNativeLib.LoadFunction("vkBuildMicromapsEXT", out vkBuildMicromapsEXT_ptr, invokeErrorCallback);
			if(vkBuildMicromapsEXT_ptr == null)
				return .Err;
			break;

		case "vkCopyMicromapEXT":
			mNativeLib.LoadFunction("vkCopyMicromapEXT", out vkCopyMicromapEXT_ptr, invokeErrorCallback);
			if(vkCopyMicromapEXT_ptr == null)
				return .Err;
			break;

		case "vkCopyMicromapToMemoryEXT":
			mNativeLib.LoadFunction("vkCopyMicromapToMemoryEXT", out vkCopyMicromapToMemoryEXT_ptr, invokeErrorCallback);
			if(vkCopyMicromapToMemoryEXT_ptr == null)
				return .Err;
			break;

		case "vkCopyMemoryToMicromapEXT":
			mNativeLib.LoadFunction("vkCopyMemoryToMicromapEXT", out vkCopyMemoryToMicromapEXT_ptr, invokeErrorCallback);
			if(vkCopyMemoryToMicromapEXT_ptr == null)
				return .Err;
			break;

		case "vkWriteMicromapsPropertiesEXT":
			mNativeLib.LoadFunction("vkWriteMicromapsPropertiesEXT", out vkWriteMicromapsPropertiesEXT_ptr, invokeErrorCallback);
			if(vkWriteMicromapsPropertiesEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyMicromapEXT":
			mNativeLib.LoadFunction("vkCmdCopyMicromapEXT", out vkCmdCopyMicromapEXT_ptr, invokeErrorCallback);
			if(vkCmdCopyMicromapEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyMicromapToMemoryEXT":
			mNativeLib.LoadFunction("vkCmdCopyMicromapToMemoryEXT", out vkCmdCopyMicromapToMemoryEXT_ptr, invokeErrorCallback);
			if(vkCmdCopyMicromapToMemoryEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyMemoryToMicromapEXT":
			mNativeLib.LoadFunction("vkCmdCopyMemoryToMicromapEXT", out vkCmdCopyMemoryToMicromapEXT_ptr, invokeErrorCallback);
			if(vkCmdCopyMemoryToMicromapEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdWriteMicromapsPropertiesEXT":
			mNativeLib.LoadFunction("vkCmdWriteMicromapsPropertiesEXT", out vkCmdWriteMicromapsPropertiesEXT_ptr, invokeErrorCallback);
			if(vkCmdWriteMicromapsPropertiesEXT_ptr == null)
				return .Err;
			break;

		case "vkGetDeviceMicromapCompatibilityEXT":
			mNativeLib.LoadFunction("vkGetDeviceMicromapCompatibilityEXT", out vkGetDeviceMicromapCompatibilityEXT_ptr, invokeErrorCallback);
			if(vkGetDeviceMicromapCompatibilityEXT_ptr == null)
				return .Err;
			break;

		case "vkGetMicromapBuildSizesEXT":
			mNativeLib.LoadFunction("vkGetMicromapBuildSizesEXT", out vkGetMicromapBuildSizesEXT_ptr, invokeErrorCallback);
			if(vkGetMicromapBuildSizesEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawClusterHUAWEI":
			mNativeLib.LoadFunction("vkCmdDrawClusterHUAWEI", out vkCmdDrawClusterHUAWEI_ptr, invokeErrorCallback);
			if(vkCmdDrawClusterHUAWEI_ptr == null)
				return .Err;
			break;

		case "vkCmdDrawClusterIndirectHUAWEI":
			mNativeLib.LoadFunction("vkCmdDrawClusterIndirectHUAWEI", out vkCmdDrawClusterIndirectHUAWEI_ptr, invokeErrorCallback);
			if(vkCmdDrawClusterIndirectHUAWEI_ptr == null)
				return .Err;
			break;

		case "vkSetDeviceMemoryPriorityEXT":
			mNativeLib.LoadFunction("vkSetDeviceMemoryPriorityEXT", out vkSetDeviceMemoryPriorityEXT_ptr, invokeErrorCallback);
			if(vkSetDeviceMemoryPriorityEXT_ptr == null)
				return .Err;
			break;

		case "vkGetDescriptorSetLayoutHostMappingInfoVALVE":
			mNativeLib.LoadFunction("vkGetDescriptorSetLayoutHostMappingInfoVALVE", out vkGetDescriptorSetLayoutHostMappingInfoVALVE_ptr, invokeErrorCallback);
			if(vkGetDescriptorSetLayoutHostMappingInfoVALVE_ptr == null)
				return .Err;
			break;

		case "vkGetDescriptorSetHostMappingVALVE":
			mNativeLib.LoadFunction("vkGetDescriptorSetHostMappingVALVE", out vkGetDescriptorSetHostMappingVALVE_ptr, invokeErrorCallback);
			if(vkGetDescriptorSetHostMappingVALVE_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyMemoryIndirectNV":
			mNativeLib.LoadFunction("vkCmdCopyMemoryIndirectNV", out vkCmdCopyMemoryIndirectNV_ptr, invokeErrorCallback);
			if(vkCmdCopyMemoryIndirectNV_ptr == null)
				return .Err;
			break;

		case "vkCmdCopyMemoryToImageIndirectNV":
			mNativeLib.LoadFunction("vkCmdCopyMemoryToImageIndirectNV", out vkCmdCopyMemoryToImageIndirectNV_ptr, invokeErrorCallback);
			if(vkCmdCopyMemoryToImageIndirectNV_ptr == null)
				return .Err;
			break;

		case "vkCmdDecompressMemoryNV":
			mNativeLib.LoadFunction("vkCmdDecompressMemoryNV", out vkCmdDecompressMemoryNV_ptr, invokeErrorCallback);
			if(vkCmdDecompressMemoryNV_ptr == null)
				return .Err;
			break;

		case "vkCmdDecompressMemoryIndirectCountNV":
			mNativeLib.LoadFunction("vkCmdDecompressMemoryIndirectCountNV", out vkCmdDecompressMemoryIndirectCountNV_ptr, invokeErrorCallback);
			if(vkCmdDecompressMemoryIndirectCountNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetTessellationDomainOriginEXT":
			mNativeLib.LoadFunction("vkCmdSetTessellationDomainOriginEXT", out vkCmdSetTessellationDomainOriginEXT_ptr, invokeErrorCallback);
			if(vkCmdSetTessellationDomainOriginEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthClampEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetDepthClampEnableEXT", out vkCmdSetDepthClampEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetDepthClampEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetPolygonModeEXT":
			mNativeLib.LoadFunction("vkCmdSetPolygonModeEXT", out vkCmdSetPolygonModeEXT_ptr, invokeErrorCallback);
			if(vkCmdSetPolygonModeEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetRasterizationSamplesEXT":
			mNativeLib.LoadFunction("vkCmdSetRasterizationSamplesEXT", out vkCmdSetRasterizationSamplesEXT_ptr, invokeErrorCallback);
			if(vkCmdSetRasterizationSamplesEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetSampleMaskEXT":
			mNativeLib.LoadFunction("vkCmdSetSampleMaskEXT", out vkCmdSetSampleMaskEXT_ptr, invokeErrorCallback);
			if(vkCmdSetSampleMaskEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetAlphaToCoverageEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetAlphaToCoverageEnableEXT", out vkCmdSetAlphaToCoverageEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetAlphaToCoverageEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetAlphaToOneEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetAlphaToOneEnableEXT", out vkCmdSetAlphaToOneEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetAlphaToOneEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetLogicOpEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetLogicOpEnableEXT", out vkCmdSetLogicOpEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetLogicOpEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetColorBlendEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetColorBlendEnableEXT", out vkCmdSetColorBlendEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetColorBlendEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetColorBlendEquationEXT":
			mNativeLib.LoadFunction("vkCmdSetColorBlendEquationEXT", out vkCmdSetColorBlendEquationEXT_ptr, invokeErrorCallback);
			if(vkCmdSetColorBlendEquationEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetColorWriteMaskEXT":
			mNativeLib.LoadFunction("vkCmdSetColorWriteMaskEXT", out vkCmdSetColorWriteMaskEXT_ptr, invokeErrorCallback);
			if(vkCmdSetColorWriteMaskEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetRasterizationStreamEXT":
			mNativeLib.LoadFunction("vkCmdSetRasterizationStreamEXT", out vkCmdSetRasterizationStreamEXT_ptr, invokeErrorCallback);
			if(vkCmdSetRasterizationStreamEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetConservativeRasterizationModeEXT":
			mNativeLib.LoadFunction("vkCmdSetConservativeRasterizationModeEXT", out vkCmdSetConservativeRasterizationModeEXT_ptr, invokeErrorCallback);
			if(vkCmdSetConservativeRasterizationModeEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetExtraPrimitiveOverestimationSizeEXT":
			mNativeLib.LoadFunction("vkCmdSetExtraPrimitiveOverestimationSizeEXT", out vkCmdSetExtraPrimitiveOverestimationSizeEXT_ptr, invokeErrorCallback);
			if(vkCmdSetExtraPrimitiveOverestimationSizeEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthClipEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetDepthClipEnableEXT", out vkCmdSetDepthClipEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetDepthClipEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetSampleLocationsEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetSampleLocationsEnableEXT", out vkCmdSetSampleLocationsEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetSampleLocationsEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetColorBlendAdvancedEXT":
			mNativeLib.LoadFunction("vkCmdSetColorBlendAdvancedEXT", out vkCmdSetColorBlendAdvancedEXT_ptr, invokeErrorCallback);
			if(vkCmdSetColorBlendAdvancedEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetProvokingVertexModeEXT":
			mNativeLib.LoadFunction("vkCmdSetProvokingVertexModeEXT", out vkCmdSetProvokingVertexModeEXT_ptr, invokeErrorCallback);
			if(vkCmdSetProvokingVertexModeEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetLineRasterizationModeEXT":
			mNativeLib.LoadFunction("vkCmdSetLineRasterizationModeEXT", out vkCmdSetLineRasterizationModeEXT_ptr, invokeErrorCallback);
			if(vkCmdSetLineRasterizationModeEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetLineStippleEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetLineStippleEnableEXT", out vkCmdSetLineStippleEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetLineStippleEnableEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetDepthClipNegativeOneToOneEXT":
			mNativeLib.LoadFunction("vkCmdSetDepthClipNegativeOneToOneEXT", out vkCmdSetDepthClipNegativeOneToOneEXT_ptr, invokeErrorCallback);
			if(vkCmdSetDepthClipNegativeOneToOneEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdSetViewportWScalingEnableNV":
			mNativeLib.LoadFunction("vkCmdSetViewportWScalingEnableNV", out vkCmdSetViewportWScalingEnableNV_ptr, invokeErrorCallback);
			if(vkCmdSetViewportWScalingEnableNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetViewportSwizzleNV":
			mNativeLib.LoadFunction("vkCmdSetViewportSwizzleNV", out vkCmdSetViewportSwizzleNV_ptr, invokeErrorCallback);
			if(vkCmdSetViewportSwizzleNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCoverageToColorEnableNV":
			mNativeLib.LoadFunction("vkCmdSetCoverageToColorEnableNV", out vkCmdSetCoverageToColorEnableNV_ptr, invokeErrorCallback);
			if(vkCmdSetCoverageToColorEnableNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCoverageToColorLocationNV":
			mNativeLib.LoadFunction("vkCmdSetCoverageToColorLocationNV", out vkCmdSetCoverageToColorLocationNV_ptr, invokeErrorCallback);
			if(vkCmdSetCoverageToColorLocationNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCoverageModulationModeNV":
			mNativeLib.LoadFunction("vkCmdSetCoverageModulationModeNV", out vkCmdSetCoverageModulationModeNV_ptr, invokeErrorCallback);
			if(vkCmdSetCoverageModulationModeNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCoverageModulationTableEnableNV":
			mNativeLib.LoadFunction("vkCmdSetCoverageModulationTableEnableNV", out vkCmdSetCoverageModulationTableEnableNV_ptr, invokeErrorCallback);
			if(vkCmdSetCoverageModulationTableEnableNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCoverageModulationTableNV":
			mNativeLib.LoadFunction("vkCmdSetCoverageModulationTableNV", out vkCmdSetCoverageModulationTableNV_ptr, invokeErrorCallback);
			if(vkCmdSetCoverageModulationTableNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetShadingRateImageEnableNV":
			mNativeLib.LoadFunction("vkCmdSetShadingRateImageEnableNV", out vkCmdSetShadingRateImageEnableNV_ptr, invokeErrorCallback);
			if(vkCmdSetShadingRateImageEnableNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetRepresentativeFragmentTestEnableNV":
			mNativeLib.LoadFunction("vkCmdSetRepresentativeFragmentTestEnableNV", out vkCmdSetRepresentativeFragmentTestEnableNV_ptr, invokeErrorCallback);
			if(vkCmdSetRepresentativeFragmentTestEnableNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetCoverageReductionModeNV":
			mNativeLib.LoadFunction("vkCmdSetCoverageReductionModeNV", out vkCmdSetCoverageReductionModeNV_ptr, invokeErrorCallback);
			if(vkCmdSetCoverageReductionModeNV_ptr == null)
				return .Err;
			break;

		case "vkGetShaderModuleIdentifierEXT":
			mNativeLib.LoadFunction("vkGetShaderModuleIdentifierEXT", out vkGetShaderModuleIdentifierEXT_ptr, invokeErrorCallback);
			if(vkGetShaderModuleIdentifierEXT_ptr == null)
				return .Err;
			break;

		case "vkGetShaderModuleCreateInfoIdentifierEXT":
			mNativeLib.LoadFunction("vkGetShaderModuleCreateInfoIdentifierEXT", out vkGetShaderModuleCreateInfoIdentifierEXT_ptr, invokeErrorCallback);
			if(vkGetShaderModuleCreateInfoIdentifierEXT_ptr == null)
				return .Err;
			break;

		case "vkGetPhysicalDeviceOpticalFlowImageFormatsNV":
			mNativeLib.LoadFunction("vkGetPhysicalDeviceOpticalFlowImageFormatsNV", out vkGetPhysicalDeviceOpticalFlowImageFormatsNV_ptr, invokeErrorCallback);
			if(vkGetPhysicalDeviceOpticalFlowImageFormatsNV_ptr == null)
				return .Err;
			break;

		case "vkCreateOpticalFlowSessionNV":
			mNativeLib.LoadFunction("vkCreateOpticalFlowSessionNV", out vkCreateOpticalFlowSessionNV_ptr, invokeErrorCallback);
			if(vkCreateOpticalFlowSessionNV_ptr == null)
				return .Err;
			break;

		case "vkDestroyOpticalFlowSessionNV":
			mNativeLib.LoadFunction("vkDestroyOpticalFlowSessionNV", out vkDestroyOpticalFlowSessionNV_ptr, invokeErrorCallback);
			if(vkDestroyOpticalFlowSessionNV_ptr == null)
				return .Err;
			break;

		case "vkBindOpticalFlowSessionImageNV":
			mNativeLib.LoadFunction("vkBindOpticalFlowSessionImageNV", out vkBindOpticalFlowSessionImageNV_ptr, invokeErrorCallback);
			if(vkBindOpticalFlowSessionImageNV_ptr == null)
				return .Err;
			break;

		case "vkCmdOpticalFlowExecuteNV":
			mNativeLib.LoadFunction("vkCmdOpticalFlowExecuteNV", out vkCmdOpticalFlowExecuteNV_ptr, invokeErrorCallback);
			if(vkCmdOpticalFlowExecuteNV_ptr == null)
				return .Err;
			break;

		case "vkCreateShadersEXT":
			mNativeLib.LoadFunction("vkCreateShadersEXT", out vkCreateShadersEXT_ptr, invokeErrorCallback);
			if(vkCreateShadersEXT_ptr == null)
				return .Err;
			break;

		case "vkDestroyShaderEXT":
			mNativeLib.LoadFunction("vkDestroyShaderEXT", out vkDestroyShaderEXT_ptr, invokeErrorCallback);
			if(vkDestroyShaderEXT_ptr == null)
				return .Err;
			break;

		case "vkGetShaderBinaryDataEXT":
			mNativeLib.LoadFunction("vkGetShaderBinaryDataEXT", out vkGetShaderBinaryDataEXT_ptr, invokeErrorCallback);
			if(vkGetShaderBinaryDataEXT_ptr == null)
				return .Err;
			break;

		case "vkCmdBindShadersEXT":
			mNativeLib.LoadFunction("vkCmdBindShadersEXT", out vkCmdBindShadersEXT_ptr, invokeErrorCallback);
			if(vkCmdBindShadersEXT_ptr == null)
				return .Err;
			break;

		case "vkGetFramebufferTilePropertiesQCOM":
			mNativeLib.LoadFunction("vkGetFramebufferTilePropertiesQCOM", out vkGetFramebufferTilePropertiesQCOM_ptr, invokeErrorCallback);
			if(vkGetFramebufferTilePropertiesQCOM_ptr == null)
				return .Err;
			break;

		case "vkGetDynamicRenderingTilePropertiesQCOM":
			mNativeLib.LoadFunction("vkGetDynamicRenderingTilePropertiesQCOM", out vkGetDynamicRenderingTilePropertiesQCOM_ptr, invokeErrorCallback);
			if(vkGetDynamicRenderingTilePropertiesQCOM_ptr == null)
				return .Err;
			break;

		case "vkCreateSemaphoreSciSyncPoolNV":
			mNativeLib.LoadFunction("vkCreateSemaphoreSciSyncPoolNV", out vkCreateSemaphoreSciSyncPoolNV_ptr, invokeErrorCallback);
			if(vkCreateSemaphoreSciSyncPoolNV_ptr == null)
				return .Err;
			break;

		case "vkDestroySemaphoreSciSyncPoolNV":
			mNativeLib.LoadFunction("vkDestroySemaphoreSciSyncPoolNV", out vkDestroySemaphoreSciSyncPoolNV_ptr, invokeErrorCallback);
			if(vkDestroySemaphoreSciSyncPoolNV_ptr == null)
				return .Err;
			break;

		case "vkCmdSetAttachmentFeedbackLoopEnableEXT":
			mNativeLib.LoadFunction("vkCmdSetAttachmentFeedbackLoopEnableEXT", out vkCmdSetAttachmentFeedbackLoopEnableEXT_ptr, invokeErrorCallback);
			if(vkCmdSetAttachmentFeedbackLoopEnableEXT_ptr == null)
				return .Err;
			break;

		default:
			Runtime.FatalError(scope $"Unknown function name '{name}'.");
		}
		return .Ok;
	}

	public static Result<void, String> LoadFunctions(Span<String> functions, VkInstance? instance = null)
	{
		if(instance != null)
			SetInstance(instance.Value);

		for (var func in functions)
		{
			if(LoadFunction(func) case .Err)
				return .Err(func);
		}
		return .Ok;
	}

	private static void LoadAllFuncions(VkInstance? instance = null, List<String> excludeFunctions = null)
	{
		if (instance != null)
			SetInstance(instance.Value);

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateInstance"))
			LoadFunction("vkCreateInstance").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyInstance"))
			LoadFunction("vkDestroyInstance").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEnumeratePhysicalDevices"))
			LoadFunction("vkEnumeratePhysicalDevices").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceFeatures"))
			LoadFunction("vkGetPhysicalDeviceFeatures").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceFormatProperties"))
			LoadFunction("vkGetPhysicalDeviceFormatProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceImageFormatProperties"))
			LoadFunction("vkGetPhysicalDeviceImageFormatProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceProperties"))
			LoadFunction("vkGetPhysicalDeviceProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceQueueFamilyProperties"))
			LoadFunction("vkGetPhysicalDeviceQueueFamilyProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceMemoryProperties"))
			LoadFunction("vkGetPhysicalDeviceMemoryProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetInstanceProcAddr"))
			LoadFunction("vkGetInstanceProcAddr").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceProcAddr"))
			LoadFunction("vkGetDeviceProcAddr").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDevice"))
			LoadFunction("vkCreateDevice").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyDevice"))
			LoadFunction("vkDestroyDevice").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEnumerateInstanceExtensionProperties"))
			LoadFunction("vkEnumerateInstanceExtensionProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEnumerateDeviceExtensionProperties"))
			LoadFunction("vkEnumerateDeviceExtensionProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEnumerateInstanceLayerProperties"))
			LoadFunction("vkEnumerateInstanceLayerProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEnumerateDeviceLayerProperties"))
			LoadFunction("vkEnumerateDeviceLayerProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceQueue"))
			LoadFunction("vkGetDeviceQueue").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueueSubmit"))
			LoadFunction("vkQueueSubmit").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueueWaitIdle"))
			LoadFunction("vkQueueWaitIdle").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDeviceWaitIdle"))
			LoadFunction("vkDeviceWaitIdle").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAllocateMemory"))
			LoadFunction("vkAllocateMemory").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkFreeMemory"))
			LoadFunction("vkFreeMemory").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkMapMemory"))
			LoadFunction("vkMapMemory").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkUnmapMemory"))
			LoadFunction("vkUnmapMemory").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkFlushMappedMemoryRanges"))
			LoadFunction("vkFlushMappedMemoryRanges").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkInvalidateMappedMemoryRanges"))
			LoadFunction("vkInvalidateMappedMemoryRanges").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceMemoryCommitment"))
			LoadFunction("vkGetDeviceMemoryCommitment").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBindBufferMemory"))
			LoadFunction("vkBindBufferMemory").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBindImageMemory"))
			LoadFunction("vkBindImageMemory").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetBufferMemoryRequirements"))
			LoadFunction("vkGetBufferMemoryRequirements").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageMemoryRequirements"))
			LoadFunction("vkGetImageMemoryRequirements").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageSparseMemoryRequirements"))
			LoadFunction("vkGetImageSparseMemoryRequirements").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSparseImageFormatProperties"))
			LoadFunction("vkGetPhysicalDeviceSparseImageFormatProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueueBindSparse"))
			LoadFunction("vkQueueBindSparse").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateFence"))
			LoadFunction("vkCreateFence").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyFence"))
			LoadFunction("vkDestroyFence").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkResetFences"))
			LoadFunction("vkResetFences").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetFenceStatus"))
			LoadFunction("vkGetFenceStatus").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkWaitForFences"))
			LoadFunction("vkWaitForFences").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateSemaphore"))
			LoadFunction("vkCreateSemaphore").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroySemaphore"))
			LoadFunction("vkDestroySemaphore").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateEvent"))
			LoadFunction("vkCreateEvent").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyEvent"))
			LoadFunction("vkDestroyEvent").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetEventStatus"))
			LoadFunction("vkGetEventStatus").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetEvent"))
			LoadFunction("vkSetEvent").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkResetEvent"))
			LoadFunction("vkResetEvent").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateQueryPool"))
			LoadFunction("vkCreateQueryPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyQueryPool"))
			LoadFunction("vkDestroyQueryPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetQueryPoolResults"))
			LoadFunction("vkGetQueryPoolResults").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateBuffer"))
			LoadFunction("vkCreateBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyBuffer"))
			LoadFunction("vkDestroyBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateBufferView"))
			LoadFunction("vkCreateBufferView").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyBufferView"))
			LoadFunction("vkDestroyBufferView").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateImage"))
			LoadFunction("vkCreateImage").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyImage"))
			LoadFunction("vkDestroyImage").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageSubresourceLayout"))
			LoadFunction("vkGetImageSubresourceLayout").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateImageView"))
			LoadFunction("vkCreateImageView").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyImageView"))
			LoadFunction("vkDestroyImageView").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateShaderModule"))
			LoadFunction("vkCreateShaderModule").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyShaderModule"))
			LoadFunction("vkDestroyShaderModule").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreatePipelineCache"))
			LoadFunction("vkCreatePipelineCache").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyPipelineCache"))
			LoadFunction("vkDestroyPipelineCache").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPipelineCacheData"))
			LoadFunction("vkGetPipelineCacheData").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkMergePipelineCaches"))
			LoadFunction("vkMergePipelineCaches").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateGraphicsPipelines"))
			LoadFunction("vkCreateGraphicsPipelines").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateComputePipelines"))
			LoadFunction("vkCreateComputePipelines").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyPipeline"))
			LoadFunction("vkDestroyPipeline").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreatePipelineLayout"))
			LoadFunction("vkCreatePipelineLayout").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyPipelineLayout"))
			LoadFunction("vkDestroyPipelineLayout").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateSampler"))
			LoadFunction("vkCreateSampler").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroySampler"))
			LoadFunction("vkDestroySampler").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDescriptorSetLayout"))
			LoadFunction("vkCreateDescriptorSetLayout").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyDescriptorSetLayout"))
			LoadFunction("vkDestroyDescriptorSetLayout").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDescriptorPool"))
			LoadFunction("vkCreateDescriptorPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyDescriptorPool"))
			LoadFunction("vkDestroyDescriptorPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkResetDescriptorPool"))
			LoadFunction("vkResetDescriptorPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAllocateDescriptorSets"))
			LoadFunction("vkAllocateDescriptorSets").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkFreeDescriptorSets"))
			LoadFunction("vkFreeDescriptorSets").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkUpdateDescriptorSets"))
			LoadFunction("vkUpdateDescriptorSets").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateFramebuffer"))
			LoadFunction("vkCreateFramebuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyFramebuffer"))
			LoadFunction("vkDestroyFramebuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateRenderPass"))
			LoadFunction("vkCreateRenderPass").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyRenderPass"))
			LoadFunction("vkDestroyRenderPass").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetRenderAreaGranularity"))
			LoadFunction("vkGetRenderAreaGranularity").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateCommandPool"))
			LoadFunction("vkCreateCommandPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyCommandPool"))
			LoadFunction("vkDestroyCommandPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkResetCommandPool"))
			LoadFunction("vkResetCommandPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAllocateCommandBuffers"))
			LoadFunction("vkAllocateCommandBuffers").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkFreeCommandBuffers"))
			LoadFunction("vkFreeCommandBuffers").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBeginCommandBuffer"))
			LoadFunction("vkBeginCommandBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEndCommandBuffer"))
			LoadFunction("vkEndCommandBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkResetCommandBuffer"))
			LoadFunction("vkResetCommandBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindPipeline"))
			LoadFunction("vkCmdBindPipeline").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetViewport"))
			LoadFunction("vkCmdSetViewport").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetScissor"))
			LoadFunction("vkCmdSetScissor").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetLineWidth"))
			LoadFunction("vkCmdSetLineWidth").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthBias"))
			LoadFunction("vkCmdSetDepthBias").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetBlendConstants"))
			LoadFunction("vkCmdSetBlendConstants").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthBounds"))
			LoadFunction("vkCmdSetDepthBounds").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetStencilCompareMask"))
			LoadFunction("vkCmdSetStencilCompareMask").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetStencilWriteMask"))
			LoadFunction("vkCmdSetStencilWriteMask").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetStencilReference"))
			LoadFunction("vkCmdSetStencilReference").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindDescriptorSets"))
			LoadFunction("vkCmdBindDescriptorSets").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindIndexBuffer"))
			LoadFunction("vkCmdBindIndexBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindVertexBuffers"))
			LoadFunction("vkCmdBindVertexBuffers").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDraw"))
			LoadFunction("vkCmdDraw").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawIndexed"))
			LoadFunction("vkCmdDrawIndexed").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawIndirect"))
			LoadFunction("vkCmdDrawIndirect").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawIndexedIndirect"))
			LoadFunction("vkCmdDrawIndexedIndirect").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDispatch"))
			LoadFunction("vkCmdDispatch").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDispatchIndirect"))
			LoadFunction("vkCmdDispatchIndirect").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyBuffer"))
			LoadFunction("vkCmdCopyBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyImage"))
			LoadFunction("vkCmdCopyImage").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBlitImage"))
			LoadFunction("vkCmdBlitImage").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyBufferToImage"))
			LoadFunction("vkCmdCopyBufferToImage").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyImageToBuffer"))
			LoadFunction("vkCmdCopyImageToBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdUpdateBuffer"))
			LoadFunction("vkCmdUpdateBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdFillBuffer"))
			LoadFunction("vkCmdFillBuffer").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdClearColorImage"))
			LoadFunction("vkCmdClearColorImage").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdClearDepthStencilImage"))
			LoadFunction("vkCmdClearDepthStencilImage").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdClearAttachments"))
			LoadFunction("vkCmdClearAttachments").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdResolveImage"))
			LoadFunction("vkCmdResolveImage").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetEvent"))
			LoadFunction("vkCmdSetEvent").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdResetEvent"))
			LoadFunction("vkCmdResetEvent").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdWaitEvents"))
			LoadFunction("vkCmdWaitEvents").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdPipelineBarrier"))
			LoadFunction("vkCmdPipelineBarrier").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginQuery"))
			LoadFunction("vkCmdBeginQuery").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndQuery"))
			LoadFunction("vkCmdEndQuery").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdResetQueryPool"))
			LoadFunction("vkCmdResetQueryPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdWriteTimestamp"))
			LoadFunction("vkCmdWriteTimestamp").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyQueryPoolResults"))
			LoadFunction("vkCmdCopyQueryPoolResults").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdPushConstants"))
			LoadFunction("vkCmdPushConstants").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginRenderPass"))
			LoadFunction("vkCmdBeginRenderPass").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdNextSubpass"))
			LoadFunction("vkCmdNextSubpass").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndRenderPass"))
			LoadFunction("vkCmdEndRenderPass").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdExecuteCommands"))
			LoadFunction("vkCmdExecuteCommands").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEnumerateInstanceVersion"))
			LoadFunction("vkEnumerateInstanceVersion").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBindBufferMemory2"))
			LoadFunction("vkBindBufferMemory2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBindImageMemory2"))
			LoadFunction("vkBindImageMemory2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceGroupPeerMemoryFeatures"))
			LoadFunction("vkGetDeviceGroupPeerMemoryFeatures").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDeviceMask"))
			LoadFunction("vkCmdSetDeviceMask").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDispatchBase"))
			LoadFunction("vkCmdDispatchBase").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEnumeratePhysicalDeviceGroups"))
			LoadFunction("vkEnumeratePhysicalDeviceGroups").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageMemoryRequirements2"))
			LoadFunction("vkGetImageMemoryRequirements2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetBufferMemoryRequirements2"))
			LoadFunction("vkGetBufferMemoryRequirements2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageSparseMemoryRequirements2"))
			LoadFunction("vkGetImageSparseMemoryRequirements2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceFeatures2"))
			LoadFunction("vkGetPhysicalDeviceFeatures2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceProperties2"))
			LoadFunction("vkGetPhysicalDeviceProperties2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceFormatProperties2"))
			LoadFunction("vkGetPhysicalDeviceFormatProperties2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceImageFormatProperties2"))
			LoadFunction("vkGetPhysicalDeviceImageFormatProperties2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceQueueFamilyProperties2"))
			LoadFunction("vkGetPhysicalDeviceQueueFamilyProperties2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceMemoryProperties2"))
			LoadFunction("vkGetPhysicalDeviceMemoryProperties2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSparseImageFormatProperties2"))
			LoadFunction("vkGetPhysicalDeviceSparseImageFormatProperties2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkTrimCommandPool"))
			LoadFunction("vkTrimCommandPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceQueue2"))
			LoadFunction("vkGetDeviceQueue2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateSamplerYcbcrConversion"))
			LoadFunction("vkCreateSamplerYcbcrConversion").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroySamplerYcbcrConversion"))
			LoadFunction("vkDestroySamplerYcbcrConversion").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDescriptorUpdateTemplate"))
			LoadFunction("vkCreateDescriptorUpdateTemplate").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyDescriptorUpdateTemplate"))
			LoadFunction("vkDestroyDescriptorUpdateTemplate").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkUpdateDescriptorSetWithTemplate"))
			LoadFunction("vkUpdateDescriptorSetWithTemplate").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceExternalBufferProperties"))
			LoadFunction("vkGetPhysicalDeviceExternalBufferProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceExternalFenceProperties"))
			LoadFunction("vkGetPhysicalDeviceExternalFenceProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceExternalSemaphoreProperties"))
			LoadFunction("vkGetPhysicalDeviceExternalSemaphoreProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDescriptorSetLayoutSupport"))
			LoadFunction("vkGetDescriptorSetLayoutSupport").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawIndirectCount"))
			LoadFunction("vkCmdDrawIndirectCount").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawIndexedIndirectCount"))
			LoadFunction("vkCmdDrawIndexedIndirectCount").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateRenderPass2"))
			LoadFunction("vkCreateRenderPass2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginRenderPass2"))
			LoadFunction("vkCmdBeginRenderPass2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdNextSubpass2"))
			LoadFunction("vkCmdNextSubpass2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndRenderPass2"))
			LoadFunction("vkCmdEndRenderPass2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkResetQueryPool"))
			LoadFunction("vkResetQueryPool").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSemaphoreCounterValue"))
			LoadFunction("vkGetSemaphoreCounterValue").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkWaitSemaphores"))
			LoadFunction("vkWaitSemaphores").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSignalSemaphore"))
			LoadFunction("vkSignalSemaphore").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetBufferDeviceAddress"))
			LoadFunction("vkGetBufferDeviceAddress").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetBufferOpaqueCaptureAddress"))
			LoadFunction("vkGetBufferOpaqueCaptureAddress").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceMemoryOpaqueCaptureAddress"))
			LoadFunction("vkGetDeviceMemoryOpaqueCaptureAddress").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceToolProperties"))
			LoadFunction("vkGetPhysicalDeviceToolProperties").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreatePrivateDataSlot"))
			LoadFunction("vkCreatePrivateDataSlot").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyPrivateDataSlot"))
			LoadFunction("vkDestroyPrivateDataSlot").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetPrivateData"))
			LoadFunction("vkSetPrivateData").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPrivateData"))
			LoadFunction("vkGetPrivateData").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetEvent2"))
			LoadFunction("vkCmdSetEvent2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdResetEvent2"))
			LoadFunction("vkCmdResetEvent2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdWaitEvents2"))
			LoadFunction("vkCmdWaitEvents2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdPipelineBarrier2"))
			LoadFunction("vkCmdPipelineBarrier2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdWriteTimestamp2"))
			LoadFunction("vkCmdWriteTimestamp2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueueSubmit2"))
			LoadFunction("vkQueueSubmit2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyBuffer2"))
			LoadFunction("vkCmdCopyBuffer2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyImage2"))
			LoadFunction("vkCmdCopyImage2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyBufferToImage2"))
			LoadFunction("vkCmdCopyBufferToImage2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyImageToBuffer2"))
			LoadFunction("vkCmdCopyImageToBuffer2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBlitImage2"))
			LoadFunction("vkCmdBlitImage2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdResolveImage2"))
			LoadFunction("vkCmdResolveImage2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginRendering"))
			LoadFunction("vkCmdBeginRendering").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndRendering"))
			LoadFunction("vkCmdEndRendering").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCullMode"))
			LoadFunction("vkCmdSetCullMode").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetFrontFace"))
			LoadFunction("vkCmdSetFrontFace").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetPrimitiveTopology"))
			LoadFunction("vkCmdSetPrimitiveTopology").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetViewportWithCount"))
			LoadFunction("vkCmdSetViewportWithCount").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetScissorWithCount"))
			LoadFunction("vkCmdSetScissorWithCount").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindVertexBuffers2"))
			LoadFunction("vkCmdBindVertexBuffers2").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthTestEnable"))
			LoadFunction("vkCmdSetDepthTestEnable").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthWriteEnable"))
			LoadFunction("vkCmdSetDepthWriteEnable").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthCompareOp"))
			LoadFunction("vkCmdSetDepthCompareOp").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthBoundsTestEnable"))
			LoadFunction("vkCmdSetDepthBoundsTestEnable").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetStencilTestEnable"))
			LoadFunction("vkCmdSetStencilTestEnable").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetStencilOp"))
			LoadFunction("vkCmdSetStencilOp").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetRasterizerDiscardEnable"))
			LoadFunction("vkCmdSetRasterizerDiscardEnable").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthBiasEnable"))
			LoadFunction("vkCmdSetDepthBiasEnable").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetPrimitiveRestartEnable"))
			LoadFunction("vkCmdSetPrimitiveRestartEnable").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceBufferMemoryRequirements"))
			LoadFunction("vkGetDeviceBufferMemoryRequirements").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceImageMemoryRequirements"))
			LoadFunction("vkGetDeviceImageMemoryRequirements").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceImageSparseMemoryRequirements"))
			LoadFunction("vkGetDeviceImageSparseMemoryRequirements").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetCommandPoolMemoryConsumption"))
			LoadFunction("vkGetCommandPoolMemoryConsumption").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetFaultData"))
			LoadFunction("vkGetFaultData").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroySurfaceKHR"))
			LoadFunction("vkDestroySurfaceKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSurfaceSupportKHR"))
			LoadFunction("vkGetPhysicalDeviceSurfaceSupportKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSurfaceCapabilitiesKHR"))
			LoadFunction("vkGetPhysicalDeviceSurfaceCapabilitiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSurfaceFormatsKHR"))
			LoadFunction("vkGetPhysicalDeviceSurfaceFormatsKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSurfacePresentModesKHR"))
			LoadFunction("vkGetPhysicalDeviceSurfacePresentModesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateSwapchainKHR"))
			LoadFunction("vkCreateSwapchainKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroySwapchainKHR"))
			LoadFunction("vkDestroySwapchainKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSwapchainImagesKHR"))
			LoadFunction("vkGetSwapchainImagesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAcquireNextImageKHR"))
			LoadFunction("vkAcquireNextImageKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueuePresentKHR"))
			LoadFunction("vkQueuePresentKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceDisplayPropertiesKHR"))
			LoadFunction("vkGetPhysicalDeviceDisplayPropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceDisplayPlanePropertiesKHR"))
			LoadFunction("vkGetPhysicalDeviceDisplayPlanePropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDisplayPlaneSupportedDisplaysKHR"))
			LoadFunction("vkGetDisplayPlaneSupportedDisplaysKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDisplayModePropertiesKHR"))
			LoadFunction("vkGetDisplayModePropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDisplayModeKHR"))
			LoadFunction("vkCreateDisplayModeKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDisplayPlaneCapabilitiesKHR"))
			LoadFunction("vkGetDisplayPlaneCapabilitiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDisplayPlaneSurfaceKHR"))
			LoadFunction("vkCreateDisplayPlaneSurfaceKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateSharedSwapchainsKHR"))
			LoadFunction("vkCreateSharedSwapchainsKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateXlibSurfaceKHR"))
			LoadFunction("vkCreateXlibSurfaceKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceXlibPresentationSupportKHR"))
			LoadFunction("vkGetPhysicalDeviceXlibPresentationSupportKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateXcbSurfaceKHR"))
			LoadFunction("vkCreateXcbSurfaceKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceXcbPresentationSupportKHR"))
			LoadFunction("vkGetPhysicalDeviceXcbPresentationSupportKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateWaylandSurfaceKHR"))
			LoadFunction("vkCreateWaylandSurfaceKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceWaylandPresentationSupportKHR"))
			LoadFunction("vkGetPhysicalDeviceWaylandPresentationSupportKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateAndroidSurfaceKHR"))
			LoadFunction("vkCreateAndroidSurfaceKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateWin32SurfaceKHR"))
			LoadFunction("vkCreateWin32SurfaceKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceWin32PresentationSupportKHR"))
			LoadFunction("vkGetPhysicalDeviceWin32PresentationSupportKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDebugReportCallbackEXT"))
			LoadFunction("vkCreateDebugReportCallbackEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyDebugReportCallbackEXT"))
			LoadFunction("vkDestroyDebugReportCallbackEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDebugReportMessageEXT"))
			LoadFunction("vkDebugReportMessageEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDebugMarkerSetObjectTagEXT"))
			LoadFunction("vkDebugMarkerSetObjectTagEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDebugMarkerSetObjectNameEXT"))
			LoadFunction("vkDebugMarkerSetObjectNameEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDebugMarkerBeginEXT"))
			LoadFunction("vkCmdDebugMarkerBeginEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDebugMarkerEndEXT"))
			LoadFunction("vkCmdDebugMarkerEndEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDebugMarkerInsertEXT"))
			LoadFunction("vkCmdDebugMarkerInsertEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceVideoCapabilitiesKHR"))
			LoadFunction("vkGetPhysicalDeviceVideoCapabilitiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceVideoFormatPropertiesKHR"))
			LoadFunction("vkGetPhysicalDeviceVideoFormatPropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateVideoSessionKHR"))
			LoadFunction("vkCreateVideoSessionKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyVideoSessionKHR"))
			LoadFunction("vkDestroyVideoSessionKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetVideoSessionMemoryRequirementsKHR"))
			LoadFunction("vkGetVideoSessionMemoryRequirementsKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBindVideoSessionMemoryKHR"))
			LoadFunction("vkBindVideoSessionMemoryKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateVideoSessionParametersKHR"))
			LoadFunction("vkCreateVideoSessionParametersKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkUpdateVideoSessionParametersKHR"))
			LoadFunction("vkUpdateVideoSessionParametersKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyVideoSessionParametersKHR"))
			LoadFunction("vkDestroyVideoSessionParametersKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginVideoCodingKHR"))
			LoadFunction("vkCmdBeginVideoCodingKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndVideoCodingKHR"))
			LoadFunction("vkCmdEndVideoCodingKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdControlVideoCodingKHR"))
			LoadFunction("vkCmdControlVideoCodingKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDecodeVideoKHR"))
			LoadFunction("vkCmdDecodeVideoKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindTransformFeedbackBuffersEXT"))
			LoadFunction("vkCmdBindTransformFeedbackBuffersEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginTransformFeedbackEXT"))
			LoadFunction("vkCmdBeginTransformFeedbackEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndTransformFeedbackEXT"))
			LoadFunction("vkCmdEndTransformFeedbackEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginQueryIndexedEXT"))
			LoadFunction("vkCmdBeginQueryIndexedEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndQueryIndexedEXT"))
			LoadFunction("vkCmdEndQueryIndexedEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawIndirectByteCountEXT"))
			LoadFunction("vkCmdDrawIndirectByteCountEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateCuModuleNVX"))
			LoadFunction("vkCreateCuModuleNVX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateCuFunctionNVX"))
			LoadFunction("vkCreateCuFunctionNVX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyCuModuleNVX"))
			LoadFunction("vkDestroyCuModuleNVX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyCuFunctionNVX"))
			LoadFunction("vkDestroyCuFunctionNVX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCuLaunchKernelNVX"))
			LoadFunction("vkCmdCuLaunchKernelNVX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageViewHandleNVX"))
			LoadFunction("vkGetImageViewHandleNVX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageViewAddressNVX"))
			LoadFunction("vkGetImageViewAddressNVX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetShaderInfoAMD"))
			LoadFunction("vkGetShaderInfoAMD").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateStreamDescriptorSurfaceGGP"))
			LoadFunction("vkCreateStreamDescriptorSurfaceGGP").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceExternalImageFormatPropertiesNV"))
			LoadFunction("vkGetPhysicalDeviceExternalImageFormatPropertiesNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryWin32HandleNV"))
			LoadFunction("vkGetMemoryWin32HandleNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateViSurfaceNN"))
			LoadFunction("vkCreateViSurfaceNN").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryWin32HandleKHR"))
			LoadFunction("vkGetMemoryWin32HandleKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryWin32HandlePropertiesKHR"))
			LoadFunction("vkGetMemoryWin32HandlePropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryFdKHR"))
			LoadFunction("vkGetMemoryFdKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryFdPropertiesKHR"))
			LoadFunction("vkGetMemoryFdPropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkImportSemaphoreWin32HandleKHR"))
			LoadFunction("vkImportSemaphoreWin32HandleKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSemaphoreWin32HandleKHR"))
			LoadFunction("vkGetSemaphoreWin32HandleKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkImportSemaphoreFdKHR"))
			LoadFunction("vkImportSemaphoreFdKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSemaphoreFdKHR"))
			LoadFunction("vkGetSemaphoreFdKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdPushDescriptorSetKHR"))
			LoadFunction("vkCmdPushDescriptorSetKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginConditionalRenderingEXT"))
			LoadFunction("vkCmdBeginConditionalRenderingEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndConditionalRenderingEXT"))
			LoadFunction("vkCmdEndConditionalRenderingEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetViewportWScalingNV"))
			LoadFunction("vkCmdSetViewportWScalingNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkReleaseDisplayEXT"))
			LoadFunction("vkReleaseDisplayEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAcquireXlibDisplayEXT"))
			LoadFunction("vkAcquireXlibDisplayEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetRandROutputDisplayEXT"))
			LoadFunction("vkGetRandROutputDisplayEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSurfaceCapabilities2EXT"))
			LoadFunction("vkGetPhysicalDeviceSurfaceCapabilities2EXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDisplayPowerControlEXT"))
			LoadFunction("vkDisplayPowerControlEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkRegisterDeviceEventEXT"))
			LoadFunction("vkRegisterDeviceEventEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkRegisterDisplayEventEXT"))
			LoadFunction("vkRegisterDisplayEventEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSwapchainCounterEXT"))
			LoadFunction("vkGetSwapchainCounterEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetRefreshCycleDurationGOOGLE"))
			LoadFunction("vkGetRefreshCycleDurationGOOGLE").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPastPresentationTimingGOOGLE"))
			LoadFunction("vkGetPastPresentationTimingGOOGLE").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDiscardRectangleEXT"))
			LoadFunction("vkCmdSetDiscardRectangleEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDiscardRectangleEnableEXT"))
			LoadFunction("vkCmdSetDiscardRectangleEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDiscardRectangleModeEXT"))
			LoadFunction("vkCmdSetDiscardRectangleModeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetHdrMetadataEXT"))
			LoadFunction("vkSetHdrMetadataEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSwapchainStatusKHR"))
			LoadFunction("vkGetSwapchainStatusKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkImportFenceWin32HandleKHR"))
			LoadFunction("vkImportFenceWin32HandleKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetFenceWin32HandleKHR"))
			LoadFunction("vkGetFenceWin32HandleKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkImportFenceFdKHR"))
			LoadFunction("vkImportFenceFdKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetFenceFdKHR"))
			LoadFunction("vkGetFenceFdKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR"))
			LoadFunction("vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR"))
			LoadFunction("vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAcquireProfilingLockKHR"))
			LoadFunction("vkAcquireProfilingLockKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkReleaseProfilingLockKHR"))
			LoadFunction("vkReleaseProfilingLockKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSurfaceCapabilities2KHR"))
			LoadFunction("vkGetPhysicalDeviceSurfaceCapabilities2KHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSurfaceFormats2KHR"))
			LoadFunction("vkGetPhysicalDeviceSurfaceFormats2KHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceDisplayProperties2KHR"))
			LoadFunction("vkGetPhysicalDeviceDisplayProperties2KHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceDisplayPlaneProperties2KHR"))
			LoadFunction("vkGetPhysicalDeviceDisplayPlaneProperties2KHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDisplayModeProperties2KHR"))
			LoadFunction("vkGetDisplayModeProperties2KHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDisplayPlaneCapabilities2KHR"))
			LoadFunction("vkGetDisplayPlaneCapabilities2KHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateIOSSurfaceMVK"))
			LoadFunction("vkCreateIOSSurfaceMVK").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateMacOSSurfaceMVK"))
			LoadFunction("vkCreateMacOSSurfaceMVK").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetDebugUtilsObjectNameEXT"))
			LoadFunction("vkSetDebugUtilsObjectNameEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetDebugUtilsObjectTagEXT"))
			LoadFunction("vkSetDebugUtilsObjectTagEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueueBeginDebugUtilsLabelEXT"))
			LoadFunction("vkQueueBeginDebugUtilsLabelEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueueEndDebugUtilsLabelEXT"))
			LoadFunction("vkQueueEndDebugUtilsLabelEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueueInsertDebugUtilsLabelEXT"))
			LoadFunction("vkQueueInsertDebugUtilsLabelEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBeginDebugUtilsLabelEXT"))
			LoadFunction("vkCmdBeginDebugUtilsLabelEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEndDebugUtilsLabelEXT"))
			LoadFunction("vkCmdEndDebugUtilsLabelEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdInsertDebugUtilsLabelEXT"))
			LoadFunction("vkCmdInsertDebugUtilsLabelEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDebugUtilsMessengerEXT"))
			LoadFunction("vkCreateDebugUtilsMessengerEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyDebugUtilsMessengerEXT"))
			LoadFunction("vkDestroyDebugUtilsMessengerEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSubmitDebugUtilsMessageEXT"))
			LoadFunction("vkSubmitDebugUtilsMessageEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetAndroidHardwareBufferPropertiesANDROID"))
			LoadFunction("vkGetAndroidHardwareBufferPropertiesANDROID").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryAndroidHardwareBufferANDROID"))
			LoadFunction("vkGetMemoryAndroidHardwareBufferANDROID").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetSampleLocationsEXT"))
			LoadFunction("vkCmdSetSampleLocationsEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceMultisamplePropertiesEXT"))
			LoadFunction("vkGetPhysicalDeviceMultisamplePropertiesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateAccelerationStructureKHR"))
			LoadFunction("vkCreateAccelerationStructureKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyAccelerationStructureKHR"))
			LoadFunction("vkDestroyAccelerationStructureKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBuildAccelerationStructuresKHR"))
			LoadFunction("vkCmdBuildAccelerationStructuresKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBuildAccelerationStructuresIndirectKHR"))
			LoadFunction("vkCmdBuildAccelerationStructuresIndirectKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBuildAccelerationStructuresKHR"))
			LoadFunction("vkBuildAccelerationStructuresKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCopyAccelerationStructureKHR"))
			LoadFunction("vkCopyAccelerationStructureKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCopyAccelerationStructureToMemoryKHR"))
			LoadFunction("vkCopyAccelerationStructureToMemoryKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCopyMemoryToAccelerationStructureKHR"))
			LoadFunction("vkCopyMemoryToAccelerationStructureKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkWriteAccelerationStructuresPropertiesKHR"))
			LoadFunction("vkWriteAccelerationStructuresPropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyAccelerationStructureKHR"))
			LoadFunction("vkCmdCopyAccelerationStructureKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyAccelerationStructureToMemoryKHR"))
			LoadFunction("vkCmdCopyAccelerationStructureToMemoryKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyMemoryToAccelerationStructureKHR"))
			LoadFunction("vkCmdCopyMemoryToAccelerationStructureKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetAccelerationStructureDeviceAddressKHR"))
			LoadFunction("vkGetAccelerationStructureDeviceAddressKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdWriteAccelerationStructuresPropertiesKHR"))
			LoadFunction("vkCmdWriteAccelerationStructuresPropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceAccelerationStructureCompatibilityKHR"))
			LoadFunction("vkGetDeviceAccelerationStructureCompatibilityKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetAccelerationStructureBuildSizesKHR"))
			LoadFunction("vkGetAccelerationStructureBuildSizesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdTraceRaysKHR"))
			LoadFunction("vkCmdTraceRaysKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateRayTracingPipelinesKHR"))
			LoadFunction("vkCreateRayTracingPipelinesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetRayTracingShaderGroupHandlesKHR"))
			LoadFunction("vkGetRayTracingShaderGroupHandlesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetRayTracingCaptureReplayShaderGroupHandlesKHR"))
			LoadFunction("vkGetRayTracingCaptureReplayShaderGroupHandlesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdTraceRaysIndirectKHR"))
			LoadFunction("vkCmdTraceRaysIndirectKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetRayTracingShaderGroupStackSizeKHR"))
			LoadFunction("vkGetRayTracingShaderGroupStackSizeKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetRayTracingPipelineStackSizeKHR"))
			LoadFunction("vkCmdSetRayTracingPipelineStackSizeKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageDrmFormatModifierPropertiesEXT"))
			LoadFunction("vkGetImageDrmFormatModifierPropertiesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateValidationCacheEXT"))
			LoadFunction("vkCreateValidationCacheEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyValidationCacheEXT"))
			LoadFunction("vkDestroyValidationCacheEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkMergeValidationCachesEXT"))
			LoadFunction("vkMergeValidationCachesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetValidationCacheDataEXT"))
			LoadFunction("vkGetValidationCacheDataEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindShadingRateImageNV"))
			LoadFunction("vkCmdBindShadingRateImageNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetViewportShadingRatePaletteNV"))
			LoadFunction("vkCmdSetViewportShadingRatePaletteNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCoarseSampleOrderNV"))
			LoadFunction("vkCmdSetCoarseSampleOrderNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateAccelerationStructureNV"))
			LoadFunction("vkCreateAccelerationStructureNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyAccelerationStructureNV"))
			LoadFunction("vkDestroyAccelerationStructureNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetAccelerationStructureMemoryRequirementsNV"))
			LoadFunction("vkGetAccelerationStructureMemoryRequirementsNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBindAccelerationStructureMemoryNV"))
			LoadFunction("vkBindAccelerationStructureMemoryNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBuildAccelerationStructureNV"))
			LoadFunction("vkCmdBuildAccelerationStructureNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyAccelerationStructureNV"))
			LoadFunction("vkCmdCopyAccelerationStructureNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdTraceRaysNV"))
			LoadFunction("vkCmdTraceRaysNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateRayTracingPipelinesNV"))
			LoadFunction("vkCreateRayTracingPipelinesNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetAccelerationStructureHandleNV"))
			LoadFunction("vkGetAccelerationStructureHandleNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdWriteAccelerationStructuresPropertiesNV"))
			LoadFunction("vkCmdWriteAccelerationStructuresPropertiesNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCompileDeferredNV"))
			LoadFunction("vkCompileDeferredNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryHostPointerPropertiesEXT"))
			LoadFunction("vkGetMemoryHostPointerPropertiesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdWriteBufferMarkerAMD"))
			LoadFunction("vkCmdWriteBufferMarkerAMD").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceCalibrateableTimeDomainsEXT"))
			LoadFunction("vkGetPhysicalDeviceCalibrateableTimeDomainsEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetCalibratedTimestampsEXT"))
			LoadFunction("vkGetCalibratedTimestampsEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawMeshTasksNV"))
			LoadFunction("vkCmdDrawMeshTasksNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawMeshTasksIndirectNV"))
			LoadFunction("vkCmdDrawMeshTasksIndirectNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawMeshTasksIndirectCountNV"))
			LoadFunction("vkCmdDrawMeshTasksIndirectCountNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetExclusiveScissorEnableNV"))
			LoadFunction("vkCmdSetExclusiveScissorEnableNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetExclusiveScissorNV"))
			LoadFunction("vkCmdSetExclusiveScissorNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCheckpointNV"))
			LoadFunction("vkCmdSetCheckpointNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetQueueCheckpointDataNV"))
			LoadFunction("vkGetQueueCheckpointDataNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkInitializePerformanceApiINTEL"))
			LoadFunction("vkInitializePerformanceApiINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkUninitializePerformanceApiINTEL"))
			LoadFunction("vkUninitializePerformanceApiINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetPerformanceMarkerINTEL"))
			LoadFunction("vkCmdSetPerformanceMarkerINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetPerformanceStreamMarkerINTEL"))
			LoadFunction("vkCmdSetPerformanceStreamMarkerINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetPerformanceOverrideINTEL"))
			LoadFunction("vkCmdSetPerformanceOverrideINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAcquirePerformanceConfigurationINTEL"))
			LoadFunction("vkAcquirePerformanceConfigurationINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkReleasePerformanceConfigurationINTEL"))
			LoadFunction("vkReleasePerformanceConfigurationINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkQueueSetPerformanceConfigurationINTEL"))
			LoadFunction("vkQueueSetPerformanceConfigurationINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPerformanceParameterINTEL"))
			LoadFunction("vkGetPerformanceParameterINTEL").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetLocalDimmingAMD"))
			LoadFunction("vkSetLocalDimmingAMD").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateImagePipeSurfaceFUCHSIA"))
			LoadFunction("vkCreateImagePipeSurfaceFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateMetalSurfaceEXT"))
			LoadFunction("vkCreateMetalSurfaceEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceFragmentShadingRatesKHR"))
			LoadFunction("vkGetPhysicalDeviceFragmentShadingRatesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetFragmentShadingRateKHR"))
			LoadFunction("vkCmdSetFragmentShadingRateKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkWaitForPresentKHR"))
			LoadFunction("vkWaitForPresentKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceCooperativeMatrixPropertiesNV"))
			LoadFunction("vkGetPhysicalDeviceCooperativeMatrixPropertiesNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV"))
			LoadFunction("vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSurfacePresentModes2EXT"))
			LoadFunction("vkGetPhysicalDeviceSurfacePresentModes2EXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAcquireFullScreenExclusiveModeEXT"))
			LoadFunction("vkAcquireFullScreenExclusiveModeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkReleaseFullScreenExclusiveModeEXT"))
			LoadFunction("vkReleaseFullScreenExclusiveModeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateHeadlessSurfaceEXT"))
			LoadFunction("vkCreateHeadlessSurfaceEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetLineStippleEXT"))
			LoadFunction("vkCmdSetLineStippleEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDeferredOperationKHR"))
			LoadFunction("vkCreateDeferredOperationKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyDeferredOperationKHR"))
			LoadFunction("vkDestroyDeferredOperationKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeferredOperationMaxConcurrencyKHR"))
			LoadFunction("vkGetDeferredOperationMaxConcurrencyKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeferredOperationResultKHR"))
			LoadFunction("vkGetDeferredOperationResultKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDeferredOperationJoinKHR"))
			LoadFunction("vkDeferredOperationJoinKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPipelineExecutablePropertiesKHR"))
			LoadFunction("vkGetPipelineExecutablePropertiesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPipelineExecutableStatisticsKHR"))
			LoadFunction("vkGetPipelineExecutableStatisticsKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPipelineExecutableInternalRepresentationsKHR"))
			LoadFunction("vkGetPipelineExecutableInternalRepresentationsKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkMapMemory2KHR"))
			LoadFunction("vkMapMemory2KHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkUnmapMemory2KHR"))
			LoadFunction("vkUnmapMemory2KHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkReleaseSwapchainImagesEXT"))
			LoadFunction("vkReleaseSwapchainImagesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetGeneratedCommandsMemoryRequirementsNV"))
			LoadFunction("vkGetGeneratedCommandsMemoryRequirementsNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdPreprocessGeneratedCommandsNV"))
			LoadFunction("vkCmdPreprocessGeneratedCommandsNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdExecuteGeneratedCommandsNV"))
			LoadFunction("vkCmdExecuteGeneratedCommandsNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindPipelineShaderGroupNV"))
			LoadFunction("vkCmdBindPipelineShaderGroupNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateIndirectCommandsLayoutNV"))
			LoadFunction("vkCreateIndirectCommandsLayoutNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyIndirectCommandsLayoutNV"))
			LoadFunction("vkDestroyIndirectCommandsLayoutNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAcquireDrmDisplayEXT"))
			LoadFunction("vkAcquireDrmDisplayEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDrmDisplayEXT"))
			LoadFunction("vkGetDrmDisplayEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdEncodeVideoKHR"))
			LoadFunction("vkCmdEncodeVideoKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdRefreshObjectsKHR"))
			LoadFunction("vkCmdRefreshObjectsKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceRefreshableObjectTypesKHR"))
			LoadFunction("vkGetPhysicalDeviceRefreshableObjectTypesKHR").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkExportMetalObjectsEXT"))
			LoadFunction("vkExportMetalObjectsEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDescriptorSetLayoutSizeEXT"))
			LoadFunction("vkGetDescriptorSetLayoutSizeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDescriptorSetLayoutBindingOffsetEXT"))
			LoadFunction("vkGetDescriptorSetLayoutBindingOffsetEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDescriptorEXT"))
			LoadFunction("vkGetDescriptorEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindDescriptorBuffersEXT"))
			LoadFunction("vkCmdBindDescriptorBuffersEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDescriptorBufferOffsetsEXT"))
			LoadFunction("vkCmdSetDescriptorBufferOffsetsEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindDescriptorBufferEmbeddedSamplersEXT"))
			LoadFunction("vkCmdBindDescriptorBufferEmbeddedSamplersEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetBufferOpaqueCaptureDescriptorDataEXT"))
			LoadFunction("vkGetBufferOpaqueCaptureDescriptorDataEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageOpaqueCaptureDescriptorDataEXT"))
			LoadFunction("vkGetImageOpaqueCaptureDescriptorDataEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageViewOpaqueCaptureDescriptorDataEXT"))
			LoadFunction("vkGetImageViewOpaqueCaptureDescriptorDataEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSamplerOpaqueCaptureDescriptorDataEXT"))
			LoadFunction("vkGetSamplerOpaqueCaptureDescriptorDataEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetFragmentShadingRateEnumNV"))
			LoadFunction("vkCmdSetFragmentShadingRateEnumNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawMeshTasksEXT"))
			LoadFunction("vkCmdDrawMeshTasksEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawMeshTasksIndirectEXT"))
			LoadFunction("vkCmdDrawMeshTasksIndirectEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawMeshTasksIndirectCountEXT"))
			LoadFunction("vkCmdDrawMeshTasksIndirectCountEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetImageSubresourceLayout2EXT"))
			LoadFunction("vkGetImageSubresourceLayout2EXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceFaultInfoEXT"))
			LoadFunction("vkGetDeviceFaultInfoEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkAcquireWinrtDisplayNV"))
			LoadFunction("vkAcquireWinrtDisplayNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetWinrtDisplayNV"))
			LoadFunction("vkGetWinrtDisplayNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateDirectFBSurfaceEXT"))
			LoadFunction("vkCreateDirectFBSurfaceEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceDirectFBPresentationSupportEXT"))
			LoadFunction("vkGetPhysicalDeviceDirectFBPresentationSupportEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetVertexInputEXT"))
			LoadFunction("vkCmdSetVertexInputEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryZirconHandleFUCHSIA"))
			LoadFunction("vkGetMemoryZirconHandleFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryZirconHandlePropertiesFUCHSIA"))
			LoadFunction("vkGetMemoryZirconHandlePropertiesFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkImportSemaphoreZirconHandleFUCHSIA"))
			LoadFunction("vkImportSemaphoreZirconHandleFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSemaphoreZirconHandleFUCHSIA"))
			LoadFunction("vkGetSemaphoreZirconHandleFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateBufferCollectionFUCHSIA"))
			LoadFunction("vkCreateBufferCollectionFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetBufferCollectionImageConstraintsFUCHSIA"))
			LoadFunction("vkSetBufferCollectionImageConstraintsFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetBufferCollectionBufferConstraintsFUCHSIA"))
			LoadFunction("vkSetBufferCollectionBufferConstraintsFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyBufferCollectionFUCHSIA"))
			LoadFunction("vkDestroyBufferCollectionFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetBufferCollectionPropertiesFUCHSIA"))
			LoadFunction("vkGetBufferCollectionPropertiesFUCHSIA").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI"))
			LoadFunction("vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSubpassShadingHUAWEI"))
			LoadFunction("vkCmdSubpassShadingHUAWEI").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindInvocationMaskHUAWEI"))
			LoadFunction("vkCmdBindInvocationMaskHUAWEI").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemoryRemoteAddressNV"))
			LoadFunction("vkGetMemoryRemoteAddressNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPipelinePropertiesEXT"))
			LoadFunction("vkGetPipelinePropertiesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetFenceSciSyncFenceNV"))
			LoadFunction("vkGetFenceSciSyncFenceNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetFenceSciSyncObjNV"))
			LoadFunction("vkGetFenceSciSyncObjNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkImportFenceSciSyncFenceNV"))
			LoadFunction("vkImportFenceSciSyncFenceNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkImportFenceSciSyncObjNV"))
			LoadFunction("vkImportFenceSciSyncObjNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSciSyncAttributesNV"))
			LoadFunction("vkGetPhysicalDeviceSciSyncAttributesNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetSemaphoreSciSyncObjNV"))
			LoadFunction("vkGetSemaphoreSciSyncObjNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkImportSemaphoreSciSyncObjNV"))
			LoadFunction("vkImportSemaphoreSciSyncObjNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMemorySciBufNV"))
			LoadFunction("vkGetMemorySciBufNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV"))
			LoadFunction("vkGetPhysicalDeviceExternalMemorySciBufPropertiesNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceSciBufAttributesNV"))
			LoadFunction("vkGetPhysicalDeviceSciBufAttributesNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetPatchControlPointsEXT"))
			LoadFunction("vkCmdSetPatchControlPointsEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetLogicOpEXT"))
			LoadFunction("vkCmdSetLogicOpEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateScreenSurfaceQNX"))
			LoadFunction("vkCreateScreenSurfaceQNX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceScreenPresentationSupportQNX"))
			LoadFunction("vkGetPhysicalDeviceScreenPresentationSupportQNX").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetColorWriteEnableEXT"))
			LoadFunction("vkCmdSetColorWriteEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawMultiEXT"))
			LoadFunction("vkCmdDrawMultiEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawMultiIndexedEXT"))
			LoadFunction("vkCmdDrawMultiIndexedEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateMicromapEXT"))
			LoadFunction("vkCreateMicromapEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyMicromapEXT"))
			LoadFunction("vkDestroyMicromapEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBuildMicromapsEXT"))
			LoadFunction("vkCmdBuildMicromapsEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBuildMicromapsEXT"))
			LoadFunction("vkBuildMicromapsEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCopyMicromapEXT"))
			LoadFunction("vkCopyMicromapEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCopyMicromapToMemoryEXT"))
			LoadFunction("vkCopyMicromapToMemoryEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCopyMemoryToMicromapEXT"))
			LoadFunction("vkCopyMemoryToMicromapEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkWriteMicromapsPropertiesEXT"))
			LoadFunction("vkWriteMicromapsPropertiesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyMicromapEXT"))
			LoadFunction("vkCmdCopyMicromapEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyMicromapToMemoryEXT"))
			LoadFunction("vkCmdCopyMicromapToMemoryEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyMemoryToMicromapEXT"))
			LoadFunction("vkCmdCopyMemoryToMicromapEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdWriteMicromapsPropertiesEXT"))
			LoadFunction("vkCmdWriteMicromapsPropertiesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDeviceMicromapCompatibilityEXT"))
			LoadFunction("vkGetDeviceMicromapCompatibilityEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetMicromapBuildSizesEXT"))
			LoadFunction("vkGetMicromapBuildSizesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawClusterHUAWEI"))
			LoadFunction("vkCmdDrawClusterHUAWEI").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDrawClusterIndirectHUAWEI"))
			LoadFunction("vkCmdDrawClusterIndirectHUAWEI").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkSetDeviceMemoryPriorityEXT"))
			LoadFunction("vkSetDeviceMemoryPriorityEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDescriptorSetLayoutHostMappingInfoVALVE"))
			LoadFunction("vkGetDescriptorSetLayoutHostMappingInfoVALVE").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDescriptorSetHostMappingVALVE"))
			LoadFunction("vkGetDescriptorSetHostMappingVALVE").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyMemoryIndirectNV"))
			LoadFunction("vkCmdCopyMemoryIndirectNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdCopyMemoryToImageIndirectNV"))
			LoadFunction("vkCmdCopyMemoryToImageIndirectNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDecompressMemoryNV"))
			LoadFunction("vkCmdDecompressMemoryNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdDecompressMemoryIndirectCountNV"))
			LoadFunction("vkCmdDecompressMemoryIndirectCountNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetTessellationDomainOriginEXT"))
			LoadFunction("vkCmdSetTessellationDomainOriginEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthClampEnableEXT"))
			LoadFunction("vkCmdSetDepthClampEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetPolygonModeEXT"))
			LoadFunction("vkCmdSetPolygonModeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetRasterizationSamplesEXT"))
			LoadFunction("vkCmdSetRasterizationSamplesEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetSampleMaskEXT"))
			LoadFunction("vkCmdSetSampleMaskEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetAlphaToCoverageEnableEXT"))
			LoadFunction("vkCmdSetAlphaToCoverageEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetAlphaToOneEnableEXT"))
			LoadFunction("vkCmdSetAlphaToOneEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetLogicOpEnableEXT"))
			LoadFunction("vkCmdSetLogicOpEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetColorBlendEnableEXT"))
			LoadFunction("vkCmdSetColorBlendEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetColorBlendEquationEXT"))
			LoadFunction("vkCmdSetColorBlendEquationEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetColorWriteMaskEXT"))
			LoadFunction("vkCmdSetColorWriteMaskEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetRasterizationStreamEXT"))
			LoadFunction("vkCmdSetRasterizationStreamEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetConservativeRasterizationModeEXT"))
			LoadFunction("vkCmdSetConservativeRasterizationModeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetExtraPrimitiveOverestimationSizeEXT"))
			LoadFunction("vkCmdSetExtraPrimitiveOverestimationSizeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthClipEnableEXT"))
			LoadFunction("vkCmdSetDepthClipEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetSampleLocationsEnableEXT"))
			LoadFunction("vkCmdSetSampleLocationsEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetColorBlendAdvancedEXT"))
			LoadFunction("vkCmdSetColorBlendAdvancedEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetProvokingVertexModeEXT"))
			LoadFunction("vkCmdSetProvokingVertexModeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetLineRasterizationModeEXT"))
			LoadFunction("vkCmdSetLineRasterizationModeEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetLineStippleEnableEXT"))
			LoadFunction("vkCmdSetLineStippleEnableEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetDepthClipNegativeOneToOneEXT"))
			LoadFunction("vkCmdSetDepthClipNegativeOneToOneEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetViewportWScalingEnableNV"))
			LoadFunction("vkCmdSetViewportWScalingEnableNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetViewportSwizzleNV"))
			LoadFunction("vkCmdSetViewportSwizzleNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCoverageToColorEnableNV"))
			LoadFunction("vkCmdSetCoverageToColorEnableNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCoverageToColorLocationNV"))
			LoadFunction("vkCmdSetCoverageToColorLocationNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCoverageModulationModeNV"))
			LoadFunction("vkCmdSetCoverageModulationModeNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCoverageModulationTableEnableNV"))
			LoadFunction("vkCmdSetCoverageModulationTableEnableNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCoverageModulationTableNV"))
			LoadFunction("vkCmdSetCoverageModulationTableNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetShadingRateImageEnableNV"))
			LoadFunction("vkCmdSetShadingRateImageEnableNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetRepresentativeFragmentTestEnableNV"))
			LoadFunction("vkCmdSetRepresentativeFragmentTestEnableNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetCoverageReductionModeNV"))
			LoadFunction("vkCmdSetCoverageReductionModeNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetShaderModuleIdentifierEXT"))
			LoadFunction("vkGetShaderModuleIdentifierEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetShaderModuleCreateInfoIdentifierEXT"))
			LoadFunction("vkGetShaderModuleCreateInfoIdentifierEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetPhysicalDeviceOpticalFlowImageFormatsNV"))
			LoadFunction("vkGetPhysicalDeviceOpticalFlowImageFormatsNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateOpticalFlowSessionNV"))
			LoadFunction("vkCreateOpticalFlowSessionNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyOpticalFlowSessionNV"))
			LoadFunction("vkDestroyOpticalFlowSessionNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkBindOpticalFlowSessionImageNV"))
			LoadFunction("vkBindOpticalFlowSessionImageNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdOpticalFlowExecuteNV"))
			LoadFunction("vkCmdOpticalFlowExecuteNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateShadersEXT"))
			LoadFunction("vkCreateShadersEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroyShaderEXT"))
			LoadFunction("vkDestroyShaderEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetShaderBinaryDataEXT"))
			LoadFunction("vkGetShaderBinaryDataEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdBindShadersEXT"))
			LoadFunction("vkCmdBindShadersEXT").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetFramebufferTilePropertiesQCOM"))
			LoadFunction("vkGetFramebufferTilePropertiesQCOM").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkGetDynamicRenderingTilePropertiesQCOM"))
			LoadFunction("vkGetDynamicRenderingTilePropertiesQCOM").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCreateSemaphoreSciSyncPoolNV"))
			LoadFunction("vkCreateSemaphoreSciSyncPoolNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkDestroySemaphoreSciSyncPoolNV"))
			LoadFunction("vkDestroySemaphoreSciSyncPoolNV").IgnoreError();

		if(excludeFunctions == null || !excludeFunctions.Contains("vkCmdSetAttachmentFeedbackLoopEnableEXT"))
			LoadFunction("vkCmdSetAttachmentFeedbackLoopEnableEXT").IgnoreError();

	}

	public static void LoadFunction<T>(StringView name, out T funcPtr)
	{
		mNativeLib.LoadFunction(name, out funcPtr);
	}
}
