getgenv().SilentAimEnabled = true
getgenv().AutoShootEnabled = true
getgenv().Prediction = 0.135
getgenv().FOVRadius = 110
getgenv().TargetPart = "Head"

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

local FOV = Drawing.new("Circle")
FOV.Color = Color3.fromRGB(255, 0, 0)
FOV.Thickness = 1
FOV.Filled = false
FOV.Transparency = 0.5
FOV.Radius = getgenv().FOVRadius
FOV.Visible = true
FOV.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

local function getClosestEnemy()
    local closest, dist = nil, math.huge
    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and plr.Team ~= LocalPlayer.Team and plr.Character and plr.Character:FindFirstChild(getgenv().TargetPart) then
            local part = plr.Character[getgenv().TargetPart]
            local pos, vis = Camera:WorldToViewportPoint(part.Position)
            local mag = (Vector2.new(pos.X, pos.Y) - FOV.Position).Magnitude
            if vis and mag < dist and mag <= getgenv().FOVRadius then
                closest = part
                dist = mag
            end
        end
    end
    return closest
end

local __namecall
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local args = {...}
    if getgenv().SilentAimEnabled and tostring(self) == "HitPart" and getnamecallmethod() == "FireServer" then
        local target = getClosestEnemy()
        if target then
            args[2] = target
            args[3] = target.Position + (target.Velocity * getgenv().Prediction)
            return __namecall(self, unpack(args))
        end
    end
    return __namecall(self, ...)
end)

RunService.RenderStepped:Connect(function()
    FOV.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
end)

RunService.RenderStepped:Connect(function()
    if not getgenv().AutoShootEnabled then return end
    local target = getClosestEnemy()
    if target then
        local shoot = ReplicatedStorage:FindFirstChild("WeaponRemote")
        if shoot then
            shoot:FireServer(target.Position + (target.Velocity * getgenv().Prediction))
        end
    end
end)

print("✅ Arsenal script cargado desde Expert Hub 😈📦")
