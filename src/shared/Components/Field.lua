local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local packages = ReplicatedStorage.Packages
local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)

local Selectors = require(ReplicatedStorage.Selectors)

local Pile = require(ReplicatedStorage.Components.Pile)

local Field = Roact.Component:extend("Field")

function Field:render()
	local props = self.props
	local piles = props.piles or {}

	local cardPiles = {}

	for id, pile in pairs(piles) do
		cardPiles[id] = Roact.createElement(Pile, {
			cards = pile.cards;
			id = id;
			position = pile.position;
		})
	end

	return Roact.createElement("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundTransparency = 1;
		Position = UDim2.new(0.5, 0, 0.5, 0);
		Size = UDim2.new(0.6, 0, 0.6, 0);
		ZIndex = 2;
	}, cardPiles)
end

Field = RoactRodux.connect(
	function(state, props)
		local match = Selectors.getMatchByPlayerId()
		local piles = match and match.field
		return {
			piles = piles
		}
	end
)(Field)

return Field