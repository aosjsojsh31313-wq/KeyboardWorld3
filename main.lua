-- نظام Rayfield الاحترافي - نسخة التنبيه الأمني
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- نافذة التحذير (تظهر قبل كل شيء)
Rayfield:Notify({
   Title = "⚠️ تحذير هام",
   Content = "استخدام السكربت قد يعرض حسابك للخطر، استخدمه على مسؤوليتك الشخصية!",
   Duration = 6,
   Image = 4483362457,
})

-- انتظار 6 ثواني كما طلبت
task.wait(6)

-- الواجهة الرئيسية
local Window = Rayfield:CreateWindow({
   Name = "🏆 AI Keyboard Master - نظام المحترفين",
   LoadingTitle = "جاري تحميل البيانات...",
   LoadingSubtitle = "بواسطة: Ahmed Eid",
   Theme = "Default",
})

local Tab = Window:CreateTab("⚙️ التحكم", nil)

-- زر التجميع الذكي
Tab:CreateButton({
   Name = "بدء تجميع الكؤوس (ذكي)",
   Callback = function()
       _G.Farming = not _G.Farming
       if _G.Farming then
           Rayfield:Notify({Title = "نظام AI", Content = "تم تفعيل التجميع...", Duration = 3})
           task.spawn(function()
               while _G.Farming do
                   pcall(function()
                       local closest = nil
                       local minDistance = math.huge
                       for _, obj in pairs(game.Workspace:GetDescendants()) do
                           if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                               local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - obj.Position).Magnitude
                               if mag < 500 then
                                   if mag < minDistance then
                                       minDistance = mag
                                       closest = obj
                                   end
                               end
                           end
                       end
                       if closest then
                           game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = closest.CFrame
                       end
                   end)
                   task.wait(0.1)
               end
           end)
       end
   end,
})

-- زر الإغلاق
Tab:CreateButton({
   Name = "إغلاق السكربت (X)",
   Callback = function()
       Rayfield:Destroy()
   end,
})

