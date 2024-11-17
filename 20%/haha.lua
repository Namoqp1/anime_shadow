local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
	Title = "paischooldailaw",
	SubTitle = "kuy",
	TabWidth = 160,
	Size = UDim2.fromOffset(580, 460),
	Acrylic = false,
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.LeftControl
})

local Tabs = {
	Main = Window:AddTab({ Title = "Main", Icon = "home" }),
	Eggs = Window:AddTab({ Title = "Eggs", Icon = "box" }),
	trial = Window:AddTab({ Title = "Trial", Icon = "bell" }),
	Mice = Window:AddTab({ Title = "Misc", Icon = "bug" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

_G.MapSelect = _G.MapSelect or "Leaf Village"
_G.SelectedStands = _G.SelectedStands or {}

local Farm = Tabs.Main:AddSection("| Select") 
local Mon = {}
local MonSet = {}
local map = {}
local mapset = {}

Mon = {}
MonSet = {}
map = {}
mapset = {}

if workspace.Server.Enemies[_G.MapSelect] then
	for i, v in pairs(workspace.Server.Enemies[_G.MapSelect]:GetChildren()) do
		if not MonSet[v.Name] then
			table.insert(Mon, v.Name)
			MonSet[v.Name] = true
		end
	end
end

if workspace.Server.Stars then
	for i, v in pairs(workspace.Server.Stars:GetChildren()) do
		if not mapset[v.Name] then
			table.insert(map, v.Name)
			mapset[v.Name] = true
		end
	end
end




local MapSelect = Farm:AddDropdown("MapSelect", {
	Title = "Select Map",
	Values = map,
	Multi = false,
	Default = _G.MapSelect,
	Callback = function(selected)
		_G.MapSelect = selected
		print(_G.MapSelect)
	end
})


local MonSelect = Farm:AddDropdown("MonSelect", {
	Title = "Select Monster",
	Values = Mon,
	Multi = false,
	Default = _G.MonSelect,
	Callback = function(selected)
		_G.MonSelect = selected
		print(_G.MonSelect)
	end
})

local function reset()
	Mon = {}
	MonSet = {}

	if workspace.Server.Enemies[_G.MapSelect] then
		for i, v in pairs(workspace.Server.Enemies[_G.MapSelect]:GetChildren()) do
			if not MonSet[v.Name] then
				table.insert(Mon, v.Name)
				MonSet[v.Name] = true
			end
		end
		MonSelect:SetValues(Mon)
	end
end


Farm:AddButton({
	Title = "Refresh Monster",
	Description = "",
	Callback = reset
})
reset()


local AutoFarm = Tabs.Main:AddSection("| Auto Farm")

local toggleAttack = AutoFarm:AddToggle("toggleAttack", {Title = "Auto Attack", Default = _G.Attack })
toggleAttack:OnChanged(function(bool)
	_G.Attack = bool
end)

spawn(function()
	while task.wait() do
		if _G.Attack then
			for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Pets.Background.Frame.List:GetChildren()) do
				if v.Name ~= "UIGridLayout" then
					local args = {
						[1] = "General",
						[2] = "Pets",
						[3] = "Attack",
						[4] = v.Name,
						[5] = workspace.Server.Enemies:WaitForChild(_G.MapSelect):WaitForChild(_G.MonSelect)
					}

					game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer(unpack(args))
				end
			end
		end
	end
end)


local toggleClick = AutoFarm:AddToggle("toggleClick", {Title = "Auto Click", Default = _G.Click })
toggleClick:OnChanged(function(bool)
	_G.Click = bool
end)


spawn(function()
	while task.wait() do
		if _G.Click then
			local args = {
				[1] = "Enemies",
				[2] = "World",
				[3] = "Click"
			}

			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
		end
	end
end)

local AutoEgg = Tabs.Eggs:AddSection("| Star")

local kuy = AutoEgg:AddDropdown("Select_Star", {
	Title = "Select Star",
	Values = map,
	Multi = false,
	Default = _G.Egg,
	Callback = function(Egg)
		_G.Egg = Egg
	end
})


local toggleStar = AutoEgg:AddToggle("toggleStar", {Title = "Auto Star", Default = _G.Star })
toggleStar:OnChanged(function(bool)
	_G.Star = bool
end)

spawn(function()
	while task.wait() do
		if _G.Star then
			local data = require(game:GetService("ReplicatedStorage").Shared.Stars[_G.Egg])
			_G.coinsPrice = data.Coins.Price
			local xpel = tonumber(_G.coinsPrice)
			local coinsText = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Left_Container.Currency.Coins.Container.Amount.Text
			local coinsWithoutComma = coinsText:gsub(",", "")
			local mycoin = tonumber(coinsWithoutComma)
			print(mycoin)
			if mycoin >= xpel then
				repeat task.wait()
					local args = {
						[1] = "General",
						[2] = "Stars",
						[3] = "Open",
						[4] = _G.Egg,
						[5] = "Coins"
					}

					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
				until _G.Star == false
			end
		end
	end
end)


local toggleTPStar = AutoEgg:AddToggle("toggleTPStar", {Title = "AUTO TP TO STAR", Default = _G.TPStar })
toggleTPStar:OnChanged(function(bool)
	_G.TPStar = bool
end)

spawn(function()
	while task.wait() do
		if _G.TPStar then
			for i,v in pairs(workspace.Server.Stars:GetChildren()) do
				if v.Name == _G.Egg then
					local naja = v.Name
					repeat task.wait()
						game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Server.Stars[naja].Coins.Arrow.CFrame
					until _G.TPStar == false
				end
			end
		end
	end
end)

local plstrial = Tabs.trial:AddSection("| Trial")

local toggleTrial = plstrial:AddToggle("toggleTrial", {Title = "Auto Trial", Default = _G.Trial })
toggleTrial:OnChanged(function(bool)
	_G.Trial = bool
end)

local playerPosition = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
local closestEnemy = nil
local shortestDistance = math.huge






spawn(function()
	while task.wait() do
		if true then
			if game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Trial.Visible == true then
				wait(2.5)
				local args = {
					[1] = "Enemies",
					[2] = "Trial_Easy",
					[3] = "Join"
				}

				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
			else
				for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Pets.Background.Frame.List:GetChildren()) do
					for n,m in pairs(workspace.Server.Enemies["Leaf Village"]:GetChildren()) do
					if v.Name ~= "UIGridLayout" then
						local args = {
							[1] = "General",
							[2] = "Pets",
							[3] = "Attack",
							[4] = v.Name,
							[5] = workspace.Server.Enemies:WaitForChild("Leaf Village"):WaitForChild(m.Name)
						}

						game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer(unpack(args))
						end
					end
				end
			end
		end
	end
end)






local PLSMICE = Tabs.Mice:AddSection("| Misc")

local toggleMagnet = PLSMICE:AddToggle("toggleMagnet", {Title = "Auto Magnet", Default = _G.magnet })
toggleMagnet:OnChanged(function(bool)
	_G.magnet = bool
end)

spawn(function()
	while task.wait() do
		if _G.magnet then
			for i,v in pairs(workspace.Client.Drops:GetChildren()) do
				if #v:GetChildren() >= 1 then
					local args = {
						[1] = "General",
						[2] = "Drops",
						[3] = "Collect",
						[4] = v.Name
					}

					game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
				end
			end
		end
	end
end)


local toggleUnlock = PLSMICE:AddToggle("toggleUnlock", {Title = "Auto Unlock", Default = _G.Unlock })
toggleUnlock:OnChanged(function(bool)
	_G.Unlock = bool
end)


spawn(function()
	while task.wait(1) do
		if _G.Unlock then
			for i,v in pairs(workspace.Client.Portals:GetChildren()) do
				local args = {
					[1] = "General",
					[2] = "Teleport",
					[3] = "Buy",
					[4] = v.Name
				}

				game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))
			end
		end
	end
end)

Tabs.Mice:AddToggle("Anti AFK", {
	Title = "Anti AFK", 
	Default = true, 
	Callback = function(cbx) 
		_G.AntiAFKEnabled = cbx
		local vu = game:GetService("VirtualUser")
		game.Players.LocalPlayer.Idled:connect(function()
			if _G.AntiAFKEnabled then
				vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
				wait(1)
				vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
			end
		end)
	end})






