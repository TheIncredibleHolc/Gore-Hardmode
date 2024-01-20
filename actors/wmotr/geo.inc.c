#include "src/game/envfx_snow.h"

const GeoLayout wmotr_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, wmotr__wmotr_seg7_dl_0700C1F8_Obj_mesh_layer_1),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, wmotr__wmotr_seg7_dl_0700C1F8_Obj_mesh_layer_5),
		GEO_DISPLAY_LIST(LAYER_OPAQUE, wmotr_material_revert_render_settings),
		GEO_DISPLAY_LIST(LAYER_TRANSPARENT, wmotr_material_revert_render_settings),
	GEO_CLOSE_NODE(),
	GEO_END(),
};
