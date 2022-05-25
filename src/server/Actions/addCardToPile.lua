local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Modules.Actions)

local actions = ServerScriptService.Actions
local changeField = require(actions.changeField)

local function addCardToPile(matchId, pileId, playerId)
	return changeField(matchId, pileId, {
		type = Actions.addCardToPile;
		pileId = pileId;
		playerId = playerId;
	})
end

return addCardToPile