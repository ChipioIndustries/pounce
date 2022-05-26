local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)
local Selectors = require(ReplicatedStorage.Selectors)
local Store = require(ReplicatedStorage.Modules.Store)
local Cards = require(ReplicatedStorage.Utilities.Cards)

local checks = ReplicatedStorage.Checks
local isMatchActive = require(checks.isMatchActive)
local isCardAscendingAndSameSuit = require(checks.isCardAscendingAndSameSuit)
local isPilePositionOk = require(checks.isPilePositionOk)

local function moveCardToPile(player, targetPileId, origin, columnIndex, pilePosition)
	player = player or Players.LocalPlayer

	local success, result = isMatchActive(player)

	if not success then
		return success, result
	end

	local playerId = tostring(player.UserId)
	local matchId = Selectors.getMatchIdByPlayerId(playerId)
	local matchData = Store:getState().activeMatches[matchId]
	local playerData = matchData.players[playerId]
	local originCard

	if origin == Enums.CardOrigin.Column then
		local column = playerData.pad[columnIndex]
		originCard = column[#column]
	elseif origin == Enums.CardOrigin.Deck then
		originCard = Selectors.Deck.getTopCard(matchId, playerId)
	elseif origin == Enums.CardOrigin.Stack then
		originCard = playerData.stack[#playerData.stack]
	end

	if not originCard then
		return false, CONFIG.Responses.NoCard
	end

	if targetPileId then
		-- existing pile
		local pile = matchData.field[targetPileId]
		local topCard = pile[#pile]

		success, result = isCardAscendingAndSameSuit(topCard, originCard)

		if not success then
			return success, result
		end
	else
		-- new pile
		if Cards:getValue(originCard) ~= 1 then
			return false, CONFIG.Responses.PileStartRequiresAce
		end

		success, result = isPilePositionOk(matchId, pilePosition)

		if not success then
			return success, result
		end
	end

	return true
end

return moveCardToPile