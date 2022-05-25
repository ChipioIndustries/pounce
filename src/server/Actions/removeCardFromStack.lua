local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Constants.Actions)

local actions = ServerScriptService.Actions
local changePlayerStack = require(actions.changePlayerStack)

local function removeCardFromStack(matchId, playerId)
	return changePlayerStack(matchId, playerId, {
		type = Actions.removeCardFromStack;
	})
end

return removeCardFromStack