local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Roact = require(ReplicatedStorage.Packages.Roact)

local Cards = require(ReplicatedStorage.Utilities.Cards)

local Icon = Roact.Component:extend("Icon")

function Icon:render()
	local props = self.props
	local anchorPoint = props.anchorPoint
	local position = props.position
	local signature = props.signature
	local size = props.size or UDim2.new(0, 18, 0, 18)

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