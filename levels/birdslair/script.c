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
#include "levels/birdslair/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_birdslair_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _birdslair_segment_7SegmentRomStart, _birdslair_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xa, _clouds_skybox_mio0SegmentRomStart, _clouds_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario),

	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, birdslair_area_1),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x01, 0x1A, 0x01, 0x01, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_YELLOW_COIN, -1980, 60, 0, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -3020, 60, 0, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2132, 60, 368, 0, -45, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 0, 60, 1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2868, 60, -368, 0, -45, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2500, 60, 520, 0, -90, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2500, 60, -520, 0, -90, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2868, 60, 368, 0, -135, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2132, 60, -368, 0, -135, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -300, -200, 1900, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 0, -200, 2200, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -600, -200, 1600, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -1980, 60, 2000, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 400, 60, 1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 800, 60, 1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -400, 60, 1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -800, 60, 1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -1200, 60, 1200, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1200, 60, 1200, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1300, 60, 0, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1300, 60, 400, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1300, 60, 800, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -1300, 60, 0, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -1300, 60, 400, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -1300, 60, 800, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -1300, 60, -400, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1300, 60, -400, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1300, 60, -800, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -1300, 60, -800, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -1200, 60, -1200, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 1200, 60, -1200, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 0, 60, -1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 400, 60, -1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -400, 60, -1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -800, 60, -1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, 800, 60, -1300, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -3020, 60, 2000, 0, 0, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2132, 60, 2368, 0, -45, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2868, 60, 1632, 0, -45, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2500, 60, 2520, 0, -90, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2500, 60, 1480, 0, -90, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2868, 60, 2368, 0, -135, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_YELLOW_COIN, -2132, 60, 1632, 0, -135, 0, 0x00000000, id_bhvOneCoin),
		OBJECT(E_MODEL_GOOMBA, -1149, 771, 1149, 0, -45, 0, 0x00000000, id_bhvGoomba),
		OBJECT(E_MODEL_GOOMBA, 1149, 810, 1149, 0, -45, 0, 0x00000000, id_bhvGoomba),
		OBJECT(E_MODEL_GOOMBA, 1149, 810, -1149, 0, -45, 0, 0x00000000, id_bhvGoomba),
		OBJECT(E_MODEL_GOOMBA, -1149, 810, -1149, 0, -45, 0, 0x00000000, id_bhvGoomba),
		OBJECT(E_MODEL_BITS_WARP_PIPE, -1220, 648, 0, 0, 0, 0, (0x01 << 16), id_bhvWarpPipe),
		OBJECT(E_MODEL_METAL_BOX, 0, 0, -1300, 0, 0, 0, (6 << 16), id_bhvPushableMetalBox),
		OBJECT(MODEL_NONE, 1600, 1560, 0, 0, 0, 0, 0x000A0000, id_bhvSpinAirborneWarp),
		MARIO_POS(0x01, 0, 1600, 1560, 0),
		TERRAIN(birdslair_area_1_collision),
		MACRO_OBJECTS(birdslair_area_1_macro_objs),
		SET_BACKGROUND_MUSIC(0x00, SEQ_EVENT_METAL_CAP),
		TERRAIN_TYPE(TERRAIN_GRASS),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, 1600, 1560, 0),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};
