local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Constants.Actions)

local changeMatch = require(ServerScriptService.Actions.changeMatch)

local function addPile(matchId, playerId, suit, position)
	return changeMatch(matchId, {
		type = Actions.addPile;
		pileId = HttpService:GenerateGUID(false);
		playerId = playerId;
		suit = suit;
		position = position;
	})
end

return addPile