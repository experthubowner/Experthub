local PlaceId = game.PlaceId

local GameScripts = {
    [111958650] = "ArsenalSilent.lua"
}

local URLBase = "https://raw.githubusercontent.com/experthubowner/Experthub/main/guiones/"

if GameScripts[PlaceId] then
    loadstring(game:HttpGet(URLBase .. GameScripts[PlaceId]))()
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Expert Hub",
        Text = "Juego no soportado aún 😢",
        Duration = 5
    })
end
