local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - احتراف", Theme = "Default"})
local Tab = Window:CreateTab("🤖 المساعد الذكي", nil)

_G.AutoFarm = false
_G.TargetName = nil

-- نظام مسح ذكي يقرأ البيانات من اللعبة مباشرة
local function ScanGameData()
    local items = {}
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        -- التأكد من أن العنصر هو كأس (يحتوي على TouchInterest) وليس Lava أو غيرها
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
            -- نأخذ الاسم الحقيقي الموجود داخل اللعبة
            items[obj.Name] = obj.Name 
        end
    end
    return items
end

-- حماية الموت المدمجة
local player = game.Players.LocalPlayer
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").HealthChanged:Connect(function(health)
        if health < 100 then char.Humanoid.Health = 1000 end
    end)
end)

-- القائمة المنسدلة التي تحتوي على البيانات المقروءة من اللعبة
Tab:CreateDropdown({
   Name = "اختر الكأس المراد تجميعه (بيانات حقيقية)",
   Options = ScanGameData(), -- سيتم ملء الخيارات تلقائياً من بيانات اللعبة
   Callback = function(Option) _G.TargetName = Option end,
})

Tab:CreateToggle({
    Name = "تفعيل المسار الدقيق (الكأس -> البداية)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        task.spawn(function()
            while _G.AutoFarm do
                local target = nil
                -- البحث عن الكأس الذي اخترته في البيانات
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj.Name == _G.TargetName then target = obj break end
                end
                
                if target then
                    local startPos = Vector3.new(0, 0, 0) -- موقع البداية
                    local TweenService = game:GetService("TweenService")
                    local char = game.Players.LocalPlayer.Character
                    
                    -- الذهاب للكأس المختار فقط
                    local tween1 = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = target.CFrame})
                    tween1:Play()
                    tween1.Completed:Wait()
                    
                    -- الرجوع للبداية
                    local tween2 = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(startPos)})
                    tween2:Play()
                    tween2.Completed:Wait()
                end
                task.wait(0.1)
            end
        end)
    end,
})
