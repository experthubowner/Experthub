-- ⚡ Cyber Message "Aimbot Activated - Press Jump" SOLO si puedes activar el aimbot
local function showAimbotActivated()
	if true then -- puedes reemplazar esta condición por una real si necesitas
		local screenGui = Instance.new("ScreenGui")
		screenGui.Name = "AimbotMessage"
		screenGui.IgnoreGuiInset = true
		screenGui.ResetOnSpawn = false
		screenGui.Parent = player:WaitForChild("PlayerGui")

		local label = Instance.new("TextLabel")
		label.Parent = screenGui
		label.Size = UDim2.new(1, 0, 0.2, 0)
		label.Position = UDim2.new(0, 0, 0.4, 0)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.fromRGB(255, 0, 255)
		label.TextStrokeTransparency = 0
		label.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)
		label.Text = "⚡⚡ AIMBOT ACTIVATED ⚡⚡\nPress Jump to Toggle"
		label.Font = Enum.Font.Arcade
		label.TextScaled = true

		-- Efecto de luz animado cyber
		local tween = TweenService:Create(label, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {
			TextColor3 = Color3.fromRGB(255, 0, 255)
		})
		tween:Play()

		-- Auto-remover después de 3 segundos
		task.delay(3, function()
			if screenGui then
				screenGui:Destroy()
			end
		end)
	end
end

-- 🔫 LLAMAR CUANDO PUEDAS ACTIVAR AIMBOT
-- Puedes cambiar esta lógica a lo que quieras (ej. si estás en una zona, un nivel, etc.)
showAimbotActivated()
