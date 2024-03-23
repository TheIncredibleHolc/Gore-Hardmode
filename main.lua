-- name: GORE / Hard-Mode! 
-- description: Gore and dismemberment! Made by IncredibleHolc and cooliokid956 (Great Kingdom Official), with additional help from Blocky.cmd and the community!


-------TESTING NOTES AND KNOWN BUGS-------------

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

--TTC Speed Increase
local realbhv = {
    [id_bhvTTC2DRotator] = bhv_ttc_2d_rotator_update,
    [id_bhvTTCCog]       = bhv_ttc_cog_update,
    [id_bhvTTCElevator]  = bhv_ttc_elevator_update,
    [id_bhvTTCMovingBar] = bhv_ttc_moving_bar_update,
    [id_bhvTTCPendulum]  = bhv_ttc_pendulum_update,
    [id_bhvTTCPitBlock]  = bhv_ttc_pit_block_update,
    [id_bhvTTCRotatingSolid] = bhv_ttc_rotating_solid_update,
    [id_bhvTTCSpinner]   = bhv_ttc_spinner_update,
    [id_bhvTTCTreadmill] = bhv_ttc_treadmill_update,
}

local fastbhv = {}

function speed_objs(o)
    if true then
        fastbhv[get_id_from_behavior(o.behavior)]()
    end
end

for bhv, func in pairs(realbhv) do
    fastbhv[hook_behavior(bhv, get_object_list_from_behavior(get_behavior_from_id(bhv)), false, nil, speed_objs, get_behavior_name_from_id(bhv))] = func
end

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GBEHAVIORVALUES -- Fast switches to manipulate the game.

--Turns off bubble death.
gServerSettings.bubbleDeath = false

--(BoB, THI, TTM) bowling balls faster
gBehaviorValues.BowlingBallTtmSpeed = 40
gBehaviorValues.BowlingBallThiSmallSpeed = 45
gBehaviorValues.BowlingBallThiSmallSpeed = 45


--Koopa the quick is STUPID fast. Player has to finish race in 20.9 seconds.
gBehaviorValues.KoopaBobAgility = 20
gBehaviorValues.KoopaThiAgility = 25
gBehaviorValues.KoopaCatchupAgility = 60

-- King bobomb health
gBehaviorValues.KingBobombHealth = 6

--Slide and Metal cap timers
gLevelValues.pssSlideStarTime = 570 -- 19 Seconds
gLevelValues.metalCapDuration = 90 -- 3 seconds, LOL.

-- Unlock JRB cannon
save_file_set_star_flags(get_current_save_file_num() - 1, COURSE_JRB, 0x80)

----helpers------

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
	if (m.controller.buttonPressed & D_JPAD) ~= 0 then
		local_play(sBoneBreak, m.pos, 1)
		m.numLives = 1
		set_mario_action(m, ACT_NECKSNAP, 0)
		--spawn_sync_if_main(id_bhvFlame, E_MODEL_RED_FLAME, m.pos.x + 100, m.pos.y, m.pos.z, nil, m.playerIndex)
		--spawn_sync_object(id_bhvLava, E_MODEL_LAVA, m.pos.x, m.waterLevel + 1, m.pos.z, function (o)
       --[[
		spawn_non_sync_object(id_bhvGrandStar, E_MODEL_STAR, m.pos.x, m.pos.y + 400, m.pos.z, function (o)
            o.oAction = 0
        end)
		]]
		--	end)
		--spawn_sync_object(id_bhvBowserBomb, E_MODEL_BOWSER_BOMB,  m.pos.x + 100, m.pos.y, m.pos.z, nil)
	end
	if (m.controller.buttonPressed & L_JPAD) ~= 0 then
		--warp_to_level(2, 1, 1)
		--spawn_non_sync_object(id_bhvLightning, E_MODEL_LIGHTNING, m.pos.x, m.pos.y + 350, m.pos.z, nil)

		--spawn_sync_object(id_bhvWingCap, E_MODEL_LUIGIS_WING_CAP, m.pos.x, m.pos.y, m.pos.z + 50, nil)
		spawn_non_sync_object(id_bhvStaticObject, E_MODEL_TROPHY_PODIUM, m.pos.x, m.floorHeight, m.pos.z, function(o)
			obj_scale(o, 0.2)
		end)
		
		--[[
		spawn_non_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, m.pos.x, m.pos.y, m.pos.z, function(o)
			o.oFaceAnglePitch = o.oFaceAnglePitch - 17000
		end)
		]]
		--spawn_non_sync_object(id_bhvSkybox1, E_MODEL_SKYBOX, m.pos.x, m.pos.y + 0, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvSkybox2, E_MODEL_SKYBOX2, m.pos.x, m.pos.y - 9500, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvSkybox2, E_MODEL_SKYBOX2, m.pos.x, m.pos.y + 500, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvSkybox1, E_MODEL_SKYBOX, m.pos.x, m.pos.y + 1000, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvSkybox2, E_MODEL_SKYBOX, m.pos.x, m.pos.y + 1500, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvSkybox1, E_MODEL_SKYBOX, m.pos.x, m.pos.y + 2000, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvSkybox2, E_MODEL_SKYBOX, m.pos.x, m.pos.y + 2500, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvSkybox1, E_MODEL_SKYBOX, m.pos.x, m.pos.y + 2800, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvSkybox2, E_MODEL_SKYBOX, m.pos.x, m.pos.y + 3400, m.pos.z, nil)
	end
	if (m.controller.buttonPressed & R_JPAD) ~= 0 then
		--spawn_non_sync_object(id_bhvGrandStarShadow, E_MODEL_GSSHADOW, m.pos.x, m.pos.y + 80, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvBubbleParticleSpawner, E_MODEL_BUBBLE, m.pos.x, m.pos.y + 80, m.pos.z, nil)
		--spawn_non_sync_object(id_bhvKoopaShell, E_MODEL_KOOPA_SHELL, m.pos.x, m.pos.y + 80, m.pos.z, nil)
		spawn_non_sync_object(id_bhvTrophy, E_MODEL_MARIO, m.pos.x + 300, m.pos.y + 50, m.pos.z, function (trophy)
			obj_scale(trophy, .2)
			trophy.oBehParams = 1 << 16
		end)
	end
	if (m.controller.buttonPressed & U_JPAD) ~= 0 then
		spawn_non_sync_object(id_bhvTrophy, E_MODEL_LUIGI, m.pos.x, m.pos.y + 350, m.pos.z, function (trophy)
			obj_scale(trophy, .2)
			trophy.oBehParams = 2 << 16
		end)
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


-----------Locals-------------
local TEX_MARIO_LESS_HIGH = get_texture_info('mariolesshigh')
local TEX_BLOOD_OVERLAY = get_texture_info('bloodoverlay')
local TEX_TRIPPY_OVERLAY = get_texture_info('trippy')

local TEX_PORTAL = get_texture_info("portal")

local TEX_DIRT = get_texture_info("grass_09004800")

------Variables n' stuff------

smlua_audio_utils_replace_sequence(SEQ_EVENT_CUTSCENE_ENDING, 35, 76, "gorepeach") --Custom Audio for end cutscene

LEVEL_HELL = level_register('level_hell_entry', COURSE_NONE, 'Hell', 'Hell', 28000, 0x28, 0x28, 0x28)
LEVEL_SECRETHUB = level_register('level_secretroom_entry', COURSE_NONE, 'Secret Hub', 'Secret Hub', 28000, 0x28, 0x28, 0x28)

E_MODEL_HIDDENFLAG = smlua_model_util_get_id("hiddenflag_geo")
E_MODEL_BLOOD_SPLATTER = smlua_model_util_get_id("blood_splatter_geo")
E_MODEL_BLOOD_SPLATTER2 = smlua_model_util_get_id("blood_splatter2_geo")
E_MODEL_BLOOD_SPLATTER_WALL = smlua_model_util_get_id("blood_splatter_wall_geo")
E_MODEL_GOLD_SPLAT = smlua_model_util_get_id("gold_splat_geo")
E_MODEL_SMILER = smlua_model_util_get_id("smiler_geo") --My dumbass reused this function without changing the name. This is NOT the backroom smiler. 
E_MODEL_SMILER2 = smlua_model_util_get_id("smiler2_geo") --This isn't it either.
E_MODEL_SMILER3 = smlua_model_util_get_id("smiler3_geo") --Also not this one...
E_MODEL_LAVA = smlua_model_util_get_id("lava_geo")
COL_LAVA = smlua_collision_util_get("lava_collision")
E_MODEL_SKYBOX = smlua_model_util_get_id("skybox_geo")
E_MODEL_SKYBOX2 = smlua_model_util_get_id("skybox2_geo")
E_MODEL_GSSHADOW = smlua_model_util_get_id("gsshadow_geo")
COL_GSSHADOW = smlua_collision_util_get("gsshadowcol_collision")
E_MODEL_LIGHTNING = smlua_model_util_get_id("lightning_geo")
E_MODEL_LIGHTNING2 = smlua_model_util_get_id("lightning2_geo")
E_MODEL_LIGHTNING3 = smlua_model_util_get_id("lightning3_geo")
E_MODEL_RING = smlua_model_util_get_id("ring_geo")
E_MODEL_GSCHARGE = smlua_model_util_get_id("gscharge_geo")
E_MODEL_GSBEAM = smlua_model_util_get_id("gsbeam_geo")
COL_GSBEAM = smlua_collision_util_get("gsbeamcol_collision")
E_MODEL_HEADLESSMARIO = smlua_model_util_get_id("headlessmario_geo")
E_MODEL_BOTTOMLESSMARIO = smlua_model_util_get_id("bottomlessmario_geo")
E_MODEL_HELLPLATFORM = smlua_model_util_get_id("hellplatform_geo")
COL_HELLPLATFORM = smlua_collision_util_get("hellplatform_collision")
E_MODEL_HELLTHWOMPER = smlua_model_util_get_id("hellthwomper_geo")
E_MODEL_BACKROOM = smlua_model_util_get_id("backroom_geo")
COL_BACKROOM = smlua_collision_util_get("backroom_collision")
E_MODEL_BLACKROOM = smlua_model_util_get_id("blackroom_geo")
COL_BLACKROOM = smlua_collision_util_get("blackroom_collision")
E_MODEL_BACKROOM_SMILER = smlua_model_util_get_id("backroom_smiler_geo")
COL_BACKROOM_SMILER = smlua_collision_util_get("backroom_smiler_collision") --The ACTUAL custom Smiler enemy in the backroom.
E_MODEL_NETHERPORTAL = smlua_model_util_get_id("netherportal_geo")
COL_NETHERPORTAL = smlua_collision_util_get("netherportal_collision")
E_MODEL_TROPHY_PODIUM = smlua_model_util_get_id("podium_geo")


smlua_text_utils_course_name_replace(COURSE_WDW, 'Dry world')
smlua_text_utils_course_name_replace(COURSE_JRB, 'Jolly Roger Hell')



gStateExtras = {}
for i = 0, MAX_PLAYERS-1 do
	gStateExtras[i] = {
		splatter = 1,
		flyingVel = 0,
		enablesplattimer = 0, --w
		splattimer = 0,
		jumpland = 0,
		disappear = 0,
		bigthrowenabled = 0, --w
		isdead = false,
		isinhell = false,
		stomped = false,
		headless = false,
		bottomless = false,
		disableuntilnextwarp = false,
		penguinholding = 0,
		penguintimer = 0,
		objtimer = 0,
		--isfalling = false,
		ishigh = 0,
		outsidegastimer = 60,
		highdeathtimer = 0,
		splatterdeath = 0, -- w
	}
end
toadguitimer = 0
ukikiheldby = -1
ukikiholding = 0
ukikitimer = 0
highalpha = 0
bloodalpha = 0
hallucinate = 0
portalalpha = 0
loadingscreen = 0

ACT_GONE = allocate_mario_action(ACT_GROUP_CUTSCENE|ACT_FLAG_STATIONARY|ACT_FLAG_INTANGIBLE|ACT_FLAG_INVULNERABLE)
function act_gone(m)
    m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags & ~GRAPH_RENDER_ACTIVE
	m.actionTimer = m.actionTimer + 1
	if m.actionTimer == m.actionArg then
		local savedY = m.pos.y
		common_death_handler(m, 0, -1)
		m.pos.y = savedY
	end
end
hook_mario_action(ACT_GONE, act_gone)

-----------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------
-----Custom Behaviors-----

function killer_exclamation_boxes(m) -- Makes exclamation boxes drop on top of you! (squishes)
	box = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvExclamationBox)

	if box ~= nil then
		if lateral_dist_between_objects(m.marioObj, box) < 50 and m.pos.y < box.oPosY and m.pos.y > box.oPosY - 400 then
			box.oPosY = box.oPosY - 100
		end
	end
end

--- @param o Object
local function bhv_red_flood_flag_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oInteractType = INTERACT_POLE
    o.hitboxRadius = 80
    o.hitboxHeight = 700
    o.oIntangibleTimer = 0

    cur_obj_init_animation(0)
end

--- @param o Object
local function bhv_red_flood_flag_loop(o)
    bhv_pole_base_loop()
end

id_bhvRedFloodFlag = hook_behavior(nil, OBJ_LIST_POLELIKE, true, bhv_red_flood_flag_init, bhv_red_flood_flag_loop)

function bhv_custom_kingwhomp(obj) -- makes king whomp give you quicksand
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

---@param bowsbomb Object
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
	local m = nearest_mario_state_to_object(obj)
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

	--if obj.oChainChompHitGate then
	--if obj.oChainChompReleaseStatus == CHAIN_CHOMP_RELEASED_JUMP_AWAY then
		--if obj.oMoveFlags & OBJ_MOVE_HIT_WALL then
		--obj_get_nearest_object_with_behavior_id(o, id_bhvChainChompGate)
		--if obj_check_if_collided_with_object(obj, o) ~= 0 then
		--if obj.oChainChompHitGate then


end

function bhv_custom_goomba_loop(obj) -- make goombas faster, more unpredictable. Will lunge at Mario
	local m = nearest_mario_state_to_object(obj)
	if obj.oGoombaJumpCooldown >= 9 then
		obj.oGoombaJumpCooldown = 8
		obj.oVelY = obj.oVelY + 10
		obj.oForwardVel = 70
	end
	obj.oHomeX = m.pos.x
	obj.oHomeY = m.pos.y
	obj.oHomeZ = m.pos.z

	if obj_has_model_extended(obj, E_MODEL_WOODEN_SIGNPOST) ~= 0 then
		if ia(m) and obj.oAction > 2 and obj.oTimer < 2 then
			cutscene_object_with_dialog(CUTSCENE_DIALOG, obj, obj.oBehParams)
		end
	end
end

function bhv_custom_thwomp(obj)
	local m = nearest_player_to_object(obj)
	local n = gNetworkPlayers[0]
	if n.currLevelNum ~= LEVEL_TTC then --TTC is excluded for flood as its nearly unbeatable. Giving the player mercy by turning it off in regular game mode too.	
		
		obj.oThwompRandomTimer = 0 --Instant falling

		if obj.oAction == 0 then --ARISE!!
			obj.oPosY = obj.oPosY + 15
			if obj.oTimer == math.random(5, 40) then
				obj.oAction = 1
			end
		end
		if obj.oAction == 3 then --EARTHQUAAAAKE
			cur_obj_shake_screen(SHAKE_POS_MEDIUM)
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
		obj.oForwardVel = obj.oForwardVel + 200
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

function bhv_bowser_key_spawn_ukiki(obj) --Spawns Ukiki for an annoying minigame. 
	spawn_sync_if_main(id_bhvUkiki, E_MODEL_UKIKI, obj.oPosX, obj.oPosY + 50, obj.oPosZ, function (o)
		o.oAction = 3
	end, 0)
	cur_obj_disable_rendering_and_become_intangible(obj)
	fadeout_music(0)
	stream_play(smwbonusmusic)
end

function bhv_bowser_key_ukiki_loop(obj)
	local o = obj_get_nearest_object_with_behavior_id(obj, id_bhvUkiki)
	if o ~= nil then
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

-------ACT_FUNCTIONS------------

function squishblood(o) -- Creates instant pool of impact-blood under mario.
	spawn_sync_if_main(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, o.oPosX, find_floor_height(o.oPosX, o.oPosY, o.oPosZ) + 2, o.oPosZ,
	function (obj)
		local z, normal = vec3f(), cur_obj_update_floor_height_and_get_floor().normal
		obj.oFaceAnglePitch = 16384-calculate_pitch(z, normal)
		obj.oFaceAngleYaw = calculate_yaw(z, normal)
	end, 0)
end

ACT_NECKSNAP = allocate_mario_action(ACT_GROUP_AUTOMATIC|ACT_FLAG_INVULNERABLE|ACT_FLAG_STATIONARY)

--Mario's neck snapping action.
function act_necksnap(m)
    common_death_handler(m, MARIO_ANIM_SUFFOCATING, 86)
	smlua_anim_util_set_animation(m.marioObj, "MARIO_NECKSNAP")
	m.actionTimer = m.actionTimer + 1
	if m.actionTimer == 1 then
		set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
	end
	--djui_chat_message_create(tostring(m.actionTimer))
end
hook_mario_action(ACT_NECKSNAP, act_necksnap)

--Electricutes the F out of Mario
function act_shocked(m)
	m.actionTimer = m.actionTimer + 1
	set_mario_animation(m, MARIO_ANIM_SHOCKED)
	if m.actionTimer % 2 == 0 then
		m.flags = m.flags | MARIO_METAL_SHOCK
	else
		m.flags = m.flags & ~(MARIO_METAL_SHOCK)
	end
	if (m.actionTimer) == 20 or (m.actionTimer) == 40 or (m.actionTimer) == 50 or (m.actionTimer) == 65 then
		m.particleFlags = PARTICLE_MIST_CIRCLE
	end
	if (m.actionTimer) >= 50 then
		m.marioBodyState.eyeState = MARIO_EYES_DEAD
	end
	if (m.actionTimer) == 75 or (m.actionTimer) == 82 or (m.actionTimer) == 90 or (m.actionTimer) == 95 or
	   (m.actionTimer) == 100 or (m.actionTimer) == 105 or (m.actionTimer) == 108 or (m.actionTimer) == 114 or
	   (m.actionTimer) == 118 or (m.actionTimer) == 121 or (m.actionTimer) == 124 or (m.actionTimer) == 127 or
	   (m.actionTimer) == 130 or (m.actionTimer) == 132 or (m.actionTimer) == 134 or (m.actionTimer) == 136 or (m.actionTimer) == 138 then
		m.particleFlags = PARTICLE_TRIANGLE|PARTICLE_MIST_CIRCLE
	end
	if (m.actionTimer) == 140 then
		m.particleFlags = PARTICLE_TRIANGLE
		m.squishTimer = 50
	end
end
hook_mario_action(ACT_SHOCKED, act_shocked)

--Mario is decapitated.
ACT_DECAPITATED = allocate_mario_action(ACT_GROUP_AUTOMATIC|ACT_FLAG_INVULNERABLE|ACT_FLAG_STATIONARY)
function act_decapitated(m)
	obj_set_model_extended(m.marioObj, E_MODEL_HEADLESSMARIO)
    common_death_handler(m, MARIO_ANIM_DYING_FALL_OVER, 80);

end
hook_mario_action(ACT_DECAPITATED, act_decapitated)

--Mario is bitten in half.
ACT_BITTEN_IN_HALF = allocate_mario_action(ACT_GROUP_AUTOMATIC|ACT_FLAG_INVULNERABLE|ACT_FLAG_STATIONARY)
function act_bitten_in_half(m)
	obj_set_model_extended(m.marioObj, E_MODEL_BOTTOMLESSMARIO)
    common_death_handler(m, MARIO_ANIM_SUFFOCATING, 86)
end
hook_mario_action(ACT_BITTEN_IN_HALF, act_bitten_in_half)





function splattertimer(m) --This timer is needed to prevent mario from immediately splatting again right after respawning. Adds some fluff to his death too.
	local s = gStateExtras[m.playerIndex]
	if (s.enablesplattimer) == 1 then
		s.splattimer = s.splattimer + 1
	end
	if (s.splattimer) == 2 then
		m.health = 120
		set_mario_action(m, ACT_THROWN_FORWARD, 0) --Throws mario forward more to "sell" the fall damage big impact.
		if (s.disappear) == 1 then --No fall damage, so Mario got squished. No corpse. It's funnier this way. 
			set_mario_action(m, ACT_GONE, 78)
			-- if not s.isdead and ia(m) then
			-- 	gGlobalSyncTable.deathcounter = gGlobalSyncTable.deathcounter + 1
			-- end
			-- s.isdead = true
		end
		if (s.disappear) == 1 then --Not a fall damage death, so cap won't fly as far. Works better since this is mostly triggered by enemies or objects smashing mario.
			mario_blow_off_cap(m, 15)
		else --Fall damage death means bigger impact, so hat is blown off more violently than above.
			mario_blow_off_cap(m, 45)
		end
		s.splattimer = s.splattimer + 1
	end

	--[[
	if (s.splattimer) == 14 then
		spawn_sync_if_main(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER2, m.pos.x, m.pos.y + 1, m.pos.z, nil, m.playerIndex)
	end
	]]
	if (s.splattimer) == 14 then
		spawn_sync_if_main(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER2, m.pos.x, find_floor_height(m.pos.x, m.pos.y, m.pos.z) + 2, m.pos.z,
		function (obj)
			local z, normal = vec3f(), cur_obj_update_floor_height_and_get_floor().normal
			obj.oFaceAnglePitch = 16384-calculate_pitch(z, normal)
			--obj.oFaceAngleYaw = calculate_yaw(z, normal)
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


function mario_update(m) -- ALL Mario_Update hooked commands.
	if is_player_active(m) == 0 then return end
	local n = gNetworkPlayers[0]
	local s = gStateExtras[m.playerIndex]

----------------------------------------------------------------------------------------------------------------------------------
	if n.currLevelNum == LEVEL_BBH then
		set_lighting_color(0,50)
		set_lighting_color(1,50)
		set_lighting_color(2,65)
		set_lighting_dir(1,128)
	end

----------------------------------------------------------------------------------------------------------------------------------
	if n.currLevelNum == LEVEL_WDW then --Wet/Dry world is now just dry world... LOL...
		set_environment_region(0, -10000)
		set_environment_region(1, -10000)
		set_environment_region(2, -10000)
		set_environment_region(3, -10000)
		local watercontrol = obj_get_first_with_behavior_id(id_bhvWaterLevelDiamond)
		while watercontrol do
			obj_mark_for_deletion(watercontrol)
			watercontrol = obj_get_next_with_same_behavior_id(watercontrol)
		end
	end

----------------------------------------------------------------------------------------------------------------------------------
	--Backroom Teleport

	--djui_chat_message_create(tostring(m.forwardVel))
	if n.currLevelNum == LEVEL_CASTLE and m.forwardVel < -120 and ia(m) then
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
	if m.action == ACT_FLYING or m.action == ACT_SHOT_FROM_CANNON then -- Makes flying gradually get FASTER!
		--djui_chat_message_create(tostring(m.forwardVel))
		m.forwardVel = m.forwardVel + 0.3
		s.flyingVel = m.forwardVel --This is to store Mario's last flying speed to check for splat-ability. 
	end
----------------------------------------------------------------------------------------------------------------------------------
	--(PSS Only) Faster sliding when picking up coins.

	if  m.action == ACT_BUTT_SLIDE and n.currLevelNum == LEVEL_PSS then
		m.slideVelX = m.slideVelX + m.numCoins * sins(m.faceAngle.y)
		m.slideVelZ = m.slideVelZ + m.numCoins * coss(m.faceAngle.y)
	end
----------------------------------------------------------------------------------------------------------------------------------
	-- BONKING DEATHS!!
	if m.action == ACT_BACKWARD_AIR_KB and s.flyingVel > 60 then -- Enables Mario to wall-splat when air-bonking objects.
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
	    end
	end

	--[[
	--djui_chat_message_create(tostring(m.floorHeight))
	if s.isFalling then --Makes mario fall funny to his death if he bonks a wall.
		if m.pos.y == m.floorHeight then
			m.squishTimer = 50	
			s.isFalling = false
		else
			m.faceAngle.z = m.faceAngle.z - 3000
			obj_set_gfx_angle(m.marioObj, m.faceAngle.z, m.faceAngle.x, m.faceAngle.y)
		end
	end
	]]

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
		fadeout_level_music(30*30)
		stream_play(highmusic)
		spawn_non_sync_object(id_bhvButterfly, E_MODEL_BUTTERFLY, m.pos.x, m.pos.y, m.pos.z, nil)
	end
	if ia(m) then
		if (s.highdeathtimer) == 200 or --Some butterflies start spawning around Mario.
		(s.highdeathtimer) == 400 or
		(s.highdeathtimer) == 600 or
		(s.highdeathtimer) == 700 or
		(s.highdeathtimer) == 800 or
		(s.highdeathtimer) == 900 or
		(s.highdeathtimer) == 1000 or
		(s.highdeathtimer) == 1100 or
		(s.highdeathtimer) == 1200 then
			spawn_non_sync_object(id_bhvButterfly, E_MODEL_BUTTERFLY, m.pos.x + 5, m.pos.y - 5, m.pos.z + 5, nil)
			spawn_non_sync_object(id_bhvButterfly, E_MODEL_BUTTERFLY, m.pos.x, m.pos.y, m.pos.z, nil)
		end
		if (s.highdeathtimer) == 100 or --Spawns occasional coins spawn to keep Mario alive
		(s.highdeathtimer) == 300 or
		(s.highdeathtimer) == 500 or
		(s.highdeathtimer) == 700 or
		(s.highdeathtimer) == 900 or
		(s.highdeathtimer) == 1100 or
		(s.highdeathtimer) == 1200 then
			local randommodel = math.random(3)
			if (randommodel == 1) then
				spawn_non_sync_object(id_bhvMrIBlueCoin, E_MODEL_SMILER, m.pos.x, m.pos.y, m.pos.z, nil)
			elseif (randommodel == 2) then
				spawn_non_sync_object(id_bhvMrIBlueCoin, E_MODEL_SMILER2, m.pos.x, m.pos.y, m.pos.z, nil)
			elseif (randommodel == 3) then
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

----------------------------------------------------------------------------------------------------------------------------------
	--Mario Disintegrates when on fire
	if m.action == ACT_BURNING_JUMP or m.action == ACT_BURNING_GROUND or m.action == ACT_BURNING_FALL then
		if m.usedObj then
			cur_obj_shake_screen(SHAKE_POS_SMALL)
			--set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
			obj_scale(m.usedObj, 6)
			obj_copy_pos(m.usedObj, m.marioObj)
			m.usedObj.oGraphYOffset = 100
			m.marioObj.oMarioBurnTimer = 1
		end

		if (m.health <= 300) then
			m.squishTimer = 50
			audio_sample_stop(gSamples[sAgonyMario])
			audio_sample_stop(gSamples[sToadburn]) --Stops Mario's super long scream
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
	n = gNetworkPlayers[0]
	if n.currLevelNum == LEVEL_HELL and m.marioObj.oTimer == 28 then
		if ia(m) then
			cutscene_object_with_dialog(CUTSCENE_DIALOG, m.marioObj, DIALOG_008)
		end
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

	if m.heldObj ~= nil and (obj_has_behavior_id(m.heldObj, id_bhvUkiki) ~= 0) then
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
	if (o) ~= nil then
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
	if (o) ~= nil then
		if mario_is_within_rectangle(o.oPosX - 250, o.oPosX + 250, o.oPosZ - 250, o.oPosZ + 250) ~= 0 then
			obj_mark_for_deletion(o)
		end
	end

	----This is a 2x2 (4-square) type platform that sinks, not the individual tiles.
	o = obj_get_nearest_object_with_behavior_id(o, id_bhvLllSinkingSquarePlatforms)
	if (o) ~= nil then
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
			--spawn_triangle_break_particles(30, 138, 1, 4)
			play_sound(SOUND_ACTION_BONK, m.marioObj.header.gfx.cameraToObject)
			s.penguinholding = 0
			s.penguintimer = 0
	end

----------------------------------------------------------------------------------------------------------------------------------
	--Fast and Killable Klepto
	klepto = obj_get_nearest_object_with_behavior_id(o, id_bhvKlepto)
	if klepto ~= nil then
		klepto.oKleptoSpeed = 120.0
		if (klepto.oAction == KLEPTO_ACT_STRUCK_BY_MARIO) then
			squishblood(klepto)
			local_play(sSplatter, m.pos, 1)
			play_sound(SOUND_OBJ_KLEPTO1, m.pos)
			obj_mark_for_deletion(klepto)
		end
	end
----------------------------------------------------------------------------------------------------------------------------------
	--Bowser 3 battle (epic battle) EnvFX Fix.
	--[[
	if n.currLevelNum == LEVEL_BOWSER_3 or n.currLevelNum == LEVEL_JRB then
		set_override_envfx(ENVFX_LAVA_BUBBLES)
	else
		set_override_envfx(-1)
	end	
]]



end

function mariohitbyenemy(m) -- Default and generic 1-hit death commands.
if (m.hurtCounter > 0) then
	local s = gStateExtras[m.playerIndex]

	-- Air Insta-Kill Mario (jumping into enemy like Chain Chomp. Mario's fault, not a chain chomp attack)
	if (m.action == ACT_FORWARD_AIR_KB or m.action == ACT_BACKWARD_AIR_KB) then
		m.health = 0xff
	end

	-- Air Insta-Kill Mario (Generic hits, mario pvp air kicks, etc..)
	if (m.action == ACT_HARD_FORWARD_AIR_KB) then
		m.forwardVel = 1150
		m.health = 0xff
	end
	if (m.action == ACT_HARD_BACKWARD_AIR_KB) then
		m.forwardVel = -1150
		m.health = 0xff
	end


	-- BIG fall insta-kill (Falling from REALLY high)
	if (m.action == ACT_HARD_BACKWARD_GROUND_KB) then
		--m.health = 0xff
		m.squishTimer = 50
	end
	if (m.action == ACT_HARD_FORWARD_GROUND_KB) then
		--m.health = 0xff
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
		spawn_sync_if_main(id_bhvWhitePuffExplosion, E_MODEL_WHITE_PUFF, o.oPosX, m.floorHeight + 50, o.oPosZ, nil, m.playerIndex)
		spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, m.floorHeight + 50, o.oPosZ, nil, m.playerIndex)
		squishblood(o)
		obj_mark_for_deletion(o)
		local_play(sSplatter, m.pos, 1)
		local_play(sKillYoshi, m.pos, 1)
	end

	--Custom Bully necksnap
	if obj_has_behavior_id(o, id_bhvSmallBully) ~= 0 and (m.action == ACT_SOFT_FORWARD_GROUND_KB or m.action == ACT_SOFT_BACKWARD_GROUND_KB) then
		network_play(sBoneBreak, m.pos, 1, m.playerIndex)
		set_mario_action(m, ACT_NECKSNAP, 0)
	end

	--[[ This doesnt work and I have no clue why. 
	--Ferris wheel platform disappears after 1 second
	if obj_has_behavior_id(o, id_bhvFerrisWheelPlatform) ~= nil then
		s.objtimer = s.objtimer + 1
		if (s.objtimer) == 30 then 
			obj_mark_for_deletion(o)
		end
	end
	]]

	--Custom bobomb buddy explosions
	if obj_has_behavior_id(o, id_bhvBobombBuddy) ~= 0 then
		spawn_sync_object(id_bhvExplosion, E_MODEL_EXPLOSION, o.oPosX, o.oPosY, o.oPosZ, nil)
		obj_mark_for_deletion(o)
	end

	--Snowman's head insta-kill
	if obj_has_behavior_id(o, id_bhvSnowmansBottom) ~= 0 then
		m.squishTimer = 50
	end

	--(HMC) Boulder insta-kill
	if obj_has_behavior_id(o, id_bhvBigBoulder) ~= 0 then
		m.squishTimer = 50
	end

	--[[ --Doesnt work. Causes every object to get destroyed.
	if obj_has_behavior_id(o, id_bhvWfSlidingTowerPlatform) then
		spawn_triangle_break_particles(30, 138, 1, 4)
		play_sound(SOUND_ACTION_HIT_2, m.marioObj.header.gfx.cameraToObject)
		obj_mark_for_deletion(o)
	end
	]]
	--Killable Dorrie?
	if obj_has_behavior_id(o, id_bhvDorrie) ~= 0 and (m.action & ACT_GROUND_POUND) ~= 0 then
		local_play(sSplatter, m.pos, 1)
		squishblood(o)
		obj_mark_for_deletion(o)
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

	--Custom bullet bill boom
	if obj_has_behavior_id(o, id_bhvBulletBill) ~= 0 and (m.hurtCounter > 0) then
		spawn_sync_if_main(id_bhvExplosion, E_MODEL_BOWSER_FLAMES, m.pos.x, m.pos.y, m.pos.z, nil, m.playerIndex)
	end

	if m.character.type == CT_MARIO and (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvPiranhaPlant) ~= 0 and not s.headless then
		s.headless = true
		network_play(sSplatter, m.pos, 1, m.playerIndex)
		network_play(sCrunch, m.pos, 1, m.playerIndex)
		squishblood(m.marioObj)
		m.health = 0xff
		set_mario_action(m, ACT_DECAPITATED, 0)
	elseif m.character.type ~= CT_MARIO and (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvPiranhaPlant) ~= 0 then
		m.squishTimer = 50
	end


	if (m.hurtCounter > 0) and
		obj_has_behavior_id(o, id_bhvExplosion) + -- Custom Bobomb explosion Mario death
		obj_has_behavior_id(o, id_bhvPitBowlingBall) + -- (BoB) Custom pit bowling ball death 
		obj_has_behavior_id(o, id_bhvGoomba) + -- Custom Goomba Mario Kill
		--obj_has_behavior_id(o, id_bhvPiranhaPlant) + -- Custom Piranha Plant death
		obj_has_behavior_id(o, id_bhvSpindrift) + -- twirling guys insta-death
		obj_has_behavior_id(o, id_bhvMrBlizzard) + -- Mr.Blizzard insta-death
		obj_has_behavior_id(o, id_bhvHauntedChair) + -- Evil chair insta-death
		obj_has_behavior_id(o, id_bhvWaterBomb) ~= 0 -- cannon bubble insta-death
	or (
		obj_has_behavior_id(o, id_bhvBowserBodyAnchor) ~= 0
		and (o.parentObj.oAction == 4 or o.parentObj.oAction == 12)
		and o.parentObj.oVelY < -40
	) then
		m.squishTimer = 50
	end

	if (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvMadPiano) ~= 0 then
		if m.character.type == CT_MARIO or m.character.type == CT_LUIGI then
			s.bottomless = true
			network_play(sSplatter, m.pos, 1, m.playerIndex)
			network_play(sCrunch, m.pos, 1, m.playerIndex)
			squishblood(m.marioObj)
			m.health = 0xff
			mario_blow_off_cap(m, 15)
			set_mario_action(m, ACT_BITTEN_IN_HALF, 0)
			cur_obj_become_intangible()
			m.hurtCounter = 0
		else
			m.squishTimer = 50
		end
	end
	
	-- Custom shocking amp Kill
	if obj_has_behavior_id(o, id_bhvCirclingAmp) ~= 0 and (m.hurtCounter > 0) then
		if not floodenabled then
			--m.health = 120 
		end
	end
	

	-- Custom FlyGuy insta-death
	if obj_has_behavior_id(o, id_bhvFlyGuy) ~= 0 and (m.hurtCounter > 0) then
		m.squishTimer = 50
	end

	-- Bowling Ball insta-death
	if obj_has_behavior_id(o, id_bhvBowlingBall) ~= 0 and (m.hurtCounter > 0) then
		if (m.action == ACT_JUMP) or (m.action == ACT_DOUBLE_JUMP) or (m.action == ACT_JUMP_KICK) or (m.action == ACT_HOLD_JUMP) or (m.action == ACT_LONG_JUMP) then
		else
			m.squishTimer = 50
		end
	end

	-- Snowman Snowball insta-death
	if obj_has_behavior_id(o, id_bhvSnowBall) ~= 0 and (m.hurtCounter > 0) then 
		spawn_sync_if_main(id_bhvExplosion, E_MODEL_EXPLOSION, m.pos.x, m.pos.y, m.pos.z, nil, m.playerIndex)
	end

	--Chain Chomp insta-deaths
	if obj_has_behavior_id(o, id_bhvChainChomp) ~= 0 and not s.bottomless and (m.hurtCounter > 0) and (m.action == ACT_BACKWARD_GROUND_KB or m.action == ACT_FORWARD_GROUND_KB) then --Custom Chain Chomp Mario Kill backward
		if m.character.type == CT_MARIO then
			s.bottomless = true
			network_play(sSplatter, m.pos, 1, m.playerIndex)
			network_play(sCrunch, m.pos, 1, m.playerIndex)
			squishblood(m.marioObj)
			m.health = 0xff
			mario_blow_off_cap(m, 15)
			set_mario_action(m, ACT_BITTEN_IN_HALF, 0)
		else
			m.squishTimer = 50
			m.particleFlags = PARTICLE_MIST_CIRCLE
			set_mario_action(m, ACT_GONE, 80)
		end
	end

	--Big bully kill mario
	if obj_has_behavior_id(o, id_bhvBigBully) ~= 0 and (m.action == ACT_SOFT_FORWARD_GROUND_KB or m.action == ACT_SOFT_BACKWARD_GROUND_KB) then
		m.squishTimer = 50
	end

end

function before_mario_action(m, action)
	local s = gStateExtras[m.playerIndex]
	local n = gNetworkPlayers[0]
-------------------------------------------------------------------------------------------------------------------------------------------------
	--Disables LAVA_BOOST and replaces with a splash and insta-death... KERPLUNK!!
	if (action == ACT_LAVA_BOOST) and n.currLevelNum ~= LEVEL_SL then
		set_mario_action(m, ACT_GONE, 1)
		network_play(sSplash, m.pos, 1, m.playerIndex)
		spawn_sync_if_main(id_bhvBowserBombExplosion, E_MODEL_BOWSER_FLAMES, m.pos.x, m.pos.y, m.pos.z, nil, m.playerIndex)
		m.health = 120
		return 1
	end

	--If lava boosted from ice, insta-kill Mario
	if (action == ACT_LAVA_BOOST) and n.currLevelNum == LEVEL_SL then
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
			elseif m.character.type == CT_TOAD then
				network_play(sToadburn, m.pos, 1, m.playerIndex)
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
		squishblood(m.marioObj)

	elseif m.action == ACT_SHOCKED then -- play shock sounds
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
	audio_sample_stop(gSamples[sToadburn]) --Stops Toad's super long scream

	--set_override_envfx(ENVFX_MODE_NONE)
	stream_fade(50) --Stops the Hazy Maze Cave custom music after death. Stops the ukiki minigame music if Mario falls to death. 
	if not s.isdead and not s.disableuntilnextwarp then
		gGlobalSyncTable.deathcounter = gGlobalSyncTable.deathcounter + 1
		s.isdead = true
	end
end

function marioalive() -- Resumes the death counter to accept death counts. 
	local s = gStateExtras[0]
	local n = gNetworkPlayers[0]
	local m = gMarioStates[0]
	audio_sample_stop(gSamples[sAgonyMario]) --Stops Mario's super long scream
	audio_sample_stop(gSamples[sToadburn]) --Stops Toad's super long scream

	hud_show()

	s.isdead = false --Mario is alive
	s.disableuntilnextwarp = false --Enables death counter
	s.headless = false --Gives Mario his head back
	s.bottomless = false --Gives Mario his whole upper body back

	if n.currLevelNum == LEVEL_TTM then
		m.pos.y = m.pos.y + 320
	end

	if m.numLives <= 0 and not s.isinhell then
		s.isinhell = true
		warp_to_level(LEVEL_HELL, 1, 0)
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
		toadguitimer = 150
	end
end

function hud_render() -- Displays the total amount of mario deaths a server has incurred since opening. 
	local s = gStateExtras[0]
	local m = gMarioStates[0]
	local n = gNetworkPlayers[0]
	if m.floor and m.floor.object and obj_has_behavior_id(m.floor.object, id_bhvBackroom) ~= 0 then return end

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

	local n = gNetworkPlayers[0]


	if not ia(m) then return end

	local obj = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhv1Up)
    if obj and n.currLevelNum ~= LEVEL_HELL and nearest_interacting_mario_state_to_object(obj).playerIndex == 0 and mario_is_within_rectangle(obj.oPosX - 200, obj.oPosX + 200, obj.oPosZ - 200, obj.oPosZ + 200) ~= 0 and m.pos.y > obj.oPosY - 200 and m.pos.y < obj.oPosY + 200 then --if local mario is touching 1up then
		spawn_sync_object(id_bhvWhitePuff1, E_MODEL_WHITE_PUFF, obj.oPosX, obj.oPosY, obj.oPosZ, nil)
		obj_mark_for_deletion(obj)
		local_play(sFart, m.pos, 1)
    end

	local demon = obj_get_nearest_object_with_behavior_id(m.marioObj,id_bhvHidden1upInPole) -- HAS ISSUES WITH CASTLE BRIDGE DEMON
    if n.currLevelNum ~= LEVEL_HELL and demon and nearest_interacting_mario_state_to_object(demon).playerIndex == 0 and is_within_100_units_of_mario(demon.oPosX, demon.oPosY, demon.oPosZ) == 1 then --if local mario is touching 1up then
		obj_mark_for_deletion(demon)
		local_play(sFart, m.pos, 1)
    end
end



---------hooks--------
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_MARIO_UPDATE, modsupport)
hook_event(HOOK_MARIO_UPDATE, killer_exclamation_boxes)
hook_event(HOOK_MARIO_UPDATE, testing)
hook_event(HOOK_MARIO_UPDATE, mariohitbyenemy)
hook_event(HOOK_MARIO_UPDATE, splattertimer)
---@param m MarioState
hook_event(HOOK_BEFORE_MARIO_UPDATE, function (m) -- mario high
local s = gStateExtras[m.playerIndex]
if (s.ishigh) == 1 then
    if m.input & INPUT_NONZERO_ANALOG ~= 0 then
		local range = 12288
        local t = m.marioObj.oTimer/50
        local angle = atan2s(m.controller.stickY, m.controller.stickX)
        local woowoo = math.sin(2 * t) + math.sin(math.pi * t)

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



-------------PvP HOOKS-------------

--Custom PvP
hook_event(HOOK_ON_PVP_ATTACK, function (attacker, victim)
	local s = gStateExtras[victim.playerIndex]

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
	end

	--Tripping
	if attacker.action == ACT_SLIDE_KICK then
		--local_play(sBoneBreak, victim.pos, 1) --Doesn't play consistently and I don't know why. Sometimes none, sometimes doubles. Probably not even a good sound for this anyway.
		set_mario_action(victim, ACT_GROUND_BONK, 0)
	end

	--Neck snapping
	if attacker.action == ACT_DIVE then
		local_play(sBoneBreak, victim.pos, 1)
		set_mario_action(victim, ACT_NECKSNAP, 0)
	end



end)

function lava_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = COL_LAVA
	o.oCollisionDistance = 10000
    o.header.gfx.skipInViewCheck = true
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

---@param o Object
---@return Vec3f
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
		if m.character.type == CT_MARIO or m.character.type == CT_LUIGI then
			s.bottomless = true
			network_play(sSplatter, m.pos, 1, m.playerIndex)
			network_play(sCrunch, m.pos, 1, m.playerIndex)
			audio_sample_stop(gSamples[sSmiler])
			squishblood(m.marioObj)
			m.health = 0xff
			mario_blow_off_cap(m, 15)
			set_mario_action(m, ACT_BITTEN_IN_HALF, 0)
			obj_mark_for_deletion(o)
		else
			m.squishTimer = 50
			m.particleFlags = PARTICLE_MIST_CIRCLE
			set_mario_action(m, ACT_GONE, 80)
			obj_mark_for_deletion(o)
		end
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

--[[
function bhv_custom_1up(o)
	m = nearest_mario_state_to_object(o)
	if is_within_100_units_of_mario(o.oPosX, o.oPosY, o.oPosZ) == 1 then
		obj_mark_for_deletion(o)
		spawn_mist_particles()
		local_play(sFart, o.header.gfx.pos, 1)
	end
end
]]

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

---@param o Object
function bhv_custom_tuxie(o)
	if o.oAction == 6 then
		if o.oTimer == 0 then
			o.oGravity = -2
			o.oForwardVel = 25
			o.oVelY = 75
		end
		o.oFaceAnglePitch = o.oFaceAnglePitch + 7500
		cur_obj_move_standard(-78)
		if o.oMoveFlags & OBJ_MOVE_LANDED ~= 0 then
			if o.oFloor.type ~= SURFACE_DEATH_PLANE then
				squishblood(o)
				local_play(sSplatter, o.header.gfx.pos, 1)
			end
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

--------------------------------------------------------------------------------------------------------------------------------
--Big Boo's Haunt

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

-------Behavior Hooks-------
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
--hook_behavior(id_bhvYellowCoin, OBJ_LIST_LEVEL, false, nil, bhv_custom_coins)
--hook_behavior(id_bhvOneCoin, OBJ_LIST_LEVEL, false, nil, bhv_custom_coins)
--hook_behavior(id_bhvMovingYellowCoin, OBJ_LIST_LEVEL, false, nil, bhv_custom_coins)
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
hook_behavior(id_bhvBowserKey, OBJ_LIST_LEVEL, false, bhv_bowser_key_spawn_ukiki, bhv_bowser_key_ukiki_loop)
id_bhvNetherPortal = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_netherportal_init, bhv_netherportal_loop, "bhvNetherPortal")
id_bhvBackroomSmiler = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_backroom_smiler_init, bhv_backroom_smiler_loop, "bhvBackroomSmiler")
id_bhvBackroom = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_backroom_init, bhv_backroom_loop, "bhvBackroom")
id_bhvHellPlatform1 = hook_behavior(nil, OBJ_LIST_SURFACE, true, bhv_hellplatform_init, bhv_hellplatform_loop, "bhvHellPlatform1")
id_bhvLava = hook_behavior(nil, OBJ_LIST_SURFACE, true, lava_init, lava_loop, "bhvLava")



-- test function to warp to level, disable if necessary
hook_chat_command("bow", "ser", function ()
	warp_to_level(LEVEL_BOWSER_3, 1, 1)
	return true
end)

hook_chat_command("wf", "whomp", function ()
	warp_to_level(LEVEL_WF, 1, 0)
	return true
end)

hook_chat_command("hmc", "haz", function ()
	warp_to_level(LEVEL_HMC, 1, 0)
	return true
end)

hook_chat_command("lll", "lava", function ()
	warp_to_level(LEVEL_LLL, 1, 0)
	return true
end)

hook_chat_command("ssl", "shift", function ()
	warp_to_level(LEVEL_SSL, 1, 0)
	return true
end)

hook_chat_command("bob", "bobomb", function ()
	warp_to_level(LEVEL_BOB, 1, 0)
	return true
end)

hook_chat_command("jrb", "jolly", function ()
	warp_to_level(LEVEL_JRB, 1, 0)
	return true
end)

hook_chat_command("ttc", "tick", function ()
	warp_to_level(LEVEL_TTC, 1, 0)
	return true
end)

hook_chat_command("rr", "rainbow", function ()
	warp_to_level(LEVEL_RR, 1, 0)
	return true
end)

hook_chat_command("ccm", "cool", function ()
	warp_to_level(LEVEL_CCM, 1, 0)
	return true
end)

hook_chat_command("wdw", "wet", function ()
	warp_to_level(LEVEL_WDW, 1, 0)
	return true
end)

hook_chat_command("bbh", "boo", function ()
	warp_to_level(LEVEL_BBH, 1, 0)
	return true
end)

hook_chat_command("hell", "hell", function ()
	warp_to_level(LEVEL_HELL, 1, 0)
	return true
end)

hook_chat_command("secret", "hub", function ()
	warp_to_level(LEVEL_SECRETHUB, 1, 0)
	return true
end)

hook_chat_command("end", "credits", function ()
	level_trigger_warp(gMarioStates[0], WARP_OP_CREDITS_START)
	return true
end)

hook_chat_command("go", "to", function ()
	vec3f_copy(gMarioStates[0].pos, {x=1992,y=-767,z=-1140})
	return true
end)

hook_chat_command("unlock", "trophy", function (msg)
	mod_storage_save(msg, "1")
	return true
end)

hook_chat_command("lock", "trophy", function (msg)
	mod_storage_save(msg, "0")
	return true
end)

-- to make ukiki jump from the key
hook_behavior(id_bhvUkiki, OBJ_LIST_GENACTOR, false, function (obj)
	obj.oPosY = obj.oHomeY
end, nil)

hook_event(HOOK_ON_LEVEL_INIT, function ()
	--Stop music when exiting levels
	stream_stop_all()
	stream_set_volume(1)
	stop_all_samples()
	local np = gNetworkPlayers[0]

	----------------------------------------------------------------------------------------------------------------------------------
	--Forces Mario to go to hell if he's anywhere but Hell while the variable is true. (Fixes Gameovers from spawning M to overworld)
	if gStateExtras[0].isinhell and np.currLevelNum ~= LEVEL_HELL then
		gMarioStates[0].numLives = 0
		warp_to_level(LEVEL_HELL, 1, 0)
	end

	if np.currLevelNum == LEVEL_HELL then
		set_lighting_color(0,255)
		set_lighting_color(1,127)
		set_lighting_color(2,100)
		set_lighting_dir(1,-128)
		stream_play(musicHell)
	else
		set_lighting_color(0, 255)
		set_lighting_color(1, 255)
		set_lighting_color(2, 255)
		set_lighting_dir(1,0)
	end

	if np.currLevelNum == LEVEL_JRB or np.currLevelNum == LEVEL_HELL then
		set_override_envfx(ENVFX_LAVA_BUBBLES)
		gLevelValues.fixCollisionBugs = true
	else
		set_override_envfx(-1)
		gLevelValues.fixCollisionBugs = false
	end

	if np.currLevelNum == LEVEL_TTC then
		--set_ttc_speed_setting(-5)
	end
end)

--Blocky looky here
hook_event(HOOK_ON_WARP, function ()
	local m = gMarioStates[0]
	local np = gNetworkPlayers[0]
	if np.currLevelNum == LEVEL_JRB and np.currAreaIndex == 1 then --Spawns lava over water, unless inside the pirate ship. 
		spawn_non_sync_object(id_bhvLava, E_MODEL_LAVA, m.pos.x, 1050, m.pos.z, function (o)
			--obj_scale(o, 4)
		end)
		local o = obj_get_first_with_behavior_id(id_bhvCannonClosed)
		o.oPosY = o.oPosY + 21
	end
	if np.currLevelNum == LEVEL_HELL then
		m.health = m.health + 2048
		area_get_warp_node(0x01).node.destLevel = LEVEL_HELL
		area_get_warp_node(0x02).node.destLevel = LEVEL_HELL
	end
	if np.currLevelNum == LEVEL_SECRETHUB then
		if np.currAreaIndex == 1 then
			stream_play(secret)
		elseif np.currAreaIndex == 2 and currentlyPlaying ~= musicUnderground then
			stream_play(musicUnderground)
		end
	end
end)

--Disable mario's fire scream to make room for custom scream.
hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
	local s = gStateExtras[m.playerIndex]
	if sound == CHAR_SOUND_ON_FIRE then return 0 end

	local o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvPiranhaPlant)
	if sound == CHAR_SOUND_ATTACKED and obj_check_hitbox_overlap(m.marioObj, o) then return 0 end

	if sound == CHAR_SOUND_DYING and (s.headless or s.bottomless) then return 0 end
end)