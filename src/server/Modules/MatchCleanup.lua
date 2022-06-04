local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Store = require(ReplicatedStorage.Modules.Store)
local removeMatch = require(ServerScriptService.Actions.removeMatch)
local setPlayerQuit = require(ServerScriptService.Actions.setPlayerQuit)

local Selectors = require(ReplicatedStorage.Selectors)

-- delete matches where all players have quit
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

local function onPlayerRemoving(player)
	local playerId = tostring(player.UserId)
	local matchId = Selectors.getMatchIdByPlayerId(playerId)
	if matchId then
		Store:dispatch(setPlayerQuit(matchId, playerId))
	end
end

Store:getValueChangedSignal("activeMatches"):connect(matchCleanup)
Players.PlayerRemoving:Connect(onPlayerRemoving)

return matchCleanup