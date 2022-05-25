local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.CONFIG)

local RNG = Random.new()

local Cards = {}

function Cards:getColor(signature, _colorsOverride)
	local colors = _colorsOverride or CONFIG.CardColors
	for color, letters in pairs(colors) do
		if table.find(letters, signature:sub(1, 1)) then
			return color
		end
	end
end

function Cards:getSignature(suit, value)
	return suit .. tostring(value)
end

function Cards:getSuit(signature)
	return signature:sub(1, 1)
end

function Cards:getValue(signature)
	return tonumber(signature:sub(2))
end

function Cards:makeDeck(_configOverride)
	local config = _configOverride or CONFIG

	local deck = {}
	for _, suit in ipairs(config.CardSuits) do
		for value, _ in pairs(config.CardDecorators) do
			table.insert(deck, self:getSignature(suit, value))
		end
	end

	return deck
end

function Cards:shuffle(deck, _configOverride)
	if not deck then
		deck = self:makeDeck(_configOverride)
	else
		-- in case the table is frozen
		deck = table.clone(deck)
	end

	-- swap each card with another card in the deck
	for index = 1, #deck do
		local swapIndex = RNG:NextInteger(index, #deck)
		deck[index], deck[swapIndex] = deck[swapIndex], deck[index]
	end

	return deck
end

return Cards