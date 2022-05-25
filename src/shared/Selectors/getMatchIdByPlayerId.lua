local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Store = require(ReplicatedStorage.Modules.Store)

local function getMatchIdByPlayerId(playerId, _matchesOverride)
	local matches = _matchesOverride or Store:getState().activeMatches
	-- TODO: initial state?
	print(Store:getState())
	for name, match in pairs(matches) do
		if match.players[playerId] then
			return name
		end
	end
end

return getMatchIdByPlayerId