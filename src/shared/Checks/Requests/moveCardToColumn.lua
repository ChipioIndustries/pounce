local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)
local Selectors = require(ReplicatedStorage.Selectors)
local Store = require(ReplicatedStorage.Modules.Store)

local checks = ReplicatedStorage.Checks
local isMatchActive = require(checks.isMatchActive)
local isCardDescendingAndAlternating = require(checks.isCardDescendingAndAlternating)

local function moveCardToColumn(player, columnIndex, origin)
	player = player or Players.LocalPlayer

	local success, result = isMatchActive(player)

	if not success then
		return success, result
	end

	local playerId = tostring(player.UserId)
	local matchId = Selectors.getMatchIdByPlayerId(playerId)
	local playerData = Store:getState().activeMatches[matchId].players[playerId]
	local column = playerData.pad[columnIndex]
	local bottomCard = column[#column]
	local topCard

	if origin == Enums.CardOrigin.Deck then
		topCard = Selectors.Deck.getTopCard(matchId, playerId)
	elseif origin == Enums.CardOrigin.Stack then
		topCard = playerData.stack[#playerData.stack]
	else
		return false, CONFIG.Responses.InvalidOrigin
	end

	if not topCard then
		return false, CONFIG.Responses.NoCard
	end

	if bottomCard then
		success, result = isCardDescendingAndAlternating(bottomCard, topCard)

		if not success then
			return success, result
		end
	end

	return true
end

return moveCardToColumn