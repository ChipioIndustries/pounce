local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Actions = require(constants.Actions)

local Llama = require(ReplicatedStorage.Packages.Llama)

local Cards = require(ReplicatedStorage.Utilities.Cards)

local function pileReducer(state, action)
	if action.type == Actions.addCardToPile then
		local keys = Llama.Dictionary.keys(state)
		assert(CONFIG.CardDecorators[#keys + 1], "attempt to add to full pile")
		-- any key can be used to grab the suit of the pile
		local suit = Cards:getSuit(keys[1])
		local playerId = tostring(action.playerId)
		return Llama.Dictionary.join(state, {
			[Cards:getSignature(suit, #keys + 1)] = playerId
		})
	end

	return state
end

return pileReducer