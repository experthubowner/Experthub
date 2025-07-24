-- 🎯 Arsenal Aimbot v2 FINAL FIX - YA NO SE VA AL PISO 💀
-- By LUA GOD 😈💻

-- 🔮 INTRO CYBER ANIMADA
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Crear GUI Intro
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

-- Animación
TweenService:Create(TextLabel, TweenInfo.new(0.6, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
	Size = UDim2.new(0.8, 0, 0.2, 0)
}):Play()

wait(3)
ScreenGui:Destroy()

-- ⚙️ CONFIG
getgenv().AimbotEnabled = true
getgenv().Prediction = 0.135
getgenv().FOVRadius = 100
getgenv().TargetPart = "Head"

-- 🎯 CÍRCULO FOV
local FOVCircle = Drawing.new("Circle")
FOVCircle.Color = Color3.fromRGB(200, 0, 255)
FOVCircle.Thickness = 2
FOVCircle.Filled = false
FOVCircle.Radius = getgenv().FOVRadius
FOVCircle.Transparency = 0.5
FOVCircle.Visible = true
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)

-- 🧠 DETECCIÓN DE ATAQUE - AUTO LOCK ENEMIGO
local attackerTarget = nil
local targetOverrideTime = 2

local function setupDamageDetector()
	local char = LocalPlayer.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	hum:GetPropertyChangedSignal("Health"):Connect(function()
		local tag = hum:FindFirstChild("creator")
		if tag and tag:IsA("ObjectValue") and tag.Value and tag.Value:IsA("Player") then
			local enemy = tag.Value
			if enemy.Character and enemy.Character:FindFirstChild(getgenv().TargetPart) then
				attackerTarget = enemy.Character[getgenv().TargetPart]
				warn("⚠️ Te disparó:", enemy.Name)
				task.delay(targetOverrideTime, function()
					attackerTarget = nil
				end)
			end
		end
	end)

	hum.ChildAdded:Connect(function(child)
		if child.Name == "creator" and child:IsA("ObjectValue") then
			local enemy = child.Value
			if enemy and enemy:IsA("Player") and enemy.Character and enemy.Character:FindFirstChild(getgenv().TargetPart) then
				attackerTarget = enemy.Character[getgenv().TargetPart]
				warn("🎯 Agresor detectado:", enemy.Name)
				task.delay(targetOverrideTime, function()
					attackerTarget = nil
				end)
			end
		end
	end)
end

if LocalPlayer.Character then setupDamageDetector() end
LocalPlayer.CharacterAdded:Connect(function()
	task.wait(1)
	setupDamageDetector()
end)

-- 🔍 AIMBOT ENEMIGO MÁS CERCANO
local function getClosestEnemy()
	if attackerTarget then return attackerTarget end

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

-- 🔁 AIMBOT LOOP FIX - YA NO SE VA AL PISO
RunService.RenderStepped:Connect(function()
	FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
	if getgenv().AimbotEnabled then
		local target = getClosestEnemy()
		if target then
			local velocity = target.Velocity

			-- ✅ FIX: Limitar Y para evitar apuntar al piso
			if math.abs(velocity.Y) > 100 then
				velocity = Vector3.new(velocity.X, 0, velocity.Z)
			end

			local predicted = target.Position + velocity * getgenv().Prediction
			local direction = (predicted - Camera.CFrame.Position).Unit
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + direction)
		end
	end
end)

print("✅ Aimbot FINAL ACTIVADO (FIX piso + auto lock) 🔫💜")
