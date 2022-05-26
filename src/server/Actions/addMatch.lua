local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

local function addMatch(playerIds)
	return {
		type = Actions.addMatch;
		playerIds = playerIds;
	}
end

return addMatch