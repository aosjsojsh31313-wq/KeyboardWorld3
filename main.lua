-- تحميل مكتبة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- نافذة التنبيه الأمني
Rayfield:Notify({Title = "⚠️ تحذير", Content = "استخدم السكربت على مسؤوليتك الشخصية!", Duration = 6})
task.wait(6)

-- إنشاء الواجهة
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - نسخة المحترفين", LoadingTitle = "جاري تحميل النظام...", LoadingSubtitle = "بواسطة: Ahmed Eid", Theme = "Default"})

-- التبويب الرئيسي
local Tab = Window:CreateTab("⚙️ التجميع التلقائي", nil)

-- القائمة المنسدلة لاختيار عدد الكؤوس (Target Win)
local Dropdown = Tab:CreateDropdown({
   Name = "اختر هدف التجميع",
   Options = {"100", "500", "1000", "5000", "10000"},
   CurrentOption = "500",
   Callback = function(Option)
      _G.TargetWin = tonumber(Option)
      Rayfield:Notify({Title = "تم التحديث", Content = "تم ضبط الهدف إلى: " .. Option, Duration = 3})
   end,
})

-- تفعيل التجميع التلقائي
local Toggle = Tab:CreateToggle({
   Name = "تفعيل التجميع التلقائي (Auto Farm)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoFarm = Value
       if _G.AutoFarm then
           task.spawn(function()
               while _G.AutoFarm do
                   -- كود البحث عن الكأس المختار والذهاب إليه
                   -- هنا يتم برمجة السكربت ليقرأ القيمة ويختار الكأس المناسب
                   task.wait(0.1)
               end
           end)
       end
   end,
})

-- تبويب الإضافات (ميزات أسطورية)
local ExtraTab = Window:CreateTab("🚀 ميزات إضافية", nil)

ExtraTab:CreateToggle({
   Name = "مانع الخمول (Anti-AFK)",
   CurrentValue = true,
   Callback = function(Value)
       if Value then
           local vu = game:GetService("VirtualUser")
           game:GetService("Players").LocalPlayer.Idled:connect(function()
               vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
               wait(1)
               vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
           end)
       end
   end,
})
