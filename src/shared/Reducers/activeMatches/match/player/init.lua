local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Actions = require(constants.Actions)

local Llama = require(ReplicatedStorage.Packages.Llama)

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
		if state.deckPosition == #state.deck then
			nextDeckPosition = 0
		elseif nextDeckPosition > #state.deck then
			nextDeckPosition = #state.deck
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
			pounced = true
		})
	elseif action.type == Actions.setPlayerQuit then
		return Llama.Dictionary.join(state, {
			quit = true
		})
	end

	return state
end

return playerReducer