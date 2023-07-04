#if !defined(VULKAN)

    #define SD_RESOURCE( resourceType, resourceName, regName, bindingIndex, setIndex ) \
        resourceType resourceName : register( regName ## bindingIndex, space ## setIndex )

    #define SD_PUSH_CONSTANTS( structName, constantBufferName, bindingIndex ) \
        ConstantBuffer<structName> constantBufferName : register( b ## bindingIndex, space0 )

#else

    #define SD_RESOURCE( resourceType, resourceName, regName, bindingIndex, setIndex ) \
        resourceType resourceName : register( regName ## bindingIndex, space ## setIndex )

    #define SD_PUSH_CONSTANTS( structName, constantBufferName, bindingIndex ) \
        [[vk::push_constant]] structName constantBufferName

    // TODO: how to support FP16 in VK?
    #define min16float float
    #define min16float2 float2
    #define min16float3 float3
    #define min16float4 float4
#endif