print('loaded builder')

local HttpService = game:GetService("HttpService")
local admin = 125785010
	
local serverUrl = 'https://raw.githubusercontent.com/zzraawashere/EZAdmin/main/server'
local clientUrl = 'https://raw.githubusercontent.com/zzraawashere/EZAdmin/main/client'
local guiUrl = 'https://raw.githubusercontent.com/zzraawashere/EZAdmin/main/gui'

local adminCommand = Instance.new('RemoteEvent')
adminCommand.Name = 'adminCommand'
adminCommand.Parent = game.ReplicatedStorage
	
local message = Instance.new('RemoteEvent')
message.Name = 'message'  -- Changed the name to avoid conflict
message.Parent = game.ReplicatedStorage

local function fetchAndExecuteScript(url)
	local success, response = pcall(function()
		return HttpService:GetAsync(url)
	end)
	
	if success then
		local executeScript = loadstring(response)
		if executeScript then
			executeScript()
		else
			warn("Failed to create function from URL: " .. url)
		end
	else
		warn("Failed to fetch data from URL: " .. url)
	end
end
	
fetchAndExecuteScript(serverUrl)
	
local adminPlayer = game.Players:GetPlayerByUserId(admin)
if adminPlayer then
	fetchAndExecuteScript(guiUrl)
	wait(5)
	fetchAndExecuteScript(clientUrl)
else
	warn("Admin player not found")
end
	

