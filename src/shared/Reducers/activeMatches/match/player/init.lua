local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.CONFIG)

local Llama = require(ReplicatedStorage.Packages.Llama)

local modules = ReplicatedStorage.Modules
local Actions = require(modules.Actions)

local Selectors = require(ReplicatedStorage.Selectors)

local stackReducer = require(script.stack)
local columnReducer = require(script.column)
local deckReducer = require(script.deck)

local function playerReducer(state, action)
	if action.type == Actions.changePlayerStack then
		return Llama.Dictionary.join(state, {
			stack = stackReducer(state.stack, action.subAction)
		})
	elseif action.type == Actions.changePlayerColumn then
		return Llama.Dictionary.join(state, {
			pad = Llama.List.set(
				state.pad,
				action.columnIndex,
				columnReducer(
					state.pad[action.columnIndex],
					action.subAction
				)
			)
		})
	elseif action.type == Actions.changePlayerDeck then
		return Llama.Dictionary.join(state, {
			deck = deckReducer(state.deck, action.subAction)
		})
	elseif action.type == Actions.advancePlayerDeckPosition then
		local nextDeckPosition = state.deckPosition + CONFIG.DeckViewableCardsCount
		if nextDeckPosition > #state.deck then
			nextDeckPosition = 0
		end
		return Llama.Dictionary.join(state, {
			deckPosition = nextDeckPosition
		})
	elseif action.type == Actions.setPlayerDeckPosition then
		local position = if #state.deck < action.position then action.position else #state.deck
		return Llama.Dictionary.join(state, {
			deckPosition = position
		})
	elseif action.type == Actions.setPlayerPounced then
		return Llama.Dictionary.join(state, {
			-- player can't pounce if someone else beat them to it
			pounced = if not Selectors.getIsMatchFinished(action.matchId) then true else false
		})
	elseif action.type == Actions.setPlayerQuit then
		return Llama.Dictionary.join(state, {
			quit = true
		})
	end

	return state
end

return playerReducer