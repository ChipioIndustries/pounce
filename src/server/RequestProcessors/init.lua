local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Remotes = require(ReplicatedStorage.Packages.Remotes)

local RequestProcessors = {}

for _, module in ipairs(script:GetChildren()) do
	local processor = require(module)
	RequestProcessors[module.Name] = processor

	local remote = Remotes:getFunctionAsync(module.Name)
	remote.OnServerInvoke = processor
end

return RequestProcessors