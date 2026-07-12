local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - احتراف", Theme = "Default"})
local Tab = Window:CreateTab("🤖 المساعد الذكي", nil)

_G.AutoFarm = false
_G.TargetCup = nil

-- 1. نظام الذكاء الاصطناعي لقراءة الكؤوس
local function GetAvailableCups()
    local cups = {}
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and string.find(obj.Name:lower(), "win") then
            cups[obj.Name] = obj.Name
        end
    end
    return cups
end

-- 2. حماية الموت الأبدية (God Mode)
local player = game.Players.LocalPlayer
player.CharacterAdded:Connect(function(char)
    char:WaitForChild("Humanoid").HealthChanged:Connect(function(health)
        if health < 100 then char.Humanoid.Health = 1000 end
    end)
end)

-- 3. الواجهة (GUI)
local Dropdown = Tab:CreateDropdown({
   Name = "اختر الكأس المراد تجميعه",
   Options = GetAvailableCups(),
   Callback = function(Option) _G.TargetCup = Option end,
})

Tab:CreateToggle({
    Name = "تفعيل المسار الدقيق (الكأس -> البداية)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        task.spawn(function()
            while _G.AutoFarm do
                if _G.TargetCup then
                    local target = nil
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
                        if obj.Name == _G.TargetCup then target = obj break end
                    end
                    
                    if target then
                        local TweenService = game:GetService("TweenService")
                        local char = player.Character
                        -- التحرك للكأس
                        local tween1 = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = target.CFrame})
                        tween1:Play()
                        tween1.Completed:Wait()
                        -- العودة للبداية
                        local tween2 = TweenService:Create(char.HumanoidRootPart, TweenInfo.new(1), {CFrame = CFrame.new(0, 5, 0)})
                        tween2:Play()
                        tween2.Completed:Wait()
                    end
                end
                task.wait(0.1)
            end
        end)
    end,
})

