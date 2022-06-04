local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Selectors = require(ReplicatedStorage.Selectors)
local Enums = require(ReplicatedStorage.Constants.Enums)
local Cards = require(ReplicatedStorage.Utilities.Cards)

local actions = ServerScriptService.Actions
local addCardToPile = require(actions.addCardToPile)
local addPile = require(actions.addPile)
local removeCardFromDeck = require(actions.removeCardFromDeck)
local removeCardFromStack = require(actions.removeCardFromStack)
local removeCardsFromColumn = require(actions.removeCardsFromColumn)

local function moveCardToPile(matchId, playerId, targetPileId, origin, columnIndex, pilePosition)
	return function(store)
		local playerData = store:getState().activeMatches[matchId].players[playerId]
		local suit
		-- remove card from the requested spot
		if origin == Enums.CardOrigin.Column then
			local column = playerData.pad[columnIndex]
			suit = Cards:getSuit(column[#column])
			store:dispatch(removeCardsFromColumn(matchId, playerId, columnIndex, 1))
		elseif origin == Enums.CardOrigin.Deck then
			suit = Cards:getSuit(Selectors.Deck.getTopCard(matchId, playerId))
			store:dispatch(removeCardFromDeck(matchId, playerId))
		elseif origin == Enums.CardOrigin.Stack then
			suit = Cards:getSuit(playerData.stack[#playerData.stack])
			store:dispatch(removeCardFromStack(matchId, playerId))
		end
		-- create a new pile or add to an existing one
		if not targetPileId then
			store:dispatch(addPile(matchId, playerId, suit, pilePosition))
		else
			store:dispatch(addCardToPile(matchId, targetPileId, playerId))
		end
	end
end

return moveCardToPile