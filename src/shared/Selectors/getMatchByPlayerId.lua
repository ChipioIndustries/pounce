local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getMatchByPlayerId(playerId, _matchesOverride)
	playerId = playerId or tostring(Players.LocalPlayer.UserId)
	local matches = _matchesOverride or Store:getState().activeMatches
	local lastQuitMatch
	for _, match in pairs(matches) do
		if match.players[playerId] then
			if match.players[playerId].quit then
				lastQuitMatch = match
			else
				return match
			end
		end
	end
	return lastQuitMatch
end

return getMatchByPlayerId