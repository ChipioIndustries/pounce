local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Llama = require(ReplicatedStorage.Packages.Llama)

local modules = ReplicatedStorage.Modules
local Actions = require(modules.Actions)

local Selectors = require(ReplicatedStorage.Selectors)

local function deckReducer(state, action)
	if action.type == Actions.removeCardFromDeck then
		local deckPosition = Selectors.getDeckPosition(action.matchId, action.playerId)
		assert(state[deckPosition], "attempt to remove nonexistent card")
		return Llama.List.removeIndex(state, deckPosition)
	end

	return state
end

return deckReducer