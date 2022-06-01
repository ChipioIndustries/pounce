local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local packages = ReplicatedStorage.Packages
local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)
local Remotes = require(packages.Remotes)

local Selectors = require(ReplicatedStorage.Selectors)

local quitRemote = Remotes:getFunctionAsync("setPlayerQuit")

local Quit = Roact.Component:extend("Quit")

function Quit:render()
	local props = self.props
	local isInMatch = props.isInMatch
	local quit = props.quit

	if isInMatch and not quit then
		return Roact.createElement("TextButton", {
			AnchorPoint = Vector2.new(0, 1);
			BackgroundColor3 = Color3.fromRGB(126, 66, 59);
			Font = CONFIG.Interface.TextFont;
			Position = UDim2.new(0, 0, 1, 0);
			Size = UDim2.new(0, 200, 0, 50);
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
	function(_state, _props)
		local match = Selectors.getMatchByPlayerId();
		local quit = if match then match.players[tostring(player.UserId)].quit else false
		return {
			-- convert to bool to prevent re-render on match change
			isInMatch = not not match;
			quit = quit;
		}
	end
)(Quit)

return Quit