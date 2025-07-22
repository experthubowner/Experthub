-- 🚪 DOORS ESP (Llaves, Libros, Entidades) by ExpertHub

local function highlight(obj)
	local h = Instance.new("Highlight", obj)
	h.FillColor = Color3.fromRGB(255, 0, 255)
	h.OutlineColor = Color3.fromRGB(255, 255, 255)
end

while task.wait(1) do
	for _, obj in ipairs(workspace:GetDescendants()) do
		if obj.Name == "KeyObtain" or obj.Name == "LiveHintBook" or obj.Name == "RushMoving" then
			if not obj:FindFirstChild("Highlight") then
				highlight(obj)
			end
		end
	end
end
