local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Llama = require(ReplicatedStorage.Packages.Llama)

local Actions = require(ReplicatedStorage.Constants.Actions)

local function deckReducer(state, action)
	if action.type == Actions.removeCardFromDeck then
		assert(state[action.deckPosition], "attempt to remove nonexistent card")
		return Llama.List.removeIndex(state, action.deckPosition)
	end

	return state
end

return deckReducer