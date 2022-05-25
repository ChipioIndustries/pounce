local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Modules.Actions)

local function changeMatch(matchId, subAction)
	return {
		type = Actions.changeMatch;
		matchId = matchId;
		subAction = subAction;
	}
end

return changeMatch