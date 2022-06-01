local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Roact = require(ReplicatedStorage.Packages.Roact)

local Cards = require(ReplicatedStorage.Utilities.Cards)

local Icon = Roact.Component:extend("Icon")

function Icon:render()
	local props = self.props
	local anchorPoint = props.anchorPoint or Vector2.new(0.5, 0.5)
	local position = props.position
	local signature = props.signature
	local size = props.size or CONFIG.Interface.Signature.IconSize

	local suit = Cards:getSuit(signature)
	local colorName = Cards:getColor(signature)

	local image = CONFIG.Images.Suits[suit]
	local color = CONFIG.Interface.CardColors[colorName]

	return Roact.createElement("ImageLabel", {
		AnchorPoint = anchorPoint;
		BackgroundTransparency = 1;
		Image = image;
		ImageColor3 = color;
		Position = position;
		Size = size;
	})
end

return Icon