local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Selectors = require(ReplicatedStorage.Selectors)
local Enums = require(ReplicatedStorage.Constants.Enums)
local Llama = require(ReplicatedStorage.Packages.Llama)

local actions = ServerScriptService.Actions
local addCardsToColumn = require(actions.addCardsToColumn)
local removeCardFromStack = require(actions.removeCardFromStack)
local removeCardFromDeck = require(actions.removeCardFromDeck)

local function moveCardToColumn(matchId, playerId, columnIndex, origin)
	return function(store)
		local playerData = store:getState().activeMatches[matchId].players[playerId]
		local card
		-- remove card from the requested spot
		if origin == Enums.CardOrigin.Deck then
			card = Selectors.Deck.getTopCard(matchId, playerId)
			store:dispatch(removeCardFromDeck(matchId, playerId))
		elseif origin == Enums.CardOrigin.Stack then
			card = Llama.List.last(playerData.stack)
			store:dispatch(removeCardFromStack(matchId, playerId))
		else
			error("invalid origin")
		end
		store:dispatch(addCardsToColumn(matchId, playerId, columnIndex, card))
	end
end

return moveCardToColumn