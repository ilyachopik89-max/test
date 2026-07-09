-- AutoWallhop Script for Roblox Delta
-- Поддержка: Delta Executor
-- Версия: 2.1

local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local rootPart = char:WaitForChild("HumanoidRootPart")

-- Настройки (можно менять)
local Settings = {
    Enabled = true,          -- Включен/Выключен
    Keybind = "G",           -- Клавиша для включения/выключения
    Walkspeed = 25,          -- Скорость ходьбы
    JumpPower = 65,          -- Сила прыжка
    WallhopPower = 35,       -- Сила отталкивания от стены
    AutoJump = true,         -- Автопрыжок
    Sensitivity = 0.3        -- Чувствительность обнаружения стен
}

-- Переменные состояния
local wallhop = {
    enabled = Settings.Enabled,
    wallRiding = false,
    lastWall = nil,
    debounce = false
}

-- Функция проверки стены
local function isWall()
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
    raycastParams.FilterDescendantsInstances = {char}
    
    -- Проверка в 4 направлениях
    local directions = {
        rootPart.CFrame.LookVector,
        -rootPart.CFrame.LookVector,
        rootPart.CFrame.RightVector,
        -rootPart.CFrame.RightVector
    }
    
    for _, dir in ipairs(directions) do
        local ray = workspace:Raycast(rootPart.Position, dir * 3, raycastParams)
        if ray and ray.Instance and ray.Instance.Material ~= Enum.Material.Air then
            local distance = (ray.Position - rootPart.Position).Magnitude
            if distance <= 2.5 then
                return true, ray.Instance
            end
        end
    end
    return false, nil
}

-- Основная функция движения
local function wallhopMovement()
    if not wallhop.enabled or not char or not humanoid or not rootPart then return end
    
    local isNearWall, wall = isWall()
    
    if isNearWall and not wallhop.debounce then
        wallhop.wallRiding = true
        wallhop.lastWall = wall
        
        -- Увеличение скорости при стене
        humanoid.WalkSpeed = Settings.Walkspeed * 1.3
        
        -- Отталкивание от стены
        local direction = (rootPart.Position - wall.Position).Unit
        rootPart.Velocity = Vector3.new(
            direction.X * Settings.WallhopPower,
            Settings.JumpPower * 0.7,
            direction.Z * Settings.WallhopPower
        )
        
        -- Автопрыжок
        if Settings.AutoJump and humanoid:GetState() ~= Enum.HumanoidStateType.Jumping then
            humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
        end
        
        wallhop.debounce = true
        task.wait(0.1)
        wallhop.debounce = false
    else
        wallhop.wallRiding = false
        humanoid.WalkSpeed = Settings.Walkspeed
    end
end

-- Обработка клавиш
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode[Settings.Keybind] then
        wallhop.enabled = not wallhop.enabled
        if wallhop.enabled then
            print("Wallhop включен")
            humanoid.WalkSpeed = Settings.Walkspeed
        else
            print("Wallhop выключен")
            humanoid.WalkSpeed = 16
            wallhop.wallRiding = false
        end
    end
end)

-- Основной цикл
spawn(function()
    while task.wait() do
        pcall(wallhopMovement)
    end
end)

-- Обновление персонажа
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = char:WaitForChild("Humanoid")
    rootPart = char:WaitForChild("HumanoidRootPart")
    wait(1)
    humanoid.WalkSpeed = Settings.Walkspeed
end)

-- Интерфейс
local function createGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player.PlayerGui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 200, 0, 60)
    frame.Position = UDim2.new(0, 10, 0, 10)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.3
    frame.BorderSizePixel = 0
    frame.Parent = screenGui
    
    -- Закругление
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "⛰️ Wallhop: " .. (wallhop.enabled and "ON" or "OFF")
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = frame
    
    -- Обновление интерфейса
    game:GetService("RunService").Heartbeat:Connect(function()
        label.Text = "⛰️ Wallhop: " .. (wallhop.enabled and "ON" or "OFF")
        frame.BackgroundColor3 = wallhop.enabled and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(170, 0, 0)
    end)
end

-- Запуск интерфейса
spawn(createGUI)

print("✅ AutoWallhop загружен! Нажмите " .. Settings.Keybind .. " для включения/выключения")
