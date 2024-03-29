#include "src/game/envfx_snow.h"

const GeoLayout trophy_mario_win_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, trophy_mario_win_skinned_021_mesh_layer_1),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, trophy_mario_win_skinned_021_mesh_layer_5),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
