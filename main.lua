-- name: GORE / Hard-Mode! [WIP]
-- description: Gore and extreme challenges! Not for the faint of heart. Another awesome mod from the GORE Team!
-- incompatible: gore

-------TESTING NOTES AND KNOWN BUGS-------------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GBEHAVIORVALUES -- Fast switches to manipulate the game.

--gLevelValues.entryLevel = LEVEL_CASTLE

--Turns off bubble death.
gServerSettings.bubbleDeath = false

--(BoB, THI, TTM) bowling balls faster
gBehaviorValues.BowlingBallTtmSpeed = 40
gBehaviorValues.BowlingBallThiSmallSpeed = 45
gBehaviorValues.BowlingBallThiSmallSpeed = 45


--Koopa the quick is STUPID fast. Player has to finish race in 20.9 seconds.
gBehaviorValues.KoopaBobAgility = 20
gBehaviorValues.KoopaThiAgility = 14

-- King bobomb health
gBehaviorValues.KingBobombHealth = 6

--Slide and Metal cap timers
gLevelValues.pssSlideStarTime = 420 -- 14 Seconds
gLevelValues.metalCapDuration = 90 -- 3 seconds, LOL.

local savedCollisionBugStatus

local
bhv_ttc_2d_rotator_update, bhv_ttc_cog_update, bhv_ttc_elevator_update, bhv_ttc_moving_bar_update, bhv_ttc_pendulum_update,
bhv_ttc_pit_block_update, bhv_ttc_rotating_solid_update, bhv_ttc_spinner_update, bhv_ttc_treadmill_update, get_id_from_behavior,
get_object_list_from_behavior, get_behavior_from_id, get_behavior_name_from_id, mario_blow_off_cap, find_floor_height,
cur_obj_update_floor_height_and_get_floor, calculate_pitch, play_secondary_music, save_file_set_using_backup_slot,
audio_stream_stop, cur_obj_enable_rendering_and_become_tangible,
spawn_mist_particles, obj_get_first_with_behavior_id, stop_secondary_music, obj_get_nearest_object_with_behavior_id,
set_lighting_color, fadeout_music, set_mario_anim_with_accel, obj_resolve_collisions_and_turn, sins, coss, obj_scale, mario_is_within_rectangle,
fadeout_level_music, play_character_sound, cutscene_object_with_dialog, cur_obj_shake_screen, obj_copy_pos,
audio_sample_stop, obj_has_behavior_id, smlua_anim_util_set_animation, set_camera_shake_from_point,
mario_drop_held_object, obj_angle_to_object, hud_show, djui_hud_render_texture, djui_hud_print_text, hud_set_value, hud_get_value,
djui_hud_measure_text, djui_hud_get_screen_height, djui_hud_get_screen_width, djui_hud_set_resolution, djui_hud_set_color,
clamp, djui_hud_render_texture_tile, nearest_interacting_mario_state_to_object, is_within_100_units_of_mario,
play_transition, network_is_server, obj_check_hitbox_overlap
=
bhv_ttc_2d_rotator_update, bhv_ttc_cog_update, bhv_ttc_elevator_update, bhv_ttc_moving_bar_update, bhv_ttc_pendulum_update,
bhv_ttc_pit_block_update, bhv_ttc_rotating_solid_update, bhv_ttc_spinner_update, bhv_ttc_treadmill_update, get_id_from_behavior,
get_object_list_from_behavior, get_behavior_from_id, get_behavior_name_from_id, mario_blow_off_cap, find_floor_height,
cur_obj_update_floor_height_and_get_floor, calculate_pitch, play_secondary_music, save_file_set_using_backup_slot,
audio_stream_stop, cur_obj_enable_rendering_and_become_tangible,
spawn_mist_particles, obj_get_first_with_behavior_id, stop_secondary_music, obj_get_nearest_object_with_behavior_id,
set_lighting_color, fadeout_music, set_mario_anim_with_accel, obj_resolve_collisions_and_turn, sins, coss, obj_scale, mario_is_within_rectangle,
fadeout_level_music, play_character_sound, cutscene_object_with_dialog, cur_obj_shake_screen, obj_copy_pos,
audio_sample_stop, obj_has_behavior_id, smlua_anim_util_set_animation, set_camera_shake_from_point,
mario_drop_held_object, obj_angle_to_object, hud_show, djui_hud_render_texture, djui_hud_print_text, hud_set_value, hud_get_value,
djui_hud_measure_text, djui_hud_get_screen_height, djui_hud_get_screen_width, djui_hud_set_resolution, djui_hud_set_color,
clamp, djui_hud_render_texture_tile, nearest_interacting_mario_state_to_object, is_within_100_units_of_mario,
play_transition, network_is_server, obj_check_hitbox_overlap

-------------------helpers------------------------------

--Scrolling textures
add_scroll_target(1, "hell_dl_cave_and_lava_mesh_layer_1_vtx_0", 0, 79)

-- Unlock JRB cannon
save_file_set_star_flags(get_current_save_file_num() - 1, COURSE_JRB, 0x80)

--TTC Speed Increase
local realbhv = {
    [id_bhvTTC2DRotator]     = bhv_ttc_2d_rotator_update,
    [id_bhvTTCCog]           = bhv_ttc_cog_update,
    [id_bhvTTCElevator]      = bhv_ttc_elevator_update,
    [id_bhvTTCMovingBar]     = bhv_ttc_moving_bar_update,
    [id_bhvTTCPendulum]      = bhv_ttc_pendulum_update,
    [id_bhvTTCPitBlock]      = bhv_ttc_pit_block_update,
    [id_bhvTTCRotatingSolid] = bhv_ttc_rotating_solid_update,
    [id_bhvTTCSpinner]       = bhv_ttc_spinner_update,
    [id_bhvTTCTreadmill]     = bhv_ttc_treadmill_update,
}

local fastbhv = {}

local function speed_objs(o)
    if true then
        fastbhv[get_id_from_behavior(o.behavior)]()
    end
end

for bhv, func in pairs(realbhv) do
    fastbhv[hook_behavior(bhv, get_object_list_from_behavior(get_behavior_from_id(bhv)), false, nil, speed_objs, get_behavior_name_from_id(bhv))] = func
end

function is_lowest_active_player()
	return get_network_player_smallest_global().localIndex == 0
end

function ia(m)
	return m.playerIndex == 0
end
function lerp(a, b, t) return a * (1 - t) + b * t end

function vec3f() return {x=0,y=0,z=0} end

function limit_angle(a) return (a + 0x8000) % 0x10000 - 0x8000 end

function testing(m)
	local s = gStateExtras[m.playerIndex]

	if (m.controller.buttonPressed & D_JPAD) ~= 0 then

		--s.isgold = true
		--warp_to_level(LEVEL_SECRETHUB, 1, 0)

	end
	if (m.controller.buttonPressed & L_JPAD) ~= 0 then
		gGlobalSyncTable.toaddeathcounter = 49
		gGlobalSyncTable.gameisbeat = true
	end
	if (m.controller.buttonPressed & R_JPAD) ~= 0 then
		m.numLives = 1
		squishblood(m.marioObj)
		set_mario_action(m, ACT_NECKSNAP, 0)
	end
	if (m.controller.buttonPressed & U_JPAD) ~= 0 then
		--local yaw = 0
		--for i = 0, 16 do
		--	yaw = yaw + 4096	
		--	spawn_sync_if_main(id_bhvFireRing, E_MODEL_RED_FLAME, m.pos.x, m.pos.y + 26, m.pos.z, function (o)
				--o.oFaceAngleYaw = yaw
				o.oMoveAngleYaw = o.oFaceAngleYaw
		--	end, 0)
		--end
	end
end

function spawn_sync_if_main(behaviorId, modelId, x, y, z, objSetupFunction, i)
	print("index:", i)
	print("attempt by "..get_network_player_smallest_global().name)
	print(get_network_player_smallest_global().localIndex + i)
	if get_network_player_smallest_global().localIndex + i == 0 then print("passed!") return spawn_sync_object(behaviorId, modelId, x, y, z, objSetupFunction) end
end

local function modsupport()
	for key,value in pairs(gActiveMods) do
		if (value.name == "Flood") then
			floodenabled = true
		end
	end
end

------Globals--------
gGlobalSyncTable.deathcounter = 0
gGlobalSyncTable.toaddeathcounter = 0
gGlobalSyncTable.hellenabled = true

-----------Locals-------------
local TEX_MARIO_LESS_HIGH = get_texture_info('mariolesshigh')
local TEX_BLOOD_OVERLAY = get_texture_info('bloodoverlay')
local TEX_TRIPPY_OVERLAY = get_texture_info('trippy')
local TEX_PORTAL = get_texture_info("portal")
local TEX_GAMEOVER = get_texture_info("gameover")
local TEX_DIRT = get_texture_info("grass_09004800")

-----------------------------------------------------------------------------------------------------------------------------
-------ACT_FUNCTIONS------------

function squishblood(o) -- Creates instant pool of impact-blood under mario.
	spawn_sync_if_main(id_bhvSquishblood, E_MODEL_BLOOD_SPLATTER, o.oPosX, find_floor_height(o.oPosX, o.oPosY, o.oPosZ) + 2, o.oPosZ, nil, 0)
	bloodmist(o)
end

function bloodmist(o) -- Creates instant pool of impact-blood under mario.
	spawn_non_sync_object(id_bhvBloodMist, E_MODEL_BLOOD_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
end

function splattertimer(m) --This timer is needed to prevent mario from immediately splatting again right after respawning. Adds some fluff to his death too.
	local s = gStateExtras[m.playerIndex]
	if s.enablesplattimer == 1 then
		s.splattimer = s.splattimer + 1
	end
	if s.splattimer == 2 then
		--m.health = 120
		m.health = 0xff
		set_mario_action(m, ACT_THROWN_FORWARD, 0) --Throws mario forward more to "sell" the fall damage big impact.
		if s.disappear == 1 then --No fall damage, so Mario got squished. No corpse. It's funnier this way. 
			set_mario_action(m, ACT_GONE, 78)
			-- if not s.isdead and ia(m) then
			-- 	gGlobalSyncTable.deathcounter = gGlobalSyncTable.deathcounter + 1
			-- end
			-- s.isdead = true
		end
		if s.disappear == 1 then --Not a fall damage death, so cap won't fly as far. Works better since this is mostly triggered by enemies or objects smashing mario.
			mario_blow_off_cap(m, 15)
		else --Fall damage death means bigger impact, so hat is blown off more violently than above.
			mario_blow_off_cap(m, 45)
		end
		s.splattimer = s.splattimer + 1
	end


	if (s.splattimer) == 14 then
		spawn_sync_if_main(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER2, m.pos.x, find_floor_height(m.pos.x, m.pos.y, m.pos.z) + 2, m.pos.z,
		function (obj)
			local z, normal = vec3f(), cur_obj_update_floor_height_and_get_floor().normal
			obj.oFaceAnglePitch = 16384-calculate_pitch(z, normal)
			--obj.oFaceAngleYaw = calculate_yaw(z, normal)
			obj.oFaceAngleRoll = 0
		end, 0)
	end

	if (s.splattimer) == 20 then
		if (s.disappear) == 0 then
			set_mario_action(m, ACT_DEATH_ON_STOMACH, 0)
		else
			s.enablesplattimer = 0
			s.splatter = 1
			s.splattimer = 0
			s.disappear = 0
		end
	end
	if (s.splattimer) == 150 then
		s.enablesplattimer = 0
		s.splatter = 1
		s.splattimer = 0
		s.disappear = 0
	end
end

function convert_s16(num)
	local min = -32768
	local max = 32767
	while (num < min) do
		num = max + (num - min)
	end
	while (num > max) do
		num = min + (num - max)
	end
	return num
end

function mario_update(m) -- ALL Mario_Update hooked commands.,
	if is_player_active(m) == 0 then return end
	local np = gNetworkPlayers[0]
	local s = gStateExtras[m.playerIndex]

	--djui_chat_message_create(tostring(np.currAreaIndex))

	if s.iwbtg and m.action == ACT_DEATH_ON_STOMACH then
		m.action = ACT_NOTHING
	end

	if s.iwbtg and m.floor.type == SURFACE_DEATH_PLANE and m.pos.y < m.floorHeight + 2048 then
		m.health = 0xff
		m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags & ~GRAPH_RENDER_ACTIVE
		set_mario_action(m, ACT_GONE, 0)
		--m.pos.y = m.floorHeight + 70
	end

	if s.iwbtg then
		play_secondary_music(0,0,0,0)
		if m.numLives > 1 then
			m.numLives = 1
		end
		if m.numStars == 10 then
			--djui_chat_message_create("trophy awarded!")
		end
		save_file_set_using_backup_slot(true)
	end

	if s.death then
		audio_stream_stop(iwbtg)
		--set_mario_action(m, ACT_NOTHING, 0)
	end

	if s.iwbtg and not s.death and m.health ~= 0xff then
		if currentlyPlaying ~= iwbtg then
			stream_stop_all()
			stream_play(iwbtg)
		end
		--hud_hide()
	else
		--stream_stop_all()
	end

	if s.iwbtg and m.health == 0xff and not s.death then
		stream_stop_all()
		delete_save(m)
		local_play(sIwbtgDeath, gLakituState.pos, 1)
		--set_mario_action(m, ACT_NOTHING, 0)
		--s.iwbtg = false
		s.death = true
	end


----------------------------------------------------------------------------------------------------------------------------------
	--Turning Gold
	if s.turningGold then
		local m0 = gMarioStates[0]
		if m0.marioObj.oTimer == 30 then
			set_mario_action(m0, ACT_IDLE, 0)
			cur_obj_disable_rendering_and_become_intangible(m0.marioObj)
		end

		if m0.marioObj.oTimer == 58 then
			set_mario_action(m0, ACT_EMERGE_FROM_PIPE, 0)

		end

		if m0.marioObj.oTimer == 70 then
			spawn_mist_particles()
			network_play(sGround, m0.pos, 1, m0.playerIndex)
			cur_obj_enable_rendering_and_become_tangible(m0.marioObj)
			soft_reset_camera(m0.area.camera)
			gPlayerSyncTable[m0.playerIndex].gold = true
			s.turningGold = false
			--djui_chat_message_create("gold")
		end
	end
----------------------------------------------------------------------------------------------------------------------------------
	--if in Snowman Land...
	if np.currLevelNum == LEVEL_SL and np.currAreaIndex <= 1 then
		set_override_envfx(ENVFX_SNOW_BLIZZARD)
		--play_sound(SOUND_ENV_WIND1, m.pos)
		--play_sound(SOUND_ENV_WIND2, m.pos)
		cur_obj_play_sound_1(SOUND_ENV_WIND1)
	end

----------------------------------------------------------------------------------------------------------------------------------
	--IWBTG Trophy
	if gGlobalSyncTable.gameisbeat and not trophy_unlocked(20) and s.iwbtg and m.numStars == 10 then
		unlock_trophy(20)
		play_sound(SOUND_MENU_COLLECT_SECRET, m.pos)
		djui_chat_message_create("IWBTG Trophy earned!!")
	end

----------------------------------------------------------------------------------------------------------------------------------
	--PSS TROPHY

	if mod_storage_load("file1coin") == "1" then
		--DO NOTHING
		--djui_chat_message_create("already collected")
	else

        local psstrophy = obj_get_first_with_behavior_id(id_bhvTrophy)

        if  np.currLevelNum == LEVEL_PSS and gGlobalSyncTable.gameisbeat and not psstrophy then
            if m.pos.y <= -4587 and m.numCoins < 81 then
                m.pos.x = -6401
                m.pos.y = -4162
                m.pos.z = 148
                m.faceAngle.y = 32768
                m.intendedYaw = 32768
                set_mario_action(m, ACT_BUTT_SLIDE, 0)
                m.forwardVel = 120
                play_secondary_music(0, 0, 0, 20)
                stream_play(edils)
            elseif m.numCoins == 81 then
                play_sound(SOUND_MENU_COLLECT_SECRET, m.pos)
                stream_stop_all()
                stop_secondary_music(0)
                djui_chat_message_create("Trophy spawned!")
                spawn_sync_object(id_bhvTrophy, E_MODEL_NONE, -6386, -4484, 5416, function(t)
                    t.oFaceAngleYaw = 32768
                    t.oBehParams = 11 << 16 | 1
                end)
            end
        end
	end


----------------------------------------------------------------------------------------------------------------------------------
	--Lava bubbling at HMC
	if np.currLevelNum == LEVEL_HMC and m.pos.y < -3900 then
		set_override_envfx(ENVFX_LAVA_BUBBLES)
	elseif np.currLevelNum == LEVEL_HMC and m.pos.y >= -3900 then
		set_override_envfx(ENVFX_MODE_NONE)
	end


----------------------------------------------------------------------------------------------------------------------------------
	if gGlobalSyncTable.gameisbeat and np.currLevelNum == LEVEL_TTM and np.currAreaIndex == 3  and not trophy_unlocked(13) then --GRANT TROPHY #13
		local trophy = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvTrophy) 
		if trophy then
			--djui_chat_message_create("trophy exists")
		else
			--djui_chat_message_create("spawning trophy")
			spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, 1356, -1055, -4816, function(t)
				t.oBehParams = 13 << 16 | 1
			end)
		end
	end

----------------------------------------------------------------------------------------------------------------------------------

-- (PSS/TTM Only) Faster sliding.
    
    local is_pss = np.currLevelNum == LEVEL_PSS
    local is_ttm = np.currLevelNum == LEVEL_TTM and np.currAreaIndex >= 2
    local is_butt_or_dive_slide = m.action == ACT_BUTT_SLIDE or m.action == ACT_DIVE_SLIDE
    
    if is_pss and is_butt_or_dive_slide then
        adjust_slide_velocity(m, 50)
    elseif is_ttm and is_butt_or_dive_slide then
        adjust_slide_velocity(m, 40)
    end
    
    if (is_pss or is_ttm) and m.action == ACT_BUTT_SLIDE then
        adjust_turn_speed(m)
    end


----------------------------------------------------------------------------------------------------------------------------------
	--If dead, gold go bye bye
	if m.health <= 120 and s.isgold then
		s.isgold = false
		gPlayerSyncTable[m.playerIndex].gold = false
	end
	
----------------------------------------------------------------------------------------------------------------------------------
	--Koopa the QUICC
	if np.currLevelNum == LEVEL_BOB then
		gBehaviorValues.KoopaCatchupAgility = 60
	else
		gBehaviorValues.KoopaCatchupAgility = 8
	end

----------------------------------------------------------------------------------------------------------------------------------
	--Disables signs on the wall, which gives us extra dialog_ID's to use for custom readouts while having regular (enemy) signs readable.
	local wallsigns = obj_get_nearest_object_with_behavior_id(o, id_bhvSignOnWall)
	if wallsigns ~= nil then
		obj_mark_for_deletion(wallsigns)
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Spooky BBH
	if np.currLevelNum == LEVEL_BBH then
		set_lighting_color(0,50)
		set_lighting_color(1,50)
		set_lighting_color(2,65)
		set_lighting_dir(1,128)
	end
----------------------------------------------------------------------------------------------------------------------------------
	if np.currLevelNum == LEVEL_BITFS then
		local minvertedpyramid = obj_get_first_with_behavior_id(id_bhvBitfsTiltingInvertedPyramid)
		while minvertedpyramid do
			obj_mark_for_deletion(minvertedpyramid)
			minvertedpyramid = obj_get_next_with_same_behavior_id(minvertedpyramid)
		end
	end

----------------------------------------------------------------------------------------------------------------------------------
	--Wet/Dry world is now just dry world... LOL...
	if np.currLevelNum == LEVEL_WDW then
        for i = 0, 3 do
		    set_environment_region(i, -10000)
        end
		local watercontrol = obj_get_first_with_behavior_id(id_bhvWaterLevelDiamond)
		while watercontrol do
			obj_mark_for_deletion(watercontrol)
			watercontrol = obj_get_next_with_same_behavior_id(watercontrol)
		end
	end

----------------------------------------------------------------------------------------------------------------------------------
	--Backroom Teleport

	--djui_chat_message_create(tostring(m.forwardVel))
	if np.currLevelNum == LEVEL_CASTLE and m.forwardVel < -120 and ia(m) then
		m.forwardVel = 0
		if not obj_get_first_with_behavior_id(id_bhvBackroom) then
			spawn_non_sync_object(id_bhvBackroom, E_MODEL_BACKROOM, 0, 10000, 0, function(o)
				o.oFaceAngleYaw = 0
				fadeout_music(0)
				stream_play(backroomMusic)
				set_lighting_color(0,255)
				set_lighting_color(1,255)
				set_lighting_color(2,30)
				set_lighting_dir(1,128)
			end)
		end
		m.pos.x = 0
		m.pos.y = 10600
		m.pos.z = 0
		set_mario_action(m, ACT_HARD_BACKWARD_GROUND_KB, 0)
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Stupid shell riding

	if m.action == ACT_RIDING_SHELL_GROUND or m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_RIDING_SHELL_FALL then
		set_mario_anim_with_accel(m, MARIO_ANIM_FIRST_PERSON, 0) --Funny standing
		--set_mario_anim_with_accel(m, MARIO_ANIM_HOLDING_BOWSER, 0) --Funny thicc dumper
		--set_mario_anim_with_accel(m, MARIO_ANIM_TWIRL, 0) --Funny tpose
	end
----------------------------------------------------------------------------------------------------------------------------------
	-- FLY FASTER!!
	if m.action == ACT_FLYING or m.action == ACT_SHOT_FROM_CANNON or m.action == ACT_THROWN_BACKWARD or m.action == ACT_THROWN_FORWARD then -- Makes flying gradually get FASTER!
		m.forwardVel = m.forwardVel + 0.3
		s.flyingVel = m.forwardVel --This is to store Mario's last flying speed to check for splat-ability. 
	end

----------------------------------------------------------------------------------------------------------------------------------
	-- BONKING DEATHS!!
	if m.action == ACT_BACKWARD_AIR_KB or m.action == ACT_FORWARD_AIR_KB and s.flyingVel > 60 then -- Enables Mario to wall-splat when air-bonking objects.
		if m.prevAction == ACT_FLYING or m.prevAction == ACT_SHOT_FROM_CANNON then
			mario_blow_off_cap(m, 45)
			m.forwardVel = m.forwardVel - 30
			m.action = ACT_SOFT_BONK --Needed to stop the first 'if' from running twice.
			set_mario_action(m, ACT_GONE, 78)
			m.health = 0xff
			set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
			m.particleFlags = PARTICLE_MIST_CIRCLE
			local_play(sSplatter, m.pos, 1)
			spawn_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, m.pos.x, m.pos.y, m.pos.z, function(o)
				local z, normal = vec3f(), m.wall.normal
				local x, xnormal = vec3f(), m.wall.normal
				o.oFaceAnglePitch = 16384-calculate_pitch(x, xnormal)
				o.oFaceAngleYaw = calculate_yaw(z, normal)
				o.oFaceAngleRoll = obj_resolve_collisions_and_turn(o.oFaceAngleYaw, 0)
				o.oPosX = o.oPosX - (48 * sins(o.oFaceAngleYaw))
				o.oPosZ = o.oPosZ - (48 * coss(o.oFaceAngleYaw))
			end)
			for i = 0, 50 do
				if m.playerIndex ~= 0 then return end
				local random = math.random()
				spawn_sync_object(id_bhvGib, E_MODEL_GIB, m.pos.x, m.pos.y, m.pos.z, function (gib)
					obj_scale(gib, random)
				end)
			end
	    end
	end

	-- BONK DEATH DETECTION FOR HEAVEHO THROWS SPECIFICALLY (Really just for WDW)
	if (m.action == ACT_THROWN_BACKWARD) or (m.action == ACT_THROWN_FORWARD) and (s.flyingVel > 60) and np.currLevelNum == LEVEL_WDW then 
		local heaveho = obj_get_nearest_object_with_behavior_id(o, id_bhvHeaveHoThrowMario)
		if heaveho ~= nil and mario_is_within_rectangle(heaveho.oPosX - 100, heaveho.oPosX + 100, heaveho.oPosZ - 100, heaveho.oPosZ + 100) == 0 and m.wall ~= nil then
			mario_blow_off_cap(m, 45)
			m.forwardVel = m.forwardVel - 30
			m.action = ACT_SOFT_BONK --Needed to stop the first 'if' from running twice.
			set_mario_action(m, ACT_GONE, 78)
			m.health = 0xff
			set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
			m.particleFlags = PARTICLE_MIST_CIRCLE
			local_play(sSplatter, m.pos, 1)
			spawn_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, m.pos.x, m.pos.y, m.pos.z, function(o)
				local z, normal = vec3f(), m.wall.normal
				local x, xnormal = vec3f(), m.wall.normal
				o.oFaceAnglePitch = 16384-calculate_pitch(x, xnormal)
				o.oFaceAngleYaw = calculate_yaw(z, normal)
				o.oFaceAngleRoll = obj_resolve_collisions_and_turn(o.oFaceAngleYaw, 0)
				o.oPosX = o.oPosX - (48 * sins(o.oFaceAngleYaw))
				o.oPosZ = o.oPosZ - (48 * coss(o.oFaceAngleYaw))
			end)
		end
	end

----------------------------------------------------------------------------------------------------------------------------------
	--SPLAT CHECK. CHECKS TO SEE IF MARIO IS HIGH ENOUGH TO SPLAT.
	--IF S.splatter is equal to 1, that means splattering is enabled and Mario CAN be splattered. (Doesn't mean he IS splattered) 
	--This gets set to '0' when Mario IS splattered. After the splatter timer is up, it sets s.splatter back to 1 to re-enable splattering. 
	if (s.splatter) == 1 and m.health > 0xff and not (m.action == ACT_BBH_ENTER_SPIN or m.action == ACT_BBH_ENTER_JUMP) then
		if m.peakHeight >= 750 and m.vel.y <= -55 then  --Checks if Mario takes fall damage
			s.jumpland = 1 --If fall damage, then 1
		else
			s.jumpland = 0 --No fall damage
		end

		if s.jumpland == 1 and m.squishTimer >= 1 then -- Checks if Mario is squished from fall damage. If so, his mangled corpse will stay on screen.
			local_play(sSplatter, m.pos, 1)
			s.splatterdeath = 1
			s.splatter = 0
		end
		if s.jumpland == 0 and m.squishTimer >= 1 then --Checks if Mario was squished from NON-FALL damage. Objects/enemies that squish Mario will smoosh his corpse to invisible. 
			local_play(sSplatter, m.pos, 1)
			s.splatterdeath = 1
			s.splatter = 0
			s.disappear = 1 -- No corpse mode.  
		end
	end
	if (s.splatterdeath) == 1 then
		m.particleFlags = PARTICLE_MIST_CIRCLE
		squishblood(m.marioObj)
		s.splatterdeath = 0
		s.enablesplattimer = 1
		s.bigthrowenabled = 0
	end
	----------------------------------------------------------------------------------------------------------------------------------
	--(Hazy Maze Cave) Mario get high when walking in gas. 
	s.outsidegastimer = s.outsidegastimer + 1 -- This is constantly counting up. As long as Mario is in gas, this number will keep getting set back to zero. If Mario isnt in gas, the timer will count up to 60 and trigger some "not in gas" commands. 


    if ia(m) and (m.input & INPUT_IN_POISON_GAS ~= 0) and m.flags & MARIO_METAL_CAP == 0 and not s.isdead then --This should be used as a check against if Mario is inside of gas. If so, IsHigh will be set to 1.
		s.ishigh = 1
		s.outsidegastimer = 0
		m.health = m.health + 4
	end

	if (s.ishigh == 1) then
		set_environment_region(2, -400) --RAISES THE GAS HIGHER
	end

	if ((s.outsidegastimer == 30) or s.isdead) and s.ishigh == 1 then --If Mario is outside the gas for 1 second, the high wears off and resets all timers.
		s.ishigh = 0
		s.highdeathtimer = 0
		if ia(m) then
			local butterfly = obj_get_first_with_behavior_id(id_bhvButterfly)
			while butterfly ~= nil do
				obj_mark_for_deletion(butterfly)
				butterfly = obj_get_next_with_same_behavior_id(butterfly)
			end
			stream_stop_all()
			set_background_music(0, get_current_background_music(), 0)
		end
	end
	if ia(m) then
		if highalpha ~= 0 then
			set_override_fov(lerp(45, lerp(140, 30, .5+math.cos(m.marioObj.oTimer*.02)/2), highalpha/255))
		else
			set_override_fov(0)
		end
	end
	if (s.ishigh) == 1 then --Mario is in gas, thefore the death timer starts counting and M velocity is lowered.
		s.highdeathtimer = s.highdeathtimer + 1
		if ia(m) then
			if (s.highdeathtimer < 1100) then
				m.forwardVel = 10
				set_handheld_shake(HAND_CAM_SHAKE_UNUSED)
			elseif (s.highdeathtimer > 1100) then
				set_handheld_shake(HAND_CAM_SHAKE_HIGH)
			end
		end
	end
	if (s.highdeathtimer) == 1 and ia(m) then --initiates the 'high' music
		fadeout_level_music(900)
		stream_play(highmusic)
		spawn_non_sync_object(id_bhvButterfly, E_MODEL_BUTTERFLY, m.pos.x, m.pos.y, m.pos.z, nil)
	end

    --* need to rewrite this later
	if ia(m) then
		if s.highdeathtimer == 200 or --Some butterflies start spawning around Mario.
		   s.highdeathtimer == 400 or
		   s.highdeathtimer == 600 or
		   s.highdeathtimer == 700 or
		   s.highdeathtimer == 800 or
		   s.highdeathtimer == 900 or
		   s.highdeathtimer == 1000 or
		   s.highdeathtimer == 1100 or
		   s.highdeathtimer == 1200 then
			spawn_non_sync_object(id_bhvButterfly, E_MODEL_BUTTERFLY, m.pos.x + 5, m.pos.y - 5, m.pos.z + 5, nil)
			spawn_non_sync_object(id_bhvButterfly, E_MODEL_BUTTERFLY, m.pos.x, m.pos.y, m.pos.z, nil)
		end
		if s.highdeathtimer == 100 or --Spawns occasional coins spawn to keep Mario alive
		   s.highdeathtimer == 300 or
		   s.highdeathtimer == 500 or
		   s.highdeathtimer == 700 or
		   s.highdeathtimer == 900 or
		   s.highdeathtimer == 1100 or
		   s.highdeathtimer == 1200 then
			local randommodel = math.random(3)
			if randommodel == 1 then
				spawn_non_sync_object(id_bhvMrIBlueCoin, E_MODEL_SMILER, m.pos.x, m.pos.y, m.pos.z, nil)
			elseif randommodel == 2 then
				spawn_non_sync_object(id_bhvMrIBlueCoin, E_MODEL_SMILER2, m.pos.x, m.pos.y, m.pos.z, nil)
			elseif randommodel == 3 then
				spawn_non_sync_object(id_bhvMrIBlueCoin, E_MODEL_SMILER3, m.pos.x, m.pos.y, m.pos.z, nil)
			end
		end
	end
	if (s.highdeathtimer) == 1100 then
		play_character_sound(m, CHAR_SOUND_COUGHING1)
	end
	if (s.highdeathtimer) == 1200 then
		play_character_sound(m, CHAR_SOUND_COUGHING2)
	end
	if (s.highdeathtimer) == 1210 then
		play_character_sound(m, CHAR_SOUND_COUGHING3)
	end
	if (s.highdeathtimer) == 1250 then
		play_character_sound(m, CHAR_SOUND_COUGHING2)
	end
	if (s.highdeathtimer) == 1265 then
		play_character_sound(m, CHAR_SOUND_COUGHING3)
	end
	if (s.highdeathtimer) == 1290 then --Mario dies from gas and resets all timers.

	end
	if (s.highdeathtimer) == 1340 then --Mario dies.
		m.health = 0xff
		set_mario_action(m, ACT_DEATH_ON_STOMACH, 0)
		play_character_sound(m, CHAR_SOUND_DYING)
		s.ishigh = 0
		s.outsidegastimer = 30
		s.highdeathtimer = 0
		s.isdead = true
	end

	if np.currLevelNum == LEVEL_SSL and np.currAreaIndex == 1 then
		if m.marioObj.oTimer == 30 and not s.sslIntro then
			cutscene_object_with_dialog(CUTSCENE_DIALOG, m.marioObj, DIALOG_046)
			s.sslIntro = true
		end
		if (m.action & ACT_FLAG_WATER_OR_TEXT) == 0 then
			s.ssldiethirst = s.ssldiethirst + 1
		else
			s.ssldiethirst = 0 -- stops timer
		end

		if s.ssldiethirst >= 300 then
			m.health = m.health - 1
			if m.health < 1024 then
				if m.action == ACT_IDLE then
					m.action = ACT_PANTING
				end
				if m.action == ACT_WALKING or m.action == ACT_JUMP or m.action == ACT_JUMP_KICK then
					m.forwardVel = clampf(m.forwardVel, -100, m.health / 64)
				end
				if m.action == ACT_LONG_JUMP then
					set_mario_action(m, ACT_JUMP, 0)
				end
			end
		end
		m.forwardVel = m.forwardVel + 0.3
	else
		s.ssldiethirst = 0
	end

	if np.currLevelNum == LEVEL_SL and np.currAreaIndex == 1 then
		if m.marioObj.oTimer == 30 and not s.slIntro then
			cutscene_object_with_dialog(CUTSCENE_DIALOG, m.marioObj, DIALOG_070)
			s.slIntro = true
		end
		m.health = m.health - 1
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Mario Disintegrates when on fire
	if m.action == ACT_BURNING_JUMP or m.action == ACT_BURNING_GROUND or m.action == ACT_BURNING_FALL then
        --* for the love of god please use for loops holc!!!!!!.......
		if m.usedObj then
			cur_obj_shake_screen(SHAKE_POS_SMALL)
			obj_scale(m.usedObj, 6)
			obj_copy_pos(m.usedObj, m.marioObj)
			m.usedObj.oGraphYOffset = 100
			m.marioObj.oMarioBurnTimer = 1
		end

		if (m.health <= 300) then
			m.squishTimer = 50
			audio_sample_stop(gSamples[sAgonyMario])
			audio_sample_stop(gSamples[sAgonyLuigi])
			audio_sample_stop(gSamples[sAgonyWario])
			audio_sample_stop(gSamples[sToadburn]) --Stops Mario's super long scream
			audio_sample_stop(gSamples[sAgonyWaluigi])
		end

        local touchingwater = m.pos.y <= m.waterLevel
        if touchingwater then
            spawn_mist_particles()
            spawn_mist_particles()
            spawn_mist_particles()
            spawn_mist_particles()
            spawn_mist_particles()
			network_play(sCoolOff, m.pos, 1, m.playerIndex)
			audio_sample_stop(gSamples[sAgonyMario])
			audio_sample_stop(gSamples[sToadburn]) --Stops Mario's super long scream
			audio_sample_stop(gSamples[sAgonyLuigi])
			audio_sample_stop(gSamples[sAgonyWario])
			audio_sample_stop(gSamples[sAgonyWaluigi])

			if m.usedObj then
				obj_mark_for_deletion(m.usedObj)
			end
        end
	end
	if m.usedObj and obj_has_behavior_id(m.usedObj, id_bhvFlame) ~= 0 and m.health < 128 then
		obj_mark_for_deletion(m.usedObj)
	end

----------------------------------------------------------------------------------------------------------------------------------
	--ENDING OF THE GAME CUTSCENE
	peach = obj_get_first_with_behavior_id(id_bhvEndPeach)
	if peach ~= nil then

		if (peach.oTimer == 950) then
			set_mario_action(m, ACT_THROWN_FORWARD, 0)
		end
		if (peach.oTimer >= 952) then
			mario_blow_off_cap(m, 23)
			m.marioBodyState.eyeState = MARIO_EYES_DEAD
		end
		if (peach.oTimer >= 950) and (peach.oTimer <= 969) then
			m.forwardVel = 6
		end
		if (peach.oTimer == 957) then
			spawn_mist_particles()
			play_character_sound(m, CHAR_SOUND_ATTACKED)
			local_play(sSplatter, m.pos, 1)
		end
		if (peach.oTimer == 960) then
			squishblood(m.marioObj)
		end
		if (peach.oTimer == 965) then
			smlua_anim_util_set_animation(m.marioObj, "MARIO_DYING_CUTSCENE")
		end
		if (peach.oTimer >= 970) then
			m.forwardVel = 0
		end
		if (peach.oTimer == 990) then
			play_character_sound(m, CHAR_SOUND_DYING)
		end
		if (peach.oTimer == 1290) then
			m.numLives = 0
			level_trigger_warp(m, WARP_OP_CREDITS_END)
		end
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Hell entrance cutscene
	if np.currLevelNum == LEVEL_HELL then
		if not ia(m) then return end
		
		if m.marioObj.oTimer <= 60 then
			--cur_obj_disable_rendering_and_become_intangible(m.marioObj)
			cur_obj_disable_rendering()
			m.pos.x = 69
			m.pos.y = 1100
			m.pos.z = -11800
			m.marioObj.oFaceAngleYaw = 0
			m.faceAngle.y = 0
		end
		if m.marioObj.oTimer == 61 then
			spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_RED_FLAME, m.pos.x, m.pos.y, m.pos.z, nil, m.playerIndex)
			network_play(sFlames, m.pos, 1, m.playerIndex)
			cur_obj_enable_rendering()
			local yaw = 0 --Creates a flame ring portal for Mario to spawn from.
			for i = 0, 16 do
				if m.playerIndex ~= 0 then return end
				yaw = yaw + 4096
				spawn_non_sync_object(id_bhvFireRing, E_MODEL_RED_FLAME, m.pos.x, m.pos.y + 26, m.pos.z, function (o)
					o.oFaceAngleYaw = yaw
					o.oMoveAngleYaw = o.oFaceAngleYaw
				end)
			end
			m.forwardVel = 65
			set_mario_action(m, ACT_HARD_FORWARD_AIR_KB, 0)
		end


		if m.marioObj.oTimer == 120 and not s.visitedhell then
			if ia(m) then
				cutscene_object_with_dialog(CUTSCENE_DIALOG, m.marioObj, DIALOG_019)
				s.visitedhell = true
			end
		end

	elseif np.currLevelNum == LEVEL_HELL and m.marioObj.oTimer == 1 then
		m.pos.x = 69
		m.pos.y = 1690
		m.pos.z = -11771
		m.faceAngle.y = 0
	end

----------------------------------------------------------------------------------------------------------------------------------
	--Mips is a pain to catch
	mips = obj_get_nearest_object_with_behavior_id(o, id_bhvMips)
	if mips ~= nil then
		mips.oMipsForwardVelocity = 100
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Racing penguin is stupid fast now. Only beatable by falling to the bottom of slide. Will insult mario to death if race lost, will crash into wall and splat if race won.
	racepen = obj_get_nearest_object_with_behavior_id(o, id_bhvRacingPenguin)
	if racepen ~= nil then 
		if (racepen.oAction == 3) then
			racepen.oRacingPenguinWeightedNewTargetSpeed = 240
			if (racepen.oRacingPenguinMarioWon ~= 0) then
				--racepen.oForwardVel = 60
			else
				racepen.oForwardVel = 180
			end
		end

		if (racepen.oRacingPenguinMarioWon ~= 0) then
			--if (racepen.oRacingPenguinReachedBottom ~= 0) and racepen.oPosZ == -7150 then --(racepen.oMoveFlags & OBJ_MOVE_HIT_WALL ~= 0) then
			if racepen.oPosZ <= -7140 then
				squishblood(racepen)
				local_play(sSplatter, m.pos, 1)
				cur_obj_play_sound_2(SOUND_OBJ_POUNDING_LOUD)
				set_camera_shake_from_point(SHAKE_POS_LARGE, racepen.oPosX, racepen.oPosY, racepen.oPosZ)
				obj_mark_for_deletion(racepen)
				spawn_sync_object(id_bhvStar, E_MODEL_STAR, m.pos.x, m.pos.y + 200, m.pos.z, function(star)
					star.oBehParams = 2 << 24
				end)
			end
		end
		if (racepen.oPrevAction == RACING_PENGUIN_ACT_SHOW_FINAL_TEXT ~= 0) and racepen.oRacingPenguinFinalTextbox == -1 then
			m.health = 0xff
		end
	end
----------------------------------------------------------------------------------------------------------------------------------
    --Goomba stomping sound effect.
    if m.bounceSquishTimer > 0 and not s.stomped then
        local_play(sGoombaStomp, m.pos, 1)
        s.stomped = true
    elseif m.bounceSquishTimer == 0 then s.stomped = false end

----------------------------------------------------------------------------------------------------------------------------------
	--Enables King Bobombs RIDICULOUS cannon-arm mario launch.
	if (m.action == ACT_GRABBED) then
		s.bigthrowenabled = 1
	end
	if (s.bigthrowenabled) == 1 then
		m.forwardVel = 280 --Was 150
	end
	if (s.bigthrowenabled) == 1 and m.hurtCounter > 0 then --  m.flags & ACT_AIR_THROW_LAND ~= 0 and m.action == 132193  both didnt work!
		m.squishTimer = 30
		s.bigthrowenabled = 0
	end
	if m.action == ACT_THROWN_FORWARD then
		s.bigthrowenabled = 0
	end
----------------------------------------------------------------------------------------------------------------------------------
	--When getting the 100 coin star, a bobomb nuke spawns on Mario.
	if (m.numCoins) == 100 then 
		m.numCoins = m.numCoins + 1
		spawn_sync_if_main(id_bhvBobomb, E_MODEL_BOBOMB_BUDDY, m.pos.x, m.pos.y, m.pos.z, nil, m.playerIndex)
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Pokey cactus do things
	pokey = obj_get_nearest_object_with_behavior_id(o, id_bhvPokey)
	if (pokey ~= nil) then
		pokey.oForwardVel = 40
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Switches snow landing to snow drowning
	if (m.action == ACT_HEAD_STUCK_IN_GROUND) or (m.action == ACT_BUTT_STUCK_IN_GROUND) or (m.action == ACT_FEET_STUCK_IN_GROUND) then
		m.particleFlags = PARTICLE_MIST_CIRCLE
		set_mario_action(m, ACT_GONE, 60)
		m.health = 0xff
 	end
----------------------------------------------------------------------------------------------------------------------------------

	if m.heldObj ~= nil and (obj_has_behavior_id(m.heldObj, id_bhvUkiki) ~= 0) and np.currLevelNum == LEVEL_BOWSER_1 then
		ukikiholding = 1
		ukikiheldby = m.playerIndex
	end
	if (ukikiholding) == 1 then
		if m.heldObj ~= nil and (obj_has_behavior_id(m.heldObj, id_bhvUkiki) ~= 0) then
			ukikitimer = ukikitimer + 1
		end
	end
	if (ukikitimer) == 2 and m.playerIndex == ukikiheldby then
		local_play(sAngryMario, m.pos, 1)
		stream_stop_all()
		local_play(sSMWBonusEnd, m.pos, 1)
	end
	if (ukikitimer) == 40 then
		obj_mark_for_deletion(m.heldObj)
		m.heldObj = nil
		set_mario_action(m, ACT_PUNCHING, 0)
		ukikitimer = ukikitimer + 1
		print("40")
	end
	if (ukikitimer) >= 41 and ia(m) then
		ukikitimer = ukikitimer + 1
		print("timing")
	end
	if (ukikitimer) == 50 then
		print("kaboom!")
		if m.playerIndex == ukikiheldby then
			m.particleFlags = PARTICLE_MIST_CIRCLE
			squishblood(m.marioObj)
			local_play(sSplatter, m.pos, 1)
			ukikiheldby = -1
			ukikiholding = 0
			ukikitimer = 0
		end
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Mario has his hat after every respawn. Makes for funny deaths when his hat flies off.
	save_file_clear_flags(SAVE_FLAG_CAP_ON_GROUND | SAVE_FLAG_CAP_ON_KLEPTO | SAVE_FLAG_CAP_ON_UKIKI | SAVE_FLAG_CAP_ON_MR_BLIZZARD)
	m.cap = m.cap & ~(SAVE_FLAG_CAP_ON_GROUND | SAVE_FLAG_CAP_ON_KLEPTO | SAVE_FLAG_CAP_ON_UKIKI | SAVE_FLAG_CAP_ON_MR_BLIZZARD)
----------------------------------------------------------------------------------------------------------------------------------
	--(Whomps Fortress) No more wood platform
	o = obj_get_nearest_object_with_behavior_id(o, id_bhvWfRotatingWoodenPlatform)
	if (o) ~= nil then
		if mario_is_within_rectangle(o.oPosX - 50, o.oPosX + 50, o.oPosZ - 50, o.oPosZ + 50) ~= 0 then
			o.oPosY = o.oPosY - 100
			obj_mark_for_deletion(o)
		end
	end
----------------------------------------------------------------------------------------------------------------------------------
	--BoB Objects

	----This makes the chain chomp gate disappear.
	o = obj_get_nearest_object_with_behavior_id(o, id_bhvChainChompGate)
	if o ~= nil then
		if mario_is_within_rectangle(o.oPosX - 150, o.oPosX + 150, o.oPosZ - 150, o.oPosZ + 150) ~= 0 then
			spawn_triangle_break_particles(30, 138, 1, 4)
			play_sound(SOUND_ACTION_HIT_2, m.marioObj.header.gfx.cameraToObject)
			obj_mark_for_deletion(o)
		end
	end

----------------------------------------------------------------------------------------------------------------------------------
	--(Lethal Lava Land) LLL Objects

	----The Drawbridge by the eye across from spawn.
	o = obj_get_nearest_object_with_behavior_id(o, id_bhvLllDrawbridge)
	if o ~= nil then
		if mario_is_within_rectangle(o.oPosX - 250, o.oPosX + 250, o.oPosZ - 250, o.oPosZ + 250) ~= 0 then
			obj_mark_for_deletion(o)
		end
	end

	----This is a 2x2 (4-square) type platform that sinks, not the individual tiles.
	o = obj_get_nearest_object_with_behavior_id(o, id_bhvLllSinkingSquarePlatforms)
	if o ~= nil then
		o.oMoveAngleYaw = o.oMoveAngleYaw + 500
	end

----------------------------------------------------------------------------------------------------------------------------------
	-- (Cool Cool Mountain) Baby penguin gets thrown after 8 seconds of mario losing his patience.

	if m.heldObj and obj_has_behavior_id(m.heldObj, id_bhvSmallPenguin) ~= 0 then
		s.penguinholding = 1
	end
	if (s.penguinholding) == 1 then
		if m.heldObj and obj_has_behavior_id(m.heldObj, id_bhvSmallPenguin) ~= 0 then
			s.penguintimer = s.penguintimer + 1
		end
	end
	if (s.penguintimer) == 230 then
		local_play(sAngryMario, m.pos, 1)
	end
	if (s.penguintimer) == 280 then
		m.heldObj.oAction = 6
		mario_drop_held_object(m)
		set_mario_action(m, ACT_JUMP_KICK, 0)
		m.particleFlags = PARTICLE_MIST_CIRCLE|PARTICLE_TRIANGLE
		play_sound(SOUND_ACTION_BONK, m.marioObj.header.gfx.cameraToObject)
		s.penguinholding = 0
		s.penguintimer = 0
	end
end

----------------------------------------------------------------------------------------------------------------------------------

function mariohitbyenemy(m) -- Default and generic 1-hit death commands.
if (m.hurtCounter > 0) then
	local s = gStateExtras[m.playerIndex]

	-- Air Insta-Kill Mario (Generic hits, mario pvp air kicks, etc..)
	if (m.action == ACT_HARD_FORWARD_AIR_KB) then
		m.health = 0xff
	end
	if (m.action == ACT_HARD_BACKWARD_AIR_KB) then
		m.health = 0xff
	end

	-- BIG fall insta-kill (Falling from REALLY high)
	if (m.action == ACT_HARD_BACKWARD_GROUND_KB) then
		m.squishTimer = 50
	end
	if (m.action == ACT_HARD_FORWARD_GROUND_KB) then
		m.squishTimer = 50
	end
end
end

function on_interact(m, o, intType, interacted) --Best place to switch enemy behaviors to have mario insta-die.
	local s = gStateExtras[m.playerIndex]
	np = gNetworkPlayers[0]
	print(get_behavior_name_from_id(get_id_from_behavior(o.behavior)))

	--KILLABLE TOAD 
	if (obj_has_behavior_id(o,id_bhvToadMessage)) ~= 0 and ((m.controller.buttonPressed & B_BUTTON) + (m.action & ACT_FLAG_ATTACKING) ~= 0) then
		spawn_sync_if_main(id_bhvWhitePuffExplosion, E_MODEL_WHITE_PUFF, o.oPosX, m.floorHeight + 2, o.oPosZ, nil, m.playerIndex)
		spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, m.floorHeight + 2, o.oPosZ, nil, m.playerIndex)
		play_sound_with_freq_scale(SOUND_MARIO_ATTACKED, m.marioObj.header.gfx.cameraToObject, 1.25)
		squishblood(o)
		obj_mark_for_deletion(o)
		network_play(sSplatter, m.pos, 1, m.playerIndex)
		if m.action & ACT_FLAG_AIR == 0 then
			set_mario_action(m, ACT_PUNCHING, 0)
		end
		gGlobalSyncTable.toaddeathcounter = gGlobalSyncTable.toaddeathcounter + 1

	end
		
	--KILLABLE YOSHI 
	if (obj_has_behavior_id(o,id_bhvYoshi)) ~= 0 and (m.controller.buttonPressed & B_BUTTON) ~= 0 then
		set_mario_action(m, ACT_JUMP_KICK, 0)
		spawn_sync_if_main(id_bhvWhitePuffExplosion, E_MODEL_WHITE_PUFF, o.oPosX, m.floorHeight + 50, o.oPosZ, nil, m.playerIndex)
		spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, m.floorHeight + 50, o.oPosZ, nil, m.playerIndex)
		squishblood(o)
		o.oAction = 6
		o.oTimer = 0
		play_sound(SOUND_ACTION_BONK, m.pos)
		local_play(sSplatter, m.pos, 1)
		local_play(sKillYoshi, m.pos, 1)
		for i = 0, 100 do
			spawn_sync_object(id_bhvBouncy1up, E_MODEL_1UP, o.oPosX, o.oPosY, o.oPosZ, nil)
		end
		spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
		spawn_sync_object(id_bhvTrophy, E_MODEL_YOSHI, o.oPosX, o.oPosY, o.oPosZ, function(t)
			t.oBehParams = 18 << 16 | 1
		end)
	end

	--Custom Bully necksnap
	if obj_has_behavior_id(o, id_bhvSmallBully) ~= 0 and (m.action == ACT_SOFT_FORWARD_GROUND_KB or m.action == ACT_SOFT_BACKWARD_GROUND_KB) then
		--network_play(sBoneBreak, m.pos, 1, m.playerIndex)
		set_mario_action(m, ACT_NECKSNAP, 0)
	end

	--Custom bobomb buddy explosions
	if obj_has_behavior_id(o, id_bhvBobombBuddy) ~= 0 then
		spawn_sync_object(id_bhvExplosion, E_MODEL_EXPLOSION, o.oPosX, o.oPosY, o.oPosZ, nil)
		obj_mark_for_deletion(o)
	end

	--Snowman's head insta-kill
	if obj_has_behavior_id(o, id_bhvSnowmansBottom) ~= 0 then
		m.squishTimer = 50
	end

	--Skeeter insta-kill
	if obj_has_behavior_id(o, id_bhvSkeeter) ~= 0 and (m.hurtCounter > 0) then
		m.squishTimer = 50
	end

	--Scuttlebug insta-kill
	if obj_has_behavior_id(o, id_bhvScuttlebug) ~= 0 and (m.hurtCounter > 0) then
		m.squishTimer = 50
	end

	--JRB falling pillar insta-kill
	if obj_has_behavior_id(o, id_bhvFallingPillarHitbox) ~= 0 and (m.hurtCounter > 0) then
		m.squishTimer = 50
	end

    --Snowballs
    if obj_has_behavior_id(o, id_bhvMrBlizzardSnowball) ~= 0 and (m.hurtCounter > 0) then
        m.faceAngle.y = o.oMoveAngleYaw - 32768
        m.pos.y = m.pos.y + 5
        set_mario_action(m, ACT_THROWN_BACKWARD, 0)
        m.vel.y = m.vel.y + 30
        m.forwardVel = -150
    end

	--Custom bullet bill boom
	if obj_has_behavior_id(o, id_bhvBulletBill) ~= 0 and (m.hurtCounter > 0) then
		spawn_sync_if_main(id_bhvExplosion, E_MODEL_BOWSER_FLAMES, m.pos.x, m.pos.y, m.pos.z, nil, m.playerIndex)
		obj_mark_for_deletion(o)
	end

	if (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvPiranhaPlant) ~= 0 and not s.headless then
		s.headless = true
		network_play(sSplatter, m.pos, 1, m.playerIndex)
		network_play(sCrunch, m.pos, 1, m.playerIndex)
		--squishblood(m.marioObj)
		m.health = 0xff
		set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
		m.particleFlags = PARTICLE_MIST_CIRCLE
		set_mario_action(m, ACT_DECAPITATED, 0)

	end

	if (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvFlyingBookend) ~= 0 and not s.headless then
		s.headless = true
		network_play(sSplatter, m.pos, 1, m.playerIndex)
		network_play(sCrunch, m.pos, 1, m.playerIndex)
		m.health = 0xff
		set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
		m.particleFlags = PARTICLE_MIST_CIRCLE
		set_mario_action(m, ACT_DECAPITATED, 0)
	end

	if (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvGoomba) ~= 0 and not s.headless then
		if o.oAction == GOOMBA_ACT_JUMP then
			s.headless = true
			network_play(sSplatter, m.pos, 1, m.playerIndex)
			m.health = 0xff
			set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
			m.particleFlags = PARTICLE_MIST_CIRCLE
			set_mario_action(m, ACT_DECAPITATED, 0)
		else
			m.squishTimer = 50
		end
	end

    handle_object_interaction(m, o)

	if (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvMadPiano) ~= 0 then
		s.bottomless = true
		network_play(sSplatter, m.pos, 1, m.playerIndex)
		network_play(sCrunch, m.pos, 1, m.playerIndex)
		squishblood(m.marioObj)
		m.health = 0xff
		mario_blow_off_cap(m, 15)
		set_mario_action(m, ACT_BITTEN_IN_HALF, 0)
		cur_obj_become_intangible()
		m.hurtCounter = 0
	end

	-- Custom FlyGuy insta-death
	if obj_has_behavior_id(o, id_bhvFlyGuy) ~= 0 and (m.hurtCounter > 0) then
		m.squishTimer = 50
	end

	--Chain Chomp insta-deaths
	if obj_has_behavior_id(o, id_bhvChainChomp) ~= 0 and not s.bottomless and (m.hurtCounter > 0) and (m.action == ACT_BACKWARD_GROUND_KB or m.action == ACT_FORWARD_GROUND_KB) then --Custom Chain Chomp Mario Kill backward
		s.bottomless = true
		network_play(sSplatter, m.pos, 1, m.playerIndex)
		network_play(sCrunch, m.pos, 1, m.playerIndex)
		squishblood(m.marioObj)
		m.health = 0xff
		mario_blow_off_cap(m, 15)
		cur_obj_shake_screen(SHAKE_POS_LARGE)
		set_mario_action(m, ACT_BITTEN_IN_HALF, 0)
	end

	--Big bully kill mario
	if obj_has_behavior_id(o, id_bhvBigBully) ~= 0 and (m.action == ACT_SOFT_FORWARD_GROUND_KB or m.action == ACT_SOFT_BACKWARD_GROUND_KB or m.action == ACT_BACKWARD_AIR_KB or m.action == ACT_FORWARD_AIR_KB or m.action == ACT_JUMP) then
		if  m.action & ACT_FLAG_AIR > 0 then
			if m.action == ACT_DEATH_ON_STOMACH then return end
			if m.pos.y > m.floorHeight then
				m.vel.x = m.vel.x + sins(o.oMoveAngleYaw) * o.oForwardVel/2
				m.vel.z = m.vel.z + coss(o.oMoveAngleYaw) * o.oForwardVel/2
				m.vel.y = 65
				local angle = obj_angle_to_object(m.marioObj, o)
				m.marioObj.oFaceAngleYaw = angle
				m.marioObj.oMoveAngleYaw = m.marioObj.oFaceAngleYaw
				spawn_mist_particles()
				play_sound(SOUND_ACTION_BOUNCE_OFF_OBJECT, m.marioObj.header.gfx.cameraToObject)
				set_mario_action(m, ACT_RAGDOLL, 0)
			end
		else
			m.squishTimer = 50
		end	
	end

	if obj_has_behavior_id(o, id_bhvBigChillBully) ~= 0 and (m.action == ACT_SOFT_FORWARD_GROUND_KB or m.action == ACT_SOFT_BACKWARD_GROUND_KB) then
		m.squishTimer = 50
	end
end

function before_mario_action(m, action)
	local s = gStateExtras[m.playerIndex]
	local np = gNetworkPlayers[0]
-------------------------------------------------------------------------------------------------------------------------------------------------
	--Disables LAVA_BOOST and replaces with a splash and insta-death... KERPLUNK!!
	if (action == ACT_LAVA_BOOST) and np.currLevelNum ~= LEVEL_SL then
		
		set_mario_action(m, ACT_GONE, 1)
		local_play(sSplash, m.pos, 1)
		spawn_non_sync_object(id_bhvBowserBombExplosion, E_MODEL_BOWSER_FLAMES, m.pos.x, m.pos.y, m.pos.z, nil)
		--m.health = 120
		m.health = 0xff
		
		return 1
	end

	--If lava boosted from ice, insta-kill Mario
	if (action == ACT_LAVA_BOOST) and np.currLevelNum == LEVEL_SL then
		m.pos.y = m.pos.y + 100
		m.health = 0xff
	end
-------------------------------------------------------------------------------------------------------------------------------------------------
	--Disables LAVA RUN and replaces with death.
	if (action == ACT_BURNING_JUMP) then --removed (action == ACT_BURNING_JUMP) or (action == ACT_BURNING_FALL) since it would reset each jump
		network_play(sFlames, m.pos, 1, m.playerIndex)

		if (m.marioObj.oMarioBurnTimer == 0) then
			if (m.usedObj and obj_has_behavior_id(m.usedObj, id_bhvFlame) == 0) or not m.usedObj then
				m.usedObj = spawn_sync_object(id_bhvFlame, E_MODEL_RED_FLAME, m.pos.x, m.pos.y, m.pos.z, nil)
			end
			if m.character.type == CT_MARIO then
				network_play(sAgonyMario, m.pos, 1, m.playerIndex)
			elseif m.character.type == CT_LUIGI then
				network_play(sAgonyLuigi, m.pos, 1, m.playerIndex)
			elseif m.character.type == CT_TOAD then
				network_play(sToadburn, m.pos, 1, m.playerIndex)
			elseif m.character.type == CT_WARIO then
				network_play(sAgonyWario, m.pos, 1, m.playerIndex)
			elseif m.character.type == CT_WALUIGI then
				network_play(sAgonyWaluigi, m.pos, 1, m.playerIndex)
			end
		end
	end
-------------------------------------------------------------------------------------------------------------------------------------------------
	--Unhides Mario if his action is changed for any reason. 
	if m.action == ACT_GONE then
		m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags | GRAPH_RENDER_ACTIVE
	end
end

function action_start(m)
	if m.action == ACT_NECKSNAP then
		local s = gStateExtras[m.playerIndex]
		s.isgold = false
		gPlayerSyncTable[m.playerIndex].gold = false
		squishblood(m.marioObj)

	elseif m.action == ACT_SHOCKED then -- play shock sounds
		local s = gStateExtras[m.playerIndex]
		s.isgold = false
		gPlayerSyncTable[m.playerIndex].gold = false
		print("playing shock for "..gNetworkPlayers[m.playerIndex].name)
		network_play(sElectricScream, m.pos, 1, m.playerIndex)
		network_play(sShock, m.pos, 1, m.playerIndex)
		m.particleFlags = PARTICLE_MIST_CIRCLE
	end
end

function mariodeath() -- If mario is dead, this will pause the counter to prevent false positive 2nd deaths, like getting neck snapped (death 1) and then falling into lava. (death 2) 
	--Will also reset other functions as well.
	local s = gStateExtras[0]

	s.penguintimer = 0 -- Resets the baby-penguin timer since Mario is dead.
	audio_sample_stop(gSamples[sAgonyMario]) --Stops Mario's super long scream
	audio_sample_stop(gSamples[sAgonyLuigi]) --Stops Luigi's super long scream
	audio_sample_stop(gSamples[sToadburn]) --Stops Toad's super long scream
	audio_sample_stop(gSamples[sAgonyWario]) --Stops Wario's super long scream
	audio_sample_stop(gSamples[sAgonyWaluigi]) --Stops Waluigi's super long scream
	s.bigthrowenabled = 0
	s.timeattack = false
	--set_override_envfx(ENVFX_MODE_NONE)
	stream_fade(50) --Stops the Hazy Maze Cave custom music after death. Stops the ukiki minigame music if Mario falls to death. 
	if not s.isdead and not s.disableuntilnextwarp then
		gGlobalSyncTable.deathcounter = gGlobalSyncTable.deathcounter + 1
		s.isdead = true
	end
end

function marioalive() -- Resumes the death counter to accept death counts. 
	local s = gStateExtras[0]
	local np = gNetworkPlayers[0]
	local m = gMarioStates[0]
	audio_sample_stop(gSamples[sAgonyMario]) --Stops Mario's super long scream
	audio_sample_stop(gSamples[sToadburn]) --Stops Toad's super long scream
	audio_sample_stop(gSamples[sAgonyLuigi]) --Stops Luigi's super long scream
	audio_sample_stop(gSamples[sAgonyWario]) --Stops Wario's super long scream
	audio_sample_stop(gSamples[sAgonyWaluigi]) --Stops Waluigi's super long scream

	hud_show()

	s.death = false
	s.isdead = false --Mario is alive
	s.disableuntilnextwarp = false --Enables death counter
	s.headless = false --Gives Mario his head back
	s.bottomless = false --Gives Mario his whole upper body back

	if np.currLevelNum == LEVEL_TTM and np.currAreaIndex < 2 then
		m.pos.y = m.pos.y + 920
	end

	if m.numLives <= 0 and not s.isinhell and not s.iwbtg and gGlobalSyncTable.hellenabled then
		s.isinhell = true
		warp_to_level(LEVEL_HELL, 1, 0)
	else 
		--s.iwbtg = false
		--s.death = false
		--warp_to_level(LEVEL_CASTLE_GROUNDS, 1, 0)
	end

	--Resets the baby penguin timer on warp so it doesn't glitch out if mario leaves the level without fully killing the baby penguin.
	s.penguinholding = 0
	s.penguintimer = 0
end

function toaddeath(o)
	local deaths = gGlobalSyncTable.toaddeathcounter
	if obj_has_behavior_id(o, id_bhvToadMessage) ~= 0 then
		if deaths == 10 then
			bhv_spawn_star_no_level_exit(o, 0, 1)
		end
		if deaths == 20 then
			bhv_spawn_star_no_level_exit(o, 1, 1)
		end
		if deaths == 30 then
			bhv_spawn_star_no_level_exit(o, 2, 1)
		end
		if deaths >= 50 and gGlobalSyncTable.gameisbeat then --GRANT TROPHY #19
			spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, m.pos.x, m.pos.y, m.pos.z, function(t)
				t.oBehParams = 19 << 16 | 1
			end)
		end
		toadguitimer = 150
	end
end

function hud_render() -- Displays the total amount of mario deaths a server has incurred since opening. 
	local s = gStateExtras[0]
	local m = gMarioStates[0]
	local n = gNetworkPlayers[0]
	if m.floor and m.floor.object and obj_has_behavior_id(m.floor.object, id_bhvBackroom) ~= 0 then return end

	if s.death and s.iwbtg then
		djui_hud_render_texture(TEX_GAMEOVER, (screenWidth/2) - 256, (screenHeight/2) - 128, 1, 1)
		--hud_hide()
		hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_POWER)
		if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
			hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) | HUD_DISPLAY_FLAG_POWER)
			m.health = 2176
			s.iwbtg = false
			s.death = false
			warp_to_level(LEVEL_CASTLE_GROUNDS, 1, 0)
			m.numLives = 4
			s.iwbtg = true
		end
	end

	if s.timeattack then
		--djui_hud_set_resolution(RESOLUTION)
		local o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvStopwatch)
		if o then
			local totalSeconds = math.ceil((gGlobalSyncTable.timerMax - o.oTimer) / 30)
			local minutes = math.floor(totalSeconds / 60)
			local seconds = totalSeconds % 60
			local timerString = string.format("%02d :%02d", minutes, seconds)
			--djui_hud_print_text(timerString, 850, 100, 5)
			djui_hud_print_text(timerString, screenWidth / 2 - djui_hud_measure_text(timerString), screenHeight - 48, 1)

		else
			s.timeattack = false
		end

	end


	screenHeight = djui_hud_get_screen_height()
	screenWidth = djui_hud_get_screen_width()

	--TOAD DEATH COUNTER. Each time you kill toad, the count goes up. It compares the number with the PreviousToadDeath variable, which tells it to update and triggers commands.
	--Toad gives 3 stars. I have set this to give these stars after every 100 toad kills.
	local deathcount = "Total server death count: "..gGlobalSyncTable.deathcounter
	djui_hud_print_text(deathcount, screenWidth - 30 - djui_hud_measure_text(deathcount), screenHeight - 78, 1)

	if (toadguitimer) ~= 0 then
		toadguitimer = toadguitimer - 1
		djui_hud_set_color(255, 255, 0, lerp(0, 255, (math.max(0, toadguitimer))/150))

		local toaddeathcount = "Server Toad death count: "..gGlobalSyncTable.toaddeathcounter
		djui_hud_print_text(toaddeathcount, screenWidth - 30 - djui_hud_measure_text(toaddeathcount), screenHeight - 48, 1)
	end
------------------------------------------------------------------------------------------------------------------------------------------------------------------
	djui_hud_set_resolution(RESOLUTION_N64)
	local width = (djui_hud_get_screen_width()+1)/512
	local height = 240/512

	--MARIO HIGH IN GAS OVERLAY
	djui_hud_set_color(255, 255, 255, highalpha)
	djui_hud_render_texture(TEX_MARIO_LESS_HIGH, 0, 0, width, height)

	if (s.highdeathtimer) >= 1 then --Mario is high, therefore a hazy green gas overlay comes up on the screen.
		highalpha = highalpha + 1
	end
	if (s.ishigh == 0) or (s.highdeathtimer >= 940) then --Mario is not high, therefore this will remove the gas effect on the hud.
		highalpha = highalpha - 2
	end
	highalpha = clamp(highalpha, 0, 255)

	--MARIO BLOODY GAS OVERLAY
	djui_hud_set_color(255, 255, 255, bloodalpha)
	djui_hud_render_texture(TEX_BLOOD_OVERLAY, 0, 0, width, height)

	if (s.highdeathtimer) >= 1000 then --Mario is very high and dying, therefore bloody gas overlay comes up on the screen.
		bloodalpha = bloodalpha + 1
	end
	if (s.ishigh == 0) then --Mario is not high, therefore this will remove the gas effect on the hud.
		bloodalpha = bloodalpha - 4
	end
	bloodalpha = clamp(bloodalpha, 0, 255)

	--MARIO TRIPPY OVERLAY
	djui_hud_set_color(255, 255, 255, hallucinate)
	djui_hud_render_texture(TEX_TRIPPY_OVERLAY, 0, 0, width, height)

	if (s.highdeathtimer) >= 360 then --Mario is hallucinating.
		hallucinate = hallucinate + 1
	end
	if (s.ishigh == 0) or (s.highdeathtimer >= 1090) then --Mario is not high or too high, therefore this will remove the gas effect on the hud.
		hallucinate = hallucinate - 3
	end
	hallucinate = clamp(hallucinate, 0, 111)

	--PORTAL OVERLAY
	if m.marioObj and loadingscreen < 1 then
		djui_hud_set_color(255, 255, 255, portalalpha)
		djui_hud_render_texture_tile(TEX_PORTAL, 0, 0, width*32, 15, 0, (m.marioObj.oTimer % 32)*16, 16, 16)

		local portal = obj_get_first_with_behavior_id(id_bhvNetherPortal)
		if portal and portal.oSubAction > 0 then --Mario is in the portal.
			portalalpha = portalalpha + 3
		else
			portalalpha = portalalpha - 6
		end

		portalalpha = clamp(portalalpha, 0, 200)
	end

	-- warp loading screen
	if loadingscreen > 0 then
		loadingscreen = loadingscreen - 1
		sound_banks_disable(0, SOUND_BANKS_ALL)
		sound_banks_disable(1, SOUND_BANKS_ALL)
		sound_banks_disable(2, SOUND_BANKS_ALL)
		djui_hud_set_color(255, 255, 255, 255)

		for i=0, math.ceil(djui_hud_get_screen_width()/32) do
			for j=0, 7 do
				djui_hud_render_texture(TEX_DIRT, i*32, j*32, 1, 1)
			end
		end
		if loadingscreen == 2 then
			s.isinhell = false
			warp_to_start_level()
			m.numLives = m.numLives + 10
		elseif loadingscreen == 0 then
			sound_banks_enable(0, SOUND_BANKS_ALL)
			sound_banks_enable(1, SOUND_BANKS_ALL)
			sound_banks_enable(2, SOUND_BANKS_ALL)

			local_play(sPortalTravel, gLakituState.pos, 1)
			play_sound(SOUND_GENERAL_COLLECT_1UP, vec3f())
		end
	end
end
-- prevent warp transition after loading finishes
hook_event(HOOK_ON_SCREEN_TRANSITION, function ()
	if loadingscreen > 0 then return false end
end)

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function mario_before_phys_step(m)
	local hScale = 1.0
	local vScale = 1.0

	-- faster swimming
	if (m.action & ACT_FLAG_SWIMMING) ~= 0 then
		hScale = hScale * 5.0
		if m.action ~= ACT_WATER_PLUNGE then
			vScale = vScale * 5.0
		end
	end

	m.vel.x = m.vel.x * hScale
	m.vel.y = m.vel.y * vScale
	m.vel.z = m.vel.z * hScale
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-----GREEN DEMONS (ONCE AND FOR ALL!!) This finally works so DON'T TOUCH IT!!
local function before_phys_step(m,stepType) --Called once per player per frame before physics code is run, return an integer to cancel it with your own step result
	local np = gNetworkPlayers[0]

	if not ia(m) then return end

	local obj = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhv1Up)
    if obj and np.currLevelNum ~= LEVEL_HELL and nearest_interacting_mario_state_to_object(obj).playerIndex == 0 and mario_is_within_rectangle(obj.oPosX - 200, obj.oPosX + 200, obj.oPosZ - 200, obj.oPosZ + 200) ~= 0 and m.pos.y > obj.oPosY - 200 and m.pos.y < obj.oPosY + 200 then --if local mario is touching 1up then
		spawn_sync_object(id_bhvWhitePuff1, E_MODEL_WHITE_PUFF, obj.oPosX, obj.oPosY, obj.oPosZ, nil)
		obj_mark_for_deletion(obj)
		local_play(sFart, m.pos, 1)
    end

	local demon = obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhvHidden1upInPole) -- HAS ISSUES WITH CASTLE BRIDGE DEMON
    if np.currLevelNum ~= LEVEL_HELL and demon and nearest_interacting_mario_state_to_object(demon).playerIndex == 0 and is_within_100_units_of_mario(demon.oPosX, demon.oPosY, demon.oPosZ) == 1 then --if local mario is touching 1up then
		obj_mark_for_deletion(demon)
		local_play(sFart, m.pos, 1)
    end
end



---------hooks--------
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_MARIO_UPDATE, modsupport)
hook_event(HOOK_MARIO_UPDATE, testing)
hook_event(HOOK_MARIO_UPDATE, mariohitbyenemy)
hook_event(HOOK_MARIO_UPDATE, splattertimer)
hook_event(HOOK_BEFORE_MARIO_UPDATE, function (m) -- mario high
--local s = gStateExtras[m.playerIndex]
local s = gStateExtras[0]
if (s.ishigh) == 1 then
    if m.input & INPUT_NONZERO_ANALOG ~= 0 then
		local range = 12288
        local t = m.marioObj.oTimer/50
        local angle = atan2s(m.controller.stickY, m.controller.stickX)
        local woowoo = sins(2 * t) + sins(math.pi * t)

		if (s.highdeathtimer) < 1100 then m.controller.stickMag = m.controller.stickMag*.25 end
        m.intendedYaw = m.intendedYaw + woowoo*range
        m.controller.stickX = m.controller.stickMag * sins(angle+woowoo*range)
        m.controller.stickY = m.controller.stickMag * coss(angle+woowoo*range)
    end
	if (s.highdeathtimer) >= 1100 then
		m.controller.buttonDown = Z_TRIG
		m.controller.buttonPressed = Z_TRIG
	end
end
	if m.usedObj and obj_has_behavior_id(m.usedObj, id_bhvKingBobomb) ~= 0 and m.usedObj.usingObj == m.marioObj then
		m.controller.buttonDown = m.usedObj.oTimer == 40 and A_BUTTON or 0
	end
end)
hook_event(HOOK_ON_WARP, marioalive)
hook_event(HOOK_BEFORE_PHYS_STEP, mario_before_phys_step)
hook_event(HOOK_BEFORE_SET_MARIO_ACTION, before_mario_action)
hook_event(HOOK_ON_SET_MARIO_ACTION, action_start)
hook_event(HOOK_ON_DEATH, mariodeath)
hook_event(HOOK_ON_OBJECT_UNLOAD, toaddeath)
hook_event(HOOK_ON_INTERACT, on_interact)
hook_event(HOOK_ON_HUD_RENDER, hud_render)
hook_event(HOOK_BEFORE_PHYS_STEP, before_phys_step) --Called once per player per frame before physics code is run, return an integer to cancel it with your own step result

-------------PvP-----------------------

--Custom PvP
hook_event(HOOK_ON_PVP_ATTACK, function (attacker, victim)
	local s = gStateExtras[victim.playerIndex]

	local actionExceptions = {
		[ACT_BACKWARD_GROUND_KB] = true,
		[ACT_FORWARD_GROUND_KB] = true,
		[ACT_FORWARD_AIR_KB] = true,
		[ACT_BACKWARD_AIR_KB] = true
	}

	--Enables 'ground pound' PvP splattering. 
	if attacker.action == ACT_GROUND_POUND and s.splatter == 1 then
		local_play(sSplatter, victim.pos, 1)
		s.splatterdeath = 1
		s.splatter = 0
		s.disappear = 1 -- No corpse mode.  
	end

	--Punching Sounds and blood
	if (attacker.action == ACT_PUNCHING) or (attacker.action == ACT_JUMP_KICK) or (attacker.action == ACT_MOVE_PUNCHING) then
		local_play(sPunch, victim.pos, 1)
		squishblood(victim.marioObj)
		if not actionExceptions[victim.action] then
			
		end
	end

	--Tripping
	if attacker.action == ACT_SLIDE_KICK and victim.action ~= ACT_GROUND_BONK then
		--local_play(sBoneBreak, victim.pos, 1) --Doesn't play consistently and I don't know why. Sometimes none, sometimes doubles. Probably not even a good sound for this anyway.
		set_mario_action(victim, ACT_GROUND_BONK, 0)
	end

	--Neck snapping
	if attacker.action == ACT_DIVE and victim.action ~= ACT_NECKSNAP then
		--local_play(sBoneBreak, victim.pos, 1)
		set_mario_action(victim, ACT_NECKSNAP, 0)
		set_mario_action(attacker, ACT_DIVE_SLIDE, 0)
	end



end)
---------------------------------------

--IWBTG MODE
hook_chat_command("iwbtg", "iwbtm", function ()
	local m = gMarioStates[0]
	local s = gStateExtras[0]
	if not s.iwbtg then

        delete_save(m)

		play_sound(SOUND_MENU_COLLECT_SECRET, m.pos)
		s.iwbtg = true
		m.numLives = 1
		play_character_sound(m, CHAR_SOUND_LETS_A_GO)
		play_transition(WARP_TRANSITION_FADE_INTO_COLOR, 1, 255, 0, 0)
        play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 15, 255, 0, 0)
		djui_chat_message_create("IWBTG MODE ENABLED!")
	else
		save_file_set_using_backup_slot(false)
		djui_chat_message_create("IWBTG mode disabled... Chicken!")
		m.health = 2176
		s.iwbtg = false
		s.death = true
		m.numLives = 4
		stream_stop_all()
		local_play(sChicken, m.pos, 1)
		spawn_non_sync_object(id_bhvExplosion, E_MODEL_EXPLOSION, m.pos.x, m.pos.y, m.pos.z, nil)
	end
	return true
end)

local msgToLevel = {
    ["BOB"] = LEVEL_BOB,
    ["WF"] = LEVEL_WF,
    ["JRB"] = LEVEL_JRB,
    ["CCM"] = LEVEL_CCM,
    ["BBH"] = LEVEL_BBH,
    ["HMC"] = LEVEL_HMC,
    ["LLL"] = LEVEL_LLL,
    ["SSL"] = LEVEL_SSL,
    ["DDD"] = LEVEL_DDD,
    ["SL"] = LEVEL_SL,
    ["WDW"] = LEVEL_WDW,
    ["TTM"] = LEVEL_TTM,
    ["THI"] = LEVEL_THI,
    ["TTC"] = LEVEL_TTC,
    ["RR"] = LEVEL_RR,
    ["PSS"] = LEVEL_PSS,
    ["TOTWC"] = LEVEL_TOTWC,
    ["VCUTM"] = LEVEL_VCUTM,
    ["COTMC"] = LEVEL_COTMC,
    ["WMOTR"] = LEVEL_WMOTR,
    ["BITDW"] = LEVEL_BITDW,
    ["BITFS"] = LEVEL_BITFS,
    ["BITS"] = LEVEL_BITS,
    ["HELL"] = LEVEL_HELL,
    ["SECRET"] = LEVEL_SECRETHUB,
    ["HUB"] = LEVEL_SECRETHUB,
}

function warp_command(msg)
    msg = string.upper(msg)
    if msgToLevel[msg] then
        warp_to_level(msgToLevel[msg], 1, 1)
    else
        djui_chat_message_create("ERROR: Tried warping to an invalid level!")
    end
    return true
end

hook_chat_command("warp", "level abreviation", warp_command)

hook_chat_command("end", "credits", function ()
	level_trigger_warp(gMarioStates[0], WARP_OP_CREDITS_START)
	return true
end)

hook_chat_command("go", "to", function ()
	vec3f_copy(gMarioStates[0].pos, {x=1992,y=-767,z=-1140})
	return true
end)

hook_chat_command("unlock", "trophy", function (msg)
	mod_storage_save("file"..get_current_save_file_num()..msg, "1")
	for id, trophy in pairs(trophyinfo) do
		if trophy.name == msg then
			gGlobalSyncTable.trophystatus[id] = true
			return true
		end
	end
end)

hook_chat_command("lock", "trophy", function (msg)
	mod_storage_save("file"..get_current_save_file_num()..msg, "0")
	for id, trophy in pairs(trophyinfo) do
		if trophy.name == msg then
			gGlobalSyncTable.trophystatus[id] = false
			return true
		end
	end
end)

hook_chat_command("hell", "HELL", function ()
	if network_is_server() and gGlobalSyncTable.hellenabled then
		djui_chat_message_create("Hell disabled.")
		gGlobalSyncTable.hellenabled = false
	elseif network_is_server() and gGlobalSyncTable.hellenabled == false then
		djui_chat_message_create("Hell enabled.")
		gGlobalSyncTable.hellenabled = true
	end
	--warp_to_level(LEVEL_HELL, 1, 0)
	return true
end)

local function default_level_func()
    set_lighting_color(0, 255)
    set_lighting_color(1, 255)
    set_lighting_color(2, 255)
    set_lighting_dir(1, 0)
    set_override_skybox(-1)
    set_override_envfx(-1)
    if savedCollisionBugStatus ~= nil then
        gLevelValues.fixCollisionBugs = savedCollisionBugStatus
        savedCollisionBugStatus = nil
    end
end

hook_event(HOOK_ON_LEVEL_INIT, function()
    local s = gStateExtras[0]
    local np = gNetworkPlayers[0]

    -- Stop music and samples when exiting levels
    if not s.iwbtg then
        stream_stop_all()
        stream_set_volume(1)
    end
    stop_all_samples()

	----------------------------------------------------------------------------------------------------------------------------------
	--Forces Mario to go to hell if he's anywhere but Hell while the variable is true. (Fixes Gameovers from spawning M to overworld)
	if gStateExtras[0].isinhell and np.currLevelNum ~= LEVEL_HELL and gGlobalSyncTable.hellenabled then
		gMarioStates[0].numLives = 0
		warp_to_level(LEVEL_HELL, 1, 0)
	end

    -- Execute level-specific actions
    local level_func = sOnLvlInitToFunc[np.currLevelNum]
    if level_func then
        level_func()
    else
        default_level_func()
    end
end)

local function level_init_spawns()
	local m = gMarioStates[0]
	local np = gNetworkPlayers[0]
	local gorrie = obj_get_first_with_behavior_id(id_bhvGorrie)
	if np.currLevelNum == LEVEL_JRB then
		if gorrie ~= nil then
			--djui_chat_message_create('dorrie exists')
		else
			--djui_chat_message_create('spawning dorrie')
			spawn_sync_object(id_bhvGorrie, E_MODEL_DORRIE, -5269, 1050, 3750, nil)
		end
	end
end

hook_event(HOOK_ON_SYNC_VALID, level_init_spawns)

hook_event(HOOK_ON_WARP, function()
    local m = gMarioStates[0]
    local np = gNetworkPlayers[0]
    local s = gStateExtras[m.playerIndex]

    if s.timeattack then
        s.timeattack = false
    end

    -- Execute the action based on the current level
    local level_func = sOnWarpToFunc[np.currLevelNum]
    if level_func then
        level_func()
    end
end)

--Disable mario's fire scream to make room for custom scream.
hook_event(HOOK_CHARACTER_SOUND, function(m, sound)
    local s = gStateExtras[m.playerIndex]
    local np = gNetworkPlayers[0]

    if sound == CHAR_SOUND_ON_FIRE then return 0 end

    local o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvPiranhaPlant)
    local in_hitbox = obj_check_hitbox_overlap(m.marioObj, o)

	if m.action == ACT_BURNING_JUMP or m.action == ACT_BURNING_GROUND or m.action == ACT_BURNING_FALL then
		if sound == CHAR_SOUND_PUNCH_YAH or sound == CHAR_SOUND_YAH_WAH_HOO then
			return 0
		end
	end

    if sound == CHAR_SOUND_ATTACKED and in_hitbox then return 0 end
    if sound == CHAR_SOUND_DYING and (s.headless or s.bottomless) then return 0 end
    if sound == CHAR_SOUND_WAAAOOOW and (m.action == ACT_THROWN_FORWARD or m.action == ACT_THROWN_BACKWARD) then return 0 end
    if check_trophyplate(m, np, sound) then return 0 end
end)