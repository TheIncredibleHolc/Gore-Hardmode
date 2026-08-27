warpUtils = {}

local npl = gNetworkPlayers

local sWarpTable = {}
local sWarpObjs  = {}
local sActiveWarp = nil

local WARP_DURATION = 25

local WARP_STATE_FADING   = 0
local WARP_STATE_WARPING = 1

local sWarpInteractions = {
    [INTERACT_WARP] = ACT_DISAPPEARED,
}

function warpUtils.newWarpNode(level, area, node, targetLevel, targetArea, targetNode, entryFunc, exitFunc, overrideVanilla)
    sWarpTable[level]                   = sWarpTable[level] or {}
    sWarpTable[level][area]             = sWarpTable[level][area] or {}
    sWarpTable[level][area][node]       = sWarpTable[level][area][node] or {}

    local warp = sWarpTable[level][area][node]
    warp.level           = level
    warp.area            = area
    warp.node            = node
    warp.targetLevel     = targetLevel
    warp.targetArea      = targetArea
    warp.targetNode      = targetNode
    warp.overrideVanilla = overrideVanilla
    warp.entryFunc       = entryFunc
    warp.exitFunc        = exitFunc
    return warp
end

function warpUtils.createWarpObj(bhv, model, node, spawnFunc, level, area, pos, angle)
    sWarpObjs[level]             = sWarpObjs[level] or {}
    sWarpObjs[level][area]       = sWarpObjs[level][area] or {}
    sWarpObjs[level][area][node] = sWarpObjs[level][area][node] or {}

    local warpObj = sWarpObjs[level][area][node]
    angle = angle or {}
    warpObj.bhv       = bhv
    warpObj.model     = model
    warpObj.spawnFunc = spawnFunc
    warpObj.pos       = pos or {0, 0, 0}
    warpObj.angle     = { angle[1] or 0, angle[2] or 0, angle[3] or 0 }
    warpObj.node      = node
    warpObj.index     = node
    return warpObj
end

local function get_lvl_warp_objs(level, area)
    return sWarpObjs[level] and sWarpObjs[level][area]
end

function warpUtils.getWarp(level, area, warpnodeID)
    return sWarpTable[level] and sWarpTable[level][area] and sWarpTable[level][area][warpnodeID]
end

local function get_exit_warp_obj(level, area, targetNode)
    local outObj = get_lvl_warp_objs(level, area)
    outObj = outObj and outObj[targetNode]

    for objList = 0, NUM_OBJ_LISTS - 1 do
        local o = obj_get_first(objList)
        while o ~= nil do
            local warpnodeID = (o.oBehParams >> 16) & 0xFF
            if warpnodeID == targetNode and sWarpInteractions[o.oInteractType] then

                if not outObj or o.behavior == get_behavior_from_id(outObj.bhv) then
                    return o
                end
            end
            o = obj_get_next(o)
        end
    end
    return nil
end

local function set_behavior_param(o, index, value)
    local shift = (4 - index) * 8
    local mask  = ~(0xFF << shift)
    o.oBehParams = (o.oBehParams & mask) | ((value & 0xFF) << shift)
end

function warpUtils.deleteWarpObj(level, area, node)
    local removedSomething = false

    local exitObj = get_exit_warp_obj(node)
    if exitObj then
        obj_mark_for_deletion(exitObj)
    end

    local objs = get_lvl_warp_objs(level, area)
    if objs and objs[node] then
        objs[node] = nil
        removedSomething = true
    end

    if sWarpTable[level] and sWarpTable[level][area] and sWarpTable[level][area][node] then
        sWarpTable[level][area][node] = nil
        removedSomething = true
    end

    return removedSomething
end

local function allow_interact(m, o, int)
    if m.playerIndex ~= 0 then return end
    if not sWarpInteractions[int] then return end

    local level = npl[0].currLevelNum
    local area  = npl[0].currAreaIndex
    local warpnodeID = (o.oBehParams >> 16) & 0xFF
    local customNode = warpUtils.getWarp(level, area, warpnodeID)
    if not customNode then return end

    local vanillaNodeData = area_get_warp_node_from_params(o)
    local vanillaNode = vanillaNodeData and vanillaNodeData.node

    if vanillaNode and not customNode.overrideVanilla then
        return true
    end

    if customNode.entryFunc then
        customNode.entryFunc(m, o)
    end

    local targetAction = sWarpInteractions[int]
    if m.action ~= targetAction then
        m.interactObj = o
        play_transition(WARP_TRANSITION_FADE_INTO_CIRCLE, WARP_DURATION, 0, 0, 0)
        set_mario_action(m, targetAction, 0)

        customNode.timer = WARP_DURATION
        customNode.entryObj = o
        customNode.state = WARP_STATE_FADING
        sActiveWarp = customNode
    end
    return false
end

local function spawn_missing_warp_objs(level, area)
    local warps = get_lvl_warp_objs(level, area)
    if not warps then return end
    for _, obj in pairs(warps) do
        if get_exit_warp_obj(level, area, obj.node) then

        else
            spawn_non_sync_object(obj.bhv, obj.model, obj.pos[1], obj.pos[2], obj.pos[3], function(o)
                set_behavior_param(o, 2, obj.node)
                obj_set_angle(o, obj.angle[1], obj.angle[2], obj.angle[3])
                if obj.spawnFunc then obj.spawnFunc(o) end
            end)
        end
    end
end

local function finish_warp(m)
    sActiveWarp = nil
    play_transition(WARP_TRANSITION_FADE_FROM_CIRCLE, 15, 0, 0, 0)
end

local function update()
    local level = npl[0].currLevelNum
    local area  = npl[0].currAreaIndex
    local m     = gMarioStates[0]

    if m.marioObj then
        spawn_missing_warp_objs(level, area)
    end

    if not sActiveWarp then return end

    set_mario_action(m, ACT_UNINITIALIZED, 0)

    if sActiveWarp.state == WARP_STATE_FADING then
        sActiveWarp.timer = sActiveWarp.timer - 1
        if sActiveWarp.timer > 0 then return end

        local newLevel = sActiveWarp.targetLevel

        if newLevel ~= level then
            warp_to_level(newLevel, 1, npl[0].currActNum)
        end

        sActiveWarp.state = WARP_STATE_WARPING
        sActiveWarp.timer = WARP_DURATION
        return
    end

    if sActiveWarp.state == WARP_STATE_WARPING then
        local newArea = sActiveWarp.targetArea
        smlua_level_util_change_area(newArea)

        local exitObj = get_exit_warp_obj(sActiveWarp.targetLevel, newArea, sActiveWarp.targetNode)
        sActiveWarp.timer = sActiveWarp.timer - 1

        if not exitObj then
            if sActiveWarp.timer <= -60 then
                djui_chat_message_create("oh my fucking god theres no exit object for node "..tostring(sActiveWarp.targetNode))
                finish_warp(m)
            end
            return
        end

        if m.area and m.area.camera then
            reset_camera(m.area.camera)
        end

        m.pos.x = exitObj.oPosX
        m.pos.y = exitObj.oPosY
        m.pos.z = exitObj.oPosZ
        m.faceAngle.y = exitObj.oFaceAngleYaw

        local exitWarp = warpUtils.getWarp(sActiveWarp.targetLevel, sActiveWarp.targetArea, sActiveWarp.targetNode)
        if exitWarp and exitWarp.exitFunc then
            exitWarp.exitFunc(m, exitObj)
        end

        finish_warp(m)
    end
end

local function on_hud_render()
    if not sActiveWarp then return end
    if sActiveWarp.state ~= WARP_STATE_WARPING then return end
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_color(0, 0, 0, 255)
    djui_hud_render_rect(0, 0, djui_hud_get_screen_width() + 1, djui_hud_get_screen_height())
end

hook_event(HOOK_ON_HUD_RENDER, on_hud_render)
hook_event(HOOK_ALLOW_INTERACT, allow_interact)
hook_event(HOOK_UPDATE, update)

return warpUtils