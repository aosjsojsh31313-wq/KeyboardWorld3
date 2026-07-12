-- تحميل مكتبة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - احترافي", Theme = "Default"})
local Tab = Window:CreateTab("⚙️ التجميع الآلي", nil)

_G.AutoFarm = false
_G.TweenSpeed = 150 -- السرعة الافتراضية

-- مُحدد سرعة التوجيه (Tween Speed) - كما في الفيديو
Tab:CreateSlider({
   Name = "سرعة التوجه (Tween Speed)",
   Range = {0, 230},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(Value)
      _G.TweenSpeed = Value
   end,
})

-- تفعيل التجميع التلقائي (Auto Farm Wins)
Tab:CreateToggle({
   Name = "تفعيل التجميع (Auto Farm)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoFarm = Value
       if _G.AutoFarm then
           task.spawn(function()
               while _G.AutoFarm do
                   pcall(function()
                       local player = game.Players.LocalPlayer
                       -- البحث عن أي "كأس" (Cup) في الماب
                       for _, obj in pairs(game.Workspace:GetDescendants()) do
                           if obj:IsA("BasePart") and obj.Name:find("Cup") then -- تعديل الاسم حسب الماب
                               -- تنفيذ الحركة (Tween) بالسرعة المحددة
                               local TweenService = game:GetService("TweenService")
                               local info = TweenInfo.new((player:DistanceFromCharacter(obj.Position) / _G.TweenSpeed), Enum.EasingStyle.Linear)
                               local tween = TweenService:Create(player.Character.HumanoidRootPart, info, {CFrame = obj.CFrame})
                               tween:Play()
                               tween.Completed:Wait()
                           end
                       end
                   end)
                   task.wait(0.1)
               end
           end)
       end
   end,
})
