local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

local function removeMatch(matchId)
	return {
		type = Actions.removeMatch;
		matchId = matchId;
	}
end

return removeMatch