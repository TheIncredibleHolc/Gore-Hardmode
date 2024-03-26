#include "src/game/envfx_snow.h"

const GeoLayout trophy_toad_head_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, trophy_toad_head_Toad_002_mesh_layer_5),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, trophy_toad_head_Toad_002_mesh_layer_1),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
