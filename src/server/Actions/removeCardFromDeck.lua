local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Constants.Actions)

local actions = ServerScriptService.Actions
local changePlayerDeck = require(actions.changePlayerDeck)

local function removeCardFromDeck(matchId, playerId)
	return changePlayerDeck(matchId, playerId, {
		type = Actions.removeCardFromDeck;
		matchId = matchId;
		playerId = playerId;
	})
end

return removeCardFromDeck