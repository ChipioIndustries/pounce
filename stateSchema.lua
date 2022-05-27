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
						["A1"] = "id1",
						["A2"] = "id2",
						["A3"] = "id3",
						["A4"] = "id4",
					},
					position = UDim2.new(),
				}
			}
		}
	}
}
