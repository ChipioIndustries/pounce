local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Constants.Actions)

local actions = ServerScriptService.Actions
local changePlayer = require(actions.changePlayer)

local function setPlayerQuit(matchId, playerId)
	return changePlayer(matchId, playerId, {
		type = Actions.setPlayerQuit;
	})
end

return setPlayerQuit