local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local packages = ReplicatedStorage.Packages
local Llama = require(packages.Llama)
local Roact = require(packages.Roact)

local Card = require(ReplicatedStorage.Components.Card)

local utilities = ReplicatedStorage.Utilities
local Cards = require(utilities.Cards)
local getSeedFromString = require(utilities.getSeedFromString)

local Pile = Roact.Component:extend("Pile")

function Pile:render()
	local props = self.props
	local cards = props.cards
	local id = props.id
	local onClick = props.onClick
	local position = props.position

	-- RNG is based on pile GUID so all of the rotations
	-- are preserved when re-rendering
	local RNG = Random.new(getSeedFromString(id))
	local cardObjects = {}

	for index, card in pairs(cards) do
		-- face-down if no more cards can be added to the pile
		local direction = Enums.CardDirection.Up
		local value = Cards:getValue(card.signature)
		if not CONFIG.CardDecorators[value + 1] then
			direction = Enums.CardDirection.Down
		end

		local callback
		if index == Llama.Dictionary.count(cards) then
			callback = onClick
		end

		cardObjects[index] = Roact.createElement(Card, {
			anchorPoint = Vector2.new(0.5, 0.5);
			direction = direction;
			onClick = callback;
			playerId = card.playerId;
			position = UDim2.new(0.5, 0, 0.5, 0);
			rotation = RNG:NextInteger(0, 359);
			signature = card.signature;
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