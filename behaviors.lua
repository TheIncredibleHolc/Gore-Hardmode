--All custom behaviors.

function killer_exclamation_boxes(m) -- Makes exclamation boxes drop on top of you! (squishes)
	box = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvExclamationBox)

	if box ~= nil then
		if lateral_dist_between_objects(m.marioObj, box) < 50 and m.pos.y < box.oPosY and m.pos.y > box.oPosY - 400 then
			box.oPosY = box.oPosY - 100
		end
	end
end

local function bhv_red_flood_flag_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oInteractType = INTERACT_POLE
    o.hitboxRadius = 80
    o.hitboxHeight = 700
    o.oIntangibleTimer = 0

    cur_obj_init_animation(0)
end

local function bhv_red_flood_flag_loop(o)
    bhv_pole_base_loop()
end

function bhv_custom_kingwhomp(obj)
	local m = nearest_mario_state_to_object(obj)
	if obj.oHealth == 3 then
		cur_obj_scale(.2)
	end
	if obj.oHealth == 2 then
		whompblood = spawn_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, obj.oPosX, obj.oPosY + 1, obj.oPosZ, nil)
		obj_scale(whompblood, .4)
		local_play(sSplatter, m.pos, 1)
		--play_sound_with_freq_scale(SOUND_OBJ_KING_WHOMP_DEATH, m.marioObj.header.gfx.cameraToObject, 3.0)
		obj_mark_for_deletion(obj)
		stop_background_music(SEQ_EVENT_BOSS)
		spawn_default_star(m.pos.x, m.pos.y + 200, m.pos.z)
	end
	if obj.oMoveFlags & OBJ_MOVE_LANDED ~= 0 and obj.oHealth >= 2 then
		spawn_sync_object(id_bhvBowserShockWave, E_MODEL_BOWSER_WAVE, obj.oPosX, obj.oPosY, obj.oPosZ, nil)
	end
	obj.oForwardVel = 30
	if lateral_dist_between_objects(m.marioObj, obj) < 700 then
		--m.floor.type = surface_ --SURFACE_QUICKSAND
	end
end

function bhv_custom_kingbobomb(obj) -- Funny boss battle
	local m = nearest_mario_state_to_object(obj)

	obj.oHomeX, obj.oHomeY, obj.oHomeZ = obj.oPosX, obj.oPosY, obj.oPosZ
	

	if obj.oMoveFlags & OBJ_MOVE_LANDED ~= 0 then
		--obj.oHealth = obj.oHealth - 1
	end
	if obj.oHealth == 6 then
		cur_obj_scale(1.6)
		gBehaviorValues.KingBobombFVel = 3
		gBehaviorValues.KingBobombYawVel = 160
	elseif obj.oHealth == 5 then
		cur_obj_scale(1.1)
		gBehaviorValues.KingBobombFVel = 6.0
		gBehaviorValues.KingBobombYawVel = 320
	elseif obj.oHealth == 4 then
		cur_obj_scale(.7)
		gBehaviorValues.KingBobombFVel = 12.0
		gBehaviorValues.KingBobombYawVel = 640
	elseif obj.oHealth == 3 then
		cur_obj_scale(.5)
		gBehaviorValues.KingBobombFVel = 24.0
		gBehaviorValues.KingBobombYawVel = 1280
	elseif obj.oHealth == 2 then
		cur_obj_scale(.25)
		gBehaviorValues.KingBobombFVel = 26
		gBehaviorValues.KingBobombYawVel = 1400
		

	elseif obj.oHealth == 1 then
		local bobsplat = spawn_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, obj.oPosX, obj.oPosY + 1, obj.oPosZ, nil)
		obj_scale(bobsplat, .4)
		local_play(sSplatter, m.pos, 1)
		spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, obj.oPosX, obj.oPosY, obj.oPosZ, nil)
		spawn_sync_object(id_bhvExplosion, E_MODEL_EXPLOSION, obj.oPosX, obj.oPosY, obj.oPosZ, nil)
		obj.oTimer = 0
		
		cur_obj_disable_rendering_and_become_intangible(obj)
		obj.oHealth = 8
	end
	if obj.oHealth == 8 then
		cur_obj_disable_rendering_and_become_intangible(obj)
	end
	if obj.oTimer == 60 and obj.oHealth == 8 then
		obj.oHealth = 0
		--obj.oAction = 8
		obj_mark_for_deletion(obj)
		stop_background_music(SEQ_EVENT_BOSS)
		spawn_default_star(m.pos.x, m.pos.y + 200, m.pos.z)
	end
	if obj.oHealth == 2 and obj.oMoveFlags == 128 then
		obj.oForwardVel = obj.oForwardVel + 5
		obj.oFaceAnglePitch = obj.oFaceAnglePitch + 4000
	else
		obj.oFaceAnglePitch = 0
	end
	if obj.oAction == 3 then
		if obj.oTimer == 0 and gMarioStates[0].marioObj == obj.usingObj then
			cutscene_object_with_dialog(CUTSCENE_DIALOG, obj, DIALOG_116)
		elseif obj.oTimer == 40 then
			obj.oSubAction = 3
		end
		cur_obj_rotate_yaw_toward(0, 0x400)
	end
	-- djui_chat_message_create(""..obj.oAction.."\n"..obj.oSubAction.."\n"..obj.oTimer)
	--[[
	if obj.oHealth < 5 then
		djui_chat_message_create(tostring(obj.oMoveFlags))
	end
	]]
end

function bobomb_loop(o) -- makes bobombs SCARY fast (Thanks blocky.cmd!!)
	local player = nearest_player_to_object(o)
	if o.oAction == 0 then
		if player ~= nil and
		   obj_return_home_if_safe(o, o.oHomeX, o.oHomeY, o.oHomeZ, 400) == 1 and
		   dist_between_objects(o, player) < 600 then
			o.oBobombFuseLit = 1
			o.oAction = BOBOMB_ACT_CHASE_MARIO
		end
	elseif o.oAction == 2 then
		o.oForwardVel = 35.0
		object_step()

		if player ~= nil then
			obj_turn_toward_object(o, player, 16, 0x800)
		end
	end
end

function bhv_custom_boulder(obj) --Locks onto mario and homes-in on him.
	local m = nearest_player_to_object(obj)
	obj_turn_toward_object(obj, m, 16, 0x800)
end

function bhv_custom_bowserbomb(bowsbomb) --Oscillates up and down
	local m = nearest_mario_state_to_object(bowsbomb)
	if bowsbomb.oTimer >= 10 then
		bowsbomb.oHomeY = math.random(-1500, 1500)
		bowsbomb.oTimer = 0
	end
	bowsbomb.oVelY = bowsbomb.oVelY + (bowsbomb.oHomeY - bowsbomb.oPosY) * .02
	object_step()
end

function bhv_custom_bouncing_fireball(obj) --Locks onto mario and homes-in on him.
	local m = nearest_player_to_object(obj)
	obj_turn_toward_object(obj, m, 16, 0x800)
end

function bhv_custom_flyguy(obj)
	obj.oForwardVel = 100
	obj.oFlyGuyIdleTimer = 0
	if (is_within_100_units_of_mario(obj.oPosX, obj.oPosY, obj.oPosZ) == 1) then
		obj.oAction = FLY_GUY_ACT_SHOOT_FIRE
		obj.oAction = FLY_GUY_ACT_SHOOT_FIRE
		obj.oAction = FLY_GUY_ACT_SHOOT_FIRE
		obj.oAction = FLY_GUY_ACT_SHOOT_FIRE
	end
end

--[[ I tried to make coins run away from mario like 6 different ways. It aint happening. 
function bhv_custom_coins(obj)
	local player = nearest_mario_state_to_object(obj)
	--local player = nearest_player_to_object(obj)
	if mario_is_within_rectangle(obj.oPosX - 250, obj.oPosX + 250, obj.oPosZ - 250, obj.oPosZ + 250) ~= 0 then
		coin = spawn_sync_object(id_bhvBlueCoinSliding, E_MODEL_YELLOW_COIN, obj.oPosX, obj.oPosY, obj.oPosZ, nil)
		obj_mark_for_deletion(obj)
		coin.oForwardVel = 20.0;
		angleToPlayer = obj_angle_to_object(coin, player.marioObj)
		coin.oMoveAngleYaw = angleToPlayer + 0x8000
	end
end
]]

function bhv_custom_bully(obj)
	local np = gNetworkPlayers[0]
	local m = nearest_mario_state_to_object(obj)
	if np.currLevelNum == LEVEL_SECRETHUB then
		cur_obj_scale(0.5)
	end

	obj.oHomeX = m.pos.x
	obj.oHomeY = m.pos.y
	obj.oHomeZ = m.pos.z
	if obj.oAction == BULLY_ACT_CHASE_MARIO or
	   obj.oAction == BULLY_ACT_PATROL then
		obj.oForwardVel = 30
	end
end

function bhv_custom_explosion(obj) -- replaces generic explosions with NUKES! (Bigger radius, bigger explosion, louder)
	local m = nearest_mario_state_to_object(obj)
	local_play(sBigExplosion, m.pos, 1)
	cur_obj_shake_screen(SHAKE_POS_LARGE)
	spawn_sync_if_main(id_bhvBowserBombExplosion, E_MODEL_BOWSER_FLAMES, obj.oPosX, obj.oPosY, obj.oPosZ, nil, 0)
	if dist_between_objects(obj, m.marioObj) <= 850 then
		m.squishTimer = 50
	end
end

function bhv_custom_chain_chomp(obj)
	if (obj.oChainChompReleaseStatus == CHAIN_CHOMP_NOT_RELEASED) then
		obj.oMoveAngleYaw = obj.oMoveAngleYaw * 5
		obj.oForwardVel = obj.oForwardVel * 3
		obj.oTimer = 0
		
		local kingbob = obj_get_nearest_object_with_behavior_id(obj, id_bhvKingBobomb)
		local goomba = obj_get_nearest_object_with_behavior_id(obj, id_bhvGoomba)
		local bobomb = obj_get_nearest_object_with_behavior_id(obj, id_bhvBobomb)
		if kingbob ~= nil then
			if obj_check_hitbox_overlap(obj, kingbob) then
				obj_mark_for_deletion(kingbob)
				network_play(sCrunch, m.pos, 1, m.playerIndex)
				network_play(sSplatter, m.pos, 1, m.playerIndex)
				djui_chat_message_create("Wait... what...?? How did you do that?! -IncredibleHolc")
				play_sound(SOUND_MENU_COLLECT_SECRET, gMarioStates[0].pos)
				if feedchomp == nil then
					feedchomp = 1
				else 
					feedchomp = feedchomp + 1
				end
			end
		end 
		if goomba ~= nil then
			if obj_check_hitbox_overlap(obj, goomba) then
				squishblood(goomba)
				obj_mark_for_deletion(goomba)
				network_play(sCrunch, m.pos, 1, m.playerIndex)
				network_play(sSplatter, m.pos, 1, m.playerIndex)
				if feedchomp == nil then
					feedchomp = 1
				else 
					feedchomp = feedchomp + 1
				end
			end
		end 
		if bobomb ~= nil then
			if obj_check_hitbox_overlap(obj, bobomb) then
				squishblood(bobomb)
				obj_mark_for_deletion(bobomb)
				network_play(sCrunch, m.pos, 1, m.playerIndex)
				network_play(sSplatter, m.pos, 1, m.playerIndex)
				if feedchomp == nil then
					feedchomp = 1
				else 
					feedchomp = feedchomp + 1
				end
			end
		end 
		if feedchomp == 5 and gGlobalSyncTable.gameisbeat and not trophy_unlocked(7) then --GRANT TROPHY #19
			play_puzzle_jingle()
			network_play(sBurp, m.pos, 1, m.playerIndex)
			play_sound(SOUND_MENU_COLLECT_SECRET, m.pos)
			spawn_non_sync_object(id_bhvMistParticleSpawner, E_MODEL_MIST, 272, 975, 1914, nil)
			spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, 272, 975, 1914, function(t)
				t.oBehParams = 7 << 16 | 1
			end)
			feedchomp = 0
		end


	else
		if obj.oTimer >= 117 then
			local m = nearest_mario_state_to_object(obj)
			squishblood(obj)
			chompmist = spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, obj.oPosX, obj.oPosY, obj.oPosZ, nil)
			obj_scale(chompmist, 3)
			set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
			local_play(sSplatter, m.pos, 1)
			obj_mark_for_deletion(obj)
			
		end
	end

end

function bhv_custom_goomba_loop(obj) -- make goombas faster, more unpredictable. Will lunge at Mario
	local m = nearest_mario_state_to_object(obj)
	local np = gNetworkPlayers[0]
	if obj.oGoombaJumpCooldown >= 9 then
		obj.oGoombaJumpCooldown = 8
		obj.oVelY = obj.oVelY + 10
		obj.oForwardVel = 70
	end

	if np.currLevelNum == LEVEL_BOWSER_2 and obj.oPosY == obj.oFloorHeight then
		obj.oForwardVel = 30
	end

	if obj.oAction == GOOMBA_ACT_JUMP and obj.oTimer < 6 then
		cur_obj_rotate_yaw_toward(obj.oGoombaTargetYaw, 0x200)
	end

	obj.oHomeX = m.pos.x
	obj.oHomeY = m.pos.y
	obj.oHomeZ = m.pos.z

	if obj_has_model_extended(obj, E_MODEL_WOODEN_SIGNPOST) ~= 0 then
		if ia(m) and obj.oAction > 2 and -- consider any action outside of the three goomba actions dead
		   m.controller.buttonPressed & B_BUTTON ~= 0 then -- press b to trigger dialog
			cutscene_object_with_dialog(CUTSCENE_DIALOG, obj, obj.oBehParams)
		end
	end
end

function bhv_custom_thwomp(obj)
	local m = nearest_player_to_object(obj)
	local np = gNetworkPlayers[0]
	if np.currLevelNum ~= LEVEL_TTC then --TTC is excluded for flood as its nearly unbeatable. Giving the player mercy by turning it off in regular game mode too.	
		obj.oThwompRandomTimer = 0 --Instant falling

		if obj.oAction == 0 then --ARISE!!
			obj.oPosY = obj.oPosY + 15
			if obj.oTimer == math.random(5, 40) then
				obj.oAction = 1
			end
		end
		if obj.oAction == 3 then --EARTHQUAAAAKE
			--cur_obj_shake_screen(SHAKE_POS_SMALL)
			spawn_mist_particles()
		end
		if obj.oAction == 4 then --No more waiting to rise!
			obj.oAction = 0
		end
		if obj.oAction == 2 then --CRUSH THEM (randomly) FAST!!
			obj.oVelY = obj.oVelY - 52
			obj.oTimer = 0
		end
		
		if obj.oAction == 3 and obj.oTimer > 1 and lateral_dist_between_objects(m, obj) < 150 then
			obj.oAction = 4
		end

	end
end

function bhv_custom_pitbowlball(obj)
	local m = nearest_player_to_object(obj)
	if lateral_dist_between_objects(m, obj) < 350 then
		obj.oForwardVel = 200
	end
end

function bhv_custom_whomp_slidingpltf(obj) --WF Sliding platforms after the weird rock eye guys.
	obj.oWFSlidBrickPtfmMovVel = 100
end

function bhv_custom_whomp(obj) --Whomps jump FAR now!
	cur_obj_scale(2)
	--obj.oForwardVel = 9.0
	obj.oTimer = 101

	--obj.oForwardVel = 40
end

function bhv_custom_seesaw(obj) --SeeSaw Objects spin like windmills
	obj.oSeesawPlatformPitchVel = -400
end

function bhv_custom_sign(obj) --This is the single most evil addition to the game. Real proud of this one :')
	local m = nearest_player_to_object(obj)
	if dist_between_objects(m, obj) < 500 then
		--evilsign =
		--- @param o Object 
		spawn_sync_if_main(id_bhvGoomba, E_MODEL_WOODEN_SIGNPOST, obj.oPosX, obj.oPosY, obj.oPosZ, function (o)
			obj_copy_angle(o, obj)
			o.oBehParams = obj.oBehParams2ndByte
		end, 0)
		obj_mark_for_deletion(obj)
	end
end

function bhv_custom_toxbox(obj) -- Yeah this isn't doing anything. These guys move in a stupid way that I can't understand.
	if obj ~= nil then
		--obj.oTimer = obj.oTimer + 1
		--tox_box_move(0, 1, 1, 0)
	end
end

function bhv_custom_tree(obj) -- Trees fall down through the map when approached.
	local m = nearest_player_to_object(obj)
	if lateral_dist_between_objects(m, obj) < 150 then
		obj.oPosY = obj.oPosY - 500
	end
end

function bhv_custom_bowlball(bowlball) -- I've got big balls, oh I've got big balls. They're such BIG balls, fancy big balls! And he's got big balls, and she's got big balls!
	obj_scale(bowlball, 1.8)
	bowlball.oForwardVel = bowlball.oForwardVel + 1
	bowlball.oFriction = 1
	if bowlball.oTimer > 180 then
		obj_mark_for_deletion(bowlball)
	end
end

function bhv_custom_bowlballspawner(obj) -- Idk if this actually does anything, but maybe?
	obj.oBBallSpawnerSpawnOdds = 1

end

function bhv_bowser_key_spawn_ukiki(obj) --Bow1 spawns Ukiki minigame, Bow2 spawns Goomba minigame
	local m = gMarioStates[0]
	local np = gNetworkPlayers[0]
	if np.currLevelNum == LEVEL_BOWSER_1 then
		spawn_sync_if_main(id_bhvUkiki, E_MODEL_UKIKI, obj.oPosX, obj.oPosY + 50, obj.oPosZ, function (o)
			o.oAction = 3
		end, 0)
		cur_obj_disable_rendering_and_become_intangible(obj)
		fadeout_music(0)
		stream_play(smwbonusmusic)
	end
	if np.currLevelNum == LEVEL_BOWSER_2 then
		cur_obj_disable_rendering_and_become_intangible(obj)
		fadeout_music(0)
		if m.playerIndex == 0 then --LISTEN. I know what you're thinking, and don't even try it. Yes, this looks wrong. It looks dumb. You want to optimize. DON'T!!
			if m.playerIndex ~= 0 then return end --I know it doesn't make sense, but I have tried every other combination under the sun (network_play with m.playerindex included) and THIS is the ONLY fix to prevent double audio. If you dare touch it, test it THOROUGHLY before pushing or face my wrath!! D:<
			local_play(sBows2intro, m.pos, 1)
		end
	end
end

function bhv_bowser_key_ukiki_loop(obj) --Bow1 spawns Ukiki minigame, Bow2 spawns Goomba minigame
	--djui_chat_message_create(tostring(obj.oTimer))
	--djui_chat_message_create(tostring(obj.oAction))
	local np = gNetworkPlayers[0]

	if np.currLevelNum == LEVEL_BOWSER_1 then
		local o = obj_get_nearest_object_with_behavior_id(obj, id_bhvUkiki)
		if o then
			cur_obj_disable_rendering_and_become_intangible(obj)
			obj_copy_pos(obj, o)
			obj.oBehParams = 1
		elseif obj.oBehParams == 1 then
			cur_obj_enable_rendering_and_become_tangible(obj)
			obj.oAction = 0
			obj.oPosY = obj.oPosY + 200
			obj.oBehParams = 0
		end
	end


	if np.currLevelNum == LEVEL_BOWSER_2 then
		if obj.oAction == 1 then
			if obj.oTimer <= 60 then
				cur_obj_disable_rendering_and_become_intangible(obj)
			end
			if obj.oTimer == 42 then
				stream_play(musicbows2)
			end

			if obj.oTimer == 40 then
				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, 1713, 1230, -698, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, 1688, 1230, -698, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, 1713, 1230, 690, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, 1713, 1230, 690, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, 695, 1230, 1697, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, 695, 1230, 1697, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, -721, 1230, 1697, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, 695, 1230, 1697, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, -1716, 1230, 680, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, -1716, 1230, 680, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, -1670, 1230, -680, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, -1670, 1230, -680, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, -696, 1230, -1708, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, -696, 1230, -1708, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, -743, 1230, -1708, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, -743, 1230, -1708, nil, 0)
			end

			if obj.oTimer == 100 then
				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, 2650, 1230, -128, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, 2650, 1230, -128, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, 58, 1230, 2402, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, 58, 1230, 2402, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, -2357, 1230, 98, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, -2357, 1230, 98, nil, 0)

				spawn_sync_if_main(id_bhvGoomba, E_MODEL_GOOMBA, 32, 1230, -2404, nil, 0)
				spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, 32, 1230, -2404, nil, 0)
			end
		end

		local o = obj_get_first_with_behavior_id(id_bhvGoomba)
		if o then
			cur_obj_disable_rendering_and_become_intangible(obj)
			obj_copy_pos(obj, o)
			obj.oBehParams = 1
		elseif obj.oBehParams == 1 then
			cur_obj_enable_rendering_and_become_tangible(obj)
			--obj.oAction = 0
			if obj.oPosY >= obj.oFloorHeight then
				obj.oPosY = obj.oPosY - 5
			else
				obj.oBehParams = 0
				stream_fade(50)
			end
		end
	end
end

hook_behavior(id_bhvUkiki, OBJ_LIST_GENACTOR, false, function (obj)
	obj.oPosY = obj.oHomeY
end, nil)

function lava_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = COL_LAVA
	o.oCollisionDistance = 10000
    o.header.gfx.skipInViewCheck = true
	bhv_init_room()
end

function lava_loop(o)
    load_object_collision_model()
end

function bhv_checkerboard_platform(o)
	if o.oBehParams2ndByte == 0 then
		if o.oAction == 3 then o.oAction = 2 end
	elseif o.oAction == 1 then
		-- checkerboard_plat_act_rotate
    	o.oVelY = 0
    	o.oAngleVelPitch = 512
    	if (o.oTimer + 1 == 0x8000 / absf_2(512)) then
    	    o.oAction = 4
		end
    	o.oCheckerBoardPlatformUnkF8 = 4
	end
end

function bhv_ferris_wheel_axle(o)
	o.oFaceAngleRoll = o.oFaceAngleRoll + 400
end

function get_pressure_point(o)
	local avg = vec3f()
	local obj = vec3f()
	object_pos_to_vec3f(obj, o)
	local count = 0
	for i = 0, MAX_PLAYERS-1 do
		local m = gMarioStates[i]
		if is_player_active(m) ~= 0 and m.marioObj and m.marioObj.platform == o then
			vec3f_add(avg, m.pos)
			count = count + 1
		end
	end
	if count < 1 then return vec3f() end
	vec3f_mul(avg, 1/count)
	vec3f_sub(avg, obj)
	return avg
end

function bhv_ferris_wheel(o)
	local pressure = get_pressure_point(o)
	o.oAngleVelRoll = (o.oAngleVelRoll + (-pressure.x*30 - o.oFaceAngleRoll)*0.1)*0.95
	if cur_obj_is_mario_ground_pounding_platform() ~= 0 then
		o.oAngleVelRoll = -pressure.x*300
	end
	if o.oFaceAngleRoll ~= limit_angle(o.oFaceAngleRoll) then
		cur_obj_play_sound_1(SOUND_GENERAL_BIG_CLOCK)
		o.oFaceAngleRoll = limit_angle(o.oFaceAngleRoll)
	end
	cur_obj_rotate_face_angle_using_vel()
end

function bhv_custom_grindel(o)
	o.oTimer = 60
    cur_obj_move_standard(2)
end

function bhv_custom_spindel(o)
	sp18 = 20 - o.oSpindelUnkF4
	sp1C = sins(o.oMoveAnglePitch * 32) * 46.0
	o.oPosZ = o.oPosZ + o.oVelZ
	if (o.oTimer < sp18 * 1) then
        if (o.oSpindelUnkF8 == 0) then
            o.oVelZ = 500
            o.oAngleVelPitch = 128
        else
            o.oVelZ = -500
            o.oAngleVelPitch = -128
		end
	end	
end

function bhv_custom_firebars(o)
	o.oMoveAngleYaw = -2048
end

function bhv_custom_hex_platform(o)
	o.oAngleVelYaw = 5000
	o.oMoveAngleYaw = o.oMoveAngleYaw + 4744
	load_object_collision_model()
end

local function bhv_hellplatform_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 7000
    o.collisionData = COL_HELLPLATFORM
    o.oAngleVelYaw = 750
    obj_scale(o, 1)
end

local function bhv_hellplatform_loop(o)
    load_object_collision_model()
    o.oFaceAngleYaw = o.oFaceAngleYaw + o.oAngleVelYaw
end

function bhv_backroom_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 10000
    o.collisionData = COL_BACKROOM
    o.header.gfx.skipInViewCheck = true
	hud_hide()
end

function bhv_backroom_loop(o)
	load_object_collision_model()
	if o.oTimer == 600 then
		stream_stop_all()
		local_play(sGlass, gLakituState.pos, 1)
		obj_set_model_extended(o, E_MODEL_BLACKROOM)
		set_lighting_color(0,2)
		set_lighting_color(1,2)
		set_lighting_color(2,2)
		set_lighting_dir(1,128)
	end

	if o.oTimer == 750 then
		local_play(sSmiler, o.header.gfx.pos, .3)
	end
	if o.oTimer == 1050 then
		local_play(sSmiler, o.header.gfx.pos, .6)
	end
	if o.oTimer == 1300 then
		spawn_non_sync_object(id_bhvBackroomSmiler, E_MODEL_BACKROOM_SMILER, 0, 10700, 0, nil)
	end
	if cur_obj_is_any_player_on_platform() ~= 0 then
		o.oSubAction = 0
	end
	if o.oSubAction == 20 then
		obj_mark_for_deletion(o)
	end
end

function bhv_backroom_smiler_init(o)
	m = gMarioStates[0]
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.hitboxRadius = 160
    o.hitboxHeight = 100
    o.oWallHitboxRadius = 30
end

function bhv_backroom_smiler_loop(o)
	local s = gStateExtras[0]
	local player = nearest_player_to_object(o)
	local angletomario = obj_angle_to_object(o, m.marioObj)

    o.oFaceAngleYaw = angletomario - 16384
	--load_object_collision_model()
	obj_turn_toward_object(o, player, 16, 0x800)
	o.oForwardVel = 20
	object_step()
	if o.oTimer % 280 == 1 then
		local_play(sSmiler, o.header.gfx.pos, 1)
	end
	if obj_check_hitbox_overlap(o, m.marioObj) and not s.isdead then

		s.bottomless = true
		network_play(sSplatter, m.pos, 1, m.playerIndex)
		network_play(sCrunch, m.pos, 1, m.playerIndex)
		audio_sample_stop(gSamples[sSmiler])
		squishblood(m.marioObj)
		m.health = 0xff
		mario_blow_off_cap(m, 15)
		set_mario_action(m, ACT_BITTEN_IN_HALF, 0)
		if mod_storage_load("smiler") == "1" then
			--nothing
		else
			spawn_sync_object(id_bhvTrophy, E_MODEL_GOALPOST, m.pos.x, m.pos.y, m.pos.z, function(t)
				t.oBehParams = 8 << 16 | 1
			end)
		end
		obj_mark_for_deletion(o)

		
	end
end

function bhv_custom_crushtrap(o)
	if mario_is_within_rectangle(o.oPosX -100, o.oPosX + 100, o.oPosX -100, o.oPosX + 100) then
		if o.oAction == 1 then
			o.oRollingLogUnkF4 = o.oRollingLogUnkF4 + 8
		end

		if o.oAction == 2 then
			o.oPosY = o.oHomeY + sins(o.oTimer * 0x1000) * 10.0;
			o.oAction = 3
		end

		if o.oAction == 3 then
			o.oAngleVelPitch = 2000
			o.oFaceAnglePitch = o.oFaceAnglePitch + o.oAngleVelPitch
		end

		if o.oTimer >= 4 then
			o.oTimer = 0
			o.oAction = 0
		end
	end
end

function bhv_custom_swing(o) -- Mostly in RR, might be other maps too. Is fun!
	if (o.oFaceAngleRoll < 0) then
		o.oSwingPlatformSpeed = o.oSwingPlatformSpeed + 64.0
	else 
		o.oSwingPlatformSpeed = o.oSwingPlatformSpeed - 64.0
	end
end

function bhv_custom_rotating_platform(o) --Spinning platform high up on RR. (Plus other maps??)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.oAngleVelYaw = o.oAngleVelYaw + 1600
	o.oFaceAngleYaw = o.oFaceAngleYaw + o.oAngleVelYaw
end

function bhv_custom_heart(o)
	m = nearest_mario_state_to_object(o)
	--if is_point_within_radius_of_any_player(200, 50, 200, 200) ~= 0 then
	if mario_is_within_rectangle(o.oPosX - 200, o.oPosX + 200, o.oPosZ - 200, o.oPosZ + 200) ~= 0 then
		obj_mark_for_deletion(o)
		spawn_mist_particles()
		local_play(sFart, o.header.gfx.pos, 1)
	end
end

function bhv_custom_moving_plats(o)
	if o.oAction == PLATFORM_ON_TRACK_ACT_MOVE_ALONG_TRACK then
		bhv_platform_on_track_update()
		bhv_platform_on_track_update()
		bhv_platform_on_track_update()
		bhv_platform_on_track_update()
		o.oVelX,   o.oVelY,   o.oVelZ,   o.oAngleVelYaw =
		o.oVelX*5, o.oVelY*5, o.oVelZ*5, o.oAngleVelYaw*5
	end
end

function bhv_custom_tuxie(o)
	if o.oAction == 6 then
		if o.oTimer == 0 then
			o.oGravity = -2
			--o.oBounciness = 0
			o.oForwardVel = 45
			o.oVelY = 75
		end
		o.oFaceAnglePitch = o.oFaceAnglePitch + 7500
		cur_obj_move_standard(-78)

		local goalpost = obj_get_nearest_object_with_behavior_id(o, id_bhvGoalpost)
		if dist_between_objects(o, goalpost) < 3000 then
			approach_vec3f_asymptotic(gLakituState.focus, o.header.gfx.pos, 3,3,3)
			approach_vec3f_asymptotic(gLakituState.curFocus, o.header.gfx.pos, 3,3,3)
		end
		if obj_check_hitbox_overlap(o, goalpost) ~= 0 then
			--GOOOAAALLL
		end

		if o.oMoveFlags & OBJ_MOVE_LANDED ~= 0 then
			if o.oFloor.type ~= SURFACE_DEATH_PLANE then
				squishblood(o)
				local_play(sSplatter, o.header.gfx.pos, 1)
			end
			spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
			cur_obj_shake_screen(SHAKE_POS_SMALL)
			obj_mark_for_deletion(o)
		end
	end
end

function bhv_netherportal_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.oCollisionDistance = 800
	obj_set_model_extended(o, E_MODEL_NETHERPORTAL)
	o.collisionData = COL_NETHERPORTAL
	o.header.gfx.skipInViewCheck = true
end

function bhv_netherportal_loop(o)
	load_object_collision_model()
	local m = gMarioStates[0]

	o.oAnimState = o.oTimer % 32
	if o.oTimer % 300 == 0 and lateral_dist_between_objects(o, m.marioObj) < 1000 and loadingscreen == 0 then
		local_play(sPortalAmbient, o.header.gfx.pos, 2)
	end
	stream_set_volume(clampf(lateral_dist_between_objects(o, m.marioObj)/800, 0.4, 1))
	if m.floor and m.floor.object and o == m.floor.object and
	   m.ceil  and m.ceil.object  and o == m.ceil.object then
		o.oSubAction = o.oSubAction + 1
	else
		o.oSubAction = 0
	end
	if o.oSubAction == 1 then
		local_play(sPortalEnter, o.header.gfx.pos, 1)
	end
	if o.oSubAction == 130 then
		loadingscreen = 30 + math.random(30)
		set_mario_action(m, ACT_GONE, 0)
		stream_stop_all()
		stop_all_samples()
	end
end

function bhv_custom_merry_go_round(o)
	if o.oMerryGoRoundStopped == 0 then
		o.oAngleVelYaw = o.oAngleVelYaw + 2048
		o.oMoveAngleYaw = o.oMoveAngleYaw + o.oAngleVelYaw
		o.oFaceAngleYaw = o.oFaceAngleYaw + o.oAngleVelYaw - 128
	end
end

function bhv_custom_piano(o)
	m = nearest_mario_state_to_object(o)
	if mario_is_within_rectangle(o.oPosX - 700, o.oPosX + 700, o.oPosZ - 700, o.oPosZ + 700) ~= 0 then
		local angleToPlayer = obj_angle_to_object(o, m.marioObj)
		o.oHomeX = m.pos.x
		o.oHomeZ = m.pos.z
		o.oAction = MAD_PIANO_ACT_ATTACK
		o.oForwardVel = 25
		cur_obj_rotate_yaw_toward(angleToPlayer, 2400)

	end
end

function bhv_custom_chairs(o)
	if (o.oHauntedChairUnkF4 ~= 0) then
		if (o.oHauntedChairUnkF4 == 0) then
			obj_compute_vel_from_move_pitch(90.0)
		end
	end
end

function bhv_goalpost_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.collisionData = COL_GOALPOST
	-- o.oCollisionDistance = 8000
	o.hitboxHeight = 1900
	o.hitboxRadius = 470
	--o.hitboxHeight = 70
	--o.hitboxRadius = 1070
	o.hitboxDownOffset = -507
end

function bhv_goalpost_loop(o)
	--o.header.gfx.scale.z = o.hitboxRadius / 100
	--o.header.gfx.scale.y = o.hitboxHeight / 100
	local mp = nearest_player_to_object(o)
	local tuxie = obj_get_nearest_object_with_behavior_id(mp, id_bhvSmallPenguin)
	
	if tuxie and o.oTimer > 60 and obj_check_hitbox_overlap(o, tuxie) then --GRANT TROPHY #9
		spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, 5104, -4577, 1435, nil)
		spawn_sync_object(id_bhvTrophy, E_MODEL_GOALPOST, 5104, -4577, 1435, function(t)
			t.oBehParams = 9 << 16 | 1
			if mod_storage_load("fieldgoal") == "1" then
				djui_chat_message_create("Field goal successful! Trophy awarded.")
			else
				djui_chat_message_create("IT'S GOOD!!!")
			end
			o.oTimer = 0
		end)

		--play_secondary_music(SEQ_EVENT_SOLVE_PUZZLE, 1, 1, 1)
		play_sound(SOUND_MENU_COLLECT_SECRET, gMarioStates[0].pos)
	end

	load_object_collision_model()
end

function warp_init(o)
	o.hitboxHeight = 100
	o.hitboxRadius = 100
end

function warp_loop(o)
	local m = gMarioStates[0]
	if obj_check_hitbox_overlap(o, m.marioObj) and m.action == ACT_IDLE then
		play_sound(SOUND_GENERAL_VANISH_SFX, m.marioObj.header.gfx.cameraToObject)
		m.pos.x = 5514
		m.pos.y = 1613
		m.pos.z = 3159
	end
end

function bhv_custom_spindrift(o)
	if mario_is_within_rectangle(o.oPosX - 500, o.oPosX + 500, o.oPosZ - 500, o.oPosZ + 500) ~= 0 then
		o.oForwardVel = 30
	end
end

function bhv_custom_slidingplatform2(o)
	local np = gNetworkPlayers[0]
	if np.currLevelNum == LEVEL_BITDW or np.currLevelNum == LEVEL_BITFS then
		obj_mark_for_deletion(o)
	end
end

function bhv_custom_circlingamp(o)
	--local random = math.random(1,2)
	if o.oTimer < 30 then
		o.oPosX = o.oHomeX + sins(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 1
		o.oPosZ = o.oHomeZ + coss(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 1
	end
	if o.oTimer >= 40 then
		o.oPosX = o.oHomeX + sins(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 2
		o.oPosZ = o.oHomeZ + coss(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 2
	end
	
	if o.oTimer >= 62 then
		local random = math.random(1, 10)
		o.oTimer = random
	end
end

function bhv_custom_squarishPathMoving(o)
	local np = gNetworkPlayers[0]

	if np.currLevelNum == LEVEL_BITDW and o.oPosY <= -2959 then
		obj_mark_for_deletion(o)
	end

	if np.currLevelNum == LEVEL_BITFS then
		obj_mark_for_deletion(o)
	end

end

function bhv_custom_ActivatedBackAndForthPlatform(o)
	local m = nearest_mario_state_to_object(o)
	local np = gNetworkPlayers[0]

	if np.currLevelNum == LEVEL_BITFS and m.pos.y >= o.oPosY -10 and mario_is_within_rectangle(o.oPosX - 500, o.oPosX + 500, o.oPosZ - 500, o.oPosZ + 500) ~= 0 then
		spawn_triangle_break_particles(30, 138, 1, 4)
		cur_obj_play_sound_1(SOUND_GENERAL_WALL_EXPLOSION)
		cur_obj_play_sound_1(SOUND_GENERAL_EXPLOSION6)
		obj_mark_for_deletion(o)
	end
end

function bhv_custom_yoshi(o)
	local m = gMarioStates[0]
	if o.oAction == 6 then


		--[[
		local count = obj_count_objects_with_behavior_id(id_bhv1upRunningAway)
		if count <= 99 then
			spawn_sync_object(id_bhvBouncy1up, E_MODEL_1UP, o.oPosX, o.oPosY, o.oPosZ, nil)
		end
		]]

		if o.oTimer == 0 then
			o.oGravity = -2
			o.oForwardVel = 125
			o.oVelY = 55
		end
		local yaw = obj_angle_to_object(o, m.marioObj)
		obj_set_model_extended(o, E_MODEL_TROPHY_YOSHI)

		o.oFaceAngleYaw = yaw + 32768
		o.oMoveAngleYaw = o.oFaceAngleYaw
		o.oFaceAnglePitch = o.oFaceAnglePitch + 7500
		cur_obj_move_standard(-78)

		if o.oMoveFlags & OBJ_MOVE_LANDED ~= 0 then
			if o.oFloor.type ~= SURFACE_DEATH_PLANE then
				squishblood(o)
				local_play(sSplatter, o.header.gfx.pos, 1)
			end
			spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
			cur_obj_shake_screen(SHAKE_POS_SMALL)
			obj_mark_for_deletion(o)
		end
	end
end

function bhv_secretwarp_init(o)
	o.hitboxHeight = 125
	o.hitboxRadius = 125
    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    o.oFaceAngleYaw = 0
    o.oMoveAnglePitch = o.oFaceAnglePitch
    o.oMoveAngleRoll = o.oMoveAngleRoll
    o.oMoveAngleYaw = o.oFaceAngleYaw
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
end

function bhv_secretwarp_loop(o)
	local m = gMarioStates[0]
	local np = gNetworkPlayers[0]
	local s = gStateExtras[0]
	if obj_check_hitbox_overlap(m.marioObj, o) and (m.controller.buttonPressed & Z_TRIG) ~= 0 and m.action ~= ACT_UNLOCKING_STAR_DOOR  then
		
		if np.currLevelNum == LEVEL_SECRETHUB then
			s.turningGold = true
            m.faceAngle.y = -10477
			set_mario_action(m, ACT_QUICKSAND_DEATH, 0)
			m.marioObj.oTimer = 0
			--gPlayerSyncTable[m.playerIndex].gold = true

		else
			if m.numStars > 80 or gGlobalSyncTable.gameisbeat then
				set_mario_action(m, ACT_UNLOCKING_STAR_DOOR, 0)
				m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
				m.pos.y = m.pos.y + 120
				o.oTimer = 0
			else
				djui_chat_message_create("You need at least 80 stars to enter. (Or beat the game)")
				local_play(sWrong, m.pos, 1)
			end
		end
		
	end
	if o.oTimer <= 200 and m.action == ACT_UNLOCKING_STAR_DOOR then
		--djui_chat_message_create(tostring(o.oTimer))
		m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
		local scalezx = 1
		local scaley = 1
		if o.oTimer == 138 and m.action == ACT_UNLOCKING_STAR_DOOR then
			play_sound(SOUND_GENERAL_VANISH_SFX, gMarioStates[0].pos)
			play_transition(WARP_TRANSITION_FADE_INTO_STAR, 19, 0, 0, 0)
		end
		if o.oTimer >= 126 then
			m.pos.y = m.pos.y + 20
			--obj_scale_xyz(m.marioObj, scalezx - 0.1, scaley + 0.1, scalezx - 0.1)
		end
		if o.oTimer == 157 and m.action == ACT_UNLOCKING_STAR_DOOR then
			warp_to_level(LEVEL_SECRETHUB, 1, 0)
		end
	end
end

function flatstar_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
	o.oFaceAnglePitch = o.oFaceAnglePitch - 16384
end

function flatstar_loop(o)
	m = gMarioStates[0]
	o.oFaceAngleRoll = o.oFaceAngleRoll + 1000
	obj_scale_xyz(o, 1, 1, 0.1)
	cur_obj_become_intangible()
	
end

function bouncy_init(o)
	o.oAction = 9
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
	local randomfvel = math.random(1,30)
	local random = math.random(10,70)
	local randomyaw = math.random(1,65536)
	o.oBounciness = 5
	o.oGravity = -4
	o.oVelY = random
	o.oForwardVel = randomfvel
	o.oFaceAngleYaw = randomyaw
	o.oMoveAngleYaw = o.oFaceAngleYaw
end

function bouncy_loop(o)
	load_object_collision_model()
	obj_set_billboard(o)
	m = gMarioStates[0]
	cur_obj_move_using_fvel_and_gravity()
	cur_obj_move_using_vel()
	if o.oPosY == o.oFloorHeight then
		o.oAction = 1
	end

	if is_within_100_units_of_mario(o.oPosX, o.oPosY, o.oPosZ) ~= 0 then
		m.numLives = m.numLives + 1
		play_sound(SOUND_GENERAL_COLLECT_1UP, vec3f())
		obj_mark_for_deletion(o)
	end

end

function bhv_squishable_platform_loop(o)
    o.oPlatformTimer = o.oPlatformTimer + 768
end

function stopwatch_init(o)
	o.hitboxHeight = 75
	o.hitboxRadius = 75
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
	obj_scale(o, 0.5)
	o.oAction = 0
end

function stopwatch_loop(o)
	local m = gMarioStates[0]
	local s = gStateExtras[m.playerIndex]
	o.oFaceAngleYaw = o.oFaceAngleYaw + 1500
	cur_obj_wait_then_blink(120, 20)
	if o.oTimer >= 180 and o.oAction == 0 then
		spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
		obj_mark_for_deletion(o)
		local_play(sFart, m.pos, 1)
	end

	if obj_check_hitbox_overlap(m.marioObj, o) and o.oAction == 0 then
		play_sound(SOUND_GENERAL_RACE_GUN_SHOT, m.pos)
		play_secondary_music(0, 0, 0, 20)
		stream_play(timeattack)
		spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
		cur_obj_disable_rendering()
		o.oTimer = 0
		o.oAction = 1
		gGlobalSyncTable.timerMax = 1620
		s.timeattack = true
		spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, 5748, 4403, 85, function(t)
			t.oFaceAngleYaw = 0
			t.oFaceAnglePitch = 0
			t.oFaceAngleRoll = 0
			t.oBehParams = 10 << 16 | 1
		end)
	end

	if o.oAction == 1 and o.oTimer == 1620 then
		t = obj_get_nearest_object_with_behavior_id(o, id_bhvTrophy)
		if t then
			local_play(sFart, m.pos, 1)
			spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, t.oPosX, t.oPosY, t.oPosZ, nil)
			s.timeattack = false
			obj_mark_for_deletion(t.parentObj)
			obj_mark_for_deletion(t)
		end
		stream_stop_all()
		stop_secondary_music(5)
		obj_mark_for_deletion(o)
		--set_background_music()
	end
end

function squishblood_init(o)
	local m = gMarioStates[0]
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true	
	local z, normal = vec3f(), cur_obj_update_floor_height_and_get_floor().normal
	o.oFaceAnglePitch = 16384-calculate_pitch(z, normal)
	o.oFaceAngleYaw = calculate_yaw(z, normal)
	o.oFaceAngleRoll = 0
	for i = 0, 60 do
		local random = math.random()		
		spawn_non_sync_object(id_bhvGib, E_MODEL_GIB, o.oPosX, o.oPosY, o.oPosZ, function (gib)
			obj_scale(gib, random/2)
		end)
	end
end

function squishblood_loop(o)
	cur_obj_update_floor()
	local z, normal = vec3f(), cur_obj_update_floor_height_and_get_floor().normal
	o.oFaceAnglePitch = 16384-calculate_pitch(z, normal)
	o.oFaceAngleYaw = calculate_yaw(z, normal)
	o.oFaceAngleRoll = 0
	if o.oPosY ~= o.oFloorHeight + 2 then
		o.oPosY = o.oFloorHeight + 2
	end
	if o.oFloor.type == SURFACE_DEATH_PLANE then
		obj_mark_for_deletion(o)
	end
end

function gib_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
	local randomfvel = math.random(1,20) --Perhaps we can partially add Mario's velocity into this equation?
	local random = math.random(20,50)
	local randomyaw = math.random(1,65536)
	o.oBounciness = 0
	o.oGravity = -4
	o.oVelY = random
	o.oForwardVel = randomfvel
	o.oFaceAngleYaw = randomyaw
	o.oMoveAngleYaw = o.oFaceAngleYaw
	o.oPosY = o.oPosY + 10 --This gets the gibs off the floor, allowing the loop code to run.
	cur_obj_update_floor_height_and_get_floor()

end

function gib_loop(o)
	local random = math.random(1,1500)
	cur_obj_update_floor_height_and_get_floor()
	if o.oPosY > o.oFloorHeight then
		cur_obj_move_using_fvel_and_gravity()
		cur_obj_move_using_vel()
		cur_obj_update_floor_height_and_get_floor()
		o.oFaceAnglePitch = o.oFaceAnglePitch + random
		o.oFaceAngleRoll = o.oFaceAngleRoll + random
		o.oFaceAngleYaw = o.oFaceAngleYaw + random
	else
		o.oPosY = o.oFloorHeight
	end

	if o.oTimer > 1200 then -- 40 second timer before deleting. 
		obj_mark_for_deletion(o)
	end

end

function firering_init(o)
	obj_set_billboard(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
	local random = math.random(1,65536)
	o.oBounciness = 0
	o.oForwardVel = 30
	o.oFaceAngleYaw = o.oFaceAngleYaw + random
	obj_scale(o, 4)
end

function firering_loop(o)
	o.oAnimState = o.oTimer % 4
	cur_obj_move_using_fvel_and_gravity()
	if o.oTimer > 20 then
		obj_mark_for_deletion(o)
	end
end

function wiggler_loop(o)
	if o.oAction == WIGGLER_ACT_WALK then
		o.oForwardVel = 80
		cur_obj_rotate_yaw_toward(0, 0x400)
	end
end

function eyerok_loop(o)
	if o.oAction == EYEROK_BOSS_ACT_WAKE_UP then
		o.oEyerokBossNumHands = o.parentObj.oEyerokBossNumHands + 4
	end
end

function dorrie_dead(o)
	local np = gNetworkPlayers[0]
	local nm = nearest_mario_state_to_object(o)
	if np.currLevelNum ~= LEVEL_HELL then
		if o.oAction == DORRIE_ACT_LOWER_HEAD then
			local_play(sDorrie, m.pos, 1)
			for i = 0, 60 do
				local random = math.random()
				spawn_non_sync_object(id_bhvGib, E_MODEL_GIB, o.oPosX, o.oPosY + 50, o.oPosZ, function (gib)
					obj_scale(gib, random/2)
				end)
			end
			o.oAction = 9
			o.oTimer = 0
		end
		if o.oAction == 9 then --Dorrie dies and sinks to the depths...
			obj_set_model_extended(o, DORRIE_DEAD)
			o.oDorrieVelY = -3
			o.oPosY = o.oPosY - 25
			o.oFaceAnglePitch = o.oFaceAnglePitch - 20
			o.oMoveAnglePitch = o.oFaceAnglePitch
			if o.oTimer == 1 then
				play_secondary_music(0, 0, 0, 120)
			end
			if o.oTimer == 60 then
				stream_play(sad)
			end
			if o.oTimer == 360 then
				stop_secondary_music(0)
			end
		end

	elseif np.currLevelNum == LEVEL_HELL then
		local homeX = 78
		local homeZ = 13706

		local oMinDist = 1650
		local oMaxDist = 2300
		local minDist = 0
		local maxDist = 4300

		o.oHomeX = (homeX - o.oPosX) * (oMaxDist - oMinDist)/(maxDist - minDist) - sins(o.oDorrieAngleToHome) * (minDist - oMinDist) + o.oPosX
		o.oHomeZ = (homeZ - o.oPosZ) * (oMaxDist - oMinDist)/(maxDist - minDist) - coss(o.oDorrieAngleToHome) * (minDist - oMinDist) + o.oPosZ
	end
end

function gorrie_init(o)
	local np = gNetworkPlayers[0]
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oAnimations = gObjectAnimations.dorrie_seg6_anims_0600F638
    o.collisionData = gGlobalObjectCollisionData.dorrie_seg6_collision_0600F644
    obj_init_animation(o, 2)
	obj_scale(o, .7)
	if np.currLevelNum == LEVEL_JRB then
		o.oHomeX = -5269
		o.oHomeY = 1050
		o.oHomeZ = 3750
	else
		o.oHomeX = 5800
		o.oHomeY = 80
		o.oHomeZ = 280
	end
	network_init_object(o, true, nil)
	
end

function gorrie_loop(o)
    local np = gNetworkPlayers[0]
    local nm = nearest_mario_state_to_object(o)
    local dorriemounted = cur_obj_is_any_player_on_platform()
	local goal = obj_get_first_with_behavior_id(id_bhvNetherPortal)
	if goal == nil then
		goal = obj_get_first_with_behavior_id(id_bhvStaticObject)
	end

    cur_obj_init_animation(1)
    cur_obj_move_xz_using_fvel_and_yaw()
    o.oAnimState = o.oTimer % 90
    load_object_collision_model()

    if dorriemounted == 1 then
		if dist_between_objects(o, goal) < 1200 then
			--djui_chat_message_create("Waiting for player to disembark!")
			o.oTimer = 0
            o.oForwardVel = 0
			local warp = obj_get_nearest_object_with_behavior_id(o, id_bhvFadingWarp)
            local warpangle = obj_angle_to_object(o, warp)
			--djui_chat_message_create(tostring(warpangle))
            obj_turn_toward_object(o, warp, 16, 256)
            obj_face_yaw_approach(warpangle, 256)
		else
			--djui_chat_message_create("Traveling to Netherportal!")
			local goal_angle = obj_angle_to_object(o, goal)
			obj_face_yaw_approach(goal_angle, 256)
			obj_turn_toward_object(o, goal, 16, 256)
            o.oForwardVel = 25
			--obj_init_animation(o, 1)
        end
    else
        if mario_is_within_rectangle(o.oPosX - 700, o.oPosX + 700, o.oPosZ - 700, o.oPosZ + 700) ~= 0 and dist_between_objects(o, goal) > 1600 then
			--djui_chat_message_create("Waiting for player to board!")
			local goal_angle = obj_angle_to_object(o, goal)
            obj_turn_toward_object(o, goal, 16, 256)
            obj_face_yaw_approach(goal_angle, 256)
            o.oForwardVel = 0
        else
			--if cur_obj_outside_home_rectangle(o.oHomeX - 600, o.oHomeX + 600, o.oHomeZ - 600, o.oHomeZ + 600) then
			if cur_obj_lateral_dist_from_obj_to_home(o) >= 500 then
				--djui_chat_message_create("Travelling to home!")
				local angletohome = cur_obj_angle_to_home()
        		o.oForwardVel = 15
				obj_face_yaw_approach(angletohome, 256)
        		o.oFaceAngleYaw = angletohome
        		o.oMoveAngleYaw = o.oFaceAngleYaw
			else
				--djui_chat_message_create("home!")
				o.oForwardVel = 0
				local goal_angle = obj_angle_to_object(o, goal)
				local anglesmooth = obj_face_yaw_approach(goal_angle, 256)
				obj_turn_toward_object(o, goal, 16, 256)
				obj_face_yaw_approach(goal_angle, 256)
			end
        end
    end
end

function bhv_klepto_init(o)
	local np = gNetworkPlayers[0]
	if np.currActNum > 1 then
		o.oAction = 10
		o.oBehParams2ndByte = 0
	end
end

function bhv_klepto_loop(o)
	local m = gMarioStates[0]
	local player = nearest_player_to_object(o)
	local np = gNetworkPlayers[0]

	--djui_chat_message_create(tostring(o.oTimer))

	if (o.oAction == KLEPTO_ACT_STRUCK_BY_MARIO) then
		for i = 0, 60 do
			local random = math.random()		
			spawn_non_sync_object(id_bhvGib, E_MODEL_GIB, o.oPosX, o.oPosY, o.oPosZ, function (gib)
				obj_scale(gib, random/2)
			end)
		end
		network_play(sPunch, m.pos, 1, m.playerIndex)
		o.oAction = 10
		o.oTimer = 2
	end

	if o.oAction == 10 then --Klepto is pissed and hunts for nearest player.
		if o.oTimer == 3 then
			obj_spawn_yellow_coins(o, 2)
		end
		o.oFaceAngleRoll = 0
		o.oMoveAngleRoll = 0
		o.oKleptoSpeed = 8
		cur_obj_update_floor()
		if o.oPosY < o.oFloorHeight + 800 then
			o.oPosY = o.oPosY + 10 --rises up high to look for players
		end
		if o.oTimer >= 90 then
			if is_point_within_radius_of_any_player(o.oPosX, o.oPosY, o.oPosZ, 8000) then
				network_play(sAngryKlepto, m.pos, 1, m.playerIndex)
				spawn_mist_particles()
				o.oAction = 8
			end
		end
	end

	if o.oAction == 8 then --CHASING PLAYER
		o.oKleptoSpeed = 35
		obj_turn_toward_object(o, player, 16, 0x2000)
		o.oFaceAngleYaw = obj_angle_to_object(o, m.marioObj)
		o.oFaceAngleRoll = 0
		o.oMoveAngleRoll = 0
		o.oFaceAnglePitch = obj_pitch_to_object(o, player)
		o.oMoveAnglePitch = obj_pitch_to_object(o, player)
		if obj_check_hitbox_overlap(m.marioObj, o) then
			if (m.action & ACT_FLAG_ATTACKING) ~= 0 then
				o.oAction = 9
				play_sound(SOUND_ACTION_BOUNCE_OFF_OBJECT, m.marioObj.header.gfx.cameraToObject)
			else
				o.oTimer = 3
				o.oAction = 10 --Player is ded, Klepto resets to hunt for next player.
				m.squishTimer = 50
			end
		end
	end

	if o.oAction == 9 then
		cur_obj_update_floor()
		if o.oPosY > o.oFloorHeight then
			o.oFaceAnglePitch = o.oFaceAnglePitch - 9000
			o.oFaceAngleRoll = o.oFaceAngleRoll + 4000
			o.oMoveAnglePitch = o.oFaceAnglePitch
			o.oMoveAngleRoll = o.oFaceAngleRoll
			o.oPosY = o.oPosY - 45
			
		else
			obj_unused_die()
			squishblood(o)
			network_play(sSplatter, m.pos, 1, m.playerIndex)
		end
	end

	if o.oAction == KLEPTO_ACT_APPROACH_TARGET_HOLDING then
		--o.oKleptoSpeed = 60
		obj_turn_toward_object(o, player, 16, 0x800)
	end
end

-------Behavior Hooks-------
hook_event(HOOK_MARIO_UPDATE, killer_exclamation_boxes)
hook_behavior(id_bhvDorrie, OBJ_LIST_SURFACE, false, nil, dorrie_dead)
hook_behavior(id_bhvEyerokBoss, OBJ_LIST_GENACTOR, false, nil, eyerok_loop)
hook_behavior(id_bhvWigglerHead, OBJ_LIST_GENACTOR, false, nil, wiggler_loop)
hook_behavior(id_bhvSquishablePlatform, OBJ_LIST_SURFACE, false, nil, bhv_squishable_platform_loop)
hook_behavior(id_bhvYoshi, OBJ_LIST_GENACTOR, false, nil, bhv_custom_yoshi)
hook_behavior(id_bhvActivatedBackAndForthPlatform, OBJ_LIST_SURFACE, false, nil, bhv_custom_ActivatedBackAndForthPlatform)
hook_behavior(id_bhvCirclingAmp, OBJ_LIST_GENACTOR, false, nil, bhv_custom_circlingamp)
hook_behavior(id_bhvSquarishPathMoving, OBJ_LIST_SURFACE, false, nil, bhv_custom_squarishPathMoving)
hook_behavior(id_bhvSlidingPlatform2, OBJ_LIST_SURFACE, false, nil, bhv_custom_slidingplatform2)
hook_behavior(id_bhvSpindrift, OBJ_LIST_GENACTOR, false, nil, bhv_custom_spindrift)
hook_behavior(id_bhvHauntedChair, OBJ_LIST_GENACTOR, false, nil, bhv_custom_chairs)
hook_behavior(id_bhvMadPiano, OBJ_LIST_GENACTOR, false, nil, bhv_custom_piano)
hook_behavior(id_bhvMerryGoRound, OBJ_LIST_SURFACE, false, nil, bhv_custom_merry_go_round)
hook_behavior(id_bhvSmallPenguin, OBJ_LIST_GENACTOR, false, nil, bhv_custom_tuxie)
hook_behavior(id_bhvPlatformOnTrack, OBJ_LIST_SURFACE, false, nil, bhv_custom_moving_plats)
hook_behavior(id_bhvRecoveryHeart, OBJ_LIST_GENACTOR, false, nil, bhv_custom_heart)
hook_behavior(id_bhvRrRotatingBridgePlatform, OBJ_LIST_SURFACE, false, nil, bhv_custom_rotating_platform)
hook_behavior(id_bhvSwingPlatform, OBJ_LIST_SURFACE, false, nil, bhv_custom_swing)
--hook_behavior(id_bhv1Up, OBJ_LIST_GENACTOR, false, nil, bhv_custom_1up)
--hook_behavior(id_bhvHidden1upInPole, OBJ_LIST_GENACTOR, false, nil, bhv_custom_1up)
hook_behavior(id_bhvFlyGuy, OBJ_LIST_GENACTOR, false, nil, bhv_custom_flyguy)
hook_behavior(id_bhvBigBoulder, OBJ_LIST_GENACTOR, false, nil, bhv_custom_boulder)
hook_behavior(id_bhvBouncingFireball, OBJ_LIST_GENACTOR, false, nil, bhv_custom_bouncing_fireball)
hook_behavior(id_bhvChainChomp, OBJ_LIST_GENACTOR, false, nil, bhv_custom_chain_chomp)
hook_behavior(id_bhvBowserBomb, OBJ_LIST_GENACTOR, false, nil, bhv_custom_bowserbomb)
hook_behavior(id_bhvCheckerboardPlatformSub, OBJ_LIST_SURFACE, false, nil, bhv_checkerboard_platform)
hook_behavior(id_bhvFerrisWheelAxle, OBJ_LIST_SURFACE, false, nil, bhv_ferris_wheel_axle)
hook_behavior(id_bhvFerrisWheelPlatform, OBJ_LIST_SURFACE, false, nil, bhv_ferris_wheel)
hook_behavior(id_bhvHorizontalGrindel, OBJ_LIST_SURFACE, false, nil, bhv_custom_grindel)
hook_behavior(id_bhvSpindel, OBJ_LIST_SURFACE, false, nil, bhv_custom_spindel)
hook_behavior(id_bhvLllRotatingHexFlame, OBJ_LIST_SURFACE, false, nil, bhv_custom_firebars)
hook_behavior(id_bhvLllRotatingHexagonalPlatform, OBJ_LIST_SURFACE, false, nil, bhv_custom_hex_platform)
hook_behavior(id_bhvLllVolcanoFallingTrap, OBJ_LIST_SURFACE, false, nil, bhv_custom_crushtrap)
hook_behavior(id_bhvSmallBully, OBJ_LIST_GENACTOR, false, nil, bhv_custom_bully)
hook_behavior(id_bhvToxBox, OBJ_LIST_SURFACE, false, nil, bhv_custom_toxbox)
hook_behavior(id_bhvWfSlidingPlatform, OBJ_LIST_SURFACE, false, nil, bhv_custom_whomp_slidingpltf)
hook_behavior(id_bhvSeesawPlatform, OBJ_LIST_SURFACE, false, nil, bhv_custom_seesaw)
hook_behavior(id_bhvMessagePanel, OBJ_LIST_SURFACE, false, nil, bhv_custom_sign)
hook_behavior(id_bhvTree, OBJ_LIST_POLELIKE, false, nil, bhv_custom_tree)
hook_behavior(id_bhvWhompKingBoss, OBJ_LIST_SURFACE, false, nil, bhv_custom_kingwhomp)
hook_behavior(id_bhvKingBobomb, OBJ_LIST_GENACTOR, false, nil, bhv_custom_kingbobomb)
hook_behavior(id_bhvSmallWhomp, OBJ_LIST_SURFACE, false, nil, bhv_custom_whomp)
hook_behavior(id_bhvThwomp, OBJ_LIST_SURFACE, false, nil, bhv_custom_thwomp)
hook_behavior(id_bhvThwomp2, OBJ_LIST_SURFACE, false, nil, bhv_custom_thwomp)
hook_behavior(id_bhvPitBowlingBall, OBJ_LIST_GENACTOR, false, nil, bhv_custom_pitbowlball)
hook_behavior(id_bhvBowlingBall, OBJ_LIST_GENACTOR, false, nil, bhv_custom_bowlball)
hook_behavior(id_bhvBobBowlingBallSpawner, OBJ_LIST_GENACTOR, false, nil, bhv_custom_bowlballspawner)
hook_behavior(id_bhvExplosion, OBJ_LIST_DESTRUCTIVE, false, bhv_custom_explosion, nil)
hook_behavior(id_bhvBobomb, OBJ_LIST_DESTRUCTIVE, false, nil, bobomb_loop)
hook_behavior(id_bhvGoomba, OBJ_LIST_PUSHABLE, false, nil, bhv_custom_goomba_loop)
hook_behavior(id_bhvKlepto, OBJ_LIST_GENACTOR, false, bhv_klepto_init, bhv_klepto_loop)
hook_behavior(id_bhvBowserKey, OBJ_LIST_LEVEL, false, bhv_bowser_key_spawn_ukiki, bhv_bowser_key_ukiki_loop)
id_bhvRedFloodFlag = hook_behavior(nil, OBJ_LIST_POLELIKE, true, bhv_red_flood_flag_init, bhv_red_flood_flag_loop)
id_bhvSquishblood = hook_behavior(nil, OBJ_LIST_GENACTOR, true, squishblood_init, squishblood_loop, "bhvSquishblood")
id_bhvStopwatch = hook_behavior(nil, OBJ_LIST_GENACTOR, true, stopwatch_init, stopwatch_loop, "bhvStopwatch")
id_bhvSecretWarp = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bhv_secretwarp_init, bhv_secretwarp_loop, "bhvSecretWarp")
id_bhvGoalpost = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_goalpost_init, bhv_goalpost_loop, "bhvGoalpost")
id_bhvNetherPortal = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_netherportal_init, bhv_netherportal_loop, "bhvNetherPortal")
id_bhvBackroomSmiler = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_backroom_smiler_init, bhv_backroom_smiler_loop, "bhvBackroomSmiler")
id_bhvBackroom = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_backroom_init, bhv_backroom_loop, "bhvBackroom")
id_bhvHellPlatform1 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_hellplatform_init, bhv_hellplatform_loop, "bhvHellPlatform1")
id_bhvLava = hook_behavior(nil, OBJ_LIST_SURFACE, true, lava_init, lava_loop, "bhvLava")
id_bhvQuickWarp = hook_behavior(nil, OBJ_LIST_SURFACE, true, warp_init, warp_loop, "bhvWarp")
id_bhvFlatStar = hook_behavior(nil, OBJ_LIST_GENACTOR, true, flatstar_init, flatstar_loop, "bhvFlatStar")
id_bhvBouncy1up = hook_behavior(nil, OBJ_LIST_GENACTOR, true, bouncy_init, bouncy_loop, "bhvBouncy1up")
id_bhvGib = hook_behavior(nil, OBJ_LIST_UNIMPORTANT, true, gib_init, gib_loop, "bhvGib")
id_bhvFireRing = hook_behavior(nil, OBJ_LIST_GENACTOR, true, firering_init, firering_loop, "bhvFireRing")
id_bhvGorrie = hook_behavior(nil, OBJ_LIST_SURFACE, true, gorrie_init, gorrie_loop)