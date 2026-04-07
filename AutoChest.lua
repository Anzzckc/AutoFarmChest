local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local VirtualUser = game:GetService("VirtualUser")

repeat task.wait() until game:IsLoaded()

local LocalPlayer = Players.LocalPlayer

if not LocalPlayer.Character then
    LocalPlayer.CharacterAdded:Wait()
end
LocalPlayer.Character:WaitForChild("HumanoidRootPart")

local Remote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_")
local args = {"SetTeam", "Marines"}
Remote:InvokeServer(unpack(args))

task.wait(1)

local Config = _G.ChestConfig or {}
local AutoHop = Config.AutoHop == true
local MaxSpeed = tonumber(Config.Speed) or 300

local TOGGLE_ICON_ID = 80404510751545
local HOP_URL = "https://raw.githubusercontent.com/Anzzckc/runhopmodule/refs/heads/main/run_hop.lua"

local target = pcall(function() return CoreGui:GetChildren() end) and CoreGui or LocalPlayer:WaitForChild("PlayerGui")

if target:FindFirstChild("Andzz") then
    target:FindFirstChild("Andzz"):Destroy()
end

local sg = Instance.new("ScreenGui", target)
sg.Name = "Andzz"
sg.IgnoreGuiInset = true

local function makeDraggable(clickObj, moveObj)
    local dragging, input, start, startPos
    clickObj.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            start = i.Position
            startPos = moveObj.Position
            i.Changed:Connect(function()
                if i.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    clickObj.InputChanged:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch then input = i end
    end)
    UIS.InputChanged:Connect(function(i)
        if i == input and dragging then
            local delta = i.Position - start
            moveObj.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

local ws = Instance.new("Frame", sg)
ws.Size = UDim2.new(1,0,1,0)
ws.BackgroundColor3 = Color3.new(1,1,1)
ws.Visible = false
ws.ZIndex = 1

local mf = Instance.new("Frame", sg)
mf.Size = UDim2.new(0,600,0,360)
mf.Position = UDim2.new(0.5,-300,0.5,-180)
mf.BackgroundColor3 = Color3.fromRGB(2,4,10)
mf.Visible = false
mf.ZIndex = 5
Instance.new("UICorner", mf).CornerRadius = UDim.new(0,10)
local st = Instance.new("UIStroke", mf)
st.Color = Color3.fromRGB(45,125,215)
st.Thickness = 1.5

local lbl_XAn = Instance.new("TextLabel", mf)
lbl_XAn.Text = ">  XAn  <"
lbl_XAn.TextColor3 = Color3.fromRGB(255, 255, 255)
lbl_XAn.TextSize = 55
lbl_XAn.Font = Enum.Font.GothamBold
lbl_XAn.Position = UDim2.new(0, 0, 0, 20)
lbl_XAn.Size = UDim2.new(1, 0, 0, 80)
lbl_XAn.BackgroundTransparency = 1
lbl_XAn.ZIndex = 20

local xanStroke = Instance.new("UIStroke", lbl_XAn)
xanStroke.Thickness = 4.5
xanStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual

local body = Instance.new("Frame", mf)
body.Size = UDim2.new(1, 0, 0, 250)
body.Position = UDim2.new(0, 0, 0.32, 0)
body.BackgroundTransparency = 1
body.ZIndex = 10

local layout = Instance.new("UIListLayout", body)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.VerticalAlignment = Enum.VerticalAlignment.Center
layout.Padding = UDim.new(0, 25)

local lbl_Title = Instance.new("TextLabel", body)
lbl_Title.Text = "AUTO FARM CHEST"
lbl_Title.TextColor3 = Color3.fromRGB(210, 220, 235)
lbl_Title.TextSize = 38
lbl_Title.Font = Enum.Font.GothamMedium
lbl_Title.BackgroundTransparency = 1
lbl_Title.Size = UDim2.new(1, 0, 0, 50)
lbl_Title.ZIndex = 15

local lbl_Beli = Instance.new("TextLabel", body)
lbl_Beli.Text = "Beli💰🤑: 0"
lbl_Beli.TextColor3 = Color3.fromRGB(190, 195, 205)
lbl_Beli.TextSize = 30
lbl_Beli.Font = Enum.Font.Code
lbl_Beli.BackgroundTransparency = 1
lbl_Beli.Size = UDim2.new(1, 0, 0, 40)
lbl_Beli.ZIndex = 15

local min = Instance.new("TextButton", mf)
min.Size = UDim2.new(0, 35, 0, 30)
min.Position = UDim2.new(1, -12, 0, -12)
min.BackgroundColor3 = Color3.fromRGB(8, 18, 40)
min.Text = "-"
min.TextColor3 = Color3.fromRGB(65, 155, 255)
min.TextSize = 28
min.Font = Enum.Font.GothamBold
min.ZIndex = 25
Instance.new("UICorner", min).CornerRadius = UDim.new(0, 6)
Instance.new("UIStroke", min).Color = Color3.fromRGB(45, 125, 215)

local tg = Instance.new("Frame", sg)
tg.Size = UDim2.new(0, 75, 0, 75)
tg.Position = UDim2.new(0, 20, 0.4, 0)
tg.BackgroundColor3 = Color3.fromRGB(5, 12, 30)
tg.ZIndex = 20
Instance.new("UICorner", tg).CornerRadius = UDim.new(1, 0)

local icon = Instance.new("ImageLabel", tg)
icon.Name = "Icon"
icon.BackgroundTransparency = 1
icon.Size = UDim2.new(0.92, 0, 0.92, 0)
icon.Position = UDim2.new(0.04, 0, 0.04, 0)
icon.Image = "rbxassetid://" .. TOGGLE_ICON_ID
icon.ZIndex = 21
Instance.new("UICorner", icon).CornerRadius = UDim.new(1, 0)

local btn = Instance.new("TextButton", tg)
btn.Size = UDim2.new(1,0,1,0)
btn.BackgroundTransparency = 1
btn.Text = ""
btn.ZIndex = 25

makeDraggable(btn, tg)
makeDraggable(mf, mf)

btn.MouseButton1Click:Connect(function()
    mf.Visible = true
    ws.Visible = true
    tg.Visible = false
    RunService:Set3dRenderingEnabled(false)
end)

min.MouseButton1Click:Connect(function()
    mf.Visible = false
    ws.Visible = false
    tg.Visible = true
    RunService:Set3dRenderingEnabled(true)
end)

local States = {
    {Text = Color3.fromRGB(255, 255, 255), Stroke = Color3.fromRGB(0, 0, 0)},
    {Text = Color3.fromRGB(255, 255, 0),   Stroke = Color3.fromRGB(0, 80, 255)},
    {Text = Color3.fromRGB(0, 255, 255),   Stroke = Color3.fromRGB(10, 10, 20)}
}

task.spawn(function()
    local i = 1
    while true do
        local nextState = States[i]
        local info = TweenInfo.new(3, Enum.EasingStyle.Linear)
        local tweenText = TweenService:Create(lbl_XAn, info, {TextColor3 = nextState.Text})
        local tweenStroke = TweenService:Create(xanStroke, info, {Color = nextState.Stroke})
        tweenText:Play()
        tweenStroke:Play()
        task.wait(4)
        i = i % #States + 1
    end
end)

local function formatNumber(num)
    if type(num) ~= "number" then return "0" end
    local isNegative = num < 0
    if isNegative then num = -num end
    local str = tostring(math.floor(num))
    if str == "0" then return "0" end
    local formatted = ""
    local count = 0
    for i = #str, 1, -1 do
        formatted = str:sub(i, i) .. formatted
        count = count + 1
        if count % 3 == 0 and i > 1 then
            formatted = "," .. formatted
        end
    end
    if isNegative then formatted = "-" .. formatted end
    return formatted
end

mf.Visible = true
ws.Visible = true
tg.Visible = false
RunService:Set3dRenderingEnabled(false)

local beli = 0

local function updateBeli()
    pcall(function()
        local dataFolder = LocalPlayer:FindFirstChild("Data")
        if dataFolder and dataFolder:FindFirstChild("Beli") then
            beli = dataFolder.Beli.Value
        end
    end)
end

updateBeli()
task.spawn(function()
    while true do
        updateBeli()
        lbl_Beli.Text = "Beli💰🤑: " .. formatNumber(beli)
        task.wait(1)
    end
end)

local function AntiAFK()
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

task.spawn(function()
    while task.wait(60) do
        AntiAFK()
    end
end)

local function getCharacter()
    if not LocalPlayer.Character then
        LocalPlayer.CharacterAdded:Wait()
    end
    LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    return LocalPlayer.Character
end

local function DistanceFromPlrSort(ObjectList)
    local RootPart = getCharacter().HumanoidRootPart
    table.sort(ObjectList, function(ChestA, ChestB)
        local RootPos = RootPart.Position
        local DistanceA = (RootPos - ChestA.Position).Magnitude
        local DistanceB = (RootPos - ChestB.Position).Magnitude
        return DistanceA < DistanceB
    end)
end

local UncheckedChests = {}
local FirstRun = true

local function getChestsSorted()
    if FirstRun then
        FirstRun = false
        for _, Object in pairs(game:GetDescendants()) do
            if Object.Name:find("Chest") and Object.ClassName == "Part" then
                table.insert(UncheckedChests, Object)
            end
        end
    end
    local Chests = {}
    for _, Chest in pairs(UncheckedChests) do
        if Chest:FindFirstChild("TouchInterest") then
            table.insert(Chests, Chest)
        end
    end
    DistanceFromPlrSort(Chests)
    return Chests
end

local function toggleNoclip(Toggle)
    for _, v in pairs(getCharacter():GetChildren()) do
        if v.ClassName == "Part" then
            v.CanCollide = not Toggle
        end
    end
end

local function Teleport(Goal, Speed)
    Speed = Speed or MaxSpeed
    toggleNoclip(true)
    local RootPart = getCharacter().HumanoidRootPart
    local Magnitude = (RootPart.Position - Goal.Position).Magnitude
    while not (Magnitude < 1) do
        local Direction = (Goal.Position - RootPart.Position).Unit
        RootPart.CFrame = RootPart.CFrame + Direction * (Speed * task.wait())
        Magnitude = (RootPart.Position - Goal.Position).Magnitude
    end
    local Humanoid = getCharacter().Humanoid
    Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    task.wait(0.1)
    toggleNoclip(false)
end

local function main()
    while task.wait() do
        local Chests = getChestsSorted()
        if #Chests > 0 then
            Teleport(Chests[1].CFrame)
        else
            task.wait(15)
            local Chests2 = getChestsSorted()
            if #Chests2 == 0 then
                if AutoHop then
                    pcall(function()
                        loadstring(game:HttpGet(HOP_URL))()
                    end)
                end
                return
            end
        end
    end
end

main()
