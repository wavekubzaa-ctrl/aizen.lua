--[[ 
    bukwaveHUB PRO V14 - FARM SPECIALIST
    EDITION: Enchanted Style (No Aimlock)
    FIXED: Auto Farm Loop, Item Detection, Tab Logic
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

-- // Services //
local _TS = game:GetService("TweenService")
local _SG = game:GetService("StarterGui")
local _LP = game.Players.LocalPlayer
local _RUN = game:GetService("RunService")

-- // Configuration Storage //
getgenv().BWH_Config = {
    ThemeColor = Color3.fromRGB(255, 45, 45),
    AutoLift = false,
    AutoRebirth = false,
    AntiAFK = true,
    FarmSpeed = 0.01 -- ปรับความเร็วการยก (วินาที)
}

-- // UI Cleanup //
if game.CoreGui:FindFirstChild("BWH_FarmSpecialist") then game.CoreGui.BWH_FarmSpecialist:Destroy() end

-- // Core UI Creation //
local _G = Instance.new("ScreenGui", game.CoreGui)
_G.Name = "BWH_FarmSpecialist"

local _Main = Instance.new("Frame", _G)
_Main.Size = UDim2.new(0, 380, 0, 260)
_Main.Position = UDim2.new(0.5, -190, 0.4, -130)
_Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
_Main.BorderSizePixel = 0
_Main.Active = true
_Main.Draggable = true
Instance.new("UICorner", _Main).CornerRadius = UDim.new(0, 10)

-- // Stroke Glow //
local _Stroke = Instance.new("UIStroke", _Main)
_Stroke.Color = getgenv().BWH_Config.ThemeColor
_Stroke.Thickness = 1.5

-- // Sidebar //
local _Side = Instance.new("Frame", _Main)
_Side.Size = UDim2.new(0, 100, 1, 0)
_Side.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
_Side.BorderSizePixel = 0
Instance.new("UICorner", _Side).CornerRadius = UDim.new(0, 10)

local _Logo = Instance.new("TextLabel", _Side)
_Logo.Size = UDim2.new(1, 0, 0, 50)
_Logo.Text = "BUKWAVE"
_Logo.TextColor3 = getgenv().BWH_Config.ThemeColor
_Logo.Font = Enum.Font.GothamBold
_Logo.TextSize = 14
_Logo.BackgroundTransparency = 1

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

local _PageFarm = CreatePage("Farm")
local _PageSettings = CreatePage("Settings")
_PageFarm.Visible = true

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

AddTab("Farm", _PageFarm, 1)
AddTab("Settings", _PageSettings, 2)

-- // Components //
local function AddSwitch(parent, text, configKey, callback)
    local f = Instance.new("Frame", parent)
    f.Size = UDim2.new(1, 0, 0, 45)
    f.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
    
    local l = Instance.new("TextLabel", f)
    l.Text = "  " .. text; l.Size = UDim2.new(0.7, 0, 1, 0)
    l.BackgroundTransparency = 1; l.TextColor3 = Color3.new(1,1,1)
    l.Font = Enum.Font.Gotham; l.TextSize = 12; l.TextXAlignment = Enum.TextXAlignment.Left
    
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
    
    s.MouseButton1Click:Connect(function()
        getgenv().BWH_Config[configKey] = not getgenv().BWH_Config[configKey]
        local active = getgenv().BWH_Config[configKey]
        _TS:Create(d, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
        _TS:Create(s, TweenInfo.new(0.2), {BackgroundColor3 = active and getgenv().BWH_Config.ThemeColor or Color3.fromRGB(45, 45, 45)}):Play()
        callback(active)
    end)
end

-- // Auto Farm Logic (FIXED) //
AddSwitch(_PageFarm, "Auto Dumbbell (Fix)", "AutoLift", function(v)
    task.spawn(function()
        while getgenv().BWH_Config.AutoLift do
            pcall(function()
                local char = _LP.Character
                -- ตรวจสอบในตัวละครและกระเป๋า
                local tool = char:FindFirstChild("Dumbbell") or _LP.Backpack:FindFirstChild("Dumbbell")
                
                if tool then
                    -- ถ้าอยู่ในกระเป๋า ให้หยิบมาถือ
                    if tool.Parent == _LP.Backpack then
                        tool.Parent = char
                    end
                    -- สั่งยก
                    tool:Activate()
                else
                    -- ถ้าหาชื่อดัมเบลไม่เจอ จะพยายามหาไอเทมแรกในกระเป๋าแทน
                    local altTool = _LP.Backpack:FindFirstChildOfClass("Tool")
                    if altTool then
                        altTool.Parent = char
                        altTool:Activate()
                    end
                end
            end)
            task.wait(getgenv().BWH_Config.FarmSpeed)
        end
    end)
end)

AddSwitch(_PageFarm, "Auto Rebirth", "AutoRebirth", function(v)
    task.spawn(function()
        while getgenv().BWH_Config.AutoRebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(2.2)
        end
    end)
end)

AddSwitch(_PageSettings, "Anti-AFK", "AntiAFK", function(v) end)

-- // Floating Toggle //
local _Toggle = Instance.new("TextButton", _G)
_Toggle.Size = UDim2.new(0, 45, 0, 45)
_Toggle.Position = UDim2.new(0, 15, 0.5, 0)
_Toggle.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
_Toggle.Text = "B"
_Toggle.TextColor3 = Color3.new(1,1,1)
_Toggle.Font = Enum.Font.GothamBold
Instance.new("UICorner", _Toggle).CornerRadius = UDim.new(1, 0)
local _TStroke = Instance.new("UIStroke", _Toggle)
_TStroke.Color = getgenv().BWH_Config.ThemeColor
_TStroke.Thickness = 2

_Toggle.MouseButton1Click:Connect(function()
    _Main.Visible = not _Main.Visible
end)

-- // Anti-AFK Connection //
_LP.Idled:Connect(function()
    if getgenv().BWH_Config.AntiAFK then
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end
end)

_SG:SetCore("SendNotification", {Title = "BWH V14", Text = "Farm Fixed & Ready!", Duration = 5})
