local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getIsPlayerWaiting(playerId, _matchesOverride)
	local matches = _matchesOverride or Store:getState().activeMatches
	for _matchId, match in pairs(matches) do
		if match.players[playerId] and not match.players[playerId].quit then
			return false
		end
	end

	return true
end

return getIsPlayerWaiting