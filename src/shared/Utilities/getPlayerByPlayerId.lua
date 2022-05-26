local Players = game:GetService("Players")

local function getPlayerByPlayerId(playerId)
	local userId = tonumber(playerId)
	return Players:GetPlayerByUserId(userId)
end

return getPlayerByPlayerId