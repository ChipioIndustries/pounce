local ReplicatedStorage = game:GetService("ReplicatedStorage")

local packages = ReplicatedStorage.Packages
local Roact = require(packages.Roact)
local Remotes = require(packages.Remotes)

local quitRemote = Remotes:getFunctionAsync("quit")

local QuitButton = Roact.Component:extend("QuitButton")

function QuitButton:init()
	self.text, self.updateText = Roact.createBinding("Quit")
end

function QuitButton:render()
	return Roact.createElement("TextButton", {
		Size = UDim2.new(0, 200, 0, 50);
		Position = UDim2.new(0.5, 0, 0.5, 0);
		AnchorPoint = Vector2.new(0.5, 0.5);
		Text = self.text;
		[Roact.Event.Activated] = function(_instance)
			local success, result = quitRemote:InvokeServer()
			local newText = if success then "Success!" else result
			self.updateText(newText)
			task.wait(2)
			self.updateText("Quit")
		end;
	})
end

return QuitButton