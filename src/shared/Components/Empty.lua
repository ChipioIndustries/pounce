local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local Roact = require(ReplicatedStorage.Packages.Roact)

local Empty = Roact.Component:extend("Empty")

function Empty:render()
	local props = self.props
	local onClick = props.onClick

	return Roact.createElement("TextButton", {
		BackgroundColor3 = Color3.new(0, 0, 0);
		BackgroundTransparency = 0.7;
		BorderSizePixel = 0;
		Size = CONFIG.Interface.CardSize;
		Text = "";
		[Roact.Event.Activated] = onClick;
	}, {
		Corner = Roact.createElement("UICorner")
	})
end

return Empty