

gSamples = {
	audio_sample_load("bonebreak.ogg"),
	audio_sample_load("bigexplosion.ogg"),
	audio_sample_load("electricscream.ogg"),
	audio_sample_load("shock.ogg"),
	audio_sample_load("mariodeath.ogg"),
	audio_sample_load("angrymario.ogg"),
	audio_sample_load("flames.ogg"),
	audio_sample_load("killyoshi.ogg"),
	audio_sample_load("smwbonusend.ogg"),
	audio_sample_load("smiler.ogg"),
	audio_sample_load("splash.ogg"),
	audio_sample_load("punch.ogg"),
	audio_sample_load("goomba.ogg"),
	audio_sample_load("agonymario.ogg"),
	audio_sample_load("cooloff.ogg"),
	audio_sample_load("thunder.ogg"),
	audio_sample_load("gslaser.ogg"),
	audio_sample_load("gsbeam.ogg"),
	audio_sample_load("crunch.ogg"),
	audio_sample_load("agonytoad.ogg"),
	audio_sample_load("fart.ogg"),
	audio_sample_load("glass.ogg"),
	audio_sample_load("portal_ambient.ogg"),
	audio_sample_load("portal_enter.ogg"),
	audio_sample_load("portal_travel.ogg"),
	audio_sample_load("smwwrong.ogg"),
	audio_sample_load("agonyluigi.ogg"),
	audio_sample_load("burp.ogg"),
	audio_sample_load("bows2intro.ogg"),
	audio_sample_load("agonywario.ogg"),
	audio_sample_load("dorriebackbreak.ogg"),
	audio_sample_load("smwping.ogg"),
	audio_sample_load("agonywaluigi.ogg"),
	audio_sample_load("iwbtgdeath.ogg"),
	audio_sample_load("chicken.ogg"),
	audio_sample_load("ground.ogg"),
	audio_sample_load("klepto.ogg"),
	audio_sample_load("nightvision.ogg"),
	audio_sample_load("chuckster.ogg")
}

sBoneBreak = 1
sBigExplosion = 2
sElectricScream = 3
sShock = 4
sSplatter = 5
sAngryMario = 6
sFlames = 7
sKillYoshi = 8
sSMWBonusEnd = 9
sSmiler = 10
sSplash = 11
sPunch = 12
sGoombaStomp = 13
sAgonyMario = 14
sCoolOff = 15
sThunder = 16
sGslaser = 17
sGsbeam = 18
sCrunch = 19
sToadburn = 20
sFart = 21
sGlass = 22
sPortalAmbient = 23
sPortalEnter = 24
sPortalTravel = 25
sWrong = 26
sAgonyLuigi = 27
sBurp = 28
sBows2intro = 29
sAgonyWario = 30
sDorrie = 31
sSmwping = 32
sAgonyWaluigi = 33
sIwbtgDeath = 34
sChicken = 35
sGround = 36
sAngryKlepto = 37
sNightvision = 38
sChuckster = 39

function loop(music) audio_stream_set_looping(music, true) end

highmusic = audio_stream_load("high.ogg")
smwbonusmusic = audio_stream_load("smwbonusloop.ogg")   loop(smwbonusmusic)
boss = audio_stream_load("croppedcastle.ogg")
backroomMusic = audio_stream_load("backroom.ogg")		loop(backroomMusic)
musicHell = audio_stream_load("hell.ogg") 				loop(musicHell)
secret = audio_stream_load("secret.ogg") 				loop(secret)
musicUnderground = audio_stream_load("underground.ogg")	loop(musicUnderground)
musicbows2 = audio_stream_load("bows2loop.ogg")         loop(musicbows2)
timeattack = audio_stream_load("timeattack.ogg")
edils = audio_stream_load("edils.ogg")					loop(edils)
sad = audio_stream_load("sad.ogg")
iwbtg = audio_stream_load("iwbtg.ogg")					loop(iwbtg)
frijoleslobby = audio_stream_load("frijlobby.ogg")		loop(frijoleslobby)

currentlyPlaying = nil
local fadeTimer = 0
local fadePeak = 0
local volume = 1

--! audio

---@param a ModAudio
function stream_play(a)
	if currentlyPlaying then audio_stream_stop(currentlyPlaying) end
	audio_stream_play(a, true, 1)
	currentlyPlaying = a
	fadeTimer = 0
end
function stream_fade(time)
	fadePeak = time
	fadeTimer = time
end
function stream_set_volume(vol)
	volume = vol
end
function stream_stop_all()
	audio_stream_stop(highmusic)
	audio_stream_stop(smwbonusmusic)
	audio_stream_stop(boss)
	audio_stream_stop(musicHell)
	audio_stream_stop(backroomMusic)
	audio_stream_stop(secret)
	audio_stream_stop(musicUnderground)
	audio_stream_stop(musicbows2)
	audio_stream_stop(timeattack)
	audio_stream_stop(edils)
	audio_stream_stop(sad)
	audio_stream_stop(frijoleslobby)
	currentlyPlaying = nil
end
hook_event(HOOK_UPDATE, function ()
	if fadeTimer > 0 then
		fadeTimer = fadeTimer - 1
		if fadeTimer == 0 then
			stream_stop_all()
		end
	end
	if currentlyPlaying then
		audio_stream_set_volume(currentlyPlaying, (is_game_paused() and 0.2 or (fadeTimer ~= 0 and fadeTimer/fadePeak or 1)) * volume)
	end
end)

function local_play(id, pos, vol)
	audio_sample_play(gSamples[id], pos, (is_game_paused() and 0 or vol))
end
function network_play(id, pos, vol, i)
    local_play(id, pos, vol)
    network_send(true, {id = id, x = pos.x, y = pos.y, z = pos.z, vol = vol, i = network_global_index_from_local(i)})
end
function stop_all_samples()
	for _, audio in pairs(gSamples) do
		audio_sample_stop(audio)
	end
end

hook_event(HOOK_ON_PACKET_RECEIVE, function (data)
	if is_player_active(gMarioStates[network_local_index_from_global(data.i)]) ~= 0 then
		local_play(data.id, {x=data.x, y=data.y, z=data.z}, data.vol)
	end
end)

--! models

LEVEL_HELL = level_register('level_hell_entry', COURSE_NONE, 'Hell', 'Hell', 28000, 0x28, 0x28, 0x28)
LEVEL_SECRETHUB = level_register('level_secretroom_entry', COURSE_NONE, 'Secret Hub', 'Secret Hub', 28000, 0x28, 0x28, 0x28)

E_MODEL_HIDDENFLAG = smlua_model_util_get_id("hiddenflag_geo")
E_MODEL_BLOOD_SPLATTER = smlua_model_util_get_id("blood_splatter_geo")
E_MODEL_BLOOD_SPLATTER2 = smlua_model_util_get_id("blood_splatter2_geo")
E_MODEL_BLOOD_SPLATTER_WALL = smlua_model_util_get_id("blood_splatter_wall_geo")
E_MODEL_BLOOD_MIST = smlua_model_util_get_id("blood_mist_geo")
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
E_MODEL_GOLD_RING = smlua_model_util_get_id("gold_ring_geo")
E_MODEL_SWING_BLADE = smlua_model_util_get_id("SwingBlade_geo")
COL_MODEL_SWING_BLADE = smlua_collision_util_get("SwingBlade_collision")
E_MODEL_GRINDER = smlua_model_util_get_id("Grinder_geo")
E_MODEL_CHOMP = smlua_model_util_get_id("chomp_geo")
E_MODEL_STOPWATCH = smlua_model_util_get_id("stopwatch_geo")
E_MODEL_GIB = smlua_model_util_get_id("gib_geo")
COL_GIB = smlua_collision_util_get("gib_collision")
DORRIE_DEAD = smlua_model_util_get_id("dorrie_ded_lol_geo")
E_MODEL_HELL_DORRIE = smlua_model_util_get_id("hell_dorrie_geo")
E_MODEL_RED_DORRIE = smlua_model_util_get_id("red_dorrie_geo")
E_MODEL_LANTERN = smlua_model_util_get_id("lantern_geo")
COL_LANTERN = smlua_collision_util_get("lantern_collision")
E_MODEL_GOGGLES = smlua_model_util_get_id("goggles_geo")
E_MODEL_STONEWALL = smlua_model_util_get_id("stonewall_geo")
COL_STONEWALL = smlua_collision_util_get("stonewall_collision")

E_MODEL_BLOODY_STAR_DOOR = smlua_model_util_get_id("bsdoor_geo")

E_MODEL_HEADLESS_MARIO = smlua_model_util_get_id("headlessmario_geo")
E_MODEL_BOTTOMLESS_MARIO = smlua_model_util_get_id("bottomlessmario_geo")
E_MODEL_HEADLESS_LUIGI = smlua_model_util_get_id("luigidead_geo")
--E_MODEL_BOTTOMLESS_LUIGI = smlua_model_util_get_id("bottomlessmario_geo")
E_MODEL_HEADLESS_TOAD = smlua_model_util_get_id("toad_headless_geo")
E_MODEL_TOPLESS_TOAD = smlua_model_util_get_id("toad_topless_geo")
E_MODEL_HEADLESS_WARIO = smlua_model_util_get_id("wario_headless_geo")
E_MODEL_TOPLESS_WARIO = smlua_model_util_get_id("wario_topless_geo")
E_MODEL_HEADLESS_WALUIGI = smlua_model_util_get_id("waluigiheadless_geo")
E_MODEL_TOPLESS_WALUIGI = smlua_model_util_get_id("waluigitopless_geo")

E_MODEL_GOLD_MARIO = smlua_model_util_get_id("golden_mario_geo")
E_MODEL_GOLD_LUIGI = smlua_model_util_get_id("golden_luigi_geo")
E_MODEL_GOLD_TOAD = smlua_model_util_get_id("golden_toad_player_geo")
E_MODEL_GOLD_WARIO = smlua_model_util_get_id("golden_wario_geo")
E_MODEL_GOLD_WALUIGI = smlua_model_util_get_id("golden_waluigi_geo")

gold_models = {
    [CT_MARIO] = E_MODEL_GOLD_MARIO,
    [CT_LUIGI] = E_MODEL_GOLD_LUIGI,
    [CT_TOAD] = E_MODEL_GOLD_TOAD,
    [CT_WARIO] = E_MODEL_GOLD_WARIO,
    [CT_WALUIGI] = E_MODEL_GOLD_WALUIGI
}

--! music and course names

smlua_audio_utils_replace_sequence(SEQ_EVENT_CUTSCENE_ENDING, 35, 76, "gorepeach") --Custom Audio for end cutscene

smlua_text_utils_course_name_replace(COURSE_WDW, 'Dry World')
smlua_text_utils_course_name_replace(COURSE_JRB, 'Jolly Roger Hell')
smlua_text_utils_course_name_replace(COURSE_TTM, 'Dark Dark Mountain')

--! misc variables, state extras

gStateExtras = {}
for i = 0, MAX_PLAYERS-1 do
	gStateExtras[i] = {
		splatter = 1,
		flyingVel = 0,
		enablesplattimer = 0, --w
		splattimer = 0,
		jumpland = 0,
		disappear = 0,
		isdead = false,
		isinhell = false,
		stomped = false,
		headless = false,
		bottomless = false,
		disableuntilnextwarp = false,
		penguinholding = 0,
		penguintimer = 0,
		objtimer = 0,
		ishigh = 0,
		isgold = false,
		outsidegastimer = 60,
		highdeathtimer = 0,
		ssldiethirst = 0,
		splatterdeath = 0,
		timeattack = false,
		visitedhell = false,
		iwbtg = false,
		death = false,
		sslIntro = false,
		slIntro = false,
		hasNightvision = false
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
nightvisionnoise = 0


if network_is_server() and mod_storage_load("file"..get_current_save_file_num().."gameisbeat") then
	--djui_chat_message_create("game is beat!")
	if not gGlobalSyncTable.floodenabled then
		gGlobalSyncTable.gameisbeat = true
	end
else
	--djui_chat_message_create("game NOT beat")
end

define_custom_obj_fields({
    oBloody = "u32"
})

GORRIE_WAITING_FOR_DISEMBARK = 0
GORRIE_TRAVEL_TO_GOAL = 1
GORRIE_WAITING_FOR_PLAYERS_TO_BOARD = 2
GORRIE_TRAVEL_TO_HOME = 3
GORRIE_HOME_IDLE = 4

-- Table to map levels to their specific actions
sOnWarpToFunc = {
    [LEVEL_HMC] = function()
        if gGlobalSyncTable.gameisbeat then
            -- GRANT TROPHY #16
            spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, -5298, 2810, -7961, function(t)
                t.oBehParams = 16 << 16 | 1
            end)
        end

        -- Adjust Dorrie and set water level
        local dorrie = obj_get_nearest_object_with_behavior_id(o, id_bhvDorrie)
        if dorrie then
            dorrie.oPosY = dorrie.oPosY - 200
        end
        set_water_level(0, -10000, false)
        spawn_non_sync_object(id_bhvLava, E_MODEL_LAVA, gMarioStates[0].pos.x, -5200, gMarioStates[0].pos.z, nil)
    end,

    [LEVEL_LLL] = function()
        if np.currAreaIndex == 2 and gGlobalSyncTable.gameisbeat then
            -- GRANT TROPHY #15
            spawn_non_sync_object(id_bhvHellPlatform1, E_MODEL_HELLPLATFORM, 1331, 4032, 1281, nil)
            spawn_non_sync_object(id_bhvHellPlatform1, E_MODEL_HELLPLATFORM, 493, 4532, 652, nil)
            spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, 493, 4640, 652, function(t)
                t.oBehParams = 15 << 16 | 1
            end)
        end
    end,

    [LEVEL_SSL] = function()
        if np.currAreaIndex == 2 and gMarioStates[0].playerIndex == 0 then
            spawn_non_sync_object(id_bhvHeaveHo, E_MODEL_HEAVE_HO, 686, -1530, -2157, nil)
        end
    end,

    [LEVEL_JRB] = function()
        if np.currAreaIndex == 1 then
            -- Spawns lava over water, unless inside the pirate ship.
            --spawn_non_sync_object(id_bhvLava, E_MODEL_LAVA, gMarioStates[0].pos.x, 1050, gMarioStates[0].pos.z, function(o)
			spawn_non_sync_object(id_bhvLava, E_MODEL_LAVA, gMarioStates[0].pos.x, 1020, gMarioStates[0].pos.z, nil)
			if np.currActNum == 1 then
				spawn_non_sync_object(id_bhvStaticObject, E_MODEL_NONE, 6710, 1050, 4512, nil)
			else
				spawn_non_sync_object(id_bhvStaticObject, E_MODEL_NONE, 1976, 1050, 5734, nil)

			end 
            local o = obj_get_first_with_behavior_id(id_bhvCannonClosed)
            o.oPosY = o.oPosY + 21
        end
    end,

    [LEVEL_HELL] = function()
        gMarioStates[0].health = gMarioStates[0].health + 2048
        area_get_warp_node(0x01).node.destLevel = LEVEL_HELL
        area_get_warp_node(0x02).node.destLevel = LEVEL_HELL
		local goal = obj_get_first_with_behavior_id(id_bhvNetherPortal)
		local netherportalvec = {
			goal.oPosX,
			goal.oPosY,
			goal.oPosZ
		}
		--gLakituState.curFocus = netherportalvec
		--gLakituState.yaw = 0
		--soft_reset_camera(m.area.camera)
    end,

    [LEVEL_SECRETHUB] = function()
        local m = gMarioStates[0]

		--Entrance fix. If the player visits Hell first then goes to secret room, they will spawn out of the map.
		m.pos.x = -975
		m.pos.y = 850
		m.pos.z = -721
		soft_reset_camera(m.area.camera)


        if trophy_unlocked(1) and trophy_unlocked(2) and trophy_unlocked(3) and
           trophy_unlocked(4) and trophy_unlocked(5) and not trophy_unlocked(6) then
            play_sound(SOUND_MENU_COLLECT_SECRET, m.pos)
            djui_chat_message_create("Game beat with all playable characters!")
            djui_chat_message_create("Trophy earned!")
            unlock_trophy(6)
        end

        if np.currAreaIndex == 1 then
            stream_play(secret)
        elseif np.currAreaIndex == 2 and currentlyPlaying ~= musicUnderground then
            stream_play(musicUnderground)
        elseif np.currAreaIndex == 3 and currentlyPlaying ~= frijoleslobby then
            stream_play(frijoleslobby)
        end
    end,

    [LEVEL_CCM] = function()
		local np = gNetworkPlayers[0]
        if gGlobalSyncTable.gameisbeat and np.currAreaIndex == 1 then
            local count = obj_count_objects_with_behavior_id(id_bhvGoalpost)
            if count < 1 then
                spawn_non_sync_object(id_bhvGoalpost, E_MODEL_GOALPOST, 5254, -4607, 1047, function(goalpost)
                    goalpost.oFaceAngleYaw = -36768
                    goalpost.oMoveAngleYaw = goalpost.oFaceAngleYaw
                end)
            end
        end
    end,

	

    [LEVEL_CASTLE] = function()
        if np.currAreaIndex == 2 and gGlobalSyncTable.gameisbeat then
            -- GRANT TROPHY #12 (Mirror room)
            spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, 5514, 1613, 3159, function(t)
                t.oBehParams = 12 << 16 | 1
            end)
            spawn_non_sync_object(id_bhvQuickWarp, E_MODEL_NONE, 3158, 1613, 3172, nil)
        end
    end
}

sOnLvlInitToFunc = {
    [LEVEL_HELL] = function()
        set_lighting_color(0, 255)
        set_lighting_color(1, 127)
        set_lighting_color(2, 100)
        set_lighting_dir(1, -128)
        stream_play(musicHell)

        if gGlobalSyncTable.gameisbeat then
            -- GRANT TROPHY #14
            spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, -4367, 1680, 4883, function(t)
                t.oBehParams = 14 << 16 | 1
            end)
        end

        -- Apply environment effects and lighting settings
        set_override_envfx(ENVFX_LAVA_BUBBLES)
        set_override_skybox(BACKGROUND_FLAMING_SKY)
        if savedCollisionBugStatus == nil then
            savedCollisionBugStatus = gLevelValues.fixCollisionBugs
            gLevelValues.fixCollisionBugs = true
        end
    end,

	[LEVEL_TTM] = function()
		--spawn_non_sync_object(id_bhvBobombBuddy, E_MODEL_BOBOMB_BUDDY, 342, -2556, 5712, function(bob) bob.oBehParams = 20 end)
		--spawn_non_sync_object(id_bhvBobombBuddy, E_MODEL_LANTERN, 342, -2556, 5712, function(bob) bob.oBehParams = 20 end)
		
		--Lantern spawns with Mario. If you were to disable this spawn, light bubble will naturally follow Mario.
		if not gGlobalSyncTable.floodenabled then
			spawn_non_sync_object(id_bhvLantern, E_MODEL_LANTERN, 342, -2556, 5712, nil)
		end

		if np.currActNum == 6 then --Secret lantern spawns near beginning of level
			--spawn_non_sync_object(id_bhvGoggles, E_MODEL_GOGGLES, 342, -2556, 5712, nil)
		end

		spawn_non_sync_object(id_bhvGoggles, E_MODEL_GOGGLES, 434, -2000, 3704, function (nvg) 
			nvg.oFaceAngleYaw = -2600
			nvg.oMoveAngleYaw = nvg.oFaceAngleYaw
		end)
		--spawn_non_sync_object(id_bhvGoggles, E_MODEL_GOGGLES, -3492, -4100, 3705, nil)
    end,

    [LEVEL_BITFS] = function()
        if gGlobalSyncTable.gameisbeat and not trophy_unlocked(10) then
            spawn_non_sync_object(id_bhvStopwatch, E_MODEL_STOPWATCH, -7135, -2764, -3, nil)
        end
    end,

    [LEVEL_CASTLE_GROUNDS] = function()
        spawn_non_sync_object(id_bhvSecretWarp, E_MODEL_GOLD_RING, -37, 808, 545, nil)
        spawn_non_sync_object(id_bhvFlatStar, E_MODEL_STAR, -37, 811, 545, nil)
		set_lighting_color(0, 255)
		set_lighting_color(1, 255)
		set_lighting_color(2, 255)
		set_lighting_dir(1,0)
		set_override_skybox(-1)
		set_override_envfx(-1)
    end,

    [LEVEL_WF] = function()
        if np.currActNum >= 2 and gGlobalSyncTable.gameisbeat then
            -- GRANT TROPHY #17
            spawn_non_sync_object(id_bhvTrophy, E_MODEL_NONE, -404, 3584, -4, function(t)
                t.oFaceAngleYaw = -16303
                t.oBehParams = 17 << 16 | 1
            end)
        end
    end,

    [LEVEL_JRB] = function()
        -- Spawns lava and adjusts lighting
        spawn_non_sync_object(id_bhvLava, E_MODEL_LAVA, gMarioStates[0].pos.x, 1050, gMarioStates[0].pos.z, function(o)
            -- obj_scale(o, 4)
        end)
        spawn_non_sync_object(id_bhvStaticObject, E_MODEL_NONE, 5910, 1050, 4412, nil)
        local o = obj_get_first_with_behavior_id(id_bhvCannonClosed)
        o.oPosY = o.oPosY + 21

        -- Apply environment effects and lighting settings
        set_override_envfx(ENVFX_LAVA_BUBBLES)
        set_override_skybox(BACKGROUND_FLAMING_SKY)
        set_lighting_color(0, 255)
        set_lighting_color(1, 127)
        set_lighting_color(2, 100)
        set_lighting_dir(1, -128)
        if savedCollisionBugStatus == nil then
            savedCollisionBugStatus = gLevelValues.fixCollisionBugs
            gLevelValues.fixCollisionBugs = true
        end
    end
}

--! actions

_G.ACT_GONE = allocate_mario_action(ACT_GROUP_CUTSCENE|ACT_FLAG_STATIONARY|ACT_FLAG_INTANGIBLE|ACT_FLAG_INVULNERABLE)
function act_gone(m)
	local s = gStateExtras[m.playerIndex]
	s.isgold = false
	gPlayerSyncTable[m.playerIndex].gold = false
    m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags & ~GRAPH_RENDER_ACTIVE
	m.actionTimer = m.actionTimer + 1
	if m.actionTimer == m.actionArg then
		local savedY = m.pos.y
		m.pos.y = savedY
	end
	if m.actionTimer == 45 then
		if not s.iwbtg then
			--djui_chat_message_create(tostring(m.actionTimer))
			common_death_handler(m, 0, -1)
		end
	end

end
hook_mario_action(ACT_GONE, act_gone)

_G.ACT_NOTHING = allocate_mario_action(ACT_GROUP_CUTSCENE|ACT_FLAG_STATIONARY|ACT_FLAG_INTANGIBLE|ACT_FLAG_INVULNERABLE)
function act_nothing(m)
	local s = gStateExtras[m.playerIndex]
	m.marioBodyState.eyeState = MARIO_EYES_DEAD
	if m.prevAction == ACT_LAVA_BOOST then
		m.action = ACT_GONE
	end
    --m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags & ~GRAPH_RENDER_ACTIVE
	--m.actionTimer = m.actionTimer + 1
end
hook_mario_action(ACT_NOTHING, act_nothing)

--Mario's neck snapping action.
_G.ACT_NECKSNAP = allocate_mario_action(ACT_GROUP_AUTOMATIC|ACT_FLAG_INVULNERABLE|ACT_FLAG_STATIONARY)
function act_necksnap(m)
	local s = gStateExtras[m.playerIndex]
	if not s.iwbtg then
		common_death_handler(m, MARIO_ANIM_SUFFOCATING, 86)
	else
		m.health = 0xff
		--set_mario_action(m, ACT_NOTHING, 0)
	end
	smlua_anim_util_set_animation(m.marioObj, "MARIO_NECKSNAP")
	m.actionTimer = m.actionTimer + 1
	if m.actionTimer == 1 then
		local_play(sBoneBreak, m.pos, 1)
		set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
	end
	s.isgold = false
	gPlayerSyncTable[m.playerIndex].gold = false
end
hook_mario_action(ACT_NECKSNAP, act_necksnap)

_G.ACT_READING_TROPHY = allocate_mario_action(ACT_GROUP_AUTOMATIC|ACT_FLAG_STATIONARY)
function act_reading_trophy(m)
	if m.actionTimer == 1 then
		set_mario_animation(m, MARIO_ANIM_START_REACH_POCKET, 0)
	end
	if m.actionTimer == 30 then
		set_mario_action(m, ACT_IDLE, 0)
	end
end
hook_mario_action(ACT_READING_TROPHY, act_reading_trophy)

local MC = PARTICLE_MIST_CIRCLE
local T  = PARTICLE_TRIANGLE
local particleTimings = {
	[20] = MC,
	[40] = MC,
	[50] = MC,
	[65] = MC,
	[75] = MC|T,
	[82] = MC|T,
	[90] = MC|T,
	[95] = MC|T,
	[100]= MC|T,
	[105]= MC|T,
	[108]= MC|T,
	[114]= MC|T,
	[118]= MC|T,
	[121]= MC|T,
	[124]= MC|T,
	[127]= MC|T,
	[130]= MC|T,
	[132]= MC|T,
	[134]= MC|T,
	[136]= MC|T,
	[138]= MC|T,
	[140]= T
}

--Electricutes the F out of Mario
function act_shocked(m)
	local s = gStateExtras[m.playerIndex]
	s.isgold = false
	gPlayerSyncTable[m.playerIndex].gold = false
	m.actionTimer = m.actionTimer + 1
	set_mario_animation(m, MARIO_ANIM_SHOCKED)
	if m.actionTimer % 2 == 0 then
		m.flags = m.flags | MARIO_METAL_SHOCK
	else
		m.flags = m.flags & ~(MARIO_METAL_SHOCK)
	end
	if m.actionTimer > 50 then
		m.marioBodyState.eyeState = MARIO_EYES_DEAD
	end
	if particleTimings[m.actionTimer] then
		m.particleFlags = particleTimings[m.actionTimer]
	end
	if m.actionTimer == 140 then
		m.squishTimer = 50
	end
end
hook_mario_action(ACT_SHOCKED, act_shocked)

--If Mario takes damage mid-air, he will ragdoll down to his death.
_G.ACT_RAGDOLL = allocate_mario_action(ACT_GROUP_CUTSCENE|ACT_FLAG_STATIONARY|ACT_FLAG_INTANGIBLE|ACT_FLAG_INVULNERABLE)
function act_ragdoll(m)
	local s = gStateExtras[0]
	local stepResult = perform_air_step(m, 0)

	if stepResult == AIR_STEP_LANDED then
		if m.floor.type == SURFACE_BURNING then
			set_mario_action(m, ACT_LAVA_BOOST, 0)
		else
			if m.vel.y < -70 then
				s.disappear = 1
				m.squishTimer = 50
				set_camera_shake_from_hit(SHAKE_LARGE_DAMAGE)
			else
				m.squishTimer = 50
			end
		end
	elseif m.wall then
		bloodmist(m.marioObj)
		m.health = 0xff
		network_play(sSplatter, m.pos, 1, m.playerIndex)
		spawn_sync_object(id_bhvStaticObject, E_MODEL_BLOOD_SPLATTER, m.pos.x, m.pos.y, m.pos.z, function(o)
			local z, normal = vec3f(), m.wallNormal
			o.oFaceAnglePitch = 16384
			o.oFaceAngleYaw = calculate_yaw(z, normal)
			o.oFaceAngleRoll = 0
			o.oPosX = o.oPosX - (48 * sins(o.oFaceAngleYaw))
			o.oPosZ = o.oPosZ - (48 * coss(o.oFaceAngleYaw))
		end)
		for i = 0, 50 do
			local random = math.random()
			spawn_sync_object(id_bhvGib, E_MODEL_GIB, m.pos.x, m.pos.y, m.pos.z, function (gib)
				obj_scale(gib, random)
			end)
		end
		if not s.iwbtg then
			common_death_handler(m, 0, -1)
		end

		return set_mario_action(m, ACT_GONE, 0)
	end
	set_character_animation(m, CHAR_ANIM_AIRBORNE_ON_STOMACH)
	m.marioBodyState.eyeState = MARIO_EYES_DEAD
	if m.actionArg == 1 then
		local l = gLakituState
		l.posHSpeed, l.posVSpeed, l.focHSpeed, l.focVSpeed = 0, 0, 0, 0
	end
	vec3s_set(m.angleVel, 2000, 1000, 400)
	vec3s_add(m.faceAngle, m.angleVel)
	vec3s_copy(m.marioObj.header.gfx.angle, m.faceAngle)
end
hook_mario_action(ACT_RAGDOLL, act_ragdoll)

--Mario is decapitated.
_G.ACT_DECAPITATED = allocate_mario_action(ACT_GROUP_AUTOMATIC|ACT_FLAG_INVULNERABLE|ACT_FLAG_STATIONARY)

local headlessModel = {
    [0] = E_MODEL_HEADLESS_MARIO,
	E_MODEL_HEADLESS_LUIGI,
	E_MODEL_HEADLESS_TOAD,
	E_MODEL_HEADLESS_WALUIGI,
	E_MODEL_HEADLESS_WARIO,
}

function act_decapitated(m)
    local s = gStateExtras[m.playerIndex]
    local player_sync = gPlayerSyncTable[m.playerIndex]

    s.isgold = false
    player_sync.gold = false

    obj_set_model_extended(m.marioObj, headlessModel[m.character.type])

    if m.actionTimer == 0 then
        squishblood(m.marioObj)
        m.actionTimer = 1
    end

    local death_duration = s.iwbtg and 9999999 or 50
    common_death_handler(m, MARIO_ANIM_ELECTROCUTION, death_duration)
end

hook_mario_action(ACT_DECAPITATED, act_decapitated)

--Mario is bitten in half.
_G.ACT_BITTEN_IN_HALF = allocate_mario_action(ACT_GROUP_AUTOMATIC|ACT_FLAG_INVULNERABLE|ACT_FLAG_STATIONARY)

local toplessModel = {
[0]=E_MODEL_BOTTOMLESS_MARIO,
	E_MODEL_TOPLESS_TOAD,
	E_MODEL_TOPLESS_WALUIGI,
	E_MODEL_TOPLESS_WARIO
}

function act_bitten_in_half(m)
	local s = gStateExtras[m.playerIndex]
	s.isgold = false
	gPlayerSyncTable[m.playerIndex].gold = false
	obj_set_model_extended(m.marioObj, toplessModel[m.character.type])
	if not s.iwbtg then
		common_death_handler(m, MARIO_ANIM_SUFFOCATING, 86)
	else
		set_character_animation(m, CHAR_ANIM_SUFFOCATING)
	end
end
hook_mario_action(ACT_BITTEN_IN_HALF, act_bitten_in_half)

--! helper functions

function adjust_slide_velocity(m, slide_speed)
    m.slideVelX = m.slideVelX + slide_speed * sins(m.faceAngle.y)
    m.slideVelZ = m.slideVelZ + slide_speed * coss(m.faceAngle.y)
end

function adjust_turn_speed(m, turn_speed_factor)
    local turnSpeed = 0x600 * (m.forwardVel * 0.1)
    m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, turnSpeed, turnSpeed)
end

PACKET_UNLOCK = 0

function unlock_trophy(id)
	if network_is_server() then
		local trophy = trophyinfo[id]
		if trophy then
			mod_storage_save("file"..get_current_save_file_num()..trophy.name, "1")
			gGlobalSyncTable.trophystatus[id] = true
		end
	else network_send_to(1, true, {type = PACKET_UNLOCK, id = id}) end
end

hook_event(HOOK_ON_PACKET_RECEIVE, function (data)
	if data.type == PACKET_UNLOCK then
		unlock_trophy(data.id)
	end
end)

function delete_save(m)
	--[[
    for course = 0, 25 do
        save_file_remove_star_flags(get_current_save_file_num() - 1, course - 1, 0xFF)
    end
    save_file_clear_flags(0xFFFFFFFF)
    save_file_do_save(get_current_save_file_num() - 1, 1)
    m.numStars = save_file_get_total_star_count(get_current_save_file_num() - 1, COURSE_NONE, COURSE_MAX - 1)
	]]
	save_file_erase_current_backup_save()
end

function check_trophyplate(m, np, sound)
    local trophyplate = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvTrophyPlate)
    return np.currLevelNum == LEVEL_SECRETHUB and sound == CHAR_SOUND_PUNCH_YAH and obj_check_hitbox_overlap(m.marioObj, trophyplate)
end

local function has_any_behavior(obj, behaviors)
    for _, behavior_id in ipairs(behaviors) do
        if obj_has_behavior_id(obj, behavior_id) ~= 0 then
            return true
        end
    end
    return false
end
    
function handle_object_interaction(m, o)
    local behaviors = {
        id_bhvBigBoulder,
        id_bhvChainChomp,
        id_bhvPitBowlingBall,
        id_bhvBowlingBall,
        id_bhvSpindrift,
        id_bhvMrBlizzard,
        id_bhvHauntedChair,
        id_bhvWaterBomb
    }

    if m.hurtCounter > 0 and has_any_behavior(o, behaviors) then
        if m.action & ACT_FLAG_AIR > 0 then
            if m.action == ACT_DEATH_ON_STOMACH then return end

            if m.pos.y > m.floorHeight then
                local angle = obj_angle_to_object(m.marioObj, o)
                m.vel.x = m.vel.x + sins(o.oMoveAngleYaw) * o.oForwardVel / 2
                m.vel.z = m.vel.z + coss(o.oMoveAngleYaw) * o.oForwardVel / 2
                m.vel.y = 65

                m.marioObj.oFaceAngleYaw = angle
                m.marioObj.oMoveAngleYaw = angle

                spawn_mist_particles()
                play_sound(SOUND_ACTION_BOUNCE_OFF_OBJECT, m.marioObj.header.gfx.cameraToObject)
                set_mario_action(m, ACT_RAGDOLL, 0)
            end
        else
            if obj_has_behavior_id(o, id_bhvChainChomp) ~= 0 then
                -- Optionally handle Chain Chomp interaction here
                -- djui_chat_message_create("Doing nothing (you hit chain chomp and lost yer legs!!)")
            else
                m.squishTimer = 50
            end
        end
    end
end