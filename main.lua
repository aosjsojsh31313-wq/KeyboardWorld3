local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - تحديث العوالم", Theme = "Default"})
local Tab = Window:CreateTab("⚙️ الإعدادات المتقدمة", nil)

_G.AutoFarm = false
_G.TweenSpeed = 300 -- تم تحديد الحد الأقصى للسرعة بـ 300 كما طلبت
_G.TargetCup = "1" -- القيمة الافتراضية

-- اختيار قيمة الكأس حسب الماب (يغطي العوالم 1-3)
Tab:CreateDropdown({
   Name = "اختر قيمة الكأس",
   Options = {"1", "50", "150", "1000", "150k"},
   CurrentOption = "1",
   Callback = function(Option) _G.TargetCup = Option end,
})

-- ضبط السرعة (لا تتجاوز 300)
Tab:CreateSlider({
   Name = "سرعة التجميع (الحد الأقصى 300)",
   Range = {50, 300},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(Value) _G.TweenSpeed = Value end,
})

-- حماية من الموت (بشكل فعلي)
Tab:CreateToggle({
   Name = "الحماية من الموت (Anti-Death)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AntiDeath = Value
       if _G.AntiDeath then
           -- تجميد الصحة لمنع الموت
           game.Players.LocalPlayer.Character.Humanoid.HealthChanged:Connect(function()
               if _G.AntiDeath then game.Players.LocalPlayer.Character.Humanoid.Health = 1000 end
           end)
       end
   end,
})

-- التجميع التلقائي الذكي للعوالم
Tab:CreateToggle({
   Name = "تفعيل التجميع الآلي",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoFarm = Value
       task.spawn(function()
           while _G.AutoFarm do
               -- السكربت الآن يبحث في كل Workspace للتعرف على أي كأس يظهر في أي عالم
               for _, v in pairs(game.Workspace:GetDescendants()) do
                   if _G.AutoFarm and v:IsA("BasePart") and v:FindFirstChild("TouchInterest") and string.find(v.Name, _G.TargetCup) then
                       local TweenService = game:GetService("TweenService")
                       local speed = _G.TweenSpeed
                       local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
                       local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(dist / speed), {CFrame = v.CFrame})
                       tween:Play()
                       tween.Completed:Wait()
                   end
               end
               task.wait(0.1)
           end
       end)
   end,
})

