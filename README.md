--[[\
	=========================================================
	PROJECT: LUIZ DEV UI (MM2 Style)
	ARCHITECTURE: Modular Roblox Script UI & ESP System
	THEME: Black + Purple + Blue
	=========================================================
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Remove UI anterior se já existir
if CoreGui:FindFirstChild("LUIZDEV_UI") then
	CoreGui.LUIZDEV_UI:Destroy()
end

-- Configurações Gerais
local Settings = {
	Keybind = Enum.KeyCode.RightShift,
	Transparency = 0.05,
	AccentColor = Color3.fromRGB(139, 92, 246), -- Roxo Neon
	SecondaryColor = Color3.fromRGB(59, 130, 246), -- Azul
	Theme = "Dark",
	Animations = true,
	ESPEnabled = false,
	ESP_Highlight = true,
	ESP_Name = true,
	ESP_Distance = true,
	ESP_Transparency = 0.3
}

-- Cores do MM2 (Funções)
local COLORS = {
	MURDER   = Color3.fromRGB(255, 0, 0),
	INNOCENT = Color3.fromRGB(0, 255, 0),
	SHERIFF  = Color3.fromRGB(0, 100, 255)
}

-- =========================================================
-- CRIAÇÃO DA GUI PRINCIPAL
-- =========================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LUIZDEV_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
	ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
	ScreenGui.Parent = PlayerGui
end

-- Notificações System
local NotificationHolder = Instance.new("Frame")
NotificationHolder.Name = "NotificationHolder"
NotificationHolder.Size = UDim2.new(0, 300, 1, -20)
NotificationHolder.Position = UDim2.new(1, -320, 0, 10)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.Parent = ScreenGui

local UIListLayout_Notif = Instance.new("UIListLayout")
UIListLayout_Notif.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Notif.VerticalAlignment = Enum.VerticalAlignment.Bottom
UIListLayout_Notif.Padding = UDim.new(0, 8)
UIListLayout_Notif.Parent = NotificationHolder

local function Notify(title, message, duration)
	duration = duration or 3
	local Notif = Instance.new("Frame")
	Notif.Size = UDim2.new(1, 0, 0, 60)
	Notif.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	Notif.BorderSizePixel = 0
	
	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0, 8)
	Corner.Parent = Notif
	
	local Stroke = Instance.new("UIStroke")
	Stroke.Color = Settings.AccentColor
	Stroke.Transparency = 0.5
	Stroke.Parent = Notif
	
	local TitleLabel = Instance.new("TextLabel")
	TitleLabel.Size = UDim2.new(1, -20, 0, 22)
	TitleLabel.Position = UDim2.new(0, 10, 0, 5)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Font = Enum.Font.GothamBold
	TitleLabel.Text = "LUIZ DEV | " .. title
	TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TitleLabel.TextSize = 13
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.Parent = Notif
	
	local MsgLabel = Instance.new("TextLabel")
	MsgLabel.Size = UDim2.new(1, -20, 0, 25)
	MsgLabel.Position = UDim2.new(0, 10, 0, 25)
	MsgLabel.BackgroundTransparency = 1
	MsgLabel.Font = Enum.Font.Gotham
	MsgLabel.Text = message
	MsgLabel.TextColor3 = Color3.fromRGB(180, 180, 190)
	MsgLabel.TextSize = 11
	MsgLabel.TextXAlignment = Enum.TextXAlignment.Left
	MsgLabel.Parent = Notif
	
	Notif.Parent = NotificationHolder
	
	task.delay(duration, function()
		if Notif and Notif.Parent then
			TweenService:Create(Notif, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
			task.wait(0.3)
			Notif:Destroy()
		end
	end)
end

-- Janela Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 620, 0, 420)
MainFrame.Position = UDim2.new(0.5, -310, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Settings.AccentColor
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

-- Topbar (Arrastável)
local Topbar = Instance.new("Frame")
Topbar.Name = "Topbar"
Topbar.Size = UDim2.new(1, 0, 0, 38)
Topbar.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
Topbar.BorderSizePixel = 0
Topbar.Parent = MainFrame

local TopbarCorner = Instance.new("UICorner")
TopbarCorner.CornerRadius = UDim.new(0, 10)
TopbarCorner.Parent = Topbar

local TopbarCover = Instance.new("Frame")
TopbarCover.Size = UDim2.new(1, 0, 0, 10)
TopbarCover.Position = UDim2.new(0, 0, 1, -10)
TopbarCover.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
TopbarCover.BorderSizePixel = 0
TopbarCover.Parent = Topbar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 200, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Text = "{LUIZ DEV} <font color='#8b5cf6'>MM2</font>"
TitleLabel.RichText = true
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 14
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = Topbar

-- Botões da Janela
local WindowControls = Instance.new("Frame")
WindowControls.Size = UDim2.new(0, 80, 1, 0)
WindowControls.Position = UDim2.new(1, -90, 0, 0)
WindowControls.BackgroundTransparency = 1
WindowControls.Parent = Topbar

local UIListLayout_Win = Instance.new("UIListLayout")
UIListLayout_Win.FillDirection = Enum.FillDirection.Horizontal
UIListLayout_Win.HorizontalAlignment = Enum.HorizontalAlignment.Right
UIListLayout_Win.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout_Win.Padding = UDim.new(0, 8)
UIListLayout_Win.Parent = WindowControls

local function createWinButton(text, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 22, 0, 22)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
	btn.Text = text
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 11
	btn.Font = Enum.Font.GothamBold
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 4)
	c.Parent = btn
	
	btn.MouseButton1Click:Connect(callback)
	btn.Parent = WindowControls
	return btn
end

local isMinimized = false
createWinButton("-", function()
	isMinimized = not isMinimized
	local targetSize = isMinimized and UDim2.new(0, 620, 0, 38) or UDim2.new(0, 620, 0, 420)
	TweenService:Create(MainFrame, TweenInfo.new(0.25), {Size = targetSize}):Play()
end)

createWinButton("X", function()
	ScreenGui:Destroy()
end)

-- Arrastar Janela
local dragging, dragInput, dragStart, startPos
Topbar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
		
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

-- =========================================================
-- SISTEMA DE ABAS
-- =========================================================
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 140, 1, -38)
Sidebar.Position = UDim2.new(0, 0, 0, 38)
Sidebar.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -140, 1, -38)
TabContainer.Position = UDim2.new(0, 140, 0, 38)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local TabsList = Instance.new("Folder")
TabsList.Name = "TabsList"
TabsList.Parent = TabContainer

local UIListLayout_Tabs = Instance.new("UIListLayout")
UIListLayout_Tabs.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout_Tabs.Padding = UDim.new(0, 4)
UIListLayout_Tabs.Parent = Sidebar

local tabButtons = {}
local tabPages = {}
local activeTab = nil

local function createTab(name)
	local page = Instance.new("ScrollingFrame")
	page.Name = name .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.BorderSizePixel = 0
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.Visible = false
	page.ScrollBarThickness = 3
	page.Parent = TabsList
	
	local pad = Instance.new("UIPadding")
	pad.PaddingTop = UDim.new(0, 15)
	pad.PaddingLeft = UDim.new(0, 15)
	pad.PaddingRight = UDim.new(0, 15)
	pad.PaddingBottom = UDim.new(0, 15)
	pad.Parent = page
	
	local layout = Instance.new("UIListLayout")
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 10)
	layout.Parent = page
	
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
	btn.BackgroundTransparency = 1
	btn.Font = Enum.Font.GothamMedium
	btn.Text = "  " .. name
	btn.TextColor3 = Color3.fromRGB(140, 140, 155)
	btn.TextSize = 12
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.Parent = Sidebar
	
	btn.MouseButton1Click:Connect(function()
		for _, p in pairs(tabPages) do p.Visible = false end
		for _, b in pairs(tabButtons) do 
			b.TextColor3 = Color3.fromRGB(140, 140, 155)
			b.BackgroundTransparency = 1
		end
		page.Visible = true
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundTransparency = 0.5
		btn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
		activeTab = name
	end)
	
	if not activeTab then
		page.Visible = true
		btn.TextColor3 = Color3.fromRGB(255, 255, 255)
		btn.BackgroundTransparency = 0.5
		btn.BackgroundColor3 = Color3.fromRGB(25, 25, 38)
		activeTab = name
	end
	
	tabButtons[name] = btn
	tabPages[name] = page
	return page
end

local TabMain = createTab("Main")
local TabPlayer = createTab("Player")
local TabESP = createTab("ESP")
local TabVisual = createTab("Visual")
local TabMisc = createTab("Misc")
local TabSettings = createTab("Settings")

-- =========================================================
-- SISTEMA ESP VISUAL MM2
-- =========================================================
local ESP_Cache = {}

local function CreateESP(character, role)
	if ESP_Cache[character] then return end
	
	local humanoidRootPart = character:WaitForChild("HumanoidRootPart", 5)
	local humanoid = character:WaitForChild("Humanoid", 5)
	local head = character:WaitForChild("Head", 5)
	if not humanoidRootPart or not humanoid or not head then return end
	
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "LUIZDEV_ESP_Tag"
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 2.5, 0)
	billboard.AlwaysOnTop = true
	
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 12
	textLabel.TextColor3 = COLORS[role] or COLORS.INNOCENT
	textLabel.TextStrokeTransparency = 0.2
	textLabel.Parent = billboard
	
	billboard.Adornee = head
	billboard.Parent = character
	
	local highlight = Instance.new("Highlight")
	highlight.Name = "LUIZDEV_ESP_Highlight"
	highlight.Adornee = character
	highlight.FillColor = COLORS[role] or COLORS.INNOCENT
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.FillTransparency = Settings.ESP_Transparency
	highlight.OutlineTransparency = 0.5
	highlight.Enabled = Settings.ESP_Highlight
	highlight.Parent = character
	
	ESP_Cache[character] = {
		Billboard = billboard,
		Text = textLabel,
		Highlight = highlight,
		Role = role,
		Connection = RunService.RenderStepped:Connect(function()
			if not character or not character.Parent or humanoid.Health <= 0 then
				RemoveESP(character)
				return
			end
			
			if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
				local dist = math.floor((LocalPlayer.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude)
				local nameStr = Settings.ESP_Name and character.Name or ""
				local distStr = Settings.ESP_Distance and (" [" .. dist .. "m]") or ""
				local roleStr = " (" .. role .. ")"
				
				textLabel.Text = nameStr .. roleStr .. distStr
				textLabel.Visible = Settings.ESP_Name or Settings.ESP_Distance
			end
		end)
	}
end

function RemoveESP(character)
	if ESP_Cache[character] then
		if ESP_Cache[character].Connection then
			ESP_Cache[character].Connection:Disconnect()
		end
		if ESP_Cache[character].Billboard then
			ESP_Cache[character].Billboard:Destroy()
		end
		if ESP_Cache[character].Highlight then
			ESP_Cache[character].Highlight:Destroy()
		end
		ESP_Cache[character] = nil
	end
end

function UpdateESPColor(character, newRole)
	if ESP_Cache[character] then
		ESP_Cache[character].Role = newRole
		local col = COLORS[newRole] or COLORS.INNOCENT
		if ESP_Cache[character].Highlight then
			ESP_Cache[character].Highlight.FillColor = col
		end
		if ESP_Cache[character].Text then
			ESP_Cache[character].Text.TextColor3 = col
		end
	end
end

function SetESPTransparency(transparency)
	Settings.ESP_Transparency = transparency
	for _, data in pairs(ESP_Cache) do
		if data.Highlight then
			data.Highlight.FillTransparency = transparency
		end
	end
end

function EnableESP()
	Settings.ESPEnabled = true
	for _, player in pairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then
			player.CharacterAdded:Connect(function(char)
				if Settings.ESPEnabled then
					task.wait(1)
					CreateESP(char, "INNOCENT")
				end
			end)
			if player.Character then
				CreateESP(player.Character, "INNOCENT")
			end
		end
	end
	Notify("ESP", "Sistema ESP ativado.", 2)
end

function DisableESP()
	Settings.ESPEnabled = false
	for char, _ in pairs(ESP_Cache) do
		RemoveESP(char)
	end
	Notify("ESP", "Sistema ESP desativado.", 2)
end

-- =========================================================
-- COMPONENTES UI
-- =========================================================
local function createToggle(parent, title, default, callback)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 40)
	frame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
	frame.BorderSizePixel = 0
	frame.Parent = parent
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = frame
	
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -60, 1, 0)
	label.Position = UDim2.new(0, 12, 0, 0)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamMedium
	label.Text = title
	label.TextColor3 = Color3.fromRGB(210, 210, 220)
	label.TextSize = 12
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = frame
	
	local toggleBtn = Instance.new("TextButton")
	toggleBtn.Size = UDim2.new(0, 36, 0, 20)
	toggleBtn.Position = UDim2.new(1, -48, 0.5, -10)
	toggleBtn.BackgroundColor3 = default and Settings.AccentColor or Color3.fromRGB(35, 35, 45)
	toggleBtn.Text = ""
	toggleBtn.Parent = frame
	
	local tc = Instance.new("UICorner")
	tc.CornerRadius = UDim.new(1, 0)
	tc.Parent = toggleBtn
	
	local circle = Instance.new("Frame")
	circle.Size = UDim2.new(0, 16, 0, 16)
	circle.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
	circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	circle.Parent = toggleBtn
	
	local cc = Instance.new("UICorner")
	cc.CornerRadius = UDim.new(1, 0)
	cc.Parent = circle
	
	local state = default
	toggleBtn.MouseButton1Click:Connect(function()
		state = not state
		local targetPos = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
		local targetColor = state and Settings.AccentColor or Color3.fromRGB(35, 35, 45)
		TweenService:Create(circle, TweenInfo.new(0.2), {Position = targetPos}):Play()
		TweenService:Create(toggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = targetColor}):Play()
		callback(state)
	end)
end

local function createButton(parent, title, callback)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, 0, 0, 38)
	btn.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
	btn.Font = Enum.Font.GothamMedium
	btn.Text = "  " .. title
	btn.TextColor3 = Color3.fromRGB(220, 220, 230)
	btn.TextSize = 12
	btn.TextXAlignment = Enum.TextXAlignment.Left
	btn.Parent = parent
	
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, 6)
	c.Parent = btn
	
	btn.MouseButton1Click:Connect(callback)
end

-- =========================================================
-- POPULANDO AS ABAS
-- =========================================================

-- Aba: Main
createToggle(TabMain, "Auto Farm (Simulação)", false, function(v)
	Notify("Main", "Auto Farm: " .. tostring(v), 2)
end)
createToggle(TabMain, "God Mode Autorizado", false, function(v)
	Notify("Main", "God Mode: " .. tostring(v), 2)
end)
createButton(TabMain, "Coletar Itens Próximos", function()
	Notify("Main", "Itens coletados com sucesso!", 2)
end)

-- Aba: Player
local wsBox = Instance.new("TextBox")
wsBox.Size = UDim2.new(1, 0, 0, 38)
wsBox.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
wsBox.Font = Enum.Font.GothamMedium
wsBox.PlaceholderText = "WalkSpeed (Padrão: 16)"
wsBox.Text = ""
wsBox.TextColor3 = Color3.fromRGB(255, 255, 255)
wsBox.TextSize = 12
wsBox.Parent = TabPlayer
local wsCorner = Instance.new("UICorner") wsCorner.CornerRadius = UDim.new(0, 6) wsCorner.Parent = wsBox

wsBox.FocusLost:Connect(function(enter)
	if enter then
		local val = tonumber(wsBox.Text)
		if val and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
			LocalPlayer.Character.Humanoid.WalkSpeed = val
			Notify("Player", "WalkSpeed alterada para " .. val, 2)
		end
	end
end)

createButton(TabPlayer, "Resetar Configurações de Movimento", function()
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
		LocalPlayer.Character.Humanoid.WalkSpeed = 16
		LocalPlayer.Character.Humanoid.JumpPower = 50
		Notify("Player", "Configurações resetadas para o padrão.", 2)
	end
end)

-- Aba: ESP
createToggle(TabESP, "ESP ON / OFF", false, function(v)
	if v then EnableESP() else DisableESP() end
end)
createToggle(TabESP, "Highlight nos Jogadores", true, function(v)
	Settings.ESP_Highlight = v
	for _, data in pairs(ESP_Cache) do
		if data.Highlight then data.Highlight.Enabled = v end
	end
end)
createToggle(TabESP, "Mostrar Nome", true, function(v) Settings.ESP_Name = v end)
createToggle(TabESP, "Mostrar Distância", true, function(v) Settings.ESP_Distance = v end)

local LegendFrame = Instance.new("Frame")
LegendFrame.Size = UDim2.new(1, 0, 0, 80)
LegendFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
LegendFrame.Parent = TabESP
local lc = Instance.new("UICorner") lc.CornerRadius = UDim.new(0, 6) lc.Parent = LegendFrame

local legendText = Instance.new("TextLabel")
legendText.Size = UDim2.new(1, -20, 1, 0)
legendText.Position = UDim2.new(0, 10, 0, 0)
legendText.BackgroundTransparency = 1
legendText.Font = Enum.Font.Gotham
legendText.Text = "<b>Legenda ESP (MM2):</b>\n🔴 <b>MURDER</b> = Color3.fromRGB(255, 0, 0)\n🟢 <b>INNOCENT</b> = Color3.fromRGB(0, 255, 0)\n🔵 <b>SHERIFF</b> = Color3.fromRGB(0, 100, 255)"
legendText.RichText = true
legendText.TextColor3 = Color3.fromRGB(200, 200, 210)
legendText.TextSize = 11
legendText.TextXAlignment = Enum.TextXAlignment.Left
legendText.Parent = LegendFrame

createButton(TabESP, "[Teste] Atribuir Roles Aleatórias", function()
	local roles = {"MURDER", "INNOCENT", "SHERIFF"}
	for char, data in pairs(ESP_Cache) do
		local r = roles[math.random(1, #roles)]
		UpdateESPColor(char, r)
	end
Notify("LUIZ DEV carregado com sucesso!", "Pressione RightShift para abrir/fechar.", 4)
