local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local packages = ReplicatedStorage.Packages
local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)
local Remotes = require(packages.Remotes)

local Selectors = require(ReplicatedStorage.Selectors)

local quitRemote = Remotes:getFunctionAsync("quit")

local Quit = Roact.Component:extend("Quit")

function Quit:render()
	if self.props.isInMatch then
		return Roact.createElement("TextButton", {
			AnchorPoint = Vector2.new(0, 1);
			BackgroundColor3 = Color3.fromRGB(126, 66, 59);
			Font = CONFIG.Interface.TextFont;
			Text = "Quit";
			TextColor3 = Color3.new(1, 1, 1);
			TextScaled = true;
			[Roact.Event.Activated] = function(_instance)
				quitRemote:InvokeServer()
			end;
		}, {
			Corner = Roact.createElement("UICorner")
		})
	else
		return nil
	end
end

Quit = RoactRodux.connect(
	function(state, props)
		return {
			-- convert to bool to prevent re-render on match change
			isInMatch = not not Selectors.getMatchByPlayerId();
		}
	end
)(Quit)

return Quit