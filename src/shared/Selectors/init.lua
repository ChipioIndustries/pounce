local Selectors = {}

for index, module in ipairs(script:GetChildren()) do
	Selectors[module.Name] = require(module)
end

return Selectors