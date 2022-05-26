local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getMatchByPlayerId(playerId, _matchesOverride)
	playerId = playerId or tostring(Players.LocalPlayer.UserId)
	local matches = _matchesOverride or Store:getState().activeMatches
	for _, match in pairs(matches) do
		if match.players[playerId] then
			return match
		end
	end
	return nil
end

return getMatchByPlayerId