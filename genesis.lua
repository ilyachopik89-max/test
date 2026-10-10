task.spawn(function()
local Players = game:GetService('Players')
local TweenService = game:GetService('TweenService')
local RunService = game:GetService('RunService')
local Stats = game:GetService('Stats')
local plr = Players.LocalPlayer

local gui = plr:WaitForChild('PlayerGui'):WaitForChild('MenuGui')
local TopRight = gui:WaitForChild('TopRight')
local CoinsFrame = TopRight:WaitForChild('CoinsFrame')
local CoinsDisplay = CoinsFrame:WaitForChild('CoinsDisplay')
local CoinImage = CoinsDisplay:WaitForChild('CoinImage')
local Coins = CoinsDisplay:WaitForChild('Coins')
local CoinsButton = CoinsFrame:WaitForChild('CoinsButton')

for _, v in ipairs(CoinsFrame:GetChildren()) do
if v:IsA('UICorner') or v:IsA('UIStroke') or v:IsA('UIPadding') or v:IsA('UIGradient') then
v:Destroy()
end
end
for _, v in ipairs(CoinsDisplay:GetChildren()) do
if v:IsA('UIListLayout') then
v:Destroy()
end
end

local blur = Instance.new('ImageLabel')
blur.Name = 'GlassBlur'
blur.BackgroundTransparency = 1
blur.Size = UDim2.new(1, 0, 1, 0)
blur.Position = UDim2.new(0, 0, 0, 0)
blur.Image = 'rbxassetid://96010887466311'
blur.ImageTransparency = 0.88
blur.ScaleType = Enum.ScaleType.Stretch
blur.ZIndex = CoinsFrame.ZIndex - 1
blur.Parent = CoinsFrame

CoinsFrame.BackgroundColor3 = Color3.fromRGB(12, 14, 18)
CoinsFrame.BackgroundTransparency = 0.35
CoinsFrame.AutomaticSize = Enum.AutomaticSize.X
CoinsFrame.Size = UDim2.new(0, 0, 0, 74)

local corner = Instance.new('UICorner')
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = CoinsFrame

local padding = Instance.new('UIPadding')
padding.PaddingLeft = UDim.new(0, 15)
padding.PaddingRight = UDim.new(0, 15)
padding.Parent = CoinsFrame

local stroke = Instance.new('UIStroke')
stroke.Thickness = 1
stroke.Transparency = 0.6
stroke.Color = Color3.fromRGB(135, 206, 235)
stroke.Parent = CoinsFrame

local borderGrad = Instance.new('UIGradient')
borderGrad.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 206, 235)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(135, 206, 235)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 206, 235)),
})
borderGrad.Parent = stroke

task.spawn(function()
while CoinsFrame and CoinsFrame.Parent do
for i = 0, 360, 2 do
if not borderGrad or not borderGrad.Parent then break end
borderGrad.Rotation = i
task.wait(0.01)
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
layout.Padding = UDim.new(0, 12)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = CoinsDisplay

CoinImage.LayoutOrder = 1
CoinImage.BackgroundTransparency = 1
CoinImage.Size = UDim2.new(0, 50, 0, 50)
CoinImage.ImageColor3 = Color3.fromRGB(135, 206, 235)
CoinImage.AnchorPoint = Vector2.new(0, 0.5)
CoinImage.Position = UDim2.new(0, 0, 0.5, 0)

task.defer(function()
CoinImage.Image = 'rbxassetid://99960366240167'
end)

TweenService:Create(CoinImage, TweenInfo.new(2.2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
Position = CoinImage.Position + UDim2.new(0, 0, 0, -2),
}):Play()

Coins.LayoutOrder = 2
Coins.BackgroundTransparency = 1
Coins.AutomaticSize = Enum.AutomaticSize.X
Coins.TextXAlignment = Enum.TextXAlignment.Left
Coins.TextYAlignment = Enum.TextYAlignment.Center
Coins.Font = Enum.Font.GothamBold
Coins.TextSize = 22
Coins.Text = tostring(Coins.Text)

local textGrad = Instance.new('UIGradient')
textGrad.Color = ColorSequence.new({
ColorSequenceKeypoint.new(0, Color3.fromRGB(135, 206, 235)),
ColorSequenceKeypoint.new(0.5, Color3.fromRGB(135, 206, 235)),
ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 206, 235)),
})
textGrad.Parent = Coins

task.spawn(function()
while Coins and Coins.Parent do
for i = 0, 360, 4 do
if not textGrad or not textGrad.Parent then break end
textGrad.Rotation = i
task.wait(0.01)
end
end
end)

local statsContainer = Instance.new('Frame')
statsContainer.Name = 'StatsContainer'
statsContainer.LayoutOrder = 3
statsContainer.BackgroundTransparency = 1
statsContainer.AutomaticSize = Enum.AutomaticSize.X
statsContainer.Size = UDim2.new(0, 0, 0, 45)
statsContainer.Parent = CoinsDisplay

local verticalLayout = Instance.new('UIListLayout')
verticalLayout.FillDirection = Enum.FillDirection.Vertical
verticalLayout.VerticalAlignment = Enum.VerticalAlignment.Center
verticalLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
verticalLayout.Padding = UDim.new(0, 2)
verticalLayout.Parent = statsContainer

local fpsLabel = Instance.new('TextLabel')
fpsLabel.Name = 'FpsDisplay'
fpsLabel.BackgroundTransparency = 1
fpsLabel.AutomaticSize = Enum.AutomaticSize.X
fpsLabel.Size = UDim2.new(0, 0, 0, 18)
fpsLabel.Font = Enum.Font.GothamBold
fpsLabel.TextSize = 15
fpsLabel.TextColor3 = Color3.fromRGB(135, 206, 235)
fpsLabel.TextXAlignment = Enum.TextXAlignment.Left
fpsLabel.Text = '60 fps'
fpsLabel.Parent = statsContainer

local pingLabel = Instance.new('TextLabel')
pingLabel.Name = 'PingDisplay'
pingLabel.BackgroundTransparency = 1
pingLabel.AutomaticSize = Enum.AutomaticSize.X
pingLabel.Size = UDim2.new(0, 0, 0, 18)
pingLabel.Font = Enum.Font.GothamBold
pingLabel.TextSize = 15
pingLabel.TextColor3 = Color3.fromRGB(135, 206, 235)
pingLabel.TextXAlignment = Enum.TextXAlignment.Left
pingLabel.Text = '0 ms'
pingLabel.Parent = statsContainer

local FrameTimer = tick()
local FrameCounter = 0
local FPS = 60

local StatsConnection
StatsConnection = RunService.RenderStepped:Connect(function()
if not statsContainer or not statsContainer.Parent then
if StatsConnection then StatsConnection:Disconnect() end
return
end

FrameCounter = FrameCounter + 1
if (tick() - FrameTimer) >= 1 then
FPS = FrameCounter
FrameTimer = tick()
FrameCounter = 0
end

local pingValue = 0
pcall(function()
pingValue = math.floor(Stats.Network.ServerStatsItem['Data Ping']:GetValue())
end)

fpsLabel.Text = string.format('%s fps', math.floor(FPS))
pingLabel.Text = string.format('%s ms', pingValue)
end)

CoinsButton.BackgroundTransparency = 1
CoinsButton.Text = ''
CoinsButton.Size = UDim2.new(1, 0, 1, 0)
CoinsButton.ZIndex = CoinsFrame.ZIndex + 5

local function localTween(obj, ti, props)
if obj and obj.Parent then
TweenService:Create(obj, ti, props):Play()
end
end

CoinsButton.MouseEnter:Connect(function()
localTween(stroke, TweenInfo.new(0.2), {Transparency = 0.15})
end)
CoinsButton.MouseLeave:Connect(function()
localTween(stroke, TweenInfo.new(0.2), {Transparency = 0.6})
end)
CoinsButton.MouseButton1Down:Connect(function()
localTween(CoinsFrame, TweenInfo.new(0.08), {Size = UDim2.new(0, 0, 0, 71)})
end)
CoinsButton.MouseButton1Up:Connect(function()
localTween(CoinsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 0, 0, 74)})
end)
end)

do
    local UserInputService = game:GetService("UserInputService")
    local GuiService = game:GetService("GuiService")

    local function setupDeviceSupport()
        local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
        local isConsole = GuiService:IsTenFootInterface()
        local isPC = UserInputService.KeyboardEnabled and UserInputService.MouseEnabled

        if isMobile then

        elseif isConsole then

        elseif isPC then

        end
    end

    setupDeviceSupport()
end

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")
loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local icons = "https://raw.githubusercontent.com/deividcomsono/lucide-roblox-direct/refs/heads/main/source.lua"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local Options = Library.Options
local Toggles = Library.Toggles
Library.ForceCheckbox = true

ThemeManager.BuiltInThemes["Default"][2] = {
    BackgroundColor = "8e8e8e",
    MainColor = "7e7e7e",
    AccentColor = "ffffff",
    OutlineColor = "282828",
    FontColor = "ffffff",
}
ThemeManager.DefaultTheme = "Default"

local Window = Library:CreateWindow({
	Title = "Genesis v2",
	Footer = "Welcome to Genesis V2",
	NotifySide = "Right",
	Icon = 99960366240167,
	CornerRadius = 20,
	ShowCustomCursor = false,
    EnableCompacting = true, 
    SidebarCompacted = true,
})

local Loading = Library:CreateLoading({
    Title = "Genesis V2",
    Icon = 99960366240167,
    TotalSteps = 4
})
 
-- Loading...
Loading:SetMessage("Loading...")
Loading:SetDescription("Waiting for game to load...")
task.wait(1)
 
Loading:SetCurrentStep(1)
Loading:SetDescription("Loading assets...")
task.wait(1)
 
-- Show sidebar with information
Loading:SetCurrentStep(2)

Loading:SetCurrentStep(3)
Loading:SetMessage("Loaded udpates")
Loading:SetDescription("fully loaded")
task.wait(1)
 
Loading:SetCurrentStep(4)
Loading:SetDescription("Ready to start!")
Loading:Continue() -- Destroys the loader and opens the main window

--- 'Fun', 'smile', 'like Misc but with more things',

local Tabs = {
	Home = Window:AddTab('Home', 'house', 'main things here and info'),
	Defense = Window:AddTab('Protections', 'shield-plus', 'Protect you with cool antis'),
	Target = Window:AddTab('Loops', 'skull', 'loops people with good loops'),
	Grab = Window:AddTab('grab', 'hand', 'basic things'),
	Player = Window:AddTab('Player', 'user', 'client things like PCLD esp'),
	Misc = Window:AddTab('Misc', 'layers', 'packet and trigger bot ect'),
	Build = Window:AddTab('Build', 'brick-wall', 'Builds cool thing'),
	Fun = Window:AddTab('Fun', 'smile', 'like Misc but with more things'),
	Keybinds = Window:AddTab('Keybinds', 'keyboard', 'Configure keybinds'),
	Auras = Window:AddTab('Auras', 'radar', 'auras things'),
	["UI Settings"] = Window:AddTab("UI Settings", "settings")
}



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local PS = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local R = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = workspace
local Player = PS.LocalPlayer
local Camera = Workspace.CurrentCamera
local CE = RS:WaitForChild("CharacterEvents", 10)
local BeingHeld = Player:WaitForChild("IsHeld", 10)
local StruggleEvent = CE and CE:WaitForChild("Struggle")
local function notify(title, content, duration)
local rs = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChild("Humanoid") or char:WaitForChild("Humanoid")
Toggles.AutoReset:SetValue(true)
	Library:Notify({
		Title = title or "Notification",
		Description = content or "",
		Time = duration or 5,
	})
end

local paintPartsBackup = {}
local paintConnections = {}
local function deleteAllPaintParts()
	for _, obj in ipairs(Workspace:GetDescendants()) do
		if obj:IsA("BasePart") and obj.Name == "PaintPlayerPart" then
			local clone = obj:Clone()
			clone.Archivable = true
			paintPartsBackup[obj:GetDebugId()] = {
				clone = clone,
				parent = obj.Parent
			}
			obj:Destroy()
		end
	end
end
local function restorePaintParts()
	for _, data in pairs(paintPartsBackup) do
		if data.clone and data.parent then
			data.clone.Parent = data.parent
		end
	end
	paintPartsBackup = {}
end
local function watchNewPaintParts()
	table.insert(paintConnections, Workspace.DescendantAdded:Connect(function(obj)
		if obj:IsA("BasePart") and obj.Name == "PaintPlayerPart" then
			task.defer(function()
				if obj and obj.Parent then
					local clone = obj:Clone()
					clone.Archivable = true
					paintPartsBackup[obj:GetDebugId()] = {
						clone = clone,
						parent = obj.Parent
					}
					obj:Destroy()
				end
			end)
		end
	end))
end
local function disconnectWatchers()
	for _, conn in ipairs(paintConnections) do
		if conn.Connected then
			conn:Disconnect()
		end
	end
	paintConnections = {}
end
local function setTouchQuery(state)
	local char = Workspace:FindFirstChild(Player.Name)
	if not char then
		return
	end
	for _, v in ipairs(char:GetChildren()) do
		if v:IsA("Part") or v:IsA("BasePart") then
			v.CanTouch = state
			v.CanQuery = state
		end
	end
end
local antiGucciConnection
local safePosition
local restoreFrames = 0
local function spawnBlobman()
	local args = {
		[1] = "CreatureBlobman",
		[2] = CFrame.new(0, 5000000, 0),
		[3] = Vector3.new(0, 60, 0)
	}
	pcall(function()
		ReplicatedStorage.MenuToys.SpawnToyRemoteFunction:InvokeServer(unpack(args))
	end)
	local folder = Workspace:WaitForChild(Player.Name .. "SpawnedInToys", 5)
	if folder and folder:FindFirstChild("CreatureBlobman") then
		local blob = folder.CreatureBlobman
		if blob:FindFirstChild("Head") then
			blob.Head.CFrame = CFrame.new(0, 50000, 0)
			blob.Head.Anchored = true
		end
		notify("Success", "Blobman Spawned!", 3)
	end
end
function startAntiGucci()
	local character = Player.Character or Player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	safePosition = rootPart.Position
	local folder = Workspace:FindFirstChild(Player.Name .. "SpawnedInToys")
	local blob = folder and folder:FindFirstChild("CreatureBlobman")
	local seat = blob and blob:FindFirstChild("VehicleSeat")
	if not blob then
		spawnBlobman()
		task.wait(1)
		folder = Workspace:FindFirstChild(Player.Name .. "SpawnedInToys")
		blob = folder and folder:FindFirstChild("CreatureBlobman")
		seat = blob and blob:FindFirstChild("VehicleSeat")
	end
	if seat and seat:IsA("VehicleSeat") then
		rootPart.CFrame = seat.CFrame + Vector3.new(0, 2, 0)
		seat:Sit(humanoid)
	end
	humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
		if humanoid.Jump and humanoid.Sit then
			restoreFrames = 15
			safePosition = rootPart.Position
		end
	end)
	if antiGucciConnection then
		antiGucciConnection:Disconnect()
	end
	antiGucciConnection = R.Heartbeat:Connect(function()
		if not rootPart or not humanoid then
			return
		end
		ReplicatedStorage.CharacterEvents.RagdollRemote:FireServer(rootPart, 0)
		if restoreFrames > 0 then
			rootPart.CFrame = CFrame.new(safePosition)
			restoreFrames = restoreFrames - 1
		end
	end)
	task.spawn(function()
		while humanoid.Sit do
			task.wait(1)
		end
		task.wait(0.5)
		rootPart.CFrame = CFrame.new(safePosition)
	end)
end

Library:Notify({
    Title = "Genesis V2",
    Description = "Welcome to Genesis V2, by Cyr0_IHP",
    Time = 10,
	BigIcon = 99960366240167,
})


function stopAntiGucci()
	if antiGucciConnection then
		antiGucciConnection:Disconnect()
		antiGucciConnection = nil
	end
	local blobFolder = Workspace:FindFirstChild(Player.Name .. "SpawnedInToys")
	if blobFolder and blobFolder:FindFirstChild("CreatureBlobman") then
		blobFolder.CreatureBlobman:Destroy()
	end
end
local antiGucciConnectionTrain
local safePositionTrain
local restoreFramesTrain = 0
local function startAntiGucciTrain()
	local character = Player.Character or Player.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local rootPart = character:WaitForChild("HumanoidRootPart")
	safePositionTrain = rootPart.Position
	local folder = workspace.Map.AlwaysHereTweenedObjects
	local train = folder and folder:FindFirstChild("Train")
	local seat
	if train then
		for _, d in ipairs(train:GetDescendants()) do
			if d:IsA("Seat") then
				seat = d
				break
			end
		end
	end
	if seat then
		rootPart.CFrame = seat.CFrame + Vector3.new(0, 2, 0)
		seat:Sit(humanoid)
	end
	humanoid:GetPropertyChangedSignal("Jump"):Connect(function()
		if humanoid.Jump and humanoid.Sit then
			restoreFramesTrain = 15
			safePositionTrain = rootPart.Position
		end
	end)
	if antiGucciConnectionTrain then
		antiGucciConnectionTrain:Disconnect()
	end
	antiGucciConnectionTrain = R.Heartbeat:Connect(function()
		if not rootPart or not humanoid then
			return
		end
		ReplicatedStorage.CharacterEvents.RagdollRemote:FireServer(rootPart, 0)
		if restoreFramesTrain > 0 then
			rootPart.CFrame = CFrame.new(safePositionTrain)
			restoreFramesTrain = restoreFramesTrain - 1
		end
	end)
	task.spawn(function()
		while humanoid.Sit do
			task.wait(1)
		end
		task.wait(0.5)
		rootPart.CFrame = CFrame.new(safePositionTrain)
	end)
end
local function stopAntiGucciTrain()
	if antiGucciConnectionTrain then
		antiGucciConnectionTrain:Disconnect()
		antiGucciConnectionTrain = nil
	end
	local trainFolder = workspace.Map.AlwaysHereTweenedObjects
	if trainFolder and trainFolder:FindFirstChild("Train") then
		ResetPlayer(game.Players.LocalPlayer)
	end
end
local DefenseGroup = Tabs.Defense:AddLeftGroupbox("Defense Main", "shield")
local DefenseExtra = Tabs.Defense:AddRightGroupbox("Extra Defense", "shield-plus")
local antiGrabExplosionConn, antiGrabHeldConn, antiGrabStruggleConn, antiGrabHumConn, antiGrabAnchorConn
local antiGrabRootCF, antiGrabRootPos, antiGrabHardFreeze = nil, nil, false
local function antiGrabUnfreeze(char)
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Anchored = false
		if hrp:FindFirstChild("FreezeJoint") then
			hrp.FreezeJoint:Destroy()
		end
	end
	antiGrabHardFreeze = false
	if antiGrabAnchorConn then
		antiGrabAnchorConn:Disconnect()
		antiGrabAnchorConn = nil
	end
end
local function antiGrabFreezeInPlace(char)
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end
	antiGrabRootCF = hrp.CFrame
	antiGrabRootPos = hrp.Position
	antiGrabHardFreeze = true
	if not hrp:FindFirstChild("FreezeJoint") then
		local align = Instance.new("AlignPosition")
		align.Name = "FreezeJoint"
		align.Mode = Enum.PositionAlignmentMode.OneAttachment
		align.MaxForce = 1e6
		align.MaxVelocity = 0
		align.Responsiveness = 200
		local att = Instance.new("Attachment", hrp)
		align.Attachment0 = att
		align.Position = antiGrabRootPos
		align.Parent = hrp
	end
	antiGrabAnchorConn = R.Heartbeat:Connect(function()
		if antiGrabHardFreeze and hrp then
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			hrp.CFrame = antiGrabRootCF
		end
	end)
end
local function antiGrabReconnect()
	local char = Player.Character or Player.CharacterAdded:Wait()
	local hum = char:WaitForChild("Humanoid")
	local hrp = char:WaitForChild("HumanoidRootPart")
	local fp = hrp:FindFirstChild("FirePlayerPart")
	if fp then
		fp:Destroy()
	end
	if antiGrabHumConn then
		antiGrabHumConn:Disconnect()
	end
	antiGrabHumConn = hum.Changed:Connect(function(p)
		if p == "Sit" and hum.Sit then
			if not (hum.SeatPart and tostring(hum.SeatPart.Parent) == "CreatureBlobman") then
				hum:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
				hum.Sit = false
			end
		end
	end)
end
local autoStruggleConn = nil

local MiscGroup = Tabs.Defense:AddRightGroupbox("Misc", "shield-alert")


local HousebreakGroup = Tabs.Build:AddRightGroupbox("House Break", "axe")

do
    local shurikens_break = {}
    local selectedHouse = "1"

    local plotmap = {
        ["green house"]  = "1",
        ["pink house"]   = "2",
        ["purple house"] = "3",
        ["blue house"]   = "4",
        ["red house"]    = "5",
    }

    local houseValues = {}
    for name in pairs(plotmap) do
        table.insert(houseValues, name)
    end
    table.sort(houseValues)

    local function spawnthing(toyName, cframe)
        local inv = workspace:FindFirstChild(Player.Name .. "SpawnedInToys")
        if not inv then return nil end

        local 
