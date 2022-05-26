local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getMatchIdByPlayerId(playerId, _matchesOverride)
	playerId = playerId or tostring(Players.LocalPlayer.UserId)
	local matches = _matchesOverride or Store:getState().activeMatches
	for name, match in pairs(matches) do
		if match.players[playerId] then
			return name
		end
	end
	return nil
end

return getMatchIdByPlayerId