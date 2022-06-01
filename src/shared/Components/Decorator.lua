local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Roact = require(ReplicatedStorage.Packages.Roact)

local Cards = require(ReplicatedStorage.Utilities.Cards)

local Decorator = Roact.Component:extend("Decorator")

function Decorator:render()
	local props = self.props
	local anchorPoint = props.anchorPoint
	local position = props.position
	local signature = props.signature

	local value = Cards:getValue(signature)
	local decorator = CONFIG.CardDecorators[value]

	local colorName = Cards:getColor(signature)
	local color = CONFIG.Interface.CardColors[colorName]

	return Roact.createElement("TextLabel", {
		AnchorPoint = anchorPoint;
		BackgroundTransparency = 1;
		Font = CONFIG.Interface.TextFont;
		Position = position;
		Size = CONFIG.Interface.Signature.DecoratorSize;
		Text = decorator:upper();
		TextColor3 = color;
		TextScaled = true;
	})
end

return Decorator