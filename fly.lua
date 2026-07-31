-- LocalScript: Coloque em StarterPlayerScripts ou StarterGui
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

-- Configurações do Fly
local flying = false
local flySpeed = 50
local minSpeed = 10
local maxSpeed = 300
local bodyVelocity = nil
local bodyGyro = nil

-- Recarregar referências ao reaparecer (Respawn)
player.CharacterAdded:Connect(function(newChar)
    character = newChar
    humanoid = character:WaitForChild("Humanoid")
    rootPart = character:WaitForChild("HumanoidRootPart")
    flying = false
end)

-- 1. Criação da Interface Gráfica (GUI)
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "FlyGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Painel Principal Flutuante (Quadrado)
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 150, 0, 150)
mainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true -- Permite arrastar o painel
mainFrame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainFrame

-- Título "FLY"
local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "FLY"
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.Parent = mainFrame

-- Botão de Ligar / Desligar
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0.8, 0, 0, 32)
toggleBtn.Position = UDim2.new(0.1, 0, 0.24, 0)
toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
toggleBtn.Text = "DESLIGADO"
toggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleBtn.TextSize = 13
toggleBtn.Font = Enum.Font.SourceSansBold
toggleBtn.Parent = mainFrame

local toggleCorner = Instance.new("UICorner")
toggleCorner.CornerRadius = UDim.new(0, 6)
toggleCorner.Parent = toggleBtn

-- Texto de Velocidade
local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(1, 0, 0, 20)
speedLabel.Position = UDim2.new(0, 0, 0.52, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "Velocidade: " .. flySpeed
speedLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
speedLabel.TextSize = 13
speedLabel.Font = Enum.Font.SourceSans
speedLabel.Parent = mainFrame

-- Botão Diminuir (-)
local minusBtn = Instance.new("TextButton")
minusBtn.Size = UDim2.new(0.35, 0, 0, 30)
minusBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
minusBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minusBtn.Text = "-"
minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minusBtn.TextSize = 22
minusBtn.Font = Enum.Font.SourceSansBold
minusBtn.Parent = mainFrame

local minusCorner = Instance.new("UICorner")
minusCorner.CornerRadius = UDim.new(0, 6)
minusCorner.Parent = minusBtn

-- Botão Aumentar (+)
local plusBtn = Instance.new("TextButton")
plusBtn.Size = UDim2.new(0.35, 0, 0, 30)
plusBtn.Position = UDim2.new(0.55, 0, 0.7, 0)
plusBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
plusBtn.Text = "+"
plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
plusBtn.TextSize = 22
plusBtn.Font = Enum.Font.SourceSansBold
plusBtn.Parent = mainFrame

local plusCorner = Instance.new("UICorner")
plusCorner.CornerRadius = UDim.new(0, 6)
plusCorner.Parent = plusBtn

-- 2. Lógica do Voo
local function startFlying()
    if not rootPart then return end

    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = rootPart.CFrame
    bodyGyro.Parent = rootPart

    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVelocity.Parent = rootPart

    humanoid.PlatformStand = true
end

local function stopFlying()
    if bodyGyro then bodyGyro:Destroy() end
    if bodyVelocity then bodyVelocity:Destroy() end
    if humanoid then humanoid.PlatformStand = false end
end

-- Atualização contínua da direção do voo
RunService.RenderStepped:Connect(function()
    if flying and rootPart and bodyVelocity and bodyGyro then
        local camera = workspace.CurrentCamera
        local moveVector = Vector3.zero

        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            moveVector = moveVector + camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            moveVector = moveVector - camera.CFrame.LookVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            moveVector = moveVector - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            moveVector = moveVector + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            moveVector = moveVector + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
            moveVector = moveVector - Vector3.new(0, 1, 0)
        end

        bodyGyro.CFrame = camera.CFrame
        bodyVelocity.Velocity = moveVector * flySpeed
    end
end)

-- Eventos da Interface
toggleBtn.MouseButton1Click:Connect(function()
    flying = not flying
    if flying then
        toggleBtn.Text = "LIGADO"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 80)
        startFlying()
    else
        toggleBtn.Text = "DESLIGADO"
        toggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        stopFlying()
    end
end)

minusBtn.MouseButton1Click:Connect(function()
    flySpeed = math.max(minSpeed, flySpeed - 10)
    speedLabel.Text = "Velocidade: " .. flySpeed
end)

plusBtn.MouseButton1Click:Connect(function()
    flySpeed = math.min(maxSpeed, flySpeed + 10)
    speedLabel.Text = "Velocidade: " .. flySpeed
end)
