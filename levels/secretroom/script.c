#include <ultra64.h>
#include "sm64.h"
#include "behavior_data.h"
#include "model_ids.h"
#include "seq_ids.h"
#include "dialog_ids.h"
#include "segment_symbols.h"
#include "level_commands.h"

#include "game/level_update.h"

#include "levels/scripts.h"


/* Fast64 begin persistent block [includes] */
/* Fast64 end persistent block [includes] */

#include "make_const_nonconst.h"
#include "levels/secretroom/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_secretroom_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _secretroom_segment_7SegmentRomStart, _secretroom_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _clouds_skybox_mio0SegmentRomStart, _clouds_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario),

	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, secretroom_area_1),
		WARP_NODE(0xF0, 51, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, 0x1A, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x01, 51, 0x02, 0x03, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_BITS_WARP_PIPE, -2387, 198, -2628, 0, 0, 0, (0x01 << 16), id_bhvWarpPipe),
		MARIO_POS(0x01, 0, -1009, 26, -725),
		OBJECT(E_MODEL_NONE, 1020, 345, -1956, 0, -60, 0, (10 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1082, 345, -1850, 0, -60, 0, (11 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1142, 345, -1747, 0, -60, 0, (12 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1203, 345, -1640, 0, -60, 0, (13 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1264, 345, -1535, 0, -60, 0, (14 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1326, 345, -1428, 0, -60, 0, (15 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1385, 345, -1325, 0, -60, 0, (16 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1447, 345, -1219, 0, -60, 0, (17 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1506, 345, -1116, 0, -60, 0, (18 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1568, 345, -1009, 0, -60, 0, (19 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1627, 345, -908, 0, -60, 0, (20 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 899, 345, -2167, 0, -60, 0, (8 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 960, 345, -2062, 0, -60, 0, (9 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 776, 345, -2378, 0, -60, 0, (6 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 534, 345, -2798, 0, -60, 0, (2 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 473, 345, -2903, 0, -60, 0, (1 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 840, 345, -2269, 0, -60, 0, (7 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, -1355, 291, -1697, 0, 0, 0, (9 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -2206, 291, -1697, 0, 0, 0, (2 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -2328, 291, -1697, 0, 0, 0, (1 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -2086, 291, -1697, 0, 0, 0, (3 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -1964, 291, -1697, 0, 0, 0, (4 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -1842, 291, -1697, 0, 0, 0, (5 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -1721, 291, -1697, 0, 0, 0, (6 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -1594, 291, -1697, 0, 0, 0, (7 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -1476, 291, -1697, 0, 0, 0, (8 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -1233, 291, -1697, 0, 0, 0, (10 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -1110, 291, -1697, 0, 0, 0, (11 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -991, 291, -1697, 0, 0, 0, (12 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -868, 291, -1697, 0, 0, 0, (13 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -747, 291, -1697, 0, 0, 0, (14 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -623, 291, -1698, 0, 0, 0, (15 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -504, 291, -1698, 0, 0, 0, (16 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -382, 291, -1698, 0, 0, 0, (17 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -263, 291, -1698, 0, 0, 0, (18 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -139, 291, -1698, 0, 0, 0, (19 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, -22, 291, -1698, 0, 0, 0, (20 << 16), id_bhvTrophyPlate),
		OBJECT(E_MODEL_NONE, 594, 345, -2694, 0, -60, 0, (3 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 716, 345, -2484, 0, -60, 0, (5 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 655, 345, -2589, 0, -60, 0, (4 << 16), id_bhvTrophy),
		OBJECT(MODEL_NONE, -975, 1063, -699, 0, 180, 0, 0x000A0000, bhvSpinAirborneWarp),
		OBJECT(MODEL_NONE, -974, 1150, -708, 0, 180, 0, 0x000A0000, bhvDeathWarp),
		TERRAIN(secretroom_area_1_collision),
		MACRO_OBJECTS(secretroom_area_1_macro_objs),
		STOP_MUSIC(0),
		TERRAIN_TYPE(TERRAIN_STONE),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	AREA(2, secretroom_area_2),
		WARP_NODE(0x0A, 51, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x1A, 51, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, 51, 0x01, 0x01, WARP_NO_CHECKPOINT),
		WARP_NODE(0x01, 51, 0x02, 0x02, WARP_NO_CHECKPOINT),
		WARP_NODE(0x02, 51, 0x02, 0x01, WARP_NO_CHECKPOINT),
		WARP_NODE(0x03, 51, 0x01, 0x01, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_GOOMBA, 1319, 384, -1374, 0, -90, 0, 0x00000000, id_bhvGoomba),
		OBJECT(E_MODEL_HIDDENFLAG, -1500, 200, -1500, 0, 0, 0, 0x00000000, id_bhvRedFloodFlag),
		OBJECT(E_MODEL_HELLPLATFORM, -3500, 1100, 0, 0, -90, 0, 0x00000000, id_bhvHellPlatform1),
		OBJECT(E_MODEL_HELLTHWOMPER, -3500, 1300, 0, 0, 90, 0, 0x00000000, id_bhvThwomp),
		OBJECT(MODEL_NONE, -1481, 2400, 0, 0, 90, 0, 0x000A0000, bhvSpinAirborneWarp),
		MARIO_POS(0x01, 90, -1481, 2400, 0),
		OBJECT(MODEL_NONE, -1230, 1576, 2099, 0, 90, 0, (0x01 << 16), id_bhvFadingWarp),
		OBJECT(MODEL_NONE, 139, 1401, -2754, 0, 45, 0, (0x02 << 16), id_bhvFadingWarp),
		OBJECT(E_MODEL_BITS_WARP_PIPE, 1459, 218, -4, 0, -90, 0, (0x03 << 16), id_bhvWarpPipe),
		TERRAIN(secretroom_area_2_collision),
		MACRO_OBJECTS(secretroom_area_2_macro_objs),
		STOP_MUSIC(0),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 90, -1481, 2400, 0),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};
