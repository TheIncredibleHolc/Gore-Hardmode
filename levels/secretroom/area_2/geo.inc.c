#include "src/game/envfx_snow.h"

const GeoLayout secretroom_area_2_geo[] = {
	GEO_NODE_START(),
	GEO_OPEN_NODE(),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_OPAQUE, 0, -227, -1, secretroom_dl_brick_mesh_layer_1),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_ALPHA, -200, 0, -100, secretroom_dl_Cube_008_mesh_layer_4),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_OPAQUE, 0, -227, -1, secretroom_dl_gates_mesh_layer_1),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_ALPHA, 0, -227, -1, secretroom_dl_gates_001_mesh_layer_4),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_OPAQUE, 0, -494, -1, secretroom_dl_grass_mesh_layer_1),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_ALPHA, -900, 556, -1801, -90, 0, 0, secretroom_dl_Plane_mesh_layer_4),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_TRANSPARENT, secretroom_dl_Plane_mesh_layer_5),
		GEO_CLOSE_NODE(),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_ALPHA, 0, 331, -1, secretroom_dl_Plane_001_mesh_layer_4),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_OPAQUE, 1594, 1657, -2817, 0, 90, 0, secretroom_dl_Plane_013_mesh_layer_1),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_OPAQUE, 1594, 1657, -2826, 0, 90, 0, secretroom_dl_Plane_014_mesh_layer_1),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_OPAQUE, 1144, 1657, -2817, 0, 90, 0, secretroom_dl_Plane_015_mesh_layer_1),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_OPAQUE, 1144, 1657, -2826, 0, 90, 0, secretroom_dl_Plane_016_mesh_layer_1),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_OPAQUE, 694, 1657, -2817, 0, 90, 0, secretroom_dl_Plane_017_mesh_layer_1),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_OPAQUE, 694, 1657, -2826, 0, 90, 0, secretroom_dl_Plane_018_mesh_layer_1),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_OPAQUE, 244, 1657, -2817, 0, 90, 0, secretroom_dl_Plane_019_mesh_layer_1),
		GEO_TRANSLATE_ROTATE_WITH_DL(LAYER_OPAQUE, 244, 1657, -2826, 0, 90, 0, secretroom_dl_Plane_020_mesh_layer_1),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_OPAQUE, 900, 1325, -2551, secretroom_dl_platform_mesh_layer_1),
		GEO_TRANSLATE_ROTATE(LAYER_OPAQUE, -1, 1261, 1526, 0, 180, 0),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_OPAQUE, 0, -227, -1, secretroom_dl_room_mesh_layer_1),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_OPAQUE, 0, -227, -1, secretroom_dl_wall1_mesh_layer_1),
		GEO_TRANSLATE_NODE_WITH_DL(LAYER_OPAQUE, 0, -227, -1, secretroom_dl_wall2_mesh_layer_1),
		GEO_OPEN_NODE(),
			GEO_DISPLAY_LIST(LAYER_ALPHA, secretroom_dl_wall2_mesh_layer_4),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_RETURN(),
};
const GeoLayout secretroom_area_2[] = {
	GEO_NODE_SCREEN_AREA(10, SCREEN_WIDTH/2, SCREEN_HEIGHT/2, SCREEN_WIDTH/2, SCREEN_HEIGHT/2),
	GEO_OPEN_NODE(),
		GEO_ZBUFFER(0),
		GEO_OPEN_NODE(),
			GEO_NODE_ORTHO(100.0000),
			GEO_OPEN_NODE(),
				GEO_BACKGROUND(BACKGROUND_ABOVE_CLOUDS, geo_skybox_main),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
		GEO_ZBUFFER(1),
		GEO_OPEN_NODE(),
			GEO_CAMERA_FRUSTUM_WITH_FUNC(45.0000, 100, 30000, geo_camera_fov),
			GEO_OPEN_NODE(),
				GEO_CAMERA(CAMERA_MODE_OUTWARD_RADIAL, 0, 0, 0, 0, -100, 0, geo_camera_main),
				GEO_OPEN_NODE(),
					GEO_BRANCH(1, secretroom_area_2_geo),
					GEO_RENDER_OBJ(),
					GEO_ASM(ENVFX_MODE_NONE, geo_envfx_main),
				GEO_CLOSE_NODE(),
			GEO_CLOSE_NODE(),
		GEO_CLOSE_NODE(),
	GEO_CLOSE_NODE(),
	GEO_END(),
};