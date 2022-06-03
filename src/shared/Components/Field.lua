local CollectionService = game:GetService("CollectionService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local packages = ReplicatedStorage.Packages
local Remotes = require(packages.Remotes)
local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)

local Store = require(ReplicatedStorage.Modules.Store)

local Selectors = require(ReplicatedStorage.Selectors)

local Pile = require(ReplicatedStorage.Components.Pile)

local setSelectedCard = require(ReplicatedStorage.Actions.setSelectedCard)

local moveCardToPile = Remotes:getFunctionAsync("moveCardToPile")

local Field = Roact.Component:extend("Field")

function Field:render()
	local props = self.props
	local piles = props.piles or {}
	local wipeSelection = props.wipeSelection

	local cardPiles = {}

	for id, pile in pairs(piles) do
		cardPiles[id] = Roact.createElement(Pile, {
			cards = pile.cards;
			id = id;
			onClick = function()
				local selection = Store:getState().selection
				if selection then
					moveCardToPile:InvokeServer(id, selection.origin, selection.column)
					wipeSelection()
				end
			end;
			position = pile.position;
		})
	end

	return Roact.createElement("TextButton", {
		AnchorPoint = Vector2.new(0.5, 0.5);
		BackgroundTransparency = 1;
		Position = UDim2.new(0.5, 0, 0.5, 0);
		Size = UDim2.new(CONFIG.Interface.FieldSize, 0, CONFIG.Interface.FieldSize, 0);
		Text = "";
		ZIndex = 2;
		[Roact.Event.Activated] = function()
			local selection = Store:getState().selection
			if selection then
				local tableInstance = CollectionService:GetTagged(CONFIG.TableTag)[1]
				local tablePosition = tableInstance.Position
				local tableSize = tableInstance.Size.X
				local scale = tableSize * CONFIG.Interface.FieldSize
				local position = UDim2.new(0.5, 0, 0.5, 0)
				local hit = mouse.Hit
				if hit then
					hit = hit.Position - tablePosition
					local function studsToScale(studs)
						return studs / scale + 0.5
					end
					local mouseX = -hit.Z
					local mouseY = hit.X
					position = UDim2.new(studsToScale(mouseX), 0, studsToScale(mouseY), 0)
					print(mouseX, mouseY, position)
				end
				moveCardToPile:InvokeServer(nil, selection.origin, selection.column, position)
				wipeSelection()
			end
		end;
	}, cardPiles)
end

Field = RoactRodux.connect(
	function(_state, _props)
		local match = Selectors.getMatchByPlayerId()
		local piles = match and match.field
		return {
			piles = piles;
		}
	end,
	function(dispatch)
		return {
			wipeSelection = function()
				dispatch(setSelectedCard())
			end
		}
	end
)(Field)

return Field