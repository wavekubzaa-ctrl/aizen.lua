--[[ 
    bukwaveHUB PRO ULTIMATE V10
    BY: bukwaveHUB Team
    FEATURES: Multi-Tab UI, Theme Selector, Smart Farm, Anti-AFK
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

-- // Services //
local _TS = game:GetService("TweenService")
local _SG = game:GetService("StarterGui")
local _LP = game.Players.LocalPlayer
local _RUN = game:GetService("RunService")

-- // Global State //
getgenv().Config = {
    MainColor = Color3.fromRGB(200, 0, 0),
    AutoLift = false,
    AutoRebirth = false,
    FreezePos = false,
    AntiAFK = true,
    WalkSpeed = 16,
    JumpPower = 50
}

-- // UI Cleanup //
if game.CoreGui:FindFirstChild("BWH_ULTIMATE") then game.CoreGui.BWH_ULTIMATE:Destroy() end

-- // UI Creation //
local _G = Instance.new("ScreenGui", game.CoreGui)
_G.Name = "BWH_ULTIMATE"

-- // Notification System //
local function Notify(title, text)
    _SG:SetCore("SendNotification", {Title = title, Text = text, Duration = 3})
end

-- // Floating Toggle Button //
local _Btn = Instance.new("TextButton", _G)
_Btn.Size = UDim2.new(0, 50, 0, 50)
_Btn.Position = UDim2.new(0, 20, 0.4, 0)
_Btn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_Btn.Text = "BH"
_Btn.TextColor3 = Color3.new(1,1,1)
_Btn.Font = Enum.Font.GothamBold
_Btn.TextSize = 18
_Btn.Draggable = true
_Btn.Active = true
Instance.new("UICorner", _Btn).CornerRadius = UDim.new(0, 10)
local _BtnStroke = Instance.new("UIStroke", _Btn)
_BtnStroke.Color = getgenv().Config.MainColor
_BtnStroke.Thickness = 2

-- // Main Frame //
local _Main = Instance.new("Frame", _G)
_Main.Size = UDim2.new(0, 380, 0, 280)
_Main.Position = UDim2.new(0.5, -190, 0.4, -140)
_Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
_Main.Visible = false
_Main.ClipsDescendants = true
_Main.Draggable = true
_Main.Active = true
Instance.new("UICorner", _Main).CornerRadius = UDim.new(0, 12)
local _MainStroke = Instance.new("UIStroke", _Main)
_MainStroke.Color = getgenv().Config.MainColor
_MainStroke.Thickness = 1.5

-- // Sidebar (Tabs) //
local _Side = Instance.new("Frame", _Main)
_Side.Size = UDim2.new(0, 100, 1, 0)
_Side.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Instance.new("UICorner", _Side).CornerRadius = UDim.new(0, 12)

local _Title = Instance.new("TextLabel", _Side)
_Title.Size = UDim2.new(1, 0, 0, 50)
_Title.Text = "bukwave"
_Title.TextColor3 = getgenv().Config.MainColor
_Title.Font = Enum.Font.GothamBold
_Title.TextSize = 14
_Title.BackgroundTransparency = 1

-- // Tab Container //
local _Pages = Instance.new("Frame", _Main)
_Pages.Position = UDim2.new(0, 110, 0, 10)
_Pages.Size = UDim2.new(1, -120, 1, -20)
_Pages.BackgroundTransparency = 1

local function CreatePage(name)
    local p = Instance.new("ScrollingFrame", _Pages)
    p.Name = name
    p.Size = UDim2.new(1, 0, 1, 0)
    p.BackgroundTransparency = 1
    p.Visible = false
    p.ScrollBarThickness = 0
    local layout = Instance.new("UIListLayout", p)
    layout.Padding = UDim.new(0, 8)
    return p
end

local _PageMain = CreatePage("Main")
local _PageSettings = CreatePage("Settings")
_PageMain.Visible = true

-- // Tab Buttons //
local function AddTab(name, page)
    local btn = Instance.new("TextButton", _Side)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Position = UDim2.new(0.05, 0, 0, 55 + (38 * (_Side:GetChildren().Count or 0))) -- Simplified
    btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    btn.Text = name
    btn.TextColor3 = Color3.new(0.8, 0.8, 0.8)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    
    btn.MouseButton1Click:Connect(function()
        for _, v in pairs(_Pages:GetChildren()) do v.Visible = false end
        page.Visible = true
    end)
end

AddTab("Farm", _PageMain)
AddTab("Settings", _PageSettings)

-- // UI Components //
local function CreateSwitch(parent, text, callback)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 40)
    f.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    
    local l = Instance.new("TextLabel", f)
    l.Text = "  " .. text; l.Size = UDim2.new(0.7, 0, 1, 0)
    l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1)
    l.Font = Enum.Font.Gotham; l.TextSize = 12; l.TextXAlignment = Enum.TextXAlignment.Left
    
    local s = Instance.new("TextButton", f)
    s.Size = UDim2.new(0, 40, 0, 20)
    s.Position = UDim2.new(1, -50, 0.5, -10)
    s.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
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
        _TS:Create(s, TweenInfo.new(0.2), {BackgroundColor3 = active and getgenv().Config.MainColor or Color3.fromRGB(40, 40, 40)}):Play()
        callback(active)
    end)
end

local function CreateThemeBtn(parent, color, name)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, 0, 0, 35)
    b.BackgroundColor3 = color
    b.Text = name; b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    b.MouseButton1Click:Connect(function()
        getgenv().Config.MainColor = color
        _MainStroke.Color = color
        _BtnStroke.Color = color
        _Title.TextColor3 = color
        Notify("Theme Updated", "Color changed to " .. name)
    end)
end

-- // Main Functions //
CreateSwitch(_PageMain, "Auto Lift (Dumbbell)", function(v)
    getgenv().Config.AutoLift = v
    task.spawn(function()
        while getgenv().Config.AutoLift do
            pcall(function()
                local char = _LP.Character
                local tool = char:FindFirstChildOfClass("Tool") or _LP.Backpack:FindFirstChild("Dumbbell") or _LP.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    if tool.Parent ~= char then tool.Parent = char end
                    tool:Activate()
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
            task.wait(2.5)
        end
    end)
end)

CreateSwitch(_PageMain, "Anti-AFK System", function(v)
    getgenv().Config.AntiAFK = v
end)

-- // Theme Settings //
Instance.new("TextLabel", _PageSettings).Text = "Select Theme Color"; -- Add styling
CreateThemeBtn(_PageSettings, Color3.fromRGB(200, 0, 0), "Royal Red")
CreateThemeBtn(_PageSettings, Color3.fromRGB(0, 200, 100), "Neon Green")
CreateThemeBtn(_PageSettings, Color3.fromRGB(0, 150, 255), "Deep Blue")
CreateThemeBtn(_PageSettings, Color3.fromRGB(255, 0, 150), "Hot Pink")

-- // Toggle Animation //
_Btn.MouseButton1Click:Connect(function()
    _Main.Visible = not _Main.Visible
    if _Main.Visible then
        _Main.Size = UDim2.new(0, 0, 0, 0)
        _TS:Create(_Main, TweenInfo.new(0.4, Enum.EasingStyle.Back), {Size = UDim2.new(0, 380, 0, 280)}):Play()
    end
end)

-- // Anti-AFK Logic //
_LP.Idled:Connect(function()
    if getgenv().Config.AntiAFK then
        game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end
end)

Notify("bukwaveHUB PRO V10", "Ultimate Version Loaded!")
