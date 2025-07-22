-- ⚔️ Combat Warriors Auto Parry + Anti Ragdoll by ExpertHub

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Anti Ragdoll
game:GetService("RunService").Stepped:Connect(function()
	local char = LocalPlayer.Character
	if char and char:FindFirstChild("Ragdolled") then
		char.Ragdolled:Destroy()
	end
end)

-- Auto Parry
local remote = ReplicatedStorage:WaitForChild("Events"):WaitForChild("ParryButtonPress")
while task.wait(0.25) do
	remote:FireServer()
end
