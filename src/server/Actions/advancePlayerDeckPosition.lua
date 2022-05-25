local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local actions = ServerScriptService.Actions
local changePlayer = require(actions.changePlayer)

local function advancePlayerDeckPosition(matchId, playerId)
	return changePlayer(matchId, playerId, {
		type = Actions.advancePlayerDeckPosition;
	})
end

return advancePlayerDeckPosition