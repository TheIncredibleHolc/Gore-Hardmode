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
		OBJECT(E_MODEL_BITS_WARP_PIPE, -2109, 194, -3025, 0, 0, 0, (0x01 << 16), id_bhvWarpPipe),
		MARIO_POS(0x01, 0, -1009, 26, -725),
		OBJECT(E_MODEL_NONE, 1020, 448, -1956, 0, -149, 0, (10 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1082, 448, -1851, 0, -149, 0, (11 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1143, 448, -1748, 0, -149, 0, (12 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1206, 448, -1642, 0, -149, 0, (13 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1268, 448, -1538, 0, -149, 0, (14 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1331, 448, -1431, 0, -149, 0, (15 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1392, 448, -1329, 0, -149, 0, (16 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1454, 448, -1224, 0, -149, 0, (17 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1515, 448, -1122, 0, -149, 0, (18 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1578, 448, -1016, 0, -149, 0, (19 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 1638, 448, -915, 0, -149, 0, (20 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 895, 448, -2166, 0, -149, 0, (8 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NONE, 958, 448, -2061, 0, -149, 0, (9 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_STAR, 771, 448, -2376, 0, -149, 0, (6 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_LUIGI, 523, 448, -2793, 0, -149, 0, (2 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_MARIO, 462, 448, -2897, 0, -149, 0, (1 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_NETHERPORTAL, 835, 448, -2267, 0, -149, 0, (7 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_TOAD, 585, 448, -2690, 0, -149, 0, (3 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_WALUIGI, 709, 448, -2480, 0, -149, 0, (5 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_WARIO, 647, 448, -2585, 0, -149, 0, (4 << 16), id_bhvTrophy),
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
