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
#include "levels/hell/header.h"

/* Fast64 begin persistent block [scripts] */
/* Fast64 end persistent block [scripts] */

const LevelScript level_hell_entry[] = {
	INIT_LEVEL(),
	LOAD_MIO0(0x7, _hell_segment_7SegmentRomStart, _hell_segment_7SegmentRomEnd), 
	LOAD_MIO0(0xb, _effect_mio0SegmentRomStart, _effect_mio0SegmentRomEnd), 
	LOAD_MIO0(0xa, _bitfs_skybox_mio0SegmentRomStart, _bitfs_skybox_mio0SegmentRomEnd), 
	ALLOC_LEVEL_POOL(),
	MARIO(MODEL_MARIO, 0x00000001, bhvMario),

	/* Fast64 begin persistent block [level commands] */
	/* Fast64 end persistent block [level commands] */

	AREA(1, hell_area_1),
		WARP_NODE(0x0A, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF0, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		OBJECT(E_MODEL_EXCLAMATION_BOX, 91, 587, -3653, 0, 0, 0, 0x00000000, id_bhvExclamationBox),
		OBJECT(E_MODEL_AMP, 761, 507, -7921, 90, 0, 0, 0x00000000, id_bhvCirclingAmp),
		OBJECT(MODEL_1UP, 743, 779, -7350, 90, 10, 0, 0x00000000, bhv1Up),
		OBJECT(E_MODEL_NONE, -134, 550, -7362, -90, 0, 180, 0x00000000, id_bhvLllRotatingBlockWithFireBars),
		OBJECT(E_MODEL_BULLY, 117, 346, -3734, 90, 0, 0, 0x00000000, id_bhvSmallBully),
		OBJECT(MODEL_NONE, 0, 1806, -11787, 0, 0, 0, 0x000A0000, bhvSpinAirborneWarp),
		MARIO_POS(0x01, 0, 0, 1588, -11787),
		TERRAIN(hell_area_1_collision),
		MACRO_OBJECTS(hell_area_1_macro_objs),
		STOP_MUSIC(0),
		SHOW_DIALOG(0x00, DIALOG_008),
		TERRAIN_TYPE(TERRAIN_STONE),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, 0, 1588, -11787),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};
