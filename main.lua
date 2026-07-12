-- تحميل مكتبة Rayfield
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - نظام الأمان", Theme = "Default"})
local Tab = Window:CreateTab("⚙️ التجميع الآمن", nil)

_G.AutoFarm = false

-- تفعيل التجميع بالحركة الطبيعية (بدون Teleport لتجنب الباند)
Tab:CreateToggle({
   Name = "تفعيل التجميع (مشي طبيعي)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoFarm = Value
       if _G.AutoFarm then
           task.spawn(function()
               while _G.AutoFarm do
                   pcall(function()
                       local player = game.Players.LocalPlayer
                       local character = player.Character
                       local humanoid = character:FindFirstChild("Humanoid")
                       
                       -- البحث عن أقرب كأس
                       local closestCup = nil
                       local minDistance = math.huge
                       
                       for _, obj in pairs(game.Workspace:GetDescendants()) do
                           if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                               local distance = (character.HumanoidRootPart.Position - obj.Position).Magnitude
                               if distance < minDistance then
                                   minDistance = distance
                                   closestCup = obj
                               end
                           end
                       end
                       
                       -- التحرك نحو الكأس (مشي طبيعي)
                       if closestCup and humanoid then
                           humanoid:MoveTo(closestCup.Position)
                           task.wait(0.5) -- سرعة التحرك
                       end
                   end)
                   task.wait(0.1)
               end
           end)
       end
   end,
})

Tab:CreateButton({Name = "إيقاف التجميع", Callback = function() _G.AutoFarm = false end})

