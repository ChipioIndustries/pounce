local ReplicatedStorage = game:GetService("ReplicatedStorage")

local packages = ReplicatedStorage.Packages

local ReplicationMiddleware = require(packages.ReplicationMiddleware)
local Rodux = require(packages.Rodux)

local replicationMiddleware = ReplicationMiddleware.new()

local store = Rodux.Store.new(function(state, action) return state end, nil, {
    replicationMiddleware;
	Rodux.loggerMiddleware;
})

return store