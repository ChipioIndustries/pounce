local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Actions = require(constants.Actions)

local Llama = require(ReplicatedStorage.Packages.Llama)

local Cards = require(ReplicatedStorage.Utilities.Cards)

local function pileReducer(state, action)
	if action.type == Actions.addCardToPile then
		assert(CONFIG.CardDecorators[#state + 1], "attempt to add to full pile")
		-- any key can be used to grab the suit of the pile
		local suit = Cards:getSuit(state[#state].signature)
		local playerId = tostring(action.playerId)
		return Llama.List.push(state, {
			playerId = playerId;
			signature = Cards:getSignature(suit, #state + 1);
		})
	end

	return state
end

return pileReducer