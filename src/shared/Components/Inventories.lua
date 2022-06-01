local ReplicatedStorage = game:GetService("ReplicatedStorage")

local packages = ReplicatedStorage.Packages
local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)

local Inventory = require(ReplicatedStorage.Components.Inventory)

local Selectors = require(ReplicatedStorage.Selectors)

local Inventories = Roact.Component:extend("Inventories")

function Inventories:render()
	local props = self.props
	local matchData = props.matchData

	local inventories = {}
	local index = 0

	if matchData then
		for playerId, playerData in pairs(matchData.players) do
			index += 1
			inventories[playerId] = Roact.createElement(Inventory, {
				playerData = playerData;
				rotationIndex = index;
			})
		end
	end

	return Roact.createFragment(inventories)
end

Inventories = RoactRodux.connect(
	function(state, props)
		return {
			matchData = Selectors.getMatchByPlayerId();
		}
	end
)(Inventories)

return Inventories