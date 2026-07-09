-- Auto Wallhop для Roblox (Delta Executor)
-- Скрипт автоматически выполняет wallhop при прыжке рядом со стеной

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local wallhopEnabled = true
local flickIntensity = 25  -- Угол поворота (градусы)
local jumpPower = 50       -- Сила прыжка
local walkSpeed = 20       -- Скорость передвижения

-- Настройка параметров персонажа
humanoid.JumpPower = jumpPower
humanoid.WalkSpeed = walkSpeed

-- Функция Wallhop
local function Wallhop()
    if not wallhopEnabled then return end
    
    -- Поворот камеры для эффекта "флика"
    local currentCFrame = rootPart.CFrame
    local rotation = CFrame.Angles(0, math.rad(flickIntensity), 0)
    rootPart.CFrame = currentCFrame * rotation
    
    -- Выполнение прыжка
    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    
    -- Возврат в исходное положение
    task.wait(0.03)
    rootPart.CFrame = currentCFrame
end

-- Обработчик прыжка
local function onJump()
    if wallhopEnabled then
        Wallhop()
    end
end

-- Подключение события прыжка
humanoid.StateChanged:Connect(function(oldState, newState)
    if newState == Enum.HumanoidStateType.Jumping then
        onJump()
    end
end)

-- Поддержка перерождения персонажа
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    humanoid.JumpPower = jumpPower
    humanoid.WalkSpeed = walkSpeed
    
    humanoid.StateChanged:Connect(function(oldState, newState)
        if newState == Enum.HumanoidStateType.Jumping then
            onJump()
        end
    end)
end)

-- Интерфейс управления (в консоли)
print("=== Auto Wallhop ===")
print("Включен: " .. tostring(wallhopEnabled))
print("Для отключения введите в консоли: wallhopEnabled = false")
print("Для включения: wallhopEnabled = true")
