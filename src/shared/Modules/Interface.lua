local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer

local playerGui = player:WaitForChild("PlayerGui")

local packages = ReplicatedStorage.Packages

local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)
local Store = require(ReplicatedStorage.Modules.Store)
local App = require(ReplicatedStorage.Components.App)

local appHandle = Roact.mount(
	Roact.createElement(RoactRodux.StoreProvider, {
		store = Store,
	}, {
		Roact.createElement(App)
	}),
	playerGui
)

return appHandle