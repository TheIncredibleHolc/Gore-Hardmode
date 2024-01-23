------------------------------------------------------------------------------
--Helper:
function testing(m)
    if (m.controller.buttonPressed & U_JPAD) ~= 0 then
        spawn_non_sync_object(id_bhvStarMinions, E_MODEL_STAR, m.pos.x, m.pos.y + 3500, m.pos.z, function (obj)
            obj.oAction = STAR_MINION_ACT_FALL
        end)
    end
end

------------------------------------------------------------------------------
function custom_bowser(obj)
	local m = gMarioStates[0]
	if (m.controller.buttonPressed & U_JPAD) ~= 0 then
		obj.oHealth = obj.oHealth - 1
	end
    if obj.oBehParams2ndByte == 2 then
        obj.oHealth = 1
    end
	if obj.oBehParams2ndByte == 2 then
        --[[   --Enables bowser to be splattered against bomb.
		if obj.oHealth <= 0 then
			squishblood(obj)
			local_play(sSplatter, m.pos, 1)
			obj_mark_for_deletion(obj)
			fadeout_level_music(100)
			--play_music(0, SEQ_EVENT_CUTSCENE_ENDING, 0)
			spawn_sync_object(id_bhvGrandStar, E_MODEL_STAR, -2.4, 350, -46, function (o)
                o.oAction = 0
            end)
		end
        ]]
	end
    --obj_mark_for_deletion(obj) --Enable this for faster testing
end

hook_behavior(id_bhvBowser, OBJ_LIST_GENACTOR, false, nil, custom_bowser)



GRAND_STAR_ACT_INTRO = 0
GRAND_STAR_ACT_GO_HOME = 1
GRAND_STAR_ACT_SHOCKWAVE = 2
GRAND_STAR_ACT_FALLING_MINIONS = 3
GRAND_STAR_ACT_VULNERABLE = 4

GRAND_STAR_SUB_ACT_NONE = 0
GRAND_STAR_SUB_ACT_SUMMON_MINIONS = 1
GRAND_STAR_ATTACK_SELECT = 6
GRAND_STAR_SHOOTING = 7
numBombMinions = 5

STAR_MINION_ACT_SHOCKWAVE = 0
STAR_MINION_ACT_FALL = 1

--E_MODEL_CASTLE = smlua_model_util_get_id("castle_geo")
--E_MODEL_BOB = smlua_model_util_get_id("bob_geo")
--E_MODEL_WMOTR = smlua_model_util_get_id("wmotr_geo")

define_custom_obj_fields({
    oJumpCounter = "u32",
    oMinionsSummoned = "u32"
})

function obj_move(o)
    cur_obj_update_floor_and_walls()
    cur_obj_move_using_fvel_and_gravity()
end

function obj_change_action(o, action)
    o.oAction = action
    o.oTimer = 0
    o.oForwardVel = 0
    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    o.oFaceAngleYaw = 0
    o.oJumpCounter = -1
    o.oGravity = -4
    o.oSubAction = 0
end


function grand_star_init(o)
    local m = gMarioStates[0]

    gLakituState.mode = CAMERA_MODE_BOSS_FIGHT
    obj_set_secondary_camera_focus()
    gCutsceneFocus = o
    gSecondCameraFocus = o



    o.oFlags = (OBJ_FLAG_MOVE_XZ_USING_FVEL | OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.oInteractType = INTERACT_DAMAGE
    spawn_non_sync_object(id_bhvLava, E_MODEL_LAVA, 0, 0, 0, nil)
    set_override_envfx(ENVFX_LAVA_BUBBLES)
    --spawn_non_sync_object(id_bhvGrandStarShadow, E_MODEL_GSSHADOW, o.oPosX, 250, o.oPosY, nil) 
    spawn_non_sync_object(id_bhvSkybox2, E_MODEL_SKYBOX2, 0, m.pos.y - 9500, 0, nil)
    spawn_non_sync_object(id_bhvSkybox2, E_MODEL_SKYBOX2, 0, m.pos.y + 500, 0, nil)
    spawn_non_sync_object(id_bhvLightning, E_MODEL_LIGHTNING, o.oPosX, o.oPosY + 550, o.oPosZ, nil)
    --spawn_non_sync_object(id_bhvStaticObject, E_MODEL_RING, 0, m.pos.y - 300, 0, function(obj)
    --    obj_scale(obj, 0.6)
    --    obj.header.gfx.skipInViewCheck = true
    --end)

    --[[
    spawn_non_sync_object(id_bhvStaticObject, E_MODEL_LIGHTNING, o.oPosX, o.oPosY + 200, o.oPosZ, function (obj)
		vec = {x=obj.oPosX, y=obj.oPosY, z=obj.oPosZ}
		local yaw = calculate_yaw(vec, gLakituState.pos)
		--djui_popup_create(tostring(yaw), 1)
		obj.oFaceAngleYaw = yaw + -20000
		if (obj.oTimer) >= 2 then
			obj_mark_for_deletion(obj)
		end
	end)
    ]]


    local_play(sThunder, gMarioStates[0].marioObj.header.gfx.cameraToObject, 1);
    audio_stream_play(boss, true, 1)

    o.hitboxRadius = 160
    o.hitboxHeight = 100
    o.oWallHitboxRadius = 30
    o.oGravity = -4
    o.oBounciness = 0

    o.oIntangibleTimer = 0

    o.oMoveFlags = o.oMoveFlags | OBJ_MOVE_IN_AIR

    o.oHomeX = o.oPosX
    o.oHomeY = o.oPosY
    o.oHomeZ = o.oPosZ
    o.setHome = 1

    o.oHealth = 3
    o.oDamageOrCoinValue = 0
    cur_obj_scale(2.0)
    fadeout_level_music(1)

end

function act_intro(o)
    if o.oAction == GRAND_STAR_ACT_INTRO then
        obj_move(o)
        if o.oTimer <= 1 then
            spawn_mist_particles()
            spawn_non_sync_object(id_bhvLightning, E_MODEL_LIGHTNING, o.oPosX - 15, o.oPosY, o.oPosZ, nil)
            cur_obj_play_sound_2(SOUND_GENERAL_GRAND_STAR)
            o.oForwardVel = 0
            o.oVelY = 60
            play_transition(WARP_TRANSITION_FADE_INTO_COLOR, 5, 255, 255, 255)
            play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 5, 0, 0, 0)
        elseif o.oTimer < 30 then
            -- During the first second of the intro, make the grand star spin
            o.oFaceAngleYaw = o.oFaceAngleYaw + 0x1000  -- Adjust the rotation speed as needed

        elseif o.oTimer >= 30 then
            -- At the end of the intro animation, switch to the next action
            obj_change_action(o, GRAND_STAR_ACT_SHOCKWAVE)
        end
    end
end



-- Function to handle jump behavior
function act_jump_towards_mario(o, m)
    if o.oAction == GRAND_STAR_ACT_SHOCKWAVE then
        obj_move(o)
        o.oForwardVel = 15
        o.oFaceAnglePitch = o.oFaceAnglePitch + 0x800
        o.oFaceAngleRoll = o.oFaceAngleRoll + 0x150

        if o.oTimer <= 10 then
            o.oVelY = 100
            cur_obj_play_sound_2(SOUND_OBJ_KING_BOBOMB_JUMP)
            obj_turn_toward_object(o, m.marioObj, 16, 12384)
        end

        if o.oPosY <= o.oFloorHeight and o.oTimer >= 2.5 then
        --if o.oPosY <= 200 and o.oTimer >= 2.5 then
            -- Create a shockwave when landing
            spawn_non_sync_object(id_bhvBowserShockWave, E_MODEL_BOWSER_WAVE, o.oPosX, 320, o.oPosZ, nil)
            spawn_mist_particles_variable(0, 0, 200.0)
            spawn_triangle_break_particles(20, 138, 3.0, 4)
            cur_obj_shake_screen(SHAKE_POS_LARGE)
            play_sound(SOUND_OBJ_KING_BOBOMB, m.marioObj.header.gfx.cameraToObject)

            -- Perform 2 or 3 more jumps after landing
            if o.oJumpCounter == -1 then
                o.oJumpCounter = 1
            else
                o.oJumpCounter = o.oJumpCounter + 1
            end

            if o.oJumpCounter <= 3 then
                o.oTimer = 0
                o.oVelY = 0
            else
                -- After the specified number of jumps, switch back to idle action
                obj_change_action(o, GRAND_STAR_ACT_GO_HOME)
            end
        end
    end
end

-- Function to handle "go home" behavior
function act_go_home(o)
    if o.oAction == GRAND_STAR_ACT_GO_HOME then
        o.oGravity = 0
        obj_move(o)

        if o.oTimer < 60 then
            o.oFaceAngleYaw = o.oFaceAngleYaw + 0x1000
            o.oVelY = -20

        -- Check if the grand star has finished digging
        elseif o.oTimer >= 60 and o.oTimer <= 120 then
            o.oFaceAngleYaw = o.oFaceAngleYaw + 0x800 --This WAS 0x800. Gonna fiddle and see if it fixes the minions spawn offset. 
            o.oPosX = 0
            o.oPosZ = 0
            o.oVelY = 40
        elseif o.oTimer > 120 then
            o.oVelY = 0
            o.oFaceAngleYaw = o.oFaceAngleYaw + 0x600
            if obj_count_objects_with_behavior_id(id_bhvStarMinions) < 5 and o.oTimer < 122 then --THIS OTIMER WAS 122. Adjusting to see if I can get minions to spawn on the star platform tips.
                o.oSubAction = GRAND_STAR_SUB_ACT_SUMMON_MINIONS
            end
        end
    end
end

-- Function to summon minions in a circle formation around the grand star
function sub_act_summon_minions(o)
    if o.oSubAction == GRAND_STAR_SUB_ACT_SUMMON_MINIONS then
        local radius = 1500
        if obj_count_objects_with_behavior_id(id_bhvStarMinions) < numBombMinions then
            for i = 1, numBombMinions do
                local angle = i * (2 * math.pi) / numBombMinions
                local x = o.oPosX + radius * math.cos(angle)
                local z = o.oPosZ + radius * math.sin(angle)

                spawn_non_sync_object(id_bhvStarMinions, E_MODEL_STAR, x, o.oPosY, z, function (obj)
                    obj.oAction = STAR_MINION_ACT_SHOCKWAVE
                    obj.oBehParams2ndByte = i * 30
                end)
            end
        else
            o.oSubAction = GRAND_STAR_SUB_ACT_NONE --This is the last part of where we've left off. This WAS GRAND_STAR_SUB_ACT_NONE but I'm going to test something by making a function to randomly select the stars next attack..
            --o.oAction = GRAND_STAR_ATTACK_SELECT
            o.oTimer = 0
            o.oAction = GRAND_STAR_SHOOTING
        end
    end
end



function act_shooting_attack (o)
    m = nearest_mario_state_to_object(o)
    o.oAction = GRAND_STAR_SHOOTING
    if o.oAction == GRAND_STAR_SHOOTING then
        djui_popup_create(tostring(o.oTimer), 1)
        local gsvec = {x=o.oPosX, y=o.oPosY, z=o.oPosZ}
        local star_angletomario = obj_angle_to_object(o, m.marioObj)
        local star_pitchtomario = obj_pitch_to_object(o, m.marioObj)
        o.oFaceAngleYaw = star_angletomario
        o.oFaceAnglePitch = star_pitchtomario

        if o.oTimer <= 150 and o.oTimer > 50 then --GS starts spinning to "charge" his attack. 
            o.oFaceAngleRoll = o.oFaceAngleRoll + 50 * o.oTimer
        elseif o.oTimer > 150 then
            o.oFaceAngleRoll = o.oFaceAngleRoll + 8000
        end

        if o.oTimer == 60 then
            local_play(sGslaser, gsvec, 1)
        end

        if o.oTimer == 90 then
            gscharge = spawn_non_sync_object(id_bhvStaticObject, E_MODEL_GSCHARGE, o.oPosX, o.oPosY, o.oPosZ, function(obj)
                obj.oFaceAngleYaw = star_angletomario
                obj.oFaceAnglePitch = star_pitchtomario
            end)
            gschargescale = 10
            gscharge.oOpacity = 0
            obj_scale(gscharge, gschargescale)
        end
        if o.oTimer >= 91 and o.oTimer < 146 then
            if gscharge.oOpacity <= 250 then
                gscharge.oOpacity = gscharge.oOpacity + 1
            end
            gschargescale = gschargescale - 0.2
            obj_scale(gscharge, gschargescale)
            gscharge.oPosX = o.oPosX
            gscharge.oPosY = o.oPosY
            gscharge.oPosZ = o.oPosZ
            gscharge.oFaceAngleYaw = star_angletomario
            gscharge.oFaceAnglePitch = star_pitchtomario
        end

        if o.oTimer == 135 then
            local_play(sGsbeam, gsvec, 1)
        end

        if o.oTimer == 147 then
            obj_mark_for_deletion(gscharge)
        end

        if o.oTimer == 151 then
            GSBeam = spawn_non_sync_object(id_bhvGSBeam, E_MODEL_GSBEAM, o.oPosX, o.oPosY, o.oPosZ, function (beam)
            beam.oFaceAnglePitch = star_pitchtomario
            beam.oFaceAngleYaw = star_angletomario
            end)

        end

        if o.oTimer >= 152 and o.oTimer < 250 then
            GSBeam.oPosX = o.oPosX
            GSBeam.oPosY = o.oPosY
            GSBeam.oPosZ = o.oPosZ
            GSBeam.oFaceAngleYaw = star_angletomario
            GSBeam.oFaceAnglePitch = star_pitchtomario
        end
        
        if o.oTimer == 250 then
            obj_mark_for_deletion(GSBeam)
        end
    
        
    
    
    
    end



end





function GRAND_STAR_ATTACK_SELECT (o)
    if o.oAction == GRAND_STAR_ATTACK_SELECT then
        local attack = math.random(3,3)
        if attack == 1 then
            obj_change_action(o, GRAND_STAR_ACT_SHOCKWAVE)
        end
        if attack == 2 then
            obj_change_action(o, GRAND_STAR_ACT_FALLING_MINIONS)
        end
        if attack == 3 then
            o.oAction = GRAND_STAR_SHOOTING
        end
        
    
    end
end



-- Function for the grand star to spawn falling minions in a circle formation
function act_falling_minions(o, m)
    if o.oAction == GRAND_STAR_ACT_FALLING_MINIONS then
        obj_move(o)
        o.oFaceAngleYaw = o.oFaceAngleYaw + 0x1000

        if o.oTimer <= 10 then
            o.oVelY = 60
            cur_obj_play_sound_2(SOUND_OBJ_KING_BOBOMB_JUMP)
        end

        if o.oPosY <= o.oFloorHeight and o.oTimer >= 2.5 then
            local initialRadius = 30  -- Initial radius
            local spawnDelay = 5  -- Delay between spawning each minion

            for i = 1, numBombMinions do
                local angle = (i * (2 * math.pi) / numBombMinions)
                local radius = initialRadius * (o.oJumpCounter >= 0 and o.oJumpCounter or 0) * 20

                local x = o.oPosX + radius * math.cos(angle)
                local z = o.oPosZ + radius * math.sin(angle)

                if i <= 1 and o.oJumpCounter <= 1 then
                    spawn_non_sync_object(id_bhvStarMinions, E_MODEL_STAR, x, o.oPosY + 3500, z, function (obj)
                        obj.oAction = STAR_MINION_ACT_FALL
                    end)
                else
                    spawn_non_sync_object(id_bhvStarMinions, E_MODEL_STAR, x, o.oPosY + 3500, z, function (obj)
                        obj.oAction = STAR_MINION_ACT_FALL
                    end)
                    spawn_mist_particles_variable(0, 0, 200.0)
                end

                o.oTimer = o.oTimer + spawnDelay
                --djui_popup_create(tostring(radius), 1)
            end

            spawn_triangle_break_particles(20, 138, 3.0, 4)
            cur_obj_shake_screen(SHAKE_POS_LARGE)
            play_sound(SOUND_OBJ_POUNDING1, m.marioObj.header.gfx.cameraToObject)
            play_sound(SOUND_OBJ_KING_BOBOMB, m.marioObj.header.gfx.cameraToObject)

            if o.oJumpCounter == -1 then
                o.oJumpCounter = 1
            else
                o.oJumpCounter = o.oJumpCounter + 1
            end

            if o.oJumpCounter <= 5 then
                o.oTimer = 0
                o.oVelY = 0
            else
                obj_change_action(o, GRAND_STAR_ACT_VULNERABLE)
            end
        end
    end
end

function act_vulnerable(o)
    local m = nearest_mario_state_to_object(o)
    if o.oAction == GRAND_STAR_ACT_VULNERABLE then
        obj_move(o)
        if (o.oPosY ~= o.oFloorHeight) then
            o.oVelY = -5
            o.oTimer = 0
        end
        obj_scale(o, math.sin(math.pi / 2))
        if o.oTimer >= 300 then
            o.oAction = GRAND_STAR_ACT_SHOCKWAVE
        end
    end
end

function grand_star_loop(o)
    local m = nearest_mario_state_to_object(o)
    local p = nearest_player_to_object(o)

    act_shooting_attack(o)
    --[[
    act_go_home(o) 
    act_intro(o) --Spawns GS, starts the fight.
    act_jump_towards_mario(o, m) --The star lunges at Mario and leaves shockwaves
    act_falling_minions(o, m) --The GS summons jumping minions that leave shockwaves
    sub_act_summon_minions(o) --The GS summons explosive minions
    act_go_home(o)
    act_shooting_attack(o)
    ]]

    --djui_chat_message_create(tostring(o.oAngleToHome))
    --djui_chat_message_create(tostring(o.oAction))
    --djui_chat_message_create(tostring(o.oTimer))
end

-- Grand Star Minion initialization
function grand_star_minion_init(o)
    o.oFlags = (OBJ_FLAG_MOVE_XZ_USING_FVEL | OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.oInteractType = INTERACT_DAMAGE

    o.hitboxRadius = 50
    o.hitboxHeight = 50
    o.oWallHitboxRadius = 30
    o.oGravity = -4
    o.oBounciness = 0

    o.oIntangibleTimer = 0

    o.oMoveFlags = o.oMoveFlags | OBJ_MOVE_IN_AIR

    o.oHomeX = o.oPosX
    o.oHomeY = o.oPosY
    o.oHomeZ = o.oPosZ
    o.setHome = 1

    o.oHealth = 3
    o.oDamageOrCoinValue = 0
end

function minion_act_shockwave(o)
    if o.oAction == STAR_MINION_ACT_SHOCKWAVE then
        if o.oTimer == 1 then
            spawn_non_sync_object(id_bhvLightning, E_MODEL_LIGHTNING, o.oPosX, o.oPosY + 550, o.oPosZ, nil)
        end
        obj_move(o)
        o.oFaceAngleYaw = o.oFaceAngleYaw + 0x800
        if o.oTimer <= 10 then
            o.oVelY = 100
            cur_obj_play_sound_2(SOUND_GENERAL_GRAND_STAR_JUMP)
        end
        if o.oPosY <= o.oFloorHeight and o.oTimer >= 2.5 then
            -- Create a shockwave when landing
            spawn_non_sync_object(id_bhvBowserShockWave, E_MODEL_BOWSER_WAVE, o.oPosX, 320, o.oPosZ, nil)
            spawn_mist_particles_variable(0, 0, 200.0)
            spawn_triangle_break_particles(20, 138, 3.0, 4)
            cur_obj_shake_screen(SHAKE_POS_LARGE)
            play_sound(SOUND_OBJ_SWOOP_DEATH, gMarioStates[0].marioObj.header.gfx.cameraToObject)

            if o.oJumpCounter == -1 then
                o.oJumpCounter = 1
            else
                o.oJumpCounter = o.oJumpCounter + 1
            end
            if o.oJumpCounter <= 2 then
                o.oTimer = 0
                o.oVelY = 0
            else
                obj_mark_for_deletion(o)
                obj_change_action(obj_get_first_with_behavior_id(id_bhvGrandStar), GRAND_STAR_ACT_FALLING_MINIONS)
            end
        end
    end
end

function spawn_explosion_ring(o, x, z, radius, numSegments)
    for i = 1, numSegments do
        local angle = (i * (2 * math.pi) / numSegments)
        local spawnX = x + radius * math.cos(angle)
        local spawnZ = z + radius * math.sin(angle)
        spawn_non_sync_object(id_bhvSmallExplosion, E_MODEL_EXPLOSION, spawnX, o.oPosY, spawnZ, nil)
    end
end

local explode = true

function minion_act_falling(o)
    if o.oAction == STAR_MINION_ACT_FALL then
        djui_chat_message_create(tostring(o.oTimer))
        o.oFaceAngleYaw = o.oFaceAngleYaw + 0x800
        if o.oPosY > o.oFloorHeight then
            obj_move(o)
            o.oVelY = -50
        else
            o.oVelY = 0
        end

        if o.oPosY <= o.oFloorHeight and o.oTimer >= 2.5 then
            spawn_explosion_ring(o, o.oPosX, o.oPosZ, 200, 4)
            cur_obj_disable_rendering_and_become_intangible(o)
            if explode then
                spawn_mist_particles_variable(0, 0, 200.0)
                spawn_triangle_break_particles(20, 138, 3.0, 4)
                cur_obj_shake_screen(SHAKE_POS_LARGE)
                play_sound(SOUND_OBJ_SWOOP_DEATH, gMarioStates[0].marioObj.header.gfx.cameraToObject)
                explode = false
            end

            for i = 70, 100, 5 do
                if o.oTimer == i then
                    spawn_explosion_ring(o, o.oPosX, o.oPosZ, 300 + (i - 75) * 25, 10)
                end
            end

            if o.oTimer >= 85 and o.oPosY <= o.oFloorHeight and o.oTimer >= 2.5 then
                obj_get_first_with_behavior_id(id_bhvGrandStar).oAction = GRAND_STAR_ACT_VULNERABLE
                obj_mark_for_deletion(o)
                explode = true
            end
        end
    end
end


function grand_star_minion_loop(o)
    local m = nearest_mario_state_to_object(o)
    minion_act_shockwave(o)
    minion_act_falling(o)
    otherMinion = obj_get_nearest_object_with_behavior_id(o, id_bhvStarMinions)
end

function small_explosion_init(o)
    local m = nearest_mario_state_to_object(o)
    play_sound(SOUND_GENERAL2_BOBOMB_EXPLOSION, gMarioStates[0].marioObj.header.gfx.cameraToObject)
    set_environmental_camera_shake(SHAKE_ENV_EXPLOSION)
    o.oOpacity = 255
    obj_set_hitbox_radius_and_height(o, 175, 175)
    if obj_check_hitbox_overlap(m.marioObj, o) ~= false then
        m.squishTimer = 50
    end
end

function small_explosion_loop(o)
    local m = nearest_mario_state_to_object(o)
    if (o.oTimer == 1) then
        spawn_sync_object(id_bhvSmoke, E_MODEL_EXPLOSION, o.oPosX, o.oPosY, o.oPosZ, nil)
    end
    obj_mark_for_deletion(o)
end

---------------------------------Environment-----------------------------------------

function skybox1_init (o)
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.skipInViewCheck = true
end

function skybox1_loop (o)
    obj_scale(o, 0.8)
    if o.oTimer >= 18 then
        o.oPosY = -7500
        o.oTimer = 0
    else
        o.oPosY = o.oPosY + 6000
    end
    o.oFaceAngleYaw = o.oFaceAngleYaw + 0x0250
end

function skybox2_init (o)
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.skipInViewCheck = true
end

function skybox2_loop (o)
    obj_scale(o, 0.8)
    if o.oTimer >= 60 then
        --o.oPosY = 0
        o.oTimer = 0
    else
        --o.oPosY = o.oPosY + 50
    end
    o.oFaceAngleYaw = o.oFaceAngleYaw - 0x400
end

function lightning_init(obj)
    obj.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    vec = {x=obj.oPosX, y=obj.oPosY, z=obj.oPosZ}
    local yaw = calculate_yaw(vec, gLakituState.pos)
    --djui_popup_create(tostring(yaw), 1)
    obj.oFaceAngleYaw = yaw -22000
end

function lightning_loop(obj)
    if obj.oTimer >= 2 then
        obj_set_model_extended(obj, E_MODEL_LIGHTNING2)
    end
    if obj.oTimer >= 3 then
        obj_set_model_extended(obj, E_MODEL_LIGHTNING3)
    end
    if obj.oTimer >= 4 then
        obj_set_model_extended(obj, E_MODEL_LIGHTNING)
    end
    if obj.oTimer >= 5 then
        obj_set_model_extended(obj, E_MODEL_LIGHTNING2)
    end
    if obj.oTimer >= 6 then
        obj_set_model_extended(obj, E_MODEL_LIGHTNING3)
    end
    if obj.oTimer >= 7 then
        obj_set_model_extended(obj, E_MODEL_LIGHTNING)
    end
    if obj.oTimer >= 8 then
        obj_mark_for_deletion(obj)
    end
end

-----------------------------------------------------------------------------------

function gsbeam_init (o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = COL_GSBEAM
	o.oCollisionDistance = 10000
    o.header.gfx.skipInViewCheck = true
end

function gsbeam_loop (o)
    m = nearest_mario_state_to_object(o)
    o.oFaceAngleRoll = o.oFaceAngleRoll + 8000
    if obj_check_if_collided_with_object(o, m.marioObj) ~= 0 then
        m.squishTimer = 50
    end
end

-- Hook behaviors for Grand Star and Star Minions
hook_event(HOOK_MARIO_UPDATE, testing)
id_bhvGrandStar = hook_behavior(id_bhvGrandStar, OBJ_LIST_LEVEL, true, grand_star_init, grand_star_loop, "bhvGoreGrandStar")
id_bhvStarMinions = hook_behavior(nil, OBJ_LIST_LEVEL, true, grand_star_minion_init, grand_star_minion_loop, "bhvGoreGrandStarMinion")
id_bhvSmallExplosion = hook_behavior(nil, OBJ_LIST_LEVEL, true, small_explosion_init, small_explosion_loop, "bhvGoreSmallExplosion")
id_bhvSkybox1 = hook_behavior(nil, OBJ_LIST_LEVEL, true, skybox1_init, skybox1_loop, "bhvSkybox1")
id_bhvSkybox2 = hook_behavior(nil, OBJ_LIST_LEVEL, true, skybox2_init, skybox2_loop, "bhvSkybox1")
id_bhvLightning = hook_behavior(nil, OBJ_LIST_GENACTOR, false, lightning_init, lightning_loop, "bhvLightning")
id_bhvGSBeam = hook_behavior(nil, OBJ_LIST_GENACTOR, false, gsbeam_init, gsbeam_loop, "bhvGSBeam")