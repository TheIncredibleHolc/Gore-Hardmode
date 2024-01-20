#include "src/game/envfx_snow.h"

const GeoLayout bob_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, bob__bob_seg7_dl_0700A470_Obj_mesh_layer_1),
		GEO_DISPLAY_LIST(LAYER_ALPHA, bob__bob_seg7_dl_0700A470_Obj_mesh_layer_4),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, bob_material_revert_render_settings),
		GEO_DISPLAY_LIST(LAYER_ALPHA, bob_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
