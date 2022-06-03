local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local Roact = require(ReplicatedStorage.Packages.Roact)

local components = ReplicatedStorage.Components
local Card = require(components.Card)
local Empty = require(components.Empty)

local Column = Roact.Component:extend("Column")

function Column:render()
	local props = self.props
	local cards = props.cards
	local clickable = props.clickable or Enums.Clickable.All
	local layoutDirection = props.layoutDirection or Enums.CardLayoutDirection.Vertical
	local onClick = props.onClick
	local selectionIndex = props.selectionIndex
	local sizeOffsetsOverride = props.sizeOffsetsOverride
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
		local callback
		if onClick then
			if clickable == Enums.Clickable.All then
				callback = function(...)
					local args = {...}
					table.insert(args, index)
					onClick(unpack(args))
				end
			elseif clickable == Enums.Clickable.TopOnly then
				if index == #cards then
					callback = onClick
				end
			end
		end
		table.insert(cardObjects, Roact.createElement(Card, {
			direction = Enums.CardDirection.Up;
			onClick = callback;
			position = getOffset(index - 1);
			selected = selectionIndex and index >= selectionIndex;
			signature = signature;
			zIndex = index;
		}))
	end

	if #cardObjects == 0 then
		table.insert(cardObjects, Roact.createElement(Empty, {
			onClick = onClick;
		}))
	end

	return Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		Size = CONFIG.Interface.CardSize + getOffset((sizeOffsetsOverride or #cardObjects) - 1)
	}, cardObjects)
end

return Column