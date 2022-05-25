local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local changeMatch = require(ServerScriptService.Actions.changeMatch)

local function addPile(matchId, playerId, suit, position)
	return changeMatch(matchId, {
		type = Actions.addPile;
		playerId = playerId;
		suit = suit;
		position = position;
	})
end

return addPile