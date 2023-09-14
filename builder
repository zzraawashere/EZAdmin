local HttpService = game:GetService("HttpService")
local admin = 125785010

local serverUrl = 'https://raw.githubusercontent.com/zzraawashere/EZAdmin/main/server'
local clientUrl = 'https://raw.githubusercontent.com/zzraawashere/EZAdmin/main/client'
local guiUrl = 'https://raw.githubusercontent.com/zzraawashere/EZAdmin/main/gui'

local function fetchAndCreateScript(url, scriptType, parent)
	local success, response = pcall(function()
		return HttpService:GetAsync(url)
	end)

	if success then
		local newScript = Instance.new(scriptType)
		newScript.Source = response
		newScript.Parent = parent
	else
		warn("Failed to fetch data from URL: " .. url)
	end
end

fetchAndCreateScript(serverUrl, 'Script', game.ServerScriptService)

local adminPlayer = game.Players:GetPlayerByUserId(admin)
if adminPlayer then
	fetchAndCreateScript(guiUrl, 'LocalScript', adminPlayer:WaitForChild("PlayerGui"))
	wait(5)
	fetchAndCreateScript(clientUrl, 'LocalScript', adminPlayer:WaitForChild("PlayerGui"))
else
	warn("Admin player not found")
end

local adminCommand = Instance.new('RemoteEvent')
adminCommand.Name = 'adminCommand'
adminCommand.Parent = game.ReplicatedStorage

local message = Instance.new('RemoteEvent')
message.Name = 'messageEvent'  -- Changed the name to avoid conflict
message.Parent = game.ReplicatedStorage
