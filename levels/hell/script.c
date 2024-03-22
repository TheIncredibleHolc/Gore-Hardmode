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
		WARP_NODE(0xF0, LEVEL_BOB, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0xF1, 0x1A, 0x01, 0x0A, WARP_NO_CHECKPOINT),
		WARP_NODE(0x01, LEVEL_BOB, 0x01, 0x02, WARP_NO_CHECKPOINT),
		WARP_NODE(0x02, LEVEL_BOB, 0x01, 0x01, WARP_NO_CHECKPOINT),
		OBJECT(MODEL_RED_FLAME, -1090, 207, 1772, 90, 0, 0, (4 << 16), bhvFlamethrower),
		OBJECT(MODEL_RED_FLAME, 1064, 207, -226, 90, 0, 0, (4 << 16), bhvFlamethrower),
		OBJECT(MODEL_RED_FLAME, -21, 221, 4383, 90, 0, 0, (4 << 16), bhvFlamethrower),
		OBJECT(MODEL_RED_FLAME, 409, 221, 4383, 90, 0, 0, (4 << 16), bhvFlamethrower),
		OBJECT(E_MODEL_HELLTHWOMPER, -922, 2888, 3150, 0, -90, 0, (4 << 16), id_bhvThwomp),
		OBJECT(E_MODEL_NETHERPORTAL, -4350, 1697, 4895, 0, -90, 0, (7 << 16), id_bhvTrophy),
		OBJECT(E_MODEL_EXCLAMATION_BOX, 91, 587, -3653, 0, 0, 0, (6 << 16), id_bhvExclamationBox),
		OBJECT(MODEL_1UP, 743, 779, -7350, 90, 10, 0, 0x00000000, bhv1Up),
		OBJECT(MODEL_1UP, 1443, 979, 950, 90, 10, 0, 0x00000000, bhv1Up),
		OBJECT(MODEL_1UP, -452, 903, 150, 90, 10, 0, 0x00000000, bhvHidden1upInPoleSpawner),
		OBJECT(MODEL_1UP, -220, 907, 195, 90, 10, 0, 0x00000000, bhvHidden1upInPoleSpawner),
		OBJECT(MODEL_1UP, 1539, 1106, 2694, 90, 10, 0, 0x00000000, bhv1Up),
		OBJECT(MODEL_1UP, -4814, 1991, 4135, 90, 10, 0, 0x00000000, bhv1Up),
		OBJECT(MODEL_1UP, -3847, 1429, 5232, 90, 10, 0, 0x00000000, bhv1Up),
		OBJECT(MODEL_NONE, 78, 275, 13706, 0, 90, 0, 0x00000000, id_bhvNetherPortal),
		OBJECT(E_MODEL_HELLPLATFORM, 1538, 910, 2694, 0, 0, 0, 0x00000000, id_bhvHellPlatform1),
		OBJECT(E_MODEL_HELLPLATFORM, -3172, 1033, 5241, 0, 0, 0, 0x00000000, id_bhvHellPlatform1),
		OBJECT(E_MODEL_NONE, -134, 597, -7362, -90, 0, 180, 0x00000000, id_bhvLllRotatingBlockWithFireBars),
		OBJECT(E_MODEL_BULLY, 117, 346, -3734, 90, 0, 0, 0x00000000, id_bhvSmallBully),
		OBJECT(E_MODEL_BULLY, 100, 700, -1100, 90, 0, 0, 0x00000000, id_bhvSmallBully),
		OBJECT(E_MODEL_AMP, 1600, 700, -900, 90, 0, 0, 0x00000000, id_bhvCirclingAmp),
		OBJECT(E_MODEL_AMP, 1700, 1000, 1000, 90, 0, 0, 0x00000000, id_bhvCirclingAmp),
		OBJECT(MODEL_RED_FLAME, 759, 207, -7372, 90, 0, 0, (4 << 16), bhvFlamethrower),
		OBJECT(MODEL_NONE, 69, 1802, -11787, 0, 0, 0, 0x000A0000, bhvSpinAirborneWarp),
		MARIO_POS(0x01, 0, 69, 1585, -11787),
		OBJECT(MODEL_NONE, 67, 1975, -11770, 0, 0, 0, 0x000A0000, bhvDeathWarp),
		OBJECT(E_MODEL_NONE, 4703, 270, 493, 0, 0, 0, 0x00010000, id_bhvFadingWarp),
		OBJECT(E_MODEL_NONE, 37, 293, 10471, 0, 0, 0, 0x00020000, id_bhvFadingWarp),
		OBJECT(MODEL_YELLOW_COIN, 1643, 979, 650, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1643, 879, 450, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1643, 779, 250, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1643, 679, -50, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1643, 679, -250, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1643, 679, -450, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1643, 679, -650, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1443, 679, -950, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1143, 679, -1050, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 843, 679, -1050, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1143, 879, -1050, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1663, 852, -603, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 943, 879, -1050, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1661, 853, -382, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1670, 860, -150, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, -344, 1331, 4402, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, -621, 1331, 4402, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 989, 1331, 4402, 90, 10, 0, 0x00000000, bhvYellowCoin),
		OBJECT(MODEL_YELLOW_COIN, 1146, 1331, 4402, 90, 10, 0, 0x00000000, bhvYellowCoin),
		TERRAIN(hell_area_1_collision),
		MACRO_OBJECTS(hell_area_1_macro_objs),
		STOP_MUSIC(0),
		SHOW_DIALOG(0x00, DIALOG_008),
		TERRAIN_TYPE(TERRAIN_STONE),
		/* Fast64 begin persistent block [area commands] */
		/* Fast64 end persistent block [area commands] */
	END_AREA(),

	FREE_LEVEL_POOL(),
	MARIO_POS(0x01, 0, 69, 1585, -11787),
	CALL(0, lvl_init_or_update),
	CALL_LOOP(1, lvl_init_or_update),
	CLEAR_LEVEL(),
	SLEEP_BEFORE_EXIT(1),
	EXIT(),
};
