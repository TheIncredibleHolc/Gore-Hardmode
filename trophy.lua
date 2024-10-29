-------------------------TROPHY SYSTEM-------------------------

E_MODEL_SILVER_PLATE = smlua_model_util_get_id("silverplate_geo") --This is the description panel under the display trophy.
E_MODEL_GOLD_PLATE  = smlua_model_util_get_id("goldplate_geo")  --This is the description panel under the display trophy.

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
E_MODEL_TROPHY_YOSHI = smlua_model_util_get_id("trophy_yoshi_owie_geo")
E_MODEL_3D_COIN = smlua_model_util_get_id("coin3d_geo")
E_MODEL_IWBTG = smlua_model_util_get_id("iwbtg_geo")

trophyinfo = {
	{ name = "mario",      model = E_MODEL_TROPHY_MARIO,     scale = 0.1, y_offset = 20,  podium = E_MODEL_PLAT_TROPHY_PODIUM, message = "Trophy #1 - Beat the game as Mario."  },
	{ name = "luigi",      model = E_MODEL_TROPHY_LUIGI,     scale = 0.1, y_offset = 20,  podium = E_MODEL_PLAT_TROPHY_PODIUM, message = "Trophy #2 - Beat the game as Luigi."  },
	{ name = "toad",       model = E_MODEL_TROPHY_TOAD,      scale = 0.1, y_offset = 26,  podium = E_MODEL_PLAT_TROPHY_PODIUM, message = "Trophy #3 - Beat the game as Toad."   },
	{ name = "waluigi",    model = E_MODEL_TROPHY_WALUIGI,   scale = 0.1, y_offset = 20,  podium = E_MODEL_PLAT_TROPHY_PODIUM, message = "Trophy #4 - Beat the game as Wario."  },
	{ name = "wario",      model = E_MODEL_TROPHY_WARIO,     scale = 0.1, y_offset = 20,  podium = E_MODEL_PLAT_TROPHY_PODIUM, message = "Trophy #5 - Beat the game as Waluigi."},
	{ name = "star",       model = E_MODEL_STAR,             scale = 0.6, y_offset = -15, podium = E_MODEL_PLAT_TROPHY_PODIUM, message = "Trophy #6 - Beat the game with all 5 characters." },
	{ name = "chainchomp", model = E_MODEL_CHOMP,            scale = 0.2, y_offset = -15, podium = E_MODEL_GOLD_TROPHY_PODIUM, message = "Trophy #7 - Feed Chain-Chomp 5 enemies."},
	{ name = "smiler",     model = E_MODEL_BACKROOM_SMILER,  scale = 0.2, y_offset = -20, podium = E_MODEL_GOLD_TROPHY_PODIUM, message = "Trophy #8 - Visit the Backrooms."       },
	{ name = "fieldgoal",  model = E_MODEL_GOALPOST,         scale = 0.06, y_offset = 10, podium = E_MODEL_GOLD_TROPHY_PODIUM, message = "Trophy #9 - (CCM) Kick a field goal."   },
	{ name = "stopwatch",  model = E_MODEL_STOPWATCH,        scale = 0.3, y_offset = 10,  podium = E_MODEL_GOLD_TROPHY_PODIUM, message = "Trophy #10 - (BITFS) Time-Attack!"       },
	{ name = "coin",       model = E_MODEL_3D_COIN,          scale = 0.3, y_offset = -25, podium = E_MODEL_GOLD_TROPHY_PODIUM, message = "Trophy #11 - (PSS) Collect 81 Coins."    },
	{ name = "snowman",    model = E_MODEL_CCM_SNOWMAN_HEAD, scale = 0.2, y_offset = -30, podium = E_MODEL_FIND_TROPHY_PODIUM, message = "Trophy #12 - Take a good look at yourself."},
	{ name = "smileymoon", model = E_MODEL_SMILER3,          scale = 1.2, y_offset = -30, podium = E_MODEL_FIND_TROPHY_PODIUM, message = "Trophy #13 - Find this right next to the skull."},
	{ name = "portal",     model = E_MODEL_NETHERPORTAL,     scale = 0.2, y_offset = 10,  podium = E_MODEL_FIND_TROPHY_PODIUM, message = "Trophy #14 - Take a trip through Hell.",
	  loop = function (o)
		o.parentObj.oAnimState = o.oTimer % 32
	  end},

	{ name = "bully",      model = E_MODEL_HELL_DORRIE,      scale = 0.07, y_offset = -20,  podium = E_MODEL_FIND_TROPHY_PODIUM, message = "Trophy #15 - When you're at the top of the volcano, go higher.",
	  loop = function (o)
		o.oAnimations = gObjectAnimations.dorrie_seg6_anims_0600F638
		obj_init_animation(o.parentObj, 1)

	  end},

	{ name = "boulder",    model = E_MODEL_HMC_ROLLING_ROCK, scale = 0.2, y_offset = -30, podium = E_MODEL_FIND_TROPHY_PODIUM, message = "Trophy #16 - Surely you've found the way around those boulders..",
	  loop = function (o)
		o.parentObj.oFaceAnglePitch = o.parentObj.oFaceAnglePitch -2000
	  end},

	{ name = "hoot",       model = E_MODEL_HOOT,             scale = 0.6, y_offset = 24,  podium = E_MODEL_FIND_TROPHY_PODIUM, message = "Trophy #17 - Somewhere in first 4 levels, must be found on Course Star #2 or higher.",
	  loop = function (o)
		o.oAnimations = gObjectAnimations.hoot_seg5_anims_05005768
		obj_init_animation(o.parentObj, 0)
	  end},

	{ name = "killyoshi",  model = E_MODEL_TROPHY_YOSHI,            scale = 0.4, y_offset = 10,   podium = E_MODEL_GORE_TROPHY_PODIUM, message = "Trophy #18 - Bad news, you need all 120 stars and have to kill your favorite dinosaur. Good news, you're gonna want to kill him by the time you finish those stars.",
	loop = function (o)
		o.oAnimations = gObjectAnimations.yoshi_seg5_anims_05024100
		obj_init_animation(o.parentObj, 0)
	  end},

	{ name = "deadtoad",   model = E_MODEL_TOAD_HEAD,        scale = 0.2, y_offset = 0,   podium = E_MODEL_GORE_TROPHY_PODIUM, message = "Trophy #19 - Toadal Genocide (50x kills)"},
	{ name = "iwbtg",      model = E_MODEL_IWBTG,            scale = 0.5, y_offset = -24,   podium = E_MODEL_GORE_TROPHY_PODIUM, message = "Trophy #20 - Collect 10 stars with IWBTG mode enabled!"}
}

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
		spawn_non_sync_object(id_bhvStaticObject, trophy.model, 0, 0, 0, function(display)
			display.oFlags = display.oFlags | OBJ_FLAG_TRANSFORM_RELATIVE_TO_PARENT
			obj_scale(display, trophy.scale*5)
			display.oParentRelativePosY = 102 - trophy.y_offset
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
	display.oAngleVelYaw = 300
	display.oFaceAngleYaw = display.oFaceAngleYaw + display.oAngleVelYaw

	obj_scale(display, trophy.scale)

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
			local nm = nearest_mario_state_to_object(o)
			-- collect (spin, fly up and shrink, leaving a trail of sparkles behind)
			if nm.playerIndex == 0 then
				djui_popup_create_global(tostring(gNetworkPlayers[nm.playerIndex].name) .. " collected a trophy!", 1)
				play_puzzle_jingle()
			end
			--network_play(sTrophy, m.pos, 1, m.playerIndex)
			--play_sound(SOUND_MENU_COLLECT_SECRET, gMarioStates[0].pos)
			--network_play(sTrophy, o.header.gfx.pos, 1, 0)
			--djui_chat_message_create("Trophy collected!")
			unlock_trophy(o.oBehParams >> 16)

			o.oVelY = -15
			o.oAction = 1
			o.oFloorHeight = 0.999
		else -- display, do a little bounce
			o.oVelY = 70
			o.oAction = 1
			--cur_obj_push_mario_away(80)
		end
	end
end

---@param o Object
function trophyplate_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	obj_set_hitbox_radius_and_height(o, 40, 100)
	if trophy_unlocked(o.oBehParams >> 16) then
        obj_set_model_extended(o, E_MODEL_GOLD_PLATE)
    else
        obj_set_model_extended(o, E_MODEL_SILVER_PLATE)
    end
end

function trophyplate_loop(o)
    local m = gMarioStates[0]
    local trophy = trophyinfo[o.oBehParams >> 16]

    if obj_check_hitbox_overlap(o, m.marioObj) and (m.controller.buttonPressed & B_BUTTON) ~= 0 then
        djui_chat_message_create(tostring(trophy.message))
        m.faceAngle.y = -43691
        set_mario_action(m, ACT_WAITING_FOR_DIALOG, 0)
        set_mario_action(m, ACT_IDLE, 0)
        local_play(sSmwping, m.pos, 1)
    end
end

function prize_spawner() -- Trophy Hunt Prize Spawner
    local m = gMarioStates[0]
    local np = gNetworkPlayers[0]

    if np.currLevelNum == LEVEL_SECRETHUB then
        local starplatform = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvSecretWarp)
        if not starplatform then
            if gGlobalSyncTable.allTrophiesUnlocked then
                spawn_non_sync_object(id_bhvSecretWarp, E_MODEL_GOLD_RING, 723, 196, -1683, nil)
                spawn_non_sync_object(id_bhvFlatStar, E_MODEL_STAR, 723, 196, -1683, nil)
            end
        end
    end
end

function gold_players(m)
	--local m = gMarioStates[0]
	local s = gStateExtras[0]
	
	if not gGlobalSyncTable.allTrophiesUnlocked then return end

	for i = 0, (MAX_PLAYERS - 1) do
		if gPlayerSyncTable[i].gold then
			local s = gStateExtras[i]
			s.isgold = true
		end
	end

	if s.isgold then
		--djui_chat_message_create("player is gold")
		m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
		m.marioObj.hookRender = 1
		obj_set_model_extended(m.marioObj, GoreHMApi.get_char_models(m).gold)
	end
end

hook_event(HOOK_MARIO_UPDATE, gold_players)
hook_event(HOOK_UPDATE, prize_spawner)

id_bhvTrophy = hook_behavior(nil, OBJ_LIST_GENACTOR, true, trophy_init, trophy_loop, "bhvTrophy")
id_bhvTrophyPlate = hook_behavior(nil, OBJ_LIST_GENACTOR, true, trophyplate_init, trophyplate_loop, "bhvTrophyPlate")