local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Modules.Actions)

local function changeMatch(players, subAction)
	return {
		type = Actions.changeMatch;
		players = players;
		subAction = subAction;
	}
end

return changeMatch