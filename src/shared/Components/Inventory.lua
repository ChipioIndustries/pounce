local ReplicatedStorage = game:GetService("ReplicatedStorage")

local constants = ReplicatedStorage.Constants
local CONFIG = require(constants.CONFIG)
local Enums = require(constants.Enums)

local packages = ReplicatedStorage.Packages
local Llama = require(packages.Llama)
local Remotes = require(packages.Remotes)
local Roact = require(packages.Roact)
local RoactRodux = require(packages.RoactRodux)

local Sound = require(ReplicatedStorage.Modules.Sound)

local components = ReplicatedStorage.Components
local Column = require(components.Column)
local Stack = require(components.Stack)

local setSelectedCard = require(ReplicatedStorage.Actions.setSelectedCard)

local makeHandleSelectionOr = require(ReplicatedStorage.Utilities.makeHandleSelectionOr)

local advancePlayerDeckPosition = Remotes:getFunctionAsync("advancePlayerDeckPosition")
local moveCardToColumn = Remotes:getFunctionAsync("moveCardToColumn")
local moveCardsBetweenColumns = Remotes:getFunctionAsync("moveCardsBetweenColumns")

local Inventory = Roact.Component:extend("Inventory")

local rotations = {
	{
		AnchorPoint = Vector2.new(0, 1);
		Position = UDim2.new(0, 0, 1, 0);
		Rotation = 0;
	},
	{
		AnchorPoint = Vector2.new(0, 0.5);
		Position = UDim2.new(-0.4, 0, 0.5, 0);
		Rotation = 90;
	},
	{
		AnchorPoint = Vector2.new(0, 0.5);
		Position = UDim2.new(0.4, 0, 0.5, 0);
		Rotation = 270;
	},
	{
		AnchorPoint = Vector2.new(0, 0);
		Position = UDim2.new(0, 0, 0, 0);
		Rotation = 180;
	}
}

function Inventory:render()
	local props = self.props
	local isLocalPlayer = props.isLocalPlayer
	local playerData = props.playerData
	local rotationIndex = props.rotationIndex
	local selection = props.selection
	local setSelection = props.setSelection
	local wipeSelection = props.wipeSelection

	local rotationProps = rotations[rotationIndex]

	local cardPiles = {}

	do -- stack
		local stackInput = {}

		--[[
			the inventory component is used cosmetically for other players and also
			interactively for the local player, so it needs to check before
			adding any event handlers or things that are irrelevant to other players.
		]]
		if isLocalPlayer then
			stackInput = {
				isMainStack = true;
				selected = selection and selection.origin == Enums.CardOrigin.Stack;
				onClick = function()
					if #playerData.stack > 0 then
						Sound:play(CONFIG.Sounds.Select)
						setSelection(Enums.CardOrigin.Stack)
					end
				end;
			}
		end

		table.insert(cardPiles, Roact.createElement(Stack,
			Llama.Dictionary.join(
				{
					cards = playerData.stack;
					direction = Enums.CardDirection.Up;
				},
				stackInput
			)
		))
	end

	do -- pad (columns)
		for index, column in ipairs(playerData.pad) do
			local columnInput = {}
			if isLocalPlayer then
				local selectionIndex
				if
					selection
					and selection.origin == Enums.CardOrigin.Column
					and selection.column == index
				then
					-- selection index controls how many of the cards in the column are highlighted
					selectionIndex = selection.index
				end
				local callback
				local function moveToColumnHandler()
					if selection then
						local success
						if selection.origin == Enums.CardOrigin.Column then
							local originColumn = selection.column
							local cardCount = #playerData.pad[originColumn] - selection.index + 1
							success = moveCardsBetweenColumns:InvokeServer(originColumn, index, cardCount)
						else
							success = moveCardToColumn:InvokeServer(index, selection.origin)
						end
						if success then
							Sound:play(CONFIG.Sounds.Place)
						end
						wipeSelection()
					end
				end
				-- if the column isn't empty, make it selectable.
				-- otherwise just make it check to see if the selection can be moved there
				if #column > 0 then
					callback = makeHandleSelectionOr(moveToColumnHandler, Enums.CardOrigin.Column, index)
				else
					callback = moveToColumnHandler
				end
				columnInput = {
					onClick = callback;
					selectionIndex = selectionIndex;
				}
			end
			table.insert(cardPiles, Roact.createElement(Column,
				Llama.Dictionary.join(
					{
						cards = column;
					},
					columnInput
				)
			))
		end
	end

	-- padding between pad and deck
	table.insert(cardPiles, Roact.createElement("Frame", {
		BackgroundTransparency = 1;
		Size = UDim2.new(0, 20, 0, 0);
	}))

	do -- hidden portion of deck
		local hiddenDeckInput = {}

		if isLocalPlayer then
			hiddenDeckInput = {
				onClick = function()
					Sound:play(CONFIG.Sounds.Slide)
					wipeSelection()
					advancePlayerDeckPosition:InvokeServer()
				end;
			}
		end

		local hiddenDeckCards = {}
		if playerData.deckPosition + 1 <= #playerData.deck then
			hiddenDeckCards = Llama.List.slice(playerData.deck, playerData.deckPosition + 1)
		end

		table.insert(cardPiles, Roact.createElement(Stack,
			Llama.Dictionary.join(
				{
					cards = hiddenDeckCards;
					direction = Enums.CardDirection.Down;
				},
				hiddenDeckInput
			)
		))
	end

	do -- visible portion of deck
		-- get the top 3 viewable cards from the deck
		local cards = {}
		if playerData.deckPosition > 0 then
			cards = Llama.List.slice(
				playerData.deck,
				math.max(1, playerData.deckPosition - CONFIG.DeckViewableCardsCount + 1),
				playerData.deckPosition
			)
		end

		local shownDeckInput = {}

		if isLocalPlayer then
			local selectionIndex
			if selection and selection.origin == Enums.CardOrigin.Deck then
				-- select the top card of the deck
				selectionIndex = #cards
			end

			shownDeckInput = {
				clickable = Enums.Clickable.TopOnly;
				onClick = makeHandleSelectionOr(nil, Enums.CardOrigin.Deck);
				selectionIndex = selectionIndex;
			}
		end

		table.insert(cardPiles, Roact.createElement(Column,
			Llama.Dictionary.join(
				{
					cards = cards;
					layoutDirection = Enums.CardLayoutDirection.Horizontal;
					sizeOffsetsOverride = CONFIG.DeckViewableCardsCount;
				},
				shownDeckInput
			)
		))
	end

	return Roact.createElement("Frame",
		Llama.Dictionary.join(
			{
				BackgroundTransparency = 1;
				Size = UDim2.new(1, 0, 0.2, 0);
			},
			rotationProps
		),
		Llama.Dictionary.join(
			{
				Layout = Roact.createElement("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal;
					HorizontalAlignment = Enum.HorizontalAlignment.Center;
					Padding = UDim.new(0, 8);
				})
			},
			cardPiles
		)
	)
end

Inventory = RoactRodux.connect(
	function(state, _props)
		return {
			selection = state.selection;
		}
	end,
	function(dispatch)
		return {
			setSelection = function(...)
				dispatch(setSelectedCard(...))
			end;
			wipeSelection = function()
				dispatch(setSelectedCard())
			end
		}
	end
)(Inventory)

return Inventory