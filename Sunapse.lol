local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/"

local function Sunapse_Load(path)
	local body = game:HttpGet(repo .. path)
	local fn, err = loadstring(body)
	assert(fn, "Sunapse loadstring fail " .. path .. ": " .. tostring(err))
	return fn()
end

local Library = Sunapse_Load("Library.lua")
local ThemeManager = Sunapse_Load("addons/ThemeManager.lua")
local SaveManager = Sunapse_Load("addons/SaveManager.lua")

local Options = Library.Options
local Toggles = Library.Toggles

Library.ForceCheckbox = false
Library.ShowToggleFrameInKeybinds = true
Library.CornerRadius = 20
Library.Scheme.FontColor = Color3.fromHex("ffffff")
Library.Scheme.MainColor = Color3.fromHex("242424")
Library.Scheme.AccentColor = Color3.fromHex("eeedf4")
Library.Scheme.BackgroundColor = Color3.fromHex("151515")
Library.Scheme.OutlineColor = Color3.fromHex("373737")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = workspace.CurrentCamera

local BeamTexture = "rbxassetid://11722493032"
local ScriptStartClock = os.clock()

local ExecutorName = (function()
	if identifyexecutor then
		local success, name = pcall(identifyexecutor)
		if success and name then
			return name
		end
	end
	if syn then
		return "Synapse"
	end
	if KRNL_LOADED then
		return "Krnl"
	end
	if fluxus then
		return "Fluxus"
	end
	return "Unknown"
end)()

local function GetAccountCreationDate()
	local success, accountAge = pcall(function()
		return LocalPlayer.AccountAge
	end)
	if not success or not accountAge then
		return "N/A"
	end
	local timestamp = os.time() - accountAge * 86400
	local success2, date = pcall(function()
		return os.date("%d.%m.%Y", timestamp)
	end)
	if success2 and date then
		return date
	end
	return "N/A"
end

local function GetAccountAge()
	local success, accountAge = pcall(function()
		return LocalPlayer.AccountAge
	end)
	if not success or not accountAge then
		return "N/A"
	end
	local years = math.floor(accountAge / 365)
	local months = math.floor(accountAge % 365 / 30)
	local days = accountAge % 30
	if years > 0 then
		return years .. "y " .. months .. "m"
	end
	if months > 0 then
		return months .. "m " .. days .. "d"
	end
	return days .. "d"
end

local GetPlayerNames, FindPlayerByName, GetNearestPlayer, GetSetNetworkOwnerEvent, GetDestroyGrabLineEvent
local GetOtherPlayers, TeleportBehind, FireSetNetworkOwner, FireDestroyGrabLine, SetLineLagActive, ClearLineLagActive
local KickLoop, PalletRagdoll, SnowballRagdoll, LoopKill, AntiKickLoop, BlobKill, DestroyVisual
local BlobBring, BlobKick, BlobLoopKick, BlobBypass, BlobGrabLoopKick, BlobLock, DestroyGucciLoop, RemoveAntiInputLoop
local IsEspTarget, AddEspBox, ClearEspBoxes, RefreshEspBoxes, WatchPacketNotify, StartAntiGrab, StopAntiGrab
local AntiExplosionStep, IsGrabBeam, ClearGrabBeams, DestroyAntiKickToys, StopAntiVoid
local StopAntiBurn, StartAntiBurn, StopAntiFreeze, ClearFreeze, WatchAntiFreeze, RemovePaintParts
local SetCharacterCollision, StopAntiPaint, StopAntiPoison, StopPcldBreak, StartPcldBreak, StopGucci, StartGucci
local GetBlobmen, DropBlobmanCreatures, ApplySkybox, RestoreSkybox, IsBlackholeName, ApplyBlackholeTexture
local RestoreBlackholeTextures, WatchBlackholes, StopWatchBlackholes, ApplyShader, RestoreShader
local StartJumpCircle, StopJumpCircle, CreateTraceBeam, StartAntiBlobman, StopAntiBlobman, StartLSD, StopLSD
local AntiOwnershipLoop

local State = {
	flags = {},
	connections = {},
	refs = {},
	temp = {},
	runtime = {},
}

State.runtime.target = nil
State.runtime.kick = false
State.runtime.blobKick = false
State.runtime.kickHeight = 22
State.runtime.grabDelay = 0.05
State.runtime.rogdoll = false
State.runtime.rogdollMethod = nil
State.runtime.loopKill = false
State.runtime.destroyGucci = false
State.runtime.antiInput = false
State.runtime.antiKick = false
State.runtime.loopKickBlob = false
State.runtime.loopApple = false
State.runtime.autoSit = false
State.runtime.traceOn = false
State.runtime.espOn = false
State.runtime.pktNotify = true
State.runtime.pktCooldown = false
State.runtime.destroyGucciTask = nil
State.runtime.antiInputTask = nil
State.runtime.antiKickTask = nil
State.runtime.loopKillTask = nil
State.runtime.kickTask = nil
State.runtime.rogdollTask = nil
State.runtime.traceConn = nil
State.runtime.traceBeam = nil
State.runtime.traceTarget = nil
State.runtime.espBoxes = {}
State.runtime.espColor = Color3.fromRGB(255, 255, 255)
State.runtime.notifyConns = {}
State.runtime.currentConfig = nil
State.runtime.kickCurrentTarget = nil
State.runtime.menuKeybind = Enum.KeyCode.RightShift

State.flags.antiGrab = false
State.flags.antiLoopTP = false
State.flags.antiLoopThreshold = 50
State.flags.antiExplosion = false
State.flags.antiLag = false
State.flags.autoLeave = false
State.flags.antiKickShuriken = false
State.flags.antiKickItem = false
State.flags.antiKickPalletka = false
State.flags.antiVoid = false
State.flags.antiBurn = false
State.flags.antiFreeze = false
State.flags.antiOwnership = false
State.flags.antiLoopKick = false
State.flags.antiPaint = false
State.flags.antiSticky = false
State.flags.antiSnowball = false
State.flags.antiBanana = false
State.flags.antiPoison = false
State.flags.pcldBreak = false
State.flags.gucci = false
State.flags.autoReset = false
State.flags.antiBlobman = false
State.flags.shaders = false
State.flags.jumpCircle = false
State.flags.traceGlobal = false
State.flags.customBlackhole = false

State.refs.antiGrabProc = false
State.connections.antiGrab = {}
State.refs.antiLoopLastSafeCF = nil
State.connections.antiLoop = nil
State.connections.antiExplode = nil
State.connections.antiLag = nil
State.refs.antiLagBeamScript = nil
State.connections.autoLeave = nil
State.connections.autoReset = nil
State.refs.antiKickItemName = "SpookyCandle1"
State.refs.antiKickItemNameOptions = { "SpookyCandle1", "ClockAlarm", "FoodPlate" }
State.connections.antiVoid = {}
State.refs.antiVoidOriginalFallenHeight = nil
State.refs.antiVoidLastSafePosition = nil
State.connections.antiBurn = {}
State.connections.antiFreeze = {}
State.refs.antiFreezeHeartbeat = nil
State.refs.antiOwnSelectedFood = "Pizza (Cheese)"
State.connections.antiLoopKick = nil
State.refs.antiLoopKickHouseName = "Green House"
State.refs.antiLoopKickRadius = 10
State.connections.antiPaint = {}
State.refs.antiStickyRunning = false
State.refs.antiSnowballRunning = false
State.refs.antiBananaRunning = false
State.connections.antiPoison = {}
State.refs.pcldActive = false
State.connections.gucci = nil
State.refs.gucciActive = false
State.refs.gucciVehicle = nil
State.refs.gucciType = "Invisible (Tractor)"
State.refs.antiBlobmanRunning = false
State.connections.antiBlobmanDesc = nil
State.connections.antiBlobmanHeartbeat = nil
State.connections.antiBlobmanLoop = nil
State.refs.currentSkybox = nil
State.refs.skyboxOrig = { saved = false }
State.refs.currentBlackhole = nil
State.refs.blackholeOrig = {}
State.connections.blackholeWatch = nil
State.refs.currentShaderTheme = nil
State.refs.ccEffect = nil
State.refs.bloomEffect = nil

State.refs.originalLight = {
	Brightness = Lighting.Brightness,
	Ambient = Lighting.Ambient,
	OutdoorAmbient = Lighting.OutdoorAmbient,
	ClockTime = Lighting.ClockTime,
	TimeOfDay = Lighting.TimeOfDay,
	FogEnd = Lighting.FogEnd,
	FogStart = Lighting.FogStart,
	ExposureCompensation = Lighting.ExposureCompensation,
}

State.refs.jumpCircleOn = false
State.connections.jumpCircle = nil
State.refs.jumpCircleType = "Ritual 1"
State.refs.lineLagActive = false

local EspTargetNames = { "partesp", "playercharacterlocationdetector" }

local FoodAssets = {
	["Pizza (Cheese)"] = "FoodPizzaCheese",
	["Pizza (Pepperoni)"] = "FoodPizzaPepperoni",
	Burger = "FoodHamburger",
	Hotdog = "FoodHotdog",
	Banana = "FoodBanana",
	Donut = "FoodDonut",
	Cake = "FoodCakePink",
	Bread = "FoodBread",
	Mayonnaise = "FoodMayonnaise",
	["French Fries"] = "FoodFrenchFries",
	["Dippy Egg"] = "FoodDippyEgg",
	Coconut = "FoodCoconut",
	["Meat Stick"] = "FoodMeatStick",
	["Poison Mushroom"] = "FoodMushroomPoison",
}

local HousePositions = {
	["Green House"] = CFrame.new(-548.305054, -2.45424771, 79.3213348),
	["Pink House"] = CFrame.new(-475.493835, -2.70774508, -159.395279),
	["Witch House"] = CFrame.new(270.225922, -2.48055029, 458.186493),
	["Blue House"] = CFrame.new(501.939911, 88.2323608, -349.129211),
	["China House"] = CFrame.new(545.441833, 128.004593, -99.4881439),
}

local SkyboxPresets = {
	HD = {
		Bk = "http://www.roblox.com/asset/?id=16553658937",
		Dn = "http://www.roblox.com/asset/?id=16553660713",
		Ft = "http://www.roblox.com/asset/?id=16553662144",
		Lf = "http://www.roblox.com/asset/?id=16553664042",
		Rt = "http://www.roblox.com/asset/?id=16553665766",
		Up = "http://www.roblox.com/asset/?id=16553667750",
	},
	["Black Storm"] = {
		Bk = "rbxassetid://15502511288",
		Dn = "rbxassetid://15502508460",
		Ft = "rbxassetid://15502510289",
		Lf = "rbxassetid://15502507918",
		Rt = "rbxassetid://15502509398",
		Up = "rbxassetid://15502511911",
	},
	Snow = {
		Bk = "http://www.roblox.com/asset/?id=155657655",
		Dn = "http://www.roblox.com/asset/?id=155674246",
		Ft = "http://www.roblox.com/asset/?id=155657609",
		Lf = "http://www.roblox.com/asset/?id=155657671",
		Rt = "http://www.roblox.com/asset/?id=155657619",
		Up = "http://www.roblox.com/asset/?id=155674931",
	},
	["Blue Space"] = {
		Bk = "rbxassetid://15536110634",
		Dn = "rbxassetid://15536112543",
		Ft = "rbxassetid://15536116141",
		Lf = "rbxassetid://15536114370",
		Rt = "rbxassetid://15536118762",
		Up = "rbxassetid://15536117282",
	},
	Realistic = {
		Bk = "rbxassetid://653719502",
		Dn = "rbxassetid://653718790",
		Ft = "rbxassetid://653719067",
		Lf = "rbxassetid://653719190",
		Rt = "rbxassetid://653718931",
		Up = "rbxassetid://653719321",
	},
	Sunset = {
		Bk = "rbxassetid://600830446",
		Dn = "rbxassetid://600831635",
		Ft = "rbxassetid://600832720",
		Lf = "rbxassetid://600886090",
		Rt = "rbxassetid://600833862",
		Up = "rbxassetid://600835177",
	},
	Space = {
		Bk = "http://www.roblox.com/asset/?id=166509999",
		Dn = "http://www.roblox.com/asset/?id=166510057",
		Ft = "http://www.roblox.com/asset/?id=166510116",
		Lf = "http://www.roblox.com/asset/?id=166510092",
		Rt = "http://www.roblox.com/asset/?id=166510131",
		Up = "http://www.roblox.com/asset/?id=166510114",
	},
	Pink = {
		Bk = "rbxassetid://12216109205",
		Dn = "rbxassetid://12216109875",
		Ft = "rbxassetid://12216109489",
		Lf = "rbxassetid://12216110170",
		Rt = "rbxassetid://12216110471",
		Up = "rbxassetid://12216108877",
	},
	Galaxy = {
		Bk = "rbxassetid://15983968922",
		Dn = "rbxassetid://15983966825",
		Ft = "rbxassetid://15983965025",
		Lf = "rbxassetid://15983967420",
		Rt = "rbxassetid://15983966246",
		Up = "rbxassetid://15983964246",
	},
	["Roblox Default"] = {
		Bk = "rbxasset://textures/sky/sky512_bk.tex",
		Dn = "rbxasset://textures/sky/sky512_dn.tex",
		Ft = "rbxasset://textures/sky/sky512_ft.tex",
		Lf = "rbxasset://textures/sky/sky512_lf.tex",
		Rt = "rbxasset://textures/sky/sky512_rt.tex",
		Up = "rbxasset://textures/sky/sky512_up.tex",
	},
}

local BlackholeTextures = {
	Gargantua = "rbxassetid://5436396975",
	["Dark blue"] = "rbxassetid://78890931816939",
	Canopus = "rbxassetid://14559055920",
	["light blue"] = "rbxassetid://17769650925",
	white = "rbxassetid://11722493032",
	Galaxy = "rbxassetid://135988354771745",
}

local JumpCircleTextures = {
	["Ritual 1"] = "rbxassetid://117117534447665",
	["Ritual 2"] = "rbxassetid://8800230306",
}

local ShaderPresets = {
	["Ночь"] = {
		Brightness = 2,
		Ambient = Color3.fromRGB(60, 70, 130),
		OutdoorAmbient = Color3.fromRGB(70, 80, 150),
		ClockTime = 12,
		FogEnd = 100000,
		FogStart = 90000,
		ExposureCompensation = 0.3,
		CC = {
			Brightness = 0,
			Contrast = 0.1,
			Saturation = -0.1,
			Tint = Color3.fromRGB(120, 140, 220),
		},
		Bloom = { Intensity = 0.6, Size = 32, Threshold = 0.7 },
	},
	["Вечер"] = {
		Brightness = 2.5,
		Ambient = Color3.fromRGB(170, 110, 75),
		OutdoorAmbient = Color3.fromRGB(190, 120, 85),
		ClockTime = 12,
		FogEnd = 100000,
		FogStart = 90000,
		ExposureCompensation = 0.4,
		CC = {
			Brightness = 0,
			Contrast = 0.1,
			Saturation = 0.2,
			Tint = Color3.fromRGB(255, 200, 160),
		},
		Bloom = { Intensity = 0.6, Size = 32, Threshold = 0.7 },
	},
	["Неон"] = {
		Brightness = 2.5,
		Ambient = Color3.fromRGB(80, 40, 120),
		OutdoorAmbient = Color3.fromRGB(90, 50, 140),
		ClockTime = 22,
		FogEnd = 1500,
		FogStart = 200,
		ExposureCompensation = 0.3,
		CC = {
			Brightness = 0,
			Contrast = 0.4,
			Saturation = 0.8,
			Tint = Color3.fromRGB(180, 100, 255),
		},
		Bloom = { Intensity = 1.3, Size = 44, Threshold = 0.35 },
	},
	["Холодный"] = {
		Brightness = 2.5,
		Ambient = Color3.fromRGB(120, 140, 180),
		OutdoorAmbient = Color3.fromRGB(140, 160, 200),
		ClockTime = 12,
		FogEnd = 100000,
		FogStart = 90000,
		ExposureCompensation = 0.1,
		CC = {
			Brightness = 0,
			Contrast = 0.1,
			Saturation = 0.1,
			Tint = Color3.fromRGB(150, 180, 255),
		},
		Bloom = { Intensity = 0.4, Size = 24, Threshold = 0.8 },
	},
	["Тёплый"] = {
		Brightness = 2.5,
		Ambient = Color3.fromRGB(180, 140, 100),
		OutdoorAmbient = Color3.fromRGB(200, 160, 120),
		ClockTime = 12,
		FogEnd = 100000,
		FogStart = 90000,
		ExposureCompensation = 0.2,
		CC = {
			Brightness = 0.02,
			Contrast = 0.1,
			Saturation = 0.3,
			Tint = Color3.fromRGB(255, 200, 150),
		},
		Bloom = { Intensity = 0.5, Size = 28, Threshold = 0.6 },
	},
}
local function WaitChild(instance, childName)
	return instance:FindFirstChild(childName) or instance:WaitForChild(childName, 3)
end

GetPlayerNames = function()
	local names = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			table.insert(names, player.DisplayName)
		end
	end
	return names
end

FindPlayerByName = function(name)
	for _, player in ipairs(Players:GetPlayers()) do
		if player.DisplayName == name or player.Name == name then
			return player
		end
	end
end

GetNearestPlayer = function(position)
	if not position then
		return nil
	end
	local bestDistance = math.huge
	local nearestPlayer = nil
	for _, player in ipairs(Players:GetPlayers()) do
		local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			local distance = (rootPart.Position - position).Magnitude
			if distance < bestDistance then
				bestDistance = distance
				nearestPlayer = player
			end
		end
	end
	return nearestPlayer
end

GetSetNetworkOwnerEvent = function()
	local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents") or ReplicatedStorage:WaitForChild("GrabEvents", 10)
	return grabEvents and grabEvents:FindFirstChild("SetNetworkOwner")
end

GetDestroyGrabLineEvent = function()
	local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents") or ReplicatedStorage:WaitForChild("GrabEvents", 10)
	return grabEvents and grabEvents:FindFirstChild("DestroyGrabLine")
end

GetOtherPlayers = function()
	local others = {}
	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			table.insert(others, player)
		end
	end
	return others
end

TeleportBehind = function(rootPart, targetRootPart)
	if not rootPart or not targetRootPart then
		return
	end
	pcall(function()
		rootPart.CFrame = targetRootPart.CFrame * CFrame.new(0, 0, 2)
		rootPart.AssemblyLinearVelocity = Vector3.zero
	end)
end

FireSetNetworkOwner = function(part)
	if not part then
		return
	end
	local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents")
	local setNetworkOwner = grabEvents and grabEvents:FindFirstChild("SetNetworkOwner")
	if setNetworkOwner then
		for i = 1, 5 do
			pcall(function()
				setNetworkOwner:FireServer(part, part.CFrame)
			end)
		end
	end
end

FireDestroyGrabLine = function(part)
	if not part then
		return
	end
	local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents")
	local destroyGrabLine = grabEvents and grabEvents:FindFirstChild("DestroyGrabLine")
	if destroyGrabLine then
		pcall(function()
			destroyGrabLine:FireServer(part)
		end)
	end
end

SetLineLagActive = function()
	State.refs.lineLagActive = true
end

ClearLineLagActive = function()
	State.refs.lineLagActive = false
end

KickLoop = function(playerName)
	local grabEvents = ReplicatedStorage:FindFirstChild("GrabEvents") or ReplicatedStorage:WaitForChild("GrabEvents", 10)
	if not grabEvents then
		Library:Notify({ Title = "Sunapse.lol", Description = "GrabEvents not found", Time = 3 })
		return
	end
	local setNetworkOwner = grabEvents:FindFirstChild("SetNetworkOwner") or grabEvents:WaitForChild("SetNetworkOwner", 5)
	local createGrabLine = grabEvents:FindFirstChild("CreateGrabLine")
	local destroyGrabLine = grabEvents:FindFirstChild("DestroyGrabLine") or grabEvents:WaitForChild("DestroyGrabLine", 5)
	if not setNetworkOwner then
		Library:Notify({ Title = "Sunapse.lol", Description = "SetNetworkOwner not found", Time = 3 })
		return
	end
	local lastGrab = 0

	while State.runtime.kick do
		local targetPlayer = Players:FindFirstChild(playerName)
		if not targetPlayer or not targetPlayer.Parent then
			break
		end

		local character = LocalPlayer.Character
		local rootPart = character and character:FindFirstChild("HumanoidRootPart")
		local targetCharacter = targetPlayer.Character
		local targetHumanoid = targetCharacter and targetCharacter:FindFirstChildOfClass("Humanoid")

		if not targetCharacter or not targetHumanoid or targetHumanoid.Health <= 0 then
			pcall(function()
				targetCharacter = targetPlayer.CharacterAdded:Wait()
				targetHumanoid = targetCharacter:WaitForChild("Humanoid", 5)
			end)
			RunService.Heartbeat:Wait()
		else
			local targetRootPart = targetCharacter:FindFirstChild("HumanoidRootPart")
			if not (character and rootPart) or not targetRootPart or not targetHumanoid or targetHumanoid.Health <= 0 then
				RunService.Heartbeat:Wait()
			elseif (targetRootPart.Position - rootPart.Position).Magnitude > 30 then
				pcall(function()
					character:PivotTo(targetRootPart.CFrame * CFrame.new(0, 2, 4))
				end)
				RunService.Heartbeat:Wait()
			else
				local kickPosition = (rootPart.CFrame * CFrame.new(0, State.runtime.kickHeight, 0)).Position

				if not targetRootPart:FindFirstChild("Kick2Align") then
					for _, child in pairs(targetRootPart:GetChildren()) do
						if child:IsA("BodyPosition") or child:IsA("BodyGyro") or child:IsA("AlignPosition") or child:IsA("AlignOrientation") then
							if child.Name ~= "Kick2Align" and child.Name ~= "Kick2Rot" then
								pcall(function()
									child:Destroy()
								end)
							end
						end
					end

					local attachment = Instance.new("Attachment", targetRootPart)
					attachment.Name = "Kick2Att0"
					local anchorAttachment = Instance.new("Attachment", workspace.Terrain)
					anchorAttachment.Name = "Kick2Att1"
					local alignPosition = Instance.new("AlignPosition")
					alignPosition.Name = "Kick2Align"
					alignPosition.Attachment0 = attachment
					alignPosition.Attachment1 = anchorAttachment
					alignPosition.MaxForce = math.huge
					alignPosition.Responsiveness = 300
					alignPosition.Parent = targetRootPart
					local alignOrientation = Instance.new("AlignOrientation")
					alignOrientation.Name = "Kick2Rot"
					alignOrientation.Attachment0 = attachment
					alignOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
					alignOrientation.CFrame = CFrame.new()
					alignOrientation.MaxTorque = math.huge
					alignOrientation.Responsiveness = 300
					alignOrientation.Parent = targetRootPart
				end

				local kick2Align = targetRootPart:FindFirstChild("Kick2Align")
				if kick2Align and kick2Align.Attachment1 then
					kick2Align.Attachment1.WorldPosition = kickPosition
				end

				local ki
