local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local changeMatch = require(ServerScriptService.Actions.changeMatch)

local function changePlayer(matchId, playerId, subAction)
	return changeMatch(matchId, {
		type = Actions.changePlayer;
		playerId = playerId;
		subAction = subAction;
	})
end

return changePlayer