local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getDeckPosition(matchId, playerId, _matchesOverride)
	local matches = _matchesOverride or Store:getState().activeMatches

	return matches[matchId].players[tostring(playerId)].deckPosition
end

return getDeckPosition