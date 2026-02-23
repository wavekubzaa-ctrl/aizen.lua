--[[ 
    PROJECT: GLUE HUB (V8 - BOSS SELECTOR)
    GAME: Glue Piece
    FEATURES: Manual Boss Selection, Auto-Lock Target, Transparent UI
--]]

if not game:IsLoaded() then game.Loaded:Wait() end

local _LP = game.Players.LocalPlayer
local _RUN = game:GetService("RunService")

-- // ค้นหาโฟลเดอร์เก็บมอนสเตอร์ //
local function GetEnemyFolder()
    return workspace:FindFirstChild("Enemies") or workspace:FindFirstChild("NPCs") or workspace:FindFirstChild("Monsters")
end

getgenv().GlueConfig = {
    AutoFarm = false,
    LockedTargetName = nil, -- ชื่อบอสที่ล็อคไว้
    Distance = 7,
    InfGeppo = true
}

-- // UI (Glass Theme 50%) //
local _G = Instance.new("ScreenGui", game.CoreGui)
_G.Name = "GlueV8_Selector"

local _MainBtn = Instance.new("TextButton", _G)
_MainBtn.Size = UDim2.new(0, 65, 0, 65)
_MainBtn.Position = UDim2.new(0, 20, 0.4, 0)
_MainBtn.BackgroundColor3 = Color3.new(0,0,0)
_MainBtn.BackgroundTransparency = 0.5
_MainBtn.Text = "BOSS\nLOCK"
_MainBtn.TextColor3 = Color3.fromRGB(255, 170, 0)
_MainBtn.Draggable = true
Instance.new("UICorner", _MainBtn).CornerRadius = UDim.new(1,0)
Instance.new("UIStroke", _MainBtn).Color = Color3.fromRGB(255, 170, 0)

local _Panel = Instance.new("Frame", _MainBtn)
_Panel.Size = UDim2.new(0, 240, 0, 420)
_Panel.Position = UDim2.new(1, 10, 0, -150)
_Panel.BackgroundColor3 = Color3.new(0,0,0)
_Panel.BackgroundTransparency = 0.5
_Panel.Visible = false
Instance.new("UICorner", _Panel)

local function AddBtn(text, y, callback, parent, color)
    local b = Instance.new("TextButton", parent or _Panel)
    b.Size = UDim2.new(0.9, 0, 0, 30)
    b.Position = UDim2.new(0.05, 0, 0, y)
    b.BackgroundColor3 = color or Color3.new(1,1,1)
    b.BackgroundTransparency = 0.8
    b.Text = text; b.TextColor3 = Color3.new(1,1,1)
    b.Font = Enum.Font.GothamBold; b.TextSize = 10
    Instance.new("UICorner", b)
    b.MouseButton1Click:Connect(function() callback(b) end)
    return b
end

-- // ฟาร์มหลัก //
AddBtn("START AUTO FARM: OFF", 15, function(b)
    getgenv().GlueConfig.AutoFarm = not getgenv().GlueConfig.AutoFarm
    b.Text = getgenv().GlueConfig.AutoFarm and "AUTO FARM: ON" or "START AUTO FARM: OFF"
    b.BackgroundColor3 = getgenv().GlueConfig.AutoFarm and Color3.new(0, 0.5, 0) or Color3.new(1,1,1)
end)

-- แสดงเป้าหมายปัจจุบัน
local _CurrentTarget = Instance.new("TextLabel", _Panel)
_CurrentTarget.Size = UDim2.new(1, 0, 0, 25); _CurrentTarget.Position = UDim2.new(0, 0, 0, 50)
_CurrentTarget.Text = "TARGET: NONE"; _CurrentTarget.TextColor3 = Color3.fromRGB(255, 200, 0)
_CurrentTarget.BackgroundTransparency = 1; _CurrentTarget.Font = Enum.Font.GothamBold

AddBtn("CLEAR TARGET (FARM ALL)", 80, function()
    getgenv().GlueConfig.LockedTargetName = nil
    _CurrentTarget.Text = "TARGET: NONE (AUTO)"
end, _Panel, Color3.fromRGB(100, 0, 0))

-- Boss Selector List
local _ListTitle = Instance.new("TextLabel", _Panel)
_ListTitle.Size = UDim2.new(1, 0, 0, 20); _ListTitle.Position = UDim2.new(0, 0, 0, 115)
_ListTitle.Text = "-- SELECT BOSS TO LOCK --"; _ListTitle.TextColor3 = Color3.new(1,1,1)
_ListTitle.BackgroundTransparency = 1; _ListTitle.TextSize = 10

local _BossScroll = Instance.new("ScrollingFrame", _Panel)
_BossScroll.Size = UDim2.new(0.9, 0, 0, 150); _BossScroll.Position = UDim2.new(0.05, 0, 0, 140)
_BossScroll.BackgroundTransparency = 0.9; _BossScroll.CanvasSize = UDim2.new(0, 0, 5, 0)
_BossScroll.ScrollBarThickness = 2

-- Warp Section
local _WarpTitle = Instance.new("TextLabel", _Panel)
_WarpTitle.Size = UDim2.new(1, 0, 0, 20); _WarpTitle.Position = UDim2.new(0, 0, 0, 300)
_WarpTitle.Text = "-- QUICK WARP --"; _WarpTitle.TextColor3 = Color3.new(1,1,1)
_WarpTitle.BackgroundTransparency = 1; _WarpTitle.TextSize = 10

local _WarpScroll = Instance.new("ScrollingFrame", _Panel)
_WarpScroll.Size = UDim2.new(0.9, 0, 0, 50); _WarpScroll.Position = UDim2.new(0.05, 0, 0, 320)
_WarpScroll.BackgroundTransparency = 0.9; _WarpScroll.CanvasSize = UDim2.new(0, 0, 2, 0)

local Islands = { ["Starter"] = CFrame.new(-168, 12, 190), ["Jungle"] = CFrame.new(-1250, 20, -1120) }
local wy = 0
for name, cf in pairs(Islands) do
    AddBtn(name, wy, function() _LP.Character.HumanoidRootPart.CFrame = cf end, _WarpScroll)
    wy = wy + 35
end

AddBtn("CLOSE", 380, function() _Panel.Visible = false end)
_MainBtn.MouseButton1Click:Connect(function() _Panel.Visible = not _Panel.Visible end)

-- // ระบบอัปเดตลิสต์บอส (เลือกได้จริง) //
spawn(function()
    while wait(2) do
        for _, v in pairs(_BossScroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
        local folder = GetEnemyFolder()
        if folder then
            local by = 0
            -- ใช้ Dictionary เพื่อกรองชื่อซ้ำ
            local displayed = {}
            for _, v in pairs(folder:GetChildren()) do
                if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and not displayed[v.Name] then
                    -- กรองเฉพาะบอส (เลือด 5000+) หรือชื่อเฉพาะ
                    if v.Humanoid.MaxHealth >= 5000 then
                        displayed[v.Name] = true
                        AddBtn(v.Name, by, function()
                            getgenv().GlueConfig.LockedTargetName = v.Name
                            _CurrentTarget.Text = "LOCKED: " .. v.Name
                        end, _BossScroll)
                        by = by + 35
                    end
                end
            end
        end
    end
end)

-- Auto Weapon
local function UseTools()
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

-- // ฟาร์มลูป (ระบบล็อคเป้าเป๊ะๆ) //
_RUN.Heartbeat:Connect(function()
    if getgenv().GlueConfig.AutoFarm then
        pcall(function()
            local folder = GetEnemyFolder()
            local target = nil
            
            -- ถ้าล็อคชื่อไว้ ให้หาบอสชื่อนั้นที่เลือด > 0
            if getgenv().GlueConfig.LockedTargetName then
                for _, v in pairs(folder:GetChildren()) do
                    if v.Name == getgenv().GlueConfig.LockedTargetName and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        target = v
                        break
                    end
                end
            end
            
            -- ถ้าไม่ได้ล็อค หรือบอสที่ล็อคไม่เกิด ให้หาตัวที่ใกล้ที่สุด
            if not target then
                for _, v in pairs(folder:GetChildren()) do
                    if v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
                        target = v
                        break
                    end
                end
            end

            if target and _LP.Character:FindFirstChild("HumanoidRootPart") then
                _LP.Character.HumanoidRootPart.Velocity = Vector3.zero
                _LP.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, getgenv().GlueConfig.Distance, 0) * CFrame.Angles(math.rad(-90), 0, 0)
                UseTools()
            end
        end)
    end
end)
