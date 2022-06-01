local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local packages = ReplicatedStorage.Packages
local Llama = require(packages.Llama)
local Roact = require(packages.Roact)

local components = ReplicatedStorage.Components
local Column = require(components.Column)
local Stack = require(components.Stack)

local Inventory = Roact.Component:extend("Inventory")

local rotations = {
	{
		AnchorPoint = Vector2.new(0, 1);
		Position = UDim2.new(0, 0, 1, 0);
		Rotation = 0;
	},
	{
		AnchorPoint = Vector2.new(0, 0.5);
		Position = UDim2.new(-0.4, 0, 0.5, 0);
		Rotation = 90;
	},
	{
		AnchorPoint = Vector2.new(0, 0.5);
		Position = UDim2.new(0.4, 0, 0.5, 0);
		Rotation = 270;
	},
	{
		AnchorPoint = Vector2.new(0, 0);
		Position = UDim2.new(0, 0, 0, 0);
		Rotation = 180;
	}
}

function Inventory:render()
	local props = self.props
	local rotationIndex = props.rotationIndex
	local playerData = props.playerData

	local cardPiles = {}

	table.insert(cardPiles, Roact.createElement(Stack, {
		cards = playerData.stack;
		direction = Enums.CardDirection.Up;
	}))

	for index, column in ipairs(playerData.pad) do
		table.insert(cardPiles, Roact.createElement(Column, {
			cards = column;
		}))
	end

	table.insert(cardPiles, Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		Size = UDim2.new(0, 20, 0, 0);
	}))

	table.insert(cardPiles, Roact.createElement(Stack, {
		cards = Llama.List.slice(playerData.deck, playerData.deckPosition + 1);
		direction = Enums.CardDirection.Down;
	}))

	-- get the top 3 viewable cards from the deck
	local cards = {}
	if playerData.deckPosition > 0 then
		cards = Llama.List.slice(
			playerData.deck,
			math.max(1, playerData.deckPosition - CONFIG.DeckViewableCardsCount),
			playerData.deckPosition
		)
	end

	table.insert(cardPiles, Roact.createElement(Column, {
		cards = cards;
		layoutDirection = Enums.CardLayoutDirection.Horizontal;
	}))

	local rotationProps = rotations[rotationIndex]

	return Roact.createElement("Frame",
		Llama.Dictionary.join(
			{
				BackgroundTransparency = 1;
				Size = UDim2.new(1, 0, 0.2, 0);
			},
			rotationProps
		),
		Llama.Dictionary.join(
			{
				Layout = Roact.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal;
					HorizontalAlignment = Enum.HorizontalAlignment.Center;
					Padding = UDim.new(0, 8);
				})
			},
			cardPiles
		)
	)
end

return Inventory