local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.CONFIG)

local Llama = require(ReplicatedStorage.Packages.Llama)

local modules = ReplicatedStorage.Modules
local Actions = require(modules.Actions)

local utilities = ReplicatedStorage.Utilities
local Cards = require(utilities.Cards)

local matchReducer = require(script.match)

local function activeMatchesReducer(state, action)
	if action.type == Actions.addMatch then
		local players = {}

		for _, player in ipairs(action.players) do
			local deck = Cards.shuffle()

			local stack = {}
			for _ = 1, CONFIG.StackSize do
				table.insert(stack, deck[#deck])
				deck[#deck] = nil
			end

			local pad = {}
			for index = 1, CONFIG.PadCount do
				pad[index] = { deck[#deck] }
				deck[#deck] = nil
			end

			local playerData = {
				deckPosition = 0,
				deck = deck,
				pad = pad,
				pounced = false,
				stack = stack,
			}

			players[tostring(player.UserId)] = playerData
		end

		return Llama.Dictionary.join(state, {
			[HttpService:GenerateGUID(false)] = {
				players = players,
				field = {}
			}
		})
	elseif action.type == Actions.changeMatch then
		return Llama.Dictionary.join(state, {
			[action.matchId] = matchReducer(state[action.matchId], action.subAction)
		})
	elseif action.type == Actions.removeMatch then
		return Llama.Dictionary.join(state, {
			[action.matchId] = Llama.None
		})
	end

	return state
end

return activeMatchesReducer