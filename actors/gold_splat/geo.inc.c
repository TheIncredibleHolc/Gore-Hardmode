#include "src/game/envfx_snow.h"

const GeoLayout gold_splat_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, gold_splat_Plane_mesh_layer_5),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
