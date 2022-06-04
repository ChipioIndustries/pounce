-- Rodux store changes are expensive, so rate limits
-- need to be applied to any remote that dispatches actions
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local packages = ReplicatedStorage.Packages
local LeakyBucket = require(packages.LeakyBucket)
local Remotes = require(packages.Remotes)

local Secrets = require(ServerScriptService.Secrets)

local buckets = {
	--[[
		each player has a table of leaky buckets
		corresponding to each remote. if a bucket
		overflows the call is dropped to prevent spam.
	]]
}

local function rateLimiter(arguments, metadata)
	local playerId = arguments[1].UserId
	local remoteName = metadata.remoteName
	buckets[playerId] = buckets[playerId] or {}
	local playerBuckets = buckets[playerId]
	if not playerBuckets[remoteName] then
		local rate = Secrets.RateLimits[remoteName] or Secrets.RateLimits.Global
		playerBuckets[remoteName] = LeakyBucket.new({
			fillWhenOverflowing = Secrets.RateLimitFillWhenOverflowing;
			leakRate = rate;
			size = Secrets.RateLimitBuffer;
		})
	end
	local overflowed = playerBuckets[remoteName]:fill()
	return overflowed, arguments
end

local function onPlayerRemoving(player)
	buckets[player.UserId] = nil
end

Remotes:registerMiddleware(rateLimiter)
Players.PlayerRemoving:Connect(onPlayerRemoving)

return buckets