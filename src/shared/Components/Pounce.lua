local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local packages = ReplicatedStorage.Packages
local Remotes = require(packages.Remotes)
local Roact = require(packages.Roact)

local setPlayerPounced = Remotes:getFunctionAsync("setPlayerPounced")

local Pounce = Roact.Component:extend("Pounce")

function Pounce:render()
	return Roact.createElement("TextButton", {
		BackgroundColor3 = Color3.new(0, 0.6, 0);
		BackgroundTransparency = 0;
		BorderSizePixel = 0;
		Font = Enum.Font.FredokaOne;
		Size = CONFIG.Interface.CardSize;
		Text = "POUNCE!";
		TextColor3 = Color3.new(1, 1, 1);
		TextScaled = true;
		[Roact.Event.Activated] = function()
			setPlayerPounced:InvokeServer()
		end;
	}, {
		Corner = Roact.createElement("UICorner")
	})
end

return Pounce