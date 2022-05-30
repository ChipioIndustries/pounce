local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local check = require(ReplicatedStorage.Checks.playerInMatch)

local function quit(player)
	player = player or Players.LocalPlayer
	return check(player)
end

return quit