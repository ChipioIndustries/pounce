local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local packages = ReplicatedStorage.Packages
local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)

local Selectors = require(ReplicatedStorage.Selectors)
local getPlayerByPlayerId = require(ReplicatedStorage.Utilities.getPlayerByPlayerId)

local StatusBar = Roact.Component:extend("StatusBar")

function StatusBar:render()
	local props = self.props
	local match = props.match
	local position = props.position
	local size = props.size

	local text = ""

	if not match then
		text = CONFIG.Statuses.Waiting
	else
		local matchId = Selectors.getMatchIdByPlayerId()
		local matchWinner = Selectors.getMatchWinner(matchId)
		if matchWinner then
			local winningPlayer = getPlayerByPlayerId(matchWinner) or { DisplayName = "Someone" }
			local winnerName = if winningPlayer == player then "You" else winningPlayer.DisplayName
			text = CONFIG.Statuses.GameOver:format(winnerName)
		end
	end

	return Roact.createElement("TextLabel", {
		BackgroundTransparency = 1;
		Font = CONFIG.Interface.TextFont;
		Position = position;
		Size = size;
		Text = text:lower();
		TextColor3 = Color3.new(1, 1, 1);
		TextScaled = true;
		TextTransparency = CONFIG.Interface.BackgroundTransparency;
	})
end

StatusBar = RoactRodux.connect(
	function(_state, _props)
		return {
			match = Selectors.getMatchByPlayerId()
		}
	end
)(StatusBar)

return StatusBar