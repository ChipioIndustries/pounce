local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local packages = ReplicatedStorage.Packages
local Llama = require(packages.Llama)
local Roact = require(packages.Roact)
local Cards = require(ReplicatedStorage.Utilities.Cards)

local Card = Roact.Component:extend("Card")

function Card:render()
	local props = self.props
	local anchorPoint = props.anchorPoint
	local direction = props.direction
	local position = props.position
	local rotation = props.rotation
	local signature = props.signature
	local zIndex = props.zIndex

	local additionalChildren
	local additionalProps

	if direction == Enums.CardDirection.Up then
		additionalProps = {

		}
		additionalChildren = {}
	elseif direction == Enums.CardDirection.Down then
		additionalProps = {

		}
		additionalChildren = {}
	end

	local value = Cards:getValue(signature)
	local decorator = CONFIG.CardDecorators[value]

	return Roact.createElement("TextButton",
		Llama.Dictionary.join(
			{
				AnchorPoint = anchorPoint;
				Position = position;
				Rotation = rotation;
				Size = CONFIG.Interface.CardSize;
				ZIndex = zIndex;
			},
			additionalProps
		),
		Llama.Dictionary.join(
			{
				Corner = Roact.createElement("UICorner", {
					CornerRadius = UDim.new(0, 8);
				});
				Stroke = Roact.createElement("UIStroke");
			},
			additionalChildren
		)
	)
end

return Card