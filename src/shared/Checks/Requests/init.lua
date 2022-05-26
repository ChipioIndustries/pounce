local RequestChecks = {}

for _, module in ipairs(script:GetChildren()) do
	RequestChecks[module.Name] = require(module)
end

return RequestChecks