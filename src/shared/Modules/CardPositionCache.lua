local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local CardPositionCache = {}
local cache = {}

--[[
	cache positions of cards so when a card appears,
	it knows where its animation start point should be
]]

function CardPositionCache:_flush()
	for key, data in pairs(cache) do
		if tick() - data.timestamp > CONFIG.CardPositionCacheLifetime then
			cache[key] = nil
		end
	end
end

function CardPositionCache:get(signature: string, playerId: string)
	local entry = cache[signature .. playerId]
	return entry and entry.position
end

function CardPositionCache:set(signature: string, playerId: string, position)
	cache[signature .. playerId] = {
		position = position;
		timestamp = tick();
	}
end

task.spawn(function()
	while true do
		task.wait(CONFIG.CardPositionCacheFlushRate)
		CardPositionCache:_flush()
	end
end)

return CardPositionCache
