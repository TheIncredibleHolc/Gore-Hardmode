--Fog.
--Thanks Blocky.cmd !! :D

local E_MODEL_FOG = smlua_model_util_get_id("fog_geo")

local STATE_NORMAL = 0
local STATE_SAND = 1
local STATE_BLACK = 2
local STATE_GREEN = 3
local STATE_PURPLE = 4
local STATE_HAUNTED = 5
local STATE_FIRE = 6

local skyboxInfo = {
    [BACKGROUND_OCEAN_SKY]       = {anim = STATE_NORMAL , color = {r = 100, g = 147, b = 200}},
    [BACKGROUND_SNOW_MOUNTAINS]  = {anim = STATE_NORMAL , color = {r = 100, g = 147, b = 200}},
    [BACKGROUND_ABOVE_CLOUDS]    = {anim = STATE_NORMAL , color = {r = 100, g = 147, b = 200}},
    [BACKGROUND_BELOW_CLOUDS]    = {anim = STATE_NORMAL , color = {r = 100, g = 147, b = 200}},
    [BACKGROUND_UNDERWATER_CITY] = {anim = STATE_NORMAL , color = {r = 100, g = 147, b = 200}},
    [BACKGROUND_FLAMING_SKY]     = {anim = STATE_FIRE   , color = {r = 235, g = 080, b = 080}},
    [BACKGROUND_GREEN_SKY]       = {anim = STATE_GREEN  , color = {r = 104, g = 200, b = 148}},
    [BACKGROUND_HAUNTED]         = {anim = STATE_HAUNTED, color = {r = 113, g = 103, b = 238}},
    [BACKGROUND_DESERT]          = {anim = STATE_SAND   , color = {r = 171, g = 171, b = 116}},
    [BACKGROUND_PURPLE_SKY]      = {anim = STATE_PURPLE , color = {r = 147, g = 004, b = 199}},
    [BACKGROUND_CUSTOM]          = {anim = STATE_NORMAL , color = {r = 100, g = 100, b = 100}},
}

---@param o Object
local function fog_init(o)
    o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    o.header.gfx.skipInViewCheck = true
    o.oFaceAnglePitch = 0
    o.oFaceAngleRoll = 0
    o.oOpacity = 75
    obj_scale(o, 3.5)
    set_override_far(1000000)
end

---@param o Object
local function fog_loop(o)
    local m = gMarioStates[0]

    local skybox = get_skybox() --* in loop function in case mods change the skybox
    if skyboxInfo[skybox] then
        o.oAnimState = skyboxInfo[skybox].anim
    else
        o.oAnimState = STATE_BLACK
    end

    local r, g, b = 100, 100, 100

    if skybox >= 0 then
        r, g, b = skyboxInfo[skybox].color.r, skyboxInfo[skybox].color.g, skyboxInfo[skybox].color.b
    end

    -- check skybox to determine the color of the fog
    if skybox == BACKGROUND_CUSTOM then
        -- custom skybox, use terrain type instead
        if m.area.terrainType == TERRAIN_SAND then
            r, g, b = skyboxInfo[BACKGROUND_DESERT].color.r, skyboxInfo[BACKGROUND_DESERT].color.g, skyboxInfo[BACKGROUND_DESERT].color.b
        elseif m.area.terrainType == TERRAIN_SPOOKY then
            r, g, b = skyboxInfo[BACKGROUND_HAUNTED].color.r, skyboxInfo[BACKGROUND_HAUNTED].color.g, skyboxInfo[BACKGROUND_HAUNTED].color.b
        else
            r, g, b = 100, 100, 100
        end
    end

    set_lighting_color(0, r)
    set_lighting_color(1, g)
    set_lighting_color(2, b)
    set_vertex_color(0, r)
    set_vertex_color(1, g)
    set_vertex_color(2, b)
    set_fog_color(0, r)
    set_fog_color(1, g)
    set_fog_color(2, b)

    o.oPosX, o.oPosY, o.oPosZ = m.pos.x, m.pos.y, m.pos.z
    o.oFaceAngleYaw = m.faceAngle.y
end

---@param m MarioState
local function mario_update(m)
    np = gNetworkPlayers[0]
    if m.playerIndex ~= 0 then return end
    if np.currLevelNum == LEVEL_SL and np.currAreaIndex <= 1 then
        if not obj_get_first_with_behavior_id(id_bhvFog) then
            spawn_non_sync_object(id_bhvFog, E_MODEL_FOG, 0, 0, 0, nil)
        end
    elseif np.currLevelNum ~= LEVEL_HELL then
        set_lighting_color(0, 255)
        set_lighting_color(1, 255)
        set_lighting_color(2, 255)
        set_vertex_color(0, 255)
        set_vertex_color(1, 255)
        set_vertex_color(2, 255)
        set_fog_color(0, 255)
        set_fog_color(1, 255)
        set_fog_color(2, 255)
    end
end

id_bhvFog = hook_behavior(nil, OBJ_LIST_DEFAULT, false, fog_init, fog_loop)
hook_event(HOOK_MARIO_UPDATE, mario_update)