highmusic = audio_stream_load("high.ogg")
smwbonusmusic = audio_stream_load("smwbonusloop.ogg")   audio_stream_set_looping(smwbonusmusic, true)
boss = audio_stream_load("croppedcastle.ogg")
backroomMusic = audio_stream_load("backroom.ogg")		audio_stream_set_looping(backroomMusic, true)
musicHell = audio_stream_load("hell.ogg") 				audio_stream_set_looping(musicHell, true)
secret = audio_stream_load("secret.ogg") 				audio_stream_set_looping(secret, true)
musicUnderground = audio_stream_load("underground.ogg")	audio_stream_set_looping(musicUnderground, true)
musicbows2 = audio_stream_load("bows2loop.ogg")         audio_stream_set_looping(musicbows2, true)
timeattack = audio_stream_load("timeattack.ogg")
edils = audio_stream_load("edils.ogg")					audio_stream_set_looping(edils, true)

currentlyPlaying = nil
local fadeTimer = 0
local fadePeak = 0
local volume = 1

---@param a BassAudio
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
	audio_sample_load("trophy.ogg"),
	audio_sample_load("agonyluigi.ogg"),
	audio_sample_load("burp.ogg"),
	audio_sample_load("bows2intro.ogg"),
	audio_sample_load("agonywario.ogg"),
	audio_sample_load("dorriebackbreak.ogg"),
	audio_sample_load("smwping.ogg")
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
sTrophy = 26
sAgonyLuigi = 27
sBurp = 28
sBows2intro = 29
sAgonyWario = 30
sDorrie = 31
sSmwping = 32

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