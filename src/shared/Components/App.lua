local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local Table = require(ReplicatedStorage.Components.Table)

local App = Roact.Component:extend("App")

function App:render()
	return Roact.createFragment({
		-- I kind of expected to put more stuff in here lol
		Table = Roact.createElement(Table)
	})
end

return App