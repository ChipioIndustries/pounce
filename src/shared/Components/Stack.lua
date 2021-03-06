local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local Roact = require(ReplicatedStorage.Packages.Roact)

local components = ReplicatedStorage.Components
local Card = require(components.Card)
local Empty = require(components.Empty)
local InventoryContext = require(components.InventoryContext)
local Pounce = require(components.Pounce)

local Stack = Roact.Component:extend("Stack")

function Stack:render()
	return Roact.createElement(InventoryContext.Consumer, {
		render = function(context)
			local props = self.props
			local cards = props.cards
			local direction = props.direction
			local isMainStack = props.isMainStack
			local onClick = props.onClick
			local selected = props.selected

			local playerId = context.playerId

			local topCard = cards[#cards]
			local bottomCard = cards[#cards - 1]

			local cardObjects = {}

			if bottomCard then
				table.insert(cardObjects, Roact.createElement(Card, {
					direction = direction;
					playerId = playerId;
					position = CONFIG.Interface.StackBottomCardOffset;
					signature = bottomCard;
					zIndex = 1;
				}))
			end

			if topCard then
				table.insert(cardObjects, Roact.createElement(Card, {
					direction = direction;
					onClick = onClick;
					playerId = playerId;
					selected = selected;
					signature = topCard;
					zIndex = 2;
				}))
			else
				if isMainStack then
					table.insert(cardObjects, Roact.createElement(Pounce))
				else
					table.insert(cardObjects, Roact.createElement(Empty, {
						onClick = onClick;
					}))
				end
			end

			return Roact.createElement("Frame", {
				BackgroundTransparency = 1;
				Size = CONFIG.Interface.CardSize + CONFIG.Interface.StackBottomCardOffset
			}, cardObjects)
		end
	})
end

return Stack