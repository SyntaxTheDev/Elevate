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

end
