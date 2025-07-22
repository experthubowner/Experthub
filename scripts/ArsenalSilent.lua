-- 🎯 Arsenal Aimbot AUTO con FOV CÍRCULO + INTRO CYBER ANIMADA
-- By DIOS DEL LUA 😈👑

-- 🔮 INTRO CYBER ANIMADA
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- 🧪 Crear GUI
local ScreenGui = Instance.new("ScreenGui", LocalPlayer:WaitForChild("PlayerGui"))
ScreenGui.Name = "CyberIntro"
ScreenGui.ResetOnSpawn = false

local TextLabel = Instance.new("TextLabel", ScreenGui)
TextLabel.Size = UDim2.new(0, 0, 0, 0)
TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
TextLabel.BackgroundTransparency = 1
TextLabel.Text = "⚡ AIMBOT ACTIVADO ⚡"
TextLabel.TextColor3 = Color3.fromRGB(200, 0, 255)
TextLabel.TextStrokeTransparency = 0
TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
TextLabel.Font = Enum.Font.Arcade
TextLabel.TextScaled = true

-- 🎬 Zoom animado cyber
local tweenInfo = TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
local targetSize = { Size = UDim2.new(0.8, 0, 0.2, 0) }
TweenService:Create(TextLabel, tweenInfo, targetSize):Play()

wait(3)
ScreenGui:Destroy()

-- ⚙️ CONFIG
getgenv().AimbotEnabled = true
getgenv().Prediction = 0.135
getgenv().FOVRadius = 100
getgenv().TargetPart = "Head"

-- 🟣 Dibujar Círculo FOV
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(200, 0, 255) -- Morado cyber
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Radius = getgenv().FOVRadius
FOVCircle.Transparency = 0.5
FOVCircle.Visible = true
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

-- 🎯 Buscar enemigo más cercano
local function getClosestEnemy()
    local closest, shortest = nil, math.huge
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Team ~= LocalPlayer.Team and player.Character and player.Character:FindFirstChild(getgenv().TargetPart) then
            local part = player.Character[getgenv().TargetPart]
            local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - FOVCircle.Position).Magnitude
                if dist <= FOVCircle.Radius and dist < shortest then
                    closest = part
                    shortest = dist
                end
            end
        end
    end
    return closest
end

-- 💥 Loop del Aimbot
RunService.RenderStepped:Connect(function()
    FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    if getgenv().AimbotEnabled then
        local target = getClosestEnemy()
        if target then
            local predicted = target.Position + target.Velocity * getgenv().Prediction
            local direction = (predicted - Camera.CFrame.Position).Unit
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction)
        end
    end
end)

print("✅ AIMBOT con intro cyber activado 😈💜")
