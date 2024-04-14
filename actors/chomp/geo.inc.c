#include "src/game/envfx_snow.h"

const GeoLayout chomp_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_ALPHA, chomp_goomba_mesh_layer_4),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, chomp_goomba_mesh_layer_1),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
