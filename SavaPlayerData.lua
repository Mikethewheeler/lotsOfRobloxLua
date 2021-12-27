local DataStoreService = game:GetService("DataStoreService")
local DataStore = DataStoreService:GetDataStore("ObbyDataStore")

game.Players.PlayerAdded:Connect(function(player)
	local data
	
	local success, errorMessage = pcall(function()
		data = DataStore:GetAsync(player.UserId.."-stage")
		print(data) 
	end)
	if success then
		print("Success, loaded ObbyDataStore")
		if data then
			player.Team = game.Teams[data]
		else
			player.Team = game.Teams.Stage1
		end
	else
		print(errorMessage)
		player.Team = game.Teams.Stage1
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	local teamName = player.Team.Name
	
	local success, errorMessage = pcall(function()
		DataStore:SetAsync(player.UserId.."-stage", teamName)
	end)
	if success then
		print("Saved data succesfully")
	else
		print(errorMessage)
	end
end)
