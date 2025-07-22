-- Servicios necesarios
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Jugador local
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local camera = workspace.CurrentCamera

-- Variables de estado
local aimbotActivo = false
local conexion

-- UI estilo hacker
local playerGui = localPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AimbotUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local etiqueta = Instance.new("TextLabel")
etiqueta.Size = UDim2.new(0.6, 0, 0.1, 0)
etiqueta.Position = UDim2.new(0.2, 0, 0.05, 0)
etiqueta.BackgroundTransparency = 1
etiqueta.Text = "Salta para activar el aimbot"
etiqueta.TextColor3 = Color3.fromRGB(160, 32, 240)
etiqueta.TextStrokeTransparency = 0
etiqueta.TextStrokeColor3 = Color3.new(0, 0, 0)
etiqueta.Font = Enum.Font.Code
etiqueta.TextScaled = true
etiqueta.Parent = screenGui

-- Función para comprobar si el jugador es enemigo
local function esEnemigo(jugador)
    return jugador.Team ~= localPlayer.Team
end

-- Encontrar el enemigo más cercano
local function obtenerJugadorCercano()
    local masCercano = nil
    local distanciaMinima = math.huge

    for _, jugador in pairs(Players:GetPlayers()) do
        if jugador ~= localPlayer and esEnemigo(jugador) and jugador.Character and jugador.Character:FindFirstChild("Head") then
            local distancia = (jugador.Character.Head.Position - camera.CFrame.Position).Magnitude
            if distancia < distanciaMinima then
                distanciaMinima = distancia
                masCercano = jugador
            end
        end
    end

    return masCercano
end

-- Activar Aimbot
local function iniciarAimbot()
    conexion = RunService.RenderStepped:Connect(function()
        local objetivo = obtenerJugadorCercano()
        if objetivo and objetivo.Character and objetivo.Character:FindFirstChild("Head") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, objetivo.Character.Head.Position)
        end
    end)
end

-- Desactivar Aimbot
local function detenerAimbot()
    if conexion then
        conexion:Disconnect()
        conexion = nil
    end
end

-- Toggle con la tecla de salto
UserInputService.JumpRequest:Connect(function()
    aimbotActivo = not aimbotActivo
    if aimbotActivo then
        iniciarAimbot()
        etiqueta.Text = "🔥 Aimbot ACTIVADO 🔥"
        print("Aimbot ACTIVADO")
    else
        detenerAimbot()
        etiqueta.Text = "❌ Aimbot DESACTIVADO ❌"
        print("Aimbot DESACTIVADO")
    end
end)
