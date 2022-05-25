local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getIsMatchFinished(matchId, _matchOverride)
	local match = _matchOverride or Store:getState().activeMatches[matchId]
	for _playerId, player in pairs(match.players) do
		if player.pounced then
			return true
		end
	end

	return false
end

return getIsMatchFinished