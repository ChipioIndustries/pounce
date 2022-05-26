local CONFIG = {
	CardColors = {
		["black"] = {
			"A";
			"C";
		};
		["red"] = {
			"B";
			"D";
		};
	};
	CardSuits = {
		"A";
		"B";
		"C";
		"D";
	};
	CardDecorators = {
		[1] = "1";
		[2] = "2";
		[3] = "3";
		[4] = "4";
		[5] = "5";
		[6] = "6";
		[7] = "7";
		[8] = "8";
		[9] = "9";
		[10] = "10";
		[11] = "J";
		[12] = "Q";
		[13] = "K";
	};
	CameraPosition = CFrame.new(4, 8, 0, 0, -0.87, 0.5, 0, 0.5, 0.87, -1, 0, 0);
	DeckSize = 52;
	PadCount = 4;
	StackSize = 13;
	DeckViewableCardsCount = 3;
	MinimumPileDistance = 0.1;
	MatchIntermission = 10;
	MinPlayers = 1;
	MaxPlayers = 4;
	Responses = {
		GameAlreadyEnded = "Someone has already pounced!";
		InvalidOrigin = "Invalid origin, stop exploiting :eyes:";
		NoCard = "No card to move!";
		NotInMatch = "You're not currently in a match!";
		PileStartRequiresAce = "You need an ace to create a new pile!";
		PilesTooClose = "Too close to another pile!";
		SameColor = "These cards are the same color!";
		StackNotCleared = "Your stack isn't empty yet!";
		TooManyCards = "Column doesn't have enough cards to move";
		WrongValue = "This card is too high or low to go here!";
		WrongSuit = "This card's suit doesn't match!";
	};
}

return CONFIG