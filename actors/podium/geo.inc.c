#include "src/game/envfx_snow.h"

const GeoLayout podium_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, podium_skinned_002_mesh_layer_1),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, podium_skinned_002_mesh_layer_5),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
