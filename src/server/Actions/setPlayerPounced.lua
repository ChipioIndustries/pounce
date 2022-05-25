local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Constants.Actions)

local actions = ServerScriptService.Actions
local changePlayer = require(actions.changePlayer)

local function setPlayerPounced(matchId, playerId)
	return changePlayer(matchId, playerId, {
		type = Actions.setPlayerPounced;
	})
end

return setPlayerPounced