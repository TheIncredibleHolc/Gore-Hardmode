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
	{ name = "mario", model = E_MODEL_TROPHY_MARIO, scale = 0.1, y_offset = -20, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #1 Beat the game as Mario.
	{ name = "luigi", model = E_MODEL_TROPHY_LUIGI, scale = 0.1, y_offset = -20, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #2 Beat the game as Luigi.
	{ name = "toad", model = E_MODEL_TROPHY_TOAD, scale = 0.1, y_offset = -26, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #3 Beat the game as Toad.
	{ name = "wario", model = E_MODEL_TROPHY_WARIO, scale = 0.1, y_offset = -20, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #4 Beat the game as Wario.
	{ name = "waluigi", model = E_MODEL_TROPHY_WALUIGI, scale = 0.1, y_offset = -20, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #5 Beat the game as Waluigi.
	{ name = "star", model = E_MODEL_STAR, scale = 0.6, y_offset = 15, podium = E_MODEL_PLAT_TROPHY_PODIUM }, --Trophy #6 Beat the game with all 5 characters. (Or get 120 stars?).
	{ name = "portal", model = E_MODEL_NETHERPORTAL, scale = 0.2, y_offset = -10, podium = E_MODEL_FIND_TROPHY_PODIUM,  --Trophy #7 Find the NetherPortal.
	  loop = function (o)
		o.oAnimState = o.oTimer % 32
	  end
	},
	{ name = "smiler", model = E_MODEL_BACKROOM_SMILER, scale = 0.2, y_offset = 20, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #8 Visit the Backrooms.
	{ name = "fieldgoal", model = E_MODEL_GOALPOST, scale = 0.1, y_offset = -10, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #9 Kick a field goal in CCM.
	{ name = "trophy10", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #10
	{ name = "trophy11", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #11
	{ name = "lakitu", model = E_MODEL_LAKITU, scale = 0.2, y_offset = 0, podium = E_MODEL_FIND_TROPHY_PODIUM }, --Trophy #12 -- "Take a good look at yourself." (Mirror room)
	{ name = "trophy13", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #13
	{ name = "trophy14", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #14
	{ name = "trophy15", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #15
	{ name = "trophy16", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #16
	{ name = "trophy17", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #17
	{ name = "trophy18", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM }, --Trophy #18
	{ name = "deadtoad", model = E_MODEL_TOAD_HEAD, scale = 0.2, y_offset = 0, podium = E_MODEL_GORE_TROPHY_PODIUM }, --Trophy #19 - Kill Toad 50x
	{ name = "trophy20", model = E_MODEL_NONE, scale = 0.2, y_offset = 0, podium = E_MODEL_GOLD_TROPHY_PODIUM } --Trophy #20
}

function unlock_trophy(id)
	local trophy = trophyinfo[id]
	if trophy then
		mod_storage_save(trophy.name, "1")
	end
end

---@param o Object
function trophy_load(o)
	local np = gNetworkPlayers[0]
	local trophy = trophyinfo[o.oBehParams >> 16]

	-- Loads the status of each trophy on Secret Room entry.
	local trophyunlocked = mod_storage_load(trophy.name) == "1"

	print("trophy: "..trophy.name)
	print("trophy "..(trophyunlocked and "unlocked" or "locked"))
	print("type: "..(o.oBehParams & 1 ~= 0 and "collectible" or "display"))

	-- Checks to see if trophy should display. (show if unlocked and display or locked and collectible)
	if trophyunlocked == (o.oBehParams & 1 == 0) then
		obj_set_model_extended(o, trophy.model)
		spawn_non_sync_object(id_bhvStaticObject, trophy.podium, o.oPosX, o.oPosY - 102, o.oPosZ, function(podium)
			obj_scale(podium, .2)
			obj_copy_angle(podium, o)
			podium.oFaceAngleYaw = podium.oFaceAngleYaw + 16384
			podium.oMoveAngleYaw = podium.oFaceAngleYaw
		end)
	elseif np.currLevelNum ~= LEVEL_SECRETHUB then -- don't delete display if trophy isn't unlocked
		spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
		obj_mark_for_deletion(o)
	return end
	cur_obj_scale(trophy.scale)
end

---@param o Object
function trophy_init(o)
	local trophy = trophyinfo[o.oBehParams >> 16]
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.header.gfx.skipInViewCheck = true
	obj_set_hitbox_radius_and_height(o, 40, 100)
	trophy_load(o)
	o.oPosY = o.oPosY + trophy.y_offset
end

---@param o Object
function trophy_loop(o)
	n = gNetworkPlayers[0]
	local trophy = trophyinfo[o.oBehParams >> 16]
	o.oAngleVelYaw = 500
	o.oFaceAngleYaw = o.oFaceAngleYaw + o.oAngleVelYaw

	if trophy.loop then trophy.loop(o) end
	if o.oBehParams & 1 ~= 0 then -- is a collectible
		local player = nearest_player_to_object(o)
		if obj_check_hitbox_overlap(o, player) then
			-- collect (spin, fly up and shrink, leaving a trail of sparkles behind)
			play_sound(SOUND_MENU_COLLECT_SECRET, gMarioStates[0].pos)
			--network_play(sTrophy, o.header.gfx.pos, 1, 0)
			djui_chat_message_create("Trophy collected!")
			mod_storage_save(trophy.name, "1")
			obj_mark_for_deletion(o)
		else
			cur_obj_become_intangible()
		end
	end
end

function trophyplate_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.header.gfx.skipInViewCheck = true
	obj_set_hitbox_radius_and_height(o, 40, 100)
end

function trophyplate_loop(o)
	if o.oBehParams & 1 == 0 then -- if trophy NOT collected already...
		
	else

	end
end


------------------------------------------------------------------------------------------------------------
-------- Trying to do a check for the first 5 trophies to grant the 6th trophy (beat game with all characters). No luck so far. 
t1 = mod_storage_load("mario")
t2 = mod_storage_load("luigi")
t3 = mod_storage_load("toad")
t4 = mod_storage_load("wario")
t5 = mod_storage_load("waluigi")

function trophy_check(o)
	m = gMarioStates[0]

	if mod_storage_load("mario") == "1" and mod_storage_load("luigi") == "1" and mod_storage_load("toad") == "1" and mod_storage_load("wario") == "1" and mod_storage_load("waluigi") == "1" and mod_storage_load("star") ~= "1" then
		spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, m.pos.x, m.pos.y, m.pos.z, function(t)
			obj_scale(t, .05)
			t.oBehParams = 6 << 16 | 1
		end)
	end

end

hook_event(HOOK_ON_WARP, trophy_check)
------------------------------------------------------------------------------------------------------------

id_bhvTrophy = hook_behavior(nil, OBJ_LIST_GENACTOR, true, trophy_init, trophy_loop, "bhvTrophy")
id_bhvTrophyPlate = hook_behavior(nil, OBJ_LIST_GENACTOR, true, trophyplate_init, trophyplate_loop, "bhvTrophyPlate")