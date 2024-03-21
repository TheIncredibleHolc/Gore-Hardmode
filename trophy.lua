-------------------------TROPHY SYSTEM-------------------------

trophyinfo = {
	{ name = "smiler", model = E_MODEL_BACKROOM_SMILER },
	{ name = "mario", model = E_MODEL_MARIO },
	{ name = "luigi", model = E_MODEL_LUIGI }
}

---@param o Object
function trophy_load(o)
	local trophy = trophyinfo[o.oBehParams >> 24]

	-- Loads the status of each trophy on Secret Room entry.
	local trophyunlocked = mod_storage_load(trophy.name) == "1"

	-- Checks to see if trophy should display. (show if unlocked and display or locked and collectible)
	if trophyunlocked ~= (o.oBehParams & 1 == 0) then
		obj_set_model_extended(o, trophy.model)
	else
		obj_mark_for_deletion(o)
	end
end

-- Trophy display behavior. 
---@param o Object
function trophy_init(o)
	o.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
	o.header.gfx.skipInViewCheck = true

	obj_set_hitbox_radius_and_height(o, 40, 100)
	trophy_load(o)
end

---@param o Object
function trophy_loop(o)
	o.oAngleVelYaw = 500
	o.oFaceAngleYaw = o.oFaceAngleYaw + o.oAngleVelYaw

	if o.oBehParams & 1 == 0 then -- is a collectible
		local player = nearest_player_to_object(o)
		if obj_check_hitbox_overlap(o, player) then
			-- collect (spin, fly up and shrink, leaving a trail of sparkles behind)
		end
	end
end

id_bhvTrophy = hook_behavior(nil, OBJ_LIST_GENACTOR, true, trophy_init, trophy_loop, "bhvTrophy")