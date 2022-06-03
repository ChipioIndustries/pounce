local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CONFIG = require(ReplicatedStorage.Constants.CONFIG)

local Sound = {}
local cache = {}

local function cacheSound(id)
	if not cache[id] then
		local newSound = Instance.new("Sound")
		newSound.SoundId = "rbxassetid://" .. id
		newSound.Parent = script
		cache[id] = newSound
	end
end

function Sound:play(soundId)
	cacheSound(soundId)
	local soundCopy = cache[soundId]:Clone()
	soundCopy.Parent = workspace
	soundCopy:Play()
	soundCopy.Ended:Connect(function()
		soundCopy:Destroy()
	end)
end

for _, soundId in pairs(CONFIG.Sounds) do
	cacheSound(soundId)
end

task.spawn(function()
	ContentProvider:PreloadAsync(script:GetChildren())
end)

return Sound