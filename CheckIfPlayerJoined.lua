local Players = game:GetService("Players")
local dataStoreService = game:GetService("DataStoreService")
local DataStore = dataStoreService:GetDataStore("PlayedJoinedCheck")


Players.PlayerAdded:Connect(function(player)
	local Data 
	--get their datastore value(may fail if servers are down)
	local Success, Error = pcall(function()
		Data = DataStore:GetAsync(player.UserId)
	end)
	if Success then 
		if Data then
			print(player.DisplayName.." has joined on the past") 
		else 
			print(player.DisplayName.." joined for the first time")
			pcall(function() -- After first join, set to true
				DataStore:SetAsync(player.UserId, true)
			end)
		end
	else 
		warn("Failed to load "..player.DisplayName.." data("..Error..")")
	end
end)
