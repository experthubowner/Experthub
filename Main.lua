-- 🌐 ExpertHub Main Loader by LUA GOD 😈

local PlaceId = game.PlaceId
print("🧠 Detectando juego... PlaceId:", PlaceId)

local GameScripts = {
    [286090429] = "ArsenalSilent.lua" -- Arsenal REAL
}

local URLBase = "https://raw.githubusercontent.com/experthubowner/Experthub/main/scripts/"

if GameScripts[PlaceId] then
    print("✅ Juego compatible, cargando script:", GameScripts[PlaceId])
    loadstring(game:HttpGet(URLBase .. GameScripts[PlaceId]))()
else
    print("❌ Juego no soportado (ID: " .. PlaceId .. ")")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Expert Hub 🌐",
        Text = "Juego no soportado aún 😢",
        Duration = 5
    })
end
