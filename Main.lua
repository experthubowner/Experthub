local PlaceId = game.PlaceId
print("🧠 PlaceId detectado:", PlaceId)

local GameScripts = {
    [111958650] = "ArsenalSilent.lua"
}

local URLBase = "https://raw.githubusercontent.com/experthubowner/Experthub/main/scripts/"

if GameScripts[PlaceId] then
    print("✅ Juego compatible, cargando script:", GameScripts[PlaceId])
    loadstring(game:HttpGet(URLBase .. GameScripts[PlaceId]))()
else
    print("❌ Juego no soportado (PlaceId no listado)")
    game.StarterGui:SetCore("SendNotification", {
        Title = "Expert Hub",
        Text = "Juego no soportado aún 😢",
        Duration = 5
    })
end
