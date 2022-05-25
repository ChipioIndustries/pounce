local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local actions = ServerScriptService.Actions
local changePlayerColumn = require(actions.changePlayerColumn)

local function addCardsToColumn(matchId, playerId, columnIndex, ...)
	local suits = {...}
	return changePlayerColumn(matchId, playerId, columnIndex, {
		type = Actions.addCardsToColumn;
		suits = suits;
	})
end

return addCardsToColumn