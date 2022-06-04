local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Cards = require(ReplicatedStorage.Utilities.Cards)

--[[
	are the cards alternating colors?
	is card B 1 value lower than card A?
]]

local function isCardDescendingAndAlternating(signatureA, signatureB)
	if Cards:getColor(signatureA) == Cards:getColor(signatureB) then
		return false, CONFIG.Responses.SameColor
	end
	-- B should be 1 lower than A
	if Cards:getValue(signatureA) - 1 ~= Cards:getValue(signatureB) then
		return false, CONFIG.Responses.WrongValue
	end
	return true
end

return isCardDescendingAndAlternating