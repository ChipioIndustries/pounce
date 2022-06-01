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
	local selected = props.selected
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
				signature = signature;
				position = UDim2.new(0.5, 0, 0.5, 0);
				size = CONFIG.Interface.Signature.CenterIconSize;
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

	local strokeColor = Color3.new(0, 0, 0)
	if selected then
		strokeColor = Color3.new(1, 0.9, 0)
	end

	return Roact.createElement("Frame",
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
				Stroke = Roact.createElement("UIStroke", {
					Color = strokeColor;
				});
			},
			additionalChildren
		)
	)
end

return Card