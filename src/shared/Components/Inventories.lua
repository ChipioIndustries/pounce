local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local packages = ReplicatedStorage.Packages
local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)

local Inventory = require(ReplicatedStorage.Components.Inventory)

local Selectors = require(ReplicatedStorage.Selectors)

local localPlayerId = tostring(player.UserId)

local Inventories = Roact.Component:extend("Inventories")

function Inventories:render()
	local props = self.props
	local matchData = props.matchData

	local inventories = {}
	local index = 1

	if matchData then
		local function addData(playerId, playerData, playerIndex)
			inventories[playerId] = Roact.createElement(Inventory, {
				isLocalPlayer = playerId == tostring(player.UserId);
				playerData = playerData;
				rotationIndex = playerIndex;
			})
		end

		-- ensure localplayer gets 1st position
		addData(localPlayerId, matchData.players[localPlayerId], index)

		for playerId, playerData in pairs(matchData.players) do
			if playerId ~= localPlayerId then
				index += 1
				addData(playerId, playerData, index)
			end
		end
	end

	return Roact.createFragment(inventories)
end

Inventories = RoactRodux.connect(
	function(_state, _props)
		return {
			matchData = Selectors.getMatchByPlayerId();
		}
	end
)(Inventories)

return Inventories