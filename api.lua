--- @class GoreHMModels
--- @field public headless ModelExtendedId
--- @field public topless ModelExtendedId
--- @field public gold ModelExtendedId

local baseCharModels = {
    [CT_MARIO] = {
        headless = E_MODEL_HEADLESS_MARIO,
        topless = E_MODEL_TOPLESS_MARIO,
        gold = E_MODEL_GOLD_MARIO
    },
    [CT_LUIGI] = {
        headless = E_MODEL_HEADLESS_LUIGI,
        topless = E_MODEL_TOPLESS_LUIGI,
        gold = E_MODEL_GOLD_LUIGI
    },
    [CT_TOAD] = {
        headless = E_MODEL_HEADLESS_TOAD,
        topless = E_MODEL_TOPLESS_TOAD,
        gold = E_MODEL_GOLD_TOAD
    },
    [CT_WALUIGI] = {
        headless = E_MODEL_HEADLESS_WALUIGI,
        topless = E_MODEL_TOPLESS_WALUIGI,
        gold = E_MODEL_GOLD_WALUIGI
    },
    [CT_WARIO] = {
        headless = E_MODEL_HEADLESS_WARIO,
        topless = E_MODEL_TOPLESS_WARIO,
        gold = E_MODEL_GOLD_WARIO
    }
}
local goldModels = {}
local charModels = {}

_G.GoreHMApi = {
    register_character_models = function (models)
        -- work on later
    end,
    ---@param m MarioState
    ---@return GoreHMModels
    get_char_models = function (m)
        return charSelect and charSelect.nonexistent_function --[[ :( ]] or baseCharModels[m.character.type]
    end
}