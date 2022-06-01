local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local Roact = require(ReplicatedStorage.Packages.Roact)

local Card = require(ReplicatedStorage.Components.Card)

local utilities = ReplicatedStorage.Utilities
local Cards = require(utilities.Cards)
local getSeedFromString = require(utilities.getSeedFromString)

local Pile = Roact.Component:extend("Pile")

function Pile:render()
	local props = self.props
	local cards = props.cards
	local id = props.id
	local position = props.position

	local RNG = Random.new(getSeedFromString(id))
	local cardObjects = {}
	local index = 0

	for cardSignature, _playerId in pairs(cards) do
		index += 1

		-- face-down if no more cards can be added to the pile
		local direction = Enums.CardDirection.Up
		local value = Cards:getValue(cardSignature)
		if not CONFIG.CardDecorators[value + 1] then
			direction = Enums.CardDirection.Down
		end

		cardObjects[index] = Roact.createElement(Card, {
			anchorPoint = Vector2.new(0.5, 0.5);
			direction = direction;
			position = UDim2.new(0.5, 0, 0.5, 0);
			rotation = RNG:NextInteger(0, 359);
			signature = cardSignature;
			zIndex = index;
		})
	end

	local cardHeight = CONFIG.Interface.CardSize.Y.Offset

	return Roact.createElement("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundTransparency = 1;
		Position = position;
		Size = UDim2.new(0, cardHeight + 10, 0, cardHeight + 10);
		ZIndex = 2;
	}, cardObjects)
end

return Pile