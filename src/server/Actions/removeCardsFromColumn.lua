local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local actions = ServerScriptService.Actions
local changePlayerColumn = require(actions.changePlayerColumn)

local function removeCardsFromColumn(matchId, playerId, columnIndex, cardCount)
	return changePlayerColumn(matchId, playerId, columnIndex, {
		type = Actions.removeCardsFromColumn;
		cardCount = cardCount;
	})
end

return removeCardsFromColumn