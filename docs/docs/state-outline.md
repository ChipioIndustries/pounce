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
					stack = {
						"A2",
						"A10",
						"D4",
						"D1"
					},
					pad = {
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
			field = {
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
	selection = {
		origin = Enums.CardOrigin.Column;
		column = 4;
		index = 2;
	}
}

```