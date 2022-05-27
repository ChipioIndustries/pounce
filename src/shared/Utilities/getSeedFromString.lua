local function getSeedFromString(text)
	local seed = 0
	for i = 1, #text do
		seed += text:sub(i, i):byte()
	end
	return seed
end

return getSeedFromString