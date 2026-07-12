local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - نسخة محترفة", Theme = "Default"})
local Tab = Window:CreateTab("⚙️ الإعدادات المتقدمة", nil)

_G.AutoFarm = false
_G.TweenSpeed = 150 
_G.AntiDeath = false

-- اختيار قيمة الكأس
local CupDropdown = Tab:CreateDropdown({
   Name = "اختر قيمة الكأس المستهدف",
   Options = {"1", "50", "150", "1000", "150k"},
   CurrentOption = "1",
   Callback = function(Option) _G.TargetCup = Option end,
})

-- التحكم في سرعة Tween
Tab:CreateSlider({
   Name = "سرعة التجميع (Tween Speed)",
   Range = {100, 1000},
   Increment = 50,
   CurrentValue = 150,
   Callback = function(Value) _G.TweenSpeed = Value end,
})

-- زر الحماية من الموت
Tab:CreateToggle({
   Name = "حماية من الموت (Anti-Death)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AntiDeath = Value
       if _G.AntiDeath then
           game.Players.LocalPlayer.Character.Humanoid.Health = 1000000 -- رفع الصحة
       end
   end,
})

-- تفعيل التجميع الآلي الذكي
Tab:CreateToggle({
   Name = "تفعيل التجميع الآلي",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoFarm = Value
       task.spawn(function()
           while _G.AutoFarm do
               for _, obj in pairs(game.Workspace:GetDescendants()) do
                   if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and string.find(obj.Name, _G.TargetCup or "") then
                       local TweenService = game:GetService("TweenService")
                       local info = TweenInfo.new((game.Players.LocalPlayer:DistanceFromCharacter(obj.Position) / _G.TweenSpeed), Enum.EasingStyle.Linear)
                       local tween = TweenService:Create(game.Players.LocalPlayer.Character.HumanoidRootPart, info, {CFrame = obj.CFrame})
                       tween:Play()
                       tween.Completed:Wait()
                   end
               end
               task.wait(0.5)
           end
       end)
   end,
})

