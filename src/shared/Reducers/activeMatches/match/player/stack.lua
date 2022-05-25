local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Llama = require(ReplicatedStorage.Packages.Llama)

local Actions = require(ReplicatedStorage.Constants.Actions)

local function stackReducer(state, action)
	if action.type == Actions.removeCardFromStack then
		assert(#state > 0, "attempt to remove nonexistent card")
		return Llama.List.pop(state)
	end

	return state
end

return stackReducer