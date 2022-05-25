local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Llama = require(ReplicatedStorage.Packages.Llama)

local modules = ReplicatedStorage.Modules
local Actions = require(modules.Actions)

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
	elseif action.type == Actions.addField then
		return Llama.Dictionary.join(state, {
			[HttpService:GenerateGUID(false)] = {
				[Cards:getSignature(action.suit, 1)] = tostring(action.playerId)
			}
		})
	elseif action.type == Actions.changeField then
		return Llama.Dictionary.join(state, {
			[action.fieldId] = pileReducer(
				state[action.playerId],
				action.subAction
			)
		})
	end

	return state
end

return matchReducer