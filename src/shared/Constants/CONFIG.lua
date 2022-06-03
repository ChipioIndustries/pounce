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
		[1] = "A";
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
	CardPositionCacheFlushRate = 5;
	CardPositionCacheLifetime = 5;
	DeckSize = 52;
	DeckViewableCardsCount = 3;
	Images = {
		Logo = "rbxassetid://9352329372";
		Suits = {
			["A"] = "rbxassetid://9734714805";
			["B"] = "rbxassetid://9734715544";
			["C"] = "rbxassetid://9734717007";
			["D"] = "rbxassetid://9734716255";
		};
	};
	Interface = {
		BackgroundTransparency = 0.5;
		CardBackColor = Color3.fromRGB(126, 66, 59);
		CardColors = {
			["black"] = Color3.new(0, 0, 0);
			["red"] = Color3.new(1, 0.2, 0.2);
		};
		CardSize = UDim2.new(0, 60, 0, 80);
		CardColumnOffset = {
			Horizontal = 12;
			Vertical = 16;
		};
		FieldSize = 0.6;
		StackBottomCardOffset = UDim2.new(0, 0, 0, 4);
		Signature = {
			CenterIconSize = UDim2.new(0, 24, 0, 24);
			DecoratorSize = UDim2.new(0, 18, 0, 18);
			IconSize = UDim2.new(0, 12, 0, 12);
			Size = UDim2.new(1, 0, 0, 18);
		};
		TextFont = Enum.Font.FredokaOne;
		Title = "pounce!";
	};
	PadCount = 5;
	StackSize = 13;
	MatchIntermission = 1;
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
	Sounds = {
		Deselect = 9810498077;
		Error = 160715357;
		Place = 9810558987;
		Select = 9810496988;
		Slide = 9810703505;
	};
	Statuses = {
		GameOver = "Game over, %s won!";
		Waiting = "Waiting for a match...";
	};
	TableTag = "Table";
}

return CONFIG