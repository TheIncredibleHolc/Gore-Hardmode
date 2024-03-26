-------------------------TROPHY SYSTEM-------------------------

trophyinfo = {
	{ name = "mario", model = E_MODEL_MARIO, scale = 0.5, --Trophy #1 Beat the game as Mario.
	--	loop = function (o)

	--	end
	},
	{ name = "luigi", model = E_MODEL_LUIGI, scale = 0.5, --Trophy #2 Beat the game as Luigi.
	--   loop = function (o)
		
	--   end
	},
	{ name = "toad", model = E_MODEL_TOAD_PLAYER, scale = 0.5, --Trophy #3 Beat the game as Toad.
	--   loop = function (o)
		
	--   end
	},
	{ name = "wario", model = E_MODEL_WARIO, scale = 0.5, --Trophy #4 Beat the game as Wario.
	--   loop = function (o)
		
	--   end
	},
	{ name = "waluigi", model = E_MODEL_WALUIGI, scale = 0.5, --Trophy #5 Beat the game as Waluigi.
	--   loop = function (o)
		
	--   end
	},
	{ name = "star", model = E_MODEL_STAR, scale = 0.6, --Trophy #6 Beat the game with all 5 characters. (Or get 120 stars?).
	--   loop = function (o)
		
	--   end
	},
	{ name = "portal", model = E_MODEL_NETHERPORTAL, scale = 0.2, --Trophy #7 Find the NetherPortal.
	  loop = function (o)
		o.oAnimState = o.oTimer % 32
	  end
	},
	{ name = "smiler", model = E_MODEL_BACKROOM_SMILER, scale = 0.2, --Trophy #8 Visit the Backrooms.
	--   loop = function (o)
		
	--   end
	},
	{ name = "fieldgoal", model = E_MODEL_GOALPOST, scale = 0.1, --Trophy #9 Kick a field goal in CCM.
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy10", model = E_MODEL_NONE, scale = 0.2, --Trophy #10
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy11", model = E_MODEL_NONE, scale = 0.2, --Trophy #11
	--   loop = function (o)
		
	--   end
	},
	{ name = "lakitu", model = E_MODEL_LAKITU, scale = 0.2, --Trophy #12 -- "Take a good look at yourself." (Mirror room)
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy13", model = E_MODEL_NONE, scale = 0.2, --Trophy #13
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy14", model = E_MODEL_NONE, scale = 0.2, --Trophy #14
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy15", model = E_MODEL_NONE, scale = 0.2, --Trophy #15
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy16", model = E_MODEL_NONE, scale = 0.2, --Trophy #16
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy17", model = E_MODEL_NONE, scale = 0.2, --Trophy #17
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy18", model = E_MODEL_NONE, scale = 0.2, --Trophy #18
	--   loop = function (o)
		
	--   end
	},
	{ name = "deadtoad", model = E_MODEL_TOAD_HEAD, scale = 0.2, --Trophy #19 - Kill Toad 50x
	--   loop = function (o)
		
	--   end
	},
	{ name = "trophy20", model = E_MODEL_NONE, scale = 0.2, --Trophy #20
	--   loop = function (o)
		
	--   end
	}

}

silverplate = smlua_model_util_get_id("silverplate_geo") --This is the description panel under the display trophy. (Silver has not been collected)
goldplate  = smlua_model_util_get_id("goldplate_geo")  --This is the description panel under the display trophy. (Gold is already collected)


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
		spawn_non_sync_object(id_bhvStaticObject, E_MODEL_TROPHY_PODIUM, o.oPosX, o.oPosY - 102, o.oPosZ, function(podium)
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
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.header.gfx.skipInViewCheck = true
	obj_set_hitbox_radius_and_height(o, 40, 100)
	trophy_load(o)
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