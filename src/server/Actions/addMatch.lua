local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Modules.Actions)

local function addMatch(roundId)
	return {
		type = Actions.addMatch;
		roundId = roundId;
	}
end

return addMatch