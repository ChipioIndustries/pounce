local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local setSelectedCard = require(ReplicatedStorage.Actions.setSelectedCard)

local modules = ReplicatedStorage.Modules
local Store = require(modules.Store)
local Sound = require(modules.Sound)

local function makeHandleSelectionOr(action, origin, column)
	return function(_instance, _inputObject, _clickCount, index)
		local currentSelection = Store:getState().selection
		-- if no action function, action will always be to select the card
		if currentSelection then
			local isSameColumn = currentSelection.origin == origin and currentSelection.column == column
			-- if this card is already selected, deselect
			if isSameColumn and column and currentSelection.index ~= index then
				Sound:play(CONFIG.Sounds.Select)
				Store:dispatch(setSelectedCard(origin, column, index))
			elseif isSameColumn and currentSelection.index == index then
				Sound:play(CONFIG.Sounds.Deselect)
				Store:dispatch(setSelectedCard())
			elseif action then
				action(index)
			end
		else
			Sound:play(CONFIG.Sounds.Select)
			Store:dispatch(setSelectedCard(origin, column, index))
		end
	end
end

return makeHandleSelectionOr