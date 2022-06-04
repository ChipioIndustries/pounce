local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Selectors = require(ReplicatedStorage.Selectors)
local Store = require(ReplicatedStorage.Modules.Store)

local checks = ReplicatedStorage.Checks
local isMatchActive = require(checks.isMatchActive)
local isCardDescendingAndAlternating = require(checks.isCardDescendingAndAlternating)

--[[
	is the match active?
	did the user not try to move too many cards?
	if there's an existing card at the target, is it descending and alternating?
]]

local function moveCardsBetweenColumns(player, columnIndexA, columnIndexB, cardCount)
	player = player or Players.LocalPlayer

	local successActive, resultActive = isMatchActive(player)

	if not successActive then
		return successActive, resultActive
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

	local originCard = originColumn[#originColumn + 1 - cardCount]

	if targetCard then
		local successCardOrder, resultCardOrder = isCardDescendingAndAlternating(targetCard, originCard)

		if not successCardOrder then
			return successCardOrder, resultCardOrder
		end
	end

	return true
end

return moveCardsBetweenColumns