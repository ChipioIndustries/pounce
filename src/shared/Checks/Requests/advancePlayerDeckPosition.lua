local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local check = require(ReplicatedStorage.Checks.isMatchActive)

local function advancePlayerDeckPosition(player)
	player = player or Players.LocalPlayer

	local success, result = check(player)

	if not success then
		return success, result
	end

	return true
end

return advancePlayerDeckPosition