local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera
local aimbotActivo = false
local conexion

-- 🧠 Verifica si es enemigo
local function esEnemigo(jugador)
    if not jugador.Team or not localPlayer.Team then
        return true
    end
    return jugador.Team ~= localPlayer.Team
end

-- 🔍 Encuentra el enemigo más cercano
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

-- 🎯 Iniciar Aimbot
local function iniciarAimbot()
    camera.CameraType = Enum.CameraType.Scriptable
    conexion = RunService.RenderStepped:Connect(function()
        local objetivo = obtenerJugadorCercano()
        if objetivo and objetivo.Character and objetivo.Character:FindFirstChild("Head") then
            camera.CFrame = CFrame.new(camera.CFrame.Position, objetivo.Character.Head.Position)
        end
    end)
end

-- 🛑 Detener Aimbot
local function detenerAimbot()
    if conexion then
        conexion:Disconnect()
        conexion = nil
    end
    camera.CameraType = Enum.CameraType.Custom
end

-- 💜 Crear GUI y Botón para móviles
local playerGui = localPlayer:WaitForChild("PlayerGui")
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AimbotUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local etiqueta = Instance.new("TextLabel")
etiqueta.Size = UDim2.new(0.8, 0, 0.1, 0)
etiqueta.Position = UDim2.new(0.1, 0, 0.05, 0)
etiqueta.BackgroundTransparency = 1
etiqueta.Text = "Presiona el botón para activar el aimbot"
etiqueta.TextColor3 = Color3.fromRGB(160, 32, 240)
etiqueta.TextStrokeTransparency = 0
etiqueta.TextStrokeColor3 = Color3.new(0, 0, 0)
etiqueta.Font = Enum.Font.Code
etiqueta.TextScaled = true
etiqueta.Parent = screenGui

local boton = Instance.new("TextButton")
boton.Size = UDim2.new(0.4, 0, 0.08, 0)
boton.Position = UDim2.new(0.3, 0, 0.85, 0)
boton.Text = "🔥 ACTIVAR AIMBOT 🔥"
boton.Font = Enum.Font.Code
boton.TextScaled = true
boton.TextColor3 = Color3.new(1, 1, 1)
boton.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
boton.BorderColor3 = Color3.fromRGB(0, 0, 0)
boton.TextStrokeTransparency = 0
boton.TextStrokeColor3 = Color3.new(0, 0, 0)
boton.Parent = screenGui

-- 📱 Detectar toque del botón
boton.MouseButton1Click:Connect(function()
    aimbotActivo = not aimbotActivo
    if aimbotActivo then
        iniciarAimbot()
        etiqueta.Text = "✅ Aimbot ACTIVADO"
        boton.Text = "❌ DESACTIVAR AIMBOT ❌"
        print("Aimbot ACTIVADO")
    else
        detenerAimbot()
        etiqueta.Text = "Presiona el botón para activar el aimbot"
        boton.Text = "🔥 ACTIVAR AIMBOT 🔥"
        print("Aimbot DESACTIVADO")
    end
end)
