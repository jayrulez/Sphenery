using System.Threading;
using System.Collections;
using Bulkan;
using System;
using Sphenery.RHI.Helpers;
using static Bulkan.VulkanNative;
namespace Sphenery.RHI.Vulkan;

static
{
	public static Result CreateDeviceVK(DeviceLogger logger, DeviceAllocator<uint8> allocator, DeviceCreationDesc deviceCreationDesc, out IDevice device)
	{
		device = ?;
		DeviceVK implementation = Allocate!<DeviceVK>(allocator, logger, allocator);

		readonly Result res = implementation.Create(deviceCreationDesc);

		if (res == Result.SUCCESS)
		{
			device = implementation;
			return Result.SUCCESS;
		}

		Deallocate!(allocator, implementation);
		return res;
	}

	public static Result CreateDeviceVK(DeviceLogger logger, DeviceAllocator<uint8> allocator,DeviceCreationVulkanDesc deviceCreationDesc, out IDevice device)
	{
		device = ?;

		DeviceVK implementation = Allocate!<DeviceVK>(allocator, logger, allocator);
		readonly Result res = implementation.Create(deviceCreationDesc);

		if (res == Result.SUCCESS)
		{
			device = implementation;
			return Result.SUCCESS;
		}

		Deallocate!(allocator, implementation);
		return res;
	}

	public static void DestroyDeviceVK(IDevice device)
	{
		DeviceVK implementation = (DeviceVK)device;

		implementation.Destroy();
	}
}

static
{
	public const uint32 INVALID_FAMILY_INDEX = uint32(-1);

	[Inline] public static bool IsExtensionSupported(char8* ext, List<VkExtensionProperties> list)
	{
		for (var e in ref list)
		{
			if (String.Equals(ext, &e.extensionName))
				return true;
		}

		return false;
	}

	public static void* vkAllocateHostMemory(void* pUserData, uint size, uint alignment, VkSystemAllocationScope allocationScope)
	{
		//MaybeUnused(allocationScope);

		DeviceAllocator<uint8> stdAllocator = (DeviceAllocator<uint8>)Internal.UnsafeCastToObject(pUserData);
		readonly var lowLevelAllocator = stdAllocator.GetInterface();

		return lowLevelAllocator.Allocate(lowLevelAllocator.userArg, size, alignment);
	}

	public static void* vkReallocateHostMemory(void* pUserData, void* pOriginal, uint size, uint alignment, VkSystemAllocationScope allocationScope)
	{
		//MaybeUnused(allocationScope);

		DeviceAllocator<uint8> stdAllocator = (DeviceAllocator<uint8>)Internal.UnsafeCastToObject(pUserData);
		readonly var lowLevelAllocator = stdAllocator.GetInterface();

		return lowLevelAllocator.Reallocate(lowLevelAllocator.userArg, pOriginal, size, alignment);
	}

	public static void vkFreeHostMemory(void* pUserData, void* pMemory)
	{
		DeviceAllocator<uint8> stdAllocator = (DeviceAllocator<uint8>)Internal.UnsafeCastToObject(pUserData);
		readonly var lowLevelAllocator = stdAllocator.GetInterface();

		lowLevelAllocator.Free(lowLevelAllocator.userArg, pMemory);
	}

	public static void vkHostMemoryInternalAllocationNotification(void* pUserData, uint size, VkInternalAllocationType allocationType,
		VkSystemAllocationScope allocationScope)
	{
		//MaybeUnused(pUserData);
		//MaybeUnused(size);
		//MaybeUnused(allocationType);
		//MaybeUnused(allocationScope);
	}

	public static void vkHostMemoryInternalFreeNotification(void* pUserData, uint size, VkInternalAllocationType allocationType,
		VkSystemAllocationScope allocationScope)
	{
		//MaybeUnused(pUserData);
		//MaybeUnused(size);
		//MaybeUnused(allocationType);
		//MaybeUnused(allocationScope);
	}

	private static char8* GetObjectTypeName(VkObjectType objectType)
	{
		switch (objectType)
		{
		case .VK_OBJECT_TYPE_INSTANCE:
			return "VkInstance";
		case .VK_OBJECT_TYPE_PHYSICAL_DEVICE:
			return "VkPhysicalDevice";
		case .VK_OBJECT_TYPE_DEVICE:
			return "VkDevice";
		case .VK_OBJECT_TYPE_QUEUE:
			return "VkQueue";
		case .VK_OBJECT_TYPE_SEMAPHORE:
			return "VkSemaphore";
		case .VK_OBJECT_TYPE_COMMAND_BUFFER:
			return "VkCommandBuffer";
		case .VK_OBJECT_TYPE_FENCE:
			return "VkFence";
		case .VK_OBJECT_TYPE_DEVICE_MEMORY:
			return "VkDeviceMemory";
		case .VK_OBJECT_TYPE_BUFFER:
			return "VkBuffer";
		case .VK_OBJECT_TYPE_IMAGE:
			return "VkImage";
		case .VK_OBJECT_TYPE_EVENT:
			return "VkEvent";
		case .VK_OBJECT_TYPE_QUERY_POOL:
			return "VkQueryPool";
		case .VK_OBJECT_TYPE_BUFFER_VIEW:
			return "VkBufferView";
		case .VK_OBJECT_TYPE_IMAGE_VIEW:
			return "VkImageView";
		case .VK_OBJECT_TYPE_SHADER_MODULE:
			return "VkShaderModule";
		case .VK_OBJECT_TYPE_PIPELINE_CACHE:
			return "VkPipelineCache";
		case .VK_OBJECT_TYPE_PIPELINE_LAYOUT:
			return "VkPipelineLayout";
		case .VK_OBJECT_TYPE_RENDER_PASS:
			return "VkRenderPass";
		case .VK_OBJECT_TYPE_PIPELINE:
			return "VkPipeline";
		case .VK_OBJECT_TYPE_DESCRIPTOR_SET_LAYOUT:
			return "VkDescriptorSetLayout";
		case .VK_OBJECT_TYPE_SAMPLER:
			return "VkSampler";
		case .VK_OBJECT_TYPE_DESCRIPTOR_POOL:
			return "VkDescriptorPool";
		case .VK_OBJECT_TYPE_DESCRIPTOR_SET:
			return "VkDescriptorSet";
		case .VK_OBJECT_TYPE_FRAMEBUFFER:
			return "VkFramebuffer";
		case .VK_OBJECT_TYPE_COMMAND_POOL:
			return "VkCommandPool";
		case .VK_OBJECT_TYPE_SAMPLER_YCBCR_CONVERSION:
			return "VkSamplerYcbcrConversion";
		case .VK_OBJECT_TYPE_DESCRIPTOR_UPDATE_TEMPLATE:
			return "VkDescriptorUpdateTemplate";
		case .VK_OBJECT_TYPE_SURFACE_KHR:
			return "VkSurfaceKHR";
		case .VK_OBJECT_TYPE_SWAPCHAIN_KHR:
			return "VkSwapchainKHR";
		case .VK_OBJECT_TYPE_DISPLAY_KHR:
			return "VkDisplayKHR";
		case .VK_OBJECT_TYPE_DISPLAY_MODE_KHR:
			return "VkDisplayModeKHR";
		case .VK_OBJECT_TYPE_DEBUG_REPORT_CALLBACK_EXT:
			return "VkDebugReportCallbackEXT";
		case .VK_OBJECT_TYPE_DEBUG_UTILS_MESSENGER_EXT:
			return "VkDebugUtilsMessengerEXT";
		case .VK_OBJECT_TYPE_ACCELERATION_STRUCTURE_KHR:
			return "VkAccelerationStructureKHR";
		case .VK_OBJECT_TYPE_VALIDATION_CACHE_EXT:
			return "VkValidationCacheEXT";
		case .VK_OBJECT_TYPE_DEFERRED_OPERATION_KHR:
			return "VkDeferredOperationKHR";
		default:
			return "unknown";
		}
	}

	public static VkBool32 DebugUtilsMessenger(
		VkDebugUtilsMessageSeverityFlagsEXT messageSeverity, /*VkDebugUtilsMessageTypeFlagsEXT*/ uint32 messageType,
		VkDebugUtilsMessengerCallbackDataEXT* callbackData,
		void* userData)
	{
		var messageSeverity;
		//MaybeUnused(messageType);

		bool isError = false;
		bool isWarning = false;

		/*
		// TODO: convert an error to a warning as
		if (callbackData->messageIdNumber == <message ID>)
			messageSeverity = VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT;
		*/

		char8* type = "unknown";
		switch (messageSeverity)
		{
		case .VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT:
			type = "verbose";
			break;
		case .VK_DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT:
			type = "info";
			break;
		case .VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT:
			type = "warning";
			isWarning = true;
			break;
		case .VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT:
			type = "error";
			isError = true;
			break;

		default: break;
		}

		if (!isWarning && !isError)
			return VK_FALSE;

		DeviceVK device = (DeviceVK)Internal.UnsafeCastToObject(userData);

		String message = Allocate!<String>(device.GetAllocator());
		defer { Deallocate!(device.GetAllocator(), message); }

		message.AppendF("{0} {1} {2}", callbackData.messageIdNumber, scope String(callbackData.pMessageIdName), scope String(callbackData.pMessage));

		// vkCmdCopyBufferToImage: For optimal performance VkImage 0x984b920000000104 layout should be VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL instead of GENERAL.
		if (callbackData.messageIdNumber == 1303270965)
			return VK_FALSE;

		if (messageSeverity == .VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT)
		{
			message.AppendF("\nObjectNum: {0}", callbackData.objectCount);

			for (uint32 i = 0; i < callbackData.objectCount; i++)
			{
				readonly ref VkDebugUtilsObjectNameInfoEXT object = ref callbackData.pObjects[i];
				message.AppendF("\n\tObject {0} {1} ({2:2X})", object.pObjectName != null ? scope String(object.pObjectName) : "", GetObjectTypeName(object.objectType), object.objectHandle);
			}

			REPORT_ERROR(device.GetLogger(), "DebugUtilsMessenger: {0}, {1}", scope String(type), message);
		}
		else if (messageSeverity == .VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT)
		{
			REPORT_WARNING(device.GetLogger(), "DebugUtilsMessenger: {0}, {1}", scope String(type), message);
		}
		else
		{
			REPORT_INFO(device.GetLogger(), "DebugUtilsMessenger: {0}, {1}", scope String(type), message);
		}

		return VK_FALSE;
	}
}

class DeviceVK : IDevice, IDeviceVK
{
	private readonly DeviceLogger m_Logger;
	private readonly DeviceAllocator<uint8> m_Allocator;

	private Monitor m_Monitor = new .() ~ delete _;
	private List<VkPhysicalDevice> m_PhysicalDevices;
	private List<uint32> m_PhysicalDeviceIndices;
	private List<uint32> m_ConcurrentSharingModeQueueIndices;
	private uint32[COMMAND_QUEUE_TYPE_NUM] m_FamilyIndices = .();
	private CommandQueueVK[COMMAND_QUEUE_TYPE_NUM] m_Queues = .();
	private DeviceDesc m_DeviceDesc = .();
	private VkPhysicalDeviceMemoryProperties m_MemoryProps = .();
	private VkAllocationCallbacks m_AllocationCallbacks = .();
	private SPIRVBindingOffsets m_SPIRVBindingOffsets = .();
	private VkDevice m_Device = .Null;
	private VkInstance m_Instance = .Null;
	private VkAllocationCallbacks* m_AllocationCallbackPtr = null;
	private VkDebugUtilsMessengerEXT m_Messenger = .Null;
	private uint64 m_LUID = 0;
	private bool m_OwnsNativeObjects = false;
	private bool m_IsDebugUtilsSupported = false;
	private bool m_IsSubsetAllocationSupported = false;
	private bool m_IsDescriptorIndexingSupported = false;
	private bool m_IsBufferDeviceAddressSupported = false;
	private bool m_IsSampleLocationExtSupported = false;
	private bool m_IsConservativeRasterExtSupported = false;
	private bool m_IsRayTracingExtSupported = false;
	private bool m_IsMicroMapSupported = false;
	private bool m_IsMeshShaderExtSupported = false;
	private bool m_IsHDRExtSupported = false;

	[Inline] public static implicit operator VkDevice(Self self)
		{ return self.m_Device; }

	[Inline] public static implicit operator VkPhysicalDevice(Self self)
		{ return self.m_PhysicalDevices.Front; }

	[Inline] public static implicit operator VkInstance(Self self)
		{ return self.m_Instance; }

	public DeviceLogger GetLogger() => m_Logger;
	public DeviceAllocator<uint8> GetAllocator() => m_Allocator;

	[Inline] public VkAllocationCallbacks* GetAllocationCallbacks()
		{ return m_AllocationCallbackPtr; }

	[Inline] public readonly ref uint32[COMMAND_QUEUE_TYPE_NUM] GetQueueFamilyIndices()
		{ return ref m_FamilyIndices; }

	[Inline] public readonly ref SPIRVBindingOffsets GetSPIRVBindingOffsets()
		{ return ref m_SPIRVBindingOffsets; }

	[Inline] public uint32 GetPhysicalDeviceGroupSize()
		{ return m_DeviceDesc.physicalDeviceNum; }

	[Inline] public bool IsDescriptorIndexingExtSupported()
		{ return m_IsDescriptorIndexingSupported; }

	[Inline] public bool IsConcurrentSharingModeEnabledForBuffers()
		{ return m_ConcurrentSharingModeQueueIndices.Count > 1; }

	[Inline] public bool IsConcurrentSharingModeEnabledForImages()
		{ return m_ConcurrentSharingModeQueueIndices.Count > 1; }

	[Inline] public bool IsBufferDeviceAddressSupported()
		{ return m_IsBufferDeviceAddressSupported; }

	[Inline] public readonly ref List<uint32> GetConcurrentSharingModeQueueIndices()
		{ return ref m_ConcurrentSharingModeQueueIndices; }

	public this(DeviceLogger logger, DeviceAllocator<uint8> allocator)
	{
		m_Logger = logger;
		m_Allocator = allocator;

		m_PhysicalDevices = Allocate!<List<VkPhysicalDevice>>(GetAllocator());
		m_PhysicalDeviceIndices = Allocate!<List<uint32>>(GetAllocator());
		m_ConcurrentSharingModeQueueIndices = Allocate!<List<uint32>>(GetAllocator());
	}

	public ~this()
	{
		if (m_Device == .Null)
			return;

		for (uint32 i = 0; i < m_Queues.Count; i++)
			Deallocate!(GetAllocator(), m_Queues[i]);

		if (m_Messenger != .Null)
		{
			vkDestroyDebugUtilsMessengerEXTFunction  destroyCallback = (vkDestroyDebugUtilsMessengerEXTFunction)vkGetInstanceProcAddr(m_Instance, "vkDestroyDebugUtilsMessengerEXT");
			destroyCallback(m_Instance, m_Messenger, m_AllocationCallbackPtr);
		}

		if (m_OwnsNativeObjects)
		{
			VulkanNative.vkDestroyDevice(m_Device, m_AllocationCallbackPtr);
			VulkanNative.vkDestroyInstance(m_Instance, m_AllocationCallbackPtr);
		}

		Deallocate!(GetAllocator(), m_ConcurrentSharingModeQueueIndices);
		Deallocate!(GetAllocator(), m_PhysicalDeviceIndices);
		Deallocate!(GetAllocator(), m_PhysicalDevices);
	}

	public void Destroy()
	{
		Deallocate!(GetAllocator(), this);
	}

	public Result Create(DeviceCreationDesc deviceCreationDesc)
	{
		m_OwnsNativeObjects = true;
		m_SPIRVBindingOffsets = deviceCreationDesc.spirvBindingOffsets;

		/*m_AllocationCallbacks.pUserData = Internal.UnsafeCastToPtr(GetAllocator());
		m_AllocationCallbacks.pfnAllocation = vkAllocateHostMemory;
		m_AllocationCallbacks.pfnReallocation = vkReallocateHostMemory;
		m_AllocationCallbacks.pfnFree = vkFreeHostMemory;
		m_AllocationCallbacks.pfnInternalAllocation = vkHostMemoryInternalAllocationNotification;
		m_AllocationCallbacks.pfnInternalFree = vkHostMemoryInternalFreeNotification;*/

		if (deviceCreationDesc.enableAPIValidation)
			m_AllocationCallbackPtr = &m_AllocationCallbacks;

		if (VulkanNative.Initialize() case .Err)
		{
			REPORT_ERROR(GetLogger(), "Failed to initialize Vulkan.");
			return .FAILURE;
		}

		VulkanNative.SetLoadFunctionErrorCallBack(new (functionName) =>
			{
				GetLogger().ReportMessage(.TYPE_ERROR, "Failed to load function: '{0}'.", functionName);
			});

		// Create instance
		Result res = ResolvePreInstanceDispatchTable();
		if (res != Result.SUCCESS)
			return res;

		res = CreateInstance(deviceCreationDesc);
		if (res != Result.SUCCESS)
			return res;

		VulkanNative.SetInstance(m_Instance);

		// Create device
		res = ResolveInstanceDispatchTable();
		if (res != Result.SUCCESS)
			return res;

		res = FindPhysicalDeviceGroup(deviceCreationDesc.physicalDeviceGroup, deviceCreationDesc.enableMGPU);
		if (res != Result.SUCCESS)
			return res;

		vkGetPhysicalDeviceMemoryProperties(m_PhysicalDevices.Front, &m_MemoryProps);
		FillFamilyIndices(false, null, 0);

		res = CreateLogicalDevice(deviceCreationDesc);
		if (res != Result.SUCCESS)
			return res;

		res = ResolveDispatchTable();
		if (res != Result.SUCCESS)
			return res;

		CreateCommandQueues();
		SetDeviceLimits(deviceCreationDesc.enableAPIValidation);

		readonly uint32 groupSize = m_DeviceDesc.physicalDeviceNum;
		m_PhysicalDeviceIndices.Resize(groupSize * groupSize);
		for (int i = 0; i < m_PhysicalDeviceIndices.Count; i++)
		{
			m_PhysicalDeviceIndices[i] = (uint32)(i / (int)groupSize);
		}

		if (deviceCreationDesc.enableAPIValidation)
			ReportDeviceGroupInfo();

		return res;
	}

	public Result Create(DeviceCreationVulkanDesc deviceCreationVulkanDesc)
	{
		m_OwnsNativeObjects = false;
		m_SPIRVBindingOffsets = deviceCreationVulkanDesc.spirvBindingOffsets;

		readonly VkPhysicalDevice* physicalDevices = (VkPhysicalDevice*)deviceCreationVulkanDesc.vkPhysicalDevices;
		m_PhysicalDevices.Insert(0, Span<VkPhysicalDevice>(physicalDevices, deviceCreationVulkanDesc.deviceGroupSize));

		/*m_AllocationCallbacks.pUserData = Internal.UnsafeCastToPtr(GetAllocator());
		m_AllocationCallbacks.pfnAllocation = vkAllocateHostMemory;
		m_AllocationCallbacks.pfnReallocation = vkReallocateHostMemory;
		m_AllocationCallbacks.pfnFree = vkFreeHostMemory;
		m_AllocationCallbacks.pfnInternalAllocation = vkHostMemoryInternalAllocationNotification;
		m_AllocationCallbacks.pfnInternalFree = vkHostMemoryInternalFreeNotification;*/

		if (deviceCreationVulkanDesc.enableAPIValidation)
			m_AllocationCallbackPtr = &m_AllocationCallbacks;

		char8* loaderPath = deviceCreationVulkanDesc.vulkanLoaderPath;

		if (VulkanNative.Initialize(scope String(loaderPath)) case .Err)
		{
			REPORT_ERROR(GetLogger(), "Failed to initialize Vulkan.");
			return .FAILURE;
		}

		VulkanNative.SetLoadFunctionErrorCallBack(new (functionName) =>
			{
				GetLogger().ReportMessage(.TYPE_ERROR, scope $"Failed to load function: '{functionName}'.");
			});

		// Create instance
		Result res = ResolvePreInstanceDispatchTable();
		if (res != Result.SUCCESS)
			return res;

		m_Instance = (VkInstance)deviceCreationVulkanDesc.vkInstance;

		// Create device
		res = ResolveInstanceDispatchTable();
		if (res != Result.SUCCESS)
			return res;

		m_Device = (VkDevice)deviceCreationVulkanDesc.vkDevice;

		res = ResolveDispatchTable();
		if (res != Result.SUCCESS)
			return res;

		vkGetPhysicalDeviceMemoryProperties(m_PhysicalDevices.Front, &m_MemoryProps);

		FillFamilyIndices(true, deviceCreationVulkanDesc.queueFamilyIndices, deviceCreationVulkanDesc.queueFamilyIndexNum);

		// Instance extensions
		{
			uint32 extensionNum = 0;
			vkEnumerateInstanceExtensionProperties(null, &extensionNum, null);

			List<VkExtensionProperties> supportedExts = Allocate!<List<VkExtensionProperties>>(GetAllocator());
			supportedExts.Resize(extensionNum);
			defer { Deallocate!(GetAllocator(), supportedExts); }
			vkEnumerateInstanceExtensionProperties(null, &extensionNum, supportedExts.Ptr);

			if (IsExtensionSupported(VK_EXT_DEBUG_UTILS_EXTENSION_NAME, supportedExts))
				m_IsDebugUtilsSupported = true;
		}

		// Device extensions
		{
			uint32 extensionNum = 0;
			vkEnumerateDeviceExtensionProperties(m_PhysicalDevices.Front, null, &extensionNum, null);

			List<VkExtensionProperties> supportedExts = Allocate!<List<VkExtensionProperties>>(GetAllocator());
			supportedExts.Resize(extensionNum);
			defer { Deallocate!(GetAllocator(), supportedExts); }
			vkEnumerateDeviceExtensionProperties(m_PhysicalDevices.Front, null, &extensionNum, supportedExts.Ptr);

			if (IsExtensionSupported(VK_KHR_ACCELERATION_STRUCTURE_EXTENSION_NAME, supportedExts))
				m_IsRayTracingExtSupported = true;

			if (IsExtensionSupported(VK_EXT_SAMPLE_LOCATIONS_EXTENSION_NAME, supportedExts))
				m_IsSampleLocationExtSupported = true;

			if (IsExtensionSupported(VK_EXT_CONSERVATIVE_RASTERIZATION_EXTENSION_NAME, supportedExts))
				m_IsConservativeRasterExtSupported = true;

			if (IsExtensionSupported(VK_EXT_HDR_METADATA_EXTENSION_NAME, supportedExts))
				m_IsHDRExtSupported = true;

			if (IsExtensionSupported(VK_EXT_OPACITY_MICROMAP_EXTENSION_NAME, supportedExts))
				m_IsMicroMapSupported = true;

			if (IsExtensionSupported(VK_EXT_MESH_SHADER_EXTENSION_NAME, supportedExts))
				m_IsMeshShaderExtSupported = true;
		}

		CreateCommandQueues();
		SetDeviceLimits(deviceCreationVulkanDesc.enableAPIValidation);

		if (deviceCreationVulkanDesc.enableAPIValidation)
			ReportDeviceGroupInfo();

		return res;
	}

	public bool GetMemoryType(MemoryLocation memoryLocation, uint32 memoryTypeMask, ref MemoryTypeInfo memoryTypeInfo)
	{
		readonly VkMemoryPropertyFlags host = .VK_MEMORY_PROPERTY_HOST_COHERENT_BIT | .VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT;
		readonly VkMemoryPropertyFlags hostUnwantedFlags = .VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT;

		readonly VkMemoryPropertyFlags device = .VK_MEMORY_PROPERTY_DEVICE_LOCAL_BIT;
		readonly VkMemoryPropertyFlags deviceUnwantedFlags = 0;

		VkMemoryPropertyFlags flags = IsHostVisibleMemory(memoryLocation) ? host : device;
		VkMemoryPropertyFlags unwantedFlags = IsHostVisibleMemory(memoryLocation) ? hostUnwantedFlags : deviceUnwantedFlags;

		memoryTypeInfo.isHostCoherent = IsHostVisibleMemory(memoryLocation) ? 1 : 0;
		memoryTypeInfo.location = (uint8)memoryLocation;

		for (uint16 i = 0; i < m_MemoryProps.memoryTypeCount; i++)
		{
			readonly bool isMemoryTypeSupported = (memoryTypeMask & (1 << i)) != 0;
			readonly bool isPropSupported = (m_MemoryProps.memoryTypes[i].propertyFlags & flags) == flags;
			readonly bool hasUnwantedProperties = (m_MemoryProps.memoryTypes[i].propertyFlags & unwantedFlags) != 0;

			if (isMemoryTypeSupported && isPropSupported && !hasUnwantedProperties)
			{
				memoryTypeInfo.memoryTypeIndex = (uint16)i;
				return true;
			}
		}

		// ignore unwanted properties
		for (uint16 i = 0; i < m_MemoryProps.memoryTypeCount; i++)
		{
			readonly bool isMemoryTypeSupported = (memoryTypeMask & (1 << i)) != 0;
			readonly bool isPropSupported = (m_MemoryProps.memoryTypes[i].propertyFlags & flags) == flags;

			if (isMemoryTypeSupported && isPropSupported)
			{
				memoryTypeInfo.memoryTypeIndex = (uint16)i;
				return true;
			}
		}

		return false;
	}

	public bool GetMemoryType(uint32 index, ref MemoryTypeInfo memoryTypeInfo)
	{
		if (index >= m_MemoryProps.memoryTypeCount)
			return false;

		readonly ref VkMemoryType memoryType = ref m_MemoryProps.memoryTypes[index];

		memoryTypeInfo.memoryTypeIndex = (uint16)index;
		memoryTypeInfo.isHostCoherent = (memoryType.propertyFlags & .VK_MEMORY_PROPERTY_HOST_COHERENT_BIT) != 0 ? 1 : 0;

		readonly bool isHostVisible = (memoryType.propertyFlags & .VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT) != 0;
		memoryTypeInfo.location = isHostVisible ? (uint8)MemoryLocation.HOST_UPLOAD : (uint8)MemoryLocation.DEVICE;
		Compiler.Assert((uint32)MemoryLocation.MAX_NUM <= uint8.MaxValue, "Unexpected number of memory locations");

		return true;
	}

	public void SetDebugNameToTrivialObject(VkObjectType objectType, uint64 handle, char8* name)
	{
		if (VulkanNative.[Friend]vkSetDebugUtilsObjectNameEXT_ptr == null)
			return;

		VkDebugUtilsObjectNameInfoEXT info = .()
			{
				sType = .VK_STRUCTURE_TYPE_DEBUG_UTILS_OBJECT_NAME_INFO_EXT,
				pNext = null,
				objectType = objectType,
				objectHandle = (uint64)handle,
				pObjectName = name
			};

		readonly VkResult result = VulkanNative.vkSetDebugUtilsObjectNameEXT(m_Device, &info);

		RETURN_ON_FAILURE!(GetLogger(), result == .VK_SUCCESS, void(),
			"Can't set a debug name to an object: vkSetDebugUtilsObjectNameEXT returned {0}.", (int32)result);
	}

	public void SetDebugNameToDeviceGroupObject(VkObjectType objectType, uint64* handles, char8* name)
	{
		if (VulkanNative.[Friend]vkSetDebugUtilsObjectNameEXT_ptr == null)
			return;

		VkDebugUtilsObjectNameInfoEXT info = .()
			{
				sType = .VK_STRUCTURE_TYPE_DEBUG_UTILS_OBJECT_NAME_INFO_EXT,
				pNext = null,
				objectType = objectType,
				objectHandle = (uint64)0
			};

		for (uint32 i = 0; i < m_DeviceDesc.physicalDeviceNum; i++)
		{
			if (handles[i] != 0)
			{
				String nameWithDeviceIndex = scope String(name)..AppendF("{0}", i);

				info.objectHandle = (uint64)handles[i];
				info.pObjectName = nameWithDeviceIndex.Ptr;

				readonly VkResult result = VulkanNative.vkSetDebugUtilsObjectNameEXT(m_Device, &info);
				RETURN_ON_FAILURE!(GetLogger(), result == .VK_SUCCESS, void(),
					"Can't set a debug name to an object: vkSetDebugUtilsObjectNameEXT returned {0}.", (int32)result);
			}
		}
	}



	private Result CreateInstance(DeviceCreationDesc deviceCreationDesc)
	{
		List<char8*> layers = Allocate!<List<char8*>>(GetAllocator());
		defer { Deallocate!(GetAllocator(), layers); }
		if (deviceCreationDesc.enableAPIValidation)
			layers.Add("VK_LAYER_KHRONOS_validation");

		FilterInstanceLayers(layers);

		uint32 extensionNum = 0;
		vkEnumerateInstanceExtensionProperties(null, &extensionNum, null);

		List<VkExtensionProperties> supportedExts = Allocate!<List<VkExtensionProperties>>(GetAllocator());
		defer { Deallocate!(GetAllocator(), supportedExts); }
		supportedExts.Resize(extensionNum);
		vkEnumerateInstanceExtensionProperties(null, &extensionNum, supportedExts.Ptr);

		List<char8*> extensions = Allocate!<List<char8*>>(GetAllocator());
		defer { Deallocate!(GetAllocator(), extensions); }
		for (uint32 i = 0; i < deviceCreationDesc.vulkanExtensions.instanceExtensionNum; i++)
			extensions.Add(deviceCreationDesc.vulkanExtensions.instanceExtensions[i]);

		extensions.Add(VK_KHR_SURFACE_EXTENSION_NAME);
		#if true //VK_USE_PLATFORM_WIN32_KHR
		extensions.Add(VK_KHR_WIN32_SURFACE_EXTENSION_NAME);
		#endif
		#if VK_USE_PLATFORM_METAL_EXT
			extensions.Add(VK_EXT_METAL_SURFACE_EXTENSION_NAME);
		#endif
		#if VK_USE_PLATFORM_XLIB_KHR
			extensions.Add(VK_KHR_XLIB_SURFACE_EXTENSION_NAME);
		#endif
		#if VK_USE_PLATFORM_WAYLAND_KHR
			extensions.Add(VK_KHR_WAYLAND_SURFACE_EXTENSION_NAME);
		#endif

		if (IsExtensionSupported(VK_EXT_DEBUG_UTILS_EXTENSION_NAME, supportedExts))
		{
			extensions.Add(VK_EXT_DEBUG_UTILS_EXTENSION_NAME);
			m_IsDebugUtilsSupported = true;
		}

		/*readonly*/ VkApplicationInfo appInfo = .()
			{
				sType = .VK_STRUCTURE_TYPE_APPLICATION_INFO,
				pNext = null,
				pApplicationName  = null,
				applicationVersion = 0,
				pEngineName = null,
				engineVersion  = 0,
				apiVersion  = VulkanNative.VK_API_VERSION_1_3
			};

		/*readonly*/ VkInstanceCreateInfo info = .()
			{
				sType = .VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
				pNext = null,
				flags = (VkInstanceCreateFlags)0,
				pApplicationInfo  = &appInfo,
				enabledLayerCount  = (uint32)layers.Count,
				ppEnabledLayerNames  = layers.Ptr,
				enabledExtensionCount  = (uint32)extensions.Count,
				ppEnabledExtensionNames  = extensions.Ptr
			};

		VkResult result = vkCreateInstance(&info, m_AllocationCallbackPtr, &m_Instance);

		RETURN_ON_FAILURE!(GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't create a VkInstance: vkCreateInstance returned {0}.", (int32)result);

		if (deviceCreationDesc.enableAPIValidation)
		{
			vkCreateDebugUtilsMessengerEXTFunction vkCreateDebugUtilsMessengerEXTFunc = null;
			vkCreateDebugUtilsMessengerEXTFunc = (vkCreateDebugUtilsMessengerEXTFunction)VulkanNative.vkGetInstanceProcAddr(m_Instance, "vkCreateDebugUtilsMessengerEXT");

			VkDebugUtilsMessengerCreateInfoEXT createInfo = .() { sType = .VK_STRUCTURE_TYPE_DEBUG_UTILS_MESSENGER_CREATE_INFO_EXT };

			createInfo.messageSeverity = .VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT | .VK_DEBUG_UTILS_MESSAGE_SEVERITY_INFO_BIT_EXT;
			createInfo.messageSeverity |= .VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT | .VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT;

			createInfo.messageType = .VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT | .VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT;
			createInfo.messageType |= .VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT;

			PFN_vkDebugUtilsMessengerCallbackEXT debugCallbackFunction = => DebugUtilsMessenger;
			createInfo.pUserData = Internal.UnsafeCastToPtr(this);
			createInfo.pfnUserCallback = debugCallbackFunction;

			result = vkCreateDebugUtilsMessengerEXT(m_Instance, &createInfo, m_AllocationCallbackPtr, &m_Messenger);

			RETURN_ON_FAILURE!(GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
				"Can't create a debug utils messenger callback: vkCreateDebugUtilsMessengerEXT returned {0}.", (int32)result);
		}

		return Result.SUCCESS;
	}

	//================================================================================================================
	// NRI
	//================================================================================================================

	public ref DeviceDesc GetDesc()
	{
		return ref m_DeviceDesc;
	}

	public void* GetNativeObject()
	{
		return default;
	}

	public void SetDebugName(char8* name)
	{
		SetDebugNameToTrivialObject(.VK_OBJECT_TYPE_DEVICE, (uint64)m_Device, name);
	}

	public Result GetCommandQueue(CommandQueueType commandQueueType, out ICommandQueue commandQueue)
	{
		using (m_Monitor.Enter())
		{
			if (m_FamilyIndices[(uint32)commandQueueType] == INVALID_FAMILY_INDEX)
			{
				commandQueue = ?;
				return Result.UNSUPPORTED;
			}

			commandQueue = (ICommandQueue)m_Queues[(uint32)commandQueueType];

			return Result.SUCCESS;
		}
	}

	public Result CreateCommandAllocator(ICommandQueue commandQueue, uint32 physicalDeviceMask, out ICommandAllocator commandAllocator)
	{
		return CreateImplementation<CommandAllocatorVK...>(out commandAllocator, commandQueue, physicalDeviceMask);
	}

	public Result CreateDescriptorPool(DescriptorPoolDesc descriptorPoolDesc, out IDescriptorPool descriptorPool)
	{
		return CreateImplementation<DescriptorPoolVK...>(out descriptorPool, descriptorPoolDesc);
	}

	public Result CreateBuffer(BufferDesc bufferDesc, out IBuffer buffer)
	{
		return CreateImplementation<BufferVK...>(out buffer, bufferDesc);
	}

	public Result CreateTexture(TextureDesc textureDesc, out ITexture texture)
	{
		return CreateImplementation<TextureVK...>(out texture, textureDesc);
	}

	public Result CreateBufferView(BufferViewDesc bufferViewDesc, out IDescriptor bufferView)
	{
		return CreateImplementation<DescriptorVK...>(out bufferView, bufferViewDesc);
	}

	public Result CreateTexture1DView(Texture1DViewDesc textureViewDesc, out IDescriptor textureView)
	{
		return CreateImplementation<DescriptorVK...>(out textureView, textureViewDesc);
	}

	public Result CreateTexture2DView(Texture2DViewDesc textureViewDesc, out IDescriptor textureView)
	{
		return CreateImplementation<DescriptorVK...>(out textureView, textureViewDesc);
	}

	public Result CreateTexture3DView(Texture3DViewDesc textureViewDesc, out IDescriptor textureView)
	{
		return CreateImplementation<DescriptorVK...>(out textureView, textureViewDesc);
	}

	public Result CreateSampler(SamplerDesc samplerDesc, out IDescriptor sampler)
	{
		return CreateImplementation<DescriptorVK...>(out sampler, samplerDesc);
	}

	public Result CreatePipelineLayout(PipelineLayoutDesc pipelineLayoutDesc, out IPipelineLayout pipelineLayout)
	{
		return CreateImplementation<PipelineLayoutVK...>(out pipelineLayout, pipelineLayoutDesc);
	}

	public Result CreateGraphicsPipeline(GraphicsPipelineDesc graphicsPipelineDesc, out IPipeline pipeline)
	{
		return CreateImplementation<PipelineVK...>(out pipeline, graphicsPipelineDesc);
	}

	public Result CreateComputePipeline(ComputePipelineDesc computePipelineDesc, out IPipeline pipeline)
	{
		return CreateImplementation<PipelineVK...>(out pipeline, computePipelineDesc);
	}

	public Result CreateFrameBuffer(FrameBufferDesc frameBufferDesc, out IFrameBuffer frameBuffer)
	{
		return CreateImplementation<FrameBufferVK...>(out frameBuffer, frameBufferDesc);
	}

	public Result CreateQueryPool(QueryPoolDesc queryPoolDesc, out IQueryPool queryPool)
	{
		return CreateImplementation<QueryPoolVK...>(out queryPool, queryPoolDesc);
	}

	public Result CreateFence(uint64 initialValue, out IFence fence)
	{
		return CreateImplementation<FenceVK...>(out fence, initialValue);
	}

	public Result CreateSwapChain(SwapChainDesc swapChainDesc, out ISwapChain swapChain)
	{
		return CreateImplementation<SwapChainVK...>(out swapChain, swapChainDesc);
	}

	public Result CreateRayTracingPipeline(RayTracingPipelineDesc rayTracingPipelineDesc, out IPipeline pipeline)
	{
		return CreateImplementation<PipelineVK...>(out pipeline, rayTracingPipelineDesc);
	}

	public Result CreateAccelerationStructure(AccelerationStructureDesc accelerationStructureDesc, out IAccelerationStructure accelerationStructure)
	{
		return CreateImplementation<AccelerationStructureVK...>(out accelerationStructure, accelerationStructureDesc);
	}

	public void DestroyCommandAllocator(ICommandAllocator commandAllocator)
	{
		Deallocate!(GetAllocator(), (CommandAllocatorVK)commandAllocator);
	}

	public void DestroyCommandBuffer(ICommandBuffer commandBuffer)
	{
		Deallocate!(GetAllocator(), (CommandBufferVK)commandBuffer);
	}

	public void DestroyDescriptorPool(IDescriptorPool descriptorPool)
	{
		Deallocate!(GetAllocator(), (DescriptorPoolVK)descriptorPool);
	}

	public void DestroyBuffer(IBuffer buffer)
	{
		Deallocate!(GetAllocator(), (BufferVK)buffer);
	}

	public void DestroyTexture(ITexture texture)
	{
		Deallocate!(GetAllocator(), (TextureVK)texture);
	}

	public void DestroyDescriptor(IDescriptor descriptor)
	{
		Deallocate!(GetAllocator(), (DescriptorVK)descriptor);
	}

	public void DestroyPipelineLayout(IPipelineLayout pipelineLayout)
	{
		Deallocate!(GetAllocator(), (PipelineLayoutVK)pipelineLayout);
	}

	public void DestroyPipeline(IPipeline pipeline)
	{
		Deallocate!(GetAllocator(), (PipelineVK)pipeline);
	}

	public void DestroyFrameBuffer(IFrameBuffer frameBuffer)
	{
		Deallocate!(GetAllocator(), (FrameBufferVK)frameBuffer);
	}

	public void DestroyQueryPool(IQueryPool queryPool)
	{
		Deallocate!(GetAllocator(), (QueryPoolVK)queryPool);
	}

	public void DestroyFence(IFence fence)
	{
		Deallocate!(GetAllocator(), (FenceVK)fence);
	}

	public void DestroySwapChain(ISwapChain swapChain)
	{
		Deallocate!(GetAllocator(), (SwapChainVK)swapChain);
	}

	public void DestroyAccelerationStructure(IAccelerationStructure accelerationStructure)
	{
		Deallocate!(GetAllocator(), (AccelerationStructureVK)accelerationStructure);
	}

	public Result GetDisplays(Display* displays, ref uint32 displayNum)
	{
		return Result.UNSUPPORTED;
	}

	public Result GetDisplaySize(ref Display display, ref uint16 width, ref uint16 height)
	{
		return Result.UNSUPPORTED;
	}

	public Result AllocateMemory(uint32 physicalDeviceMask, uint32 memoryType, uint64 size, out IMemory memory)
	{
		return CreateImplementation<MemoryVK...>(out memory, physicalDeviceMask, memoryType, size);
	}

	public Result BindBufferMemory(BufferMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum)
	{
		if (memoryBindingDescNum == 0)
			return Result.SUCCESS;

		readonly uint32 infoMaxNum = memoryBindingDescNum * m_DeviceDesc.physicalDeviceNum;

		VkBindBufferMemoryInfo* infos = STACK_ALLOC!<VkBindBufferMemoryInfo>(infoMaxNum);
		uint32 infoNum = 0;

		VkBindBufferMemoryDeviceGroupInfo* deviceGroupInfos = null;
		if (m_DeviceDesc.physicalDeviceNum > 1)
			deviceGroupInfos = STACK_ALLOC!<VkBindBufferMemoryDeviceGroupInfo>(infoMaxNum);

		for (uint32 i = 0; i < memoryBindingDescNum; i++)
		{
			readonly ref BufferMemoryBindingDesc bindingDesc = ref memoryBindingDescs[i];

			MemoryVK memoryImpl = (MemoryVK)bindingDesc.memory;
			BufferVK bufferImpl = (BufferVK)bindingDesc.buffer;

			readonly MemoryTypeUnpack unpack = .() { type = memoryImpl.GetMemoryType() };
			readonly ref MemoryTypeInfo memoryTypeInfo = ref unpack.info;

			readonly MemoryLocation memoryLocation = (MemoryLocation)memoryTypeInfo.location;

			uint32 physicalDeviceMask = GetPhysicalDeviceGroupMask(bindingDesc.physicalDeviceMask);
			if (IsHostVisibleMemory(memoryLocation))
				physicalDeviceMask = 0x1;

			if (memoryTypeInfo.isDedicated == 1)
				memoryImpl.CreateDedicated(bufferImpl, physicalDeviceMask);

			for (uint32 j = 0; j < m_DeviceDesc.physicalDeviceNum; j++)
			{
				if (((1u << j) & physicalDeviceMask) != 0)
				{
					ref VkBindBufferMemoryInfo info = ref infos[infoNum++];

					info = .();
					info.sType = .VK_STRUCTURE_TYPE_BIND_BUFFER_MEMORY_INFO;
					info.buffer = bufferImpl.GetHandle(j);
					info.memory = memoryImpl.GetHandle(j);
					info.memoryOffset = bindingDesc.offset;

					if (IsHostVisibleMemory(memoryLocation))
						bufferImpl.SetHostMemory(memoryImpl, info.memoryOffset);

					if (deviceGroupInfos != null)
					{
						ref VkBindBufferMemoryDeviceGroupInfo deviceGroupInfo = ref deviceGroupInfos[infoNum - 1];
						deviceGroupInfo = .();
						deviceGroupInfo.sType = .VK_STRUCTURE_TYPE_BIND_BUFFER_MEMORY_DEVICE_GROUP_INFO;
						deviceGroupInfo.deviceIndexCount = m_DeviceDesc.physicalDeviceNum;
						deviceGroupInfo.pDeviceIndices = &m_PhysicalDeviceIndices[j * m_DeviceDesc.physicalDeviceNum];
						info.pNext = &deviceGroupInfo;
					}
				}
			}
		} VkResult result = .VK_SUCCESS;
		if (infoNum > 0)
			result = vkBindBufferMemory2(m_Device, infoNum, infos);

		RETURN_ON_FAILURE!(GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't bind a memory to a buffer: vkBindBufferMemory2 returned {0}.", (int32)result);

		for (uint32 i = 0; i < memoryBindingDescNum; i++)
		{
			BufferVK bufferImpl = (BufferVK)memoryBindingDescs[i].buffer;
			bufferImpl.ReadDeviceAddress();
		}

		return Result.SUCCESS;
	}

	public Result BindTextureMemory(TextureMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum)
	{
		readonly uint32 infoMaxNum = memoryBindingDescNum * m_DeviceDesc.physicalDeviceNum;

		VkBindImageMemoryInfo* infos = STACK_ALLOC!<VkBindImageMemoryInfo>(infoMaxNum);
		uint32 infoNum = 0;

		VkBindImageMemoryDeviceGroupInfo* deviceGroupInfos = null;
		if (m_DeviceDesc.physicalDeviceNum > 1)
			deviceGroupInfos = STACK_ALLOC!<VkBindImageMemoryDeviceGroupInfo>(infoMaxNum);

		for (uint32 i = 0; i < memoryBindingDescNum; i++)
		{
			readonly ref TextureMemoryBindingDesc bindingDesc = ref memoryBindingDescs[i];

			readonly uint32 physicalDeviceMask = GetPhysicalDeviceGroupMask(bindingDesc.physicalDeviceMask);

			MemoryVK memoryImpl = (MemoryVK)bindingDesc.memory;
			TextureVK textureImpl = (TextureVK)bindingDesc.texture;

			readonly MemoryTypeUnpack unpack = .() { type = memoryImpl.GetMemoryType() };
			readonly ref MemoryTypeInfo memoryTypeInfo = ref  unpack.info;

			if (memoryTypeInfo.isDedicated == 1)
				memoryImpl.CreateDedicated(textureImpl, physicalDeviceMask);

			for (uint32 j = 0; j < m_DeviceDesc.physicalDeviceNum; j++)
			{
				if (((1u << j) & physicalDeviceMask) != 0)
				{
					ref VkBindImageMemoryInfo info = ref infos[infoNum++];
					info.sType = .VK_STRUCTURE_TYPE_BIND_IMAGE_MEMORY_INFO;
					info.pNext = null;
					info.image = textureImpl.GetHandle(j);
					info.memory = memoryImpl.GetHandle(j);
					info.memoryOffset = bindingDesc.offset;

					if (deviceGroupInfos != null)
					{
						ref VkBindImageMemoryDeviceGroupInfo deviceGroupInfo = ref deviceGroupInfos[infoNum - 1];
						deviceGroupInfo = .();
						deviceGroupInfo.sType = .VK_STRUCTURE_TYPE_BIND_IMAGE_MEMORY_DEVICE_GROUP_INFO;
						deviceGroupInfo.deviceIndexCount = m_DeviceDesc.physicalDeviceNum;
						deviceGroupInfo.pDeviceIndices = &m_PhysicalDeviceIndices[j * m_DeviceDesc.physicalDeviceNum];
						info.pNext = &deviceGroupInfo;
					}
				}
			}
		}

		VkResult result = .VK_SUCCESS;
		if (infoNum > 0)
			result = vkBindImageMemory2(m_Device, infoNum, infos);

		RETURN_ON_FAILURE!(GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't bind a memory to a texture: vkBindImageMemory2 returned {0}.", (int32)result);

		return Result.SUCCESS;
	}

	public Result BindAccelerationStructureMemory(AccelerationStructureMemoryBindingDesc* memoryBindingDescs, uint32 memoryBindingDescNum)
	{
		if (memoryBindingDescNum == 0)
			return Result.SUCCESS;

		BufferMemoryBindingDesc* infos = ALLOCATE_SCRATCH!<BufferMemoryBindingDesc>(this, memoryBindingDescNum);

		for (uint32 i = 0; i < memoryBindingDescNum; i++)
		{
			readonly ref AccelerationStructureMemoryBindingDesc bindingDesc = ref memoryBindingDescs[i];
			AccelerationStructureVK accelerationStructure = (AccelerationStructureVK)bindingDesc.accelerationStructure;

			ref BufferMemoryBindingDesc bufferMemoryBinding = ref infos[i];
			bufferMemoryBinding = .();
			bufferMemoryBinding.buffer = (IBuffer)accelerationStructure.GetBuffer();
			bufferMemoryBinding.memory = bindingDesc.memory;
			bufferMemoryBinding.offset = bindingDesc.offset;
			bufferMemoryBinding.physicalDeviceMask = bindingDesc.physicalDeviceMask;
		}

		Result result = BindBufferMemory(infos, memoryBindingDescNum);

		for (uint32 i = 0; i < memoryBindingDescNum && result == Result.SUCCESS; i++)
		{
			AccelerationStructureVK accelerationStructure = (AccelerationStructureVK)memoryBindingDescs[i].accelerationStructure;
			result = accelerationStructure.FinishCreation();
		}

		FREE_SCRATCH!(this, infos, memoryBindingDescNum);

		return result;
	}

	public void FreeMemory(IMemory memory)
	{
		Deallocate!(GetAllocator(), (MemoryVK)memory);
	}

	public FormatSupportBits GetFormatSupport(Format format)
	{
		readonly VkFormat vulkanFormat = GetVkFormat(format);
		readonly VkPhysicalDevice physicalDevice = m_PhysicalDevices.Front;

		VkFormatProperties formatProperties = .();
		vkGetPhysicalDeviceFormatProperties(physicalDevice, vulkanFormat, &formatProperties);

		const VkFormatFeatureFlags transferBits = .VK_FORMAT_FEATURE_TRANSFER_DST_BIT | .VK_FORMAT_FEATURE_TRANSFER_SRC_BIT;

		const VkFormatFeatureFlags textureBits = .VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT | transferBits;
		const VkFormatFeatureFlags storageTextureBits = .VK_FORMAT_FEATURE_STORAGE_IMAGE_BIT | transferBits;
		const VkFormatFeatureFlags bufferBits = .VK_FORMAT_FEATURE_UNIFORM_TEXEL_BUFFER_BIT | transferBits;
		const VkFormatFeatureFlags storageBufferBits = .VK_FORMAT_FEATURE_STORAGE_TEXEL_BUFFER_BIT | transferBits;
		const VkFormatFeatureFlags colorAttachmentBits = .VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BIT | .VK_FORMAT_FEATURE_COLOR_ATTACHMENT_BLEND_BIT | transferBits;
		const VkFormatFeatureFlags depthAttachmentBits = .VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT | transferBits;
		const VkFormatFeatureFlags vertexBufferBits = .VK_FORMAT_FEATURE_VERTEX_BUFFER_BIT | transferBits;

		FormatSupportBits mask = FormatSupportBits.UNSUPPORTED;

		if (formatProperties.optimalTilingFeatures.HasFlag(textureBits))
			mask |= FormatSupportBits.TEXTURE;

		if (formatProperties.optimalTilingFeatures.HasFlag(storageTextureBits))
			mask |= FormatSupportBits.STORAGE_TEXTURE;

		if (formatProperties.optimalTilingFeatures.HasFlag(colorAttachmentBits))
			mask |= FormatSupportBits.COLOR_ATTACHMENT;

		if (formatProperties.optimalTilingFeatures.HasFlag(depthAttachmentBits))
			mask |= FormatSupportBits.DEPTH_STENCIL_ATTACHMENT;

		if (formatProperties.bufferFeatures.HasFlag(bufferBits))
			mask |= FormatSupportBits.BUFFER;

		if (formatProperties.bufferFeatures.HasFlag(storageBufferBits))
			mask |= FormatSupportBits.STORAGE_BUFFER;

		if (formatProperties.bufferFeatures.HasFlag(vertexBufferBits))
			mask |= FormatSupportBits.VERTEX_BUFFER;

		return mask;
	}

	public uint32 CalculateAllocationNumber(Sphenery.RHI.Helpers.ResourceGroupDesc resourceGroupDesc)
	{
		DeviceMemoryAllocatorHelper allocator = scope .(this, GetAllocator());

		return allocator.CalculateAllocationNumber(resourceGroupDesc);
	}

	public Result AllocateAndBindMemory(Sphenery.RHI.Helpers.ResourceGroupDesc resourceGroupDesc, IMemory* allocations)
	{
		DeviceMemoryAllocatorHelper allocator = scope .(this, GetAllocator());

		return allocator.AllocateAndBindMemory(resourceGroupDesc, allocations);
	}

	public Result CreateCommandQueueVK(CommandQueueVulkanDesc commandQueueVulkanDesc, out ICommandQueue commandQueue)
	{
		readonly uint32 commandQueueTypeIndex = (uint32)commandQueueVulkanDesc.commandQueueType;

		m_Monitor.Enter();
		defer m_Monitor.Exit();

		readonly bool isFamilyIndexSame = m_FamilyIndices[commandQueueTypeIndex] == commandQueueVulkanDesc.familyIndex;
		readonly bool isQueueSame = ((VkQueue)m_Queues[commandQueueTypeIndex] == (VkQueue)commandQueueVulkanDesc.vkQueue);
		if (isFamilyIndexSame && isQueueSame)
		{
			commandQueue = (ICommandQueue)m_Queues[commandQueueTypeIndex];
			return Result.SUCCESS;
		}

		CreateImplementation<CommandQueueVK...>(out commandQueue, commandQueueVulkanDesc);

		if (m_Queues[commandQueueTypeIndex] != null)
			Deallocate!(GetAllocator(), m_Queues[commandQueueTypeIndex]);

		m_FamilyIndices[commandQueueTypeIndex] = commandQueueVulkanDesc.familyIndex;
		m_Queues[commandQueueTypeIndex] = (CommandQueueVK)commandQueue;

		return Result.SUCCESS;
	}

	public Result CreateCommandAllocatorVK(CommandAllocatorVulkanDesc commandAllocatorVulkanDesc, out ICommandAllocator commandAllocator)
	{
		return CreateImplementation<CommandAllocatorVK...>(out commandAllocator, commandAllocatorVulkanDesc);
	}

	public Result CreateCommandBufferVK(CommandBufferVulkanDesc commandBufferVulkanDesc, out ICommandBuffer commandBuffer)
	{
		return CreateImplementation<CommandBufferVK...>(out commandBuffer, commandBufferVulkanDesc);
	}

	public Result CreateDescriptorPoolVK(uint64 vkDescriptorPool, out IDescriptorPool descriptorPool)
	{
		return CreateImplementation<DescriptorPoolVK...>(out descriptorPool, vkDescriptorPool);
	}

	public Result CreateBufferVK(BufferVulkanDesc bufferVulkanDesc, out IBuffer buffer)
	{
		return CreateImplementation<BufferVK...>(out buffer, bufferVulkanDesc);
	}

	public Result CreateTextureVK(TextureVulkanDesc textureVulkanDesc, out ITexture texture)
	{
		return CreateImplementation<TextureVK...>(out texture, textureVulkanDesc);
	}

	public Result CreateMemoryVK(MemoryVulkanDesc memoryVulkanDesc, out IMemory memory)
	{
		return CreateImplementation<MemoryVK...>(out memory, memoryVulkanDesc);
	}

	public Result CreateGraphicsPipelineVK(uint64 vkPipeline, out IPipeline pipeline)
	{
		PipelineVK implementation = Allocate!<PipelineVK>(GetAllocator(), this);
		readonly Result result = implementation.CreateGraphics(vkPipeline);

		if (result != Result.SUCCESS)
		{
			pipeline = (IPipeline)implementation;
			return result;
		}

		pipeline = ?;
		Deallocate!(GetAllocator(), implementation);

		return result;
	}

	public Result CreateComputePipelineVK(uint64 vkPipeline, out IPipeline pipeline)
	{
		PipelineVK implementation = Allocate!<PipelineVK>(GetAllocator(), this);
		readonly Result result = implementation.CreateCompute(vkPipeline);

		if (result != Result.SUCCESS)
		{
			pipeline = (IPipeline)implementation;
			return result;
		}

		pipeline = ?;
		Deallocate!(GetAllocator(), implementation);

		return result;
	}

	public Result CreateQueryPoolVK(QueryPoolVulkanDesc queryPoolVulkanDesc, out IQueryPool queryPool)
	{
		return CreateImplementation<QueryPoolVK...>(out queryPool, queryPoolVulkanDesc);
	}

	public Result CreateAccelerationStructureVK(AccelerationStructureVulkanDesc accelerationStructureDesc, out IAccelerationStructure accelerationStructure)
	{
		return CreateImplementation<AccelerationStructureVK...>(out accelerationStructure, accelerationStructureDesc);
	}

	public void* GetVkPhysicalDevice()
	{
		return (VkPhysicalDevice)this;
	}

	public void* GetVkInstance()
	{
		return (VkInstance)this;
	}

	public void* GetVkGetInstanceProcAddr()
	{
		return default;
	}

	public void* GetVkGetDeviceProcAddr()
	{
		return default;
	}





	private Result FindPhysicalDeviceGroup(PhysicalDeviceGroup* physicalDeviceGroup, bool enableMGPU)
	{
		uint32 deviceGroupNum = 0;
		vkEnumeratePhysicalDeviceGroups(m_Instance, &deviceGroupNum, null);

		VkPhysicalDeviceGroupProperties* deviceGroups = STACK_ALLOC!<VkPhysicalDeviceGroupProperties>(deviceGroupNum);
		VkResult result = vkEnumeratePhysicalDeviceGroups(m_Instance, &deviceGroupNum, deviceGroups);

		RETURN_ON_FAILURE!(GetLogger(), result == .VK_SUCCESS, GetReturnCode(result),
			"Can't enumerate physical devices: vkEnumeratePhysicalDevices returned {0}.", (int32)result);

		VkPhysicalDeviceIDProperties idProps = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_ID_PROPERTIES };
		VkPhysicalDeviceProperties2 props = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2 };
		props.pNext = &idProps;

		bool isVulkan11Supported = false;

		uint32 i = 0;
		for (; i < deviceGroupNum && m_PhysicalDevices.IsEmpty; i++)
		{
			readonly ref VkPhysicalDeviceGroupProperties group = ref deviceGroups[i];
			vkGetPhysicalDeviceProperties2(group.physicalDevices[0], &props);

			readonly uint32 majorVersion = VulkanNative.VK_API_VERSION_MAJOR(props.properties.apiVersion);
			readonly uint32 minorVersion = VulkanNative.VK_API_VERSION_MINOR(props.properties.apiVersion);
			isVulkan11Supported = majorVersion > 1 || (majorVersion == 1 && minorVersion >= 1);

			if (physicalDeviceGroup != null)
			{
				readonly uint64 luid = *(uint64*)&idProps.deviceLUID;
				if (luid == physicalDeviceGroup.luid)
				{
					RETURN_ON_FAILURE!(GetLogger(), isVulkan11Supported, Result.UNSUPPORTED,
						"Can't create a device: the specified physical device does not support Vulkan 1.1.");
					break;
				}
			}
			else
			{
				if (isVulkan11Supported)
					break;
			}
		}

		RETURN_ON_FAILURE!(GetLogger(), i != deviceGroupNum, Result.UNSUPPORTED,
			"Can't create a device: physical device not found.");

		/*readonly*/ ref VkPhysicalDeviceGroupProperties group = ref deviceGroups[i];

		m_IsSubsetAllocationSupported = true;
		if (group.subsetAllocation == VK_FALSE && group.physicalDeviceCount > 1)
		{
			m_IsSubsetAllocationSupported = false;
			REPORT_WARNING(GetLogger(), "The device group does not support memory allocation on a subset of the physical devices.");
		}

		m_PhysicalDevices.Insert(0, Span<VkPhysicalDevice>(&group.physicalDevices, group.physicalDeviceCount));

		if (!enableMGPU)
			m_PhysicalDevices.Resize(1);

		return Result.SUCCESS;
	}

	private Result CreateLogicalDevice(DeviceCreationDesc deviceCreationDesc)
	{
		uint32 extensionNum = 0;
		vkEnumerateDeviceExtensionProperties(m_PhysicalDevices.Front, null, &extensionNum, null);

		List<VkExtensionProperties> supportedExts = Allocate!<List<VkExtensionProperties>>(GetAllocator());
		defer
		{
			Deallocate!(GetAllocator(), supportedExts);
		}
		supportedExts.Resize(extensionNum);
		vkEnumerateDeviceExtensionProperties(m_PhysicalDevices.Front, null, &extensionNum, supportedExts.Ptr);

		List<char8*> desiredExts = Allocate!<List<char8*>>(GetAllocator());
		defer
		{
			Deallocate!(GetAllocator(), desiredExts);
		}
		for (uint32 i = 0; i < deviceCreationDesc.vulkanExtensions.deviceExtensionNum; i++)
			desiredExts.Add(deviceCreationDesc.vulkanExtensions.deviceExtensions[i]);

		if (IsExtensionSupported(VK_KHR_SWAPCHAIN_EXTENSION_NAME, supportedExts))
			desiredExts.Add(VK_KHR_SWAPCHAIN_EXTENSION_NAME);

		if (IsExtensionSupported(VK_KHR_DEFERRED_HOST_OPERATIONS_EXTENSION_NAME, supportedExts))
			desiredExts.Add(VK_KHR_DEFERRED_HOST_OPERATIONS_EXTENSION_NAME);

		if (IsExtensionSupported(VK_KHR_SYNCHRONIZATION_2_EXTENSION_NAME, supportedExts))
			desiredExts.Add(VK_KHR_SYNCHRONIZATION_2_EXTENSION_NAME);

		if (IsExtensionSupported(VK_KHR_PIPELINE_LIBRARY_EXTENSION_NAME, supportedExts))
			desiredExts.Add(VK_KHR_PIPELINE_LIBRARY_EXTENSION_NAME);

		if (IsExtensionSupported(VK_KHR_RAY_TRACING_PIPELINE_EXTENSION_NAME, supportedExts))
			desiredExts.Add(VK_KHR_RAY_TRACING_PIPELINE_EXTENSION_NAME);

		if (IsExtensionSupported(VK_KHR_RAY_QUERY_EXTENSION_NAME, supportedExts))
			desiredExts.Add(VK_KHR_RAY_QUERY_EXTENSION_NAME);

		if (IsExtensionSupported(VK_KHR_ACCELERATION_STRUCTURE_EXTENSION_NAME, supportedExts))
		{
			desiredExts.Add(VK_KHR_ACCELERATION_STRUCTURE_EXTENSION_NAME);
			m_IsRayTracingExtSupported = true;
		}

		if (IsExtensionSupported(VK_EXT_SAMPLE_LOCATIONS_EXTENSION_NAME, supportedExts))
		{
			desiredExts.Add(VK_EXT_SAMPLE_LOCATIONS_EXTENSION_NAME);
			m_IsSampleLocationExtSupported = true;
		}

		if (IsExtensionSupported(VK_EXT_CONSERVATIVE_RASTERIZATION_EXTENSION_NAME, supportedExts))
		{
			desiredExts.Add(VK_EXT_CONSERVATIVE_RASTERIZATION_EXTENSION_NAME);
			m_IsConservativeRasterExtSupported = true;
		}

		if (IsExtensionSupported(VK_EXT_HDR_METADATA_EXTENSION_NAME, supportedExts))
		{
			desiredExts.Add(VK_EXT_HDR_METADATA_EXTENSION_NAME);
			m_IsHDRExtSupported = true;
		}

		if (IsExtensionSupported(VK_EXT_OPACITY_MICROMAP_EXTENSION_NAME, supportedExts))
		{
			desiredExts.Add(VK_EXT_OPACITY_MICROMAP_EXTENSION_NAME);
			m_IsMicroMapSupported = true;
		}

		if (IsExtensionSupported(VK_EXT_MESH_SHADER_EXTENSION_NAME, supportedExts))
		{
			desiredExts.Add(VK_EXT_MESH_SHADER_EXTENSION_NAME);
			m_IsMeshShaderExtSupported = true;
		}

		VkPhysicalDeviceRayTracingPipelineFeaturesKHR rayTracingFeatures = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_RAY_TRACING_PIPELINE_FEATURES_KHR };
		VkPhysicalDeviceAccelerationStructureFeaturesKHR accelerationStructureFeatures = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_ACCELERATION_STRUCTURE_FEATURES_KHR };
		VkPhysicalDeviceRayQueryFeaturesKHR rayQueryFeatures = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_RAY_QUERY_FEATURES_KHR };
		VkPhysicalDeviceOpacityMicromapFeaturesEXT micromapFeatures = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_OPACITY_MICROMAP_FEATURES_EXT };
		VkPhysicalDeviceMeshShaderFeaturesEXT meshShaderFeatures = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_MESH_SHADER_FEATURES_EXT };
		VkPhysicalDeviceVulkan11Features features11 = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_1_FEATURES };
		VkPhysicalDeviceVulkan12Features features12 = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES };
		VkPhysicalDeviceVulkan13Features features13 = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_3_FEATURES };
		VkPhysicalDeviceFeatures2 features2 = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2 };

		features2.pNext = &features11;
		features11.pNext = &features12;
		features12.pNext = &features13;

		if (m_IsRayTracingExtSupported)
		{
			rayTracingFeatures.pNext = features2.pNext;
			features2.pNext = &rayTracingFeatures;
			accelerationStructureFeatures.pNext = features2.pNext;
			features2.pNext = &accelerationStructureFeatures;
			rayQueryFeatures.pNext = features2.pNext;
			features2.pNext = &rayQueryFeatures;
		}

		if (m_IsMicroMapSupported)
		{
			micromapFeatures.pNext = features2.pNext;
			features2.pNext = &micromapFeatures;
		}

		if (m_IsMeshShaderExtSupported)
		{
			meshShaderFeatures.pNext = features2.pNext;
			features2.pNext = &meshShaderFeatures;
		}

		vkGetPhysicalDeviceFeatures2(m_PhysicalDevices.Front, &features2);

		List<VkDeviceQueueCreateInfo> queues = Allocate!<List<VkDeviceQueueCreateInfo>>(GetAllocator());
		defer
		{
			Deallocate!(GetAllocator(), queues);
		}
		/*readonly*/ float priorities = 1.0f;
		for (uint i = 0; i < m_FamilyIndices.Count; i++)
		{
			if (m_FamilyIndices[i] == INVALID_FAMILY_INDEX)
				continue;

			VkDeviceQueueCreateInfo info = .() { sType = .VK_STRUCTURE_TYPE_DEVICE_QUEUE_CREATE_INFO };
			info.queueCount = 1;
			info.queueFamilyIndex = m_FamilyIndices[i];
			info.pQueuePriorities = &priorities;
			queues.Add(info);
		}

		VkDeviceCreateInfo deviceCreateInfo = .() { sType = .VK_STRUCTURE_TYPE_DEVICE_CREATE_INFO };
		deviceCreateInfo.pNext = &features2;
		deviceCreateInfo.queueCreateInfoCount = (uint32)queues.Count;
		deviceCreateInfo.pQueueCreateInfos = queues.Ptr;
		deviceCreateInfo.enabledExtensionCount = (uint32)desiredExts.Count;
		deviceCreateInfo.ppEnabledExtensionNames = desiredExts.Ptr;

		VkDeviceGroupDeviceCreateInfo deviceGroupInfo = .() { sType = .VK_STRUCTURE_TYPE_DEVICE_GROUP_DEVICE_CREATE_INFO };
		if (m_PhysicalDevices.Count > 1)
		{
			deviceGroupInfo.pNext = deviceCreateInfo.pNext;
			deviceGroupInfo.physicalDeviceCount = (uint32)m_PhysicalDevices.Count;
			deviceGroupInfo.pPhysicalDevices = m_PhysicalDevices.Ptr;
			deviceCreateInfo.pNext = &deviceGroupInfo;
		}

		readonly VkResult result = vkCreateDevice(m_PhysicalDevices.Front, &deviceCreateInfo, m_AllocationCallbackPtr, &m_Device);

		RETURN_ON_FAILURE!(GetLogger(), result == .VK_SUCCESS, GetReturnCode(result), "Can't create a device: vkCreateDevice returned {0}.", (int32)result);

		return Result.SUCCESS;
	}

	private void FillFamilyIndices(bool useEnabledFamilyIndices, uint32* enabledFamilyIndices, uint32 familyIndexNum)
	{
		uint32 familyNum = 0;
		vkGetPhysicalDeviceQueueFamilyProperties(m_PhysicalDevices.Front, &familyNum, null);

		List<VkQueueFamilyProperties> familyProps = Allocate!<List<VkQueueFamilyProperties>>(GetAllocator());
		familyProps.Resize(familyNum);
		defer
		{
			Deallocate!(GetAllocator(), familyProps);
		}
		vkGetPhysicalDeviceQueueFamilyProperties(m_PhysicalDevices.Front, &familyNum, familyProps.Ptr);

		Internal.MemSet(&m_FamilyIndices, (.)INVALID_FAMILY_INDEX, m_FamilyIndices.Count * sizeof(uint32));

		for (uint32 i = 0; i < familyProps.Count; i++)
		{
			readonly VkQueueFlags mask = familyProps[i].queueFlags;
			readonly bool graphics = mask.HasFlag(.VK_QUEUE_GRAPHICS_BIT);
			readonly bool compute = mask.HasFlag(.VK_QUEUE_COMPUTE_BIT);
			readonly bool copy = mask.HasFlag(.VK_QUEUE_TRANSFER_BIT);

			if (useEnabledFamilyIndices)
			{
				bool isFamilyEnabled = false;
				for (uint32 j = 0; j < familyIndexNum && !isFamilyEnabled; j++)
					isFamilyEnabled = enabledFamilyIndices[j] == i;

				if (!isFamilyEnabled)
					continue;
			}

			if (graphics)
				m_FamilyIndices[(uint32)CommandQueueType.GRAPHICS] = i;
			else if (compute)
				m_FamilyIndices[(uint32)CommandQueueType.COMPUTE] = i;
			else if (copy)
				m_FamilyIndices[(uint32)CommandQueueType.COPY] = i;
		}
	}

	private void SetDeviceLimits(bool enableValidation)
	{
		uint32 familyNum = 0;
		vkGetPhysicalDeviceQueueFamilyProperties(m_PhysicalDevices.Front, &familyNum, null);

		List<VkQueueFamilyProperties> familyProperties = Allocate!<List<VkQueueFamilyProperties>>(GetAllocator());
		defer { Deallocate!(GetAllocator(), familyProperties); }
		familyProperties.Resize(familyNum);
		vkGetPhysicalDeviceQueueFamilyProperties(m_PhysicalDevices.Front, &familyNum, familyProperties.Ptr);

		uint32 copyQueueTimestampValidBits = 0;
		readonly uint32 copyQueueFamilyIndex = m_FamilyIndices[(uint32)CommandQueueType.COPY];
		if (copyQueueFamilyIndex != INVALID_FAMILY_INDEX)
			copyQueueTimestampValidBits = familyProperties[copyQueueFamilyIndex].timestampValidBits;

		VkPhysicalDeviceIDProperties deviceIDProps = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_ID_PROPERTIES };
		VkPhysicalDeviceProperties2 props = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_PROPERTIES_2, pNext = &deviceIDProps };

		vkGetPhysicalDeviceProperties2(m_PhysicalDevices.Front, &props);
		readonly ref VkPhysicalDeviceLimits limits = ref props.properties.limits;

		VkPhysicalDeviceFeatures features = .();
		vkGetPhysicalDeviceFeatures(m_PhysicalDevices.Front, &features);

		VkPhysicalDeviceVulkan12Features features12 = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_VULKAN_1_2_FEATURES };
		VkPhysicalDeviceFeatures2 features2 = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_FEATURES_2, pNext = &features12 };

		vkGetPhysicalDeviceFeatures2(m_PhysicalDevices.Front, &features2);

		m_IsDescriptorIndexingSupported = features12.descriptorIndexing ? true : false;
		m_IsBufferDeviceAddressSupported = features12.bufferDeviceAddress ? true : false;

		Compiler.Assert(VK_LUID_SIZE == sizeof(uint64), "invalid sizeof");
		m_LUID = *(uint64*)&deviceIDProps.deviceLUID;

		m_DeviceDesc.graphicsAPI = GraphicsAPI.VULKAN;
		m_DeviceDesc.vendor = GetVendorFromID(props.properties.vendorID);
		m_DeviceDesc.nriVersionMajor = 1; //NRI_VERSION_MAJOR;
		m_DeviceDesc.nriVersionMinor = 0; //NRI_VERSION_MINOR;

		m_DeviceDesc.viewportMaxNum = limits.maxViewports;
		m_DeviceDesc.viewportSubPixelBits = limits.viewportSubPixelBits;
		m_DeviceDesc.viewportBoundsRange[0] = int32(limits.viewportBoundsRange[0]);
		m_DeviceDesc.viewportBoundsRange[1] = int32(limits.viewportBoundsRange[1]);

		m_DeviceDesc.frameBufferMaxDim = Math.Min(limits.maxFramebufferWidth, limits.maxFramebufferHeight);
		m_DeviceDesc.frameBufferLayerMaxNum = limits.maxFramebufferLayers;
		m_DeviceDesc.framebufferColorAttachmentMaxNum = limits.maxColorAttachments;

		m_DeviceDesc.frameBufferColorSampleMaxNum = (uint8)(limits.framebufferColorSampleCounts);
		m_DeviceDesc.frameBufferDepthSampleMaxNum = (uint8)(limits.framebufferDepthSampleCounts);
		m_DeviceDesc.frameBufferStencilSampleMaxNum = (uint8)(limits.framebufferStencilSampleCounts);
		m_DeviceDesc.frameBufferNoAttachmentsSampleMaxNum = (uint8)(limits.framebufferNoAttachmentsSampleCounts);
		m_DeviceDesc.textureColorSampleMaxNum = (uint8)(limits.sampledImageColorSampleCounts);
		m_DeviceDesc.textureIntegerSampleMaxNum = (uint8)(limits.sampledImageIntegerSampleCounts);
		m_DeviceDesc.textureDepthSampleMaxNum = (uint8)(limits.sampledImageDepthSampleCounts);
		m_DeviceDesc.textureStencilSampleMaxNum = (uint8)(limits.sampledImageStencilSampleCounts);
		m_DeviceDesc.storageTextureSampleMaxNum = (uint8)(limits.storageImageSampleCounts);

		m_DeviceDesc.texture1DMaxDim = limits.maxImageDimension1D;
		m_DeviceDesc.texture2DMaxDim = limits.maxImageDimension2D;
		m_DeviceDesc.texture3DMaxDim = limits.maxImageDimension3D;
		m_DeviceDesc.textureArrayMaxDim = limits.maxImageArrayLayers;
		m_DeviceDesc.texelBufferMaxDim = limits.maxTexelBufferElements;

		m_DeviceDesc.memoryAllocationMaxNum = limits.maxMemoryAllocationCount;
		m_DeviceDesc.samplerAllocationMaxNum = limits.maxSamplerAllocationCount;
		m_DeviceDesc.uploadBufferTextureRowAlignment = 1;
		m_DeviceDesc.uploadBufferTextureSliceAlignment = 1;
		m_DeviceDesc.typedBufferOffsetAlignment = (uint32)limits.minTexelBufferOffsetAlignment;
		m_DeviceDesc.constantBufferOffsetAlignment = (uint32)limits.minUniformBufferOffsetAlignment;
		m_DeviceDesc.constantBufferMaxRange = limits.maxUniformBufferRange;
		m_DeviceDesc.storageBufferOffsetAlignment = (uint32)limits.minStorageBufferOffsetAlignment;
		m_DeviceDesc.storageBufferMaxRange = limits.maxStorageBufferRange;
		m_DeviceDesc.pushConstantsMaxSize = limits.maxPushConstantsSize;
		m_DeviceDesc.bufferMaxSize = uint64.MaxValue;
		m_DeviceDesc.bufferTextureGranularity = (uint32)limits.bufferImageGranularity;

		m_DeviceDesc.boundDescriptorSetMaxNum = limits.maxBoundDescriptorSets;
		m_DeviceDesc.perStageDescriptorSamplerMaxNum = limits.maxPerStageDescriptorSamplers;
		m_DeviceDesc.perStageDescriptorConstantBufferMaxNum = limits.maxPerStageDescriptorUniformBuffers;
		m_DeviceDesc.perStageDescriptorStorageBufferMaxNum = limits.maxPerStageDescriptorStorageBuffers;
		m_DeviceDesc.perStageDescriptorTextureMaxNum = limits.maxPerStageDescriptorSampledImages;
		m_DeviceDesc.perStageDescriptorStorageTextureMaxNum = limits.maxPerStageDescriptorStorageImages;
		m_DeviceDesc.perStageResourceMaxNum = limits.maxPerStageResources;

		m_DeviceDesc.descriptorSetSamplerMaxNum = limits.maxDescriptorSetSamplers;
		m_DeviceDesc.descriptorSetConstantBufferMaxNum = limits.maxDescriptorSetUniformBuffers;
		m_DeviceDesc.descriptorSetStorageBufferMaxNum = limits.maxDescriptorSetStorageBuffers;
		m_DeviceDesc.descriptorSetTextureMaxNum = limits.maxDescriptorSetSampledImages;
		m_DeviceDesc.descriptorSetStorageTextureMaxNum = limits.maxDescriptorSetStorageImages;

		m_DeviceDesc.vertexShaderAttributeMaxNum = limits.maxVertexInputAttributes;
		m_DeviceDesc.vertexShaderStreamMaxNum = limits.maxVertexInputBindings;
		m_DeviceDesc.vertexShaderOutputComponentMaxNum = limits.maxVertexOutputComponents;

		m_DeviceDesc.tessControlShaderGenerationMaxLevel = (float)limits.maxTessellationGenerationLevel;
		m_DeviceDesc.tessControlShaderPatchPointMaxNum = limits.maxTessellationPatchSize;
		m_DeviceDesc.tessControlShaderPerVertexInputComponentMaxNum = limits.maxTessellationControlPerVertexInputComponents;
		m_DeviceDesc.tessControlShaderPerVertexOutputComponentMaxNum = limits.maxTessellationControlPerVertexOutputComponents;
		m_DeviceDesc.tessControlShaderPerPatchOutputComponentMaxNum = limits.maxTessellationControlPerPatchOutputComponents;
		m_DeviceDesc.tessControlShaderTotalOutputComponentMaxNum = limits.maxTessellationControlTotalOutputComponents;

		m_DeviceDesc.tessEvaluationShaderInputComponentMaxNum = limits.maxTessellationEvaluationInputComponents;
		m_DeviceDesc.tessEvaluationShaderOutputComponentMaxNum = limits.maxTessellationEvaluationOutputComponents;

		m_DeviceDesc.geometryShaderInvocationMaxNum = limits.maxGeometryShaderInvocations;
		m_DeviceDesc.geometryShaderInputComponentMaxNum = limits.maxGeometryInputComponents;
		m_DeviceDesc.geometryShaderOutputComponentMaxNum = limits.maxGeometryOutputComponents;
		m_DeviceDesc.geometryShaderOutputVertexMaxNum = limits.maxGeometryOutputVertices;
		m_DeviceDesc.geometryShaderTotalOutputComponentMaxNum = limits.maxGeometryTotalOutputComponents;

		m_DeviceDesc.fragmentShaderInputComponentMaxNum = limits.maxFragmentInputComponents;
		m_DeviceDesc.fragmentShaderOutputAttachmentMaxNum = limits.maxFragmentOutputAttachments;
		m_DeviceDesc.fragmentShaderDualSourceAttachmentMaxNum = limits.maxFragmentDualSrcAttachments;
		m_DeviceDesc.fragmentShaderCombinedOutputResourceMaxNum = limits.maxFragmentCombinedOutputResources;

		m_DeviceDesc.computeShaderSharedMemoryMaxSize = limits.maxComputeSharedMemorySize;
		m_DeviceDesc.computeShaderWorkGroupMaxNum[0] = limits.maxComputeWorkGroupCount[0];
		m_DeviceDesc.computeShaderWorkGroupMaxNum[1] = limits.maxComputeWorkGroupCount[1];
		m_DeviceDesc.computeShaderWorkGroupMaxNum[2] = limits.maxComputeWorkGroupCount[2];
		m_DeviceDesc.computeShaderWorkGroupInvocationMaxNum = limits.maxComputeWorkGroupInvocations;
		m_DeviceDesc.computeShaderWorkGroupMaxDim[0] = limits.maxComputeWorkGroupSize[0];
		m_DeviceDesc.computeShaderWorkGroupMaxDim[1] = limits.maxComputeWorkGroupSize[1];
		m_DeviceDesc.computeShaderWorkGroupMaxDim[2] = limits.maxComputeWorkGroupSize[2];

		m_DeviceDesc.timestampFrequencyHz = uint64(1e9 / double(limits.timestampPeriod) + 0.5);
		m_DeviceDesc.subPixelPrecisionBits = limits.subPixelPrecisionBits;
		m_DeviceDesc.subTexelPrecisionBits = limits.subTexelPrecisionBits;
		m_DeviceDesc.mipmapPrecisionBits = limits.mipmapPrecisionBits;
		m_DeviceDesc.drawIndexedIndex16ValueMax = Math.Min<uint32>(uint16.MaxValue, limits.maxDrawIndexedIndexValue);
		m_DeviceDesc.drawIndexedIndex32ValueMax = limits.maxDrawIndexedIndexValue;
		m_DeviceDesc.drawIndirectMaxNum = limits.maxDrawIndirectCount;
		m_DeviceDesc.samplerLodBiasMin = -limits.maxSamplerLodBias;
		m_DeviceDesc.samplerLodBiasMax = limits.maxSamplerLodBias;
		m_DeviceDesc.samplerAnisotropyMax = limits.maxSamplerAnisotropy;
		m_DeviceDesc.texelOffsetMin = limits.minTexelOffset;
		m_DeviceDesc.texelOffsetMax = limits.maxTexelOffset;
		m_DeviceDesc.texelGatherOffsetMin = limits.minTexelGatherOffset;
		m_DeviceDesc.texelGatherOffsetMax = limits.maxTexelGatherOffset;
		m_DeviceDesc.clipDistanceMaxNum = limits.maxClipDistances;
		m_DeviceDesc.cullDistanceMaxNum = limits.maxCullDistances;
		m_DeviceDesc.combinedClipAndCullDistanceMaxNum = limits.maxCombinedClipAndCullDistances;
		m_DeviceDesc.physicalDeviceNum = (uint8)m_PhysicalDevices.Count;

		m_DeviceDesc.isAPIValidationEnabled = enableValidation;
		m_DeviceDesc.isTextureFilterMinMaxSupported = features12.samplerFilterMinmax;
		m_DeviceDesc.isLogicOpSupported = features.logicOp;
		m_DeviceDesc.isDepthBoundsTestSupported = features.depthBounds;
		m_DeviceDesc.isProgrammableSampleLocationsSupported = m_IsSampleLocationExtSupported;
		m_DeviceDesc.isComputeQueueSupported = m_Queues[(uint32)CommandQueueType.COMPUTE] != null;
		m_DeviceDesc.isCopyQueueSupported = m_Queues[(uint32)CommandQueueType.COPY] != null;
		m_DeviceDesc.isCopyQueueTimestampSupported = copyQueueTimestampValidBits == 64;
		m_DeviceDesc.isRegisterAliasingSupported = true;
		m_DeviceDesc.isSubsetAllocationSupported = m_IsSubsetAllocationSupported;
		m_DeviceDesc.isFloat16Supported = features12.shaderFloat16;

		// Conservative raster
		if (m_IsConservativeRasterExtSupported)
		{
			VkPhysicalDeviceConservativeRasterizationPropertiesEXT conservativeRasterProps = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_CONSERVATIVE_RASTERIZATION_PROPERTIES_EXT };

			props.pNext = &conservativeRasterProps;

			vkGetPhysicalDeviceProperties2(m_PhysicalDevices.Front, &props);

			if (conservativeRasterProps.fullyCoveredFragmentShaderInputVariable && conservativeRasterProps.primitiveOverestimationSize <= (1.0 / 256.0f))
				m_DeviceDesc.conservativeRasterTier = 3;
			else if (conservativeRasterProps.degenerateTrianglesRasterized && conservativeRasterProps.primitiveOverestimationSize < (1.0f / 2.0f))
				m_DeviceDesc.conservativeRasterTier = 2;
			else
				m_DeviceDesc.conservativeRasterTier = 1;
		}

		// Ray tracing
		if (m_IsRayTracingExtSupported)
		{
			VkPhysicalDeviceRayTracingPipelinePropertiesKHR rayTracingProps = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_RAY_TRACING_PIPELINE_PROPERTIES_KHR };
			VkPhysicalDeviceAccelerationStructurePropertiesKHR accelerationStructureProperties = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_ACCELERATION_STRUCTURE_PROPERTIES_KHR };

			props.pNext = &rayTracingProps;
			rayTracingProps.pNext = &accelerationStructureProperties;

			vkGetPhysicalDeviceProperties2(m_PhysicalDevices.Front, &props);

			m_DeviceDesc.rayTracingShaderGroupIdentifierSize = rayTracingProps.shaderGroupHandleSize;
			m_DeviceDesc.rayTracingShaderRecursionMaxDepth = rayTracingProps.maxRayRecursionDepth;
			m_DeviceDesc.rayTracingGeometryObjectMaxNum = (uint32)accelerationStructureProperties.maxGeometryCount;
			m_DeviceDesc.rayTracingShaderTableAligment = rayTracingProps.shaderGroupBaseAlignment;
			m_DeviceDesc.rayTracingShaderTableMaxStride = rayTracingProps.maxShaderGroupStride;
		}

		// Mesh shader
		if (!m_IsMeshShaderExtSupported)
		{
			VkPhysicalDeviceMeshShaderPropertiesEXT meshShaderProps = .() { sType = .VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_MESH_SHADER_PROPERTIES_EXT };

			props.pNext = &meshShaderProps;

			vkGetPhysicalDeviceProperties2(m_PhysicalDevices.Front, &props);

			m_DeviceDesc.meshTaskWorkGroupInvocationMaxNum = meshShaderProps.maxTaskWorkGroupInvocations;
			m_DeviceDesc.meshTaskWorkGroupMaxDim[0] = meshShaderProps.maxTaskWorkGroupSize[0];
			m_DeviceDesc.meshTaskWorkGroupMaxDim[1] = meshShaderProps.maxTaskWorkGroupSize[1];
			m_DeviceDesc.meshTaskWorkGroupMaxDim[2] = meshShaderProps.maxTaskWorkGroupSize[2];
			m_DeviceDesc.meshTaskTotalMemoryMaxSize = meshShaderProps.maxTaskPayloadAndSharedMemorySize;
			m_DeviceDesc.meshTaskOutputMaxNum = meshShaderProps.maxMeshWorkGroupTotalCount;
			m_DeviceDesc.meshWorkGroupInvocationMaxNum = meshShaderProps.maxMeshWorkGroupInvocations;
			m_DeviceDesc.meshWorkGroupMaxDim[0] = meshShaderProps.maxMeshWorkGroupSize[0];
			m_DeviceDesc.meshWorkGroupMaxDim[1] = meshShaderProps.maxMeshWorkGroupSize[1];
			m_DeviceDesc.meshWorkGroupMaxDim[2] = meshShaderProps.maxMeshWorkGroupSize[2];
			m_DeviceDesc.meshOutputVertexMaxNum = meshShaderProps.maxMeshOutputVertices;
			m_DeviceDesc.meshOutputPrimitiveMaxNum = meshShaderProps.maxMeshOutputPrimitives;
			m_DeviceDesc.meshMultiviewViewMaxNum = meshShaderProps.maxMeshMultiviewViewCount;
			m_DeviceDesc.meshOutputPerVertexGranularity = meshShaderProps.meshOutputPerVertexGranularity;
			m_DeviceDesc.meshOutputPerPrimitiveGranularity = meshShaderProps.meshOutputPerPrimitiveGranularity;
		}
	}

	private void CreateCommandQueues()
	{
		for (uint32 i = 0; i < m_FamilyIndices.Count; i++)
		{
			if (m_FamilyIndices[i] == INVALID_FAMILY_INDEX)
				continue;

			VkQueue handle = .Null;
			vkGetDeviceQueue(m_Device, m_FamilyIndices[i], 0, &handle);

			m_Queues[i] = Allocate!<CommandQueueVK>(GetAllocator(), this, handle, m_FamilyIndices[i], (CommandQueueType)i);
			m_ConcurrentSharingModeQueueIndices.Add(m_FamilyIndices[i]);
		}
	}

	private mixin RESOLVE_OPTIONAL_DEVICE_FUNCTION(String name)
	{
		String vkName = scope $"vk{name}";
		VulkanNative.LoadFunction(vkName, false).IgnoreError();
	}

	private mixin RESOLVE_DEVICE_FUNCTION(String name)
	{
		String vkName = scope $"vk{name}";
		if (VulkanNative.LoadFunction(vkName, false) case .Err)
		{
			REPORT_ERROR(GetLogger(), "Failed to get device function: '{}'.", vkName);
			return Result.UNSUPPORTED;
		}
	}

	private mixin RESOLVE_DEVICE_FUNCTION_WITH_OTHER_NAME(String name, String otherName)
	{
		String vkName = scope $"{otherName}";
		if (VulkanNative.LoadFunction(vkName, false) case .Err)
		{
			REPORT_ERROR(GetLogger(), "Failed to get device function: '{}'.", vkName);
			return Result.UNSUPPORTED;
		}
	}

	private mixin RESOLVE_INSTANCE_FUNCTION(String name)
	{
		String vkName = scope $"vk{name}";
		if (VulkanNative.LoadFunction(vkName, false) case .Err)
		{
			REPORT_ERROR(GetLogger(), "Failed to get instance function: '{}'.", vkName);
			return Result.UNSUPPORTED;
		}
	}

	private mixin RESOLVE_PRE_INSTANCE_FUNCTION(String name)
	{
		String vkName = scope $"vk{name}";
		if (VulkanNative.LoadFunction(vkName, false) case .Err)
		{
			REPORT_ERROR(GetLogger(), "Failed to get instance function: '{}'.", vkName);
			return Result.UNSUPPORTED;
		}
	}

	private Result ResolvePreInstanceDispatchTable()
	{
		if (VulkanNative.LoadFunction("vkGetInstanceProcAddr", false) case .Err)
		{
			REPORT_ERROR(GetLogger(), "Failed to get vkGetInstanceProcAddr.");
			return Result.UNSUPPORTED;
		}

		RESOLVE_PRE_INSTANCE_FUNCTION!("CreateInstance");
		RESOLVE_PRE_INSTANCE_FUNCTION!("EnumerateInstanceExtensionProperties");
		RESOLVE_PRE_INSTANCE_FUNCTION!("EnumerateInstanceLayerProperties");

		return Result.SUCCESS;
	}

	private Result ResolveInstanceDispatchTable()
	{
		RESOLVE_INSTANCE_FUNCTION!("GetDeviceProcAddr");
		RESOLVE_INSTANCE_FUNCTION!("DestroyInstance");
		RESOLVE_INSTANCE_FUNCTION!("DestroyDevice");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceMemoryProperties");
		RESOLVE_INSTANCE_FUNCTION!("GetDeviceGroupPeerMemoryFeatures");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceFormatProperties");
		RESOLVE_INSTANCE_FUNCTION!("CreateDevice");
		RESOLVE_INSTANCE_FUNCTION!("GetDeviceQueue");
		RESOLVE_INSTANCE_FUNCTION!("EnumeratePhysicalDeviceGroups");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceProperties");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceProperties2");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceFeatures");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceFeatures2");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceQueueFamilyProperties");
		RESOLVE_INSTANCE_FUNCTION!("EnumerateDeviceExtensionProperties");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceSurfaceFormatsKHR");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceSurfaceSupportKHR");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceSurfaceCapabilitiesKHR");
		RESOLVE_INSTANCE_FUNCTION!("GetPhysicalDeviceSurfacePresentModesKHR");
		RESOLVE_INSTANCE_FUNCTION!("DestroySurfaceKHR");

#if true //VK_USE_PLATFORM_WIN32_KHR
		RESOLVE_INSTANCE_FUNCTION!("CreateWin32SurfaceKHR");
#endif
#if VK_USE_PLATFORM_METAL_EXT
		RESOLVE_INSTANCE_FUNCTION!("CreateMetalSurfaceEXT");
#endif
#if VK_USE_PLATFORM_XLIB_KHR
		RESOLVE_INSTANCE_FUNCTION!("CreateXlibSurfaceKHR");
#endif
#if VK_USE_PLATFORM_WAYLAND_KHR
		RESOLVE_INSTANCE_FUNCTION!("CreateWaylandSurfaceKHR");
#endif

		return Result.SUCCESS;
	}

	private Result ResolveDispatchTable()
	{
		RESOLVE_DEVICE_FUNCTION!("CreateBuffer");
		RESOLVE_DEVICE_FUNCTION!("CreateImage");
		RESOLVE_DEVICE_FUNCTION!("CreateBufferView");
		RESOLVE_DEVICE_FUNCTION!("CreateImageView");
		RESOLVE_DEVICE_FUNCTION!("CreateSampler");
		RESOLVE_DEVICE_FUNCTION!("CreateRenderPass");
		RESOLVE_DEVICE_FUNCTION!("CreateFramebuffer");
		RESOLVE_DEVICE_FUNCTION!("CreateQueryPool");
		RESOLVE_DEVICE_FUNCTION!("CreateCommandPool");
		RESOLVE_DEVICE_FUNCTION!("CreateSemaphore");
		RESOLVE_DEVICE_FUNCTION!("CreateDescriptorPool");
		RESOLVE_DEVICE_FUNCTION!("CreatePipelineLayout");
		RESOLVE_DEVICE_FUNCTION!("CreateDescriptorSetLayout");
		RESOLVE_DEVICE_FUNCTION!("CreateShaderModule");
		RESOLVE_DEVICE_FUNCTION!("CreateGraphicsPipelines");
		RESOLVE_DEVICE_FUNCTION!("CreateComputePipelines");
		RESOLVE_DEVICE_FUNCTION!("CreateSwapchainKHR");

		RESOLVE_DEVICE_FUNCTION!("DestroyBuffer");
		RESOLVE_DEVICE_FUNCTION!("DestroyImage");
		RESOLVE_DEVICE_FUNCTION!("DestroyBufferView");
		RESOLVE_DEVICE_FUNCTION!("DestroyImageView");
		RESOLVE_DEVICE_FUNCTION!("DestroySampler");
		RESOLVE_DEVICE_FUNCTION!("DestroyRenderPass");
		RESOLVE_DEVICE_FUNCTION!("DestroyFramebuffer");
		RESOLVE_DEVICE_FUNCTION!("DestroyQueryPool");
		RESOLVE_DEVICE_FUNCTION!("DestroyCommandPool");
		RESOLVE_DEVICE_FUNCTION!("DestroySemaphore");
		RESOLVE_DEVICE_FUNCTION!("DestroyDescriptorPool");
		RESOLVE_DEVICE_FUNCTION!("DestroyPipelineLayout");
		RESOLVE_DEVICE_FUNCTION!("DestroyDescriptorSetLayout");
		RESOLVE_DEVICE_FUNCTION!("DestroyShaderModule");
		RESOLVE_DEVICE_FUNCTION!("DestroyPipeline");
		RESOLVE_DEVICE_FUNCTION!("DestroySwapchainKHR");

		RESOLVE_DEVICE_FUNCTION!("AllocateMemory");
		RESOLVE_DEVICE_FUNCTION!("MapMemory");
		RESOLVE_DEVICE_FUNCTION!("UnmapMemory");
		RESOLVE_DEVICE_FUNCTION!("FreeMemory");

		RESOLVE_OPTIONAL_DEVICE_FUNCTION!("BindBufferMemory2");
		if ([Friend]vkBindBufferMemory2_ptr == null)
			RESOLVE_DEVICE_FUNCTION_WITH_OTHER_NAME!("BindBufferMemory2", "vkBindBufferMemory2KHR");

		RESOLVE_OPTIONAL_DEVICE_FUNCTION!("BindImageMemory2");
		if ([Friend]vkBindImageMemory2_ptr == null)
			RESOLVE_DEVICE_FUNCTION_WITH_OTHER_NAME!("BindImageMemory2", "vkBindImageMemory2KHR");

		RESOLVE_OPTIONAL_DEVICE_FUNCTION!("GetBufferMemoryRequirements2");
		if ([Friend]vkGetBufferMemoryRequirements2_ptr == null)
			RESOLVE_DEVICE_FUNCTION_WITH_OTHER_NAME!("GetBufferMemoryRequirements2", "vkGetBufferMemoryRequirements2KHR");

		RESOLVE_OPTIONAL_DEVICE_FUNCTION!("GetImageMemoryRequirements2");
		if ([Friend]vkGetImageMemoryRequirements2_ptr == null)
			RESOLVE_DEVICE_FUNCTION_WITH_OTHER_NAME!("GetImageMemoryRequirements2", "vkGetImageMemoryRequirements2KHR");

		RESOLVE_DEVICE_FUNCTION!("QueueWaitIdle");
		RESOLVE_DEVICE_FUNCTION!("AcquireNextImageKHR");
		RESOLVE_DEVICE_FUNCTION!("QueueSubmit");
		RESOLVE_DEVICE_FUNCTION!("QueuePresentKHR");

		RESOLVE_DEVICE_FUNCTION!("GetSemaphoreCounterValue");
		RESOLVE_DEVICE_FUNCTION!("WaitSemaphores");

		RESOLVE_DEVICE_FUNCTION!("ResetCommandPool");
		RESOLVE_DEVICE_FUNCTION!("ResetDescriptorPool");
		RESOLVE_DEVICE_FUNCTION!("AllocateCommandBuffers");
		RESOLVE_DEVICE_FUNCTION!("AllocateDescriptorSets");
		RESOLVE_DEVICE_FUNCTION!("FreeCommandBuffers");
		RESOLVE_DEVICE_FUNCTION!("FreeDescriptorSets");
		RESOLVE_DEVICE_FUNCTION!("UpdateDescriptorSets");

		RESOLVE_DEVICE_FUNCTION!("BeginCommandBuffer");
		RESOLVE_DEVICE_FUNCTION!("CmdSetDepthBounds");
		RESOLVE_DEVICE_FUNCTION!("CmdSetViewport");
		RESOLVE_DEVICE_FUNCTION!("CmdSetScissor");
		RESOLVE_DEVICE_FUNCTION!("CmdSetStencilReference");
		RESOLVE_DEVICE_FUNCTION!("CmdClearAttachments");
		RESOLVE_DEVICE_FUNCTION!("CmdClearColorImage");
		RESOLVE_DEVICE_FUNCTION!("CmdBeginRenderPass");
		RESOLVE_DEVICE_FUNCTION!("CmdBindVertexBuffers");
		RESOLVE_DEVICE_FUNCTION!("CmdBindIndexBuffer");
		RESOLVE_DEVICE_FUNCTION!("CmdBindPipeline");
		RESOLVE_DEVICE_FUNCTION!("CmdBindDescriptorSets");
		RESOLVE_DEVICE_FUNCTION!("CmdPushConstants");
		RESOLVE_DEVICE_FUNCTION!("CmdDispatch");
		RESOLVE_DEVICE_FUNCTION!("CmdDispatchIndirect");
		RESOLVE_DEVICE_FUNCTION!("CmdDraw");
		RESOLVE_DEVICE_FUNCTION!("CmdDrawIndexed");
		RESOLVE_DEVICE_FUNCTION!("CmdDrawIndirect");
		RESOLVE_DEVICE_FUNCTION!("CmdDrawIndexedIndirect");
		RESOLVE_DEVICE_FUNCTION!("CmdCopyBuffer");
		RESOLVE_DEVICE_FUNCTION!("CmdCopyImage");
		RESOLVE_DEVICE_FUNCTION!("CmdCopyBufferToImage");
		RESOLVE_DEVICE_FUNCTION!("CmdCopyImageToBuffer");
		RESOLVE_DEVICE_FUNCTION!("CmdPipelineBarrier");
		RESOLVE_DEVICE_FUNCTION!("CmdBeginQuery");
		RESOLVE_DEVICE_FUNCTION!("CmdEndQuery");
		RESOLVE_DEVICE_FUNCTION!("CmdWriteTimestamp");
		RESOLVE_DEVICE_FUNCTION!("CmdCopyQueryPoolResults");
		RESOLVE_DEVICE_FUNCTION!("CmdResetQueryPool");
		RESOLVE_DEVICE_FUNCTION!("CmdEndRenderPass");
		RESOLVE_DEVICE_FUNCTION!("CmdFillBuffer");
		RESOLVE_DEVICE_FUNCTION!("EndCommandBuffer");

		RESOLVE_DEVICE_FUNCTION!("GetSwapchainImagesKHR");

		if (m_IsDebugUtilsSupported)
		{
			RESOLVE_DEVICE_FUNCTION!("SetDebugUtilsObjectNameEXT");
			RESOLVE_DEVICE_FUNCTION!("CmdBeginDebugUtilsLabelEXT");
			RESOLVE_DEVICE_FUNCTION!("CmdEndDebugUtilsLabelEXT");
		}

		if (m_IsHDRExtSupported)
		{
			RESOLVE_OPTIONAL_DEVICE_FUNCTION!("SetHdrMetadataEXT");
			m_IsHDRExtSupported = [Friend]vkSetHdrMetadataEXT_ptr != null;
		}

		if (m_IsRayTracingExtSupported)
		{
			RESOLVE_DEVICE_FUNCTION!("CreateAccelerationStructureKHR");
			RESOLVE_DEVICE_FUNCTION!("CreateRayTracingPipelinesKHR");
			RESOLVE_DEVICE_FUNCTION!("DestroyAccelerationStructureKHR");
			RESOLVE_DEVICE_FUNCTION!("GetAccelerationStructureDeviceAddressKHR");
			RESOLVE_DEVICE_FUNCTION!("GetAccelerationStructureBuildSizesKHR");
			RESOLVE_DEVICE_FUNCTION!("GetRayTracingShaderGroupHandlesKHR");
			RESOLVE_DEVICE_FUNCTION!("CmdBuildAccelerationStructuresKHR");
			RESOLVE_DEVICE_FUNCTION!("CmdCopyAccelerationStructureKHR");
			RESOLVE_DEVICE_FUNCTION!("CmdWriteAccelerationStructuresPropertiesKHR");
			RESOLVE_DEVICE_FUNCTION!("CmdTraceRaysKHR");
			RESOLVE_DEVICE_FUNCTION!("GetBufferDeviceAddress");
		}

		if (m_IsMeshShaderExtSupported)
		{
			RESOLVE_DEVICE_FUNCTION!("CmdDrawMeshTasksEXT");
		}

		return Result.SUCCESS;
	}

	private void FilterInstanceLayers(List<char8*> layers)
	{
		uint32 layerNum = 0;
		vkEnumerateInstanceLayerProperties(&layerNum, null);

		List<VkLayerProperties> supportedLayers = Allocate!<List<VkLayerProperties>>(GetAllocator());
		supportedLayers.Resize(layerNum);
		defer
		{
			Deallocate!(GetAllocator(), supportedLayers);
		}
		vkEnumerateInstanceLayerProperties(&layerNum, supportedLayers.Ptr);

		for (int i = 0; i < layers.Count; i++)
		{
			bool found = false;
			for (uint32 j = 0; j < layerNum && !found; j++)
			{
				if (String.Equals(&supportedLayers[j].layerName, layers[i]))
					found = true;
			}

			if (!found)
				layers.RemoveAt(i--);
		}
	}

	private void ReportDeviceGroupInfo()
	{
		REPORT_INFO(GetLogger(), "Available device memory heaps:");

		for (uint32 i = 0; i < m_MemoryProps.memoryHeapCount; i++)
		{
			String text = scope String();

			if (m_MemoryProps.memoryHeaps[i].flags.HasFlag(.VK_MEMORY_HEAP_DEVICE_LOCAL_BIT))
				text.Append("DEVICE_LOCAL_BIT ");

			if (m_MemoryProps.memoryHeaps[i].flags.HasFlag(.VK_MEMORY_HEAP_MULTI_INSTANCE_BIT))
				text.Append("MULTI_INSTANCE_BIT ");

			readonly double size = double(m_MemoryProps.memoryHeaps[i].size) / (1024.0 * 1024.0);

			REPORT_INFO(GetLogger(), "\tHeap{0} {1}MiB - {2}", i, size, text);

			if (m_DeviceDesc.physicalDeviceNum == 1)
				continue;

			for (uint32 j = 0; j < m_DeviceDesc.physicalDeviceNum; j++)
			{
				REPORT_INFO(GetLogger(), "\t\tPhysicalDevice{0}", j);

				for (uint32 k = 0; k < m_DeviceDesc.physicalDeviceNum; k++)
				{
					if (j == k)
						continue;

					VkPeerMemoryFeatureFlags flags = 0;
					vkGetDeviceGroupPeerMemoryFeatures(m_Device, i, j, k, &flags);

					text.Clear();
					if (flags.HasFlag(.VK_PEER_MEMORY_FEATURE_COPY_SRC_BIT))
						text.Append("COPY_SRC_BIT ");
					if (flags.HasFlag(.VK_PEER_MEMORY_FEATURE_COPY_DST_BIT))
						text.Append("COPY_DST_BIT ");
					if (flags.HasFlag(.VK_PEER_MEMORY_FEATURE_GENERIC_SRC_BIT))
						text.Append("GENERIC_SRC_BIT ");
					if (flags.HasFlag(.VK_PEER_MEMORY_FEATURE_GENERIC_DST_BIT))
						text.Append("GENERIC_DST_BIT ");

					REPORT_INFO(GetLogger(), "\t\t\tPhysicalDevice{0} - {1}", k, text);
				}
			}
		}
	}

	private Result CreateImplementation<Implementation, Interface>(out Interface entity)
		where Implementation : Interface, var
	{
		entity = ?;

		Implementation implementation = Allocate!<Implementation>(GetAllocator(), this);
		readonly Result result = implementation.Create();

		if (result == Result.SUCCESS)
		{
			entity = (Interface)implementation;
			return Result.SUCCESS;
		}

		Deallocate!(GetAllocator(), implementation);
		return result;
	}

	private Result CreateImplementation<Implementation, Interface, P1>(out Interface entity, P1 p1)
		where Implementation : Interface, var
		where P1 : var
	{
		entity = ?;

		Implementation implementation = Allocate!<Implementation>(GetAllocator(), this);
		readonly Result result = implementation.Create(p1);

		if (result == Result.SUCCESS)
		{
			entity = (Interface)implementation;
			return Result.SUCCESS;
		}

		Deallocate!(GetAllocator(), implementation);
		return result;
	}

	private Result CreateImplementation<Implementation, Interface, P1, P2>(out Interface entity, P1 p1, P2 p2)
		where Implementation : Interface, var
		where P1 : var
		where P2 : var
	{
		entity = ?;

		Implementation implementation = Allocate!<Implementation>(GetAllocator(), this);
		readonly Result result = implementation.Create(p1, p2);

		if (result == Result.SUCCESS)
		{
			entity = (Interface)implementation;
			return Result.SUCCESS;
		}

		Deallocate!(GetAllocator(), implementation);
		return result;
	}

	private Result CreateImplementation<Implementation, Interface, P1, P2, P3>(out Interface entity, P1 p1, P2 p2, P3 p3)
		where Implementation : Interface, var
		where P1 : var
		where P2 : var
	{
		entity = ?;

		Implementation implementation = Allocate!<Implementation>(GetAllocator(), this);
		readonly Result result = implementation.Create(p1, p2, p3);

		if (result == Result.SUCCESS)
		{
			entity = (Interface)implementation;
			return Result.SUCCESS;
		}

		Deallocate!(GetAllocator(), implementation);
		return result;
	}

}