local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Constants.Actions)

local actions = ServerScriptService.Actions
local changePlayerColumn = require(actions.changePlayerColumn)

local function addCardsToColumn(matchId, playerId, columnIndex, ...)
	local cards = {...}
	return changePlayerColumn(matchId, playerId, columnIndex, {
		type = Actions.addCardsToColumn;
		cards = cards;
	})
end

return addCardsToColumn