local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local Roact = require(ReplicatedStorage.Packages.Roact)

local components = ReplicatedStorage.Components
local Card = require(components.Card)
local Empty = require(components.Empty)

local Stack = Roact.Component:extend("Stack")

function Stack:render()
	local props = self.props
	local cards = props.cards
	local direction = props.direction
	local onClick = props.onClick
	local selected = props.selected

	local topCard = cards[#cards]
	local bottomCard = cards[#cards - 1]

	local cardObjects = {}

	if bottomCard then
		table.insert(cardObjects, Roact.createElement(Card, {
			direction = direction;
			position = CONFIG.Interface.StackBottomCardOffset;
			signature = bottomCard;
			zIndex = 1;
		}))
	end

	if topCard then
		table.insert(cardObjects, Roact.createElement(Card, {
			direction = direction;
			onClick = onClick;
			selected = selected;
			signature = topCard;
			zIndex = 2;
		}))
	else
		table.insert(cardObjects, Roact.createElement(Empty, {
			onClick = onClick;
		}))
	end

	return Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		Size = CONFIG.Interface.CardSize + CONFIG.Interface.StackBottomCardOffset
	}, cardObjects)
end

return Stack