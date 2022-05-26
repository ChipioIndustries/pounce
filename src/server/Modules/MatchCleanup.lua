local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Store = require(ReplicatedStorage.Modules.Store)
local removeMatch = require(ServerScriptService.Actions.removeMatch)

local function matchCleanup(matches, _oldMatches)
	for matchId, match in pairs(matches) do
		local isMatchEmpty = true
		for _playerId, playerData in pairs(match.players) do
			if not playerData.quit then
				isMatchEmpty = false
			end
		end
		if isMatchEmpty then
			Store:dispatch(removeMatch(matchId))
		end
	end
end

Store:getValueChangedSignal("activeMatches"):connect(matchCleanup)

return matchCleanup