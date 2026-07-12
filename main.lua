local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - نظام المسح الذكي", Theme = "Default"})
local Tab = Window:CreateTab("🤖 المساعد الذكي", nil)

_G.AutoFarm = false
_G.TargetObject = nil

-- نظام قراءة البيانات (يقرأ الكؤوس الموجودة فعلياً في اللعبة)
local function ScanForCups()
    local cups = {}
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            -- يتم التعرف على الكؤوس وترتيبها برمجياً
            table.insert(cups, obj.Name)
        end
    end
    return cups
end

-- حماية الموت الفورية
local player = game.Players.LocalPlayer
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").HealthChanged:Connect(function(health)
        if health < 100 then char.Humanoid.Health = 1000 end
    end)
end)

-- قائمة اختيار ذكية تعتمد على بيانات الماب الحالية
local CupDropdown = Tab:CreateDropdown({
   Name = "اختر الكأس المراد تجميعه",
   Options = ScanForCups(),
   Callback = function(Option) _G.TargetName = Option end,
})

Tab:CreateToggle({
    Name = "تفعيل المسار الدقيق (حركة الكأس ثم البداية)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        task.spawn(function()
            while _G.AutoFarm do
                local target = nil
                -- البحث عن الكأس المختار
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj.Name == _G.TargetName then target = obj break end
                end
                
                if target then
                    local startPos = Vector3.new(0, 0, 0) -- موقع البداية (يمكنك تعديله)
                    local TweenService = game:GetService("TweenService")
                    local char = game.Players.LocalPlayer.Character
                    
                    -- 1. الذهاب للكأس
                    local tween1 = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = target.CFrame})
                    tween1:Play()
                    tween1.Completed:Wait()
                    
                    -- 2. الرجوع للبداية
                    local tween2 = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(startPos)})
                    tween2:Play()
                    tween2.Completed:Wait()
                end
                task.wait(0.5)
            end
        end)
    end,
})
