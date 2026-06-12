-- [[ LUIZ HUB V1 - VERSÃO 100% CORRIGIDA SEM ERROS ]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove versões antigas para evitar botões duplicados na tela
if PlayerGui:FindFirstChild("LUIZ_Hub_V1") then
    PlayerGui.LUIZ_Hub_V1:Destroy()
end

-- Criando a ScreenGui Principal
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LUIZ_Hub_V1"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false

-- CONTROLES PRINCIPAIS DO MENU
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local SavePosBtn = Instance.new("TextButton")
local TpPosBtn = Instance.new("TextButton")
local ToggleBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

-- Botão Flutuante [ + ]
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
ToggleBtn.Position = UDim2.new(0, 15, 0, 15)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Text = "[ + ]"
ToggleBtn.TextColor3 = Color3.fromRGB(0, 255, 150)
ToggleBtn.TextSize = 18
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Visible = false
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 8)

-- Painel Principal
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.Position = UDim2.new(0.5, -110, 0.5, -92)
MainFrame.Size = UDim2.new(0, 220, 0, 185)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = false 
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Título LUIZ HUB V1
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 15, 0, 10)
Title.Size = UDim2.new(0, 130, 0, 30)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "LUIZ HUB V1"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 22
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Botão [ OBR ] (Ocultar Painel)
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(0, 175, 0, 10)
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "[ OBR ]"
CloseBtn.TextColor3 = Color3.fromRGB(255, 85, 85)
CloseBtn.TextSize = 12

-- Estilização dos botões internos
local function styleButton(btn, text, pos, color)
    btn.Parent = MainFrame
    btn.BackgroundColor3 = color
    btn.Position = pos
    btn.Size = UDim2.new(0, 180, 0, 45)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextSize = 14
    Instance.new("UICorner", btn)
end

styleButton(SavePosBtn, "SALVAR POSIÇÃO", UDim2.new(0, 20, 0, 60), Color3.fromRGB(0, 120, 255))
styleButton(TpPosBtn, "TELETRANSPORTAR POS", UDim2.new(0, 20, 0, 115), Color3.fromRGB(120, 0, 255))

-- PAINEL DE KEY (ESTILO EMBED VERMELHO)
local KeyFrame = Instance.new("Frame")
local KeyTitle = Instance.new("TextLabel")
local KeySubtitle = Instance.new("TextLabel")
local KeyInput = Instance.new("TextBox")
local VerifyBtn = Instance.new("TextButton")

KeyFrame.Name = "KeyFrame"
KeyFrame.Parent = ScreenGui
KeyFrame.BackgroundColor3 = Color3.fromRGB(35, 15, 15)
KeyFrame.BorderColor3 = Color3.fromRGB(255, 0, 50)
KeyFrame.BorderSizePixel = 2
KeyFrame.Position = UDim2.new(0.5, -120, 0.5, -100)
KeyFrame.Size = UDim2.new(0, 240, 0, 200)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 10)

KeyTitle.Parent = KeyFrame
KeyTitle.BackgroundTransparency = 1
KeyTitle.Position = UDim2.new(0, 0, 0, 15)
KeyTitle.Size = UDim2.new(1, 0, 0, 25)
KeyTitle.Font = Enum.Font.SourceSansBold
KeyTitle.Text = "LUIZ HUB V1"
KeyTitle.TextColor3 = Color3.fromRGB(255, 0, 50)
KeyTitle.TextSize = 24

KeySubtitle.Parent = KeyFrame
KeySubtitle.BackgroundTransparency = 1
KeySubtitle.Position = UDim2.new(0, 0, 0, 45)
KeySubtitle.Size = UDim2.new(1, 0, 0, 20)
KeySubtitle.Font = Enum.Font.SourceSans
KeySubtitle.Text = "coloque sua Key"
KeySubtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
KeySubtitle.TextSize = 14

KeyInput.Parent = KeyFrame
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 10, 10)
KeyInput.BorderColor3 = Color3.fromRGB(100, 0, 20)
KeyInput.Position = UDim2.new(0, 20, 0, 80)
KeyInput.Size = UDim2.new(0, 200, 0, 35)
KeyInput.Font = Enum.Font.SourceSans
KeyInput.PlaceholderText = "Insira a chave aqui..."
KeyInput.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
KeyInput.Text = ""
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.TextSize = 14
Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 6)

VerifyBtn.Parent = KeyFrame
VerifyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 40)
VerifyBtn.Position = UDim2.new(0, 20, 0, 135)
VerifyBtn.Size = UDim2.new(0, 200, 0, 40)
VerifyBtn.Font = Enum.Font.SourceSansBold
VerifyBtn.Text = "verificar key"
VerifyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
VerifyBtn.TextSize = 16
Instance.new("UICorner", VerifyBtn).CornerRadius = UDim.new(0, 6)

-- LÓGICA DO SISTEMA (BOTÕES E VERIFICAÇÕES)
local savedPos = nil

VerifyBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == "LUIZ-HUB" then
        KeyFrame:Destroy()
        MainFrame.Visible = true
    else
        VerifyBtn.Text = "KEY INCORRETA! ✗"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 20)
        task.wait(1.5)
        VerifyBtn.Text = "verificar key"
        VerifyBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 40)
    end
end)

SavePosBtn.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        savedPos = LocalPlayer.Character.HumanoidRootPart.CFrame
        SavePosBtn.Text = "SALVO! ✓"
        task.wait(1)
        SavePosBtn.Text = "SALVAR POSIÇÃO"
    end
end)

TpPosBtn.MouseButton1Click:Connect(function()
    if savedPos and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = savedPos
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    ToggleBtn.Visible = true
end)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    ToggleBtn.Visible = false
end)
