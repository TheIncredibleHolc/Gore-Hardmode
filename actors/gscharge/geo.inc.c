#include "src/game/envfx_snow.h"

const GeoLayout gscharge_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_ASM(0, geo_update_layer_transparency),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, gscharge_Plane_mesh_layer_5),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, gscharge_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};