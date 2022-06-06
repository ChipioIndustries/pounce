---
sidebar_position: 3
title: State Outline
---

# State Outline

This project uses Rodux, a library for centralizing game state. The store state matches the following structure:

```lua
local state = {
	activeMatches = {
		["GUID"] = {
			players = {
				["id1"] = {
					stack = { -- column the player needs to empty to win
						"A2",
						"A10",
						"D4",
						"D1"
					},
					pad = { -- AKA columns
						[1] = {
							"A13",
							"D12",
							"C11",
							"D10",
							"C9",
							"B8",
						}
					},
					deck = {
						"A2",
						"A10",
						"D4",
						"D1",
					};
					deckPosition = 28,
					pounced = false,
					quit = false,
				}
			},
			field = { -- AKA piles
				["GUID"] = {
					cards = {
						[1] = {
							playerId = "id1",
							signature = "A1"
						};
						[2] = {
							playerId = "id2",
							signature = "A2"
						};
						[3] = {
							playerId = "id1",
							signature = "A3"
						};
					},
					position = UDim2.new(),
				}
			}
		}
	};
	selection = { -- can be nil. client-exclusive.
		origin = Enums.CardOrigin.Column;
		column = 4; --optional
		index = 2; --optional
	}
}
```

## Player Ids

Player Ids are `UserId`s converted to strings. This is done because using numbers as non-sequential keys is a nightmare for replication and iteration in general.

## Card Signatures

Card signatures are short strings consisting of a card's suit and value combined together. Suits are single characters, and values are numbers.

|Suit|Value|Signature|
|-|-|-|
|A|Q|`"A12"`|
|D|4|`"D4"`|
|C|1|`"C1"`|
