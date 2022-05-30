local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)
local Store = require(ReplicatedStorage.Modules.Store)
local Selectors = require(ReplicatedStorage.Selectors)
local addMatch = require(ServerScriptService.Actions.addMatch)

local function makeMatches()
	local nextMatch = {}

	local function makeMatch()
		Store:dispatch(addMatch(HttpService:GenerateGUID(false), nextMatch))
		nextMatch = {}
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if Selectors.getIsPlayerWaiting(tostring(player.UserId)) then
			table.insert(nextMatch, tostring(player.UserId))
			if #nextMatch == CONFIG.MaxPlayers then
				makeMatch()
			end
		end
	end

	if #nextMatch >= CONFIG.MinPlayers then
		makeMatch()
	end
end

task.spawn(function()
	while true do
		task.wait(CONFIG.MatchIntermission)
		makeMatches()
	end
end)

return makeMatches