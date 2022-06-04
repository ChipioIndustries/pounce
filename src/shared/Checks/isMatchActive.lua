local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Selectors = require(ReplicatedStorage.Selectors)
local Store = require(ReplicatedStorage.Modules.Store)
local check = require(ReplicatedStorage.Checks.playerInMatch)

--[[
	is the player in a match?
	has the match ended?
]]

local function isMatchActive(player)
	local success, result = check(player)

	if not success then
		return success, result
	end

	local playerId = tostring(player.UserId)
	local matchId = Selectors.getMatchIdByPlayerId(playerId)

	local players = Store:getState().activeMatches[matchId].players

	for _playerId, playerData in pairs(players) do
		if playerData.pounced then
			return false, CONFIG.Responses.GameAlreadyEnded
		end
	end

	return true
end

return isMatchActive