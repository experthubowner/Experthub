-- 💰 ExpertHub: Build A Boat AutoGold 💸
-- 🔥 Script creado por el LUA GOD para Arceus X

-- Detectar leaderstats del jugador
local player = game.Players.LocalPlayer
local stats = player:WaitForChild("leaderstats")
local gold = stats:WaitForChild("Gold") -- A veces se llama Coins

-- Aumentar 200 cada segundo
while true do
    gold.Value = gold.Value + 200
    wait(1)
end
