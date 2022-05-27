local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

local function selectionReducer(state, action)
	state = state or {}

	if action.type == Actions.setSelectedCard then
		return {
			column = action.column; -- optional
			index = action.index; -- optional
			origin = action.origin;
		}
	end

	return state
end

return selectionReducer