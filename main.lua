---@diagnostic disable: deprecated

-- Checking current game

local done = true
-- game.PlaceId == 1204176775
if done then

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

    local WeaponsTab = Window:CreateTab("Weapons", 4483362458)
    local WeaponsSection = WeaponsTab:CreateSection("Weapon Options")

    local VisualsTab = Window:CreateTab("Visuals", 4483362458)
    local VisualsSection = VisualsTab:CreateSection("Visual Options")

    local MiscTab = Window:CreateTab("Misc", 4483362458)
    local MiscSection = MiscTab:CreateSection("Misc")

    local ConfigTab = Window:CreateTab("Configs", 4483362458)
    local ConfigSection = ConfigTab:CreateSection("Configs")

    -- Checking API to ensure no anti exploit scripts are being utilized

    local function API_Check()
        if Drawing == nil then
            return "No"
        else
            return "Yes"
        end
    end
    
    if Find_Required == "No" then
        game:GetService("StarterGui"):SetCore("SendNotification",{
            Title = "Elevated Cheats";
            Text = "ESP script could not be loaded because your exploit is unsupported.";
            Duration = math.huge;
            Button1 = "OK"
        })
        return
    end

    -- Variables
    
    local InfiniteJumpEnabled = false
    local Noclip = nil
    local Clip = nil
    local NoClipEnabled = false
    local enableESP = false
    local nameESP = false
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Camera = workspace.CurrentCamera
    local Typing = false
    local Find_Required = API_Check()


    Rayfield:Notify({
        Title = "Elevated Cheats",
        Content = "Successfully injected into south bronx.",
        Duration = 5.5,
        Image = nil,
        Actions = {}, -- Notification Buttons
     })
     -- Main Tab
     local MainSection = MainTab:CreateSection("Main")

     local InfiniJump = MainTab:CreateButton({
        Name = "Infinite Jump",
        Callback = function()
            InfiniteJumpEnabled = not InfiniteJumpEnabled
            if InfiniteJumpEnabled then
                Rayfield:Notify({
                    Title = "Elevated Cheats",
                    Content = "Infinite Jump has been enabled.",
                    Duration = 5.5,
                    Image = nil,
                    Actions = {}, -- Notification Buttons
                 })
            else
                Rayfield:Notify({
                    Title = "Elevated Cheats",
                    Content = "Infinite Jump has been disabled.",
                    Duration = 5.5,
                    Image = nil,
                    Actions = {}, -- Notification Buttons
                 })

            end
            game:GetService("UserInputService").JumpRequest:connect(function()
                if InfiniteJumpEnabled then
                    game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
                end
            end)
        end,
     })

     local PlayerSpeed = MainTab:CreateSlider({
        Name = "Player Speed",
        Range = {16, 300},
        Increment = 1,
        Suffix = "Speed",
        CurrentValue = 16,
        Flag = "speed", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (Value)
        end,
     })


     local NoClipBind = MainTab:CreateKeybind({
         Name = "No Clip",
         CurrentKeybind = "N",
         HoldToInteract = false,
         Flag = "noclip", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
         Callback = function(Keybind)
             noclip()
         end,
     })

     local Coords = MainTab:CreateButton({
        Name = "Copy Coords",
        Callback = function()
            local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
            print(plr.CFrame)

            local ClipboardService = game:GetService("ClipboardService")
            ClipboardService.OnCopy = function(cut)
                return plr.CFrame;
            ClipboardService.OnPaste:connect(function(value)
            
            Rayfield:Notify({
                Title = "Elevated Cheats",
                Content = "Successfully copied your current Coords.",
                Duration = 5.5,
                Image = nil,
                Actions = {}, -- Notification Buttons
             })
        end,
     })
     
     local Dropdown = MainTab:CreateDropdown({
        Name = "Teleport",
        Options = {"Place #1","Place #2"},
        CurrentOption = {"Select"},
        MultipleOptions = false,
        Flag = "teleport", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Option)
            local selectedOption = Option[1]
            local plr = game.Players.LocalPlayer.Character.HumanoidRootPart
            local humanoid = game.Players.LocalPlayer.Character.Humanoid

            if selectedOption == "Place #1" then
                wait(0.1)
                humanoid:changeState(Enum.HumanoidStateType.Jumping)

                plr.CFrame = CFrame.new(-90, 3, 203)
            end
            if selectedOption == "Place #2" then
                wait(0.1)
                humanoid:changeState(Enum.HumanoidStateType.Jumping)

                plr.CFrame = CFrame.new(172, 1294, 185)
            end
        end,
     })


     -- Teleport Tab
     local MainSection = MainTab:CreateSection("Teleports")

     -- Visuals Tab

     local ESP = VisualsTab:CreateToggle({
        Name = "Enable ESP",
        CurrentValue = false,
        Flag = "ESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)
            if Value then
                enableESP = true
                print("ESP Value set to TRUE")
            else
                enableESP = false
                print("ESP Value set to FALSE")
            end

            if CurrentValue == false and nameESP == true then
                NameESP.CurrentValue = false;
            end
        end,
     })

     -- ESP Settings

     _G.SendNotifications = false
     _G.DefaultSettings = false
     _G.TeamCheck = false
     _G.ESPVisible = false
     _G.TextColor = Color3.fromRGB(40, 90, 255)
     _G.TextSize = 14
     _G.Center = true
     _G.Outline = false
     _G.OutlineColor = Color3.fromRGB(0, 0, 0)
     _G.TextTransparency = 0.7
     _G.TextFont = Drawing.Fonts.UI

     -- Creating / Drawing ESP Function

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
        _G.TextColor = Color3.fromRGB(255, 255, 255)
        _G.TextSize = 12
        _G.Center = true
        _G.Outline = false
        _G.OutlineColor = Color3.fromRGB(0, 0, 0)
        _G.TextTransparency = 0.75
    end
    
    UserInputService.TextBoxFocused:Connect(function()
        Typing = true
    end)
    
    UserInputService.TextBoxFocusReleased:Connect(function()
        Typing = false
    end)

     local NameESP = VisualsTab:CreateToggle({
        Name = "Names",
        CurrentValue = false,
        Flag = "NameESP", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
        Callback = function(Value)

            if Value and enableESP == true then
                _G.ESPVisible = true
                print("Adjusting Visible value to TRUE")
            else
                _G.ESPVisible = false
                print("Adjusting Visible value to FALSE")
            end

            if _G.ESPVisible and enableESP == true then
                Rayfield:Notify({
                    Title = "Elevated Cheats",
                    Content = "Name ESP enabled.",
                    Duration = 5.5,
                    Image = nil,
                    Actions = {},
                 })
            end
            if _G.ESPVisible == false and enableESP == true then
                Rayfield:Notify({
                    Title = "Elevated Cheats",
                    Content = "Name ESP disabled.",
                    Duration = 5.5,
                    Image = nil,
                    Actions = {},
                 })    
            end

            local Success, Errored = pcall(function()
                CreateESP()
            end)
            
        end,
     })


     function noclip()
        NoClipEnabled = not NoClipEnabled -- Toggle the state
        if NoClipEnabled then
            Clip = false
            local function Nocl()
                if Clip == false and game.Players.LocalPlayer.Character ~= nil then
                    for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                        if v:IsA('BasePart') and v.CanCollide and v.Name ~= floatName then
                            v.CanCollide = false
                        end
                    end
                end
                wait(0.21) -- basic optimization
            end
            Noclip = game:GetService('RunService').Stepped:Connect(Nocl)

            Rayfield:Notify({
               Title = "Elevated Cheats",
               Content = "No clip has been enabled.",
               Duration = 5.5,
               Image = nil,
               Actions = {}, -- Notification Buttons
            })

        else
            if Noclip then
               Noclip:Disconnect()

               Rayfield:Notify({
                   Title = "Elevated Cheats",
                   Content = "No clip has been disabled.",
                   Duration = 5.5,
                   Image = nil,
                   Actions = {}, -- Notification Buttons
                })
   
           end -- Disconnect the event if NoClip is disabled
        end
    end

end
