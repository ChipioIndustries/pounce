return function()
	local Cards = require(script.Parent.Cards)
	describe("Cards.lua", function()
		describe("getColor", function()
			local colorsOverride = {
				["blue"] = {
					"A";
					"C"
				};
				["red"] = {
					"B";
					"D"
				};
			}

			it("should return the color of the signature", function()
				local result1 = Cards:getColor("A1", colorsOverride)
				local result2 = Cards:getColor("B11", colorsOverride)

				expect(result1).to.equal("blue")
				expect(result2).to.equal("red")
			end)

			it("should error when receiving a number and not a signature", function()
				expect(function()
					Cards:getColor(1)
				end).to.throw()
			end)
		end)

		describe("getSignature", function()
			it("should return the signature", function()
				local result1 = Cards:getSignature("A", 12)
				local result2 = Cards:getSignature("B", 1)

				expect(result1).to.equal("A12")
				expect(result2).to.equal("B1")
			end)
		end)

		describe("getSuit", function()
			it("should return the suit", function()
				local result1 = Cards:getSuit("A1")
				local result2 = Cards:getSuit("B12")

				expect(result1).to.equal("A")
				expect(result2).to.equal("B")
			end)

			it("should fail when receiving value", function()
				expect(function()
					Cards:getSuit(1)
				end).to.throw()
			end)
		end)

		describe("getValue", function()
			it("should return the value", function()
				local result1 = Cards:getValue("A1")
				local result2 = Cards:getValue("B12")

				expect(result1).to.equal(1)
				expect(result2).to.equal(12)
			end)

			it("should fail when receiving value", function()
				expect(function()
					Cards:getValue(1)
				end).to.throw()
			end)

			it("should fail when receiving suit", function()
				expect(function()
					Cards:getValue("A")
				end).to.throw()
			end)
		end)
	end)
end