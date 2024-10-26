--All custom behaviors.

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
    o.oForwardVel = 30
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
        if isApproaching then djui_chat_message_create("go go")             end
        if isShooting and not tooClose then djui_chat_message_create("keep going !!")     end
        if tooClose      then djui_chat_message_create("WAIT NO STOP STOP") end
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
        djui_chat_message_create(""..o.oAngleToHome)
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

--[[ I tried to make coins run away from mario like 6 different ways. It aint happening. 
function bhv_custom_coins(o)
    local player = nearest_mario_state_to_object(o)
    --local player = nearest_player_to_object(o)
    if mario_is_within_rectangle(o.oPosX - 250, o.oPosX + 250, o.oPosZ - 250, o.oPosZ + 250) ~= 0 then
        local coin = spawn_sync_object(id_bhvBlueCoinSliding, E_MODEL_YELLOW_COIN, o.oPosX, o.oPosY, o.oPosZ, nil)
        obj_mark_for_deletion(o)
        coin.oForwardVel = 20.0
        angleToPlayer = obj_angle_to_object(coin, player.marioObj)
        coin.oMoveAngleYaw = angleToPlayer + 0x8000
    end
end
]]

local function bhv_custom_bully(o)
    local np = gNetworkPlayers[0]
    local m = nearest_mario_state_to_object(o)
    if o.oBehParams == 20 then
        cur_obj_scale(0.02)
        o.oFlags = GRAPH_RENDER_INVISIBLE
    end
    o.oHomeX = m.pos.x
    o.oHomeY = m.pos.y
    o.oHomeZ = m.pos.z
    if o.oAction == BULLY_ACT_CHASE_MARIO or
       o.oAction == BULLY_ACT_PATROL then
        o.oForwardVel = 30
    end
end

local function bhv_custom_explosion(o) -- replaces generic explosions with NUKES! (Bigger radius, bigger explosion, louder)
    local m = nearest_mario_state_to_object(o)
    if o.oBehParams ~= 20 then
        local_play(sBigExplosion, m.pos, 1)
        cur_obj_shake_screen(SHAKE_POS_LARGE)
        spawn_sync_if_main(id_bhvBowserBombExplosion, E_MODEL_BOWSER_FLAMES, o.oPosX, o.oPosY, o.oPosZ, nil, 0)
        if dist_between_objects(o, m.marioObj) <= 850 then
            m.squishTimer = 50
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
    if not (np.currLevelNum == LEVEL_BITS and obj.oPosY > -3500) then
        obj.oSeesawPlatformPitchVel = -400
    end
end

local function bhv_custom_sign(o) --This is the single most evil addition to the game. Real proud of this one :')
    --m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
    local m = nearest_player_to_object(o)
    if dist_between_objects(m, o) < 500 then
        --evilsign =
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

local function bhv_custom_tree(o) -- Trees fall down through the map when approached.
    local m = gMarioStates[0]
    local np = gNetworkPlayers[0]
    if lateral_dist_between_objects(m.marioObj, o) < 150 then
        o.oPosY = o.oPosY - 500
        if np.currLevelNum == LEVEL_WF then
            local hoot = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvHoot)
            if hoot and hoot.oHootAvailability ~= HOOT_AVAIL_WANTS_TO_TALK then
                --spawn_sync_object(id_bhvExplosion, E_MODEL_EXPLOSION, o.oPosX, o.oPosY + 200, o.oPosZ, function (x) x.oBehParams = 20 end)
                hoot.oHootAvailability = HOOT_AVAIL_WANTS_TO_TALK
                play_secondary_music(0,0,0,0)
                obj_mark_for_deletion(o)
            end
        end
    end
end

local function bhv_custom_bowlball(bowlball) -- I've got big balls, oh I've got big balls. They're such BIG balls, fancy big balls! And he's got big balls, and she's got big balls!
    obj_scale(bowlball, 1.8)
    bowlball.oForwardVel = bowlball.oForwardVel + 1
    bowlball.oFriction = 1
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
    o.oPosY = o.oHomeY
end, nil)

local function lava_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = COL_LAVA
    o.oCollisionDistance = 10000
    o.header.gfx.skipInViewCheck = true
    bhv_init_room()
end

local function lava_loop(o)
    load_object_collision_model()
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

local function bhv_custom_hex_platform(o)
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
end

local function bhv_backroom_smiler_loop(o)
    local m = gMarioStates[0]
    local s = gStateExtras[0]
    local player = nearest_player_to_object(o)
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
    obj_turn_toward_object(o, player, 16, 0x800)
    o.oForwardVel = 20
    object_step()
    if o.oTimer % 280 == 1 and np.currLevelNum ~= LEVEL_TTM then
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
            if gGlobalSyncTable.gameisbeat then
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

local function bhv_custom_slidingplatform2(o)
    local np = gNetworkPlayers[0]
    if np.currLevelNum == LEVEL_BITDW or np.currLevelNum == LEVEL_BITFS then
        obj_mark_for_deletion(o)
    end
end

local function bhv_custom_circlingamp(o)
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

local function bhv_custom_squarishPathMoving(o)
    local np = gNetworkPlayers[0]

    if np.currLevelNum == LEVEL_BITDW and o.oPosY <= -2959 then
        obj_mark_for_deletion(o)
    end

    if np.currLevelNum == LEVEL_BITFS then
        obj_mark_for_deletion(o)
    end

end

local function bhv_custom_ActivatedBackAndForthPlatform(o)
    local m = nearest_mario_state_to_object(o)
    local np = gNetworkPlayers[0]

    if np.currLevelNum == LEVEL_BITFS and m.pos.y >= o.oPosY -10 and mario_is_within_rectangle(o.oPosX - 500, o.oPosX + 500, o.oPosZ - 500, o.oPosZ + 500) ~= 0 then
        spawn_triangle_break_particles(30, 138, 1, 4)
        spawn_mist_particles()
        set_camera_shake_from_hit(SHAKE_POS_MEDIUM)
        play_sound(SOUND_GENERAL_WALL_EXPLOSION, m.marioObj.header.gfx.cameraToObject)
        play_sound(SOUND_GENERAL_EXPLOSION6, m.marioObj.header.gfx.cameraToObject)

        obj_mark_for_deletion(o)
    end
end

local function bhv_custom_yoshi(o)
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
            --gPlayerSyncTable[m.playerIndex].gold = true

        else
            if m.numStars >= 50 or gGlobalSyncTable.gameisbeat then
                set_mario_action(m, ACT_UNLOCKING_STAR_DOOR, 0)
                m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
                m.pos.y = m.pos.y + 120
                o.oTimer = 0
            else
                djui_chat_message_create("You need at least 50 stars to enter. (Or beat the game)")
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
    -- cur_obj_move_using_vel()
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
    local bloodcount = obj_count_objects_with_behavior_id(id_bhvSquishblood)
    cur_obj_update_floor()

    if o.oTimer > 900 or bloodcount > 15 then --This protects blood spam and low FPS
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

end

local function gib_loop(o)
    local m = gMarioStates[0]
    local random = math.random(1,1500)
    local gibs = obj_count_objects_with_behavior_id(id_bhvGib)

    if gibs > 240 then
        obj_mark_for_deletion(o)
    end

    if m.marioObj.oTimer < 10 then --This protects from gib spam and low FPS
        obj_mark_for_deletion(o)
    end

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

local function bhv_klepto_init(o)
    local np = gNetworkPlayers[0]
    if np.currActNum > 1 then
        o.oAction = 10
        o.oBehParams2ndByte = 0
    end
end

local function bhv_klepto_loop(o)
    local m = gMarioStates[0]
    local player = nearest_player_to_object(o)
    local np = gNetworkPlayers[0]

    --djui_chat_message_create(tostring(o.oTimer))

    if (o.oAction == KLEPTO_ACT_STRUCK_BY_MARIO) then
        gibs(o)
        network_play(sPunch, m.pos, 1, m.playerIndex)
        o.oAction = 10
        o.oTimer = 2
    end

    if o.oAction == KLEPTO_ACT_SEARCH_FOR_MARIO then --Klepto is pissed and hunts for nearest player.
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
                o.oAction = 9
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
        --o.oKleptoSpeed = 60
        obj_turn_toward_object(o, player, 16, 0x800)
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

function blood_mist_init(o)
    -- someone more experienced than me can probably do the init and loop better
    --local s = gStateExtras[0]
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.node.flags = o.header.gfx.node.flags | GRAPH_RENDER_BILLBOARD
    o.header.gfx.skipInViewCheck = true
    o.oGraphYOffset = 40
    obj_scale(o, 1)
end

function blood_mist_loop(o)
    o.oOpacity = (-clampf(math.floor(o.oTimer * 8), 0, 255) + 255)
    o.oGraphYOffset = o.oGraphYOffset + -2.5
    if o.oTimer > 30 then -- 2 second timer before deleting. 
        obj_mark_for_deletion(o)
    end
end

function lantern_init(o)
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

function lantern_loop(o)
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

function glow_init(o)
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.node.flags = o.header.gfx.node.flags | GRAPH_RENDER_BILLBOARD
    o.header.gfx.skipInViewCheck = true
    obj_set_billboard(o)
    obj_scale(o, 2)
    o.oOpacity = 255

end

function glow_loop(o)
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

function goggles_init(o)
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.skipInViewCheck = true
    o.hitboxRadius = 50
    o.hitboxHeight = 50
    o.oFaceAnglePitch = -2000
    o.oMoveAnglePitch = o.oFaceAnglePitch
    obj_scale(o, 1.3)
end

function goggles_loop(o)
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

function hoot_loop(o)
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

function chuckya(o)
    local nm = nearest_mario_state_to_object(o)
    local m = gMarioStates[0]
    if o.oTimer == 10 and o.oAction == 1 then
        network_play(sChuckster, m.pos, 1, m.playerIndex)
        cutscene_object_with_dialog(CUTSCENE_DIALOG, nm.marioObj, DIALOG_116)
    end
end

function stonewall_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.collisionData = COL_STONEWALL
    o.oCollisionDistance = 10000
    o.header.gfx.skipInViewCheck = true
end

function stonewall_loop(o)
    load_object_collision_model()
end

function flame_loop(o) --This is to help prevent a bunch of stuck flames from building up in Hell near the beginning. 
    np = gNetworkPlayers[0]
    if o.oBehParams == 4 and o.oTimer > 400 then -- BehParam 4 is set to the usedflame when mario ignites. This will cause that flame to burn out within 500 frames.
        obj_unused_die()
        obj_mark_for_deletion(o)
    end
end

function vomit_init(o)
    o.oFlags = (OBJ_FLAG_ACTIVE_FROM_AFAR | OBJ_FLAG_COMPUTE_DIST_TO_MARIO | OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE)
    o.header.gfx.node.flags = o.header.gfx.node.flags | GRAPH_RENDER_BILLBOARD
    o.header.gfx.skipInViewCheck = true
    o.oGraphYOffset = 40
    obj_scale(o, 0.2)
    o.oGravity = -1
    end

function vomit_loop(o)
    local sickmario = nearest_mario_state_to_object(o)
    --obj_set_face_angle(o, sickmario.marioObj.oFaceAnglePitch, sickmario.marioObj.oFaceAngleYaw, sickmario.marioObj.oFaceAngleRoll)
    --obj_set_face_angle_to_move_angle(o)
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

function heaveho_loop(o)
    local m = gMarioStates[0]
    if o.oHeaveHoUnk88 >= 1 then
        set_mario_action(m, ACT_RAGDOLL, 0)
        m.pos.y = m.pos.y + 4
    end
    if is_within_100_units_of_mario(o.oPosX, o.oPosY, o.oPosZ) and m.forwardVel == -45 then
        m.forwardVel = 45
        m.vel.y = m.vel.y + 80
    end
end

function skeeter_loop(o)
    local m = nearest_mario_state_to_object(o)
    if is_point_within_radius_of_mario(o.oPosX, o.oPosY, o.oPosZ, 1200) ~= 0 and m.action ~= ACT_GONE then
        local ang = obj_angle_to_object(o, m.marioObj)
        o.oForwardVel = 65
        o.oFaceAngleYaw = ang
        o.oMoveAngleYaw = o.oFaceAngleYaw
    end
end

function scuttlebug_loop(o)
    --Nothing yet D:
end

function coin_switch(o)
    if o.oAction == BLUE_COIN_SWITCH_ACT_RECEDING and o.oTimer == 4 then
        local m = gMarioStates[0]
        set_mario_action(m, ACT_BUTT_STUCK_IN_GROUND, 0)
    end
end

hook_gore_behavior(id_bhvBlueCoinSwitch, false, nil, coin_switch)
hook_gore_behavior(id_bhvScuttlebug, false, nil, scuttlebug_loop)
hook_gore_behavior(id_bhvSkeeter, false, nil, skeeter_loop)
hook_gore_behavior(id_bhvHeaveHo, false, nil, heaveho_loop)
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
hook_gore_behavior(id_bhvSpindrift, false, nil, bhv_custom_spindrift)
hook_gore_behavior(id_bhvHauntedChair, false, nil, bhv_custom_chairs)
hook_gore_behavior(id_bhvMadPiano, false, nil, bhv_custom_piano)
hook_gore_behavior(id_bhvMerryGoRound, false, nil, bhv_custom_merry_go_round)
hook_gore_behavior(id_bhvSmallPenguin, false, nil, bhv_custom_tuxie)
hook_gore_behavior(id_bhvPlatformOnTrack, false, nil, bhv_custom_moving_plats)
hook_gore_behavior(id_bhvRecoveryHeart, false, nil, bhv_custom_heart)
hook_gore_behavior(id_bhvRrRotatingBridgePlatform, false, nil, bhv_custom_rotating_platform)
hook_gore_behavior(id_bhvSwingPlatform, false, nil, bhv_custom_swing)
--hook_gore_behavior(id_bhv1Up, false, nil, bhv_custom_1up)
--hook_gore_behavior(id_bhvHidden1upInPole, false, nil, bhv_custom_1up)
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
hook_gore_behavior(id_bhvLllRotatingHexFlame, false, nil, bhv_custom_firebars)
hook_gore_behavior(id_bhvLllRotatingHexagonalPlatform, false, nil, bhv_custom_hex_platform)
hook_gore_behavior(id_bhvLllVolcanoFallingTrap, false, nil, bhv_custom_crushtrap)
hook_gore_behavior(id_bhvSmallBully, false, nil, bhv_custom_bully)
hook_gore_behavior(id_bhvToxBox, false, nil, bhv_custom_toxbox)
hook_gore_behavior(id_bhvWfSlidingPlatform, false, nil, bhv_custom_whomp_slidingpltf)
hook_gore_behavior(id_bhvSeesawPlatform, false, nil, bhv_custom_seesaw)
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
hook_gore_behavior(id_bhvKlepto, false, bhv_klepto_init, bhv_klepto_loop)
hook_gore_behavior(id_bhvBowserKey, false, bhv_bowser_key_custom_init, bhv_bowser_key_custom_loop)
--hook_gore_behavior(id_bhvBobombBuddy, false, bobomb_lantern_init, bobomb_lantern_loop)
hook_gore_behavior(id_bhvHoot, false, nil, hoot_loop)
hook_gore_behavior(id_bhvChuckya, false, nil, chuckya)
hook_gore_behavior(id_bhvFlame, false, flame_loop)
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
id_bhvGib = hook_behavior(nil, OBJ_LIST_UNIMPORTANT, true, gib_init, gib_loop, "bhvGib")
id_bhvFireRing = hook_behavior(nil, OBJ_LIST_GENACTOR, true, firering_init, firering_loop, "bhvFireRing")
id_bhvGorrie = hook_behavior(nil, OBJ_LIST_SURFACE, true, gorrie_init, gorrie_loop)
id_bhvLantern = hook_behavior(nil, OBJ_LIST_SURFACE, true, lantern_init, lantern_loop)
id_bhvGlow = hook_behavior(nil, OBJ_LIST_GENACTOR, true, glow_init, glow_loop)
id_bhvGoggles = hook_behavior(nil, OBJ_LIST_GENACTOR, true, goggles_init, goggles_loop)
id_bhvStonewall = hook_behavior(nil, OBJ_LIST_SURFACE, true, stonewall_init, stonewall_loop)
id_bhvVomit = hook_behavior(nil, OBJ_LIST_GENACTOR, true, vomit_init, vomit_loop)
