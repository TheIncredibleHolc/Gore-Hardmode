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
	LOAD_MIO0(0xb, _effect_mio0SegmentRomStart, _effect_mio0SegmentRomEnd), 
	LOAD_MIO0(0xa, _bitfs_skybox_mio0SegmentRomStart, _bitfs_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario),

	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, secretroom_area_1),
		WARP_NODE(0xF0, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, 0x1A, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x01, LEVEL_BOB, 0x01, 0x01, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_BITS_WARP_PIPE, -2200, 0, -4600, 0, 0, 0, (0x01 << 16), id_bhvWarpPipe),
		OBJECT(MODEL_NONE, 69, 1802, 35, 0, 0, 0, 0x000A0000, bhvSpinAirborneWarp),
		MARIO_POS(0x01, 0, 69, 1585, 35),
		OBJECT(MODEL_NONE, 67, 1975, 52, 0, 0, 0, 0x000A0000, bhvDeathWarp),
		TERRAIN(secretroom_area_1_collision),
		MACRO_OBJECTS(secretroom_area_1_macro_objs),
		STOP_MUSIC(0),
		SHOW_DIALOG(0x00, DIALOG_008),
		TERRAIN_TYPE(TERRAIN_STONE),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, 69, 1585, 35),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};
