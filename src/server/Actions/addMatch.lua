local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

-- TODO: make this random on studio playtest
local RNG = Random.new(123.5)

local function addMatch(matchId, playerIds)
	return {
		type = Actions.addMatch;
		matchId = matchId;
		playerIds = playerIds;
		seed = RNG:NextInteger(1, 100);
	}
end

return addMatch