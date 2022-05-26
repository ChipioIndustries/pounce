local function combineChecks(checks)
	return function(...)
		for _, check in ipairs(checks) do
			local success, result = check(...)

			if not success then
				return success, result
			end
		end

		return true
	end
end

return combineChecks