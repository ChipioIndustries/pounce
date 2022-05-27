local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local packages = ReplicatedStorage.Packages
local Llama = require(packages.Llama)
local Roact = require(packages.Roact)

local components = ReplicatedStorage.Components
local Icon = require(components.Icon)
local Signature = require(components.Signature)

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
			BackgroundColor3 = Color3.new(1, 1, 1);
		}
		additionalChildren = {
			BottomSignature = Roact.createElement(Signature, {
				anchorPoint = Vector2.new(1, 1);
				position = UDim2.new(1, 0, 1, 0);
				rotation = 180;
				signature = signature;
			});
			CenterIcon = Roact.createElement(Icon, {
				anchorPoint = Vector2.new(0.5, 0.5);
				signature = signature;
				position = UDim2.new(0.5, 0, 0.5, 0);
				size = UDim2.new(0, 36, 0, 36);
			});
			TopSignature = Roact.createElement(Signature, {
				signature = signature;
			});
		}
	elseif direction == Enums.CardDirection.Down then
		additionalProps = {
			BackgroundColor3 = CONFIG.Interface.CardBackColor;
		}
		additionalChildren = {}
	end

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
				Corner = Roact.createElement("UICorner");
				Stroke = Roact.createElement("UIStroke");
			},
			additionalChildren
		)
	)
end

return Card