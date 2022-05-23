local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Llama = require(ReplicatedStorage.Packages.Llama)

local Actions = require(ReplicatedStorage.Modules.Actions)

local matchReducer = require(script.match)

local function activeMatchesReducer(state, action)
	if action.type == Actions.addMatch then
		return Llama.Dictionary.join(state, {
			[action.roundId] = {

			}
		})
	elseif action.type == Actions.changeMatch then
		return Llama.Dictionary.join(state, {
			[action.roundId] = matchReducer(state[action.roundId], action.subAction)
		})
	elseif action.type == Actions.removeMatch then
		return Llama.Dictionary.join(state, {
			[action.roundId] = Llama.None
		})
	end

	return state
end

return activeMatchesReducer