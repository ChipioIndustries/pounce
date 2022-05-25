local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Store = require(ReplicatedStorage.Modules.Store)

-- pulling out the intense 5th-grade math for this one
local function pythagoreanTheorem(a, b)
	return math.sqrt(a^2 + b^2)
end

local function checkPilePosition(matchId, position, _fieldOverride)
	local piles = _fieldOverride or Store:getState().activeMatches[matchId].field

	local x = position.X.Scale
	local y = position.Y.Scale

	for _, pile in pairs(piles) do
		-- get distance between the twe piles
		local x2 = pile.position.X.Scale
		local y2 = pile.position.Y.Scale

		local a = x2 - x
		local b = y2 - y

		local c = pythagoreanTheorem(a, b)

		if c < CONFIG.MinimumPileDistance then
			return false
		end
	end

	return true
end

return checkPilePosition