local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Teams = game:GetService("Teams")

local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local camera = workspace.CurrentCamera

local aimbotEnabled = false
local connection

-- Encuentra el jugador enemigo más cercano
local function getClosestPlayer()
    local closestPlayer = nil
    local shortestDistance = math.huge

    for _, player in pairs(Players:GetPlayers()) do
        -- Verifica que no sea el jugador local y que estén en equipos diferentes
        if player ~= localPlayer and player.Team ~= localPlayer.Team then
            if player.Character and player.Character:FindFirstChild("Head") then
                local distance = (player.Character.Head.Position - camera.CFrame.Position).Magnitude
                if distance < shortestDistance then
                    shortestDistance = distance
                    closestPlayer = player
                end
            end
        end
    end

    return closestPlayer
end

-- Aimbot: apunta la cámara hacia el enemigo
local function startAimbot()
    connection = RunService.RenderStepped:Connect(function()
        local target = getClosestPlayer()
        if target and target.Character and target.Character:FindFirstChild("Head") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, target.Character.Head.Position)
        end
    end)
end

-- Detener aimbot
local function stopAimbot()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

-- Manejo del salto
UserInputService.JumpRequest:Connect(function()
    aimbotEnabled = not aimbotEnabled
    if aimbotEnabled then
        startAimbot()
        print("Aimbot activado")
    else
        stopAimbot()
        print("Aimbot desactivado")
    end
end)
