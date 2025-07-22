-- 🎯 Arsenal Aimbot AUTO con FOV CÍRCULO (NO necesitas disparar)
-- By DIOS DEL LUA 😈👑

-- ✅ Mostrar imagen por 3 segundos antes de activar el aimbot
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- GUI para mostrar imagen por 3 segundos
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ExpertHubGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Parent = ScreenGui
ImageLabel.BackgroundTransparency = 1
ImageLabel.Size = UDim2.new(0, 300, 0, 300)
ImageLabel.Position = UDim2.new(0.5, -150, 0.5, -150)
ImageLabel.Image = "rbxassetid://17326235589" -- 💥 Imagen subida por ChatGPT

wait(3)
ScreenGui:Destroy()

-- ⚙️ CONFIG
getgenv().AimbotEnabled = true
getgenv().Prediction = 0.135
getgenv().FOVRadius = 100
getgenv().TargetPart = "Head"

-- 📦 Servicios
local RunService = game:GetService("RunService")

-- 🔘 Dibujo del FOV Circle
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(0, 255, 0)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Radius = getgenv().FOVRadius
FOVCircle.Transparency = 0.5
FOVCircle.Visible = true
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

-- 🎯 Función para encontrar el enemigo más cercano al círculo
local function getClosestEnemy()
    local closest, shortest = nil, math.huge
    for _,player in pairs(Players:GetPlayers()) do
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

-- 🎥 RenderStepped loop del aimbot
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

-- ✅ Aimbot activado
print("✅ Aimbot con FOV Circle ACTIVADO en Arsenal 😈💚")
