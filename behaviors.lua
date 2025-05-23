--Math! -Baldi

local function easeOutSine(x)
    return sins((x * math.pi) / 2)
end

--All custom behaviors.

local function obj_explode_if_within_300_units(o)
    local mObj = nearest_player_to_object(o)
    local pos = o.header.gfx.cameraToObject
    if dist_between_objects(mObj, o) < 300 then
        spawn_triangle_break_particles(30, 138, 1, 4)
        spawn_mist_particles()
        set_camera_shake_from_hit(SHAKE_POS_MEDIUM)
        play_sound(SOUND_GENERAL_WALL_EXPLOSION, pos)
        play_sound(SOUND_GENERAL_EXPLOSION6, pos)
        obj_mark_for_deletion(o)
    end
end

local delete_on_spawn = obj_mark_for_deletion

local function killer_exclamation_boxes(m) -- Makes exclamation boxes drop on top of you! (squishes)
    local box = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvExclamationBox)

    if box then
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

--local ACT_KING_WHOMP_CHASE_FAST = 15

local function bhv_custom_kingwhomp(o)
    local m = nearest_mario_state_to_object(o)
    if o.oHealth == 3 then
        cur_obj_scale(.2)
    end
    if o.oHealth == 2 then
        local whompblood = spawn_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, o.oPosX, o.oPosY + 1, o.oPosZ, nil)
        obj_scale(whompblood, .4)
        local_play(sSplatter, m.pos, 1)
        --play_sound_with_freq_scale(SOUND_OBJ_KING_WHOMP_DEATH, m.marioObj.header.gfx.cameraToObject, 3.0)
        obj_mark_for_deletion(o)
        stop_background_music(SEQ_EVENT_BOSS)
        spawn_default_star(m.pos.x, m.pos.y + 200, m.pos.z)
    end
    if o.oMoveFlags & OBJ_MOVE_LANDED ~= 0 and o.oHealth >= 2 then
        spawn_sync_object(id_bhvBowserShockWave, E_MODEL_BOWSER_WAVE, o.oPosX, o.oPosY, o.oPosZ, nil)
    end
    
    if o.oAction == 6 and o.oTimer == 35 then
        o.oSubAction = 10
    end
    if o.oAction == 1 then
        o.oForwardVel = 30
    elseif o.oSubAction ~= 10 then
        o.oForwardVel = 30
    end
    --if lateral_dist_between_objects(m.marioObj, o) < 700 then
    --	--m.floor.type = surface_ --SURFACE_QUICKSAND
    --end
end

local function bhv_custom_kingbobomb(o)
    local m = nearest_mario_state_to_object(o)

    o.oHomeX, o.oHomeY, o.oHomeZ = o.oPosX, o.oPosY, o.oPosZ

    local healthScales = {1.6, 1.1, 0.7, 0.5, 0.25}
    local fVelocities = {3, 6.0, 12.0, 24.0, 26}
    local yawVelocities = {160, 320, 640, 1280, 1400}
    if o.oHealth <= 6 and o.oHealth >= 2 then
        local index = 7 - o.oHealth
        cur_obj_scale(healthScales[index])
        gBehaviorValues.KingBobombFVel = fVelocities[index]
        gBehaviorValues.KingBobombYawVel = yawVelocities[index]
    elseif o.oHealth == 1 then
        local bobsplat = spawn_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, o.oPosX, o.oPosY + 1, o.oPosZ, nil)
        obj_scale(bobsplat, .4)
        local_play(sSplatter, m.pos, 1)
        spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
        spawn_sync_object(id_bhvExplosion, E_MODEL_EXPLOSION, o.oPosX, o.oPosY, o.oPosZ, nil)
        o.oTimer = 0
        cur_obj_disable_rendering_and_become_intangible(o)
        o.oHealth = 8
    elseif o.oHealth == 8 then
        cur_obj_disable_rendering_and_become_intangible(o)
    end

    if o.oTimer == 60 and o.oHealth == 8 then
        o.oHealth = 0
        obj_mark_for_deletion(o)
        stop_background_music(SEQ_EVENT_BOSS)
        spawn_default_star(m.pos.x, m.pos.y + 200, m.pos.z)
    end

    if o.oHealth == 2 and o.oMoveFlags == 128 then
        o.oForwardVel = o.oForwardVel + 5
        o.oFaceAnglePitch = o.oFaceAnglePitch + 4000
    else
        o.oFaceAnglePitch = 0
    end

    if o.oAction == 3 then --I'M A CHUCKSTER
        if o.oTimer == 0 and m.marioObj == o.usingObj then
            local m = nearest_mario_state_to_object(o)
            --cutscene_object_with_dialog(CUTSCENE_DIALOG, o, DIALOG_116)
            cutscene_object_with_dialog(CUTSCENE_DIALOG, m.marioObj, DIALOG_116)
            network_play(sChuckster, m.pos, 1, m.playerIndex)
            m.forwardVel = 280
        elseif o.oTimer == 40 then
            o.oSubAction = 3
        end
        cur_obj_rotate_yaw_toward(0, 0x400)
    end

    -- djui_chat_message_create(""..o.oAction.."\n"..o.oSubAction.."\n"..o.oTimer)
    -- if o.oHealth < 5 then
    --     djui_chat_message_create(tostring(o.oMoveFlags))
    -- end
end

local function bobomb_loop(o) -- makes bobombs SCARY fast (Thanks blocky.cmd!!)
    local player = nearest_player_to_object(o)
    local np = gNetworkPlayers[0]

    if np.currLevelNum == LEVEL_BITS then
        obj_mark_for_deletion(o)
    end

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

local function bhv_custom_boulder(o) --Locks onto mario and homes-in on him.
    local m = nearest_player_to_object(o)
    obj_turn_toward_object(o, m, 16, 0x800)
end

local function bhv_custom_bowserbomb(o) --Oscillates up and down
    if o.oTimer >= 10 then
        o.oHomeY = math.random(-1500, 1500)
        o.oTimer = 0
    end
    o.oVelY = o.oVelY + (o.oHomeY - o.oPosY) * .02
    object_step()
end

local function bhv_custom_bouncing_fireball(o) --Locks onto mario and homes-in on him.
    local m = nearest_player_to_object(o)
    obj_turn_toward_object(o, m, 16, 0x800)
end

local sFlyGuyOverrideVelActions = {
    [FLY_GUY_ACT_IDLE] = 0,
    [FLY_GUY_ACT_APPROACH_MARIO] = 1,
    [FLY_GUY_ACT_SHOOT_FIRE] = 0
}

-- local function bhv_custom_flyguy_init(o)
-- 	o.oDistanceToMario
-- end
---@param o Object
local function bhv_custom_flyguy(o)
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)

    local overrideVel = sFlyGuyOverrideVelActions[o.oAction]

    if overrideVel then
        local vel = o.oFlyGuyVel
        local targetVel = 0
        local targetTimer = o.oFlyGuyTargetTimer
        local moveYaw = o.oFlyGuyMoveYaw
        local angleToPlayer = obj_angle_to_object(o, mObj)

        local isApproaching = o.oAction == FLY_GUY_ACT_APPROACH_MARIO
        local isShooting = (o.oAction == FLY_GUY_ACT_SHOOT_FIRE)
        local tooClose = dist < 400
        --if isApproaching then djui_chat_message_create("go go")             end
        --if isShooting and not tooClose then djui_chat_message_create("keep going !!")     end
        --if tooClose      then djui_chat_message_create("WAIT NO STOP STOP") end
        if isApproaching or (isShooting and not tooClose) then
            targetTimer = targetTimer + 8
            -- djui_chat_message_create("calculate vel")
        else--if o.oAction == FLY_GUY_ACT_SHOOT_FIRE then
            targetTimer = targetTimer - 16
            -- djui_chat_message_create("reduce vel")
        end
        targetTimer = clamp(targetTimer, 0, 50)

        local angleDiff = abs_angle_diff(angleToPlayer, moveYaw)
        local turnSharpness = angle_range_float(angleDiff, 0x2000, 0x5000)
        if isApproaching or isShooting then
            obj_face_yaw_approach(angleToPlayer, 0x800)
            -- cur_obj_rotate_yaw_toward(angleToPlayer, (0x400 - math.min(angle_range_float(angleDiff, 0x100, 0x1000) * 0x400, 0x400)) * invert_float(vel/100))
            -- cur_obj_rotate_yaw_toward(angleToPlayer, 0x400 * invert_float(vel/100))
            moveYaw = approach_s16_symmetric(moveYaw, angleToPlayer, 0x400 * invert_float(vel/100))
            o.oMoveAngleYaw = moveYaw
            o.oFlyGuyMoveYaw = moveYaw
            -- o.oFaceAngleYaw = o.oMoveAngleYaw
        end
        -- djui_chat_message_create(""..0x400 * invert_float(vel/100))
        --djui_chat_message_create(""..o.oAngleToHome)
        -- djui_chat_message_create(""..(0x400 - math.min(angle_range_float(angleDiff, 0x100, 0x1000) * 0x400, 0x400)) * invert_float(vel/100))

        targetTimer = targetTimer
        * invert_float(turnSharpness / 2)
        * (0.5 + (clamp(dist, 300, 600) - 300) / (600 - 300) / 2)

        targetVel = math.min(math.max(targetTimer, vel), 100)

        -- o.oFaceAngleYaw = 0
        vel = vel + (targetVel - vel)*.1

        o.oFlyGuyVel = vel
        o.oForwardVel = vel
        o.oFlyGuyTargetTimer = targetTimer

        -- djui_chat_message_create("target:"..targetVel)
    end
    -- djui_chat_message_create("vel:"..o.oAngleToHome)
    -- djui_chat_message_create("actual vel:"..o.oForwardVel)

    -- if o.oAction == FLY_GUY_ACT_SHOOT_FIRE then cur_obj_move_standard(78) djui_chat_message_create("step.") end
    if overrideVel == 0 then cur_obj_move_standard(78) end

    o.oFlyGuyIdleTimer = 0

    local lockedOn = o.oAction == FLY_GUY_ACT_SHOOT_FIRE and dist < 1000
    local ignore = m.action == ACT_GONE
    if (dist < 400 or lockedOn) and not ignore then
        o.oHomeX = m.pos.x
        o.oHomeY = m.pos.y
        o.oHomeZ = m.pos.z
        o.oAction = FLY_GUY_ACT_SHOOT_FIRE
        if o.oTimer < 10 or o.oTimer > 20 then
            -- djui_chat_message_create("SHOOT")
            o.oTimer = 10
            obj_scale(o, 1.2)
            o.oFlyGuyScaleVel = -.01
        end
    elseif o.oAction == FLY_GUY_ACT_LUNGE
       or (o.oAction == FLY_GUY_ACT_IDLE and dist < 1500) then
        if o.oAction == FLY_GUY_ACT_LUNGE then o.oVelY = 0 end
        o.oAction = FLY_GUY_ACT_APPROACH_MARIO
    end
    -- djui_chat_message_create(""..o.oAction)
end

local function bhv_custom_coins_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO
    if obj_has_behavior_id(o, id_bhvCoinFormationSpawn) ~= 0 then
        local hitbox = get_temp_object_hitbox()
        hitbox.interactType = INTERACT_COIN
        hitbox.radius = 100
        hitbox.height = 64
        hitbox.damageOrCoinValue = 1
        obj_set_hitbox(o, hitbox)
    end
    obj_set_billboard(o)
end

--I had to make this function because it isn't exposed!!! --Flipflop Bell
local function bhv_coin_sparkles_init(o)
    --if o == nil then return end
    if (o.oInteractStatus & INT_STATUS_INTERACTED and (o.oInteractStatus & INT_STATUS_TOUCHED_BOB_OMB) ~= true) then
        --spawn_sync_object(id_bhvGoldenCoinSparkles, E_MODEL_SPARKLES, o.oPosX, o.oPosY, o.oPosZ, nil)
        --obj_mark_for_deletion(o)
        return 1
    end
    --o.oInteractStatus = 0
    return 0
end

--I tried to make coins run away from mario like 6 different ways. It aint happening.
--IT HAPPENED (only for secret aquarium though) --Flipflop Bell
local function bhv_custom_coins(o)
    local np = gNetworkPlayers[0]
    if obj_has_behavior_id(o, id_bhvCoinFormationSpawn) ~= 0 then --Forced to recreate the bhv :(
        if o.oTimer == 1 then
            bhv_init_room()
            if o.oCoinUnkF8 == 1 then
                o.oPosY = o.oPosY + 300.0
                cur_obj_update_floor_height()
                if o.oPosY < o.oFloorHeight or o.oFloorHeight < gLevelValues.floorLowerLimitMisc then
                    obj_mark_for_deletion(o)
                else
                    o.oPosY = o.oFloorHeight
                end
            else
                cur_obj_update_floor_height()
                if math.abs(o.oPosY - o.oFloorHeight) > 250.0 then
                    obj_set_model_extended(o, E_MODEL_YELLOW_COIN_NO_SHADOW)
                end
            end
        else
            if o.parentObj and bhv_coin_sparkles_init(o) == 1 then
                o.parentObj.oCoinUnkF4 = o.parentObj.oCoinUnkF4 | bit_shift_left(o.oBehParams2ndByte);
            end
            bhv_yellow_coin_loop()
        end
        if not o.parentObj and o.parentObj.oAction == 2 then
            obj_mark_for_deletion(o)
        end
    end
    if np.currLevelNum ~= LEVEL_SA then return end
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)
    if dist < 500 and obj_has_behavior_id(o, id_bhvCoinFormationSpawn) ~= 0 then
        spawn_sync_object(id_bhvWhitePuff1, E_MODEL_WHITE_PUFF, o.oPosX, o.oPosY, o.oPosZ, nil)
        obj_mark_for_deletion(o)
        local_play(sFart, m.pos, 1)
    end
    if dist < 1000 and obj_has_behavior_id(o, id_bhvRedCoin) ~= 0 then
        if o.oPosY >= -150 then
            o.oGravity = 10.0
            o.oFriction = 1.0
            o.oBuoyancy = 1.5
        elseif m.pos.y <= o.oPosY then
            o.oGravity = -10.0
            o.oFriction = 1.0
            o.oBuoyancy = 1.5
        end
        bhv_moving_yellow_coin_loop()
        o.oForwardVel = 32.0
    end
    if o.oTimer > 299 then
        o.oTimer = 10
    end
    o.oMoveAngleYaw = o.oAngleToMario + 0x8000
    --djui_chat_message_create(tostring(obj_get_nearest_object_with_behavior_id(mObj, id_bhvRedCoin).oMoveAngleYaw))

end

local function bhv_custom_bully(o)
    local m = nearest_mario_state_to_object(o)
    local dist = dist_between_objects(o, m.marioObj)
    if dist < 2000 then -- essentially gives them better detection range without making them walk on the edge all the time
        o.oHomeX = m.pos.x
        o.oHomeY = m.pos.y
        o.oHomeZ = m.pos.z
        --djui_chat_message_create(tostring(o.oAction))
    elseif dist >= 2000 and o.oAction == 0 and o.oTimer == 1 then
        o.oHomeX = o.oPosX
        o.oHomeY = o.oPosY
        o.oHomeZ = o.oPosZ
    end
    if o.oBehParams == 20 then
        cur_obj_scale(0.02)
        o.oFlags = GRAPH_RENDER_INVISIBLE
    end
    --if dist < 400 and (m.aciton == ACT_GROUND_POUND or m.action == ACT_JUMP_KICK) and (o.oInteractStatus & INT_STATUS_INTERACTED == 0) then
        --o.oForwardVel = 0
    --end
    if o.oAction == 2 then
        if o.oTimer > 10 then
            o.oForwardVel = o.oForwardVel / 1.4
        end
        if o.oTimer <= 4 then
            cur_obj_become_intangible()
        else
            cur_obj_become_tangible()
        end
    end
    if o.oBullyKBTimerAndMinionKOCounter == 2 then
        o.oAction = 1
        o.oBullyKBTimerAndMinionKOCounter = 0
        cur_obj_init_animation(1)

    end
end

local function bhv_custom_explosion(o) -- replaces generic explosions with NUKES! (Bigger radius, bigger explosion, louder)
    local m = nearest_mario_state_to_object(o)
    if o.oBehParams ~= 20 then
        local_play(sBigExplosion, m.pos, 1)
        cur_obj_shake_screen(SHAKE_POS_LARGE)
        spawn_sync_if_main(id_bhvBowserBombExplosion, E_MODEL_BOWSER_FLAMES, o.oPosX, o.oPosY, o.oPosZ, nil, 0)
        if dist_between_objects(o, m.marioObj) <= 850 and m.flags & MARIO_METAL_CAP == 0 then
            m.squishTimer = 50
        elseif dist_between_objects(o, m.marioObj) <= 850 and MARIO_METAL_CAP ~= 0 then -- i think i did this for testing, may keep it for romhack compatibility
            m.capTimer = 1
            m.flags = MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD
            set_mario_action(m, ACT_HARD_BACKWARD_GROUND_KB, 0)
            stop_cap_music()
        end
        if o.oChicken == 1 then
            local_play(sChicken, m.pos, 1)
        end
    end
end

local function bhv_custom_chain_chomp(o)
    local m = gMarioStates[0]
    if (o.oChainChompReleaseStatus == CHAIN_CHOMP_NOT_RELEASED) then
        o.oMoveAngleYaw = o.oMoveAngleYaw * 5
        o.oForwardVel = o.oForwardVel * 3
        o.oTimer = 0

        local kingbob = obj_get_nearest_object_with_behavior_id(o, id_bhvKingBobomb)
        local goomba = obj_get_nearest_object_with_behavior_id(o, id_bhvGoomba)
        local bobomb = obj_get_nearest_object_with_behavior_id(o, id_bhvBobomb)
        if kingbob ~= nil then
            if obj_check_hitbox_overlap(o, kingbob) then
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
            if obj_check_hitbox_overlap(o, goomba) then
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
            if obj_check_hitbox_overlap(o, bobomb) then
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
        if o.oTimer >= 117 then
            local m = nearest_mario_state_to_object(o)
            squishblood(o)
            local chompmist = spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
            obj_scale(chompmist, 3)
            set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
            local_play(sSplatter, m.pos, 1)
            obj_mark_for_deletion(o)
        end
    end

end

local function bhv_custom_goomba_loop(o) -- make goombas faster, more unpredictable. Will lunge at Mario
    local m = nearest_mario_state_to_object(o)
    local np = gNetworkPlayers[0]
    if o.oGoombaJumpCooldown >= 9 then
        o.oGoombaJumpCooldown = 8
        o.oVelY = o.oVelY + 10
        o.oForwardVel = 70
    end

    if np.currLevelNum == LEVEL_BOWSER_2 and o.oPosY == o.oFloorHeight then
        o.oForwardVel = 30
    end

    if o.oAction == GOOMBA_ACT_JUMP and o.oTimer < 6 then
        cur_obj_rotate_yaw_toward(o.oGoombaTargetYaw, 0x200)
    end

    o.oHomeX = m.pos.x
    o.oHomeY = m.pos.y
    o.oHomeZ = m.pos.z

    if obj_has_model_extended(o, E_MODEL_WOODEN_SIGNPOST) ~= 0 then
        if ia(m) and o.oAction > 2 and -- consider any action outside of the three goomba actions dead
           m.controller.buttonPressed & B_BUTTON ~= 0 then -- press b to trigger dialog
            cutscene_object_with_dialog(CUTSCENE_DIALOG, o, o.oBehParams)
        end
    end

    if o.oTimer >= 16 and o.oAction == OBJ_ACT_SQUISHED then
        squishblood(o)
        local_play(sSplatter, m.pos, 1)
        
        local mo = m.marioObj --Spawns Goombas when Mario kills a Huge Goomba (may change spawned goombas to Tiny Goombas if I can figure out how to attach them to the player)
        if obj_has_behavior_id(o, id_bhvGoomba) ~= 0 and (o.oBehParams2ndByte & (GOOMBA_BP_TRIPLET_FLAG_MASK) ~= 0 or 
        o.oBehParams2ndByte & GOOMBA_BP_SIZE_MASK == 1) then
            spawn_non_sync_object(id_bhvGoomba, E_MODEL_GOOMBA, o.oPosX, o.oPosY, o.oPosZ, function(g) 
                    g.oBehParams2ndByte = 0 
                    g.oMoveAngleYaw = mo.oMoveAngleYaw + 16384
                    g.oBehParams2ndByte = 4
                end)
            spawn_non_sync_object(id_bhvGoomba, E_MODEL_GOOMBA, o.oPosX, o.oPosY, o.oPosZ, function(g) 
                    g.oBehParams2ndByte = 0
                    g.oMoveAngleYaw = mo.oMoveAngleYaw - 16384
                    g.oBehParams2ndByte = 4
                end)

                -- Initial plans were to make Huge Goombas immune to all squish attacks except for ground pounds, but there was a bug with themm escaping their squished state and entering an intangible state. pls fix
                --if m.action ~= ACT_GROUND_POUND and (o.oAction == OBJ_ACT_VERTICAL_KNOCKBACK or o.oAction == OBJ_ACT_HORIZONTAL_KNOCKBACK or o.oAction == OBJ_ACT_SQUISHED) then
                    --o.oVelX = 0
                    --o.oVelY = 0
                    --o.oVelZ = 0
                    --o.oForwardVel = 0
                    --o.oGoombaRelativeSpeed = 0
                    --o.oAction = 0
                --elseif m.action == ACT_GROUND_POUND and o.oAction == OBJ_ACT_SQUISHED then
                    --whatever stops them from escaping ground pounds
                --end
            
                --end
            
        end
    end

    metalhit_attack(o)
end

local function goom_int(m, o, intType) -- Intangibility check specifically for Huge Goombas' goomba spawns on death, could cause unresponsiveness when killing goombas too early.
    if obj_has_behavior_id(o, id_bhvGoomba) ~= 0 and o.oBehParams2ndByte == 4 and o.oTimer <= 5 then
    --djui_chat_message_create("goom")
        if o.oTimer <= 5 then
        return false end
    end
end

local function bhv_custom_thwomp(o)
    local m = nearest_player_to_object(o)
    local np = gNetworkPlayers[0]
    if np.currLevelNum ~= LEVEL_TTC then --TTC is excluded for flood as its nearly unbeatable. Giving the player mercy by turning it off in regular game mode too.	
        o.oThwompRandomTimer = 0 --Instant falling

        if o.oAction == 0 then --ARISE!!
            o.oPosY = o.oPosY + 15
            if o.oTimer == math.random(5, 40) then
                o.oAction = 1
            end
        end
        if o.oAction == 3 then --EARTHQUAAAAKE
            --cur_obj_shake_screen(SHAKE_POS_SMALL)
            spawn_mist_particles()
        end
        if o.oAction == 4 then --No more waiting to rise!
            o.oAction = 0
        end
        if o.oAction == 2 then --CRUSH THEM (randomly) FAST!!
            o.oVelY = o.oVelY - 52
            o.oTimer = 0
        end

        if o.oAction == 3 and o.oTimer > 1 and lateral_dist_between_objects(m, o) < 150 then
            o.oAction = 4
        end

    end
end

local function bhv_custom_pitbowlball(o)
    local m = nearest_player_to_object(o)
    if lateral_dist_between_objects(m, o) < 350 then
        o.oForwardVel = 200
    end
end

local function bhv_custom_large_bomp_loop(o)
    if dist_between_objects(gMarioStates[0].marioObj, o) < 750 then
        o.oAction = 0
        o.oForwardVel = 70
    end
    if o.oPosX > 3830 then
        o.oMoveAngleYaw = o.oMoveAngleYaw - 0x8000
        o.oPosX = 3830
    elseif o.oPosX < 3280 then
        o.oMoveAngleYaw = o.oMoveAngleYaw - 0x8000
        o.oPosX = 3280
    end
end

local function large_bomp_hitbox(o)
    local hitbox = get_temp_object_hitbox()
    hitbox.interactType = INTERACT_DAMAGE
    hitbox.radius = 300
    hitbox.height = 230
    hitbox.damageOrCoinValue = 2
    obj_set_hitbox(o, hitbox)
    o.oIntangibleTimer = 0
    o.collisionData = nil
end

local function cur_obj_rotate_pitch_toward(o, target, increment) --cur_obj_rotate_yaw_toward but for pitch
    if not o then return 0 end
    local startYaw = o.oMoveAnglePitch

    o.oMoveAnglePitch = approach_s16_symmetric(o.oMoveAnglePitch, target, increment);

    o.oAngleVelPitch = o.oMoveAnglePitch - startYaw
    if o.oAngleVelPitch == 0 then
        return true
    else
        return false
    end
end

local function bhv_custom_bullet_bill(o)
    local pitchToMario = obj_pitch_to_object(o, gMarioStates[0].marioObj) -- A vanilla function for this but not one for gCurrentObject??
    local touchFloor = o.oPosY < (find_floor_height(o.oPosX, o.oPosY, o.oPosZ) + 50) -- Thx I'mYourCat
    local touchCeiling = o.oPosY > (find_ceil_height(o.oPosX, o.oPosY, o.oPosZ) - 50) -- Also thx PeachyPeach for this function
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_SET_FACE_ANGLE_TO_MOVE_ANGLE
    if touchFloor or touchCeiling and o.oTimer > 50 then
        o.oAction = 0
        spawn_mist_particles()
    elseif o.oTimer > 50 and dist_between_objects(gMarioStates[0].marioObj, o) < 1000 and o.oAction == 2 then
        --o.oForwardVel = 0
        obj_compute_vel_from_move_pitch(50.0)
        cur_obj_rotate_yaw_toward(o.oAngleToMario, 0xF00)
        cur_obj_rotate_pitch_toward(o, pitchToMario, 0xF00)
    end
    if o.oAction == 0 then
        o.oMoveAnglePitch = 0
        obj_compute_vel_from_move_pitch(0)
    end
    obj_move_xyz_using_fvel_and_yaw(o)
    --djui_chat_message_create(tostring(o.oTimer))
end

local function bhv_custom_tower_platforms(o)
    load_object_collision_model() --had to add this for some reason
    if o.oPosY < 3870 then return end
    o.parentObj = obj_get_first_with_behavior_id(id_bhvWfSolidTowerPlatform)
    or obj_get_first_with_behavior_id(id_bhvWfSlidingTowerPlatform)
    local mObj = gMarioStates[0].marioObj
    local pos = o.header.gfx.cameraToObject
    if mObj.platform == o then
        o.oSubAction = 1
        set_camera_shake_from_hit(SHAKE_POS_MEDIUM)
        play_sound(SOUND_GENERAL_WALL_EXPLOSION, pos)
        play_sound(SOUND_GENERAL_EXPLOSION6, pos)
    end
    if o.parentObj == nil then return end
    if o.parentObj.oSubAction == 1 or o.oSubAction == 1 then
        o.parentObj.oSubAction = 1
        spawn_triangle_break_particles(30, 138, 1, 4)
        spawn_mist_particles()
        obj_mark_for_deletion(o)
    end
end

local function bhv_custom_tower_elevator(o)
    local mObj = gMarioStates[0].marioObj
    local m = gMarioStates[0]
    if mObj.platform == o and o.oAction < 4 then
        o.oAction = 4
        cur_obj_set_home_once()
    elseif o.oAction == 4 then
        if o.oPosY > o.oHomeY - 150 then
            o.oPosY = o.oPosY - 5
            cur_obj_play_sound_1(SOUND_ENV_ELEVATOR1)
        else
            o.oAction = 5
            o.oTimer = 0
        end
    elseif o.oAction == 5 then
        if o.oTimer >= 32 then
            o.oAction = 0
        elseif o.oTimer > 15 and o.oTimer <= 24 then
            o.oPosY = (o.oHomeY - 150) + (750 * (o.oTimer-15)/8)
            --approach_f32((o.oHomeY - 150), (o.oHomeY + 650), 8, 0)
            cur_obj_play_sound_1(SOUND_ENV_ELEVATOR1)
            if mObj.platform == o and m.action ~= ACT_GONE then
                play_sound(SOUND_OBJ_HEAVEHO_TOSSED, mObj.header.gfx.cameraToObject)
                set_mario_action(m, ACT_RAGDOLL, 0)
                m.health = m.health - 0x200
                m.vel.y = 150
            end
        elseif o.oTimer > 24 and o.oTimer < 32 then
            o.oPosY = (o.oHomeY + 600) - (600 * (o.oTimer-24)/8)
            cur_obj_play_sound_1(SOUND_ENV_ELEVATOR1)
        end
    end
end

local function bhv_custom_whomp_slidingpltf(o) --WF Sliding platforms after the weird rock eye guys.
    o.oWFSlidBrickPtfmMovVel = 100
end

local function bhv_custom_whomp(o) --Whomps jump FAR now!
    cur_obj_scale(2)
    --o.oForwardVel = 9.0
    o.oTimer = 101

    --o.oForwardVel = 40
end

local function bhv_custom_seesaw(obj) --SeeSaw Objects spin like windmills
    local np = gNetworkPlayers[0]
    if np.currLevelNum == LEVEL_BITDW or np.currLevelNum == LEVEL_BITS then
        obj.oSeesawPlatformPitchVel = -400
    end
end

local function bhv_custom_tilting_plat(o)
    if cur_obj_is_any_player_on_platform() then
        o.oAngleVelPitch = o.oAngleVelPitch * 5
        o.oFaceAnglePitch = o.oFaceAnglePitch + o.oAngleVelPitch
    end
end

local function bhv_custom_coffin(o)
    o.oBehParams2ndByte = 1 --Not COFFIN_BP_STATIC
    if o.oTimer == 1 then
        o.oUnk1A8 = 4 * random_float()
    end
    if o.oFaceAnglePitch < 0 then
        o.oFaceAnglePitch = 0
    end
    if o.oAction == COFFIN_ACT_IDLE and o.oFaceAnglePitch == 0 and o.oTimer > 0 then
        o.oAction = COFFIN_ACT_STAND_UP
    elseif o.oAction == COFFIN_ACT_IDLE and o.oFaceAnglePitch ~= 0 then
        o.oAngleVelPitch = approach_s16_symmetric(o.oAngleVelPitch, -2000*o.oUnk1A8, 200*o.oUnk1A8)
        o.oTimer = 0
    elseif o.oAction == COFFIN_ACT_STAND_UP then
        if o.oFaceAnglePitch ~= 0x4000 then
            approach_s16_symmetric(o.oAngleVelPitch, -1000*o.oUnk1A8, 200*o.oUnk1A8)
            obj_face_pitch_approach(0x4000, o.oAngleVelPitch)
        end
        o.oTimer = o.oTimer + 3
    end
end

local function bhv_custom_staircase_step(o)
    --o.oFlags = OBJ_FLAG_COMPUTE_ANGLE_TO_MARIO | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_SET_FACE_YAW_TO_MOVE_YAW | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    local m = nearest_mario_state_to_object(o)
    --local mObj = m.marioObj
    --local angleToPlayer = obj_angle_to_object(o, mObj)
    --local dist = dist_between_objects(mObj, o)
    if mario_is_within_rectangle(o.oPosX -300, o.oPosX +300, 900, 1500) ~= 0 and o.oAction == 0 then
        o.oAction = 1
        o.oForwardVel = 70
        o.collisionData = nil
        local_play(sMetal2, m.pos, 0.5)
    elseif o.oAction == 1 then
        if mario_is_within_rectangle(o.oPosX -128, o.oPosX +128, o.oPosZ-102, o.oPosZ+102) ~= 0 and
        m.pos.y > o.oPosY and m.pos.y < o.oPosY +614 then
            m.squishTimer = 50
        end
        if o.oTimer > 100 then
            obj_mark_for_deletion(o)
        end
    end
    --djui_chat_message_create(tostring(o.oAction))
    cur_obj_move_xz_using_fvel_and_yaw()
end

local function bhv_custom_haunted_bookshelf(o) --Anti Speedrun Trick >:) (Unused for being too much of a troll)
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local angleToPlayer = obj_angle_to_object(o, mObj)
    if o.oAction == 0 and angleToPlayer > -2000 and angleToPlayer < 2000 and m.pos.y >= 1024 and m.pos.z < 2225 then
        o.oAction = 3
        o.oForwardVel = 70
        o.oRoom = 0
        local hitbox = get_temp_object_hitbox()
        hitbox.radius = 300
        hitbox.height = 750
        obj_set_hitbox(o, hitbox)
        o.oIntangibleTimer = 0
        o.collisionData = nil
        local_play(sMetal2, m.pos, 1)
    elseif o.oAction == 3 then
        o.oFaceAnglePitch = 32768 --I can't change o.oFaceAngleYaw for this specific behavior so yeah
        o.oFaceAngleRoll = 32768
        if obj_check_if_collided_with_object(o, mObj) ~= 0 then
            m.squishTimer = 50
        end
        if o.oTimer > 100 then
            obj_mark_for_deletion(o)
        end
    end
    cur_obj_move_xz_using_fvel_and_yaw()
end

local function bhv_custom_sign(o) --This is the single most evil addition to the game. Real proud of this one :')
    --m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
    local m = nearest_player_to_object(o)
    if dist_between_objects(m, o) < 500 then
        spawn_sync_if_main(id_bhvGoomba, E_MODEL_WOODEN_SIGNPOST, o.oPosX, o.oPosY, o.oPosZ, function (goomba)
            obj_copy_angle(goomba, o)
            goomba.oBehParams = o.oBehParams2ndByte
        end, 0)
        obj_mark_for_deletion(o)
    end
end

local function bhv_custom_toxbox(o) -- Yeah this isn't doing anything. These guys move in a stupid way that I can't understand.
    if o ~= nil then
        --o.oTimer = o.oTimer + 1
        --tox_box_move(0, 1, 1, 0)
    end
end

local function bhv_custom_tree(o) -- Trees shoot into the sky until blowing up after 1.66 seconds.
    local m = nearest_mario_state_to_object(o)
    local np = gNetworkPlayers[0]
    local mObj = m.marioObj
    local grab_pole = m.action == ACT_GRAB_POLE_FAST or m.action == ACT_GRAB_POLE_SLOW
    local hoot_act = np.currLevelNum == LEVEL_WF and np.currActNum > 2
    
    if lateral_dist_between_objects(m.marioObj, o) < 150 and grab_pole and o.oAction ~= 2 then
        o.oTimer = 0
        o.oAction = 2
    end
    
    if o.oAction == 2 and o.oTimer == 1 then
        local_play(sFireworkLaunch, m.pos, 2)
    end

    if o.oAction == 2 and o.oTimer < 50 then
        o.oPosY = o.oPosY + 50
    elseif o.oAction == 2 and o.oTimer == 50 then
        obj_spawn_yellow_coins(o, 3)
        obj_mark_for_deletion(o)   
        spawn_non_sync_object(id_bhvSmallExplosion, E_MODEL_EXPLOSION, o.oPosX, o.oPosY, o.oPosZ, nil)
        set_camera_shake_from_hit(SHAKE_POS_MEDIUM)
        if lateral_dist_between_objects(m.marioObj, o) < 250 then
            if m.flags & MARIO_METAL_CAP == 0 then 
                m.squishTimer = 50
            elseif m.flags & MARIO_METAL_CAP ~= 0 then -- doesn't do anything and i have no idea why
                set_mario_action(m, ACT_FLAG_AIRBORNE, 0)
                set_mario_action(m, ACT_HARD_BACKWARD_AIR_KB, 0)
                play_sound(SOUND_ACTION_METAL_BONK, m.pos)
                stop_cap_music()
            end
        end

        if hoot_act and not gGlobalSyncTable.romhackcompatibility then
            local hoot = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvHoot)
            if hoot and hoot.oHootAvailability ~= HOOT_AVAIL_WANTS_TO_TALK then
                hoot.oHootAvailability = HOOT_AVAIL_WANTS_TO_TALK
                play_secondary_music(0,0,0,0)
            end
        end
    end
end

local function bhv_custom_bowlball(bowlball) -- I've got big balls, oh I've got big balls. They're such BIG balls, fancy big balls! And he's got big balls, and she's got big balls!
    local np = gNetworkPlayers[0]
    obj_scale(bowlball, 1.8)
    if np.currLevelNum ~= LEVEL_BOB then
        bowlball.oForwardVel = bowlball.oForwardVel + 1
        bowlball.oFriction = 1
    else
        bhv_bowling_ball_loop()
        bhv_bowling_ball_loop()
        bhv_bowling_ball_loop() -- Nyoom
        bhv_bowling_ball_loop()
        bhv_bowling_ball_loop()
    end
    if bowlball.oTimer > 180 then
        obj_mark_for_deletion(bowlball)
    end
end

local function bhv_custom_bowlballspawner(o) -- Idk if this actually does anything, but maybe?
    o.oBBallSpawnerSpawnOdds = 1

end

local function bhv_bowser_key_custom_init(o) --Bow1 spawns Ukiki minigame, Bow2 spawns Goomba minigame
    local np = gNetworkPlayers[0]

    if np.currLevelNum == LEVEL_BOWSER_1 then
        spawn_sync_if_main(id_bhvUkiki, E_MODEL_UKIKI, o.oPosX, o.oPosY + 50, o.oPosZ, function (ukiki)
            ukiki.oAction = 3
        end, 0)
        cur_obj_disable_rendering_and_become_intangible(o)
        fadeout_music(0)
        stream_play(smwbonusmusic)
    end
    if np.currLevelNum == LEVEL_BOWSER_2 then
        cur_obj_disable_rendering_and_become_intangible(o)
        fadeout_music(0)
        local_play(sBows2intro, gCamera.pos, 1)
    end
end

local function bhv_bowser_key_custom_loop(o) --Bow1 spawns Ukiki minigame, Bow2 spawns Goomba minigame
    --djui_chat_message_create(tostring(o.oTimer))
    --djui_chat_message_create(tostring(o.oAction))
    local np = gNetworkPlayers[0]



    if np.currLevelNum == LEVEL_BOWSER_1 then
        local ukiki = obj_get_nearest_object_with_behavior_id(o, id_bhvUkiki)
        if ukiki then
            cur_obj_disable_rendering_and_become_intangible(o)
            obj_copy_pos(o, ukiki)
            o.oBehParams = 1
        elseif o.oBehParams == 1 then
            cur_obj_enable_rendering_and_become_tangible(o)
            o.oAction = 0
            o.oPosY = o.oPosY + 200
            o.oBehParams = 0
        end
    end


    if np.currLevelNum == LEVEL_BOWSER_2 then
        if o.oAction == 1 then
            if o.oTimer <= 60 then
                cur_obj_disable_rendering_and_become_intangible(o)
            end
            if o.oTimer == 42 then
                stream_play(musicbows2)
            end

            if o.oTimer == 40 then
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

            if o.oTimer == 100 then
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

        local goomba = obj_get_first_with_behavior_id(id_bhvGoomba)
        if goomba then
            cur_obj_disable_rendering_and_become_intangible(o)
            obj_copy_pos(o, goomba)
            o.oBehParams = 1
        elseif o.oBehParams == 1 then
            cur_obj_enable_rendering_and_become_tangible(o)
            --o.oAction = 0
            if o.oPosY >= o.oFloorHeight then
                o.oPosY = o.oPosY - 5
            else
                o.oBehParams = 0
                stream_fade(50)
            end
        end
    end
end

hook_behavior(id_bhvUkiki, OBJ_LIST_GENACTOR, false, function (o)
    local np = gNetworkPlayers[0]
    o.oPosY = o.oHomeY
    if np.currLevelNum == LEVEL_BOWSER_1 then
        local ukiki = obj_count_objects_with_behavior_id(id_bhvUkiki)
        if ukiki > 1 then
            obj_mark_for_deletion(o)
        end
    end
end, nil)

local function lava_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = COL_LAVA
    o.oCollisionDistance = 10000
    o.header.gfx.skipInViewCheck = true
    bhv_init_room()
end

local function lava_loop(o)
    local m = gMarioStates[0]
    np = gNetworkPlayers[0]
    if np.currLevelNum ~= LEVEL_JRB and np.currLevelNum ~= LEVEL_HMC then
        load_object_collision_model()
    end
end

local function bhv_checkerboard_platform(o)
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

local function bhv_ferris_wheel_axle(o)
    local np = gNetworkPlayers[0]
    o.oFaceAngleRoll = o.oFaceAngleRoll + 400
end

local function get_pressure_point(o)
    local avg = vec3f()
    local objPos = vec3f()
    object_pos_to_vec3f(objPos, o)
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
    vec3f_sub(avg, objPos)
    return avg
end

local function bhv_ferris_wheel(o)
    local np = gNetworkPlayers[0]
    if np.currLevelNum ~= LEVEL_BITS then
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
end

local function bhv_custom_grindel(o)
    o.oTimer = 60
    cur_obj_move_standard(2)
end

local function bhv_custom_spindel(o)
    secondDoor = 20 - o.oSpindelUnkF4
    sp1C = sins(o.oMoveAnglePitch * 32) * 46.0
    o.oPosZ = o.oPosZ + o.oVelZ
    if (o.oTimer < secondDoor * 1) then
        if (o.oSpindelUnkF8 == 0) then
            o.oVelZ = 500
            o.oAngleVelPitch = 128
        else
            o.oVelZ = -500
            o.oAngleVelPitch = -128
        end
    end	
end

local function bhv_custom_firebars(o)
    o.oMoveAngleYaw = -2048
end

local function bhv_custom_flamethrower(o)
    local np = gNetworkPlayers[0]
    if not gGlobalSyncTable.romhackcompatibility and np.currLevelNum == LEVEL_BITFS then return end
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)
    if dist < 1500 then
        o.oAction = 1
        o.oTimer = 0
    elseif dist < 1500 and o.oAction == 1 then
        if o.oTimer > 60 then
            o.oTimer = 60
        end
    end
end

local function bhv_custom_hex_platform(o)
    o.oAngleVelYaw = 5000
    o.oMoveAngleYaw = o.oMoveAngleYaw + 4744
    load_object_collision_model()
end

local function bhv_custom_rotating_platform(o) --copied from above to fix visual disparity
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

local function bhv_backroom_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 10000
    o.collisionData = COL_BACKROOM
    o.header.gfx.skipInViewCheck = true
    hud_hide()
end

local function bhv_backroom_loop(o)
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

local function bhv_backroom_smiler_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.hitboxRadius = 160
    o.hitboxHeight = 100
    o.oWallHitboxRadius = 30
    o.oGravity = 1
    obj_scale(o, 1.6)
    obj_set_billboard(o)

end

local function bhv_backroom_smiler_loop(o)
    local m = gMarioStates[0]
    local s = gStateExtras[0]
    local angletomario = obj_angle_to_object(o, m.marioObj)
    local np = gNetworkPlayers[0]

    if np.currLevelNum == LEVEL_TTM then
        local lantern = obj_get_nearest_object_with_behavior_id(o, id_bhvLantern)
        local distance = dist_between_objects(m.marioObj, lantern)
        if distance < 1100 or s.hasNightvision then
            obj_unused_die()
            stop_secondary_music(0)
        end
    end

    cur_obj_update_floor_height_and_get_floor()
    --if o.oPosY > o.oFloorheight + 200 or o.oPosY < m.pos.y then
        o.oPosY = o.oFloorHeight + 200
    --end



    o.oFaceAngleYaw = angletomario - 16384
    --load_object_collision_model()
    obj_turn_toward_object(o, m.marioObj, 16, 0x800)
    o.oForwardVel = 20
    object_step()
    if o.oTimer % 280 == 1 and np.currLevelNum ~= LEVEL_TTM then
        local_play(sSmiler, o.header.gfx.pos, 1)
    end
    if obj_check_hitbox_overlap(o, m.marioObj) and not s.isdead then
        m.health = 0xff
        s.bottomless = true
        network_play(sSplatter, m.pos, 1, m.playerIndex)
        network_play(sCrunch, m.pos, 1, m.playerIndex)
        audio_sample_stop(gSamples[sSmiler])
        squishblood(m.marioObj)
        
        mario_blow_off_cap(m, 15)
        set_mario_action(m, ACT_BITTEN_IN_HALF, 0)
        if mod_storage_load("smiler") == "1" then
            --nothing
        else
            if gGlobalSyncTable.gameisbeat and np.currLevelNum ~= LEVEL_TTM then
                spawn_sync_object(id_bhvTrophy, E_MODEL_GOALPOST, m.pos.x, m.pos.y, m.pos.z, function(t)
                    t.oBehParams = 8 << 16 | 1
                end)
            end
        end
        obj_mark_for_deletion(o)

        
    end
end

local function bhv_custom_crushtrap(o)
    if mario_is_within_rectangle(o.oPosX -100, o.oPosX + 100, o.oPosX -100, o.oPosX + 100) then
        if o.oAction == 1 then
            o.oRollingLogUnkF4 = o.oRollingLogUnkF4 + 8
        end

        if o.oAction == 2 then
            o.oPosY = o.oHomeY + sins(o.oTimer * 0x1000) * 10.0
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

local function bhv_custom_swing(o) -- Mostly in RR, might be other maps too. Is fun!
    if (o.oFaceAngleRoll < 0) then
        o.oSwingPlatformSpeed = o.oSwingPlatformSpeed + 64.0
    else
        o.oSwingPlatformSpeed = o.oSwingPlatformSpeed - 64.0
    end
end

local function bhv_custom_rotating_platform(o) --Spinning platform high up on RR. (Plus other maps??)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oAngleVelYaw = o.oAngleVelYaw + 1600
    o.oFaceAngleYaw = o.oFaceAngleYaw + o.oAngleVelYaw
end

local function bhv_custom_heart(o)
    local m = gMarioStates[0]
    --if is_point_within_radius_of_any_player(200, 50, 200, 200) ~= 0 then
    if mario_is_within_rectangle(o.oPosX - 200, o.oPosX + 200, o.oPosZ - 200, o.oPosZ + 200) ~= 0 then
        obj_mark_for_deletion(o)
        spawn_mist_particles()
        local_play(sFart, m.pos, 1)
    end
end

local function bhv_custom_moving_plats(o)
    if o.oAction == PLATFORM_ON_TRACK_ACT_MOVE_ALONG_TRACK then
        bhv_platform_on_track_update()
        bhv_platform_on_track_update()
        bhv_platform_on_track_update()
        bhv_platform_on_track_update()
        o.oVelX,   o.oVelY,   o.oVelZ,   o.oAngleVelYaw =
        o.oVelX*5, o.oVelY*5, o.oVelZ*5, o.oAngleVelYaw*5
    end
end

local function bhv_custom_tuxie(o)
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

local function bhv_netherportal_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oCollisionDistance = 800
    obj_set_model_extended(o, E_MODEL_NETHERPORTAL)
    o.collisionData = COL_NETHERPORTAL
    o.header.gfx.skipInViewCheck = true
end

local function bhv_netherportal_loop(o)
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

local function bhv_custom_merry_go_round(o)
    if o.oMerryGoRoundStopped == 0 then
        o.oAngleVelYaw = o.oAngleVelYaw + 2048
        o.oMoveAngleYaw = o.oMoveAngleYaw + o.oAngleVelYaw
        o.oFaceAngleYaw = o.oFaceAngleYaw + o.oAngleVelYaw - 128
    end
end

local function bhv_custom_tumbling_bridge(o)
    local m = nearest_mario_state_to_object(o)
    if dist_between_objects(m.marioObj, o) < 500 and
    obj_has_behavior(o.parentObj, get_behavior_from_id(id_bhvBbhTumblingBridge)) ~= 0 then
        o.oInteractStatus = o.oInteractStatus | INT_STATUS_INTERACTED
    end
end

local function bhv_custom_piano(o)
    local m = nearest_mario_state_to_object(o)
    if dist_between_objects(m.marioObj, o) < 700 then
        local angleToPlayer = obj_angle_to_object(o, m.marioObj)
        o.oHomeX = m.pos.x
        o.oHomeZ = m.pos.z
        o.oAction = MAD_PIANO_ACT_ATTACK
        o.oForwardVel = 25
        cur_obj_rotate_yaw_toward(angleToPlayer, 2400)
    end
end

local function bhv_custom_chairs(o)
    if (o.oHauntedChairUnkF4 ~= 0) then
        if (o.oHauntedChairUnkF4 == 0) then
            obj_compute_vel_from_move_pitch(90.0)
        end
    end
    if o.oHauntedChairUnkF4 > 1 and o.oHauntedChairUnkF4 < 20 then
        o.oHauntedChairUnkF4 = o.oHauntedChairUnkF4 - 2
    end
    o.oTimer = o.oTimer + 2
    obj_move_xyz_using_fvel_and_yaw(o)
end

local function bhv_custom_books(o)
    --for i = 0, 2 do
        bhv_flying_bookend_loop()
    --end
end

local function bhv_goalpost_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = COL_GOALPOST
    -- o.oCollisionDistance = 8000
    o.hitboxHeight = 1900
    o.hitboxRadius = 470
    --o.hitboxHeight = 70
    --o.hitboxRadius = 1070
    o.hitboxDownOffset = -507
end

local function bhv_goalpost_loop(o)
    --o.header.gfx.scale.z = o.hitboxRadius / 100
    --o.header.gfx.scale.y = o.hitboxHeight / 100
    local m = gMarioStates[0]
    local mp = nearest_player_to_object(o)
    local tuxie = obj_get_nearest_object_with_behavior_id(mp, id_bhvSmallPenguin)
    
    if tuxie and o.oTimer > 60 and obj_check_hitbox_overlap(o, tuxie) then --GRANT TROPHY #9
        local troph = obj_get_first_with_behavior_id(id_bhvTrophy)
        if troph == nil then
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
        end

        --play_secondary_music(SEQ_EVENT_SOLVE_PUZZLE, 1, 1, 1)
        play_sound(SOUND_MENU_COLLECT_SECRET, gMarioStates[0].pos)
    end

    load_object_collision_model()
end

local function warp_init(o)
    o.hitboxHeight = 100
    o.hitboxRadius = 100
end

local function warp_loop(o)
    local m = gMarioStates[0]
    if obj_check_hitbox_overlap(o, m.marioObj) and m.action == ACT_IDLE then
        play_sound(SOUND_GENERAL_VANISH_SFX, m.marioObj.header.gfx.cameraToObject)
        m.pos.x = 5514
        m.pos.y = 1613
        m.pos.z = 3159
    end
end

local function bhv_custom_spindrift(o)
    if mario_is_within_rectangle(o.oPosX - 500, o.oPosX + 500, o.oPosZ - 500, o.oPosZ + 500) ~= 0 then
        o.oForwardVel = 30
    end
end

local function snowman_body_loop(o)
    if o.oAction == 1 then
        if o.oPosY < -700 then
            o.oForwardVel = o.oForwardVel * 1.25
        elseif o.oPosY > -40 then
            o.oForwardVel = o.oForwardVel * 1.1
        end
        --djui_chat_message_create(tostring(o.oForwardVel))
    end
end

local function bhv_custom_slidingplatform2(o)
    local np = gNetworkPlayers[0]
    if np.currLevelNum == LEVEL_BITDW or np.currLevelNum == LEVEL_BITFS then
        obj_mark_for_deletion(o)
    end
end

local function bhv_custom_animates_on_floor_switch_press(o)
    local np = gNetworkPlayers[0]
    if np.currLevelNum ~= LEVEL_BITDW then return end
    if o.oFloorSwitchPressAnimationUnkF4 < 161 and o.oFloorSwitchPressAnimationUnkF4 ~= 0 then
        o.oFloorSwitchPressAnimationUnkF8 = 9 * o.oFloorSwitchPressAnimationUnkF4/200
        if o.oFloorSwitchPressAnimationUnkF8 % 2 == 0 and o.oTimer > 30 then
            cur_obj_play_sound_1(SOUND_GENERAL_BUTTON_PRESS_2_LOWPRIO);
            o.oTimer = 0
        end
    end
    --djui_chat_message_create(tostring(o.oFloorSwitchPressAnimationUnkF4))
end

local function bhv_custom_circlingamp(o)
    --local random = math.random(1,2)
    if o.oTimer < 30 then
        o.oPosX = o.oHomeX + sins(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 1
        o.oPosZ = o.oHomeZ + coss(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 1
    elseif o.oTimer <= 33 then
        o.oPosX = o.oHomeX + sins(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 0.1
        o.oPosZ = o.oHomeZ + coss(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 0.1
    end
    if o.oTimer >= 40 then
        o.oPosX = o.oHomeX + sins(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 2
        o.oPosZ = o.oHomeZ + coss(o.oMoveAngleYaw) * o.oAmpRadiusOfRotation * 2
    end
    if o.oTimer < 20 then
        cur_obj_scale(2) 
    elseif o.oTimer <= 49 then
        cur_obj_scale(1)
    end
    if o.oTimer >= 50 then
        cur_obj_scale(2)
    end
    
    if o.oTimer >= 62 then
        local random = math.random(1, 10)
        o.oTimer = random
    end
end

local function bhv_custom_squarishPathMoving(o)
    local np = gNetworkPlayers[0]
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local pos = o.header.gfx.cameraToObject
    if o.oAction == 5 then
        o.oTimer = o.oTimer + 1
        play_sound(SOUND_GENERAL2_SWITCH_TICK_SLOW, gGlobalSoundSource)
        if o.oTimer >= 90 then
            spawn_triangle_break_particles(30, 138, 1, 4)
            spawn_mist_particles()
            set_camera_shake_from_hit(SHAKE_POS_MEDIUM)
            play_sound(SOUND_GENERAL_WALL_EXPLOSION, pos)
            play_sound(SOUND_GENERAL_EXPLOSION6, pos)
            obj_mark_for_deletion(o)
        end
    elseif mObj.platform == o then
        o.oAction = 5
    end
    if (np.currLevelNum == LEVEL_BITDW and o.oPosY <= -2959) or np.currLevelNum == LEVEL_BITFS then
        obj_mark_for_deletion(o)
    end
    --djui_chat_message_create(tostring(obj_get_nearest_object_with_behavior_id(mObj, id_bhvSquarishPathMoving).oTimer))
end

local function bhv_custom_ActivatedBackAndForthPlatform(o)
    local m = nearest_mario_state_to_object(o)
    local np = gNetworkPlayers[0]
    local pos = o.header.gfx.cameraToObject

    if np.currLevelNum == LEVEL_BITFS and m.pos.y >= o.oPosY -10 and mario_is_within_rectangle(o.oPosX - 500, o.oPosX + 500, o.oPosZ - 500, o.oPosZ + 500) ~= 0 then
        spawn_triangle_break_particles(30, 138, 1, 4)
        spawn_mist_particles()
        set_camera_shake_from_hit(SHAKE_POS_MEDIUM)
        play_sound(SOUND_GENERAL_WALL_EXPLOSION, pos)
        play_sound(SOUND_GENERAL_EXPLOSION6, pos)
        obj_mark_for_deletion(o)
    --elseif np.currLevelNum == LEVEL_BITS and m.pos.y >= o.oPosY -10 and mario_is_within_rectangle(1650, 2300, -1240, -440) ~= 0 then
        --spawn_triangle_break_particles(30, 138, 1, 4)
        --spawn_mist_particles()
        --set_camera_shake_from_hit(SHAKE_POS_MEDIUM)
        --play_sound(SOUND_GENERAL_WALL_EXPLOSION, pos)
        --play_sound(SOUND_GENERAL_EXPLOSION6, pos)
        --obj_mark_for_deletion(o)
        --spawn_non_sync_object(id_bhvActivatedBackAndForthPlatform, E_MODEL_BITS_ARROW_PLATFORM, 2793, 2325, -904, function(b)
        --o.oFaceAngleYaw = -16384 end)
    end
end

local function bhv_custom_yoshi(o)
    local m = gMarioStates[0]
    if o.oAction == 6 then
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

local function bhv_secretwarp_init(o)
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

local function bhv_secretwarp_loop(o)
    local m = gMarioStates[0]
    local np = gNetworkPlayers[0]
    local s = gStateExtras[0]
    if obj_check_hitbox_overlap(m.marioObj, o) and (m.controller.buttonPressed & Z_TRIG) ~= 0 and m.action ~= ACT_UNLOCKING_STAR_DOOR  then
        
        if np.currLevelNum == LEVEL_SECRETHUB then
            s.turningGold = true
            m.faceAngle.y = -10477
            set_mario_action(m, ACT_QUICKSAND_DEATH, 0)
            m.marioObj.oTimer = 0
        else
            if m.numStars >= 50 or gGlobalSyncTable.gameisbeat then
                if not gGlobalSyncTable.gameisbeat then
                    mod_storage_save("file"..get_current_save_file_num().."gameisbeat", "true")
                    gGlobalSyncTable.gameisbeat = true
                    djui_chat_message_create("Trophy Hunt is now unlocked for all players!")
                end

                set_mario_action(m, ACT_UNLOCKING_STAR_DOOR, 0)
                m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
                m.pos.y = m.pos.y + 120
                o.oTimer = 0
            else
                djui_chat_message_create("You need at least 50 stars to enter!")
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

local function flatstar_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oFaceAnglePitch = o.oFaceAnglePitch - 16384
end

local function flatstar_loop(o)
    o.oFaceAngleRoll = o.oFaceAngleRoll + 1000
    obj_scale_xyz(o, 1, 1, 0.1)
    cur_obj_become_intangible()
end

local function bouncy_init(o)
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

local function bouncy_loop(o)
    local m = gMarioStates[0]
    obj_set_billboard(o)
    cur_obj_move_using_fvel_and_gravity()
    if o.oPosY == o.oFloorHeight then
        o.oAction = 1
    end

    if is_within_100_units_of_mario(o.oPosX, o.oPosY, o.oPosZ) ~= 0 then
        m.numLives = m.numLives + 1
        play_sound(SOUND_GENERAL_COLLECT_1UP, gGlobalSoundSource)
        obj_mark_for_deletion(o)
    end
end

local function bhv_squishable_platform_loop(o)
    o.oPlatformTimer = o.oPlatformTimer + 768
end

local function stopwatch_init(o)
    o.hitboxHeight = 75
    o.hitboxRadius = 75
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    obj_scale(o, 0.5)
    o.oAction = 0
end

local function stopwatch_loop(o)
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
        gGlobalSyncTable.timerMax = 1410
        s.timeattack = true
        spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, 5748, 4403, 85, function(t)
            t.oFaceAngleYaw = 0
            t.oFaceAnglePitch = 0
            t.oFaceAngleRoll = 0
            t.oBehParams = 10 << 16 | 1
        end)
    end

    if o.oAction == 1 and o.oTimer == 1410 then
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

local function squishblood_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true	
    local z, normal = vec3f(), cur_obj_update_floor_height_and_get_floor().normal
    o.oFaceAnglePitch = 16384-calculate_pitch(z, normal)
    o.oFaceAngleYaw = calculate_yaw(z, normal)
    o.oFaceAngleRoll = 0
    --djui_chat_message_create(tostring(o.oBehParams))
    if o.oBehParams ~= 1 then --This is to stop blood from gibs shooting out of the ground if you kill an airborn enemy.
        gibs(o)
    end
end

local function squishblood_loop(o)
    local m = gMarioStates[0]
    cur_obj_update_floor()

    if o.oTimer > 900 then --This protects blood spam and low FPS
        obj_mark_for_deletion(o)
    end

    if o.oFloor == SURFACE_DEATH_PLANE then
        obj_mark_for_deletion(o)
    end
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

local function gib_init(o)
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

    o.oRandomSpinVelX = math.random(100, 13000)
    o.oRandomSpinVelY = math.random(100, 13000)
    o.oRandomSpinVelZ = math.random(100, 13000)


end

local function gib_loop(o)
    local m = gMarioStates[0]
    local s = gStateExtras[0]
    if m.marioObj.oTimer < 10 and not s.iwbtg then --This protects from gib spam and low FPS
        obj_mark_for_deletion(o)
    end

    cur_obj_update_floor_height_and_get_floor()
    if o.oPosY > o.oFloorHeight then
        cur_obj_move_using_fvel_and_gravity()
        cur_obj_move_using_vel()
        cur_obj_update_floor_height_and_get_floor()
        o.oFaceAnglePitch = o.oFaceAnglePitch + o.oRandomSpinVelX
        o.oFaceAngleRoll = o.oFaceAngleRoll + o.oRandomSpinVelY
        o.oFaceAngleYaw = o.oFaceAngleYaw + o.oRandomSpinVelZ
    else
        o.oPosY = o.oFloorHeight
    end

    if o.oTimer > 600 then -- 40 second timer before deleting. 
        obj_mark_for_deletion(o)
    end

end

local function firering_init(o)
    obj_set_billboard(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    local random = math.random(1,65536)
    o.oBounciness = 0
    o.oForwardVel = 30
    o.oFaceAngleYaw = o.oFaceAngleYaw + random
    obj_scale(o, 4)
end

local function firering_loop(o)
    o.oAnimState = o.oTimer % 4
    cur_obj_move_using_fvel_and_gravity()
    if o.oTimer > 20 then
        obj_mark_for_deletion(o)
    end
end

local function wiggler_loop(o)
    if o.oAction == WIGGLER_ACT_WALK then
        o.oForwardVel = 80
        cur_obj_rotate_yaw_toward(0, 0x400)
    end
end

local function eyerok_loop(o)
    if o.oAction == EYEROK_BOSS_ACT_WAKE_UP then
        --o.oEyerokBossNumHands = o.parentObj.oEyerokBossNumHands + 4
    end
end

local function dorrie_dead(o)
    local np = gNetworkPlayers[0]
    local m = gMarioStates[0]
    local nm = nearest_mario_state_to_object(o)
    if np.currLevelNum ~= LEVEL_HELL then
        if o.oAction == DORRIE_ACT_LOWER_HEAD then
            local_play(sDorrie, m.pos, 1)
            gibs(o)
            o.oAction = 9
            o.oTimer = 0
        end
        if o.oAction == 9 then --Dorrie dies and sinks to the depths...
            obj_set_model_extended(o, DORRIE_DEAD)
            o.oDorrieVelY = -3
            o.oPosY = o.oPosY - 25
            o.oFaceAnglePitch = o.oFaceAnglePitch - 20
            o.oMoveAnglePitch = o.oFaceAnglePitch
            --djui_chat_message_create(tostring(o.oTimer))
            if o.oTimer <= 359 then
                play_secondary_music(0, 0, 0, 0)
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

local function gorrie_init(o)
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

    o.oAction = GORRIE_TRAVEL_TO_GOAL

    network_init_object(o, true, nil)

end

local function gorrie_loop(o)
    load_object_collision_model()
    cur_obj_init_animation(1)
    cur_obj_move_xz_using_fvel_and_yaw()
    local m = gMarioStates[0]
    local np = gNetworkPlayers[0]
    local nm = nearest_mario_state_to_object(o)
    --local dorriemounted = cur_obj_is_mario_on_platform()
    local dorriemounted = cur_obj_is_any_player_on_platform()
    local goal = obj_get_first_with_behavior_id(id_bhvNetherPortal)
    if goal == nil then
        goal = obj_get_first_with_behavior_id(id_bhvStaticObject)
    end

    o.oAnimState = o.oTimer % 90

    if o.oAction == GORRIE_WAITING_FOR_DISEMBARK then
        --djui_chat_message_create("Waiting for player to disembark!")
        o.oTimer = 0
        o.oForwardVel = 0
        local warp = obj_get_nearest_object_with_behavior_id(o, id_bhvFadingWarp)
        local warpangle = obj_angle_to_object(o, warp)
        obj_turn_toward_object(o, warp, 16, 256)
        obj_face_yaw_approach(warpangle, 256)
    end

    if o.oAction == GORRIE_TRAVEL_TO_GOAL then
        --djui_chat_message_create("Traveling to Netherportal!")
        local goal_angle = obj_angle_to_object(o, goal)
        obj_face_yaw_approach(goal_angle, 256)
        obj_turn_toward_object(o, goal, 16, 256)
        o.oForwardVel = 25
        --obj_init_animation(o, 1)
    end

    if o.oAction == GORRIE_WAITING_FOR_PLAYERS_TO_BOARD then
        --djui_chat_message_create("Waiting for player to board!")
        local goal_angle = obj_angle_to_object(o, goal)
        obj_turn_toward_object(o, goal, 16, 256)
        obj_face_yaw_approach(goal_angle, 256)
        o.oForwardVel = 0
    end

    if o.oAction == GORRIE_TRAVEL_TO_HOME then
        --djui_chat_message_create("Travelling to home!")
        local angletohome = cur_obj_angle_to_home()
        o.oForwardVel = 15
        obj_face_yaw_approach(angletohome, 256)
        o.oFaceAngleYaw = angletohome
        o.oMoveAngleYaw = o.oFaceAngleYaw
    end

    if o.oAction == GORRIE_HOME_IDLE then
        --djui_chat_message_create("home!")
        o.oForwardVel = 0
        local goal_angle = obj_angle_to_object(o, goal)
        local anglesmooth = obj_face_yaw_approach(goal_angle, 256)
        obj_turn_toward_object(o, goal, 16, 512)
        obj_face_yaw_approach(goal_angle, 512)
    end

    --Actual Gorrie Code
    if dorriemounted == 1 then
        if dist_between_objects(o, goal) < 1200 then --Gorrie is at the Netherportal and players need to jump off...
            if o.oAction ~= GORRIE_WAITING_FOR_DISEMBARK then
                o.oAction = GORRIE_WAITING_FOR_DISEMBARK
            end
        else
            if o.oAction ~= GORRIE_TRAVEL_TO_GOAL then --Gorrie is on the way to the nether portal.
                o.oAction = GORRIE_TRAVEL_TO_GOAL
                if dist_between_objects(o, m.marioObj) < 1200 and o.oTimer % 60 then
                    network_send_object(o, true)
                end
            end
        end
    else
        if o.oAction == GORRIE_HOME_IDLE then --Gorrie is home and doing nothing...
            if o.oAction ~= GORRIE_WAITING_FOR_PLAYERS_TO_BOARD then
                o.oAction = GORRIE_WAITING_FOR_PLAYERS_TO_BOARD
            end
        else --Nobody is aboard Gorrie and Gorrie needs to travel home.
            if cur_obj_lateral_dist_from_obj_to_home(o) >= 50 then
                if o.oAction ~= GORRIE_TRAVEL_TO_HOME then
                    o.oAction = GORRIE_TRAVEL_TO_HOME
                end
            else --Gorrie has made it back home and needs to go to idle to ready herself for player boarding.
                if o.oAction ~= GORRIE_HOME_IDLE then
                    o.oAction = GORRIE_HOME_IDLE
                end
            end
        end
    end
end

local KLEPTO_ACT_CHASE_MARIO = 8
local KLEPTO_ACT_DIE = 9
local KLEPTO_ACT_SEARCH_FOR_MARIO = 10

local KleptoHit = 0 -- used to track the amount of times klepto has been hit

local function bhv_klepto_init(o)
    local np = gNetworkPlayers[0]
    if np.currActNum > 1 then
        o.oAction = KLEPTO_ACT_SEARCH_FOR_MARIO
        o.oBehParams2ndByte = 0
    end
    KleptoHit = 0
end

local function bhv_klepto_loop(o)
    local m = gMarioStates[0]
    local player = nearest_player_to_object(o)
    local np = gNetworkPlayers[0]

    --djui_chat_message_create(tostring(o.oTimer))

    if (o.oAction == KLEPTO_ACT_STRUCK_BY_MARIO) then
        gibs(o)
        network_play(sPunch, m.pos, 1, m.playerIndex)
        o.oAction = KLEPTO_ACT_SEARCH_FOR_MARIO
        o.oTimer = 2
    end

    if o.oAction == KLEPTO_ACT_SEARCH_FOR_MARIO then -- Klepto is pissed and hunts for nearest player.
        if o.oTimer == 3 and KleptoHit < 21 then
            obj_spawn_yellow_coins(o, 2)
            KleptoHit = KleptoHit + 1 
        elseif KleptoHit == 21 then -- after 20 hits, Klepto automatically dies (KleptoHit is always set to 1 on initialization due to his action being set to 10, but pretend it says 20)
            o.oAction = KLEPTO_ACT_DIE
            play_sound(SOUND_ACTION_BOUNCE_OFF_OBJECT, m.marioObj.header.gfx.cameraToObject)
            cur_obj_become_intangible()
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

    if o.oAction == KLEPTO_ACT_CHASE_MARIO then --CHASING PLAYER
        o.oKleptoSpeed = 35
        o.oFaceAngleYaw = obj_angle_to_object(o, m.marioObj)
        o.oFaceAnglePitch = obj_pitch_to_object(o, player)
        o.oFaceAngleRoll = 0
        obj_turn_toward_object(o, player, 16, 0x2000)
        o.oMoveAnglePitch = obj_pitch_to_object(o, player)
        o.oMoveAngleRoll = 0
        if obj_check_hitbox_overlap(m.marioObj, o) then
            if (m.action & ACT_FLAG_ATTACKING) ~= 0 then
                o.oAction = KLEPTO_ACT_DIE
                play_sound(SOUND_ACTION_BOUNCE_OFF_OBJECT, m.marioObj.header.gfx.cameraToObject)
            else
                o.oTimer = 3
                o.oAction = 10 --Player is ded, Klepto resets to hunt for next player.
                m.squishTimer = 50
            end
        end
    end

    if o.oAction == KLEPTO_ACT_DIE then
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
        o.oKleptoSpeed = 80
        --obj_turn_toward_object(o, player, 16, 0x800) --removed due to easy star and zero challenge???
    end
end

local function star_door_init(o)
    o.oFlags = OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oInteractType = INTERACT_DOOR
    o.collisionData = gGlobalObjectCollisionData.inside_castle_seg7_collision_star_door
    o.oInteractionSubtype = INT_SUBTYPE_STAR_DOOR
    network_init_object(o, true, {'oBloody','oInteractStatus'})
    o.oDrawingDistance = 20000

    local hitbox = get_temp_object_hitbox()
    hitbox.interactType = INTERACT_DOOR
    hitbox.height = 100
    hitbox.radius = 80
    obj_set_hitbox(o, hitbox)
    cur_obj_set_home_once()
    bhv_door_init()
end

local function star_door_update_pos(o)
    o.oVelX = o.oBehParams2ndByte * coss(o.oMoveAngleYaw)
    o.oVelZ = o.oBehParams2ndByte * -sins(o.oMoveAngleYaw)
    o.oPosX = o.oPosX + o.oVelX
    o.oPosZ = o.oPosZ + o.oVelZ
end

local STAR_DOOR_ACT_CLOSED = 0
local STAR_DOOR_ACT_OPENING = 1
local STAR_DOOR_ACT_OPENED = 2
local STAR_DOOR_ACT_CLOSING = 3
local STAR_DOOR_HAS_CLOSED = 4

local function is_mario_in_center_of_doors(firstDoor, secondDoor, m, threshold)
    if m ~= nil and secondDoor ~= nil then
        local centerX = (firstDoor.oPosX + secondDoor.oPosX) / 2
        local centerZ = (firstDoor.oPosZ + secondDoor.oPosZ) / 2
        local distance = math.sqrt((m.pos.x - centerX) ^ 2 + (m.pos.z - centerZ) ^ 2)
        return distance < threshold
    end
    return false
end

local function star_door_loop_1(o)
    local pad = {0, 0, 0, 0}
    local secondDoor = cur_obj_nearest_object_with_behavior(get_behavior_from_id(id_bhvStarDoor))
    local m = nearest_interacting_mario_state_to_object(o)
    --djui_chat_message_create(tostring(o.oAction))

    if o.oBloody ~= 0 then
        obj_set_model_extended(o, E_MODEL_BLOODY_STAR_DOOR)
        obj_set_model_extended(secondDoor, E_MODEL_BLOODY_STAR_DOOR)
    end

    if o.oAction == STAR_DOOR_ACT_CLOSED then --oAction 0
        cur_obj_become_tangible()
        if (0x30000 & o.oInteractStatus) ~= 0 and m.action ~= ACT_GONE then
            o.oAction = 1
            if secondDoor ~= nil then
                secondDoor.oAction = 1
            end
        end
        

    elseif o.oAction == STAR_DOOR_ACT_OPENING then --oAction 1
        --camera_freeze()
        if o.oTimer == 0 and o.oMoveAngleYaw >= 0 then
            cur_obj_play_sound_2(SOUND_GENERAL_STAR_DOOR_OPEN)
            queue_rumble_data_object(o, 35, 30)
        end
        cur_obj_become_intangible()
        o.oBehParams2ndByte = -8.0
        star_door_update_pos(o)
        if o.oTimer >= 16 then
            o.oAction = 2
            --network_send_object(o, true)
        end

    elseif o.oAction == STAR_DOOR_ACT_OPENED then --oAction 2
        --if is_mario_in_center_of_doors(o, secondDoor, m, 60) then
        --    o.oAction = 3
            --network_send_object(o, true)
        --end

        --if o.oTimer >= 31 then --THIS IS THE ORIGINAL SPEED
        if o.oTimer >= 1 then
            o.oAction = 3
            --network_send_object(o, true)
        end

    elseif o.oAction == STAR_DOOR_ACT_CLOSING then --oAction 3
        if o.oTimer == 0 and o.oMoveAngleYaw >= 0 then
            cur_obj_play_sound_2(SOUND_GENERAL_STAR_DOOR_CLOSE)
            queue_rumble_data_object(o, 35, 30)
        end
        o.oBehParams2ndByte = 25
        star_door_update_pos(o)
        if o.oTimer >= 4 then
            o.oAction = 4
            --network_send_object(o, true)
        end
        
    elseif o.oAction == STAR_DOOR_HAS_CLOSED then --oAction 4
        local marioInCenter = is_mario_in_center_of_doors(o, secondDoor, m, 100)
        local marioActive = m.action ~= ACT_GONE
        if marioInCenter and marioActive then
            o.oBloody = 1
            --play_sound(SOUND_MARIO_ATTACKED, {x=0,y=0,z=0})
            --local_play(sSplatter, m.pos, 0.5)
            --spawn_sync_object(id_bhvMistCircParticleSpawner, E_MODEL_MIST, o.oPosX, o.oPosY, o.oPosZ, nil)
            --squishblood(m.marioObj)
            --set_mario_action(m, ACT_DISAPPEARED, 0)
            m.squishTimer = 50
            cur_obj_shake_screen(SHAKE_POS_SMALL)
            --set_camera_shake_from_hit(3)
            o.oInteractStatus = 0
            o.oAction = 0
            o.oTimer = 0
            network_send_object(o, true)
        else
            o.oInteractStatus = 0
            o.oAction = 0
            o.oTimer = 0
            network_send_object(o, true)
            --camera_unfreeze()
        end
        
        cur_obj_set_pos_to_home()
    end
    
    if m.controller.stickMag > 0 and o.oAction >= STAR_DOOR_ACT_OPENED and o.oAction <= STAR_DOOR_ACT_CLOSING then
        m.pos.x = m.pos.x + m.marioObj.oMarioReadingSignDPosX
        m.pos.z = m.pos.z + m.marioObj.oMarioReadingSignDPosZ
    end
end

local gDoorAdjacentRooms = {}

for i = 1, 60 do
    gDoorAdjacentRooms[i] = {0, 0}
end

local function star_door_loop_2(o)
    local sp4 = 0
    if gMarioStates[0].currentRoom ~= 0 then
        if o.oDoorUnkF8 == gMarioStates[0].currentRoom or
           gMarioStates[0].currentRoom == o.oDoorUnkFC or
           gMarioStates[0].currentRoom == o.oDoorUnk100 or
           gDoorAdjacentRooms[gMarioStates[0].currentRoom][0] == o.oDoorUnkFC or
           gDoorAdjacentRooms[gMarioStates[0].currentRoom][0] == o.oDoorUnk100 or
           gDoorAdjacentRooms[gMarioStates[0].currentRoom][1] == o.oDoorUnkFC or
           gDoorAdjacentRooms[gMarioStates[0].currentRoom][1] == o.oDoorUnk100 then
            sp4 = 1
        end
    else
        sp4 = 1
    end

    if sp4 == 1 then
        o.header.gfx.node.flags = o.header.gfx.node.flags | GRAPH_RENDER_ACTIVE
    elseif sp4 == 0 then
        o.header.gfx.node.flags = o.header.gfx.node.flags & ~GRAPH_RENDER_ACTIVE
    end

    o.oDoorUnk88 = sp4
end

local function star_door_loop(o)
    star_door_loop_1(o)
    star_door_loop_2(o)
    load_object_collision_model()
end

local function blood_mist_init(o)
    -- someone more experienced than me can probably do the init and loop better
    --local s = gStateExtras[0]
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.node.flags = o.header.gfx.node.flags | GRAPH_RENDER_BILLBOARD
    o.header.gfx.skipInViewCheck = true
    o.oGraphYOffset = 40
    obj_scale(o, 1)
end

local function blood_mist_loop(o)
    o.oOpacity = (-clampf(math.floor(o.oTimer * 8), 0, 255) + 255)
    o.oGraphYOffset = o.oGraphYOffset + -2.5
    if o.oTimer > 30 then -- 2 second timer before deleting. 
        obj_mark_for_deletion(o)
    end
end

local function lantern_init(o)
    o.oFlags = OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_HOLDABLE | OBJ_COL_FLAG_GROUNDED
    o.oInteractType = INTERACT_GRABBABLE
    o.header.gfx.skipInViewCheck = true
    --o.hitboxRadius = 100
    --o.hitboxHeight = 100
    --o.oWallHitboxRadius = 20
    o.oGravity = -1
    o.collisionData = COL_LANTERN
    o.oCollisionDistance = 10000
    o.oFriction = 0.8
    o.oBounciness = 1
    o.oBuoyancy = 1.4
    --network_init_object(o, true, nil)
    spawn_non_sync_object(id_bhvGlow, E_MODEL_GSCHARGE, o.oPosX, o.oPosY, o.oPosZ, nil)
end

local function lantern_loop(o)
    local m = gMarioStates[0]
    local s = gStateExtras[0]
    local distance = dist_between_objects (o, m.marioObj)
    local worldlighting = 255

    --[[ Fancy lighting for the lantern. Will need more work if it is to be enabled.
    local l = gLakituState
    local pitch = calculate_pitch(l.pos, l.focus)
    local yaw = calculate_yaw(l.pos, l.focus)
    local roll = l.roll
    
    local lightDir = { x = 70, y = 100, z = -90 }
    
    local m = gMarioStates[0]
    if o then vec3f_dif(lightDir, m.pos, o.header.gfx.pos) lightDir.y = -lightDir.y  end
    
    vec3f_rotate_zyx(lightDir, { x = -pitch, y = -yaw, z = roll })
    
    set_lighting_dir(0, lightDir.x - 0x28/0xFF)
    set_lighting_dir(1, lightDir.y - 0x28/0xFF)
    set_lighting_dir(2, lightDir.z - 0x28/0xFF)
    ]]

    o.oGraphYOffset = 30
    o.oInteractStatus = 0
    cur_obj_update_floor_height_and_get_floor()
    if m.action == ACT_AIR_THROW and m.actionTimer < 10 and o.oPosY > o.oFloorHeight then
        o.oForwardVel = 20
        o.oVelY = 7
    end
    if m.action == ACT_THROWING and m.actionTimer < 13 and o.oPosY > o.oFloorHeight then
        o.oForwardVel = 18
        o.oVelY = 9
    end

    cur_obj_move_standard(-78)
    cur_obj_move_using_fvel_and_gravity()

    if m.heldObj == o then
        cur_obj_disable_rendering_and_become_intangible(o)
    else
        cur_obj_enable_rendering_and_become_tangible(o)
    end

    if distance < 300  or m.heldObj == o then
        worldlighting = 255
    --elseif distance < 900 and distance > 300 then
    elseif distance < 1100 and distance > 300 then

        --worldlighting = 255 - ((distance - 300)/2)
        worldlighting = 255 - ((distance - 300)/3)
    --elseif distance > 900 then
    elseif distance > 1100 then
        worldlighting = 0
    end

    if worldlighting < 0 then
        worldlighting = 0
    end

    set_lighting_color(0, worldlighting)
    set_lighting_color(1, worldlighting)
    set_lighting_color(2, worldlighting)
    set_vertex_color(0, worldlighting)
    set_vertex_color(1, worldlighting)
    set_vertex_color(2, worldlighting)
    set_fog_color(0, 0)
    set_fog_color(1, 0)
    set_fog_color(2, 0)
    object_step()


    if distance > 2200 and m.heldObj ~= o then
        local smiler = obj_get_nearest_object_with_behavior_id(o, id_bhvBackroomSmiler)
        if smiler == nil and not s.hasNightvision and m.action ~= ACT_BITTEN_IN_HALF then
            play_secondary_music(0,0,0,60)
            spawn_non_sync_object(id_bhvBackroomSmiler, E_MODEL_BACKROOM_SMILER, o.oPosX, o.oPosY, o.oPosZ, nil)
        end
    end



end

--[[
function bobomb_lantern_init(o)
    if o.oBehParams == 20 then
        o.oFlags = OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE | OBJ_FLAG_HOLDABLE | OBJ_COL_FLAG_GROUNDED | OBJ_FLAG_HOLDABLE
        o.oInteractType = INTERACT_GRABBABLE
        spawn_non_sync_object(id_bhvGlow, E_MODEL_GSCHARGE, o.oPosX, o.oPosY, o.oPosZ, nil)
    end
end


function bobomb_lantern_loop(o)
    if o.oBehParams == 20 then
        local s = gStateExtras[0]
        local player = nearest_player_to_object(o)
        local angletomario = obj_angle_to_object(o, m.marioObj)
        local distance = dist_between_objects (o, m.marioObj)
        local worldlighting = 255

        if m.heldObj == o and m.action == ACT_AIR_THROW then
            o.oForwardVel = 30
            djui_chat_message_create("yeet")
        end
        cur_obj_move_using_fvel_and_gravity()

        if o.oPosY > o.oFloorHeight then
            limit_angle(o.oFaceAngleYaw)
        end

        if m.heldObj == o then
            cur_obj_disable_rendering_and_become_intangible(o)
        else
            cur_obj_enable_rendering_and_become_tangible(o)
        end

        if distance < 300  or m.heldObj == o then
            worldlighting = 255
        elseif distance < 900 and distance > 300 then
            worldlighting = 255 - ((distance - 300)/2)
        elseif distance > 900 then
            worldlighting = 0
        end

        if worldlighting < 0 then
            worldlighting = 0
        end

        set_lighting_color(0, worldlighting)
        set_lighting_color(1, worldlighting)
        set_lighting_color(2, worldlighting)
        set_vertex_color(0, worldlighting)
        set_vertex_color(1, worldlighting)
        set_vertex_color(2, worldlighting)
        set_fog_color(0, 0)
        set_fog_color(1, 0)
        set_fog_color(2, 0)

        o.oFaceAngleYaw = angletomario
        obj_turn_toward_object(o, player, 16, 0x800)
        o.oForwardVel = 2
        object_step()
    end
end
]]

local function glow_init(o)
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.node.flags = o.header.gfx.node.flags | GRAPH_RENDER_BILLBOARD
    o.header.gfx.skipInViewCheck = true
    obj_set_billboard(o)
    obj_scale(o, 2)
    o.oOpacity = 255

end

local function glow_loop(o)
    local m = gMarioStates[0]
    --local target = obj_get_nearest_object_with_behavior_id(o, id_bhvBobombBuddy)
    local target = obj_get_nearest_object_with_behavior_id(o, id_bhvLantern)
    local scale = 1.8+math.sin(get_global_timer()/12)*0.2
    local opacity = 105+math.sin(get_global_timer()/12)*20
    o.oGraphYOffset = 20
    o.oOpacity = opacity
    --o.oOpacity = 255
    obj_scale(o, scale)
    if m.heldObj == target then
        o.oPosX, o.oPosY, o.oPosZ = m.pos.x, m.pos.y + 90, m.pos.z
    else
        o.oPosX, o.oPosY, o.oPosZ = target.oPosX, target.oPosY, target.oPosZ
    end
end

local function goggles_init(o)
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.skipInViewCheck = true
    o.hitboxRadius = 50
    o.hitboxHeight = 50
    o.oFaceAnglePitch = -2000
    o.oMoveAnglePitch = o.oFaceAnglePitch
    obj_scale(o, 1.3)
end

local function goggles_loop(o)
    local s = gStateExtras[0]
    local m = gMarioStates[0]
    o.oGraphYOffset = 20
    cur_obj_update_floor_height_and_get_floor()
    if o.oPosY > o.oFloorHeight then
        o.oPosY = o.oFloorHeight
    end

    if obj_check_hitbox_overlap(o, m.marioObj) and m.action ~= ACT_PUTTING_ON_CAP then
        set_mario_action(m, ACT_PUTTING_ON_CAP, 0)
        cur_obj_disable_rendering_and_become_intangible(o)
        local_play(sNightvision, gLakituState.pos, 1)
        s.hasNightvision = true
        obj_mark_for_deletion(o)
    end
end

local function hoot_loop(o)
    local m = gMarioStates[0]
    local player = nearest_player_to_object(o)
    local nearmario = nearest_mario_state_to_object(o)
    local np = gNetworkPlayers[0]

    if o.oHootAvailability == HOOT_AVAIL_READY_TO_FLY and o.oAction ~= 10 then
        o.oHootAvailability = false
        --network_play(sAngryKlepto, m.pos, 1, m.playerIndex)
        stop_secondary_music(0)
        --m.action = ACT_IDLE
        approach_vec3f_asymptotic(gLakituState.focus, o.header.gfx.pos, 3,3,3)
        approach_vec3f_asymptotic(gLakituState.curFocus, o.header.gfx.pos, 3,3,3)
        play_music(0, SEQ_EVENT_BOSS, 0)
        o.oAction = 10
        o.oTimer = 0
    end

    if o.oAction == 10 then --hoot is pissed and hunts for nearest player.
        o.oFaceAngleRoll = 0
        o.oMoveAngleRoll = 0
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
        local nearest = nearest_mario_state_to_object(o)
        cur_obj_update_floor_height_and_get_floor()
        o.oForwardVel = 35
        if o.oPosY > nearest.pos.y + 30 then
            if o.oFloorHeight > 25 then
                o.oPosY = o.oPosY - 15
            end
        elseif o.oPosY < nearest.pos.y - 30 then
            o.oPosY = o.oPosY + 15
        end
        obj_turn_toward_object(o, player, 16, 0x2000)
        o.oFaceAngleRoll = 0
        o.oMoveAngleRoll = 0
        o.oFaceAnglePitch = obj_pitch_to_object(o, player)
        o.oMoveAnglePitch = obj_pitch_to_object(o, player)
        obj_move_xyz_using_fvel_and_yaw(o)
        
        if obj_check_hitbox_overlap(m.marioObj, o) then
            if (m.action & ACT_FLAG_ATTACKING) ~= 0 then
                local angletomario = obj_angle_to_object(o, m.marioObj)
                o.oMoveAngleYaw = angletomario + 32768
                cur_obj_play_sound_2(SOUND_ACTION_BONK) -- this is the small wall-kick sound.
                m.forwardVel = -45
                play_sound(SOUND_ACTION_BOUNCE_OFF_OBJECT, m.marioObj.header.gfx.cameraToObject)
                spawn_mist_particles()				
                o.oAction = 9
                o.oVelY = 40
                o.oTimer = 0
                o.oPosY = o.oPosY + 60
            else
                o.oTimer = 0
                o.oAction = 10 --Player is ded, hoot resets to hunt for next player.
                m.squishTimer = 50
            end
        end
    end

    if o.oAction == 9 then --falling to death

        --this is where "falling out of the air" code would be... but I deleted it, cause the Hoot models anchor point is stupid and rotating him as he falls out of the sky looks awful. 
        gibs(o)
        obj_unused_die()
        squishblood_nogibs(o)
        network_play(sSplatter, m.pos, 1, m.playerIndex)
        stop_background_music(SEQ_EVENT_BOSS)
    end
end

local function chuckya(o)
    local nm = nearest_mario_state_to_object(o)
    local m = gMarioStates[0]
    if o.oTimer == 10 and o.oAction == 1 then
        network_play(sChuckster, m.pos, 1, m.playerIndex)
        --cutscene_object_with_dialog(CUTSCENE_DIALOG, nm.marioObj, DIALOG_116)
    end
end

local function stonewall_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = COL_STONEWALL
    o.oCollisionDistance = 10000
    o.header.gfx.skipInViewCheck = true
end

local function stonewall_loop(o)
    load_object_collision_model()
end

local function flame_loop(o) --This is to help prevent a bunch of stuck flames from building up in Hell near the beginning. 
    np = gNetworkPlayers[0]
    if o.oBehParams == 4 and o.oTimer > 400 then -- BehParam 4 is set to the usedflame when mario ignites. This will cause that flame to burn out within 500 frames.
        obj_unused_die()
        obj_mark_for_deletion(o)
    end
end

local function vomit_init(o)
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.node.flags = o.header.gfx.node.flags | GRAPH_RENDER_BILLBOARD
    o.header.gfx.skipInViewCheck = true
    o.oGraphYOffset = 40
    obj_scale(o, 0.2)
    o.oGravity = -1
end

local function vomit_loop(o)
    local sickmario = nearest_mario_state_to_object(o)
    local random = math.random(2.0, 15.0)
    o.oForwardVel = random
    cur_obj_move_using_fvel_and_gravity()
    cur_obj_update_floor_height()
    if o.oPosY <= o.oFloorHeight then
        obj_mark_for_deletion(o)
    end

    o.oOpacity = (-clampf(math.floor(o.oTimer * 8), 0, 255) + 255)
    o.oGraphYOffset = o.oGraphYOffset + -2.5

end
-------Behavior Hooks-------

local hook_behavior, get_behavior_from_id, get_behavior_name_from_id, get_object_list_from_behavior =
hook_behavior, get_behavior_from_id, get_behavior_name_from_id, get_object_list_from_behavior

local function hook_gore_behavior(id, override, init, loop)
    if not id then return end

    local behavior = get_behavior_from_id(id)
    local name = get_behavior_name_from_id(id) or ("bhvUnk" .. id)
    local objectList = get_object_list_from_behavior(behavior)
    local newBehaviorName = "bhvGore" .. name:sub(4)

    return hook_behavior(id, objectList, override, init, loop, newBehaviorName)
end

local function heaveho_loop(o)
    local m = nearest_mario_state_to_object(o)
    if o.oHeaveHoUnk88 >= 1 then
        set_mario_action(m, ACT_RAGDOLL, 0)
        m.pos.y = m.pos.y + 4
    end
    if is_within_100_units_of_mario(o.oPosX, o.oPosY, o.oPosZ) and m.forwardVel == -45 then
        m.forwardVel = 45
        m.vel.y = m.vel.y + 80
    end
    if o.oAction == 1 then 
        o.oAction = 2
    end
    if o.oAction == 2 then
        o.oForwardVel = 60  -- this isnt doing anything
        --djui_chat_message_create("zoooom")
        if o.oTimer == 30 then
            o.oTimer = 0
        end
    end

end

local function skeeter_loop(o)
    local m = nearest_mario_state_to_object(o)
    if is_point_within_radius_of_mario(o.oPosX, o.oPosY, o.oPosZ, 1200) ~= 0 and m.action ~= ACT_GONE then
        local ang = obj_angle_to_object(o, m.marioObj)
        o.oForwardVel = 65
        o.oFaceAngleYaw = ang
        o.oMoveAngleYaw = o.oFaceAngleYaw
    end
end

local function scuttlebug_loop(o)
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)
    if dist < 700 then
        cur_obj_rotate_yaw_toward(o.oAngleToMario, 0x400)
        if o.oVelY ~= 0 and o.oTimer > 30 then
            cur_obj_play_sound_2(SOUND_OBJ2_SCUTTLEBUG_ALERT)
            o.oTimer = 0
        end
        if m.vel.y ~= 0 and m.action ~= ACT_GONE then
            o.oVelY = m.pos.y - o.oPosY + 10
            if o.oVelY > 40 then
                o.oVelY = 40
            elseif o.oVelY < -60 then
                o.oVelY = -60
            end
        end
    --[[elseif o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then
        squishblood(o)
        local_play(sSplatter, m.pos, 1)]]
    end
    --djui_chat_message_create(tostring(o.oSubAction))

    metalhit_attack(o)
end

local function boo_vanish_or_appear(o) -- Translation of the boo hiding function
    local m = nearest_mario_state_to_object(o)
    if not m then return false end
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)
    local doneAppearing = false

    --o.oVelY = 0

    if (m.action & ACT_FLAG_AIR > 0 and dist < 500 * o.header.gfx.scale.y and o.oAction ~= 3) then -- Check if mario is ground pounding, near and hadn't attacked
        o.oBooTargetOpacity = 40
        o.oInteractType = 0
        if (o.oOpacity == 40) then
            o.oBooTargetOpacity = 255
        end

        if (o.oOpacity > 180) then
            doneAppearing = true
        end
    end

    return doneAppearing
end

local function boo_loop(o)
    local m = nearest_mario_state_to_object(o)
    if boo_vanish_or_appear(o) then
        o.oTimer = 0
    elseif o.oAction > 0 and o.oTimer <= 30 then
        o.oInteractType = 0
        o.oForwardVel = 32 -- Doesn't seem to work
        cur_obj_rotate_yaw_toward(o.oAngleToMario, 0x300) -- Neither this
    end
    if obj_check_if_collided_with_object(o, m.marioObj) == 1 then
        djui_chat_message_create("yes")
        obj_set_model_extended(m.marioObj.prevObj, E_MODEL_BLUE_FLAME)
    end
    --djui_chat_message_create(tostring(o.oInteractStatus & INT_STATUS_INTERACTED))
end

local function HackerSM64_mr_i_pitch_shooting(particle, o) --Thx HackerSM64 devs
    local yScale = o.header.gfx.scale.y
    particle.oPosX = particle.oPosX + (90.0 * yScale) *  coss(o.oMoveAnglePitch) * sins(o.oMoveAngleYaw)
    particle.oPosY = particle.oPosY + (90.0 * yScale) * -sins(o.oMoveAnglePitch) + (50.0 * yScale)
    particle.oPosZ = particle.oPosZ + (90.0 * yScale) *  coss(o.oMoveAnglePitch) * coss(o.oMoveAngleYaw)
end

local function spawn_more_mr_i_particles(index, o)
    local particle = spawn_sync_object(id_bhvMrIParticle, E_MODEL_PURPLE_MARBLE, o.oPosX, o.oPosY, o.oPosZ, nil)
    particle.oMoveAngleYaw = o.oMoveAngleYaw
    particle.oMoveAnglePitch = o.oMoveAnglePitch
    HackerSM64_mr_i_pitch_shooting(particle, o)
    particle.oMoveAngleYaw = particle.oMoveAngleYaw + 0x400 * (index - 2)
    particle.oTimer = 2
end

local function mr_i_particle(o)
    local mr_i = obj_get_nearest_object_with_behavior_id(o, id_bhvMrI)
    if o.oTimer == 1 then
        for index = 0, 4 do
            spawn_more_mr_i_particles(index, mr_i)
        end
        obj_mark_for_deletion(o)
    end
    o.oForwardVel = 0
    obj_compute_vel_from_move_pitch(25.0)
    obj_move_xyz_using_fvel_and_yaw(o)
end

local function mr_i(o)
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)
    if dist < 500 and o.oAction == 1 then
        obj_turn_toward_object(o, mObj, 0x10,   0x800)
        obj_turn_toward_object(o, mObj, 0x0F, 0x400)
    elseif o.oAction == 2 then
        if o.oMrIUnkFC >= 5000 then
            --if o.oMrIUnk104 == o.oMrIUnk108 then
            --o.oMrIUnk110 = 1
            --end
            if o.oUnk1A8 == --[[o.oMrIUnk108 +]] 20 then
                --spawn_mr_i_particle()
                particle = spawn_sync_object(id_bhvMrIParticle, E_MODEL_PURPLE_MARBLE, o.oPosX, o.oPosY, o.oPosZ, nil)
                particle.oMoveAngleYaw = o.oMoveAngleYaw
                particle.oMoveAnglePitch = o.oMoveAnglePitch
                HackerSM64_mr_i_pitch_shooting(particle, o)
                local_play(sShotgun, m.pos, 1) --cur_obj_play_sound_2(SOUND_OBJ_MRI_SHOOT)
                o.oUnk1A8 = 0
                o.oMrIUnk108 = (random_float() * 50.0 + 50.0)
            end
            o.oUnk1A8 = o.oUnk1A8 + 1
        end
    elseif o.oAction == 3 and o.oTimer == 104 then
        squishblood(o)
        local_play(sSplatter, m.pos, 1)
    end
end

local function sfx_management(sfx)
    local m = gMarioStates[0]
    if sfx == SOUND_OBJ_MRI_SHOOT then
        local_play(sShotgun, m.pos, 1)
        return 0
    end
    local boo = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvGhostHuntBoo) or obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvBoo)
    or obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvMerryGoRoundBoo) or obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvGhostHuntBigBoo)
    or obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvBalconyBigBoo) or obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvMerryGoRoundBigBoo)
    local distboo = dist_between_objects(m.marioObj, boo)
    if sfx == SOUND_OBJ_BOO_LAUGH_LONG and boo and (m.action & ACT_FLAG_AIR > 0 and boo.oAction ~= 3) then
        return 0
    end
end

local function coin_switch(o)
    if o.oAction == BLUE_COIN_SWITCH_ACT_RECEDING and o.oTimer == 4 then
        local m = nearest_mario_state_to_object(o)
        set_mario_action(m, ACT_BUTT_STUCK_IN_GROUND, 0)
    end
end

local function mips(o)
    o.oMipsForwardVelocity = 100
end

-- I had to make this behavior because i can't change the interactType of a hitbox twice --Flipflop Bell
local function RacerHitbox_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.parentObj = obj_get_nearest_object_with_behavior_id(o, id_bhvKoopa)
    or obj_get_nearest_object_with_behavior_id(o, id_bhvRacingPenguin)
    local hitbox = get_temp_object_hitbox()
    hitbox.interactType = INTERACT_DAMAGE
    hitbox.radius = 150
    hitbox.height = 150
    hitbox.damageOrCoinValue = 8
    obj_set_hitbox(o, hitbox)
    o.oIntangibleTimer = 0
end

local function RacerHitbox_loop(o)
    if o.parentObj == nil then return end
    o.oPosX = o.parentObj.oPosX
    o.oPosY = o.parentObj.oPosY
    o.oPosZ = o.parentObj.oPosZ
    if o.parentObj.oAction == KOOPA_THE_QUICK_ACT_AFTER_RACE or o.parentObj.oAction == RACING_PENGUIN_ACT_FINISH_RACE then
        obj_mark_for_deletion(o)
    end
end

local function koopatheQUICC(o)
    local m = nearest_mario_state_to_object(o)
    local np = gNetworkPlayers[0]
    if np.currLevelNum == LEVEL_BOB then
        gBehaviorValues.KoopaCatchupAgility = 60
    else
        gBehaviorValues.KoopaCatchupAgility = 8
    end
    if o.oForwardVel >= 50 and o.oKoopaMovementType >= KOOPA_BP_KOOPA_THE_QUICK_BASE and
    obj_get_nearest_object_with_behavior_id(o, id_bhvRacerHitbox) == nil then
        spawn_non_sync_object(id_bhvRacerHitbox, E_MODEL_NONE, o.oPosX, o.oPosY, o.oPosZ, nil)
    -- Normal Koopa
    -- It will run away from mario without stopping if mario is near enough
    elseif o.oKoopaMovementType == KOOPA_BP_NORMAL then
        o.oKoopaAgility = 5
        if dist_between_objects(gMarioStates[0].marioObj, o) < 750 then
            o.oHomeX = o.oPosX
            o.oHomeY = o.oPosY
            o.oHomeZ = o.oPosZ
            if o.oAction == KOOPA_SHELLED_ACT_STOPPED or o.oAction == KOOPA_SHELLED_ACT_WALK then
                o.oAction = KOOPA_SHELLED_ACT_RUN_FROM_MARIO
            elseif o.oAction == KOOPA_SHELLED_ACT_RUN_FROM_MARIO then
                o.oForwardVel = 32
                cur_obj_rotate_yaw_toward(o.oAngleToMario + 0x8000, 0xF00)
            end
        end
    end
    if o.oAction == OBJ_ACT_SQUISHED then
        o.oKoopaAgility = 1 -- For some reason this affects the squish scale
        if o.oSubAction ~= 1 then -- I did this so the gore doesn't run twice --Flipflop Bell
            o.oSubAction = 1
            o.oTimer = 0
        elseif o.oSubAction == 1 and o.oTimer >= 16 then
            squishblood(o)
            local_play(sSplatter, m.pos, 1)
        end
    end
end

local function invertedpyramid(o)
    local np = gNetworkPlayers[0]
    if np.currLevelNum == LEVEL_BITFS and not gGlobalSyncTable.romhackcompatibility then
        obj_mark_for_deletion(o)
    end
end

local function waterdiamond(o)
    local np = gNetworkPlayers[0]
    if np.currLevelNum == LEVEL_WDW then
        obj_mark_for_deletion(o)
    end
end

local function clam_shell_loop(o)
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)
    if o.oSubAction == 1 then
        o.oAction = 0
        o.oTimer = o.oTimer + 2
        if m.action == ACT_BACKWARD_WATER_KB or m.action == ACT_FORWARD_WATER_KB then
        m.squishTimer = 50
        network_play(sCrunch, m.pos, 1, m.playerIndex)
        end
        if o.header.gfx.animInfo.animFrame < 24 then
            o.header.gfx.animInfo.animFrame = o.header.gfx.animInfo.animFrame + 2
        elseif o.header.gfx.animInfo.animFrame >= 29 then
            o.oSubAction = 0
        end
    elseif dist < 100 and obj_is_valid_for_interaction(o) ~= true then
        o.oSubAction = 1
        --o.oTimer = 0
        --djui_chat_message_create("real")
    end
    if m.flags & MARIO_METAL_CAP ~= 0 and (m.action == ACT_FORWARD_WATER_KB or m.action == ACT_BACKWARD_WATER_KB) then
        m.capTimer = 1
        m.flags = MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD
        play_sound(SOUND_ACTION_METAL_BONK, m.pos)
        stop_cap_music()
    end
    
    --djui_chat_message_create(tostring(obj_get_nearest_object_with_behavior_id(mObj, id_bhvClamShell).oTimer))
    --djui_chat_message_create(tostring(obj_get_nearest_object_with_behavior_id(mObj, id_bhvClamShell).header.gfx.animInfo.animFrame))     
end

local function chest_bottom_init(o) -- *Epically messes up with your muscle memory*
    if o.oBehParams2ndByte ~= 1 and o.oBehParams2ndByte ~= 3 then
        o.oBehParams2ndByte = o.oBehParams2ndByte - 1
    else
        o.oBehParams2ndByte = o.oBehParams2ndByte + 1
    end
end

local function exploding_jrb_rock_loop(o)
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)
    local pos = o.header.gfx.cameraToObject
    if dist < 750 then
        spawn_mist_particles()
        for i = 0, 5 do
            play_sound(SOUND_GENERAL_POUND_ROCK, pos)
            play_sound(SOUND_GENERAL_LOUD_POUND, pos)
        end
        for i = 0, math.random(10, 20) do
            spawn_sync_object(id_bhvRockShrapnel, E_MODEL_ROCK_SHRAPNEL, o.oPosX, o.oPosY - 200, o.oPosZ, nil)
        end
        obj_mark_for_deletion(o)
    end
end

local function rock_shrapnel_init(o) -- This is a slightly different version of bouncy_init
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    local randomfvel = math.random(10,40)
    local random = math.random(30,80)
    local randomyaw = math.random(1,65536)
    local randompitch = math.random(1,65536)
    local randomroll = math.random(1,65536)
    local randomscale = math.random(1, 20)/10
    o.oBounciness = 1
    o.oGravity = -5
    o.oVelY = random
    o.oForwardVel = randomfvel
    o.oMoveAngleYaw = randomyaw
    o.oFaceAngleYaw = randomyaw
    o.oFaceAnglePitch = randompitch
    o.oFaceAngleRoll = randomroll
    obj_scale(o, randomscale)
    --obj_set_billboard(o)
end

local function rock_shrapnel_loop(o)
    cur_obj_move_using_fvel_and_gravity()
    local m = nearest_mario_state_to_object(o)
    local mObj = m.marioObj
    local dist = dist_between_objects(mObj, o)
    if dist < 200 * o.header.gfx.scale.x and m.flags & MARIO_METAL_CAP == 0 and (m.action ~= ACT_HARD_BACKWARD_GROUND_KB and m.action ~= ACT_BACKWARD_WATER_KB) then
        m.squishTimer = 50
    elseif dist < 200 * o.header.gfx.scale.x and m.flags & MARIO_METAL_CAP ~= 0 and (m.action & ACT_FLAG_METAL_WATER == 0) then
        set_mario_action(m, ACT_HARD_BACKWARD_GROUND_KB, 0)
        m.capTimer = 1
        m.flags = MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD
        play_sound(SOUND_ACTION_METAL_BONK, m.pos)
        stop_cap_music()
    elseif dist < 200 * o.header.gfx.scale.x and (m.action & ACT_FLAG_METAL_WATER ~= 0) then
        set_mario_action(m, ACT_BACKWARD_WATER_KB, 0)
    end
end

function piranha_plant(o)
	local m = nearest_mario_state_to_object(o)
    if m ~= nil and o.oAction == PIRANHA_PLANT_ACT_BITING then
        cur_obj_update_floor_and_walls()
        o.oWallHitboxRadius = 40
        o.oForwardVel = 30
		--[[ Not sure if this is fair
		cur_obj_rotate_yaw_toward(obj_angle_to_object(o, m.marioObj), 0x400) ]]
        o.oPosY = o.oFloorHeight
        cur_obj_move_using_fvel_and_gravity()
    end

    if o.oAction == 5 or o.oAction == 6 or o.oAction == 7 then 
        return 
    elseif o.oAction == 1 then
        metalhit(o)
    else
        metalhit_attack(o)
    end
end

function pokey_body_part(o)
    local m = nearest_mario_state_to_object(o)
    if m ~= nil and dist_between_objects(o, m.marioObj) <= 1000 then
	    if o.oTimer > 20 then
            o.oTimer = 0
            if o.oPosY + 60 >= m.pos.y and o.oPosY + 60 <= m.pos.y + 160 then
                cur_obj_play_sound_2(SOUND_OBJ_SNUFIT_SHOOT)
                spawn_non_sync_object(id_bhvPokeySpike, E_MODEL_SPINY_BALL, o.oPosX, o.oPosY + 60, o.oPosZ, nil)
            end
        end
    end
end

function pokey_spike_init(o)

    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.oInteractType = INTERACT_DAMAGE

    o.oHomeX = o.oPosX
    o.oHomeY = o.oPosY
    o.oHomeZ = o.oPosZ

    o.oForwardVel = 100
    o.hurtboxHeight = 40
    o.hurtboxRadius = 40
    o.oIntangibleTimer = 0
    o.oDamageOrCoinValue = 2

    local m = nearest_mario_state_to_object(o)
    if m ~= nil then
        o.oMoveAngleYaw = obj_angle_to_object(o, m.marioObj)
    else
        obj_mark_for_deletion(o)
    end
    
end

function pokey_spike_loop(o)
    local vh = {
        x=o.oHomeX,
        y=o.oHomeY,
        z=o.oHomeZ
    }
    local vp = {
        x=o.oPosX,
        y=o.oPosY,
        z=o.oPosZ
    }
    local dist = vec3f_dist(vh, vp)
    if dist > 1500 then
        obj_mark_for_deletion(o)
        return
    end

    local m = nearest_interacting_mario_state_to_object(o)
    
    if o.oInteractStatus & INT_STATUS_INTERACTED ~= 0 then
        m.squishTimer = 50
        obj_mark_for_deletion(o)
    end

    cur_obj_move_xz_using_fvel_and_yaw()
end

function fire_piranha_plant(o)
    --djui_chat_message_create(tostring(o.oTimer))
    if o.oAction == FIRE_PIRANHA_PLANT_ACT_HIDE then return end
    --Spit more fireballs and make them faster
    if o.oTimer < 50 and o.oTimer % 10 == 0 then
        spawn_non_sync_object(id_bhvSmallPiranhaFlame, E_MODEL_RED_FLAME_SHADOW, o.oPosX, o.oPosY, o.oPosZ,
            ---@param flame Object
            function(flame)
                -- from obj_spit_fire logic
                obj_scale(flame, 2.5 * o.oFirePiranhaPlantNeutralScale)
                obj_copy_pos_and_angle(flame, o)
                flame.oBehParams2ndByte = 1
                flame.oBehParams = (1 & 0xFF) << 16
                flame.oSmallPiranhaFlameStartSpeed = 40
                flame.oSmallPiranhaFlameEndSpeed = 50
                flame.oMoveAnglePitch = 0x1000
            end)
    elseif o.oTimer >= 40 and o.oTimer <= 80 then
        o.oTimer = 81
    end
end

function wiggler_head(o)
    -- make wiggler crazier with more jumping and random turning
    if o.oAction == WIGGLER_ACT_WALK and o.oWigglerTextStatus == WIGGLER_TEXT_STATUS_COMPLETED_DIALOG then
        if o.oPosY == o.oFloorHeight and o.oTimer % (20 * o.oHealth) == 0 then
            cur_obj_play_sound_2(SOUND_OBJ_WIGGLER_JUMP)
            o.oVelY = 70
        end

        if o.oWigglerTimeUntilRandomTurn == 0 then
            o.oWigglerTimeUntilRandomTurn = o.oHealth * 10
        end
    end
end

function fire_spitter(o)
    --spit fire more quickly
    local mo = nearest_player_to_object(o)
    if mo == nil or dist_between_objects(o, mo) >= 800 or o.oMoveFlags & OBJ_MOVE_MASK_IN_WATER ~= 0 then return end
    
    if o.oAction == FIRE_SPITTER_ACT_IDLE then
        if o.oTimer % 20 == 0 then
            if o.oFireSpitterScaleVel == -0.03 then
                o.oFireSpitterScaleVel = 0.05
            end
            o.oAction = FIRE_SPITTER_ACT_SPIT_FIRE
        end

        if o.oTimer == 150 then
            o.oTimer = 0
        end
    end
end

function hell_entrance_init(o)
    o.oFlags = OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.hitboxRadius = 100
    o.hitboxHeight = 100
    o.oFaceAngleYaw = -5600
    o.oMoveAngleYaw = o.oFaceAngleYaw
    obj_scale(o, 1.3)
end

function hell_entrance_loop(o)
    local m = gMarioStates[0]
    if obj_check_hitbox_overlap(o, m.marioObj) then
        if m.controller.buttonPressed & Z_TRIG ~= 0 and m.action ~= ACT_GONE then
            set_mario_action(m, ACT_GONE, 0)
            spawn_sync_if_main(id_bhvMistCircParticleSpawner, E_MODEL_RED_FLAME, m.pos.x, m.pos.y, m.pos.z, nil, m.playerIndex)
            network_play(sFlames, m.pos, 1, m.playerIndex)
            local yaw = 0 --Creates a flame ring portal for Mario to spawn from.
            for i = 0, 16 do
                yaw = yaw + 4096
                spawn_sync_object(id_bhvFireRing, E_MODEL_RED_FLAME, m.pos.x, m.pos.y + 26, m.pos.z, function (o)
                    o.oFaceAngleYaw = yaw
                    o.oMoveAngleYaw = o.oFaceAngleYaw
                end)
            end
            play_transition(WARP_TRANSITION_FADE_INTO_COLOR, 1, 255, 0, 0)
            play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 15, 255, 0, 0)
        end
    end
end

function shockwave(o)
    local m = gMarioStates[0]
    o.hitboxHeight = 20
    o.oTimer = o.oTimer + 2
    if m.pos.y < o.oPosY - 50 then
        cur_obj_disable_rendering_and_become_intangible(o)
    end
end

function bhv_custom_signpost(o)
    local m = gMarioStates[0]
    if o.oAction == 0 and o.oWoodenPostMarioPounding ~= 0 then
        o.oWoodenPostSpeedY = (m.peakHeight - m.pos.y) / -8
        --djui_chat_message_create(tostring((m.peakHeight - m.pos.y) / -10))
        o.oAction = 1
    elseif o.oAction == 1 and o.oWoodenPostMarioPounding == 0 then
        o.oAction = 0
    end
end

STATIC_OBJ_FLICKER_TIMER = 40

local function static_obj_loop(o)
    if gNetworkPlayers[0].currLevelNum == LEVEL_RR and not gGlobalSyncTable.romhackcompatibility then
        if o.oAction == 0 then
            if o.oTimer == 1 then
                cur_obj_unhide()
            end

            if o.oTimer % 10 == 0 and o.oTimer <= STATIC_OBJ_FLICKER_TIMER then
                play_sound(SOUND_GENERAL2_SWITCH_TICK_FAST, gGlobalSoundSource)
            end

            if o.oTimer >= STATIC_OBJ_FLICKER_TIMER then
                o.oAction = 1
                o.oTimer = 0
            end
        else
            if o.oTimer == 1 then
                cur_obj_hide()
            end

            if o.oTimer % 40 == 0 and o.oTimer <= STATIC_OBJ_FLICKER_TIMER * 4 then
                play_sound(SOUND_GENERAL2_SWITCH_TICK_FAST, gGlobalSoundSource)
            end

            if o.oTimer >= STATIC_OBJ_FLICKER_TIMER * 4 then
                o.oAction = 0
                o.oTimer = 0
            end
        end
    end
end

function mrboneswildride(o) --The fun never ends!!
    local m = gMarioStates[0]
    if not gGlobalSyncTable.iwbtgmode then
        if o.oAction == 5 then

            if lateral_dist_between_objects(m.marioObj, o) < 400 then
                seq_player_lower_volume(0, 30, 100)
            else
                seq_player_unlower_volume(0, 30)
            end
            --djui_chat_message_create(tostring(o.oTimer))
            local oPos = {
                x = o.oPosX,
                y = o.oPosY,
                z = o.oPosZ
            }
            if o.oTimer == 5 then
                --fadeout_music(10)
                network_play(sElevator, oPos, 1, m.playerIndex)
            end
            if o.oTimer >= 420 and o.oTimer < 1700 then
                o.oPosY = o.oPosY + 1.4
            end
            if o.oTimer >= 1700 and o.oTimer < 1710 then
                o.oPosY = o.oPosY - 105
            end
            if o.oTimer >= 1710 and o.oTimer < 1711 then
                o.oVelY = 1
                spawn_mist_particles()
                set_camera_shake_from_hit(SHAKE_POS_LARGE)
                play_sound(SOUND_GENERAL2_SPINDEL_ROLL, oPos)
                play_sound(SOUND_GENERAL_BIG_POUND, oPos)
                play_sound(SOUND_GENERAL_BIG_POUND, oPos)
            end
            if o.oTimer >= 1711 and o.oTimer < 1785 then
                local risespeed = o.oTimer - 1700
                o.oVelY = math.min(risespeed * 2, 74)
                --o.oVelY = o.oVelY * 1.1
                cur_obj_move_using_vel()
            end
            if o.oTimer == 1786 then
                --set_background_music(0, get_current_background_music(), 0)
                spawn_triangle_break_particles(30, 138, 1, 4)
                spawn_mist_particles()
                set_camera_shake_from_hit(SHAKE_POS_MEDIUM)
                play_sound(SOUND_GENERAL_WALL_EXPLOSION, oPos)
                play_sound(SOUND_GENERAL_EXPLOSION6, oPos)
                
            end
            if o.oTimer > 1787 then
                obj_mark_for_deletion(o)
            end
        end
    end

    --if o.oBehParams == 3 and o.oAction ~= 5 then
    if o.oPosY < -2400 and cur_obj_is_mario_on_platform() ~= 0 and o.oAction ~= 5 then
        o.oAction = 5
        o.oTimer = 0
        --djui_chat_message_create("running!")
    end
end


hook_gore_behavior(id_bhvHmcElevatorPlatform, false, nil, mrboneswildride)


function bhv_custom_1up(o) -- Chases the nearest player for 5 seconds in a green demon state before despawning.
    local m = gMarioStates[0]
    local mObj = m.marioObj
    
    --if o.oAction == 1 then --1up should be chasing the player.
        --o.oTimer = 0
    --end

    if o.oAction == 1 and o.oTimer == 1 then
        local_play(sFloweyHa, o.header.gfx.pos, 1)
    end

    if lateral_dist_between_objects(m.marioObj, o) <= 120 and o.oAction == 1 and o.oTimer < 120 then --Runs if Mario 'touches' the 1up hitbox. 120 is actually slightly before, but would be a better option imo.
        m.health = 0xff
        obj_mark_for_deletion(o)
        play_sound(SOUND_GENERAL_COLLECT_1UP, gGlobalSoundSource)
    elseif lateral_dist_between_objects(m.marioObj, o) > 120 and o.oAction == 1 and o.oTimer == 150 then
        local_play(sFart, o.header.gfx.pos, 2)
        obj_mark_for_deletion(o)
    end
    
end

function bhv_custom_cork_box(o)
    local n = nearest_mario_state_to_object(o)
    local dist = dist_between_objects(o, n.marioObj)
    
    if n.heldObj == o and o.oAction ~= 2 then
        o.oTimer = 0
        o.oAction = 2
    elseif n.heldObj ~= o then
        o.oAction = 0
        obj_scale(o, 0.4)
    end

    if o.oAction == 2 and o.oTimer == 12 then
        local_play(sMegaGrow, n.pos, 2) 
        set_mario_action(n, ACT_HOLD_HEAVY_IDLE, 0)
    end

    if o.oAction == 2 and o.oTimer > 12 and o.oTimer <= 75 then
        obj_scale(o, math.max(0.4, o.oTimer / 30))
    end

    if dist < 50 and n.action == ACT_HEAVY_THROW and n.actionTimer == 13 then
        n.squishTimer = 50
        local_play(sThrowFail, n.pos, 2)
        obj_mark_for_deletion(o)
    elseif dist >= 50 and o.oAction == 2 and o.oTimer == 75 then
        n.squishTimer = 50
        local_play(sThrowFail, n.pos, 2)
        obj_mark_for_deletion(o)
    end

end

function castle_boo_init(o) -- Move the castle Boo further from the door to eventually start on the boo rushdown possession kill
    o.oPosX = -1000
    o.oPosY = 50
    o.oPosZ = -1800 
end

function custom_falling_pillar(o) -- theres an argument to be made that adding complex behavior to this would bloat JRH'S cave by a lot, so its being kept to something simple
    local m = nearest_mario_state_to_object(o)
    local angletomario = obj_angle_to_object(o, m.marioObj)
    local dist = dist_between_objects(o, m.marioObj)
    if o.oAction == 0 or (o.oAction == 2 and o.oTimer < 20) then
        o.oFaceAngleYaw = angletomario
    end
    if o.oAction ~= 2 and dist <= 1300 then
        --djui_chat_message_create("sword sfx")
        o.oAction = 2
        o.oAnimState = o.oTimer % 4

        --o.oTimer = o.oTimer + 3 -- no idea if this is doing anything (i am coding noob)
    end
    metalhit(o)
end

--function custom_snufit(o) -- Periodically shoots one large bullet at the player, faster cooldown.
    --if o.oAction == 0 then 
        --obj_scale(o, .5)
    --end
    --if o.oAction == 1 then
        --obj_scale(3)
    --end

--end

function fake_fire_init(o)
    obj_set_billboard(o)
    o.header.gfx.skipInViewCheck = true
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj_scale(o, 8)
end

function fake_fire_loop(o)
    local m = nearest_mario_state_to_object(o)
    o.oPosX = m.pos.x
    o.oPosY = m.pos.y + 40
    o.oPosZ = m.pos.z
    o.oAnimState = o.oTimer % 2
end

function bhv_custom_swoop(o)
    local m = nearest_mario_state_to_object(o)
    local pitchToMario = obj_pitch_to_object(o, gMarioStates[0].marioObj) --ty flipflop bell
    if o.oBehParams2ndByte == 50 and o.oAction == 1 then
        obj_scale(o, 0.5)
        obj_compute_vel_from_move_pitch(15)
        cur_obj_rotate_yaw_toward(o.oAngleToMario, 0xF00)
        cur_obj_rotate_pitch_toward(o, pitchToMario, 0xF00)
        if dist_between_objects(o, m.marioObj) < 100 and m.action & ACT_FLAG_ATTACKING == 0 then
            m.squishTimer = 50
        end
    end
    
    if o.oAction == 1 and o.oBehParams2ndByte ~= 50 then
        if o.oTimer < 30 then
            o.oVelY = 10
        elseif o.oAction == 1 and o.oTimer == 30 then
            o.oVelY = 0
            o.oForwardVel = 25
        end
        if o.oTimer % 35 == 0 and o.oBehParams2ndByte ~= 50 and o.oTimer ~= 0 then
            spawn_sync_object(id_bhvSwoop, E_MODEL_SWOOP, o.oPosX, o.oPosY, o.oPosZ, function(s)
            s.oBehParams2ndByte = 50
            s.oAction = 1
            end)
        end
        if o.oTimer == 150 then
            obj_mark_for_deletion(o)
            spawn_mist_particles()
        end
    end

    if o.oPrevAction == 1 and o.oAction == 0 then
        o.oAction = 1
    end
end

hook_gore_behavior(id_bhvStaticObject, false, nil, static_obj_loop)
hook_gore_behavior(id_bhvWoodenPost, false, nil, bhv_custom_signpost)
hook_gore_behavior(id_bhvBowserShockWave, false, nil, shockwave)
hook_gore_behavior(id_bhvFirePiranhaPlant, false, nil, fire_piranha_plant)
hook_gore_behavior(id_bhvWigglerHead, false, nil, wiggler_head)
hook_gore_behavior(id_bhvFireSpitter, false, nil, fire_spitter)
hook_gore_behavior(id_bhvPiranhaPlant, false, nil, piranha_plant)
hook_gore_behavior(id_bhvPokeyBodyPart, false, nil, pokey_body_part)
hook_gore_behavior(id_bhvWaterLevelDiamond, false, nil, waterdiamond)
hook_gore_behavior(id_bhvClamShell, false, nil, clam_shell_loop)
hook_gore_behavior(id_bhvTreasureChestBottom, false, chest_bottom_init, nil)
hook_gore_behavior(id_bhvRockSolid, false, nil, exploding_jrb_rock_loop)
hook_gore_behavior(id_bhvKoopa, false, nil, koopatheQUICC)
hook_gore_behavior(id_bhvBitfsTiltingInvertedPyramid, false, nil, invertedpyramid)
hook_gore_behavior(id_bhvSignOnWall, false, nil, delete_on_spawn)
hook_gore_behavior(id_bhvMips, false, nil, mips)
hook_gore_behavior(id_bhvLllSinkingSquarePlatforms, false, nil, obj_explode_if_within_300_units)
hook_gore_behavior(id_bhvLllDrawbridge, false, nil, obj_explode_if_within_300_units)
hook_gore_behavior(id_bhvWfRotatingWoodenPlatform, false, nil, obj_explode_if_within_300_units)
hook_gore_behavior(id_bhvBlueCoinSwitch, false, nil, coin_switch)
hook_gore_behavior(id_bhvRedCoin, false, bhv_custom_coins_init, bhv_custom_coins)
hook_gore_behavior(id_bhvYellowCoin, false, nil, bhv_custom_coins)
hook_gore_behavior(id_bhvCoinFormationSpawn, true, bhv_custom_coins_init, bhv_custom_coins)
hook_gore_behavior(id_bhvScuttlebug, false, nil, scuttlebug_loop)
hook_gore_behavior(id_bhvSkeeter, false, nil, skeeter_loop)
hook_gore_behavior(id_bhvHeaveHo, false, nil, heaveho_loop)
hook_gore_behavior(id_bhvGhostHuntBoo, false, nil, boo_loop)
hook_gore_behavior(id_bhvBoo, false, nil, boo_loop)
hook_gore_behavior(id_bhvMerryGoRoundBoo, false, nil, boo_loop)
hook_gore_behavior(id_bhvGhostHuntBigBoo, false, nil, boo_loop)
hook_gore_behavior(id_bhvBalconyBigBoo, false, nil, boo_loop)
hook_gore_behavior(id_bhvMerryGoRoundBigBoo, false, nil, boo_loop)
hook_gore_behavior(id_bhvMrIParticle, false, nil, mr_i_particle)
hook_gore_behavior(id_bhvMrI, false, nil, mr_i)
hook_event(HOOK_ON_PLAY_SOUND, sfx_management)
hook_event(HOOK_MARIO_UPDATE, killer_exclamation_boxes)
hook_gore_behavior(id_bhvStarDoor, true, star_door_init, star_door_loop)
hook_gore_behavior(id_bhvDorrie, false, nil, dorrie_dead)
hook_gore_behavior(id_bhvEyerokBoss, false, nil, eyerok_loop)
hook_gore_behavior(id_bhvWigglerHead, false, nil, wiggler_loop)
hook_gore_behavior(id_bhvSquishablePlatform, false, nil, bhv_squishable_platform_loop)
hook_gore_behavior(id_bhvYoshi, false, nil, bhv_custom_yoshi)
hook_gore_behavior(id_bhvActivatedBackAndForthPlatform, false, nil, bhv_custom_ActivatedBackAndForthPlatform)
hook_gore_behavior(id_bhvCirclingAmp, false, nil, bhv_custom_circlingamp)
hook_gore_behavior(id_bhvSquarishPathMoving, false, nil, bhv_custom_squarishPathMoving)
hook_gore_behavior(id_bhvSlidingPlatform2, false, nil, bhv_custom_slidingplatform2)
hook_gore_behavior(id_bhvAnimatesOnFloorSwitchPress, false, nil, bhv_custom_animates_on_floor_switch_press)
hook_gore_behavior(id_bhvSpindrift, false, nil, bhv_custom_spindrift)
hook_gore_behavior(id_bhvSnowmansBottom, false, nil, snowman_body_loop)
hook_gore_behavior(id_bhvHauntedChair, false, nil, bhv_custom_chairs)
hook_gore_behavior(id_bhvFlyingBookend, false, nil, bhv_custom_books)
hook_gore_behavior(id_bhvMadPiano, false, nil, bhv_custom_piano)
hook_gore_behavior(id_bhvMerryGoRound, false, nil, bhv_custom_merry_go_round)
hook_gore_behavior(id_bhvTumblingBridgePlatform, false, nil, bhv_custom_tumbling_bridge)
hook_gore_behavior(id_bhvSmallPenguin, false, nil, bhv_custom_tuxie)
hook_gore_behavior(id_bhvPlatformOnTrack, false, nil, bhv_custom_moving_plats)
hook_gore_behavior(id_bhvRecoveryHeart, false, nil, bhv_custom_heart)
hook_gore_behavior(id_bhvRrRotatingBridgePlatform, false, nil, bhv_custom_rotating_platform)
hook_gore_behavior(id_bhvSwingPlatform, false, nil, bhv_custom_swing)
--hook_gore_behavior(id_bhv1Up, false, nil, bhv_custom_1up)
hook_gore_behavior(id_bhvHidden1upInPole, false, nil, bhv_custom_1up)
hook_gore_behavior(id_bhvFlyGuy, false, nil, bhv_custom_flyguy)
hook_gore_behavior(id_bhvBigBoulder, false, nil, bhv_custom_boulder)
hook_gore_behavior(id_bhvBouncingFireball, false, nil, bhv_custom_bouncing_fireball)
hook_gore_behavior(id_bhvChainChomp, false, nil, bhv_custom_chain_chomp)
hook_gore_behavior(id_bhvBowserBomb, false, nil, bhv_custom_bowserbomb)
hook_gore_behavior(id_bhvCheckerboardPlatformSub, false, nil, bhv_checkerboard_platform)
hook_gore_behavior(id_bhvFerrisWheelAxle, false, nil, bhv_ferris_wheel_axle)
hook_gore_behavior(id_bhvFerrisWheelPlatform, false, nil, bhv_ferris_wheel)
hook_gore_behavior(id_bhvHorizontalGrindel, false, nil, bhv_custom_grindel)
hook_gore_behavior(id_bhvSpindel, false, nil, bhv_custom_spindel)
hook_gore_behavior(id_bhvFlamethrower, false, nil, bhv_custom_flamethrower)
hook_gore_behavior(id_bhvLllRotatingHexFlame, false, nil, bhv_custom_firebars)
hook_gore_behavior(id_bhvLllRotatingHexagonalPlatform, false, nil, bhv_custom_hex_platform)
hook_gore_behavior(id_bhvRotatingPlatform, false, nil, bhv_custom_rotating_platform)
hook_gore_behavior(id_bhvLllVolcanoFallingTrap, false, nil, bhv_custom_crushtrap)
hook_gore_behavior(id_bhvSmallBully, false, nil, bhv_custom_bully)
hook_gore_behavior(id_bhvBigBully, false, bhv_custom_bully_boss_init, bhv_custom_bully_boss_loop)
hook_gore_behavior(id_bhvToxBox, false, nil, bhv_custom_toxbox)
hook_gore_behavior(id_bhvWfSlidingPlatform, false, nil, bhv_custom_whomp_slidingpltf)
hook_gore_behavior(id_bhvLargeBomp, false, large_bomp_hitbox, bhv_custom_large_bomp_loop)
hook_gore_behavior(id_bhvBulletBill, false, nil, bhv_custom_bullet_bill)
hook_gore_behavior(id_bhvWfSolidTowerPlatform, false, nil, bhv_custom_tower_platforms)
hook_gore_behavior(id_bhvWfSlidingTowerPlatform, false, nil, bhv_custom_tower_platforms)
hook_gore_behavior(id_bhvWfElevatorTowerPlatform, false, nil, bhv_custom_tower_elevator)
hook_gore_behavior(id_bhvSeesawPlatform, false, nil, bhv_custom_seesaw)
hook_gore_behavior(id_bhvBbhTiltingTrapPlatform, false, nil, bhv_custom_tilting_plat)
hook_gore_behavior(id_bhvCoffin, false, nil, bhv_custom_coffin)
hook_gore_behavior(id_bhvHiddenStaircaseStep, false, nil, bhv_custom_staircase_step)
--hook_gore_behavior(id_bhvHauntedBookshelf, false, nil, bhv_custom_haunted_bookshelf)
hook_gore_behavior(id_bhvMessagePanel, false, nil, bhv_custom_sign)
hook_gore_behavior(id_bhvTree, false, nil, bhv_custom_tree)
hook_gore_behavior(id_bhvWhompKingBoss, false, nil, bhv_custom_kingwhomp)
hook_gore_behavior(id_bhvKingBobomb, false, nil, bhv_custom_kingbobomb)
hook_gore_behavior(id_bhvSmallWhomp, false, nil, bhv_custom_whomp)
hook_gore_behavior(id_bhvThwomp, false, nil, bhv_custom_thwomp)
hook_gore_behavior(id_bhvThwomp2, false, nil, bhv_custom_thwomp)
hook_gore_behavior(id_bhvPitBowlingBall, false, nil, bhv_custom_pitbowlball)
hook_gore_behavior(id_bhvBowlingBall, false, nil, bhv_custom_bowlball)
hook_gore_behavior(id_bhvBobBowlingBallSpawner, false, nil, bhv_custom_bowlballspawner)
hook_gore_behavior(id_bhvExplosion, false, bhv_custom_explosion, nil)
hook_gore_behavior(id_bhvBobomb, false, nil, bobomb_loop)
hook_gore_behavior(id_bhvGoomba, false, nil, bhv_custom_goomba_loop)
hook_event(HOOK_ALLOW_INTERACT, goom_int)
hook_gore_behavior(id_bhvKlepto, false, bhv_klepto_init, bhv_klepto_loop)
hook_gore_behavior(id_bhvBowserKey, false, bhv_bowser_key_custom_init, bhv_bowser_key_custom_loop)
--hook_gore_behavior(id_bhvWingCap, false, nil, bhv_custom_wc)
--hook_gore_behavior(id_bhvBobombBuddy, false, bobomb_lantern_init, bobomb_lantern_loop)
hook_gore_behavior(id_bhvHoot, false, nil, hoot_loop)
hook_gore_behavior(id_bhvChuckya, false, nil, chuckya)
hook_gore_behavior(id_bhvFlame, false, flame_loop)
hook_gore_behavior(id_bhvBreakableBoxSmall, false, nil, bhv_custom_cork_box)
hook_gore_behavior(id_bhvBooInCastle, false, nil, castle_boo_init)
hook_gore_behavior(id_bhvFallingPillar, false, nil, custom_falling_pillar)
--hook_gore_behavior(id_bhvSnufit, false, nil, custom_snufit)
hook_gore_behavior(id_bhvSwoop, false, nil, bhv_custom_swoop)
--hook_gore_behavior(id_bhvLllSinkingRectangularPlatform, false, nil, custom_sinking_rectangular_plat_loop)
id_bhvHellEntrance = hook_behavior(nil, OBJ_LIST_UNIMPORTANT, true, hell_entrance_init, hell_entrance_loop, "HellEntrance")
id_bhvBloodMist = hook_behavior(nil, OBJ_LIST_UNIMPORTANT, true, blood_mist_init, blood_mist_loop, "bhvBloodMist")
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
id_bhvRockShrapnel = hook_behavior(nil, OBJ_LIST_GENACTOR, true, rock_shrapnel_init, rock_shrapnel_loop, "bhvRockShrapnel")
id_bhvGib = hook_behavior(nil, OBJ_LIST_UNIMPORTANT, true, gib_init, gib_loop, "bhvGib")
id_bhvFireRing = hook_behavior(nil, OBJ_LIST_GENACTOR, true, firering_init, firering_loop, "bhvFireRing")
id_bhvGorrie = hook_behavior(nil, OBJ_LIST_SURFACE, true, gorrie_init, gorrie_loop)
id_bhvLantern = hook_behavior(nil, OBJ_LIST_SURFACE, true, lantern_init, lantern_loop)
id_bhvGlow = hook_behavior(nil, OBJ_LIST_GENACTOR, true, glow_init, glow_loop)
id_bhvGoggles = hook_behavior(nil, OBJ_LIST_GENACTOR, true, goggles_init, goggles_loop)
id_bhvStonewall = hook_behavior(nil, OBJ_LIST_SURFACE, true, stonewall_init, stonewall_loop)
id_bhvVomit = hook_behavior(nil, OBJ_LIST_GENACTOR, true, vomit_init, vomit_loop)
id_bhvPokeySpike = hook_behavior(nil, OBJ_LIST_GENACTOR, true, pokey_spike_init, pokey_spike_loop)
id_bhvRacerHitbox = hook_behavior(nil, OBJ_LIST_GENACTOR, true, RacerHitbox_init, RacerHitbox_loop)
id_bhvFakeFire = hook_behavior(nil, OBJ_LIST_GENACTOR, true, fake_fire_init, fake_fire_loop, "bhvFakeFire")