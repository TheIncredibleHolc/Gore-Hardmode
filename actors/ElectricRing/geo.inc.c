const GeoLayout ElectricRing_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_ALPHA, ElectricRing_Plane_mesh_layer_4),
		GEO_DISPLAY_LIST(LAYER_ALPHA, ElectricRing_final_revert_mesh_layer_4),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
