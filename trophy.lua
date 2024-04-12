-------------------------TROPHY SYSTEM-------------------------

silverplate = smlua_model_util_get_id("silverplate_geo") --This is the description panel under the display trophy.
goldplate  = smlua_model_util_get_id("goldplate_geo")  --This is the description panel under the display trophy.

E_MODEL_GOLD_TROPHY_PODIUM = smlua_model_util_get_id("podium_geo")
E_MODEL_PLAT_TROPHY_PODIUM = smlua_model_util_get_id("podium_platinum_geo")
E_MODEL_GORE_TROPHY_PODIUM = smlua_model_util_get_id("podium_ded_geo")
E_MODEL_FIND_TROPHY_PODIUM = smlua_model_util_get_id("podium_mystery_geo")

E_MODEL_TROPHY_MARIO = smlua_model_util_get_id("trophy_mario_win_geo")
E_MODEL_TROPHY_LUIGI = smlua_model_util_get_id("trophy_luigi_win_geo")
E_MODEL_TROPHY_TOAD = smlua_model_util_get_id("trophy_toad_win_geo")
E_MODEL_TROPHY_WARIO = smlua_model_util_get_id("trophy_wario_win_geo")
E_MODEL_TROPHY_WALUIGI = smlua_model_util_get_id("trophy_waluigi_win_geo")
E_MODEL_GOALPOST = smlua_model_util_get_id("goalpost_geo")
COL_GOALPOST = smlua_collision_util_get("goalpost_collision")
E_MODEL_TOAD_HEAD = smlua_model_util_get_id("trophy_toad_head_geo")

trophyinfo = {
	{ name = "mario",     model = E_MODEL_TROPHY_MARIO,     scale = 0.1, y_offset = 20,  podium = E_MODEL_PLAT_TROPHY_PODIUM }, --Trophy #1  - Beat the game as Mario.
	{ name = "luigi",     model = E_MODEL_TROPHY_LUIGI,     scale = 0.1, y_offset = 20,  podium = E_MODEL_PLAT_TROPHY_PODIUM }, --Trophy #2  - Beat the game as Luigi.
	{ name = "toad",      model = E_MODEL_TROPHY_TOAD,      scale = 0.1, y_offset = 26,  podium = E_MODEL_PLAT_TROPHY_PODIUM }, --Trophy #3  - Beat the game as Toad.
	{ name = "waluigi",   model = E_MODEL_TROPHY_WALUIGI,   scale = 0.1, y_offset = 20,  podium = E_MODEL_PLAT_TROPHY_PODIUM }, --Trophy #4  - Beat the game as Waluigi.
	{ name = "wario",     model = E_MODEL_TROPHY_WARIO,     scale = 0.1, y_offset = 20,  podium = E_MODEL_PLAT_TROPHY_PODIUM }, --Trophy #5  - Beat the game as Wario.
	{ name = "star",      model = E_MODEL_STAR,             scale = 0.6, y_offset = -15, podium = E_MODEL_PLAT_TROPHY_PODIUM }, --Trophy #6  - Beat the game with all 5 characters. (Or get 120 stars?).
	{ name = "chainchomp",model = E_MODEL_CHAIN_CHOMP,      scale = 0.2, y_offset = -15,  podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #7  - Feed Chain Chomp 5 enemies.
	{ name = "smiler",    model = E_MODEL_BACKROOM_SMILER,  scale = 0.2, y_offset = -20, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #8  - Visit the Backrooms.
	{ name = "fieldgoal", model = E_MODEL_GOALPOST,         scale = 0.1, y_offset = 10,  podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #9  - Kick a field goal in CCM.
	{ name = "trophy10",  model = E_MODEL_NONE,             scale = 0.2, y_offset = 0,   podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #10 - 
	{ name = "trophy11",  model = E_MODEL_NONE,             scale = 0.2, y_offset = 0,   podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #11 - (Found in MWOTR)
	{ name = "snowman",   model = E_MODEL_CCM_SNOWMAN_HEAD, scale = 0.2, y_offset = -40, podium = E_MODEL_FIND_TROPHY_PODIUM }, --Trophy #12 - (Found in Mirror room) "Take a good look at yourself." 
	{ name = "trophy13",  model = E_MODEL_NONE,             scale = 0.2, y_offset = 0,   podium = E_MODEL_FIND_TROPHY_PODIUM }, --Trophy #13 - (Found in SSL/Klepto Carrying)"Looks in the basement levels."
	{ name = "portal",    model = E_MODEL_NETHERPORTAL,     scale = 0.2, y_offset = 10,  podium = E_MODEL_FIND_TROPHY_PODIUM,
	  loop = function (o)
		o.oAnimState = o.oTimer % 32
	  end
	}, --Trophy #14 - Find the NetherPortal.
	{ name = "trophy15",  model = E_MODEL_NONE,             scale = 0.2, y_offset = 0,   podium = E_MODEL_FIND_TROPHY_PODIUM }, --Trophy #15
	{ name = "trophy16",  model = E_MODEL_NONE,             scale = 0.2, y_offset = 0,   podium = E_MODEL_FIND_TROPHY_PODIUM }, --Trophy #16
	{ name = "trophy17",  model = E_MODEL_NONE,             scale = 0.2, y_offset = 0,   podium = E_MODEL_FIND_TROPHY_PODIUM }, --Trophy #17
	{ name = "killyoshi",  model = E_MODEL_YOSHI,            scale = 0.2, y_offset = 0,   podium = E_MODEL_GORE_TROPHY_PODIUM }, --Trophy #18 - Kill Yoshi
	{ name = "deadtoad",  model = E_MODEL_TOAD_HEAD,        scale = 0.2, y_offset = 0,   podium = E_MODEL_GORE_TROPHY_PODIUM }, --Trophy #19 - Kill Toad 50x
	{ name = "trophy20",  model = E_MODEL_NONE,             scale = 0.2, y_offset = 0,   podium = E_MODEL_GORE_TROPHY_PODIUM }  --Trophy #20 - 
}

PACKET_UNLOCK = 0
function unlock_trophy(id)
	if network_is_server() then
		local trophy = trophyinfo[id]
		if trophy then
			mod_storage_save("file"..get_current_save_file_num()..trophy.name, "1")
			gGlobalSyncTable.trophystatus[id] = true
		end
	else network_send_to(1, true, {type = PACKET_UNLOCK, id = id}) end
end
hook_event(HOOK_ON_PACKET_RECEIVE, function (data)
	if data.type == PACKET_UNLOCK then
		unlock_trophy(data.id)
	end
end)

function trophy_unlocked(id)
	if not trophyinfo[id] then return false end
	if network_is_server() then
		return mod_storage_load("file"..get_current_save_file_num()..trophyinfo[id].name) == "1"
	end
	return gGlobalSyncTable.trophystatus[id]
end

if network_is_server() then
	gGlobalSyncTable.trophystatus = {}
	for i, _ in pairs(trophyinfo) do
		gGlobalSyncTable.trophystatus[i] = trophy_unlocked(i)
	end
end

---@param o Object
function trophy_load(o)
	local np = gNetworkPlayers[0]
	local trophy = trophyinfo[o.oBehParams >> 16]

	-- Loads the status of each trophy on Secret Room entry.
	local trophyunlocked = trophy_unlocked(o.oBehParams >> 16)

	print("trophy: "..trophy.name)
	print("trophy "..(trophyunlocked and "unlocked" or "locked"))
	print("type: "..(o.oBehParams & 1 ~= 0 and "collectible" or "display"))

	-- Checks to see if trophy should display. (show if unlocked and display or locked and collectible)
	if trophyunlocked == (o.oBehParams & 1 == 0) then
		obj_set_model_extended(o, trophy.podium)
		cur_obj_scale(.2)
		spawn_non_sync_object(id_bhvStaticObject, trophy.model, 0, 0, 0, function(display)
			display.oFlags = display.oFlags | OBJ_FLAG_TRANSFORM_RELATIVE_TO_PARENT
			obj_scale(display, trophy.scale*5)
			display.oParentRelativePosY = (102 - trophy.y_offset)*5
			display.parentObj = o
			o.parentObj = display
		end)
	elseif np.currLevelNum ~= LEVEL_SECRETHUB then -- don't delete display if trophy isn't unlocked
		spawn_non_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
		obj_mark_for_deletion(o)
	return end
end

---@param o Object
function trophy_init(o)
	o.oFlags = OBJ_FLAG_SET_THROW_MATRIX_FROM_TRANSFORM | OBJ_FLAG_0020 | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.header.gfx.skipInViewCheck = true
	obj_set_hitbox_radius_and_height(o, 40, 100)
	cur_obj_set_home_once()
	trophy_load(o)
end

---@param o Object
function trophy_loop(o)
	local player = nearest_player_to_object(o)
	local trophy = trophyinfo[o.oBehParams >> 16]
	local display = o.parentObj
	display.oAngleVelYaw = 500
	display.oFaceAngleYaw = display.oFaceAngleYaw + display.oAngleVelYaw

	cur_obj_scale(0.2)
	obj_scale(display, trophy.scale*5)

	if trophy.loop then trophy.loop(o) end

	if o.oAction == 1 then
		if o.oBehParams & 1 ~= 0 then -- collectible
			o.oPosX = o.oHomeX + sins(o.oTimer*2048) * math.sqrt(o.oTimer*3)*10
			o.oPosZ = o.oHomeZ + coss(o.oTimer*2048) * math.sqrt(o.oTimer*3)*10
			o.oVelY = minf(o.oVelY + 2, 34)
			o.oPosY = o.oPosY + o.oVelY

			o.oFaceAngleYaw = o.oFaceAngleYaw + minf(math.sqrt(o.oTimer)*1024, 3072)
			o.oFaceAngleRoll = sins(o.oTimer*512)*1024
			o.oFaceAnglePitch = coss(o.oTimer*512)*1024

			spawn_non_sync_object(id_bhvSparkleParticleSpawner, E_MODEL_SPARKLES, o.oPosX, o.oPosY, o.oPosZ, nil)

			if o.oTimer > 90 then
				cur_obj_scale((o.oFloorHeight - (1 - o.oFloorHeight)*.6)*.2)
				o.oFloorHeight = o.oFloorHeight - (1 - o.oFloorHeight)*.6
				if o.header.gfx.scale.x <= 0 then
					spawn_mist_particles()
					obj_mark_for_deletion(o)
					obj_mark_for_deletion(display)
				end
			end
		else -- display
			o.oVelY = (o.oVelY - 13)*.95
			o.oPosY = o.oPosY + o.oVelY
			if o.oPosY < o.oHomeY then
				o.oVelY = -o.oVelY
				o.oPosY = o.oHomeY
				o.oSubAction = o.oSubAction + 1
			end
			if o.oSubAction == 4 then
				o.oPosY = o.oHomeY
				o.oAction = 0
			end
		end
	end

	if obj_check_hitbox_overlap(o, player) and o.oAction == 0 then
		if o.oBehParams & 1 ~= 0 then -- collectible
			-- collect (spin, fly up and shrink, leaving a trail of sparkles behind)
			play_sound(SOUND_MENU_COLLECT_SECRET, gMarioStates[0].pos)
			--network_play(sTrophy, o.header.gfx.pos, 1, 0)
			djui_chat_message_create("Trophy collected!")
			unlock_trophy(o.oBehParams >> 16)

			o.oVelY = -15
			o.oAction = 1
			o.oFloorHeight = 0.999
		else -- display, do a little bounce
			o.oVelY = 70
			o.oAction = 1
			cur_obj_push_mario_away(80)
		end
	end
end

---@param o Object
function trophyplate_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.oInteractType = INTERACT_TEXT
	obj_set_hitbox_radius_and_height(o, 40, 100)
end

function trophyplate_loop(o)
	if o.oBehParams & 1 == 0 then -- if trophy NOT collected already...
		
	else

	end
end


------------------------------------------------------------------------------------------------------------
-------- Trying to do a check for the first 5 trophies to grant the 6th trophy (beat game with all characters). No luck so far. -- check epicbowser.lua:469
-- t1 = mod_storage_load("mario")
-- t2 = mod_storage_load("luigi")
-- t3 = mod_storage_load("toad")
-- t4 = mod_storage_load("wario")
-- t5 = mod_storage_load("waluigi")

-- function trophy_check(o)
-- 	m = gMarioStates[0]

-- 	if mod_storage_load("mario") == "1" and mod_storage_load("luigi") == "1" and mod_storage_load("toad") == "1" and mod_storage_load("wario") == "1" and mod_storage_load("waluigi") == "1" and mod_storage_load("star") ~= "1" then
-- 		spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, m.pos.x, m.pos.y, m.pos.z, function(t)
-- 			t.oBehParams = 6 << 16 | 1
-- 		end)
-- 	end

-- end

-- hook_event(HOOK_ON_WARP, trophy_check)
------------------------------------------------------------------------------------------------------------

id_bhvTrophy = hook_behavior(nil, OBJ_LIST_GENACTOR, true, trophy_init, trophy_loop, "bhvTrophy")
id_bhvTrophyPlate = hook_behavior(nil, OBJ_LIST_GENACTOR, true, trophyplate_init, trophyplate_loop, "bhvTrophyPlate")