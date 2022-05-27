local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local components = ReplicatedStorage.Components
local Decorator = require(components.Decorator)
local Icon = require(components.Icon)

local Signature = Roact.Component:extend("Signature")

function Signature:render()
	local props = self.props
	local anchorPoint = props.anchorPoint
	local position = props.position
	local rotation = props.rotation
	local signature = props.signature

	return Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		AnchorPoint = anchorPoint;
		Position = position;
		Rotation = rotation;
		Size = UDim2.new(0, 18, 0, 36);
	}, {
		Decorator = Roact.createElement(Decorator, {
			position = UDim2.new(0, 0, 0.5, 0);
			signature = 0;
		});
		Icon = Roact.createElement(Icon, {
			signature = signature;
		})
	})
end

return Signature