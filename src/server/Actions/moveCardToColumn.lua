local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Selectors = require(ReplicatedStorage.Selectors)
local Enums = require(ReplicatedStorage.Constants.Enums)
local Cards = require(ReplicatedStorage.Utilities.Cards)
local Llama = require(ReplicatedStorage.Packages.Llama)

local actions = ServerScriptService.Actions
local addCardsToColumn = require(actions.addCardsToColumn)
local removeCardFromStack = require(actions.removeCardFromStack)
local removeCardFromDeck = require(actions.removeCardFromDeck)

local function moveCardToColumn(matchId, playerId, columnIndex, origin)
	return function(store)
		local playerData = store:getState().activeMatches[matchId].players[playerId]
		local cardSuit
		if origin == Enums.CardOrigin.Deck then
			cardSuit = Cards:getSuit(Selectors.Deck.getTopCard(matchId, playerId))
			store:dispatch(removeCardFromDeck(matchId, playerId))
		elseif origin == Enums.CardOrigin.Stack then
			cardSuit = Cards:getSuit(Llama.List.last(playerData.stack))
			store:dispatch(removeCardFromStack(matchId, playerId))
		else
			error("invalid origin")
		end
		store:dispatch(addCardsToColumn(matchId, playerId, columnIndex, cardSuit))
	end
end

return moveCardToColumn