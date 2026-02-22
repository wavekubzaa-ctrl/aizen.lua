--[[
    TITLE: BUKWAVE X AIZEN ULTIMATE
    FEATURES: Auto Farm, Auto Rebirth, UI Toggle (Draggable), Character Lock
    OPTIMIZED FOR: Arceus X Neo (Mobile)
--]]

-- // Clean up existing UI //
local oldGui = game.CoreGui:FindFirstChild("BukwaveAizenGui")
if oldGui then oldGui:Destroy() end

-- // Create UI //
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BukwaveAizenGui"
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- // Minimize/Menu Button (The red circle button) //
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = ScreenGui
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.Position = UDim2.new(0, 15, 0.15, 0)
CloseBtn.Size = UDim2.new(0, 45, 0, 45)
CloseBtn.Text = "MENU"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 10
CloseBtn.Active = true
CloseBtn.Draggable = true -- ปุ่มเมนูก็ลากย้ายได้นะ!

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- // Main Frame //
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -90, 0.4, -75)
MainFrame.Size = UDim2.new(0, 180, 0, 220)
MainFrame.Active = true
MainFrame.Draggable = true -- เมนูหลักลากย้ายและล็อกตำแหน่งเดิมไว้ได้
MainFrame.Visible = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

-- // Header //
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Parent = MainFrame
Header.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Header.Size = UDim2.new(1, 0, 0, 35)

local HeaderCorner = Instance.new("UICorner")
HeaderCorner.CornerRadius = UDim.new(0, 10)
HeaderCorner.Parent = Header

local Title = Instance.new("TextLabel")
Title.Parent = Header
Title.Size = UDim2.new(1, 0, 1, 0)
Title.Text = "BUKWAVE X AIZEN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold

-- // Toggle UI Logic //
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- // Helper for Modern Buttons //
local function createButton(name, pos, text)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Parent = MainFrame
    btn.Position = pos
    btn.Size = UDim2.new(0.85, 0, 0, 35)
    btn.Text = text
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 12
    btn.BorderSizePixel = 0
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    return btn
end

-- // Create Functionality Buttons //
local ToggleFarm = createButton("ToggleFarm", UDim2.new(0.075, 0, 0.22, 0), "AUTO LIFT: OFF")
local ToggleRebirth = createButton("ToggleRebirth", UDim2.new(0.075, 0, 0.42, 0), "REBIRTH: OFF")
local ToggleLock = createButton("ToggleLock", UDim2.new(0.075, 0, 0.62, 0), "CHARACTER LOCK: OFF")

local Footer = Instance.new("TextLabel")
Footer.Parent = MainFrame
Footer.Position = UDim2.new(0, 0, 0.88, 0)
Footer.Size = UDim2.new(1, 0, 0, 20)
Footer.Text = "B W X A • Safe Version"
Footer.TextColor3 = Color3.fromRGB(80, 80, 80)
Footer.BackgroundTransparency = 1
Footer.TextSize = 9

-- // Logic Variables //
getgenv().FarmActive = false
getgenv().RebirthActive = false
getgenv().CharLocked = false
local lockedCF = nil

-- // Auto Farm Logic //
ToggleFarm.MouseButton1Click:Connect(function()
    getgenv().FarmActive = not getgenv().FarmActive
    ToggleFarm.Text = getgenv().FarmActive and "AUTO LIFT: ON" or "AUTO LIFT: OFF"
    ToggleFarm.BackgroundColor3 = getgenv().FarmActive and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(30, 30, 30)
    
    task.spawn(function()
        while getgenv().FarmActive do
            local player = game.Players.LocalPlayer
            local char = player.Character
            if char then
                local tool = char:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
                if tool then
                    tool.Parent = char
                    tool:Activate()
                end
            end
            task.wait(0.01)
        end
    end)
end)

-- // Auto Rebirth Logic //
ToggleRebirth.MouseButton1Click:Connect(function()
    getgenv().RebirthActive = not getgenv().RebirthActive
    ToggleRebirth.Text = getgenv().RebirthActive and "REBIRTH: ON" or "REBIRTH: OFF"
    ToggleRebirth.BackgroundColor3 = getgenv().RebirthActive and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(30, 30, 30)
    
    task.spawn(function()
        while getgenv().RebirthActive do
            game:GetService("ReplicatedStorage").rEvents.rebirthRemote:InvokeServer("rebirthRequest")
            task.wait(1.5)
        end
    end)
end)

-- // Character Position Lock Logic //
ToggleLock.MouseButton1Click:Connect(function()
    getgenv().CharLocked = not getgenv().CharLocked
    ToggleLock.Text = getgenv().CharLocked and "CHAR LOCK: ON" or "CHAR LOCK: OFF"
    ToggleLock.BackgroundColor3 = getgenv().CharLocked and Color3.fromRGB(0, 120, 0) or Color3.fromRGB(30, 30, 30)
    
    local player = game.Players.LocalPlayer
    local char = player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    
    if getgenv().CharLocked and root then
        lockedCF = root.CFrame
        task.spawn(function()
            while getgenv().CharLocked do
                if root and lockedCF then
                    root.CFrame = lockedCF
                    root.Velocity = Vector3.new(0, 0, 0)
                    root.RotVelocity = Vector3.new(0, 0, 0)
                end
                task.wait()
            end
        end)
    else
        lockedCF = nil
    end
end)

-- Initial Notification
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "ULTIMATE LOADED",
    Text = "Menu and Character lock active.",
    Duration = 3
})
