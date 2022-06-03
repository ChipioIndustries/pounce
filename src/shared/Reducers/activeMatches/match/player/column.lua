local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local Actions = require(constants.Actions)

local Llama = require(ReplicatedStorage.Packages.Llama)

local Cards = require(ReplicatedStorage.Utilities.Cards)

local function columnReducer(state, action)
	if action.type == Actions.addCardsToColumn then
		local newCards = {}
		local lastValue
		if #state == 0 then
			lastValue = Cards:getValue(action.cards[1]) + 1
		else
			lastValue = Cards:getValue(state[#state])
		end

		local suits = {}
		for _, card in ipairs(action.cards) do
			table.insert(suits, Cards:getSuit(card))
		end

		for _, suit in ipairs(suits) do
			lastValue -= 1
			assert(lastValue > 0, "attempt to add too many cards")
			table.insert(newCards, Cards:getSignature(suit, lastValue))
		end

		return Llama.List.push(state, unpack(newCards))
	elseif action.type == Actions.removeCardsFromColumn then
		assert(
			not action.cardCount or #state >= action.cardCount,
			"attempt to remove nonexistent card"
		)
		return Llama.List.pop(state, action.cardCount)
	end

	return state
end

return columnReducer