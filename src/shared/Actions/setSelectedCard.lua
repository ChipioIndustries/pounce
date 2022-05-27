local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Actions = require(ReplicatedStorage.Constants.Actions)

local function setSelectedCard(origin, column, index)
	return {
		type = Actions.setSelectedCard;
		column = column;
		index = index;
		origin = origin;
	}
end

return setSelectedCard