local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

local function addMatch(matchId, playerIds)
	return {
		type = Actions.addMatch;
		matchId = matchId;
		playerIds = playerIds;
		seed = tick() % 1237;
	}
end

return addMatch