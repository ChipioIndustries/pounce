local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local actions = ServerScriptService.Actions
local changePlayer = require(actions.changePlayer)

local function changePlayerStack(matchId, playerId, subAction)
	return changePlayer(matchId, playerId, {
		type = Actions.changePlayerStack;
		subAction = subAction;
	})
end

return changePlayerStack