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
	CardSuits = {
		"A";
		"B";
		"C";
		"D";
	};
	CameraPosition = CFrame.new(5, 8, 0, 0, -0.87, 0.5, 0, 0.5, 0.87, -1, 0, 0);
	DeckSize = 52;
	DeckViewableCardsCount = 3;
	Images = {
		Logo = "rbxassetid://9352329372"
	};
	Interface = {
		BackgroundTransparency = 0.5;
		TextFont = Enum.Font.FredokaOne;
		Title = "pounce!";
	};
	PadCount = 4;
	StackSize = 13;
	MatchIntermission = 10;
	MaxPlayers = 4;
	MinPlayers = 1;
	-- based on card length = 80 and field size = 600
	MinimumPileDistance = 0.14;
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
	Statuses = {
		GameOver = "Game over, %s won!";
		Waiting = "Waiting for a match...";
	};
	TableTag = "Table";
}

return CONFIG