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
