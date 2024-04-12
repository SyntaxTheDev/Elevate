local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/SyntaxTheDev/Elevate/main/ui.lua'))()

local Window = Rayfield:CreateWindow({
    Name = "Elevated Cheats",
    LoadingTitle = "Elevated Interface Suite",
    LoadingSubtitle = "by @atomicdevelopment",
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil, -- Create a custom folder for your hub/game
       FileName = "Elevated Cheats"
    },
    Discord = {
       Enabled = false,
       Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD
       RememberJoins = true -- Set this to false to make them join the discord every time they load it up
    },
    KeySystem = false, -- Set this to true to use our key system
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key", -- It is recommended to use something unique as other scripts using Rayfield may overwrite your key file
       SaveKey = true, -- The user's key will be saved, but if you change the key, they will be unable to use your script
       GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
       Key = {"Hello"}
    }
 })

 Rayfield:Notify({
    Title = "Elevated Cheats",
    Content = "Injection Successfull.",
    Duration = 6.5,
    Image = nil,
    Actions = {},
 })

 local HomeTab = Window:CreateTab("Home", nil)
 local MainSection = HomeTab:CreateSection("Main")

 local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local block = Instance.new("Part")
block.Size = Vector3.new(10, 1, 10) -- Adjust the size as needed
block.Anchored = true
block.Transparency = 0.5
block.Parent = workspace

local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

local flying = false
local speed = 50 -- Adjust the speed as needed

local function rainbowColor(t)
    local frequency = 0.5 -- Adjust the frequency to control the speed of the color change
    local r = math.sin(frequency*t + 0) * 127 + 128
    local g = math.sin(frequency*t + 2*math.pi/3) * 127 + 128
    local b = math.sin(frequency*t + 4*math.pi/3) * 127 + 128
    return Color3.new(r/255, g/255, b/255)
end

local function updateColor()
    while true do
        local t = tick()
        block.BrickColor = BrickColor.new(rainbowColor(t))
        wait(0.1)
    end
end

coroutine.wrap(updateColor)()

local function startFlying()
    if not flying then
        flying = true
        runService:BindToRenderStep("Fly", Enum.RenderPriority.First.Value, function()
            local forward = character.HumanoidRootPart.CFrame.LookVector
            local right = character.HumanoidRootPart.CFrame.RightVector
            local up = character.HumanoidRootPart.CFrame.UpVector

            local moveDirection = Vector3.new(0, 0, 0)
            if userInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + forward
            end
            if userInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - forward
            end
            if userInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + right
            end
            if userInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - right
            end
            if userInputService:IsKeyDown(Enum.KeyCode.Space) then
                moveDirection = moveDirection + up
            end
            if userInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
                moveDirection = moveDirection - up
            end
            
            moveDirection = moveDirection.unit * speed
            character.HumanoidRootPart.Velocity = moveDirection
        end)
    end
end

local function stopFlying()
    flying = false
    runService:UnbindFromRenderStep("Fly")
    character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0) -- Stop the player's movement when flying is stopped
end

local function checkToggle()
    if flying then
        stopFlying()
    else
        startFlying()
    end
end

local FlyToggle = HomeTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "fly",
    Callback = checkToggle,
})

userInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or
       input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D or
       input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftControl then
        startFlying()
    end
end)

userInputService.InputEnded:Connect(function(input)
    if (input.KeyCode == Enum.KeyCode.W or input.KeyCode == Enum.KeyCode.A or
        input.KeyCode == Enum.KeyCode.S or input.KeyCode == Enum.KeyCode.D or
        input.KeyCode == Enum.KeyCode.Space or input.KeyCode == Enum.KeyCode.LeftControl) and flying then
        stopFlying()
    end
end)


 local NoClipToggle = HomeTab:CreateToggle({
    Name = "No Clip",
    CurrentValue = false,
    Flag = "noclip",
    Callback = function(Value)
        noclip()
    end,
 })

 local GodModeToggle = HomeTab:CreateToggle({
    Name = "Toggle Example",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)

    end,
 })

 local WeaponsTab = Window:CreateTab("Weapons", nil)
 local WeaponsSection = WeaponsTab:CreateSection("Weapon Options")

 local MiscTab = Window:CreateTab("Misc", nil)
 local MiscSection = MiscTab:CreateSection("Misc Options")

 -- Functions

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
