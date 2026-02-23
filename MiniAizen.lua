--[[ 
    Muscle Farm PRO - V17
    ONLY FOR: Muscle Games (Slot 2 Dumbbell)
    FEATURES: Lag-Free Auto Farm, Auto Rebirth
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

local _TS = game:GetService("TweenService")
local _LP = game.Players.LocalPlayer
local _RUN = game:GetService("RunService")

getgenv().FarmConfig = {
    Enabled = false,
    Rebirth = false,
    Color = Color3.fromRGB(255, 45, 45)
}

local _G = Instance.new("ScreenGui", game.CoreGui)
local _Main = Instance.new("Frame", _G)
_Main.Size = UDim2.new(0, 200, 0, 150)
_Main.Position = UDim2.new(0.1, 0, 0.4, 0)
_Main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
_Main.Active = true
_Main.Draggable = true
Instance.new("UICorner", _Main)
Instance.new("UIStroke", _Main).Color = getgenv().FarmConfig.Color

local function AddButton(text, y, configKey, callback)
    local b = Instance.new("TextButton", _Main)
    b.Size = UDim2.new(0.85, 0, 0, 35)
    b.Position = UDim2.new(0.075, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.Text = text; b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold; b.TextSize = 12
    Instance.new("UICorner", b)

    b.MouseButton1Click:Connect(function()
        getgenv().FarmConfig[configKey] = not getgenv().FarmConfig[configKey]
        b.BackgroundColor3 = getgenv().FarmConfig[configKey] and getgenv().FarmConfig.Color or Color3.fromRGB(30, 30, 30)
        if callback then callback(getgenv().FarmConfig[configKey]) end
    end)
end

AddButton("AUTO FARM (SLOT 2)", 20, "Enabled", function(v)
    task.spawn(function()
        while getgenv().FarmConfig.Enabled do
            pcall(function()
                local tool = _LP.Character:FindFirstChild("Dumbbell") or _LP.Backpack:FindFirstChild("Dumbbell")
                if tool then
                    if tool.Parent ~= _LP.Character then tool.Parent = _LP.Character end
                    tool:Activate()
                end
            end)
            task.wait(0.05)
        end
    end)
end)

AddButton("AUTO REBIRTH", 65, "Rebirth", function(v)
    task.spawn(function()
        while getgenv().FarmConfig.Rebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(3)
        end
    end)
end)

local Close = Instance.new("TextButton", _Main)
Close.Size = UDim2.new(0.85, 0, 0, 25)
Close.Position = UDim2.new(0.075, 0, 0, 110)
Close.Text = "CLOSE UI"; Close.BackgroundColor3 = Color3.fromRGB(45,0,0)
Close.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", Close)
Close.MouseButton1Click:Connect(function() _G:Destroy() end)
