local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - احترافي", Theme = "Default"})
local Tab = Window:CreateTab("⚙️ التجميع التلقائي", nil)

_G.AutoFarm = false
_G.TweenSpeed = 150 -- السرعة هنا تتحكم في سرعة التجميع

Tab:CreateSlider({
   Name = "سرعة التجميع (Tween Speed)",
   Range = {100, 500},
   Increment = 10,
   CurrentValue = 150,
   Callback = function(Value) _G.TweenSpeed = Value end,
})

Tab:CreateToggle({
   Name = "تفعيل التجميع السريع (Auto Farm)",
   CurrentValue = false,
   Callback = function(Value)
       _G.AutoFarm = Value
       if _G.AutoFarm then
           task.spawn(function()
               while _G.AutoFarm do
                   local character = game.Players.LocalPlayer.Character
                   local root = character and character:FindFirstChild("HumanoidRootPart")
                   
                   if root then
                       for _, obj in pairs(game.Workspace:GetDescendants()) do
                           -- هذا الجزء يبحث عن الكؤوس (يتأكد أن الكائن له ميزة اللمس)
                           if _G.AutoFarm and obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") then
                               local distance = (root.Position - obj.Position).Magnitude
                               local speed = _G.TweenSpeed
                               local time = distance / speed
                               
                               local TweenService = game:GetService("TweenService")
                               local tween = TweenService:Create(root, TweenInfo.new(time, Enum.EasingStyle.Linear), {CFrame = obj.CFrame})
                               tween:Play()
                               tween.Completed:Wait()
                           end
                       end
                   end
                   task.wait(0.1)
               end
           end)
       end
   end,
})

