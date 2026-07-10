--[[
  🔹 Auto Wallhop Script (Educational)
  🔹 Вставь в LocalScript (например, в StarterPlayerScripts)
  🔹 Работает через обнаружение стены перед игроком и автоматический прыжок
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Настройки
local settings = {
    Enabled = true,          -- Вкл/Выкл
    Distance = 3.5,          -- Дистанция обнаружения стены
    JumpCooldown = 0.3,      -- Кд между прыжками (сек)
    AutoDirection = true,    -- Авто-разворот от стены
    HoldToWallhop = false,   -- Зажать кнопку для вкл
    Keybind = Enum.KeyCode.LeftControl -- Клавиша вкл/выкл (если HoldToWallhop = false)
}

local lastJumpTime = 0
local isEnabled = settings.Enabled

-- Функция проверки стены перед игроком
local function IsWallInFront()
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return false end
    
    local direction = root.CFrame.LookVector
    local origin = root.Position + Vector3.new(0, 1, 0)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {character}
    
    local result = workspace:Raycast(origin, direction * settings.Distance, raycastParams)
    
    return result ~= nil
end

-- Функция прыжка от стены
local function Wallhop()
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root or not humanoid then return end
    
    local now = tick()
    if now - lastJumpTime < settings.JumpCooldown then return end
    lastJumpTime = now
    
    -- Разворот от стены
    if settings.AutoDirection then
        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(180), 0)
    end
    
    -- Прыжок
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
end

-- Основной цикл (каждый кадр)
RunService.RenderStepped:Connect(function()
    if not settings.Enabled then return end
    if not isEnabled then return end
    
    character = player.Character
    if not character then return end
    
    humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if humanoid:GetState() == Enum.HumanoidStateType.Jumping or
       humanoid:GetState() == Enum.HumanoidStateType.Freefall then
        if IsWallInFront() then
            Wallhop()
        end
    end
end)

-- Вкл/Выкл по кнопке
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if not settings.HoldToWallhop and input.KeyCode == settings.Keybind then
        isEnabled = not isEnabled
        print("[AutoWallhop] " .. (isEnabled and "ВКЛ" or "ВЫКЛ"))
    end
end)

-- Зажать для вкл
if settings.HoldToWallhop then
    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == settings.Keybind then
            isEnabled = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == settings.Keybind then
            isEnabled = false
        end
    end)
end

print("[AutoWallhop] Скрипт загружен! Настройки в начале файла.")
