local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getMatchIdByUserId(userId, _matchesOverride)
	local matches = _matchesOverride or Store:getState().activeMatches
	for name, match in pairs(matches) do
		if match.players[userId] then
			return name
		end
	end
end

return getMatchIdByUserId