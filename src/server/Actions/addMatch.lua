local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

local function addMatch(players)
	return {
		type = Actions.addMatch;
		players = players;
	}
end

return addMatch