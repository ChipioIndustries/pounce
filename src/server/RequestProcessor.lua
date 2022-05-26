local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ServerScriptService.Actions)
local Remotes = require(ReplicatedStorage.Packages.Remotes)
local RequestChecks = require(ReplicatedStorage.Checks.Requests)
local Selectors = require(ReplicatedStorage.Selectors)
local Store = require(ReplicatedStorage.Modules.Store)
local RequestProcessors = {}

for requestName, requestCheck in pairs(RequestChecks) do
	local remote = Remotes:getFunctionAsync(requestName)

	local function processRequest(...)
		local success, result = requestCheck(...)

		if success then
			local arguments = {...}
			local playerId = tostring(arguments[1].UserId)
			local matchId = Selectors.getMatchIdByPlayerId(playerId)
			Store:dispatch(Actions[requestName](matchId, playerId, unpack(arguments, 2)))
			return true
		end

		return success, result
	end

	remote.OnServerInvoke = processRequest
	RequestProcessors[requestName] = processRequest
end

return RequestProcessors