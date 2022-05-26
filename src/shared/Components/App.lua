local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local Table = require(ReplicatedStorage.Components.Table)

local App = Roact.Component:extend("App")

function App:render()
	return Roact.createFragment({
		Table = Roact.createElement(Table),
		HUD = Roact.createElement("ScreenGui")
	})
end

return App