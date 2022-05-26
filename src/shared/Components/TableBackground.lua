local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Roact = require(ReplicatedStorage.Packages.Roact)

local StatusBar = require(ReplicatedStorage.Components.StatusBar)

local TableBackground = Roact.Component:extend("TableBackground")

function TableBackground:render()
	return Roact.createElement("Frame", {
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundTransparency = 1;
		Position = UDim2.new(0.5, 0, 0.5, 0);
		Size = UDim2.new(0.5, 0, 0.2, 0);
	}, {
		Logo = Roact.createElement("ImageLabel", {
			BackgroundTransparency = 1;
			Image = CONFIG.Images.Logo;
			ImageTransparency = CONFIG.Interface.BackgroundTransparency;
			ScaleType = Enum.ScaleType.Fit;
			Size = UDim2.new(0.3333, 0, 0.8, 0);
		});
		StatusBar = Roact.createElement(StatusBar, {
			position = UDim2.new(0, 0, 0.8, 0);
			size = UDim2.new(1, 0, 0.2, 0);
		});
		Title = Roact.createElement("TextLabel", {
			AnchorPoint = Vector2.new(1, 0);
			BackgroundTransparency = 1;
			Font = CONFIG.Interface.TextFont;
			Position = UDim2.new(1, 0, 0, 0);
			Size = UDim2.new(0.6666, 0, 0.8, 0);
			Text = CONFIG.Interface.Title;
			TextColor3 = Color3.new(1, 1, 1);
			TextScaled = true;
			TextTransparency = CONFIG.Interface.BackgroundTransparency;
		});
	})
end

return TableBackground