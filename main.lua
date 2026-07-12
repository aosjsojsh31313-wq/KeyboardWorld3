-- // نظام العقول الثلاثة - الواجهة الاحترافية //
local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- [1] إنشاء الواجهة (من الصفر بدون مكتبات)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Active = true
MainFrame.Draggable = true

-- حواف الريمبو
local Border = Instance.new("UIStroke", MainFrame)
Border.Thickness = 3
task.spawn(function()
    while true do
        for i = 0, 1, 0.01 do
            Border.Color = Color3.fromHSV(i, 1, 1)
            task.wait(0.05)
        end
    end
end)

-- شاشة الترحيب
local WelcomeLabel = Instance.new("TextLabel", ScreenGui)
WelcomeLabel.Size = UDim2.new(1, 0, 1, 0)
WelcomeLabel.Text = "مرحباً بكم في سكربت كيبورد الخالد"
WelcomeLabel.TextColor3 = Color3.new(1, 1, 1)
WelcomeLabel.BackgroundTransparency = 1
WelcomeLabel.TextSize = 40
task.wait(2)
WelcomeLabel:Destroy()

-- [2] العقول الثلاثة (منطق العمل)
local Brains = {
    Scanner = function() -- العقل الماسح
        local Targets = {}
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                if obj.Name:lower():find("win") or obj.Name:lower():find("cup") then
                    table.insert(Targets, obj)
                end
            end
        end
        return Targets
    end,
    Protector = function() -- عقل الحماية
        local Hum = Player.Character:FindFirstChild("Humanoid")
        if Hum then Hum.Health = 1000 end
    end,
    Executor = function(target) -- عقل التنفيذ
        Player.Character.Humanoid:MoveTo(target.Position)
    end
}

-- [3] الأزرار لكل عقل
local function CreateButton(name, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.8, 0, 0, 40)
    btn.Text = name
    btn.MouseButton1Click:Connect(callback)
end

CreateButton("تفعيل العقل الماسح", function() 
    print("العقل الماسح يعمل.. جاري قراءة الكؤوس") 
end)

CreateButton("تفعيل العقل المنفذ", function()
    task.spawn(function()
        while true do
            Brains.Protector()
            local targets = Brains.Scanner()
            for _, t in pairs(targets) do
                Brains.Executor(t)
                Player.Character.Humanoid.MoveToFinished:Wait()
            end
            task.wait(1)
        end
    end)
end)
