--[[ 
    PROTECTED BY bukwaveHUB PRO v8.0 
    UPDATE: Fixed Dumbbell Detection & New Switch UI
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

local _0xTS = game:GetService("TweenService")
local _0xSG = game:GetService("StarterGui")
local _0xID = "bukwaveHUB PRO"

_0xSG:SetCore("SendNotification", {Title = _0xID, Text = "Initializing PRO Switches...", Duration = 2})

local _0xG = Instance.new("ScreenGui")
_0xG.Name = "BWH_PRO_V8"
_0xG.Parent = game.CoreGui

-- // Rounded Square Toggle Button //
local _0xTB = Instance.new("TextButton")
_0xTB.Parent = _0xG
_0xTB.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
_0xTB.Position = UDim2.new(0, 15, 0.2, 0)
_0xTB.Size = UDim2.new(0, 50, 0, 50) -- สี่เหลี่ยม
_0xTB.Text = "BH"
_0xTB.TextColor3 = Color3.fromRGB(255, 255, 255)
_0xTB.Font = Enum.Font.GothamBold
_0xTB.TextSize = 18
_0xTB.Draggable = true
_0xTB.Active = true
Instance.new("UICorner", _0xTB).CornerRadius = UDim.new(0, 12) -- มุมโค้ง
local _0xTBS = Instance.new("UIStroke", _0xTB)
_0xTBS.Thickness = 2
_0xTBS.Color = Color3.fromRGB(255, 255, 255)

-- // Main Frame //
local _0xM = Instance.new("Frame")
_0xM.Parent = _0xG
_0xM.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
_0xM.Position = UDim2.new(0.5, -100, 0.4, -135)
_0xM.Size = UDim2.new(0, 0, 0, 0)
_0xM.Visible = false
_0xM.ClipsDescendants = true
_0xM.Draggable = true
_0xM.Active = true
Instance.new("UICorner", _0xM).CornerRadius = UDim.new(0, 15)
local _0xMS = Instance.new("UIStroke", _0xM)
_0xMS.Thickness = 2
_0xMS.Color = Color3.fromRGB(200, 0, 0)

-- // Header //
local _0xH = Instance.new("Frame", _0xM)
_0xH.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
_0xH.Size = UDim2.new(1, 0, 0, 45)
Instance.new("UICorner", _0xH).CornerRadius = UDim.new(0, 15)
local _0xHT = Instance.new("TextLabel", _0xH)
_0xHT.Size = UDim2.new(1, 0, 1, 0); _0xHT.Text = _0xID; _0xHT.TextColor3 = Color3.fromRGB(255,255,255)
_0xHT.BackgroundTransparency = 1; _0xHT.Font = Enum.Font.GothamBold; _0xHT.TextSize = 14

-- // Toggle Logic //
local _0xSt = false
local function _0xTgl()
    if _0xSt then
        _0xTS:Create(_0xM, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)}):Play()
        task.wait(0.3); _0xM.Visible = false
    else
        _0xM.Visible = true
        _0xTS:Create(_0xM, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 210, 0, 280)}):Play()
    end
    _0xSt = not _0xSt
end
_0xTB.MouseButton1Click:Connect(_0xTgl)

-- // Switch UI Component //
local function _0xCreateSwitch(_0xPos, _0xLabel, _0xCallback)
    local _0xF = Instance.new("Frame", _0xM)
    _0xF.BackgroundTransparency = 1
    _0xF.Position = _0xPos
    _0xF.Size = UDim2.new(0.9, 0, 0, 40)
    
    local _0xL = Instance.new("TextLabel", _0xF)
    _0xL.Text = _0xLabel; _0xL.TextColor3 = Color3.fromRGB(200, 200, 200)
    _0xL.TextXAlignment = Enum.TextXAlignment.Left
    _0xL.Size = UDim2.new(0.6, 0, 1, 0); _0xL.BackgroundTransparency = 1
    _0xL.Font = Enum.Font.GothamMedium; _0xL.TextSize = 12

    local _0xSBox = Instance.new("TextButton", _0xF)
    _0xSBox.Text = ""
    _0xSBox.Size = UDim2.new(0, 45, 0, 22)
    _0xSBox.Position = UDim2.new(1, -45, 0.5, -11)
    _0xSBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Instance.new("UICorner", _0xSBox).CornerRadius = UDim.new(1, 0)
    
    local _0xDot = Instance.new("Frame", _0xSBox)
    _0xDot.Size = UDim2.new(0, 16, 0, 16)
    _0xDot.Position = UDim2.new(0, 3, 0.5, -8)
    _0xDot.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    Instance.new("UICorner", _0xDot).CornerRadius = UDim.new(1, 0)

    local _0xOn = false
    _0xSBox.MouseButton1Click:Connect(function()
        _0xOn = not _0xOn
        local _0xTargetPos = _0xOn and UDim2.new(1, -19, 0.5, -8) or UDim2.new(0, 3, 0.5, -8)
        local _0xTargetColor = _0xOn and Color3.fromRGB(200, 0, 0) or Color3.fromRGB(40, 40, 40)
        
        _0xTS:Create(_0xDot, TweenInfo.new(0.2), {Position = _0xTargetPos}):Play()
        _0xTS:Create(_0xSBox, TweenInfo.new(0.2), {BackgroundColor3 = _0xTargetColor}):Play()
        _0xCallback(_0xOn)
    end)
end

-- // Features //
_0xCreateSwitch(UDim2.new(0.05, 0, 0.22, 0), "Auto Lift (Dumbbell)", function(_0xOn)
    getgenv()._f = _0xOn
    if _0xOn then
        task.spawn(function()
            while getgenv()._f do
                pcall(function()
                    local _0xP = game.Players.LocalPlayer
                    local _0xCh = _0xP.Character
                    if _0xCh then
                        local _0xTool = _0xCh:FindFirstChild("Dumbbell") or _0xP.Backpack:FindFirstChild("Dumbbell")
                        if _0xTool then
                            if _0xTool.Parent ~= _0xCh then _0xTool.Parent = _0xCh end
                            _0xTool:Activate()
                        end
                    end
                end)
                task.wait(0.05 + math.random(1,3)/100)
            end
        end)
    end
end)

_0xCreateSwitch(UDim2.new(0.05, 0, 0.4, 0), "Auto Rebirth", function(_0xOn)
    getgenv()._r = _0xOn
    if _0xOn then
        task.spawn(function()
            while getgenv()._r do
                pcall(function() game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest") end)
                task.wait(2.5)
            end
        end)
    end
end)

_0xCreateSwitch(UDim2.new(0.05, 0, 0.58, 0), "Freeze Position", function(_0xOn)
    getgenv()._l = _0xOn
    local _0xR = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if _0xOn and _0xR then
        local _0xCF = _0xR.CFrame
        task.spawn(function()
            while getgenv()._l do
                if _0xR then _0xR.CFrame = _0xCF; _0xR.Velocity = Vector3.new(0,0,0) end
                task.wait()
            end
        end)
    end
end)

local _0xFT = Instance.new("TextLabel", _0xM)
_0xFT.Position = UDim2.new(0,0,0.92,0); _0xFT.Size = UDim2.new(1,0,0,20)
_0xFT.Text = "bukwaveHUB PRO Edition v8.0"; _0xFT.TextColor3 = Color3.fromRGB(80,80,80)
_0xFT.BackgroundTransparency = 1; _0xFT.TextSize = 8; _0xFT.Font = Enum.Font.Gotham

task.wait(1)
_0xSG:SetCore("SendNotification", {Title = _0xID, Text = "PRO Ready & Fixed!", Duration = 4})
_0xTgl()
