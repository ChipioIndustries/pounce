local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Llama = require(ReplicatedStorage.Packages.Llama)
local Cards = require(ReplicatedStorage.Utilities.Cards)

local actions = ServerScriptService.Actions
local addCardsToColumn = require(actions.addCardsToColumn)
local removeCardsFromColumn = require(actions.removeCardsFromColumn)

local function moveCardsBetweenColumns(matchId, playerId, columnIndexA, columnIndexB, cardCount)
	return function(store)
		local playerColumns = store:getState().activeMatches[matchId].players[playerId].pad
		local columnA = playerColumns[columnIndexA]
		local cards = Llama.List.slice(columnA, #columnA - cardCount + 1)

		store:dispatch(removeCardsFromColumn(matchId, playerId, columnIndexA, cardCount))
		store:dispatch(addCardsToColumn(matchId, playerId, columnIndexB, unpack(cards)))
	end
end

return moveCardsBetweenColumns