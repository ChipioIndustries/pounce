local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local packages = ReplicatedStorage.Packages
local Maid = require(packages.Maid)
local Roact = require(packages.Roact)

local components = ReplicatedStorage.Components
local Field = require(components.Field)
local Inventories = require(components.Inventories)
local TableBackground = require(components.TableBackground)
local TableContext = require(components.TableContext)
local Quit = require(components.Quit)

local Table = Roact.Component:extend("Table")

function Table:init()
	self.guiRef = Roact.createRef()

	self.maid = Maid.new()
	self.adornee, self.setAdornee = Roact.createBinding(nil)

	function self.updateAdornee()
		self.setAdornee(CollectionService:GetTagged(CONFIG.TableTag)[1])
	end

	self.maid:GiveTask(CollectionService:GetInstanceAddedSignal(CONFIG.TableTag):Connect(self.updateAdornee))
	self.maid:GiveTask(CollectionService:GetInstanceRemovedSignal(CONFIG.TableTag):Connect(self.updateAdornee))

	self.updateAdornee()
end

function Table:render()
	return Roact.createElement(TableContext.Provider, {
		value = {
			surfaceGuiRef = self.guiRef;
		}
	}, {
		Table = Roact.createElement("SurfaceGui", {
			Adornee = self.adornee;
			ClipsDescendants = true;
			Face = Enum.NormalId.Top;
			LightInfluence = 1;
			PixelsPerStud = 100;
			ResetOnSpawn = false;
			SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud;
			ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
			[Roact.Ref] = self.guiRef;
		}, {
			Background = Roact.createElement(TableBackground);
			Field = Roact.createElement(Field);
			Inventories = Roact.createElement(Inventories);
			Quit = Roact.createElement(Quit);
		})
	})
end

function Table:willUnmount()
	self.maid:Cleanup()
end

return Table