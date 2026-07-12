-- مكتبة Fluent الفخمة
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- إنشاء الواجهة
local Window = Fluent:CreateWindow({
    Title = "🏆 AI Master Pro - الخالد",
    SubTitle = "نظام القراءة والتحكم الفخم",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Theme = "Dark",
})

local Tab = Window:AddTab({ Title = "🛡️ التحكم الآمن", Icon = "" })

-- 1. الحماية المطلقة (خالد)
local function MakeImmortal()
    local Char = Player.Character
    if Char then
        local Hum = Char:FindFirstChild("Humanoid")
        if Hum then
            Hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            Hum:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            Hum.Health = 1000
            Hum.MaxHealth = 1000
        end
    end
end
MakeImmortal()
Player.CharacterAdded:Connect(MakeImmortal)

-- 2. الذكاء الاصطناعي لقراءة الملفات
_G.AutoFarm = false
_G.TargetCup = nil

local CupDropdown = Tab:AddDropdown("CupDropdown", {
    Title = "اختر الكأس (قراءة حية للملفات)",
    Values = {"جاري الفحص..."},
    Callback = function(Value) _G.TargetCup = Value end
})

task.spawn(function()
    while true do
        local newOptions = {}
        local descendants = game.Workspace:GetDescendants()
        for i = 1, #descendants do
            local obj = descendants[i]
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and string.find(obj.Name:lower(), "win") then
                table.insert(newOptions, obj.Name)
            end
        end
        CupDropdown:SetValues(newOptions)
        task.wait(2)
    end
end)

-- 3. تفعيل التفريم الآمن (مشياً)
Tab:AddToggle("AutoFarmToggle", {
    Title = "تفعيل التفريم الآمن (مستحيل الموت)",
    Callback = function(Value)
        _G.AutoFarm = Value
        if Value then
            task.spawn(function()
                while _G.AutoFarm do
                    if _G.TargetCup then
                        for _, obj in pairs(game.Workspace:GetDescendants()) do
                            if _G.AutoFarm and obj.Name == _G.TargetCup and obj:IsA("BasePart") then
                                local Hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
                                if Hum then
                                    Hum:MoveTo(obj.Position)
                                    Hum.MoveToFinished:Wait()
                                end
                            end
                        end
                    end
                    task.wait(0.1)
                end
            end)
        end
    end
})

Fluent:Notify({Title = "تم التفعيل", Content = "نظام AI الخالد جاهز الآن!", Duration = 5})
