local Actions = {}

for _, module in ipairs(script:GetChildren()) do
	Actions[module.Name] = require(module)
end

return Actions