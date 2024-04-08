---@diagnostic disable: deprecated

-- Checking current game

if game.PlaceId == 1204176775 then

    local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))() -- GUI Lib

    -- Main window creation

    local Window = Rayfield:CreateWindow({
        Name = "Elevated - South Bronx",
        LoadingTitle = "Elevated Interface Suite",
        LoadingSubtitle = "by @atomicdevelopment",
        ConfigurationSaving = {
            Enabled = true,
            FolderName = nil, -- Create a custom folder for your hub/game
            FileName = "Elevated"
        },
        Discord = {
            Enabled = false,
            Invite = "elevatedcheats", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
            RememberJoins = true -- Set this to false to make them join the discord every time they load it up
        },
        KeySystem = true, -- Set this to true to use our key system
        KeySettings = {
            Title = "Elevated - Login",
            Subtitle = "Discord.gg/elevatedcheats",
            Note = "Get key a key from discord.",
            FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
            SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
            GrabKeyFromSite = true, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
            Key = {"key1", "key2"} -- List of keys that will be accepted by the system, can be RAW file links (pastebin, github etc) or simple strings ("hello","key22")
        }
    })

    -- Tab creation

    local MainTab = Window:CreateTab("Main", 4483362458)
    local MainSection = MainTab:CreateSection("Home")

    local WeaponsTab = Window:CreateTab("Weapons", 4483362458)
    local WeaponsSection = WeaponsTab:CreateSection("Weapon Options")

    local VisualsTab = Window:CreateTab("Visuals", 4483362458)
    local VisualsSection = VisualsTab:CreateSection("Visual Options")

    local MiscTab = Window:CreateTab("Misc", 4483362458)
    local MiscSection = MiscTab:CreateSection("Misc")

    local ConfigTab = Window:CreateTab("Configs", 4483362458)
    local ConfigSection = ConfigTab:CreateSection("Configs")

    -- Variables
    
    local InfiniteJumpEnabled = false

    Rayfield:Notify({
        Title = "Elevated Cheats",
        Content = "Successfully injected into south bronx.",
        Duration = 5.5,
        Image = nil,
        Actions = {}, -- Notification Buttons
     })

     -- Main Tab

     local Button = MainTab:CreateButton({
        Name = "Infinite Jump",
        Callback = function()
            InfiniteJumpEnabled = not InfiniteJumpEnabled
            game:GetService("UserInputService").JumpRequest:connect(function()
                if InfiniteJumpEnabled then
                    game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
                end
            end)
        end,
     })

     -- Visuals Tab

     local ESP = VisualsTab:CreateToggle({
        Name = "Enable ESP",
        CurrentValue = false,
        Flag = "ESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function()
        end,
     })

     local NameESP = VisualsTab:CreateToggle({
        Name = "Names",
        CurrentValue = false,
        Flag = "NameESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)

            local function API_Check()
                if Drawing == nil then
                    return "No"
                else
                    return "Yes"
                end
            end
            
            local Find_Required = API_Check()
            
            if Find_Required == "No" then
                game:GetService("StarterGui"):SetCore("SendNotification",{
                    Title = "Exunys Developer";
                    Text = "ESP script could not be loaded because your exploit is unsupported.";
                    Duration = math.huge;
                    Button1 = "OK"
                })

                return
            end
            
            local Players = game:GetService("Players")
            local RunService = game:GetService("RunService")
            local UserInputService = game:GetService("UserInputService")
            local Camera = workspace.CurrentCamera
            
            local Typing = false
            
            _G.SendNotifications = false   -- If set to true then the script would notify you frequently on any changes applied and when loaded / errored. (If a game can detect this, it is recommended to set it to false)
            _G.DefaultSettings = false   -- If set to true then the ESP script would run with default settings regardless of any changes you made.
            
            _G.TeamCheck = false   -- If set to true then the script would create ESP only for the enemy team members.
            
            _G.ESPVisible = true   -- If set to true then the ESP will be visible and vice versa.
            _G.TextColor = Color3.fromRGB(255, 255, 255)   -- The color that the boxes would appear as.
            _G.TextSize = 12   -- The size of the text.
            _G.Center = true   -- If set to true then the script would be located at the center of the label.
            _G.Outline = true   -- If set to true then the text would have an outline.
            _G.OutlineColor = Color3.fromRGB(255, 255, 255)   -- The outline color of the text.
            _G.TextTransparency = 0.7   -- The transparency of the text.
            _G.TextFont = Drawing.Fonts.UI   -- The font of the text. (UI, System, Plex, Monospace) 
            
            _G.DisableKey = Enum.KeyCode.Q   -- The key that disables / enables the ESP.
            
            local function CreateESP()
                for _, v in next, Players:GetPlayers() do
                    if v.Name ~= Players.LocalPlayer.Name then
                        local ESP = Drawing.new("Text")
            
                        RunService.RenderStepped:Connect(function()
                            if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                                local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
            
                                ESP.Size = _G.TextSize
                                ESP.Center = _G.Center
                                ESP.Outline = _G.Outline
                                ESP.OutlineColor = _G.OutlineColor
                                ESP.Color = _G.TextColor
                                ESP.Transparency = _G.TextTransparency
                                ESP.Font = _G.TextFont
            
                                if OnScreen == true then
                                    local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                                    local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                                    local Dist = (Part1 - Part2).Magnitude
                                    ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                                    ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                                    if _G.TeamCheck == true then 
                                        if Players.LocalPlayer.Team ~= v.Team then
                                            ESP.Visible = _G.ESPVisible
                                        else
                                            ESP.Visible = false
                                        end
                                    else
                                        ESP.Visible = _G.ESPVisible
                                    end
                                else
                                    ESP.Visible = false
                                end
                            else
                                ESP.Visible = false
                            end
                        end)
            
                        Players.PlayerRemoving:Connect(function()
                            ESP.Visible = false
                        end)
                    end
                end
            
                Players.PlayerAdded:Connect(function(Player)
                    Player.CharacterAdded:Connect(function(v)
                        if v.Name ~= Players.LocalPlayer.Name then 
                            local ESP = Drawing.new("Text")
                
                            RunService.RenderStepped:Connect(function()
                                if workspace:FindFirstChild(v.Name) ~= nil and workspace[v.Name]:FindFirstChild("HumanoidRootPart") ~= nil then
                                    local Vector, OnScreen = Camera:WorldToViewportPoint(workspace[v.Name]:WaitForChild("Head", math.huge).Position)
                
                                    ESP.Size = _G.TextSize
                                    ESP.Center = _G.Center
                                    ESP.Outline = _G.Outline
                                    ESP.OutlineColor = _G.OutlineColor
                                    ESP.Color = _G.TextColor
                                    ESP.Transparency = _G.TextTransparency
                
                                    if OnScreen == true then
                                        local Part1 = workspace:WaitForChild(v.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position
                                    local Part2 = workspace:WaitForChild(Players.LocalPlayer.Name, math.huge):WaitForChild("HumanoidRootPart", math.huge).Position or 0
                                        local Dist = (Part1 - Part2).Magnitude
                                        ESP.Position = Vector2.new(Vector.X, Vector.Y - 25)
                                        ESP.Text = ("("..tostring(math.floor(tonumber(Dist)))..") "..v.Name.." ["..workspace[v.Name].Humanoid.Health.."]")
                                        if _G.TeamCheck == true then 
                                            if Players.LocalPlayer.Team ~= Player.Team then
                                                ESP.Visible = _G.ESPVisible
                                            else
                                                ESP.Visible = false
                                            end
                                        else
                                            ESP.Visible = _G.ESPVisible
                                        end
                                    else
                                        ESP.Visible = false
                                    end
                                else
                                    ESP.Visible = false
                                end
                            end)
                
                            Players.PlayerRemoving:Connect(function()
                                ESP.Visible = false
                            end)
                        end
                    end)
                end)
            end
            
            if _G.DefaultSettings == true then
                _G.TeamCheck = false
                _G.ESPVisible = false
                _G.TextColor = Color3.fromRGB(40, 90, 255)
                _G.TextSize = 14
                _G.Center = true
                _G.Outline = false
                _G.OutlineColor = Color3.fromRGB(0, 0, 0)
                _G.DisableKey = Enum.KeyCode.Q
                _G.TextTransparency = 0.75
            end
            
            UserInputService.TextBoxFocused:Connect(function()
                Typing = true
            end)
            
            UserInputService.TextBoxFocusReleased:Connect(function()
                Typing = false
            end)
            
            local Success, Errored = pcall(function()
                CreateESP()
            end)

            if Value then
                _G.ESPVisible = not _G.ESPVisible
            end
            
        end,
     })

end
