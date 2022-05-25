local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Selectors = require(ReplicatedStorage.Selectors)

local function quit(player)
	player = player or Players.LocalPlayer

	local playerId = tostring(player.UserId)
	local matchId = Selectors.getMatchIdByPlayerId(playerId)

	if matchId then
		return true
	end

	return false, CONFIG.Responses.NotInMatch
end

return quit