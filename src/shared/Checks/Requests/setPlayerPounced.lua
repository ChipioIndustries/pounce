local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Selectors = require(ReplicatedStorage.Selectors)
local Store = require(ReplicatedStorage.Modules.Store)
local check = require(ReplicatedStorage.Checks.isMatchActive)

local function pounce(player)
	player = player or Players.LocalPlayer

	local success, result = check(player)

	if not success then
		return success, result
	end

	local playerId = tostring(player.UserId)
	local matchId = Selectors.getMatchIdByPlayerId(playerId)
	local playerData = Store:getState().activeMatches[matchId].players[playerId]

	if #playerData.stack > 0 then
		return false, CONFIG.Responses.StackNotCleared
	end

	return true
end

return pounce