local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

local RNG = Random.new()

local function addMatch(matchId, playerIds)
	return {
		type = Actions.addMatch;
		matchId = matchId;
		playerIds = playerIds;
		seed = RNG:NextNumber();
	}
end

return addMatch