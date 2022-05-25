local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Selectors = require(ReplicatedStorage.Selectors)
local Actions = require(ReplicatedStorage.Constants.Actions)

local actions = ServerScriptService.Actions
local changePlayerDeck = require(actions.changePlayerDeck)
local setPlayerDeckPosition = require(actions.setPlayerDeckPosition)

local function removeCardFromDeck(matchId, playerId)
	return function(store)
		local deckPosition = Selectors.Deck.getPosition(matchId, playerId)
		store:dispatch(changePlayerDeck(matchId, playerId, {
			type = Actions.removeCardFromDeck;
			deckPosition = deckPosition;
			matchId = matchId;
			playerId = playerId;
		}))
		store:dispatch(setPlayerDeckPosition(matchId, playerId, deckPosition - 1))
	end
end

return removeCardFromDeck