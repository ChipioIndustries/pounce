local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Llama = require(ReplicatedStorage.Packages.Llama)

local Actions = require(ReplicatedStorage.Constants.Actions)

local Cards = require(ReplicatedStorage.Utilities.Cards)

local playerReducer = require(script.player)
local pileReducer = require(script.pile)

local function matchReducer(state, action)
	if action.type == Actions.changePlayer then
		return Llama.Dictionary.join(state, {
			[action.playerId] = playerReducer(
				state[action.playerId],
				action.subAction
			)
		})
	elseif action.type == Actions.addPile then
		return Llama.Dictionary.join(state, {
			[HttpService:GenerateGUID(false)] = {
				cards = {
					[Cards:getSignature(action.suit, 1)] = tostring(action.playerId)
				},
				position = action.position
			}
		})
	elseif action.type == Actions.changeField then
		return Llama.Dictionary.join(state, {
			[action.pileId] = Llama.Dictionary.join(state[action.pileId], {
				cards = pileReducer(
					state[action.pileId].cards,
					action.subAction
				)
			})
		})
	end

	return state
end

return matchReducer