local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local setPlayerQuit = require(ServerScriptService.Actions.setPlayerQuit)

local check = require(ReplicatedStorage.Checks.Requests.quit)
local Selectors = require(ReplicatedStorage.Selectors)
local Store = require(ReplicatedStorage.Modules.Store)

local function quit(player)
	local valid, result = check(player)

	if valid then
		local playerId = tostring(player.UserId)
		local matchId = Selectors.getMatchIdByPlayerId(playerId)
		Store:dispatch(setPlayerQuit(matchId, playerId))
		return true
	end

	return valid, result
end

return quit