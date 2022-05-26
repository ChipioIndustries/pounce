local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local Deck = {}

function Deck.getPosition(matchId, playerId, _matchesOverride)
	playerId = playerId or tostring(Players.LocalPlayer.UserId)
	local matches = _matchesOverride or Store:getState().activeMatches

	return matches[matchId].players[tostring(playerId)].deckPosition
end

function Deck.getTopCard(matchId, playerId, _matchesOverride)
	playerId = playerId or tostring(Players.LocalPlayer.UserId)
	local matches = _matchesOverride or Store:getState().activeMatches
	local playerData = matches[matchId].players[tostring(playerId)]
	local deckPosition = playerData.deckPosition

	return playerData.deck[deckPosition]
end

return Deck