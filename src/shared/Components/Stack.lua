local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local Roact = require(ReplicatedStorage.Packages.Roact)

local Card = require(ReplicatedStorage.Components.Card)

local Stack = Roact.Component:extend("Stack")

function Stack:render()
	local props = self.props
	local cards = props.cards
	local direction = props.direction

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
			signature = topCard;
			zIndex = 2;
		}))
	end

	return Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		Size = CONFIG.Interface.CardSize + CONFIG.Interface.StackBottomCardOffset
	}, cardObjects)
end

return Stack