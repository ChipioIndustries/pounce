local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

local function selectionReducer(state, action)
	state = state or nil

	if action.type == Actions.setSelectedCard then
		if action.origin then
			return {
				column = action.column; -- optional
				index = action.index; -- optional
				origin = action.origin;
			}
		else
			return nil
		end
	end

	return state
end

return selectionReducer