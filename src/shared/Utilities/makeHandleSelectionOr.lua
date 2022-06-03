local ReplicatedStorage = game:GetService("ReplicatedStorage")

local setSelectedCard = require(ReplicatedStorage.Actions.setSelectedCard)
local Store = require(ReplicatedStorage.Modules.Store)

local function makeHandleSelectionOr(action, origin, column)
	return function(_instance, _inputObject, _clickCount, index)
		local currentSelection = Store:getState().selection
		-- if no action function, action will always be to select the card
		if currentSelection then
			-- if this card is already selected, deselect
			if
				currentSelection.origin == origin
				and currentSelection.column == column
				and currentSelection.index == index
			then
				Store:dispatch(setSelectedCard())
			elseif action then
				action(index)
			end
		else
			Store:dispatch(setSelectedCard(origin, column, index))
		end
	end
end

return makeHandleSelectionOr