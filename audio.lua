highmusic = audio_stream_load("high.mp3")
smwbonusmusic = audio_stream_load("smwbonusloop.mp3")
boss = audio_stream_load("croppedcastle.mp3")
musicHell = audio_stream_load("hell.mp3")
currentlyPlaying = nil

---@param a BassAudio
function stream_play(a)
	if currentlyPlaying then audio_stream_stop(currentlyPlaying) end
	audio_stream_play(a, true, 1)
	currentlyPlaying = a
end
function stream_stop_all()
	audio_stream_stop(highmusic)
	audio_stream_stop(smwbonusmusic)
	audio_stream_stop(boss)
	audio_stream_stop(musicHell)
	currentlyPlaying = nil
end
hook_event(HOOK_UPDATE, function ()
	if currentlyPlaying then
		audio_stream_set_volume(currentlyPlaying, is_game_paused() and 0.2 or 1)
	end
end)

gSamples = {
	audio_sample_load("bonebreak.mp3"),
	audio_sample_load("bigexplosion.mp3"),
	audio_sample_load("electricscream.mp3"),
	audio_sample_load("shock.mp3"),
	audio_sample_load("mariodeath.mp3"),
	audio_sample_load("angrymario.mp3"),
	audio_sample_load("flames.mp3"),
	audio_sample_load("killyoshi.mp3"),
	audio_sample_load("smwbonusend.mp3"),
	audio_sample_load("slip.mp3"),
	audio_sample_load("splash.mp3"),
	audio_sample_load("punch.mp3"),
	audio_sample_load("goomba.mp3"),
	audio_sample_load("agonymario.mp3"),
	audio_sample_load("cooloff.mp3"),
	audio_sample_load("thunder.mp3"),
	audio_sample_load("gslaser.mp3"),
	audio_sample_load("gsbeam.mp3"),
	audio_sample_load("crunch.mp3"),
	audio_sample_load("burp.mp3")
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
sSlip = 10
sSplash = 11
sPunch = 12
sGoombaStomp = 13
sAgonyMario = 14
sCoolOff = 15
sThunder = 16
sGslaser = 17
sGsbeam = 18
sCrunch = 19
sBurp = 20

function local_play(id, pos, vol)
	audio_sample_play(gSamples[id], pos, (is_game_paused() and 0 or vol))
end
function network_play(id, pos, vol, i)
    local_play(id, pos, vol)
    network_send(true, {id = id, x = pos.x, y = pos.y, z = pos.z, vol = vol, i = network_global_index_from_local(i)})
end

hook_event(HOOK_ON_PACKET_RECEIVE, function (data)
	if is_player_active(gMarioStates[network_local_index_from_global(data.i)]) ~= 0 then
		local_play(data.id, {x=data.x, y=data.y, z=data.z}, data.vol)
	end
end)