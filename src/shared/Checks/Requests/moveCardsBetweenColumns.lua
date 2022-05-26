local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Selectors = require(ReplicatedStorage.Selectors)
local Store = require(ReplicatedStorage.Modules.Store)

local checks = ReplicatedStorage.Checks
local isMatchActive = require(checks.isMatchActive)
local isCardDescendingAndAlternating = require(checks.isCardDescendingAndAlternating)

local function moveCardsBetweenColumns(player, columnIndexA, columnIndexB, cardCount)
	player = player or Players.LocalPlayer

	local success, result = isMatchActive(player)

	if not success then
		return success, result
	end

	local playerId = tostring(player.UserId)
	local matchId = Selectors.getMatchIdByPlayerId(playerId)
	local playerData = Store:getState().activeMatches[matchId].players[playerId]
	local targetColumn = playerData.pad[columnIndexB]
	local targetCard = targetColumn[#targetColumn]

	local originColumn = playerData.pad[columnIndexA]

	if #originColumn < cardCount then
		return false, CONFIG.Responses.TooManyCards
	end

	local originCard = originColumn[#originColumn] + 1 - cardCount

	if targetCard then
		local success, result = isCardDescendingAndAlternating(targetCard, originCard)

		if not success then
			return success, result
		end
	end

	return true
end

return moveCardsBetweenColumns