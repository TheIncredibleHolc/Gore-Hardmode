-- name: GORE / Hard-Mode!
-- description: Gore and extreme challenges! Not for the faint of heart.\n\nIf you're combining this mode with a romhack, consider using "Romhack Compatibility" in the Mod Menu.\n\nIf you're feeling especially bold, try breaking the community record for "IWBTG Mode", selectable in the Mod Menu! \n\n\n\n\nAnother awesome mod from the GORE Team: IncredibleHolc, Cooliokid956, Blocky.cmd, Birdekek, Saniky, Tilly, Isaac, Frijoles, ProfeJavix, and I'mYourCat.
-- incompatible: gore

-------TESTING NOTES AND KNOWN BUGS-------------

-- goombas can double squish while in "chase mode"
-- the player's velocity is carried over whentakign fall damage on a downwards slope
-- swoops will switch from rendering to not rendering when activated and too far away

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

function test()
    local m = gMarioStates[0]
    if m.controller.buttonPressed & Y_BUTTON ~= 0 then
        --m.pos.x = -3601
        --m.pos.y = -4279
        --m.pos.z = 3591
        --m.faceAngle.y = 16384
        --m.numStars = 100
        --m.pos.x = m.pos.x - 200
    end

end

hook_event(HOOK_UPDATE, test)

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- GBEHAVIORVALUES -- Fast switches to manipulate the game.

--gLevelValues.entryLevel = LEVEL_TOTWC

--For PVP murdering. Default off.
gGlobalSyncTable.pvp = false

--Romhack compatibility mode. Default OFF. Controls custom level spawns. 
gGlobalSyncTable.romhackcompatibility = false

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

--Slide and Metal/Wing Cap timers
gLevelValues.pssSlideStarTime = 420 -- 14 seconds
gLevelValues.metalCapDuration = 1500 -- 45 seconds (only for JRH, it'll decrease in other levels)
gLevelValues.metalCapDurationCotmc = 1800 -- 60 seconds
gLevelValues.wingCapDuration = 900 -- 30 seconds
gLevelValues.wingCapDurationTotwc = 2250 -- 75 seconds (good luck running out of that)

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
    [id_bhvTTC2DRotator]       = bhv_ttc_2d_rotator_update,
    [id_bhvTTCCog]             = bhv_ttc_cog_update,
    [id_bhvTTCElevator]        = bhv_ttc_elevator_update,
    [id_bhvTTCMovingBar]       = bhv_ttc_moving_bar_update,
    [id_bhvTTCPendulum]        = bhv_ttc_pendulum_update,
    [id_bhvTTCPitBlock]        = bhv_ttc_pit_block_update,
    [id_bhvTTCRotatingSolid]   = bhv_ttc_rotating_solid_update,
    [id_bhvTTCSpinner]         = bhv_ttc_spinner_update,
    [id_bhvTTCTreadmill]       = bhv_ttc_treadmill_update,
    [id_bhvDecorativePendulum] = bhv_decorative_pendulum_loop,
    [id_bhvClockHourHand]      = bhv_rotating_clock_arm_loop,
    [id_bhvClockMinuteHand]    = bhv_rotating_clock_arm_loop,
}

local fastbhv = {}

local function speed_objs(o)
    if true then
        fastbhv[get_id_from_behavior(o.behavior)]()
        fastbhv[get_id_from_behavior(o.behavior)]()
    end
end

local function ttc_collision_distance_fix(o)
    o.oCollisionDistance = 65535
end

for bhv, func in pairs(realbhv) do
    fastbhv[hook_behavior(bhv, get_object_list_from_behavior(get_behavior_from_id(bhv)), false, ttc_collision_distance_fix, speed_objs, get_behavior_name_from_id(bhv))] = func
end

function is_lowest_active_player()
    return get_network_player_smallest_global().localIndex == 0
end

function ia(m)
    return m.playerIndex == 0
end
function lerp(a, b, t) return a * (1 - t) + b * t end

function vec3f() return {x=0,y=0,z=0} end

function vec3f_rotate_zyx(dest, rotate)
    local v = { x = dest.x, y = dest.y, z = dest.z }
    
    local sx = sins(rotate.x)
    local cx = coss(rotate.x)

    local sy = sins(rotate.y)
    local cy = coss(rotate.y)

    local sz = sins(rotate.z)
    local cz = coss(rotate.z)

    -- Rotation around Z axis
    local xz = v.x * cz - v.y * sz
    local yz = v.x * sz + v.y * cz
    local zz = v.z

    -- Rotation around Y axis
    local xy = xz * cy + zz * sy
    local yy = yz
    local zy = -xz * sy + zz * cy

    -- Rotation around X axis
    dest.x = xy
    dest.y = yy * cx - zy * sx
    dest.z = yy * sx + zy * cx

    return dest
end

function limit_angle(a) return (a + 0x8000) % 0x10000 - 0x8000 end

function spawn_sync_if_main(behaviorId, modelId, x, y, z, objSetupFunction, i)
    print("index:", i)
    print("attempt by "..get_network_player_smallest_global().name)
    print(get_network_player_smallest_global().localIndex + i)
    --djui_chat_message_create("index:".. i)
    --djui_chat_message_create((get_network_player_smallest_global().localIndex + i) .. "")
    if get_network_player_smallest_global().localIndex + i == 0 then print("passed!") return spawn_sync_object(behaviorId, modelId, x, y, z, objSetupFunction) end
end

------Globals--------
local function modsupport()
    for key,value in pairs(gActiveMods) do
        if (value.name == "Flood") or _G.floodExpanded then
            if network_is_server() then
                --djui_chat_message_create("Gore/HM Flood compatibility enabled.")
                gGlobalSyncTable.floodenabled = true
                gGlobalSyncTable.gameisbeat = false
            end
        else
            if network_is_server() then
                gGlobalSyncTable.floodenabled = false
                --djui_chat_message_create("no flood")
            end
        end
        if (value.name == "Cheats") then
            gGlobalSyncTable.cheats = true
        end
    end
end

--Textures
local TEX_MARIO_LESS_HIGH = get_texture_info('mariolesshigh')
local TEX_BLOOD_OVERLAY = get_texture_info('bloodoverlay')
local TEX_TRIPPY_OVERLAY = get_texture_info('trippy')
local TEX_PORTAL = get_texture_info("portal")
local TEX_GAMEOVER = get_texture_info("gameover")
local TEX_DIRT = get_texture_info("grass_09004800")
local TEX_NIGHTVISION = get_texture_info("nightvision")
local TEX_NIGHTVISION2 = get_texture_info("nightvision2")
local TEX_NIGHTVISION3 = get_texture_info("nightvision3")
local TEX_NIGHTVISION4 = get_texture_info("nightvision4")
local TEX_NIGHTVISION5 = get_texture_info("nightvision5")
local TEX_JRHLAVA = get_texture_info("jrhlava")
-----------------------------------------------------------------------------------------------------------------------------
-------ACT_FUNCTIONS------------

function squishblood(o) -- Creates instant pool of impact-blood under an object.
    local m = gMarioStates[0].playerIndex
    --local count = obj_count_objects_with_behavior_id(id_bhvSquishblood)
    spawn_non_sync_object(id_bhvSquishblood, E_MODEL_BLOOD_SPLATTER, o.oPosX, find_floor_height(o.oPosX, o.oPosY, o.oPosZ) + 2, o.oPosZ, nil)
    bloodmist(o)
    --djui_chat_message_create(tostring(count))

end

function squishblood_if_main(o) -- Creates instant pool of impact-blood under an object.
    local m = gMarioStates[0].playerIndex
    --local count = obj_count_objects_with_behavior_id(id_bhvSquishblood)
    spawn_sync_if_main(id_bhvSquishblood, E_MODEL_BLOOD_SPLATTER, o.oPosX, find_floor_height(o.oPosX, o.oPosY, o.oPosZ) + 2, o.oPosZ, nil, 0)
    bloodmist(o)
    --djui_chat_message_create(tostring(count))

end

function squishblood_nogibs(o) -- Creates instant pool of impact-blood under an object.
    spawn_sync_object(id_bhvSquishblood, E_MODEL_BLOOD_SPLATTER, o.oPosX, find_floor_height(o.oPosX, o.oPosY, o.oPosZ) + 2, o.oPosZ, function (gibs) gibs.oBehParams = 1 end)
    bloodmist(o)
end

function gibs(o)
    local m = gMarioStates[0]
    if bloodgibs then
    --if m.marioObj.oTimer > 20 then
        for i = 0, 40 do
            if m.playerIndex ~= 0 then return end
            local random = math.random()
            spawn_non_sync_object(id_bhvGib, E_MODEL_GIB, o.oPosX, o.oPosY, o.oPosZ, function (gib)
                obj_scale(gib, random/2)
            end)
        end
    --end
    end
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
        m.health = 0xff
        gPlayerSyncTable[m.playerIndex].gold = false
        set_mario_action(m, ACT_THROWN_FORWARD, 0) --Throws mario forward more to "sell" the fall damage big impact.
        if s.disappear == 1 then --No fall damage, so Mario got squished. No corpse. It's funnier this way. 
            set_mario_action(m, ACT_GONE, 78)
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
    local m = gMarioStates[0] --MIGHT BREAK THINGS, I JUST ADDED THIS DUE TO SM64 EE ERRORS. BE WARNED!
    local np = gNetworkPlayers[0]
    local s = gStateExtras[m.playerIndex]

    if m.flags & MARIO_VANISH_CAP ~= 0 then
        obj_set_model_extended(m.marioObj, E_MODEL_NONE)
    end

    --djui_chat_message_create(tostring(np.currLevelNum))
    --djui_chat_message_create(tostring(np.currAreaIndex))

    if np.currLevelNum == LEVEL_HELL or np.currLevelNum == LEVEL_SECRETHUB then
        gLevelValues.fixCollisionBugs = true
    else
        gLevelValues.fixCollisionBugs = false
    end
    -------------------------------------------------------------------------------
    if s.iwbtg then

        if m.action == ACT_DEATH_ON_STOMACH then
            m.action = ACT_NOTHING
        end

        if m.floor.type == SURFACE_DEATH_PLANE and m.pos.y < m.floorHeight + 2048 then
            m.health = 0xff
            m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags & ~GRAPH_RENDER_ACTIVE
            set_mario_action(m, ACT_GONE, 0)
        end

        if s.iwbtg then
            if np.currLevelNum ~= LEVEL_CASTLE_GROUNDS then
                play_secondary_music(0,0,0,0)
            end
            if m.numLives > 1 then
                m.numLives = 1
            end
            save_file_set_using_backup_slot(true)
        end

        if s.death then
            audio_stream_stop(iwbtg)
        end

        if np.currLevelNum == LEVEL_BOWSER_1 or np.currLevelNum == LEVEL_BOWSER_2 or np.currLevelNum == LEVEL_BOWSER_3 then
            --do nothing
        else
            if not s.death and m.health ~= 0xff and m.numStars < 10 then
                if currentlyPlaying ~= iwbtgMusic[1] then
                    stream_stop_all()
                    stream_play(iwbtgMusic[1])
                end
            elseif not s.death and m.health ~= 0xff and m.numStars >= 10 and m.numStars < 25 then
                audio_stream_stop(iwbtg)
                if currentlyPlaying ~= iwbtgMusic[3] then
                    play_transition(WARP_TRANSITION_FADE_INTO_COLOR, 1, 255, 255, 255)
                    play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 15, 255, 255, 255)
                    stream_stop_all()
                    stream_play(iwbtgMusic[3])
                end
            elseif not s.death and m.health ~= 0xff and m.numStars >= 25 and m.numStars < 40 then
                if currentlyPlaying ~= iwbtgMusic[4] then
                    play_transition(WARP_TRANSITION_FADE_INTO_COLOR, 1, 255, 255, 255)
                    play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 15, 255, 255, 255)
                    stream_stop_all()
                    stream_play(iwbtgMusic[4])
                end
            elseif not s.death and m.health ~= 0xff and m.numStars >= 40 and m.numStars < 55 then
                if currentlyPlaying ~= iwbtgMusic[5] then
                    play_transition(WARP_TRANSITION_FADE_INTO_COLOR, 1, 255, 255, 255)
                    play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 15, 255, 255, 255)
                    stream_stop_all()
                    stream_play(iwbtgMusic[5])
                end
            elseif not s.death and m.health ~= 0xff and m.numStars >= 55 and m.numStars < 70 then
                if currentlyPlaying ~= iwbtgMusic[6] then
                    play_transition(WARP_TRANSITION_FADE_INTO_COLOR, 1, 255, 255, 255)
                    play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 15, 255, 255, 255)
                    stream_stop_all()
                    stream_play(iwbtgMusic[6])
                end
            elseif not s.death and m.health ~= 0xff and m.numStars >= 70 then
                if currentlyPlaying ~= iwbtgMusic[1] then
                    play_transition(WARP_TRANSITION_FADE_INTO_COLOR, 1, 255, 255, 255)
                    play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 15, 255, 255, 255)
                    stream_stop_all()
                    stream_play(iwbtgMusic[1])
                end
            end
        end

        
        if m.action == ACT_QUICKSAND_DEATH and not s.death and not quicksand then
            m.health = 0xff
            m.marioObj.oTimer = 0
            quicksand = true
        elseif m.action == ACT_QUICKSAND_DEATH and quicksand then
            if m.marioObj.oTimer > 25 then
                set_mario_action(m, ACT_NOTHING, 0)
                quicksand = false
            end
        else
            quicksand = false
        end

        if m.health == 0xff and not s.death then
            stream_stop_all()
            local_play(sIwbtgDeath, gLakituState.pos, 1)
            djui_popup_create_global("Total Stars: " .. tostring(m.numStars), 1)
            djui_popup_create_global(tostring(gNetworkPlayers[m.playerIndex].name) .. " has died!", 1)
            delete_save(m)
            gGlobalSyncTable.iwbtgGameoverEveryone = true
            s.death = true
            m.marioObj.oTimer = 1
        end
    end

 ----------------------------------------------------------------------------------------------------------------------------------
    --Turning Gold
    if s.turningGold then
        local m = gMarioStates[0]
        if m.marioObj.oTimer == 30 then
            set_mario_action(m, ACT_IDLE, 0)
            cur_obj_disable_rendering_and_become_intangible(m.marioObj)
        end

        if m.marioObj.oTimer == 58 then
            set_mario_action(m, ACT_EMERGE_FROM_PIPE, 0)

        end

        if m.marioObj.oTimer == 70 then
            spawn_mist_particles()
            network_play(sGround, m.pos, 1, m.playerIndex)
            cur_obj_enable_rendering_and_become_tangible(m.marioObj)
            soft_reset_camera(m.area.camera)
            gPlayerSyncTable[m.playerIndex].gold = true
            s.turningGold = false
        end
    end
 ----------------------------------------------------------------------------------------------------------------------------------
    if not gGlobalSyncTable.romhackcompatibility then
        if np.currLevelNum == LEVEL_BBH then
            if m.marioObj.oTimer <= 30 then
                play_transition(WARP_TRANSITION_FADE_FROM_COLOR, 40, 0, 0, 0)
            end
        end

        if np.currLevelNum == LEVEL_SL and np.currAreaIndex <= 1 then
            set_override_envfx(ENVFX_SNOW_BLIZZARD)
            cur_obj_play_sound_1(SOUND_ENV_WIND1)
            set_lighting_color(0, 100)
            set_lighting_color(1, 147)
            set_lighting_color(2, 200)
            set_vertex_color(0, 100)
            set_vertex_color(1, 147)
            set_vertex_color(2, 200)
            set_fog_color(0, 100)
            set_fog_color(1, 147)
            set_fog_color(2, 200)
        end
    
        if np.currLevelNum == LEVEL_JRB or np.currLevelNum == LEVEL_COTMC then
            if gLakituState.pos.y < 944 then
                --set_lighting_color(0, 255)
                --set_lighting_color(1, 255)
                --set_lighting_color(2, 255)
                --set_lighting_dir(1, 128)
                --set_vertex_color(0, 255)
                --set_vertex_color(1, 255)
                --set_vertex_color(2, 255)
                --set_fog_color(0, 255)
                --set_fog_color(1, 255)
                --set_fog_color(2, 255)
            --else
                set_lighting_color(0, 255)
                set_lighting_color(1, 127)
                set_lighting_color(2, 100)
                set_lighting_dir(1, -128)
                set_vertex_color(0, 255)
                set_vertex_color(1, 127)
                set_vertex_color(2, 100)
                set_fog_color(0, 255)
                set_fog_color(1, 127)
                set_fog_color(2, 100)
            end
        end

        if np.currLevelNum == LEVEL_HMC then
            if gLakituState.pos.y < -4900 then
                set_lighting_color(0, 255)
                set_lighting_color(1, 127)
                set_lighting_color(2, 100)
                set_lighting_dir(1, -128)
                set_vertex_color(0, 58)
                set_vertex_color(1, 66)
                set_vertex_color(2, 17)
                set_fog_color(0, 255)
                set_fog_color(1, 127)
                set_fog_color(2, 100)
            else
                set_lighting_color(0, 255)
                set_lighting_color(1, 255)
                set_lighting_color(2, 255)
                set_lighting_dir(1, 0)
                set_vertex_color(0, 255)
                set_vertex_color(1, 255)
                set_vertex_color(2, 255)
                set_fog_color(0, 255)
                set_fog_color(1, 255)
                set_fog_color(2, 255)
            end
        end

        if np.currLevelNum == LEVEL_HMC and m.pos.y < -3900 then
            set_override_envfx(ENVFX_LAVA_BUBBLES)
        elseif np.currLevelNum == LEVEL_HMC and m.pos.y >= -3900 then
            set_override_envfx(ENVFX_MODE_NONE)
        end

        ---WDW is now just Dry World! 
        if np.currLevelNum == LEVEL_WDW then
            for i = 0, 3 do
                set_environment_region(i, -10000)
            end
        end

        if np.currLevelNum == LEVEL_SSL and np.currAreaIndex == 1 then
            if ia(m) and m.marioObj.oTimer == 30 and not s.sslIntro then
                cutscene_object_with_dialog(CUTSCENE_DIALOG, m.marioObj, DIALOG_046)
                s.sslIntro = true
            end
            if (m.action & ACT_FLAG_WATER_OR_TEXT) == 0 then
                s.ssldiethirst = s.ssldiethirst + 1
            else
                s.ssldiethirst = 0 -- stops timer
            end
    
            if s.ssldiethirst >= 300 then
                m.health = m.health - 2
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
            --m.forwardVel = m.forwardVel + 0.3
        else
            s.ssldiethirst = 0
        end

        if np.currLevelNum == LEVEL_SL and np.currAreaIndex == 1 then
            if ia(m) and m.marioObj.oTimer == 30 and not s.slIntro then
                cutscene_object_with_dialog(CUTSCENE_DIALOG, m.marioObj, DIALOG_070)
                s.slIntro = true
            end
            m.health = m.health - 1
        end
    end
 ----------------------------------------------------------------------------------------------------------------------------------
    --IWBTG Trophy
    if gGlobalSyncTable.gameisbeat and s.iwbtg and m.numStars == 10 then
        if not trophy_unlocked(20) then
            unlock_trophy(20)
            play_sound(SOUND_MENU_COLLECT_SECRET, gGlobalSoundSource)
            djui_chat_message_create("IWBTG Trophy earned!!")
        end
    end
 ----------------------------------------------------------------------------------------------------------------------------------
    --PSS TROPHY
    if np.currLevelNum == LEVEL_PSS and not trophy_unlocked(11) then
        local psstrophy = obj_get_first_with_behavior_id(id_bhvTrophy)
        if gGlobalSyncTable.gameisbeat and not psstrophy then
            if m.pos.y <= -4587 and m.numCoins < 81 then
                m.pos.x = -6401
                m.pos.y = -4162
                m.pos.z = 148
                m.faceAngle.y = 32768
                m.intendedYaw = 32768
                set_mario_action(m, ACT_BUTT_SLIDE, 0)
                m.forwardVel = 120
                play_secondary_music(0, 0, 0, 20)
                djui_chat_message_create("A mysterious force has saved you! What could it mean?")
                if not s.iwbtg then
                    stream_play(edils)
                end
            elseif m.numCoins == 81 then
                play_sound(SOUND_MENU_COLLECT_SECRET, m.pos)
                if not s.iwbtg then
                    stream_stop_all()
                end
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
    if gGlobalSyncTable.gameisbeat and np.currLevelNum == LEVEL_TTM and np.currAreaIndex == 3 and not trophy_unlocked(13) then --GRANT TROPHY #13
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
    --If dead, gold go bye bye
    if m.health <= 120 then
        gPlayerSyncTable[m.playerIndex].gold = false
    end
 ----------------------------------------------------------------------------------------------------------------------------------
    --Backroom Teleport
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
            if m.wall then
                spawn_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, m.pos.x, m.pos.y, m.pos.z, function(o)
                    local z, normal = vec3f(), m.wall.normal
                    local x, xnormal = vec3f(), m.wall.normal
                    o.oFaceAnglePitch = 16384-calculate_pitch(x, xnormal)
                    o.oFaceAngleYaw = calculate_yaw(z, normal)
                    o.oFaceAngleRoll = obj_resolve_collisions_and_turn(o.oFaceAngleYaw, 0)
                    o.oPosX = o.oPosX - (48 * sins(o.oFaceAngleYaw))
                    o.oPosZ = o.oPosZ - (48 * coss(o.oFaceAngleYaw))
                end)
            else
                bloodmist(m.marioObj)
            end
            for i = 0, 50 do
                if not ia(m) then break end
                local random = math.random()
                spawn_sync_object(id_bhvGib, E_MODEL_GIB, m.pos.x, m.pos.y, m.pos.z, function (gib)
                    obj_scale(gib, random)
                end)
            end
        end
    end

    -- BONK DEATH DETECTION FOR HEAVEHO THROWS SPECIFICALLY (Really just for WDW)
    if (m.action == ACT_THROWN_BACKWARD) or (m.action == ACT_THROWN_FORWARD) and (s.flyingVel > 60) and np.currLevelNum == LEVEL_WDW then
        local heaveho = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvHeaveHoThrowMario)
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
            network_play(sSplatter, m.pos, 1, m.playerIndex)
            s.splatterdeath = 1
            s.splatter = 0
        end
        if s.jumpland == 0 and m.squishTimer >= 1 then --Checks if Mario was squished from NON-FALL damage. Objects/enemies that squish Mario will smoosh his corpse to invisible. 
            network_play(sSplatter, m.pos, 1, m.playerIndex)
            s.splatterdeath = 1
            s.splatter = 0
            s.disappear = 1 -- No corpse mode.  +
        end
    end
    if (s.splatterdeath) == 1 then
        m.particleFlags = PARTICLE_MIST_CIRCLE
        squishblood(m.marioObj)
        s.splatterdeath = 0
        s.enablesplattimer = 1
    end
  ----------------------------------------------------------------------------------------------------------------------------------
    --Mario Disintegrates when on fire
    local flame = m.marioObj.prevObj
    if flame and obj_has_behavior_id(flame, id_bhvFireParticleSpawner) ~= 0 then
        --* for the love of god please use for loops holc!!!!!!.......
        cur_obj_shake_screen(SHAKE_POS_SMALL)
        flame.oInteractType = INTERACT_FLAME
        flame.hookRender = 1 -- see resize_flame
        m.marioObj.oMarioBurnTimer = 1

        if (m.health <= 300) then
            m.squishTimer = 50
            audio_sample_stop(gSamples[sAgonyMario])
            audio_sample_stop(gSamples[sAgonyLuigi])
            audio_sample_stop(gSamples[sAgonyWario])
            audio_sample_stop(gSamples[sAgonyToad]) --Stops Mario's super long scream
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
            audio_sample_stop(gSamples[sAgonyToad]) --Stops Mario's super long scream
            audio_sample_stop(gSamples[sAgonyLuigi])
            audio_sample_stop(gSamples[sAgonyWario])
            audio_sample_stop(gSamples[sAgonyWaluigi])
            flame = nil
        end
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
 ---------------------------------------------------------------------------------------------------------------------------------
    --Hell entrance cutscene
    if np.currLevelNum == LEVEL_HELL then
        if not ia(m) then return end
        
        if m.marioObj.oTimer <= 2 then --FIXES THE CAMERA if the player has visited the secret room first. 
            local c = m.area.camera
            local pos = {
                x = 69,
                y = 848,
                z = -12900
            }
            vec3f_copy(c.pos, pos)
            vec3f_copy(gLakituState.pos, pos)
            vec3f_copy(gLakituState.goalPos, pos)
        end

        if m.marioObj.oTimer <= 60 then
            --gLakituState.mode = CAMERA_MODE_BEHIND_MARIO
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
    --Racing penguin is stupid fast now. Only beatable by falling to the bottom of slide. Will insult mario to death if race lost, will crash into wall and splat if race won.
    racepen = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvRacingPenguin)
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
        if racepen.oForwardVel >= 50 and obj_get_nearest_object_with_behavior_id(racepen, id_bhvRacerHitbox) == nil then
            spawn_non_sync_object(id_bhvRacerHitbox, E_MODEL_NONE, racepen.oPosX, racepen.oPosY, racepen.oPosZ, nil)
        end
    end
  ----------------------------------------------------------------------------------------------------------------------------------
    --Goomba stomping sound effect.
    if m.bounceSquishTimer > 0 and not s.stomped then
        local_play(sGoombaStomp, m.pos, 1)
        s.stomped = true
    elseif m.bounceSquishTimer == 0 then s.stomped = false end
 ----------------------------------------------------------------------------------------------------------------------------------
    --Enables King Bobombs RIDICULOUS cannon-arm mario launch and Chuckyas..
    if m.prevAction == ACT_GRABBED and m.action == ACT_THROWN_FORWARD then
        local o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvKingBobomb)
        if o == nil then
            o = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvChuckya)
        end
        if o ~= nil then
            m.vel.x = m.vel.x + sins(o.oMoveAngleYaw) * 85
            m.vel.z = m.vel.z + coss(o.oMoveAngleYaw) * 85
            m.vel.y = 65
            set_mario_action(m, ACT_RAGDOLL, 0)
        end
    end
 ----------------------------------------------------------------------------------------------------------------------------------
    --When getting the 100 coin star, a bobomb nuke spawns on Mario.
    if (m.numCoins) == 100 then
        m.numCoins = m.numCoins + 1
        spawn_sync_if_main(id_bhvBobomb, E_MODEL_BOBOMB_BUDDY, m.pos.x, m.pos.y, m.pos.z, nil, m.playerIndex)
    end
 ----------------------------------------------------------------------------------------------------------------------------------
    --Switches snow landing to snow drowning
    if (m.action == ACT_HEAD_STUCK_IN_GROUND) or (m.action == ACT_BUTT_STUCK_IN_GROUND) or (m.action == ACT_FEET_STUCK_IN_GROUND) then
        if m.floor.type == 19 or m.floor.type == 117 or m.floor.type == 20 then
            m.particleFlags = PARTICLE_MIST_CIRCLE | PARTICLE_19 | PARTICLE_WATER_SPLASH | PARTICLE_SNOW | PARTICLE_DIRT | PARTICLE_HORIZONTAL_STAR | PARTICLE_TRIANGLE
            set_mario_action(m, ACT_GONE, 60)
            m.health = 0xff
        end
     end
 ----------------------------------------------------------------------------------------------------------------------------------
    -- Murder Ukiki
    if np.currLevelNum == LEVEL_BOWSER_1 then
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
            if m.character.type == CT_MARIO then
                network_play(sAngryMario, m.pos, 1, m.playerIndex)
            elseif m.character.type == CT_LUIGI then
                network_play(sAngryLuigi, m.pos, 1, m.playerIndex)
            elseif m.character.type == CT_TOAD then
                network_play(sAngryToad, m.pos, 1, m.playerIndex)
            elseif m.character.type == CT_WARIO then
                network_play(sAngryWario, m.pos, 1, m.playerIndex)
            elseif m.character.type == CT_WALUIGI then
                network_play(sAngryWaluigi, m.pos, 1, m.playerIndex)
            end
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
    elseif np.currLevelNum == LEVEL_TTC and not gGlobalSyncTable.romhackcompatibility then
        if m.playerIndex == 0 then
            local notMoving = (m.action == ACT_IDLE or m.action == ACT_WATER_IDLE or m.action == ACT_CRAWLING or m.action == ACT_HOLDING_POLE or m.action == ACT_TOP_OF_POLE) or (m.vel.x == 0 and m.vel.y == 0 and m.vel.z == 0 and m.forwardVel == 0)
            if notMoving then
                enable_time_stop()
                sequence_player_set_tempo(SEQ_PLAYER_LEVEL, 0)
                set_ttc_speed_setting(TTC_SPEED_STOPPED)
            elseif sequence_player_get_tempo(SEQ_PLAYER_LEVEL) ~= originalTempo then
                sequence_player_set_tempo(SEQ_PLAYER_LEVEL, originalTempo)
                disable_time_stop()
                set_ttc_speed_setting(TTC_SPEED_FAST)
            end
            execute_mario_action(m.marioObj)
        end
    end
 ----------------------------------------------------------------------------------------------------------------------------------
    --Mario has his hat after every respawn. Makes for funny deaths when his hat flies off.
    save_file_clear_flags(SAVE_FLAG_CAP_ON_GROUND | SAVE_FLAG_CAP_ON_KLEPTO | SAVE_FLAG_CAP_ON_UKIKI | SAVE_FLAG_CAP_ON_MR_BLIZZARD)
    m.cap = m.cap & ~(SAVE_FLAG_CAP_ON_GROUND | SAVE_FLAG_CAP_ON_KLEPTO | SAVE_FLAG_CAP_ON_UKIKI | SAVE_FLAG_CAP_ON_MR_BLIZZARD)
 ----------------------------------------------------------------------------------------------------------------------------------
    --Effectively disables water healing, burning the player even when surfacing.
    if np.currLevelNum == LEVEL_JRB or np.currLevelNum == LEVEL_HMC or np.currLevelNum == LEVEL_COTMC and not gGlobalSyncTable.romhackcompatibility and not (network_player_connected_count() <= 1 and is_game_paused()) then
        if m.playerIndex ~= 0 then
            return
        end
        if (m.health >= 0x100) then
            --djui_chat_message_create("F")
            if ((m.healCounter or m.hurtCounter) == 0) then
                --djui_chat_message_create("FI")
                if ((m.action & ACT_FLAG_SWIMMING ~= 0) and (m.action & ACT_FLAG_INTANGIBLE == 0)) then
                    --djui_chat_message_create("FIR")
                    if ((m.pos.y >= (m.waterLevel - 140))) then
                        m.health = m.health - 26
                        --djui_chat_message_create("FIRE")
                    end
                end
            end
        end
    end

 ----------------------------------------------------------------------------------------------------------------------------------
    --Replaces the twirling action the player is in while in a tweester, instead flinging the player around.
    local spinX = 1
    if m.action == ACT_TORNADO_TWIRLING then 
        vec3s_set(m.angleVel, 3500, 2000, 700)
        vec3s_add(m.faceAngle, m.angleVel)
        vec3s_copy(m.marioObj.header.gfx.angle, m.faceAngle)    
        set_character_animation(m, CHAR_ANIM_AIRBORNE_ON_STOMACH)
    elseif m.prevAction == ACT_TORNADO_TWIRLING then
        m.vel.x = math.random(-120, 120)
        m.vel.z = math.random(-100, 100)
        m.vel.y = math.random(60, 100)
        set_mario_action(m, ACT_RAGDOLL, 0)
    end
    if m.marioObj.oMarioTornadoYawVel >= 4096 and m.marioObj.oMarioTornadoYawVel < 24576 then
        m.marioObj.oMarioTornadoYawVel = m.marioObj.oMarioTornadoYawVel + 256
    end
    --djui_chat_message_create(tostring(m.marioObj.oMarioTornadoYawVel))
end

function hook_update()
    local m = gMarioStates[0]
    local s = gStateExtras[0]
    local np = gNetworkPlayers[0]

    -- Prevents flying via triple jumps. (still possible with cannons and flying on spawn)
    if m.prevAction == ACT_FLYING_TRIPLE_JUMP and m.action == ACT_FLYING and not gGlobalSyncTable.romhackcompatibility then
        m.flags = MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD
        set_mario_action(m, ACT_FREEFALL, 0)
        mario_blow_off_cap(m, 75)
        stop_cap_music()
        if not s.flyFailure then
            djui_chat_message_create("As your cap flies away, you think of other ways to take to the skies...") -- in case people are dumb and think there's no other ways to fly
            s.flyFailure = true
        end
    end
    
    -- Prevents slow fall with WC by removing the player's cap when attempted.
    if (m.flags & (MARIO_WING_CAP) ~= 0) and (m.controller.buttonDown & A_BUTTON ~= 0) and m.vel.y <= -35 and m.action ~= ACT_GROUND_POUND and m.action ~= ACT_GROUND_POUND_LAND and m.action ~= ACT_BUTT_SLIDE_STOP and m.action ~= ACT_LONG_JUMP and m.action ~= ACT_LONG_JUMP_LAND and 
    m.action ~= ACT_LONG_JUMP_LAND and m.action ~= ACT_FLYING and m.action ~= ACT_FALL_AFTER_STAR_GRAB and m.action ~= ACT_STAR_DANCE and m.action ~= ACT_STAR_DANCE_NO_EXIT and m.action ~= ACT_LEDGE_GRAB and not gGlobalSyncTable.romhackcompatibility then
        m.flags = MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD
        mario_blow_off_cap(m, 5)
        stop_cap_music()
    elseif (m.flags & (MARIO_WING_CAP) ~= 0) and (m.controller.buttonDown & A_BUTTON ~= 0) and m.action == ACT_GROUND_POUND and m.vel.y == -38 and m.action ~= ACT_GROUND_POUND_LAND and m.action ~= ACT_BUTT_SLIDE_STOP and m.action ~= ACT_LONG_JUMP and m.action ~= ACT_LONG_JUMP_LAND and 
    m.action ~= ACT_LONG_JUMP_LAND and m.action ~= ACT_FLYING and m.action ~= ACT_FALL_AFTER_STAR_GRAB and m.action ~= ACT_STAR_DANCE and m.action ~= ACT_STAR_DANCE_NO_EXIT and m.action ~= ACT_LEDGE_GRAB and not gGlobalSyncTable.romhackcompatibility then
        m.flags = MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD
        mario_blow_off_cap(m, 5)
        stop_cap_music()
    end

    -- WC buff (and TotWC buff because faster flying made it too easy somehow)
    if m.action == ACT_FLYING or m.action == ACT_SHOT_FROM_CANNON or m.action == ACT_THROWN_BACKWARD or m.action == ACT_THROWN_FORWARD then -- Makes flying gradually get FASTER!
        if np.currLevelNum == LEVEL_TOTWC and not gGlobalSyncTable.romhackcompatibility then
            m.forwardVel = math.max(80, m.forwardVel)  
            m.forwardVel = math.min(110, m.forwardVel)
            s.flyingVel = m.forwardVel --This is to store Mario's last flying speed to check for splat-ability. 
        elseif np.currLevelNum ~= LEVEL_TOTWC and not gGlobalSyncTable.romhackcompatibility then
            m.forwardVel = math.max(85, m.forwardVel)
            s.flyingVel = m.forwardVel -- x2
        end
    end

--[[     -- Oscillates coins in TOTWC (the real totwc "buff") (removed because i dont like it)          
    local x = obj_get_first_with_behavior_id(id_bhvYellowCoin)
    local y = obj_get_first_with_behavior_id(id_bhvRedCoin)
    local z = obj_get_first_with_behavior_id(id_bhvCoinFormationSpawn)
    if np.currLevelNum == LEVEL_TOTWC and not gGlobalSyncTable.romhackcompatibility then
        local amplitude = 13
        local speed = 0.01
        while x do
            x.oPosY = x.oPosY + math.sin(get_global_timer() * speed) * amplitude
            x = obj_get_next_with_same_behavior_id(x)
        end
        while y do
            y.oPosY = y.oPosY + math.sin(get_global_timer() * speed) * amplitude
            y = obj_get_next_with_same_behavior_id(y)
        end
        while z do
            z.oPosY = z.oPosY + math.sin(get_global_timer() * speed) * amplitude
            z = obj_get_next_with_same_behavior_id(z)
        end
    end ]]

 -------------------------------------------------------------------------------------------------------------------------------------------------------------    
    -- Alters the Metal Cap timer outside of JRH to be "fair".
    if m.flags & MARIO_METAL_CAP ~= 0 and m.action & ACT_FLAG_METAL_WATER == 0 and m.action ~= ACT_STAR_DANCE_EXIT and m.action ~= ACT_WATER_PLUNGE and not gGlobalSyncTable.romhackcompatibility and not (network_player_connected_count() <= 1 and is_game_paused()) then 
        local cap_timer = m.capTimer - 1  --thank you sunk for being romhack mods pro
        if cap_timer > 1 then
            m.capTimer = cap_timer 
        end 
        if mario_is_within_rectangle(1700, 6300, -6400, 800) ~= 0 and np.currLevelNum == LEVEL_HMC then
            local cap_timer = m.capTimer - 10
            if cap_timer > 1 then
                m.capTimer = cap_timer
            end
        end
    end

    if (m.flags & (MARIO_VANISH_CAP) ~= 0) then
        -- lower mass
    end
 -------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- (PSS/TTM Only) Faster sliding.
     if not gGlobalSyncTable.romhackcompatibility then
        local is_pss = np.currLevelNum == LEVEL_PSS
        local is_ttm = np.currLevelNum == LEVEL_TTM and np.currAreaIndex >= 2
        local is_butt_or_dive_slide = m.action == ACT_BUTT_SLIDE or m.action == ACT_DIVE_SLIDE
        
        if is_pss and is_butt_or_dive_slide then
            adjust_slide_velocity(m, 50)
        elseif is_ttm and is_butt_or_dive_slide then
            adjust_slide_velocity(m, 40)
        end
        
        if np.currLevelNum == LEVEL_PSS and m.pos.y < -4480 then 
            m.forwardVel = math.min(m.forwardVel, 60)
        end
    
        local m = gMarioStates[0]
        local is_slide_fall = m.action == ACT_FREEFALL or m.action == ACT_BUTT_SLIDE_AIR
        if np.currLevelNum == LEVEL_PSS and is_slide_fall then
            if m.forwardVel > 160 then
                m.forwardVel = 30
            end
        end
        
        if (is_pss or is_ttm) and m.action == ACT_BUTT_SLIDE then
            adjust_turn_speed(m)
        end
    end

    if puking then -- Puking
    
        --Mario Sick Counter
        if s.sick < 100 and m.forwardVel > 0 and m.faceAngle.y ~= m.intendedYaw and m.action ~= ACT_PUKE and m.action ~= ACT_LONG_JUMP
        and m.action ~= ACT_JUMP and m.action ~= ACT_DOUBLE_JUMP and m.action ~= ACT_READING_NPC_DIALOG and m.action ~= ACT_WAITING_FOR_DIALOG
        and m.action ~= ACT_READING_AUTOMATIC_DIALOG and m.action ~= ACT_EXIT_LAND_SAVE_DIALOG and m.action ~= ACT_FLYING then
            s.sick = s.sick + 0.5
        elseif s.sick > 0 and s.sick < 100 and not m.marioObj.platform then
            s.sick = s.sick - 0.5
        end

        --Mario is getting sick and the camera is dizzy.
        if s.sick > 55 then
            set_handheld_shake(HAND_CAM_SHAKE_HIGH)
        elseif s.sick <= 55 and s.sick > 30 then
            set_handheld_shake(HAND_CAM_SHAKE_LOW)
        end

        --If mario is stationary on a spinning platform, get sick.
        if m.marioObj.platform and s.sick < 100 and puking then
            if m.marioObj.platform.oAngleVelYaw > 1000 then
                s.sick = s.sick + 0.5
            end
        end

        --Mario is now sick and is going to puke! :X
        if s.sick >= 100 then
            if m.forwardVel > 4 then
                --djui_chat_message_create(tostring(m.forwardVel))
                m.forwardVel = m.forwardVel - 1
            end
            if m.forwardVel <= 7 and m.pos.y == m.floorHeight then
                set_mario_action(m, ACT_PUKE, 0)
            end
        end
    end
----------------------------------------------------------------------------------------------------------------------------------
    -- (Cool Cool Mountain) Baby penguin gets thrown after 8 seconds of mario losing his patience.
    if np.currLevelNum == LEVEL_CCM then
        if m.heldObj and obj_has_behavior_id(m.heldObj, id_bhvSmallPenguin) ~= 0 then
            s.penguinholding = 1
        end
        if (s.penguinholding) == 1 then
            if m.heldObj and obj_has_behavior_id(m.heldObj, id_bhvSmallPenguin) ~= 0 and ia(m) then
                s.penguintimer = s.penguintimer + 1
            end
        end
        if (s.penguintimer) == 230 then
            if m.character.type == CT_MARIO then
                network_play(sAngryMario, m.pos, 1, m.playerIndex)
            elseif m.character.type == CT_LUIGI then
                network_play(sAngryLuigi, m.pos, 1, m.playerIndex)
            elseif m.character.type == CT_TOAD then
                network_play(sAngryToad, m.pos, 1, m.playerIndex)
            elseif m.character.type == CT_WARIO then
                network_play(sAngryWario, m.pos, 1, m.playerIndex)
            elseif m.character.type == CT_WALUIGI then
                network_play(sAngryWaluigi, m.pos, 1, m.playerIndex)
            end
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
    else
        s.penguinholding = 0
        s.penguintimer = 0
    end
----------------------------------------------------------------------------------------------------------------------------------
    -- Jolly Roger Hell rework (Metal Cap required)
    if np.currLevelNum == LEVEL_JRB or np.currLevelNum == LEVEL_HMC or np.currLevelNum == LEVEL_COTMC and not gGlobalSyncTable.romhackcompatibility then
        texture_override_set("texture_waterbox_jrb_water", TEX_JRHLAVA)
        texture_override_set("texture_waterbox_water", TEX_JRHLAVA)
        --djui_chat_message_create("BURNNNNNN")
        
        local spawned = false
        local fire = obj_get_first_with_behavior_id(id_bhvFakeFire)
        local inlava = m.pos.y <= m.waterLevel
        if np.currLevelNum ~= LEVEL_COTMC and m.action == ACT_FLAG_SWIMMING & ACT_WATER_PLUNGE or (inlava and m.flags & MARIO_METAL_CAP == 0) and not (network_player_connected_count() <= 1 and is_game_paused()) then
            if np.currAreaIndex == 1 then
                m.health = m.health - 16
            elseif np.currAreaIndex == 2 then
                m.health = m.health - 6
            end   
            while fire ~= nil do
                spawn_non_sync_object(id_bhvFakeFire, E_MODEL_RED_FLAME, m.pos.x, m.pos.y, m.pos.z, nil)  -- this is doing nothing
                spawned = true
                break
                fire = obj_get_next_with_behavior_id(fire)
            end
        elseif np.currLevelNum == LEVEL_COTMC and m.flags & MARIO_METAL_CAP == 0 and not (network_player_connected_count() <= 1 and is_game_paused()) then
            m.health = m.health - 16
        end
    else
        texture_override_reset("texture_waterbox_jrb_water")
        texture_override_reset("texture_waterbox_water")
    end
----------------------------------------------------------------------------------------------------------------------------------
    --(Hazy Maze Cave) Mario get high when walking in gas.
    if np.currLevelNum == LEVEL_HMC and not gGlobalSyncTable.romhackcompatibility and not (network_player_connected_count() <= 1 and is_game_paused()) then
        s.outsidegastimer = s.outsidegastimer + 1 -- This is constantly counting up. As long as Mario is in gas, this number will keep getting set back to zero. If Mario isnt in gas, the timer will count up to 60 and trigger some "not in gas" commands. 

        if ia(m) and (m.input & INPUT_IN_POISON_GAS ~= 0) and m.flags & MARIO_METAL_CAP == 0 and not s.isdead then --This should be used as a check against if Mario is inside of gas. If so, IsHigh will be set to 1.
            s.ishigh = true
            s.outsidegastimer = 0
            m.health = m.health + 4
        end

        if s.ishigh then
            set_environment_region(2, -400) --RAISES THE GAS HIGHER
        end

        if ((s.outsidegastimer == 30) or s.isdead) and s.ishigh then --If Mario is outside the gas for 1 second, the high wears off and resets all timers.
            s.ishigh = false
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
        if s.ishigh then --Mario is in gas, thefore the death timer starts counting and M velocity is lowered.
            if ia(m) then
                s.highdeathtimer = s.highdeathtimer + 1
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
                    spawn_non_sync_object(id_bhvMrIBlueCoin, E_MODEL_SMILER, m.pos.x, m.pos.y, m.pos.z, function (coin) coin.oGraphYOffset = 50 end)
                elseif randommodel == 2 then
                    spawn_non_sync_object(id_bhvMrIBlueCoin, E_MODEL_SMILER2, m.pos.x, m.pos.y, m.pos.z, function (coin) coin.oGraphYOffset = 50 end)
                elseif randommodel == 3 then
                    spawn_non_sync_object(id_bhvMrIBlueCoin, E_MODEL_SMILER3, m.pos.x, m.pos.y, m.pos.z, function (coin) coin.oGraphYOffset = 50 end)
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
            s.ishigh = false
            s.outsidegastimer = 30
            s.highdeathtimer = 0
            s.isdead = true
        end
    end
    
    -- Removes any instances of gas effects after leaving HMC.
    if np.currLevelNum ~= LEVEL_HMC and s.highdeathtimer > 0 and s.ishigh and not gGlobalSyncTable.romhackcompatibility then
        s.ishigh = false
        s.highdeathtimer = 0
        set_override_fov(0)
    end
 ----------------------------------------------------------------------------------------------------------------------------------  
    if np.currLevelNum == LEVEL_LLL and not gGlobalSyncTable.romhackcompatibility then
        local o = obj_get_nearest_with_behavior_id(id_bhvRedCoin)
        if o.oPosY <= 250 and o.oBehParams2ndByte ~= 10 then
            obj_mark_for_deletion(o)
        end
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
    local np = gNetworkPlayers[0]
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
        set_mario_action(m, ACT_NECKSNAP, 0)
    end

    --Custom bobomb buddy explosions
    if obj_has_behavior_id(o, id_bhvBobombBuddy) ~= 0 and np.currLevelNum ~= LEVEL_TTM then
        spawn_sync_object(id_bhvExplosion, E_MODEL_EXPLOSION, o.oPosX, o.oPosY, o.oPosZ, nil)
        obj_mark_for_deletion(o)
    end

    --Snowman's head insta-kill
    if obj_has_behavior_id(o, id_bhvSnowmansBottom) ~= 0 then
        m.squishTimer = 50
    end

    --Skeeter insta-kill
    if obj_has_behavior_id(o, id_bhvSkeeter) ~= 0 then
        if (m.hurtCounter > 0) then
            m.squishtimer = 50
        elseif o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then -- Thx xLuigiGamerx
            squishblood(o)
            local_play(sSplatter, m.pos, 1)
        end
    end

    --Scuttlebug insta-kill and gore
    if obj_has_behavior_id(o, id_bhvScuttlebug) ~= 0 then
        if (m.hurtCounter > 0) then
            m.squishTimer = 50
        elseif o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then -- Thx xLuigiGamerx
            squishblood(o)
            local_play(sSplatter, m.pos, 1)
        end
    end


    --JRB falling pillar insta-kill
    if obj_has_behavior_id(o, id_bhvFallingPillarHitbox) ~= 0 and (m.hurtCounter > 0) then
        m.squishTimer = 50
    end

    --Swoop insta-kill
    if obj_has_behavior_id(o, id_bhvSwoop) ~= 0 then 
        if (m.hurtCounter > 0) then
            m.squishtimer = 50
        elseif o.oInteractStatus & INT_STATUS_WAS_ATTACKED ~= 0 then -- Thx xLuigiGamerx
            squishblood(o)
            local_play(sSplatter, m.pos, 1)
        end
    end

    --Others
    if (obj_has_behavior_id(o, id_bhvRacerHitbox) ~= 0
    or obj_has_behavior_id(o, id_bhvMrI) ~= 0)
    and (m.hurtCounter > 0) then
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
        o.oAction = 0
        o.oMoveAnglePitch = 0
        obj_compute_vel_from_move_pitch(0)
    end

    if (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvPiranhaPlant) ~= 0 and not s.headless then
        s.headless = true
        network_play(sSplatter, m.pos, 1, m.playerIndex)
        network_play(sCrunch, m.pos, 1, m.playerIndex)
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
        if o.oAction == GOOMBA_ACT_JUMP and m.action & ACT_FLAG_AIR == 0 then
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

    if (m.hurtCounter > 0) and obj_has_behavior_id(o, id_bhvMrIParticle) ~= 0 and not s.headless then
        if m.action & ACT_FLAG_AIR == 0 then
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

    if (m.hurtCounter > 0) and (obj_has_behavior_id(o, id_bhvGhostHuntBoo) ~= 0 or obj_has_behavior_id(o, id_bhvBoo) ~= 0
    or obj_has_behavior_id(o, id_bhvMerryGoRoundBoo) ~= 0 or obj_has_behavior_id(o, id_bhvGhostHuntBigBoo) ~= 0 or obj_has_behavior_id(o, id_bhvBalconyBigBoo) ~= 0
    or obj_has_behavior_id(o, id_bhvMerryGoRoundBigBoo) ~= 0 or obj_has_behavior_id(o, id_bhvBooWithCage) ~= 0) and (not s.headless) then
        set_mario_action(m, ACT_BURNING_JUMP, 0)
        spawn_mist_particles()
        set_camera_shake_from_hit(SHAKE_SMALL_DAMAGE)
        obj_set_model_extended(m.marioObj.prevObj, E_MODEL_BLUE_FLAME) -- Only works for id_bhvBooWithCage
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
        spawn_non_sync_object(id_bhvSmallBully, E_MODEL_NONE, m.pos.x, m.pos.y, m.pos.z, function(bully) 
            cur_obj_disable_rendering()
            bully.oBehParams = 20
         end)
        set_mario_action(m, ACT_GONE, 1)
        network_play(sSplash, m.pos, 1, m.playerIndex)
        spawn_non_sync_object(id_bhvBowserBombExplosion, E_MODEL_BOWSER_FLAMES, m.pos.x, m.pos.y, m.pos.z, nil)
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

        if m.marioObj.oMarioBurnTimer == 0 then
            local charSoundTable = {
                sAgonyMario,
                sAgonyLuigi,
                sAgonyToad,
                sAgonyWaluigi,
                sAgonyWario
            }
            network_play(charSoundTable[m.character.type+1], m.pos, 1, m.playerIndex)
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
        gPlayerSyncTable[m.playerIndex].gold = false
        squishblood(m.marioObj)
    elseif m.action == ACT_SHOCKED then -- play shock sounds
        local s = gStateExtras[m.playerIndex]
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
    audio_sample_stop(gSamples[sAgonyToad]) --Stops Toad's super long scream
    audio_sample_stop(gSamples[sAgonyWario]) --Stops Wario's super long scream
    audio_sample_stop(gSamples[sAgonyWaluigi]) --Stops Waluigi's super long scream
    s.timeattack = false
    stream_fade(50) --Stops the Hazy Maze Cave custom music after death. Stops the ukiki minigame music if Mario falls to death. 
    if not s.isdead and not s.disableuntilnextwarp then
        gGlobalSyncTable.deathcounter = gGlobalSyncTable.deathcounter + 1
        s.personaldeathcount = s.personaldeathcount + 1
        s.isdead = true
    end
    serverguitimer = 300
end

function marioalive() -- Resumes the death counter to accept death counts. 
    local s = gStateExtras[0]
    local np = gNetworkPlayers[0]
    local m = gMarioStates[0]
    audio_sample_stop(gSamples[sAgonyMario]) --Stops Mario's super long scream
    audio_sample_stop(gSamples[sAgonyToad]) --Stops Toad's super long scream
    audio_sample_stop(gSamples[sAgonyLuigi]) --Stops Luigi's super long scream
    audio_sample_stop(gSamples[sAgonyWario]) --Stops Wario's super long scream
    audio_sample_stop(gSamples[sAgonyWaluigi]) --Stops Waluigi's super long scream

    hud_show()
    if np.currLevelNum ~= LEVEL_TTM then
        s.hasNightvision = false
    end
    s.death = false
    s.isdead = false --Mario is alive
    s.disableuntilnextwarp = false --Enables death counter
    s.headless = false --Gives Mario his head back
    s.bottomless = false --Gives Mario his whole upper body back

    if np.currLevelNum == LEVEL_TTM and np.currAreaIndex < 2 then
        bhv_metal_cap_init()
        --m.pos.y = m.pos.y + 920
    end

    if m.numLives <= 0 and not s.isinhell and not s.iwbtg and gGlobalSyncTable.hellenabled then
        s.isinhell = true
        warp_to_level(LEVEL_HELL, 1, 0)
    else 
        --s.iwbtg = false
    end
    --Resets the baby penguin timer on warp so it doesn't glitch out if mario leaves the level without fully killing the baby penguin.
    s.penguinholding = 0
    s.penguintimer = 0
end

function toaddeath(o)
    local m = gMarioStates[0]
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

    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_color(255, 255, 255, 255)
    screenW = djui_hud_get_screen_width()
    screenH = djui_hud_get_screen_height()
    local width  = screenW/512
    local height = screenH/512

    if s.hasNightvision then
        local nightvisionnoise = {
            TEX_NIGHTVISION,
            TEX_NIGHTVISION2,
            TEX_NIGHTVISION3,
            TEX_NIGHTVISION4,
            TEX_NIGHTVISION5
        }
        local nightvision = nightvisionnoise[math.random(#nightvisionnoise)]

        djui_hud_render_texture(nightvision, 0, 0, width, height)

        set_lighting_color(0, 20)
        set_lighting_color(1, 255)
        set_lighting_color(2, 20)
    end

    if s.iwbtg and s.death or gGlobalSyncTable.iwbtgGameoverEveryone then
        if not s.death then
            s.death = true
            set_mario_action(m, ACT_NOTHING, 0)
            stream_stop_all()
            local_play(sIwbtgDeath, gLakituState.pos, 1)
        end
        delete_save(m)
        gGlobalSyncTable.toaddeathcounter = 0
        for course = 0, COURSE_MAX -1 do
            save_file_remove_star_flags(get_current_save_file_num() - 1, course - 1, 0xFF)
        end
        save_file_clear_flags(0xFFFFFFFF)
        save_file_do_save(get_current_save_file_num() - 1, 1)
        enable_time_stop()
        --enable_time_stop_including_mario()
        djui_hud_render_texture(TEX_GAMEOVER, (screenW/2) - 256, (screenH/2) - 128, 1, 1)
        hud_hide()
        hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_POWER)
        if (m.controller.buttonPressed & A_BUTTON) ~= 0 and m.marioObj.oTimer > 60 then
            gGlobalSyncTable.iwbtgGameoverEveryone = false
        end
    end

    if not gGlobalSyncTable.iwbtgGameoverEveryone and s.death and s.iwbtg then
        hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) | HUD_DISPLAY_FLAG_POWER)
        delete_save(m)
        m.health = 0x880
        s.iwbtg = false
        s.death = false
        if gGlobalSyncTable.romhackcompatibility then
            warp_to_start_level()
        else
            warp_to_level(LEVEL_CASTLE_GROUNDS, 1, 0)
        end
        m.numLives = 10
        m.numStars = 0
        s.iwbtg = true
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
            djui_hud_print_text(timerString, screenW / 2 - djui_hud_measure_text(timerString), screenH - 48, 1)
        else
            s.timeattack = false
        end
    end

    --TOAD DEATH COUNTER. Each time you kill toad, the count goes up. It compares the number with the PreviousToadDeath variable, which tells it to update and triggers commands.
    --Toad gives 3 stars. I have set this to give these stars after every 100 toad kills.
    if serverguitimer > 0 then
        serverguitimer = serverguitimer - 1
        djui_hud_set_color(255, 255, 255, lerp(0, 255, (math.max(0, serverguitimer))/300))

        local deathcount = "Total server death count: "..gGlobalSyncTable.deathcounter
        djui_hud_print_text(deathcount, screenW - 30 - djui_hud_measure_text(deathcount), screenH - 78, 1)
    end
    --djui_chat_message_create(tostring(serverguitimer))

    if toadguitimer > 0 then
        toadguitimer = toadguitimer - 1
        djui_hud_set_color(255, 255, 0, lerp(0, 255, (math.max(0, toadguitimer))/150))

        local toaddeathcount = "Server Toad death count: "..gGlobalSyncTable.toaddeathcounter
        djui_hud_print_text(toaddeathcount, screenW - 30 - djui_hud_measure_text(toaddeathcount), screenH - 48, 1)
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------

    --MARIO HIGH IN GAS OVERLAY
    djui_hud_set_color(255, 255, 255, highalpha)
    djui_hud_render_texture(TEX_MARIO_LESS_HIGH, 0, 0, width, height)

    if s.highdeathtimer > 0 then --Mario is high, therefore a hazy green gas overlay comes up on the screen.
        highalpha = highalpha + 1
    end
    if not s.ishigh or s.highdeathtimer >= 940 then --Mario is not high, therefore this will remove the gas effect on the hud.
        highalpha = highalpha - 2
    end
    highalpha = clamp(highalpha, 0, 255)

    --MARIO BLOODY GAS OVERLAY
    djui_hud_set_color(255, 255, 255, bloodalpha)
    djui_hud_render_texture(TEX_BLOOD_OVERLAY, 0, 0, width, height)

    if s.highdeathtimer >= 1000 then --Mario is very high and dying, therefore bloody gas overlay comes up on the screen.
        bloodalpha = bloodalpha + 1
    end
    if not s.ishigh then --Mario is not high, therefore this will remove the gas effect on the hud.
        bloodalpha = bloodalpha - 4
    end
    bloodalpha = clamp(bloodalpha, 0, 255)

    --MARIO TRIPPY OVERLAY
    djui_hud_set_color(255, 255, 255, hallucinate)
    djui_hud_render_texture(TEX_TRIPPY_OVERLAY, 0, 0, width, height)

    if s.highdeathtimer >= 360 then --Mario is hallucinating.
        hallucinate = hallucinate + 1
    end
    if not s.ishigh or s.highdeathtimer >= 1090 then --Mario is not high or too high, therefore this will remove the gas effect on the hud.
        hallucinate = hallucinate - 3
    end
    hallucinate = clamp(hallucinate, 0, 111)

    --PORTAL OVERLAY
    if m.marioObj and loadingscreen < 1 then
        djui_hud_set_color(255, 255, 255, portalalpha)
        djui_hud_render_texture_tile(TEX_PORTAL, 0, 0, width*32, height*32, 0, (m.marioObj.oTimer % 32) * 16, 16, 16)

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
        local scale = 10
        loadingscreen = loadingscreen - 1
        sound_banks_disable(0, SOUND_BANKS_ALL)
        sound_banks_disable(1, SOUND_BANKS_ALL)
        sound_banks_disable(2, SOUND_BANKS_ALL)
        djui_hud_set_color(255, 255, 255, 255)

        for i=0, width*512 / (32*scale) do
            for j=0, height*512 / (32*scale) do
                djui_hud_render_texture(TEX_DIRT, i*32*scale, j*32*scale, scale, scale)
            end
        end
        if loadingscreen == 2 then
            s.isinhell = false
            warp_to_start_level()
            m.numLives = 10
        elseif loadingscreen == 0 then
            sound_banks_enable(0, SOUND_BANKS_ALL)
            sound_banks_enable(1, SOUND_BANKS_ALL)
            sound_banks_enable(2, SOUND_BANKS_ALL)

            local_play(sPortalTravel, gLakituState.pos, 1)
            play_sound(SOUND_GENERAL_COLLECT_1UP, gGlobalSoundSource)
        end
    end
------------------------------------------------------------------------------------------------------------------------------------------------------------------
    
    --Adds a death counter to replace the lives counter. (ty sunk)
    djui_hud_set_font(FONT_RECOLOR_HUD)
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_color(255, 255, 255, 255)
    djui_hud_render_texture(gTextures.mario_head, 22, 15, 1, 1)
    djui_hud_set_color(128, 128, 156, 255)
    djui_hud_print_text("x", 40, 15, 0.95)

    local s = gStateExtras[0]
    local x = 53
    local dedcount = s.personaldeathcount
    djui_hud_set_color(205, 0, 0, 255)
    djui_hud_print_text(tostring(s.personaldeathcount), x, 15, 1)
    if s.personaldeathcount ~= nil then
        if s.personaldeathcount >= 100 then
        x = x + 5
        end
    end
    
    local flags = hud_get_value(HUD_DISPLAY_FLAGS)
    if flags & HUD_DISPLAY_FLAG_LIVES ~= 0 then
        hud_set_value(HUD_DISPLAY_FLAGS, flags & ~HUD_DISPLAY_FLAG_LIVES) 
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
    if (m.action & ACT_FLAG_SWIMMING) ~= 0 and m.action ~= ACT_BACKWARD_WATER_KB and m.action ~= ACT_FORWARD_WATER_KB then
        hScale = hScale * 2.0
        if m.action ~= ACT_WATER_PLUNGE then
            vScale = vScale * 2.0
        end
    end

    m.vel.x = m.vel.x * hScale
    m.vel.y = m.vel.y * vScale
    m.vel.z = m.vel.z * hScale

end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
local function before_phys_step(m,stepType) --Called once per player per frame before physics code is run, return an integer to cancel it with your own step result
    local np = gNetworkPlayers[0]

    if not ia(m) then return end

    local mObj = m.marioObj
    local s1up = obj_get_nearest_object_with_behavior_id(mObj, id_bhv1Up)
    local dist = dist_between_objects(mObj, s1up)
    if s1up and np.currLevelNum ~= LEVEL_HELL and dist < 200 then --if local mario is touching 1up then
        spawn_sync_object(id_bhvWhitePuff1, E_MODEL_WHITE_PUFF, s1up.oPosX, s1up.oPosY, s1up.oPosZ, nil)
        obj_mark_for_deletion(s1up)
        local_play(sFart, m.pos, 2)
    end 

    local mObj = m.marioObj
    local w1up = obj_get_nearest_object_with_behavior_id(mObj, id_bhv1upWalking)
    local dist = dist_between_objects(mObj, w1up)
    if w1up and np.currLevelNum ~= LEVEL_HELL and dist < 200 then --x2
        spawn_sync_object(id_bhvWhitePuff1, E_MODEL_WHITE_PUFF, w1up.oPosX, w1up.oPosY, w1up.oPosZ, nil)
        obj_mark_for_deletion(w1up)
        local_play(sFart, m.pos, 2)
    end
    
    local mObj = m.marioObj
    local r1up = obj_get_nearest_object_with_behavior_id(mObj, id_bhv1upRunningAway)
    local dist = dist_between_objects(mObj, r1up)
    if r1up and np.currLevelNum ~= LEVEL_HELL and dist < 200 then --x3
        spawn_sync_object(id_bhvWhitePuff1, E_MODEL_WHITE_PUFF, r1up.oPosX, r1up.oPosY, r1up.oPosZ, nil)
        obj_mark_for_deletion(r1up)
        local_play(sFart, m.pos, 2)
    end

    local mObj = m.marioObj
    local h1up = obj_get_nearest_object_with_behavior_id(mObj, id_bhvHidden1up)
    local dist = dist_between_objects(mObj, h1up)
    if h1up and np.currLevelNum ~= LEVEL_HELL and dist < 200 then --x4
        spawn_sync_object(id_bhvWhitePuff1, E_MODEL_WHITE_PUFF, h1up.oPosX, h1up.oPosY, h1up.oPosZ, nil)
        obj_mark_for_deletion(h1up)
        local_play(sFart, m.pos, 2)
    end
end
---------hooks--------
hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_UPDATE, hook_update)
hook_event(HOOK_ON_LEVEL_INIT, modsupport)
hook_event(HOOK_MARIO_UPDATE, mariohitbyenemy)
hook_event(HOOK_MARIO_UPDATE, splattertimer)
hook_event(HOOK_BEFORE_MARIO_UPDATE, function (m) -- mario high in gas with messed up controls. (NOT WORKING SUDDENLY, no idea why)
    local s = gStateExtras[0]
    if s.ishigh then
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
    else
        --djui_chat_message_create("not high")
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
        if gGlobalSyncTable.pvp == true then
            local m = gMarioStates[0]
            network_play(sSplatter, victim.pos, 1, m.playerIndex)
            s.splatterdeath = 1
            s.splatter = 0
            s.disappear = 1 -- No corpse mode.  
        end
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
        set_mario_action(victim, ACT_GROUND_BONK, 0)
    end

    --Neck snapping
    if attacker.action == ACT_DIVE and victim.action ~= ACT_NECKSNAP then
        --local_play(sBoneBreak, victim.pos, 1)
        if gGlobalSyncTable.pvp == true then
            set_mario_action(victim, ACT_NECKSNAP, 0)
        end
        set_mario_action(attacker, ACT_DIVE_SLIDE, 0)
    end

end)
---------------------------------------

local function default_level_func()
    local np = gNetworkPlayers[0]
    set_lighting_color(0, 255)
    set_lighting_color(1, 255)
    set_lighting_color(2, 255)
    set_lighting_dir(1, 0)
    set_override_skybox(-1)
    set_override_envfx(-1)

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
    if level_func and not gGlobalSyncTable.romhackcompatibility then
        level_func()
    else
        default_level_func()
    end
end)

local function level_init_spawns()
    if gGlobalSyncTable.romhackcompatibility then return end
    local m = gMarioStates[0]
    local np = gNetworkPlayers[0]
    local gorrie = obj_get_first_with_behavior_id(id_bhvGorrie)
    --local stonewall = obj_get_first_with_behavior_id(id_bhvStonewall)
    local hellentrance = obj_get_first_with_behavior_id(id_bhvHellEntrance)
    if np.currLevelNum == LEVEL_JRB then   

        if gorrie ~= nil then
            --djui_chat_message_create('dorrie exists')
        else
            spawn_sync_object(id_bhvGorrie, E_MODEL_RED_DORRIE, -5269, 1050, 3750, nil)
        end
        --if stonewall ~= nil then
            --djui_chat_message_create('stonewall exists')
        --else
            --spawn_sync_object(id_bhvStonewall, E_MODEL_STONEWALL, 6307, 1090, 2600, function (wall) 
                --wall.oFaceAngleYaw = 0
                --wall.oMoveAngleYaw = wall.oFaceAngleYaw
                --obj_scale(wall, 1.4)
            --end)
        --end
    end
    if np.currLevelNum == LEVEL_SECRETHUB and np.currAreaIndex == 1 then
        if not hellentrance then
            spawn_non_sync_object(id_bhvHellEntrance, E_MODEL_HELL_ENTRANCE, 895, 195, 388, nil)
        end
    end

    if np.currLevelNum == LEVEL_HMC then
        -- spawns coins to hint towards the new floor switch location
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -4890, -4660, 4890, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -4890, -4460, 4890, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -4890, -4260, 4890, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -5321, -6327, 3500, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -4900, -6327, 2220, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -3500, -6327, 1750, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -2170, -6327, 2150, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -1760, -6327, 3630, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -2170, -6327, 4910, nil)
        spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -3560, -6327, 5330, nil)
        spawn_sync_object(id_bhvCoinFormation, E_MODEL_NONE, -3580, -5221, -825, function(f) 
            f.oBehParams2ndByte = 4
            f.oFaceAngleYaw = 0    
            end)
        
        -- spawns JRH rocks for obstacles (unused due to model desyncing)
        --spawn_sync_object(id_bhvRockSolid, E_MODEL_JRB_ROCK, -4936, -5500, 260, nil)
        --spawn_sync_object(id_bhvRockSolid, E_MODEL_JRB_ROCK, -5010, -6035, 2690, nil)
        --spawn_sync_object(id_bhvRockSolid, E_MODEL_JRB_ROCK, -5870, -5680, 4455, nil)
        --spawn_sync_object(id_bhvRockSolid, E_MODEL_JRB_ROCK, -4390, -6010, 5340, nil)
    elseif np.currLevelNum == LEVEL_BOB then
        spawn_sync_object(id_bhvWaterBombSpawner, E_MODEL_NONE, 6233, 975, 3337, nil)
        spawn_sync_object(id_bhvWaterBombSpawner, E_MODEL_NONE, 3337, 791, 3265, nil)
        spawn_sync_object(id_bhvWaterBombSpawner, E_MODEL_NONE, 4499, 768, 6669, nil)
        spawn_sync_object(id_bhvWaterBombSpawner, E_MODEL_NONE, 5294, 1020, 5154, nil)
        spawn_sync_object(id_bhvWaterBombSpawner, E_MODEL_NONE, 6948, 873, 5019, nil)
        spawn_sync_object(id_bhvWaterBombSpawner, E_MODEL_NONE, 6394, 768, 6766, nil)
        spawn_sync_object(id_bhvWaterBombSpawner, E_MODEL_NONE, 2586, 768, 6719, nil)
    elseif np.currLevelNum == LEVEL_DDD then
        --spawn_sync_object(id_bhvSwoop, E_MODEL_SWOOP, 4134, 1374, 394, nil)
    elseif np.currLevelNum == LEVEL_LLL and np.currAreaIndex == 1 then 
        spawn_sync_object(id_bhvRedCoin, E_MODEL_RED_COIN, -5130, 560, -4080, nil)
        spawn_sync_object(id_bhvRedCoin, E_MODEL_RED_COIN, 0, 840, -7110, nil)
        spawn_sync_object(id_bhvRedCoin, E_MODEL_RED_COIN, 6300, 740, -6565, nil)
        spawn_sync_object(id_bhvRedCoin, E_MODEL_RED_COIN, 7168, 1000, 1400, nil)
        spawn_sync_object(id_bhvRedCoin, E_MODEL_RED_COIN, 4064, 670, 6878, nil)
        spawn_sync_object(id_bhvRedCoin, E_MODEL_RED_COIN, -3210, 80, 3460, function(r) r.oBehParams2ndByte = 10 end)
        spawn_sync_object(id_bhvRedCoin, E_MODEL_RED_COIN, 0, 1200, 6170, nil)
        spawn_sync_object(id_bhvRedCoin, E_MODEL_RED_COIN, 0, 720, -2330, nil)
        spawn_sync_object(id_bhvBouncingFireball, E_MODEL_RED_FLAME, -760, 355, 5045, nil)
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
    if level_func and not gGlobalSyncTable.romhackcompatibility then
        level_func()
    end

    originalTempo = sequence_player_get_tempo(SEQ_PLAYER_LEVEL) + (48 * 48)

end)

--Custom character sound changes, like disabling mario's fire scream to make room for custom scream.
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
    if sound == CHAR_SOUND_COUGHING1 and s.puking then return 0 end
    if sound == CHAR_SOUND_COUGHING2 and s.puking then return 0 end
    if sound == CHAR_SOUND_COUGHING3 and s.puking then return 0 end
    --if sound == CHAR_SOUND_EEUH and m.action ~= ACT_LEDGE_CLIMB_SLOW_1 or m.action ~= ACT_LEDGE_CLIMB_SLOW_2 then return 0 end

    if check_trophyplate(m, np, sound) then return 0 end
end)

function resize_flame(o)
    if obj_has_behavior_id(o, id_bhvFireParticleSpawner) ~= 0 then
        obj_scale(o, 6)
        obj_set_gfx_pos_at_obj_pos(o, o.parentObj)
        o.header.gfx.pos.y = o.header.gfx.pos.y + 100
    end
end
hook_event(HOOK_ON_OBJECT_RENDER, resize_flame)

--Custom sound changes, like replacing King Bobomb with Chuckster sounds.
hook_event(HOOK_ON_PLAY_SOUND, function(sound)
    local m = gMarioStates[0]
    if sound == SOUND_OBJ_KING_BOBOMB_TALK and m.action == ACT_GRABBED then return 0 end
end)


function obj_interact(m, o, intType)
    local np = gNetworkPlayers[0]
    if (obj_has_behavior_id(o, id_bhvWingCap) ~= 0) and m.flags & MARIO_NORMAL_CAP | MARIO_CAP_ON_HEAD == 0 and not gGlobalSyncTable.romhackcompatibility then
        return false --Wing Cap intangibility check for players with no hat on.
    end
    --if (obj_has_behavior_id(o, id_bhvGoomba) ~= 0) and o.oTimer < 5 then
        --return false -- Intangibility check specifically for Huge Goombas' goomba spawns on death, could cause unresponsiveness when killing goombas too early.
    --end
end
hook_event(HOOK_ALLOW_INTERACT, obj_interact)
----------------------------------------------------------------------------------------------------
--used for Metal Cap's moveset to add 'lag'
local squatActions = {
    [ACT_JUMP]               = {action = ACT_JUMP,               animation = CHAR_ANIM_LAND_FROM_SINGLE_JUMP},
    [ACT_DOUBLE_JUMP]        = {action = ACT_DOUBLE_JUMP,        animation = CHAR_ANIM_LAND_FROM_DOUBLE_JUMP},
    [ACT_TRIPLE_JUMP]        = {action = ACT_TRIPLE_JUMP,        animation = CHAR_ANIM_LAND_FROM_DOUBLE_JUMP},
    [ACT_FLYING_TRIPLE_JUMP] = {action = ACT_FLYING_TRIPLE_JUMP, animation = CHAR_ANIM_LAND_FROM_DOUBLE_JUMP},
    [ACT_SIDE_FLIP]          = {action = ACT_SIDE_FLIP,          animation = CHAR_ANIM_SLIDEFLIP_LAND, vel = 10},
    [ACT_BACKFLIP]           = {action = ACT_BACKFLIP,           animation = CHAR_ANIM_LAND_FROM_DOUBLE_JUMP},
    [ACT_LONG_JUMP]          = {action = ACT_LONG_JUMP,          animation = CHAR_ANIM_CROUCH_FROM_SLOW_LONGJUMP},
    [ACT_HOLD_JUMP]          = {action = ACT_HOLD_JUMP,          animation = CHAR_ANIM_JUMP_LAND_WITH_LIGHT_OBJ},
    [ACT_SLIDE_KICK]         = {action = ACT_SLIDE_KICK,         animation = CHAR_ANIM_SLIDE_KICK},
    [ACT_JUMP_KICK]          = {action = ACT_JUMP_KICK,          animation = CHAR_ANIM_GENERAL_LAND},
    [ACT_WALL_KICK_AIR]      = {action = ACT_WALL_KICK_AIR,      animation = CHAR_ANIM_SLIDEJUMP, delay = 3},
    [ACT_STEEP_JUMP]         = {action = ACT_STEEP_JUMP,         animation = CHAR_ANIM_LAND_FROM_SINGLE_JUMP},
}
    
ACT_METAL_JUMP_SQUAT = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR)

local function act_metal_jump_squat(m) -- thank you erick for being moveset pro
    local squat = squatActions[m.prevAction]
    if (m.flags & (MARIO_METAL_CAP) ~= 0) and squat then
        if m.actionTimer > (squat.delay or 5) then
            set_mario_action(m, squat.action, 0)
        end
        set_mario_animation(m, squat.animation)
        if squat.vel then
            mario_set_forward_vel(m, squat.vel)
        end
    end

    perform_ground_step(m)
    m.actionTimer = m.actionTimer + 1

    if ACT_METAL_JUMP_SQUAT and m.flags & MARIO_METAL_CAP == 0 then -- added to fix instances of the custom action carrying over to non-MC states
        set_mario_action(m, ACT_FREEFALL, 0)
    end
end

local function metal_jump_squat(m) -- thank you again erick for being moveset pro
    local isJumping = ((squatActions[m.action] and m.pos.y < m.floorHeight + 50) or m.action == ACT_WALL_KICK_AIR and m.prevAction ~= ACT_HOLDING_POLE 
    and m.prevAction ~= ACT_CLIMBING_POLE) and m.prevAction ~= ACT_METAL_JUMP_SQUAT
    if (m.flags & (MARIO_METAL_CAP) ~= 0) and isJumping then
        set_mario_action(m, ACT_METAL_JUMP_SQUAT, 0)
    end
end

-- This function and all other moveset functions cover Mini Mode and Metal Cap (and maybe Vanish Cap)
local function movesets_before_phys_step(m, stepType)
    local np = gNetworkPlayers[0]
    local hScale = 1.0
    local speed = {
        [ACT_WALKING] = true,
        [ACT_DECELERATING] = true,
        [ACT_BRAKING] = true,
        [ACT_MOVE_PUNCHING] = true,
        [ACT_CROUCH_SLIDE] = true,
        [ACT_MOVE_PUNCHING] = true,
        [ACT_TURNING_AROUND] = true,
        [ACT_BURNING_GROUND] = true,
        [ACT_BURNING_JUMP] = true,
        [ACT_LONG_JUMP_LAND] = true,
        [ACT_JUMP_KICK] = true,
        [ACT_BACKWARD_ROLLOUT] = true,
        [ACT_FORWARD_ROLLOUT] = true,
        [ACT_FREEFALL] = true,
        [ACT_FREEFALL_LAND] = true,
        [ACT_DIVE] = true,
        [ACT_JUMP] = true,
        [ACT_JUMP_LAND] = true,
        [ACT_DOUBLE_JUMP] = true, 
        [ACT_DOUBLE_JUMP_LAND] = true,
        [ACT_TRIPLE_JUMP] = true,
        [ACT_TRIPLE_JUMP_LAND] = true,
        [ACT_SIDE_FLIP] = true,
        [ACT_BACKFLIP] = true,
        [ACT_WALL_KICK_AIR] = true,
        [ACT_QUICKSAND_JUMP_LAND] = true
    }
    -- In THI's huge area, Mario will turn into Mini Mario! (no water run unless something interesting is added regarding water in THI)
    if np.currLevelNum == LEVEL_THI and np.currAreaIndex ~= 2 then 
        if m.action ~= ACT_WATER_JUMP and m.action ~= ACT_BUBBLED then 
            hScale = hScale - 0.2
        end
        if speed[m.action] and m.action ~= ACT_LONG_JUMP_LAND then
            m.vel.x = m.vel.x * 1.3
            m.vel.z = m.vel.z * 1.3
        end
        if not m.prevAction == ACT_GRABBED and m.action == ACT_THROWN_FORWARD then
            m.vel.x = m.vel.x * hScale
            m.vel.z = m.vel.z * hScale
        end
    end

    -- Makes non-submerged Metal Cap slow and laggy as balls
    if m.flags & MARIO_METAL_CAP ~= 0 then
        if speed[m.action] then
            m.vel.x = m.vel.x * 0.6
            m.vel.z = m.vel.z * 0.6
        end
        if m.action == ACT_WALKING then
            m.forwardVel = math.min(m.forwardVel, 22)
        end
        if m.action == ACT_LONG_JUMP or m.action == ACT_SLIDEKICK then
            m.forwardVel = math.min(m.forwardVel, 32)
        end
        if m.action == ACT_DIVE then
            m.forwardVel = math.min(m.forwardVel, 32)
        end
        if ACT_METAL_JUMP_SQUAT then
            m.forwardVel = math.min(m.forwardVel, 30)
        end
        if not m.prevAction == ACT_GRABBED and m.action == ACT_THROWN_FORWARD then
            m.vel.x = m.vel.x * hScale
            m.vel.z = m.vel.z * hScale
        end
    end
end

local function movesets_on_set_action(m)
    local np = gNetworkPlayers[0]
    local jumps = {
            [ACT_STEEP_JUMP] = true,
            [ACT_WATER_JUMP] = true,
            [ACT_JUMP] = true,
            [ACT_DOUBLE_JUMP] = true,
            [ACT_TRIPLE_JUMP] = true,
            [ACT_SIDE_FLIP] = true,
            [ACT_BACKFLIP] = true,
            [ACT_FREEFALL] = true,
            [ACT_HOLD_JUMP] = true,
            [ACT_BACKWARD_ROLLOUT] = true,
            [ACT_FORWARD_ROLLOUT] = true,
            [ACT_WALL_KICK_AIR] = true,
            [ACT_TWIRLING] = true,
            [ACT_QUICKSAND_JUMP_LAND] = true,
        }

    if np.currLevelNum == LEVEL_THI and np.currAreaIndex ~= 2 and not gGlobalSyncTable.romhackcompatibility then
        if (m.action == ACT_DOUBLE_JUMP) then -- it honestly just makes sense to remove double/triple jumps
            return set_mario_action(m, ACT_JUMP, 1)
        end
        if m.action == ACT_JUMP_KICK then
            m.vel.y = m.vel.y / 0.9
        end
        if m.action == ACT_DIVE then
            m.vel.y = m.vel.y - 4
        end
        if m.action == ACT_LONG_JUMP then
            m.vel.y = m.vel.y / 1.3
        end
        if jumps[m.action] or ((m.action & ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION) ~= 0 and (m.action & ACT_FLAG_CUSTOM_ACTION) ~= 0 and m.vel.y > 0) then
            m.vel.y = m.vel.y * 1.2
        end
        if m.action == ACT_HOLD_JUMP then
            m.vel.y = m.vel.y - 9.5
        end
        if m.action == ACT_WALL_KICK_AIR then
            m.vel.y = m.vel.y - 6.5
        end
    end

    if m.flags & MARIO_METAL_CAP ~= 0 then
        if jumps[m.action] or m.action == ACT_JUMP_KICK or m.action == ACT_LONG_JUMP or m.action == ACT_DIVE or ((m.action & ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION) ~= 0 and (m.action & ACT_FLAG_CUSTOM_ACTION) ~= 0 and m.vel.y > 0) then
            m.vel.y = m.vel.y * 0.8
        end

    end
end

local function movesets_update(m)
    local np = gNetworkPlayers[0]        
    local actions = {
            [ACT_STEEP_JUMP] = true,
            [ACT_WATER_JUMP] = true,
            [ACT_JUMP] = true,
            [ACT_DOUBLE_JUMP] = true,
            [ACT_TRIPLE_JUMP] = true,
            [ACT_SIDE_FLIP] = true,
            [ACT_BACKFLIP] = true,
            [ACT_FREEFALL] = true,
            [ACT_HOLD_JUMP] = true,
            [ACT_BACKWARD_ROLLOUT] = true,
            [ACT_FORWARD_ROLLOUT] = true,
            [ACT_WALL_KICK_AIR] = true,
            [ACT_TWIRLING] = true,
            [ACT_JUMP_KICK] = true,
            [ACT_DIVE] = true,
            [ACT_LONG_JUMP] = true,
            [ACT_QUICKSAND_JUMP_LAND] = true,
        }

    if np.currLevelNum == LEVEL_THI and np.currAreaIndex ~= 2 and not gGlobalSyncTable.romhackcompatibility then
        if actions[m.action] and m.action ~= ACT_SIDE_FLIP and m.vel.y > 0 or ((m.action & ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION) ~= 0 and (m.action & ACT_FLAG_CUSTOM_ACTION) ~= 0 and m.vel.y > 0) then 
            m.vel.y = m.vel.y + 0.5
        elseif actions[m.action] and m.action ~= ACT_LONG_JUMP and m.vel.y < 0 or ((m.action & ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION) ~= 0 and (m.action & ACT_FLAG_CUSTOM_ACTION) ~= 0 and m.vel.y < 0) then 
            m.vel.y = m.vel.y + 2
        end
        if m.action == ACT_LONG_JUMP and m.vel.y < 0 then 
            m.vel.y = m.vel.y + 1
        end
        if m.action == ACT_SIDE_FLIP and m.vel.y > 0 then
            m.vel.y = m.vel.y - 0.5
        end
        if m.action == ACT_SLIDEKICK then
            m.vel.y = m.vel.y + 4
        end

        -- changes the player's size, model and hitbox
        gPlayerSyncTable[m.playerIndex].size = 0.5
        vec3f_set(m.marioObj.header.gfx.scale, gPlayerSyncTable[m.playerIndex].size, gPlayerSyncTable[m.playerIndex].size, gPlayerSyncTable[m.playerIndex].size)
        m.marioObj.hitboxRadius = 10
        m.marioObj.hurtboxHeight = 25
        m.marioObj.hurtboxRadius = 10
    end
    
    if m.flags & MARIO_METAL_CAP ~= 0 and actions[m.action] or ((m.action & ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION) ~= 0 and (m.action & ACT_FLAG_CUSTOM_ACTION) ~= 0 and m.vel.y > 0) then
        m.vel.y = m.vel.y - 2
    end
end

-- there was an attempt at making Huge Goombas invulnerable when not being ground pounded, but there were bugs with them escaping squish deaths that i couldnt fix
--local function huge_goom_ded(o) 
    --local m = gMarioStates[0] 
    --if m.action == ACT_GROUND_POUND and (o.oAction == OBJ_ACT_VERTICAL_KNOCKBACK or o.oAction == OBJ_ACT_HORIZONTAL_KNOCKBACK or o.oAction == OBJ_ACT_SQUISHED) then
    --    o.oVelX = 0
    --    o.oVelY = 0
    --    o.oVelZ = 0
    --    o.oForwardVel = 0
    --    o.oGoombaRelativeSpeed = 0
    --    o.oAction = 0
    ---end
--end
--hook_event(HOOK_ON_OBJECT_UNLOAD, huge_goom_ded)


hook_mario_action(ACT_METAL_JUMP_SQUAT, act_metal_jump_squat)
hook_event(HOOK_ON_SET_MARIO_ACTION, metal_jump_squat)
hook_event(HOOK_MARIO_UPDATE, movesets_update)
hook_event(HOOK_ON_SET_MARIO_ACTION, movesets_on_set_action)
hook_event(HOOK_BEFORE_PHYS_STEP, movesets_before_phys_step)
----------------------------------------------------------------------------------------------------------------------------------------------------------
local function bbh_no_wkicks(m) --this'll be expanded on once Vanish Cap is complete
    if m.playerIndex ~= 0 then return end
    
    if gNetworkPlayers[0].currLevelNum == LEVEL_BBH and m.action == ACT_AIR_HIT_WALL then
        m.wallKickTimer = 0
        m.actionTimer = 3
    end
end
hook_event(HOOK_BEFORE_SET_MARIO_ACTION, bbh_no_wkicks)
hook_event(HOOK_ON_SET_MARIO_ACTION, bbh_no_wkicks)
----------------------------------------------------------------------------------------------------------------------------------------------------------

local function fake_lava_death(m)
    if m.action == ACT_WATER_DEATH then
        set_mario_action(m, ACT_GONE, 1)
        network_play(sSplash, m.pos, 1, m.playerIndex)
        play_sound(SOUND_OBJ_BULLY_EXPLODE_2, m.pos)
        spawn_non_sync_object(id_bhvBowserBombExplosion, E_MODEL_BOWSER_FLAMES, m.pos.x, m.pos.y, m.pos.z, nil)
    end
    if m.action == ACT_DROWNING then
        set_mario_action(m, ACT_GONE, 1)
        network_play(sSplash, m.pos, 1, m.playerIndex)
        play_sound(SOUND_OBJ_BULLY_EXPLODE_2, m.pos)
        spawn_non_sync_object(id_bhvBowserBombExplosion, E_MODEL_BOWSER_FLAMES, m.pos.x, m.pos.y, m.pos.z, nil)
    end
end 

function level_obj_init() -- Moves the only Huge Triplet Goombas further from spawn (for fairness)
    local np = gNetworkPlayers[0]
    local o = obj_get_first_with_behavior_id(id_bhvGoombaTripletSpawner)
    local m = gMarioStates[0]
    if not gGlobalSyncTable.romhackcompatibility then
        if np.currLevelNum == LEVEL_THI and np.currAreaIndex == 1 then
            while o do 
                obj_move_xyz(o, 500, 0, -500)
                o = obj_get_next_with_same_behavior_id(o)
            end
        end

        -- Moves the Floor Switch deeper within the lava pool.
        local f = obj_get_first_with_behavior_id(id_bhvFloorSwitchGrills)
        if np.currLevelNum == LEVEL_HMC then 
            f.oPosX = -4890
            f.oPosY = -6327  
            f.oPosZ = 4890
            --spawn_sync_object(id_bhvYellowCoin, E_MODEL_YELLOW_COIN, -4890, -4660, 4890, nil)  --the issue
        end

        local e = obj_get_first_with_behavior_id(id_bhvExclamationBox)
        local r = obj_get_first_with_behavior_id(id_bhvRedCoin)
        local f = obj_get_first_with_behavior_id(id_bhvFadingWarp)
        if np.currLevelNum == LEVEL_LLL then
            while e do
                obj_mark_for_deletion(e)
                e = obj_get_next_with_same_behavior_id(e)
            end
            if r.oPosY < 250 and r.oPosX < -4000 then
                while r do
                    obj_mark_for_deletion(r)
                    r = obj_get_next_with_same_behavior_id(r)
                end
            end
            while f do
                obj_mark_for_deletion(f)
                f = obj_get_next_with_same_behavior_id(f)
            end
        end    

        -- Move the castle Boo further from the door to eventually begin the Boo race code (won't be too fancy because me coding noob)
        local b = obj_get_first_with_behavior_id(id_bhvBooInCastle)
        if np.currLevelNum == LEVEL_CASTLE and np.currAreaIndex == 1 then
            while b do
                djui_chat_message_create(tostring(b.oPosX))
                djui_chat_message_create(tostring(b.oPosY))
                djui_chat_message_create(tostring(b.oPosZ))
                b = obj_get_next_with_same_behavior_id(b)
            end
        end
    end
end

local function thi_mini() -- yea idk how to get this to work
    local np = gNetworkPlayers[0]
    if np.currLevelNum == LEVEL_THI and np.currAreaIndex == 1 then
        if m.action == ACT_EMERGE_FROM_PIPE then 
            local_play(sMini, m.pos, 2) 
        end
    end
end

-- Prevents pause exiting if you aren't idle.
local function on_pause_exit(m)
    if gMarioStates[0].action ~= ACT_IDLE then 
        djui_popup_create("You cannot exit the level in this state!", 1)
        return false 
        end
end

hook_event(HOOK_ON_PAUSE_EXIT, on_pause_exit)
hook_event(HOOK_ON_LEVEL_INIT, level_obj_init)
hook_event(HOOK_ON_WARP, thi_mini)
hook_event(HOOK_ON_DEATH, fake_lava_death)