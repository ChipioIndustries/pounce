local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local camera = workspace.CurrentCamera

camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = CONFIG.CameraPosition

return camera