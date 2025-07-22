-- 🎯 Phantom Forces Aimbot by ExpertHub

getgenv().AimbotEnabled = true
getgenv().TargetPart = "Head"

local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local function getClosest()
	local closest, dist = nil, math.huge
	for _, p in ipairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild(getgenv().TargetPart) then
			local pos, onScreen = Camera:WorldToViewportPoint(p.Character[getgenv().TargetPart].Position)
			if onScreen then
				local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)).Magnitude
				if mag < dist then
					closest, dist = p, mag
				end
			end
		end
	end
	return closest
end

RunService.RenderStepped:Connect(function()
	if getgenv().AimbotEnabled then
		local target = getClosest()
		if target and target.Character then
			local part = target.Character[getgenv().TargetPart]
			Camera.CFrame = CFrame.new(Camera.CFrame.Position, part.Position)
		end
	end
end)
