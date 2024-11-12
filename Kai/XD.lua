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



local laka = nil



local function checklaka()

	if config["Automatically Kaitan"] then

		for i,v in pairs(workspace.Client.Maps:GetChildren()) do

			if v.Name == "Leaf Village" then

				laka = 10000

			elseif v.Name == "Piece Town" then

				laka = 75000

			elseif v.Name == "Bizarre City" then

				laka = 450000

			elseif v.Name =="Dragon World" then

				laka = nil

			end

		end

	end

end



spawn(function()

	while task.wait(1.5) do

		if config["Automatically Kaitan"] then

			local coinsText = game:GetService("Players").LocalPlayer.PlayerGui.UI.HUD.Left_Container.Currency.Coins.Container.Amount.Text

			local coinsWithoutComma = coinsText:gsub(",", "")

			local mycoin = tonumber(coinsWithoutComma)

			checklaka()

			if mycoin >= laka then

			checkstage()

			local args = {



				[1] = "General",

				[2] = "Teleport",

				[3] = "Buy",

				[4] = stage

			}



			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))

			local args = {

					[1] = "General",

					[2] = "Teleport",

					[3] = "Teleport",

					[4] = stage

				}



			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))

			end

		end

	end

end)



spawn(function()

	while task.wait() do

		if config["Automatically Kaitan"]then

			checkmon()

			for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Pets.Background.Frame.List:GetChildren()) do

				for m,n in pairs(workspace.Client.Maps:GetChildren()) do

					if v.Name ~= "UIGridLayout" then

						local args = {

							[1] = "General",

							[2] = "Pets",

							[3] = "Attack",

							[4] = v.Name,

							[5] = workspace.Server.Enemies:WaitForChild(n.Name):WaitForChild(mon)

						}



						game:GetService("ReplicatedStorage").Remotes.Bridge:FireServer(unpack(args))

					end

				end

			end

		end

	end

end)



spawn(function()

	while task.wait() do

		if config["Automatically Kaitan"] then

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



local ezxd = {}



local function check_kai()

	if config["Automatically Kaitan"] then

		for i,v in pairs(workspace.Client.Maps:GetChildren()) do

			if v.Name == "Leaf Village" then

				ezxd = {

					"Sakore",

					"Lee Sin",

					"Garee",

					"Kebashi",

					"Sasuko",

					"Neroto",

					"Itacho",

					"Hoshirame",

					"Mineto"

				}

			elseif v.Name == "Piece Town" then

				ezxd = {

					"Kobi",

					"Kome",

					"Sobe",

					"Zore",

					"Marce",

					"Edwerd"

				}

			elseif v.Name == "Bizarre City" then

				ezxd = {

					"Jonan",

					"Joly",

					"Kera",

					"Josu",

					"Georne",

					"Jote"

				}

			elseif v.Name =="Dragon World" then

				ezxd = {

					"Keririn",

					"Mr San",

					"Trank",

					"Peccole",

					"San Geko",

					"Vogete"

				}

			end

		end

	end

end



spawn(function()

	while task.wait() do

		if config["Automatically Kaitan"] then

			check_kai()

			checktp()

			for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.UI.Frames.Pets.Background.Frame.List:GetDescendants()) do

				if v:IsA("Model") and table.find(ezxd,v.Name) and #v:GetDescendants() >= 3 then

					print("Ez")

				else

					for e,z in pairs(workspace.Client.Maps:GetChildren()) do

							local naja = z.Name

							print(naja)

							repeat task.wait()

								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.Server.Stars[naja].Coins.Arrow.CFrame

								local args = {

									[1] = "General",

									[2] = "Stars",

									[3] = "Open",

									[4] = egg,

									[5] = "Coins"

								}

								game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))

								print(v.Name)

							until v:IsA("Model") and table.find(ezxd,v.Name) and #v:GetDescendants() >= 3

					end

				end

			end

		end

	end

end)





spawn(function()

	while task.wait() do

		if config["Automatically Kaitan"] then

			wait(60)

			local args = {

				[1] = "General",

				[2] = "Pets",

				[3] = "Equip_Best"

			}



			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))

		end

	end

end)



spawn(function()

	while task.wait() do

		if config["Automatically Kaitan"] then

			local args = {

				[1] = "Enemies",

				[2] = "World",

				[3] = "Click"

			}



			game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("Bridge"):FireServer(unpack(args))

		end

	end

end)
