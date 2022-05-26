local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getMatchWinner(matchId, _matchOverride)
	local match = _matchOverride or Store:getState().activeMatches[matchId]
	for playerId, player in pairs(match.players) do
		if player.pounced then
			return playerId
		end
	end

	return false
end

return getMatchWinner