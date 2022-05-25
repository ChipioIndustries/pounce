local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Roact = require(ReplicatedStorage.Packages.Roact)

local App = Roact.Component:extend("App")

function App:render()

end

return App