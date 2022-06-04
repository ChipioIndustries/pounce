local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getMatchIdByPlayerId(playerId, _matchesOverride)
	playerId = playerId or tostring(Players.LocalPlayer.UserId)
	local matches = _matchesOverride or Store:getState().activeMatches
	local lastQuitMatch
	for name, match in pairs(matches) do
		if match.players[playerId] then
			if match.players[playerId].quit then
				lastQuitMatch = name
			else
				return name
			end
		end
	end
	return lastQuitMatch
end

return getMatchIdByPlayerId