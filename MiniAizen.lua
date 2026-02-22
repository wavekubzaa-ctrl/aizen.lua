--[[ 
    PROTECTED BY bukwaveHUB PRO v1.0 
    UNAUTHORIZED COPYING IS PROHIBITED
    ENCRYPTED FOR SECURITY
--]]

local _0xS = game:GetService("StarterGui")
local _0xT = game:GetService("TweenService")
local _0xN = "bukwaveHUB PRO"

_0xS:SetCore("SendNotification", {Title = _0xN, Text = "Authenticating PRO version...", Duration = 2})

local _0xG = Instance.new("ScreenGui")
_0xG.Name = "BWH_PRO_" .. math.random(1000,9999)
_0xG.Parent = game.CoreGui

local _0xMB = Instance.new("TextButton")
_0xMB.Parent = _0xG
_0xMB.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
_0xMB.Position = UDim2.new(0, 15, 0.2, 0)
_0xMB.Size = UDim2.new(0, 55, 0, 55)
_0xMB.Text = "PRO"
_0xMB.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xMB.Font = Enum.Font.GothamBold
_0xMB.TextSize = 12
_0xMB.Draggable = true
Instance.new("UICorner", _0xMB).CornerRadius = UDim.new(1, 0)
local _0xBS = Instance.new("UIStroke", _0xMB)
_0xBS.Thickness = 2
_0xBS.Color = Color3.fromRGB(255, 255, 255)
_0xBS.Transparency = 0.5

local _0xM = Instance.new("Frame")
_0xM.Parent = _0xG
_0xM.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
_0xM.Position = UDim2.new(0.5, -100, 0.4, -135)
_0xM.Size = UDim2.new(0, 0, 0, 0)
_0xM.Visible = false
_0xM.ClipsDescendants = true
Instance.new("UICorner", _0xM).CornerRadius = UDim.new(0, 15)
local _0xMS = Instance.new("UIStroke", _0xM)
_0xMS.Thickness = 2
_0xMS.Color = Color3.fromRGB(180, 0, 0)

local _0xH = Instance.new("Frame")
_0xH.Parent = _0xM
_0xH.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
_0xH.Size = UDim2.new(1, 0, 0, 45)
Instance.new("UICorner", _0xH).CornerRadius = UDim.new(0, 15)

local _0xHT = Instance.new("TextLabel")
_0xHT.Parent = _0xH
_0xHT.Size = UDim2.new(1, 0, 1, 0)
_0xHT.Text = _0xN
_0xHT.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xHT.BackgroundTransparency = 1
_0xHT.Font = Enum.Font.GothamBold
_0xHT.TextSize = 14

local _0xSt = false
local function _0xTgl()
    if _0xSt then
        _0xT:Create(_0xM, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3) _0xM.Visible = false
    else
        _0xM.Visible = true
        _0xT:Create(_0xM, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 200, 0, 275)}):Play()
    end
    _0xSt = not _0xSt
end
_0xMB.MouseButton1Click:Connect(_0xTgl)

local function _0xCB(_0xP, _0xTX)
    local _0xB = Instance.new("TextButton")
    _0xB.Parent = _0xM
    _0xB.Position = _0xP
    _0xB.Size = UDim2.new(0.85, 0, 0, 42)
    _0xB.Text = _0xTX
    _0xB.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    _0xB.TextColor3 = Color3.fromRGB(220, 220, 220)
    _0xB.Font = Enum.Font.GothamMedium
    _0xB.TextSize = 11
    Instance.new("UICorner", _0xB).CornerRadius = UDim.new(0, 10)
    Instance.new("UIStroke", _0xB).Color = Color3.fromRGB(60,60,60)
    return _0xB
end

local _0xB1 = _0xCB(UDim2.new(0.075, 0, 0.22, 0), "AUTO LIFT: OFF")
local _0xB2 = _0xCB(UDim2.new(0.075, 0, 0.43, 0), "REBIRTH: OFF")
local _0xB3 = _0xCB(UDim2.new(0.075, 0, 0.64, 0), "ANCHOR: OFF")

getgenv()._f = false; getgenv()._r = false; getgenv()._l = false; local _0xCF = nil

_0xB1.MouseButton1Click:Connect(function()
    getgenv()._f = not getgenv()._f
    _0xB1.Text = getgenv()._f and "AUTO LIFT: ON" or "AUTO LIFT: OFF"
    _0xB1.BackgroundColor3 = getgenv()._f and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(25, 25, 25)
    task.spawn(function()
        while getgenv()._f do
            pcall(function()
                local _0xPl = game.Players.LocalPlayer
                local _0xCh = _0xPl.Character
                if _0xCh then
                    local _0xTl = _0xCh:FindFirstChild("Dumbbell") or _0xPl.Backpack:FindFirstChild("Dumbbell") or _0xCh:FindFirstChildOfClass("Tool")
                    if _0xTl then _0xTl.Parent = _0xCh; _0xTl:Activate() end
                end
            end)
            task.wait(0.05 + math.random(1,5)/100)
        end
    end)
end)

_0xB2.MouseButton1Click:Connect(function()
    getgenv()._r = not getgenv()._r
    _0xB2.Text = getgenv()._r and "REBIRTH: ON" or "REBIRTH: OFF"
    _0xB2.BackgroundColor3 = getgenv()._r and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(25, 25, 25)
    task.spawn(function()
        while getgenv()._r do
            pcall(function() game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest") end)
            task.wait(2.2)
        end
    end)
end)

_0xB3.MouseButton1Click:Connect(function()
    getgenv()._l = not getgenv()._l
    _0xB3.Text = getgenv()._l and "ANCHOR: ON" or "ANCHOR: OFF"
    _0xB3.BackgroundColor3 = getgenv()._l and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(25, 25, 25)
    local _0xR = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if getgenv()._l and _0xR then
        _0xCF = _0xR.CFrame
        task.spawn(function()
            while getgenv()._l do
                if _0xR and _0xCF then _0xR.CFrame = _0xCF; _0xR.Velocity = Vector3.new(0,0,0) end
                task.wait()
            end
        end)
    else _0xCF = nil end
end)

local _0xFT = Instance.new("TextLabel", _0xM)
_0xFT.Position = UDim2.new(0,0,0.9,0); _0xFT.Size = UDim2.new(1,0,0,20)
_0xFT.Text = "bukwaveHUB PRO Edition"; _0xFT.TextColor3 = Color3.fromRGB(80,80,80)
_0xFT.BackgroundTransparency = 1; _0xFT.TextSize = 8; _0xFT.Font = Enum.Font.Gotham

task.wait(1)
_0xS:SetCore("SendNotification", {Title = _0xN, Text = "PRO Version Loaded!", Icon = "rbxassetid://6034503041", Duration = 5})
_0xTgl()
