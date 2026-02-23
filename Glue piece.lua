--[[ 
    PROJECT: GLUE HUB (V5 - INSTANT WARP)
    GAME: Glue Piece
    FEATURES: Instant Island Warp, Instant Boss Farm, Transparent UI, Multi-Weapon
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

local _LP = game.Players.LocalPlayer
local _RUN = game:GetService("RunService")

getgenv().GlueConfig = {
    AutoFarm = false,
    AutoWeapon = true,
    InfGeppo = true,
    TargetBoss = nil,
    Distance = 6,
    ThemeColor = Color3.fromRGB(0, 255, 100)
}

-- // พิกัดเกาะต่างๆ (พิกัดโดยประมาณ) //
local IslandLocations = {
    ["Starter Island"] = CFrame.new(-120, 10, 200),
    ["Orange Town"] = CFrame.new(1200, 10, -500),
    ["Jungle"] = CFrame.new(-1500, 10, -1200),
    ["Desert"] = CFrame.new(3000, 10, 2500),
    ["Snow Island"] = CFrame.new(-2500, 50, 3000),
    ["Marine Base"] = CFrame.new(4500, 20, -1500)
}

-- // UI Glass Theme 50% //
local _G = Instance.new("ScreenGui", game.CoreGui)
_G.Name = "GlueHub_V5"

local _MainBtn = Instance.new("TextButton", _G)
_MainBtn.Size = UDim2.new(0, 70, 0, 70)
_MainBtn.Position = UDim2.new(0, 20, 0.4, 0)
_MainBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
_MainBtn.BackgroundTransparency = 0.5
_MainBtn.Text = "WARP V5"
_MainBtn.TextColor3 = getgenv().GlueConfig.ThemeColor
_MainBtn.Font = Enum.Font.GothamBold
_MainBtn.TextSize = 10
_MainBtn.Draggable = true
Instance.new("UICorner", _MainBtn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", _MainBtn).Color = getgenv().GlueConfig.ThemeColor

local _Panel = Instance.new("Frame", _MainBtn)
_Panel.Size = UDim2.new(0, 260, 0, 450)
_Panel.Position = UDim2.new(1, 15, 0, -150)
_Panel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
_Panel.BackgroundTransparency = 0.5
_Panel.Visible = false
Instance.new("UICorner", _Panel)
Instance.new("UIStroke", _Panel).Color = getgenv().GlueConfig.ThemeColor

local function AddBtn(text, y, callback, parent)
    local b = Instance.new("TextButton", parent or _Panel)
    b.Size = UDim2.new(0.9, 0, 0, 28)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    b.BackgroundTransparency = 0.85
    b.Text = text; b.TextColor3 = Color3.new(1, 1, 1)
    b.Font = Enum.Font.GothamBold; b.TextSize = 11
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

-- // 1. Boss Monitor //
local _Monitor = Instance.new("ScrollingFrame", _Panel)
_Monitor.Size = UDim2.new(0.9, 0, 0, 100)
_Monitor.Position = UDim2.new(0.05, 0, 0, 35)
_Monitor.BackgroundTransparency = 0.9
_Monitor.BackgroundColor3 = Color3.new(0,0,0)
_Monitor.CanvasSize = UDim2.new(0, 0, 2, 0)
_Monitor.ScrollBarThickness = 1

-- // 2. Main Farm Controls //
AddBtn("INSTANT FARM: OFF", 150, function(b)
    getgenv().GlueConfig.AutoFarm = not getgenv().GlueConfig.AutoFarm
    b.Text = getgenv().GlueConfig.AutoFarm and "INSTANT FARM: ON" or "INSTANT FARM: OFF"
    b.TextColor3 = getgenv().GlueConfig.AutoFarm and Color3.new(0,1,0) or Color3.new(1,1,1)
end)

AddBtn("SELECT NEAREST BOSS", 185, function(b)
    local target = nil
    for _, v in pairs(workspace.Enemies:GetChildren()) do
        if v:FindFirstChild("Humanoid") and v.Humanoid.MaxHealth > 5000 and v.Humanoid.Health > 0 then
            target = v.Name; break
        end
    end
    getgenv().GlueConfig.TargetBoss = target
    b.Text = target and "TARGET: "..target or "NO BOSS FOUND"
end)

-- // 3. Instant Island Warp (Dropdown-style List) //
local _WarpScroll = Instance.new("ScrollingFrame", _Panel)
_WarpScroll.Size = UDim2.new(0.9, 0, 0, 120)
_WarpScroll.Position = UDim2.new(0.05, 0, 0, 225)
_WarpScroll.BackgroundTransparency = 0.9
_WarpScroll.CanvasSize = UDim2.new(0, 0, 3, 0)
_WarpScroll.ScrollBarThickness = 1

local warpY = 0
for islandName, cf in pairs(IslandLocations) do
    AddBtn("WARP: "..islandName, warpY, function()
        if _LP.Character and _LP.Character:FindFirstChild("HumanoidRootPart") then
            _LP.Character.HumanoidRootPart.CFrame = cf
        end
    end, _WarpScroll)
    warpY = warpY + 32
end

AddBtn("SAFE QUIT", 360, function() _LP:Kick("Instant Warp Exit") end, _Panel)
AddBtn("CLOSE", 400, function() _Panel.Visible = false end, _Panel)

_MainBtn.MouseButton1Click:Connect(function() _Panel.Visible = not _Panel.Visible end)

-- // Core Logic //

-- Monitor Update
spawn(function()
    while wait(1) do
        for _, v in pairs(_Monitor:GetChildren()) do if v:IsA("TextLabel") then v:Destroy() end end
        local offset = 0
        for _, boss in pairs(workspace.Enemies:GetChildren()) do
            if boss:FindFirstChild("Humanoid") and boss.Humanoid.MaxHealth > 5000 then
                local l = Instance.new("TextLabel", _Monitor)
                l.Size = UDim2.new(1, 0, 0, 18); l.Position = UDim2.new(0, 0, 0, offset)
                l.BackgroundTransparency = 1; l.Font = Enum.Font.Gotham; l.TextSize = 10
                local alive = boss.Humanoid.Health > 0
                l.Text = boss.Name .. " [" .. (alive and "ALIVE" or "DEAD") .. "]"
                l.TextColor3 = alive and Color3.new(0,1,0) or Color3.new(1,0,0)
                offset = offset + 18
            end
        end
    end
end)

-- Multi-Weapon Fast Attack
local function Attack()
    local bp = _LP:FindFirstChild("Backpack")
    local ch = _LP.Character
    if bp and ch then
        for _, t in pairs(bp:GetChildren()) do
            if t:IsA("Tool") then
                t.Parent = ch; t:Activate(); t.Parent = bp
            end
        end
    end
end

-- Infinite Geppo
_RUN.Stepped:Connect(function()
    if getgenv().GlueConfig.InfGeppo and _LP.Character and _LP.Character:FindFirstChild("Humanoid") then
        _LP.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

-- Instant Farm Loop
_RUN.Heartbeat:Connect(function()
    if getgenv().GlueConfig.AutoFarm then
        pcall(function()
            local target = nil
            if getgenv().GlueConfig.TargetBoss then
                target = workspace.Enemies:FindFirstChild(getgenv().GlueConfig.TargetBoss)
            end
            
            if not target or target.Humanoid.Health <= 0 then
                for _, v in pairs(workspace.Enemies:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        target = v; break
                    end
                end
            end

            if target and _LP.Character:FindFirstChild("HumanoidRootPart") then
                -- Instant Warp to Target (บนหัวศัตรู)
                _LP.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, getgenv().GlueConfig.Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                Attack()
            end
        end)
    end
end)
