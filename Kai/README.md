local config = getgenv().Configs or {
    ["Automatically Kaitan"] = true,
}

config = getgenv().Configs or config
local stage = nil

local function checkstage()
    if config["Automatically Kaitan"] then
        for i,v in pairs(workspace.Client.Maps:GetChildren()) do
            if v.Name == "Leaf Village" then
                stage = "Piece Town"
            elseif v.Name == "Piece Town" then
                stage = "Bizarre City"
            elseif v.Name == "Bizarre City" then
                stage = "Dragon World"
            elseif v.Name =="Dragon World" then
                stage = "Chimera Village"
            end
        end
    end
end

local mon = nil

local function checkmon()
    if config["Automatically Kaitan"] then
        for i,v in pairs(workspace.Client.Maps:GetChildren()) do
            if v.Name == "Leaf Village" then
                mon = "Ebito"
            elseif v.Name == "Piece Town" then
                mon = "Lucco"
            elseif v.Name == "Bizarre City" then
                mon = "Resot"
            elseif v.Name =="Dragon World" then
                mon = "Gran"
            end
        end
    end
end

local egg = nil

local function checktp()
    if config["Automatically Kaitan"] then
        for i,v in pairs(workspace.Client.Maps:GetChildren()) do
            if v.Name == "Leaf Village" then
                egg = "Leaf Village"
            elseif v.Name == "Piece Town" then
                egg = "Piece Town"
            elseif v.Name == "Bizarre City" then
                egg = "Bizarre City"
            elseif v.Name =="Dragon World" then
                egg = "Dragon World"
            end
        end
    end
end

spawn(function()
    while task.wait(1.5) do
        if config["Automatically Kaitan"] then
            checkstage()
            local args = {

					[1] = "General",
					[2] = "Teleport",
					[3] = "Buy",
					[4] = stage
				}

				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
        end
    end
end)

spawn(function()
	while task.wait() do
		if config["Automatically Kaitan"]then
		    checkmon()
			for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Pets.Background.Frame.List:GetChildren()) do
				if v.Name ~= "UIGridLayout" then
					local args = {
						[1] = "General",
						[2] = "Pets",
						[3] = "Attack",
						[4] = v.Name,
						[5] = workspace.Server.Enemies:WaitForChild(egg):WaitForChild(mon)
					}

					game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer(unpack(args))
				end
			end
		end
	end
end)

