local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Actions = require(ReplicatedStorage.Constants.Actions)

local actions = ServerScriptService.Actions
local changePlayer = require(actions.changePlayer)
local removeMatch = require(actions.removeMatch)

local function setPlayerPounced(matchId, playerId)
	return function(store)
		store:dispatch(changePlayer(matchId, playerId, {
			type = Actions.setPlayerPounced;
		}))
		task.delay(5, function()
			store:dispatch(removeMatch(matchId))
		end)
	end
end

return setPlayerPounced