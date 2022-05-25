local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Selectors = require(ReplicatedStorage.Selectors)
local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Store = require(ReplicatedStorage.Modules.Store)

local function pounce(player)
	player = player or Players.LocalPlayer

	local playerId = tostring(player.UserId)
	local matchId = Selectors.getMatchIdByPlayerId(playerId)

	if not matchId then
		return false, CONFIG.Responses.NotInMatch
	end

	local players = Store:getState().activeMatches[matchId].players

	for _playerId, playerData in pairs(players) do
		if playerData.pounced then
			return false, CONFIG.Responses.GameAlreadyEnded
		end
	end

	return true
end

return pounce