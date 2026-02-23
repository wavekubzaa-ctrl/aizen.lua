--[[ 
    bukwaveHUB PRO ULTIMATE V12 (COMBAT UPDATE)
    FEATURES: Smooth Aimlock, Tab Switching, Dumbbell Fix, Anti-AFK
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

-- // Services //
local _TS = game:GetService("TweenService")
local _SG = game:GetService("StarterGui")
local _LP = game.Players.LocalPlayer
local _MOUSE = _LP:GetMouse()
local _CAMERA = workspace.CurrentCamera

-- // Global Config //
getgenv().Config = {
    MainColor = Color3.fromRGB(200, 0, 0),
    AutoLift = false,
    AutoRebirth = false,
    AntiAFK = true,
    Aimlock = false,
    AimSmoothness = 0.1, -- 0 to 1
    AimPart = "HumanoidRootPart"
}

-- // UI Cleanup //
if game.CoreGui:FindFirstChild("BWH_ULTIMATE") then game.CoreGui.BWH_ULTIMATE:Destroy() end

local _G = Instance.new("ScreenGui", game.CoreGui)
_G.Name = "BWH_ULTIMATE"

-- // Notification //
local function Notify(t, txt)
    _SG:SetCore("SendNotification", {Title = t, Text = txt, Duration = 3})
end

-- // Toggle Button //
local _Btn = Instance.new("TextButton", _G)
_Btn.Size = UDim2.new(0, 50, 0, 50)
_Btn.Position = UDim2.new(0, 20, 0.4, 0)
_Btn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_Btn.Text = "BH"
_Btn.TextColor3 = Color3.new(1,1,1)
_Btn.Font = Enum.Font.GothamBold
_Btn.TextSize = 18
_Btn.Draggable = true
_Btn.Active = true
Instance.new("UICorner", _Btn).CornerRadius = UDim.new(0, 10)
local _BtnS = Instance.new("UIStroke", _Btn)
_BtnS.Color = getgenv().Config.MainColor
_BtnS.Thickness = 2

-- // Main Frame //
local _Main = Instance.new("Frame", _G)
_Main.Size = UDim2.new(0, 400, 0, 300)
_Main.Position = UDim2.new(0.5, -200, 0.4, -150)
_Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
_Main.Visible = false
_Main.ClipsDescendants = true
_Main.Draggable = true
_Main.Active = true
Instance.new("UICorner", _Main).CornerRadius = UDim.new(0, 12)
local _MainS = Instance.new("UIStroke", _Main)
_MainS.Color = getgenv().Config.MainColor
_MainS.Thickness = 1.5

-- // Sidebar //
local _Side = Instance.new("Frame", _Main)
_Side.Size = UDim2.new(0, 100, 1, 0)
_Side.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", _Side).CornerRadius = UDim.new(0, 12)

local _Title = Instance.new("TextLabel", _Side)
_Title.Size = UDim2.new(1, 0, 0, 50)
_Title.Text = "bukwave"
_Title.TextColor3 = getgenv().Config.MainColor
_Title.Font = Enum.Font.GothamBold
_Title.TextSize = 14
_Title.BackgroundTransparency = 1

-- // Page Container //
local _Pages = Instance.new("Frame", _Main)
_Pages.Position = UDim2.new(0, 110, 0, 10)
_Pages.Size = UDim2.new(1, -120, 1, -20)
_Pages.BackgroundTransparency = 1

local PagesList = {}
local function CreatePage(name)
    local p = Instance.new("ScrollingFrame", _Pages)
    p.Name = name
    p.Size = UDim2.new(1, 0, 1, 0)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.ScrollBarThickness = 0
    local layout = Instance.new("UIListLayout", p)
    layout.Padding = UDim.new(0, 8)
    PagesList[name] = p
    return p
end

local _PageMain = CreatePage("Farm")
local _PageCombat = CreatePage("Combat")
local _PageSettings = CreatePage("Settings")
_PageMain.Visible = true

-- // Tab Manager //
local function AddTab(name, targetPage, index)
    local btn = Instance.new("TextButton", _Side)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 60 + (40 * (index-1)))
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name
    btn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(PagesList) do p.Visible = false end
        targetPage.Visible = true
    end)
end

AddTab("Farm", _PageMain, 1)
AddTab("Combat", _PageCombat, 2)
AddTab("Settings", _PageSettings, 3)

-- // UI Component Builder //
local function CreateSwitch(parent, text, callback)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 40)
    f.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    
    local l = Instance.new("TextLabel", f)
    l.Text = "  " .. text; l.Size = UDim2.new(0.7, 0, 1, 0)
    l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1)
    l.Font = Enum.Font.Gotham; l.TextSize = 11; l.TextXAlignment = Enum.TextXAlignment.Left
    
    local s = Instance.new("TextButton", f)
    s.Size = UDim2.new(0, 40, 0, 20)
    s.Position = UDim2.new(1, -50, 0.5, -10)
    s.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    s.Text = ""
    Instance.new("UICorner", s).CornerRadius = UDim.new(1, 0)
    
    local d = Instance.new("Frame", s)
    d.Size = UDim2.new(0, 16, 0, 16)
    d.Position = UDim2.new(0, 2, 0.5, -8)
    d.BackgroundColor3 = Color3.new(1,1,1)
    Instance.new("UICorner", d).CornerRadius = UDim.new(1, 0)
    
    local active = false
    s.MouseButton1Click:Connect(function()
        active = not active
        _TS:Create(d, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
        _TS:Create(s, TweenInfo.new(0.2), {BackgroundColor3 = active and getgenv().Config.MainColor or Color3.fromRGB(45, 45, 45)}):Play()
        callback(active)
    end)
end

-- // Features: Farm //
CreateSwitch(_PageMain, "Auto Dumbbell Only", function(v)
    getgenv().Config.AutoLift = v
    task.spawn(function()
        while getgenv().Config.AutoLift do
            pcall(function()
                local char = _LP.Character
                local db = _LP.Backpack:FindFirstChild("Dumbbell") or char:FindFirstChild("Dumbbell")
                if db then
                    if db.Parent ~= char then db.Parent = char end
                    db:Activate()
                end
            end)
            task.wait(0.01)
        end
    end)
end)

CreateSwitch(_PageMain, "Auto Rebirth", function(v)
    getgenv().Config.AutoRebirth = v
    task.spawn(function()
        while getgenv().Config.AutoRebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(2.2)
        end
    end)
end)

-- // Features: Combat (Aimlock) //
CreateSwitch(_PageCombat, "Aimlock Enabled", function(v)
    getgenv().Config.Aimlock = v
end)

local function GetClosestPlayer()
    local closest = nil
    local dist = math.huge
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= _LP and p.Character and p.Character:FindFirstChild(getgenv().Config.AimPart) and p.Character:FindFirstChild("Humanoid") and p.Character.Humanoid.Health > 0 then
            local pos, onScreen = _CAMERA:WorldToViewportPoint(p.Character[getgenv().Config.AimPart].Position)
            if onScreen then
                local mag = (Vector2.new(pos.X, pos.Y) - Vector2.new(_MOUSE.X, _MOUSE.Y)).Magnitude
                if mag < dist then
                    dist = mag
                    closest = p
                end
            end
        end
    end
    return closest
end

game:GetService("RunService").RenderStepped:Connect(function()
    if getgenv().Config.Aimlock then
        local target = GetClosestPlayer()
        if target and target.Character then
            local targetPos = target.Character[getgenv().Config.AimPart].Position
            _CAMERA.CFrame = _CAMERA.CFrame:Lerp(CFrame.new(_CAMERA.CFrame.Position, targetPos), getgenv().Config.AimSmoothness)
        end
    end
end)

-- // Settings //
local function CreateThemeBtn(parent, color, name)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 38)
    b.BackgroundColor3 = color
    b.Text = name; b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold; b.TextSize = 12
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        getgenv().Config.MainColor = color
        _MainS.Color = color; _BtnS.Color = color; _Title.TextColor3 = color
        Notify("Theme", "Changed to " .. name)
    end)
end

CreateThemeBtn(_PageSettings, Color3.fromRGB(200, 0, 0), "Royal Red")
CreateThemeBtn(_PageSettings, Color3.fromRGB(0, 200, 100), "Neon Green")
CreateThemeBtn(_PageSettings, Color3.fromRGB(0, 150, 255), "Deep Blue")
CreateThemeBtn(_PageSettings, Color3.fromRGB(255, 0, 150), "Hot Pink")

-- // Toggle UI //
_Btn.MouseButton1Click:Connect(function()
    _Main.Visible = not _Main.Visible
    if _Main.Visible then
        _Main.Size = UDim2.new(0,0,0,0)
        _TS:Create(_Main, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 400, 0, 300)}):Play()
    end
end)

-- // Anti-AFK //
_LP.Idled:Connect(function()
    if getgenv().Config.AntiAFK then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end
end)

Notify("bukwaveHUB ULTIMATE", "V12 COMBAT READY!")
