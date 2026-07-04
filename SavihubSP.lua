-- Savi Hub Mais Foda de SP legit - Grow a Garden
-- Script com tela de carregamento, voo, velocidade, pulo, roubo, ESP

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- ========== TELA DE CARREGAMENTO ==========
local loadGui = Instance.new("ScreenGui")
loadGui.Name = "LoadingSavi"
loadGui.Parent = player:WaitForChild("PlayerGui")

local loadFrame = Instance.new("Frame")
loadFrame.Size = UDim2.new(1,0,1,0)
loadFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
loadFrame.Parent = loadGui

local loadLabel = Instance.new("TextLabel")
loadLabel.Size = UDim2.new(0,400,0,60)
loadLabel.Position = UDim2.new(0.5,-200,0.5,-30)
loadLabel.Text = "Savi Hub Mais Foda de SP legit
Carregando..."
loadLabel.TextColor3 = Color3.fromRGB(0,255,255)
loadLabel.TextScaled = true
loadLabel.BackgroundTransparency = 1
loadLabel.Parent = loadFrame

-- Simular carregamento (4 segundos)
wait(4)

-- Fade out
for i = 0,1,0.05 do
    loadFrame.BackgroundTransparency = i
    loadLabel.TextTransparency = i
    wait(0.03)
end
loadGui:Destroy()

-- ========== MENU PRINCIPAL ==========
local gui = Instance.new("ScreenGui")
gui.Name = "SaviHubGUI"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0,240,0,340)
frame.Position = UDim2.new(0,15,0,15)
frame.BackgroundColor3 = Color3.fromRGB(25,25,35)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(0,255,255)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,35)
title.Text = "Savi Hub Mais FODA DE SP"
title.TextColor3 = Color3.fromRGB(255,200,0)
title.BackgroundTransparency = 1
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- Função para criar botões
local function createBtn(text, y, color)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85,0,0,30)
    btn.Position = UDim2.new(0.075,0,0,y)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundColor3 = color or Color3.fromRGB(50,50,70)
    btn.BorderSizePixel = 0
    btn.Parent = frame
    return btn
end

local y = 45
local flyBtn = createBtn("Voo: OFF", y)
local speedBtn = createBtn("Velocidade 2x: OFF", y+40)
local jumpBtn = createBtn("Pulo 2x: OFF", y+80)
local stealBtn = createBtn("Roubar (teleporte)", y+120, Color3.fromRGB(180,50,50))
local fruitBtn = createBtn("Roubar Fruta (noite)", y+160, Color3.fromRGB(50,180,50))
local espBtn = createBtn("ESP: OFF", y+200)
local closeBtn = createBtn("Fechar", y+260, Color3.fromRGB(100,100,100))

-- ========== FUNÇÕES ==========

-- Voo
local flying = false
flyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    flyBtn.Text = flying and "Voo: ON" or "Voo: OFF"
    local char = player.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        local root = char:FindFirstChild("HumanoidRootPart")
        if hum and root then
            hum.PlatformStand = flying
            if flying then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(1e5,1e5,1e5)
                bv.Velocity = Vector3.new(0,50,0)
                bv.Parent = root
            else
                for _, v in pairs(root:GetDescendants()) do
                    if v:IsA("BodyVelocity") then v:Destroy() end
                end
            end
        end
    end
end)

-- Velocidade 2x
speedBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            if hum.WalkSpeed == 32 then
                hum.WalkSpeed = 64
                speedBtn.Text = "Velocidade 2x: ON"
            else
                hum.WalkSpeed = 32
                speedBtn.Text = "Velocidade 2x: OFF"
            end
        end
    end
end)

-- Pulo 2x
jumpBtn.MouseButton1Click:Connect(function()
    local char = player.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            if hum.JumpPower == 50 then
                hum.JumpPower = 100
                jumpBtn.Text = "Pulo 2x: ON"
            else
                hum.JumpPower = 50
                jumpBtn.Text = "Pulo 2x: OFF"
            end
        end
    end
end)

-- Roubar (teleportar para o jogador mais próximo)
stealBtn.MouseButton1Click:Connect(function()
    local closest, minDist = nil, math.huge
    for _, plr in pairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (plr.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).magnitude
            if dist < minDist then
                minDist = dist
                closest = plr
            end
        end
    end
    if closest then
        player.Character.HumanoidRootPart.CFrame = closest.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,3)
    end
end)

-- Roubar Fruta (noite) - tenta pegar frutas próximas (exemplo genérico)
fruitBtn.MouseButton1Click:Connect(function()
    -- Verifica se é noite (Lighting)
    local lighting = game:GetService("Lighting")
    if lighting.ClockTime >= 18 or lighting.ClockTime <= 6 then
        -- Procura por frutas (exemplo: objetos com "Fruit" no nome)
        local fruits = {}
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and (obj.Name:lower():find("fruta") or obj.Name:lower():find("fruit")) then
                table.insert(fruits, obj)
            end
        end
        if #fruits > 0 then
            -- Teleporta para a fruta mais próxima
            local closestFruit, minDist = nil, math.huge
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                for _, fruit in pairs(fruits) do
                    local dist = (fruit.Position - root.Position).magnitude
                    if dist < minDist then
                        minDist = dist
                        closestFruit = fruit
                    end
                end
                if closestFruit then
                    root.CFrame = closestFruit.CFrame * CFrame.new(0,2,0)
                end
            end
        else
            -- Notificação (opcional)
            print("Nenhuma fruta encontrada")
        end
    else
        print("Ainda não é noite (use das 18h às 6h)")
    end
end)

-- ESP (destacar jogadores)
local espEnabled = false
local espHighlights = {}
espBtn.MouseButton1Click:Connect(function()
    espEnabled = not espEnabled
    espBtn.Text = espEnabled and "ESP: ON" or "ESP: OFF"
    if espEnabled then
        -- Cria highlights para todos os jogadores
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255,0,0)
                highlight.OutlineColor = Color3.fromRGB(255,255,255)
                highlight.Parent = plr.Character
                espHighlights[plr] = highlight
            end
        end
        -- Conecta ao evento de jogador entrar
        game.Players.PlayerAdded:Connect(function(newPlr)
            wait(1)
            if espEnabled and newPlr.Character then
                local highlight = Instance.new("Highlight")
                highlight.FillColor = Color3.fromRGB(255,0,0)
                highlight.OutlineColor = Color3.fromRGB(255,255,255)
                highlight.Parent = newPlr.Character
                espHighlights[newPlr] = highlight
            end
        end)
    else
        -- Remove todos os highlights
        for plr, highlight in pairs(espHighlights) do
            highlight:Destroy()
        end
        espHighlights = {}
    end
end)

-- Fechar GUI
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
end)

-- Garantir que o ESP funcione para jogadores que entram depois
game.Players.PlayerAdded:Connect(function(plr)
    plr.CharacterAdded:Connect(function(char)
        wait(0.5)
        if espEnabled then
            local highlight = Instance.new("Highlight")
            highlight.FillColor = Color3.fromRGB(255,0,0)
            highlight.OutlineColor = Color3.fromRGB(255,255,255)
            highlight.Parent = char
            espHighlights[plr] = highlight
        end
    end)
end)
