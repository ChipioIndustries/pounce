local Actions = {
	addMatch = "addMatch",
	changeMatch = "changeMatch",
	removeMatch = "removeMatch",

	changePlayer = "changePlayer",

	addPile = "addPile",
	changeField = "changeField",
	removeField = "removeField",

	addCardToPile = "addCardToField";

	changePlayerStack = "changePlayerStack";
	changePlayerColumn = "changePlayerColumn";
	changePlayerDeck = "changePlayerDeck";

	advancePlayerDeckPosition = "advancePlayerDeckPosition";
	setPlayerDeckPosition = "setPlayerDeckPosition";

	setPlayerPounced = "setPlayerPounced";
	setPlayerQuit = "setPlayerQuit";

	removeCardFromDeck = "removeCardFromDeck";
	removeCardFromStack = "removeCardFromStack";

	addCardsToColumn = "addCardsToColumn";
	removeCardsFromColumn = "removeCardsFromColumn";

	moveCardsBetweenColumns = "moveCardsBetweenColumns";
	moveCardToColumn = "moveCardToColumn";
	moveCardToPile = "moveCardToPile";

	setSelectedCard = "setSelectedCard";
}

setmetatable(Actions, {
	__index = function()
		error("Attempt to read nonexistent action name")
	end
})

return Actions