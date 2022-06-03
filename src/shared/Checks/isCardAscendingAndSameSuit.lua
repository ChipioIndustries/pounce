local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Cards = require(ReplicatedStorage.Utilities.Cards)

local function isCardAscendingAndSameSuit(signatureA, signatureB)
	if Cards:getSuit(signatureA) ~= Cards:getSuit(signatureB) then
		return false, CONFIG.Responses.WrongSuit
	end
	-- B should be 1 higher than A
	if Cards:getValue(signatureA) + 1 ~= Cards:getValue(signatureB) then
		return false, CONFIG.Responses.WrongValue
	end
	return true
end

return isCardAscendingAndSameSuit