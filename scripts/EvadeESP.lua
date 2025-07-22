-- 🧠 Evade ESP + SpeedHack by ExpertHub

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Speed
LocalPlayer.CharacterAdded:Connect(function(char)
	repeat task.wait() until char:FindFirstChild("Humanoid")
	char.Humanoid.WalkSpeed = 30
end)

-- ESP
for _, player in ipairs(Players:GetPlayers()) do
	if player ~= LocalPlayer then
		local esp = Drawing.new("Text")
		esp.Text = player.Name
		esp.Color = Color3.fromRGB(255, 0, 255)
		esp.Size = 14
		esp.Center = true
		esp.Outline = true
		esp.Visible = true

		RunService.RenderStepped:Connect(function()
			if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local pos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
				if onScreen then
					esp.Position = Vector2.new(pos.X, pos.Y)
					esp.Visible = true
				else
					esp.Visible = false
				end
			end
		end)
	end
end
