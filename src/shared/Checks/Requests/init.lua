--[[
	each module in this directory should correspond to
	the name of a serverside action that needs to be
	exposed to the client. a remote will be made using
	the module's name.
]]
local RequestChecks = {}

for _, module in ipairs(script:GetChildren()) do
	RequestChecks[module.Name] = require(module)
end

return RequestChecks