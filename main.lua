--[[ 
    LORELIB SUPER ULTRA 2026 - EDITION
    Developer: Randola (rlk)
    Features: Auto-Save, Anti-Duplicado, Intro System, Drip UI
]]

-- ==========================================
-- 1. SETUP DE SERVIÇOS E PASTAS
-- ==========================================
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local UI_NAME = "Lorelib_2026_Ultra"
local FolderName = "Lorelib_Data"
local SaveFolder = FolderName .. "/player_save"
local SaveFile = SaveFolder .. "/config.script"

-- Criar sistema de pastas no Executor (Delta/Workspace)
if not isfolder(FolderName) then makefolder(FolderName) end
if not isfolder(SaveFolder) then makefolder(SaveFolder) end

-- Tabela de Configurações (O que será salvo)
local PlayerSettings = {
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    MainColor = {0, 255, 120} -- Verde rlk
}

-- ==========================================
-- 2. FUNÇÕES DE SAVE E LOAD
-- ==========================================
local function SaveData()
    local success, result = pcall(function()
        return HttpService:JSONEncode(PlayerSettings)
    end)
    if success then
        writefile(SaveFile, result)
    end
end

local function LoadData()
    if isfile(SaveFile) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(SaveFile))
        end)
        if success then
            PlayerSettings = result
            print("Lorelib: Player Save carregado com sucesso, man!")
        end
    else
        SaveData() -- Cria o primeiro save se não existir
    end
end

LoadData()

-- ==========================================
-- 3. LIMPEZA E CRIAÇÃO DA UI
-- ==========================================
if CoreGui:FindFirstChild(UI_NAME) then CoreGui[UI_NAME]:Destroy() end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = UI_NAME
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

-- Tela de Intro/Fundo
local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(8, 8, 10)
bg.BorderSizePixel = 0
bg.Parent = ScreenGui
bg.ZIndex = 100

local IntroText = Instance.new("TextLabel")
IntroText.Parent = bg
IntroText.Size = UDim2.new(1, 0, 1, 0)
IntroText.BackgroundTransparency = 1
IntroText.Font = Enum.Font.SourceSansBold
IntroText.TextColor3 = Color3.new(1, 1, 1)
IntroText.TextSize = 28
IntroText.TextTransparency = 1
IntroText.ZIndex = 110

-- ==========================================
-- 4. INTERFACE PRINCIPAL (DRIP STYLE)
-- ==========================================
local Main = Instance.new("Frame")
Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
Main.Position = UDim2.new(0.5, -250, 0.5, -160)
Main.Size = UDim2.new(0, 500, 0, 320)
Main.Visible = false
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)

local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Parent = Main
Sidebar.BackgroundColor3 = Color3.fromRGB(12, 12, 14)
Sidebar.Size = UDim2.new(0, 140, 1, 0)
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0, 10)

-- ==========================================
-- 5. LÓGICA DE CARREGAMENTO (INTRO + LOADING)
-- ==========================================
local function AnimText(txt)
    IntroText.Text = txt
    TweenService:Create(IntroText, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
    task.wait(1.5)
    TweenService:Create(IntroText, TweenInfo.new(0.5), {TextTransparency = 1}):Play()
    task.wait(0.3)
end

task.spawn(function()
    -- As frases que você pediu
    AnimText("Você tem que saber disso")
    AnimText("Você nem sabe luau direito e quer executa script")
    AnimText("Você nem e dev")

    -- Setup Loading Circular
    local CircleContainer = Instance.new("Frame")
    CircleContainer.Size = UDim2.new(0, 100, 0, 100)
    CircleContainer.Position = UDim2.new(0.5, -50, 0.5, -50)
    CircleContainer.BackgroundTransparency = 1
    CircleContainer.Parent = bg

    local GreenCircle = Instance.new("ImageLabel")
    GreenCircle.Size = UDim2.new(1, 0, 1, 0)
    GreenCircle.Image = "rbxassetid://12308539653"
    GreenCircle.ImageColor3 = Color3.fromRGB(unpack(PlayerSettings.MainColor))
    GreenCircle.BackgroundTransparency = 1
    GreenCircle.Parent = CircleContainer

    local Gradient = Instance.new("UIGradient")
    Gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(0.501, 1),
        NumberSequenceKeypoint.new(1, 1)
    })
    Gradient.Rotation = -180
    Gradient.Parent = GreenCircle

    local PercentText = Instance.new("TextLabel")
    PercentText.Parent = CircleContainer
    PercentText.Size = UDim2.new(1, 0, 1, 0)
    PercentText.BackgroundTransparency = 1
    PercentText.Font = Enum.Font.Code
    PercentText.TextColor3 = Color3.new(1, 1, 1)
    PercentText.TextSize = 20
    PercentText.Text = "0%"

    -- Loop de 0 a 100
    for i = 0, 100, 1 do
        PercentText.Text = i .. "%"
        Gradient.Rotation = -180 + (i * 3.6)
        if i == 100 then
            PercentText.Text = "Pronto!"
            task.wait(0.5)
        end
        task.wait(0.02)
    end

    -- Finalização
    TweenService:Create(bg, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
    task.wait(0.5)
    bg:Destroy()
    Main.Visible = true

    -- APLICAÇÃO AUTOMÁTICA DO SAVE
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = PlayerSettings.WalkSpeed
        print("Status rlk: Velocidade aplicada do Save!")
    end
end)

-- Exemplo de Função para mudar e salvar
-- Para usar: SetSpeed(100)
function SetSpeed(value)
    PlayerSettings.WalkSpeed = value
    if LocalPlayer.Character then LocalPlayer.Character.Humanoid.WalkSpeed = value end
    SaveData()
end
