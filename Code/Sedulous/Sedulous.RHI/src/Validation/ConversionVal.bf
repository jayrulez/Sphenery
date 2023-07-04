namespace Sedulous.RHI.Validation;

static{
	public static void ConvertGeometryObjectsVal(GeometryObject* destObjects, GeometryObject* sourceObjects, uint32 objectNum)
	{
	    for (uint32 i = 0; i < objectNum; i++)
	    {
	        readonly ref GeometryObject geometrySrc = ref sourceObjects[i];
	        ref GeometryObject geometryDst = ref destObjects[i];

	        geometryDst = geometrySrc;

	        if (geometrySrc.type == GeometryType.TRIANGLES)
	        {
	            geometryDst.triangles.vertexBuffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)geometrySrc.triangles.vertexBuffer);
	            geometryDst.triangles.indexBuffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)geometrySrc.triangles.indexBuffer);
	            geometryDst.triangles.transformBuffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)geometrySrc.triangles.transformBuffer);
	        }
	        else
	        {
	            geometryDst.boxes.buffer = NRI_GET_IMPL_PTR!<IBuffer...>((BufferVal)geometrySrc.boxes.buffer);
	        }
	    }
	}
}