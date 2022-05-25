local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local actions = ServerScriptService.Actions
local changePlayer = require(actions.changePlayer)

local function setPlayerDeckPosition(matchId, playerId, position)
	return changePlayer(matchId, playerId, {
		type = Actions.setPlayerDeckPosition;
		position = position;
	})
end

return setPlayerDeckPosition