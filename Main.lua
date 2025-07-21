local PlaceId = game.PlaceId
local GameScripts = {
    [111958650] = "ArsenalSilent.lua",
    [2317712696] = "PaintballSilent.lua",
    [292439477] = "Phantom.lua",
    [6872265039] = "Bedwars.lua",
    [2788229376] = "Dahood.lua"
}

local URLBase = "https://raw.githubusercontent.com/experthubowner/Experthub/main/scripts/"

if GameScripts[PlaceId] then
    loadstring(game:HttpGet(URLBase .. GameScripts[PlaceId]))()
else
    game.StarterGui:SetCore("SendNotification", {
        Title = "Expert Hub";
        Text = "Juego no soportado aún 😢";
        Duration = 5;
    })
end
