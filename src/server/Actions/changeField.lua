local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Constants.Actions)

local changeMatch = require(ServerScriptService.Actions.changeMatch)

local function changeField(matchId, pileId, subAction)
	return changeMatch(matchId, {
		type = Actions.changeField;
		pileId = pileId;
		subAction = subAction;
	})
end

return changeField