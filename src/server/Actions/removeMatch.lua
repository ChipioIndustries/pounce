local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Modules.Actions)

local function removeMatch(players)
	return {
		type = Actions.removeMatch;
		players = players;
	}
end

return removeMatch