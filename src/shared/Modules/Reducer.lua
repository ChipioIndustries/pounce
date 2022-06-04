local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local Rodux = require(ReplicatedStorage.Packages.Rodux)

local sharedReducers = ReplicatedStorage.Reducers

local reducers = {}

local function addReducers(path)
	for _, file in ipairs(path:GetChildren()) do
		reducers[file.Name] = require(file)
	end
end

addReducers(sharedReducers)

if RunService:IsServer() then
	addReducers(ServerScriptService:FindFirstChild("Reducers") or Instance.new("Folder"))
end

return Rodux.combineReducers(reducers)