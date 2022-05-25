local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local actions = ServerScriptService.Actions
local changePlayer = require(actions.changePlayer)

local function changePlayerColumn(matchId, playerId, columnIndex, subAction)
	return changePlayer(matchId, playerId, {
		type = Actions.changePlayerColumn;
		columnIndex = columnIndex;
		subAction = subAction;
	})
end

return changePlayerColumn