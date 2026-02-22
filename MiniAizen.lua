--[[
    TITLE: BUKWAVE X AIZEN (No-Lib Version)
    STABILITY: Ultra High (Works on all Mobile Executors)
    LANGUAGE: English Only
--]]

-- // Clean up existing UI //
local oldGui = game.CoreGui:FindFirstChild("BukwaveAizenGui")
if oldGui then oldGui:Destroy() end

-- // Create UI //
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local ToggleFarm = Instance.new("TextButton")
local ToggleRebirth = Instance.new("TextButton")
local Status = Instance.new("TextLabel")

ScreenGui.Name = "BukwaveAizenGui"
ScreenGui.Parent = game.CoreGui

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -75)
MainFrame.Size = UDim2.new(0, 200, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- Move it around your screen

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "BUKWAVE X AIZEN"
Title.TextColor3 = Color3.fromRGB(255, 0, 0)
Title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Title.TextSize = 14
Title.Font = Enum.Font.GothamBold

-- // Auto Farm Button //
ToggleFarm.Parent = MainFrame
ToggleFarm.Position = UDim2.new(0.1, 0, 0.25, 0)
ToggleFarm.Size = UDim2.new(0.8, 0, 0, 35)
ToggleFarm.Text = "Auto Farm: OFF"
ToggleFarm.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleFarm.TextColor3 = Color3.fromRGB(255, 255, 255)

-- // Auto Rebirth Button //
ToggleRebirth.Parent = MainFrame
ToggleRebirth.Position = UDim2.new(0.1, 0, 0.55, 0)
ToggleRebirth.Size = UDim2.new(0.8, 0, 0, 35)
ToggleRebirth.Text = "Auto Rebirth: OFF"
ToggleRebirth.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleRebirth.TextColor3 = Color3.fromRGB(255, 255, 255)

Status.Parent = MainFrame
Status.Position = UDim2.new(0, 0, 0.85, 0)
Status.Size = UDim2.new(1, 0, 0, 20)
Status.Text = "Status: Ready"
Status.TextColor3 = Color3.fromRGB(150, 150, 150)
Status.BackgroundTransparency = 1
Status.TextSize = 10

-- // Logic //
_G.AizenFarm = false
_G.AizenRebirth = false

ToggleFarm.MouseButton1Click:Connect(function()
    _G.AizenFarm = not _G.AizenFarm
    ToggleFarm.Text = _G.AizenFarm and "Auto Farm: ON" or "Auto Farm: OFF"
    ToggleFarm.BackgroundColor3 = _G.AizenFarm and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        while _G.AizenFarm do
            local p = game.Players.LocalPlayer
            local tool = p.Character and p.Character:FindFirstChildOfClass("Tool") or p.Backpack:FindFirstChildOfClass("Tool")
            if tool then
                tool.Parent = p.Character
                tool:Activate()
            end
            task.wait(0.01)
        end
    end)
end)

ToggleRebirth.MouseButton1Click:Connect(function()
    _G.AizenRebirth = not _G.AizenRebirth
    ToggleRebirth.Text = _G.AizenRebirth and "Auto Rebirth: ON" or "Auto Rebirth: OFF"
    ToggleRebirth.BackgroundColor3 = _G.AizenRebirth and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        while _G.AizenRebirth do
            game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(2)
        end
    end)
end)

print("BUKWAVE X AIZEN Loaded Successfully")
