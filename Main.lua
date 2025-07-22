-- 🌐 ExpertHub Main Loader v2 by LUA GOD 😈

local PlaceId = game.PlaceId
print("🧠 Detectando juego... PlaceId:", PlaceId)

local GameScripts = {
    [286090429] = "ArsenalSilent.lua",              -- Arsenal
    [14202073004] = "UnnamedShooterAimbot.lua",     -- ✅ Unnamed Shooter real
    [4282985734] = "CombatWarriors.lua",            -- Combat Warriors
    [9872472334] = "EvadeESP.lua",                  -- Evade
    [292439477] = "PhantomForcesAim.lua",           -- Phantom Forces
    [6516141723] = "DoorsESP.lua"                   -- Doors
}

local URLBase = "https://raw.githubusercontent.com/experthubowner/Experthub/main/scripts/"

if GameScripts[PlaceId] then
    print("✅ Juego compatible, cargando script:", GameScripts[PlaceId])
    loadstring(game:HttpGet(URLBase .. GameScripts[PlaceId]))()

    -- 💜 Mostrar "EXPERT HUB ACTIVATED" en pantalla
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Text = "💜 EXPERT HUB ACTIVATED"
    TextLabel.TextColor3 = Color3.fromRGB(170, 0, 255)
    TextLabel.Font = Enum.Font.FredokaOne
    TextLabel.TextSize = 40
    TextLabel.BackgroundTransparency = 1
    TextLabel.Size = UDim2.new(1, 0, 0, 60)
    TextLabel.Position = UDim2.new(0, 0, 0.05, 0)
    TextLabel.TextStrokeTransparency = 0.5
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0)

    -- Insert into CoreGui (roblox GUI)
    local success, gui = pcall(function()
        return game:GetService("CoreGui")
    end)

    if success and gui then
        TextLabel.Parent = gui
        task.delay(3, function()
            if TextLabel then TextLabel:Destroy() end
        end)
    else
        warn("⚠️ No se pudo insertar el texto en CoreGui")
    end

else
    print("❌ Juego no soportado (ID: " .. PlaceId .. ")")
    pcall(function()
        game.StarterGui:SetCore("SendNotification", {
            Title = "ExpertHub 🌐",
            Text = "Juego no soportado aún 😢",
            Duration = 5
        })
    end)
end
