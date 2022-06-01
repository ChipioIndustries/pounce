local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local Roact = require(ReplicatedStorage.Packages.Roact)

local Card = require(ReplicatedStorage.Components.Card)

local Column = Roact.Component:extend("Column")

function Column:render()
	local props = self.props
	local cards = props.cards
	local layoutDirection = props.layoutDirection or Enums.CardLayoutDirection.Vertical
	local cardOffset = CONFIG.Interface.CardColumnOffset[layoutDirection]

	local function getOffset(index)
		index = math.max(index, 0)
		local offset = cardOffset * index
		if layoutDirection == Enums.CardLayoutDirection.Horizontal then
			return UDim2.new(0, offset, 0, 0);
		elseif layoutDirection == Enums.CardLayoutDirection.Vertical then
			return UDim2.new(0, 0, 0, offset)
		end
	end

	local cardObjects = {}

	for index, signature in ipairs(cards) do
		table.insert(cardObjects, Roact.createElement(Card, {
			direction = Enums.CardDirection.Up;
			position = getOffset(index - 1);
			signature = signature;
			zIndex = index;
		}))
	end

	return Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		Size = CONFIG.Interface.CardSize + getOffset(#cardObjects - 1)
	}, cardObjects)
end

return Column