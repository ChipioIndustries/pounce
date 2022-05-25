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
	DeckSize = 52;
	PadCount = 4;
	StackSize = 13;
	DeckViewableCardsCount = 3;
	MinimumPileDistance = 0.1;
	Responses = {
		NotInMatch = "Player is not currently in a match";
		GameAlreadyEnded = "Someone has already pounced!";
	};
}

return CONFIG