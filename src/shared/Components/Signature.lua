local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

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
		AnchorPoint = anchorPoint;
		BackgroundTransparency = 1;
		Position = position;
		Rotation = rotation;
		Size = CONFIG.Interface.Signature.Size;
	}, {
		Decorator = Roact.createElement(Decorator, {
			signature = signature;
		});
		Icon = Roact.createElement(Icon, {
			position = UDim2.new(0.5, 0, 0.75, 0);
			signature = signature;
		})
	})
end

return Signature