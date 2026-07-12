-- إعدادات السرعة (يمكنك تعديل الرقم 300 لأي قيمة تريدها، بحد أقصى 300)
local _G_TweenSpeed = 300 

-- حماية الموت الأبدية (تشتغل تلقائياً فور تنفيذ السكربت)
local player = game.Players.LocalPlayer
local function enableGodMode()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.HealthChanged:Connect(function()
            player.Character.Humanoid.Health = 1000 
        end)
    end
end
enableGodMode()
player.CharacterAdded:Connect(enableGodMode)

-- نظام المسح والتحرك الذكي
task.spawn(function()
    while true do
        local found = false
        -- يقوم السكربت بمسح ملفات العالم الحالي بحثاً عن أي كائن اسمه يحتوي على "Win"
        for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") 
               and string.find(obj.Name:lower(), "win") then -- يقرأ أي شيء اسمه فيه كلمة Win
                
                local TweenService = game:GetService("TweenService")
                local char = player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local dist = (char.HumanoidRootPart.Position - obj.Position).Magnitude
                    -- الحركة تعتمد على السرعة التي حددتها في _G_TweenSpeed
                    local info = TweenInfo.new(dist / _G_TweenSpeed, Enum.EasingStyle.Linear)
                    local tween = TweenService:Create(char.HumanoidRootPart, info, {CFrame = obj.CFrame})
                    tween:Play()
                    tween.Completed:Wait()
                    found = true
                end
            end
        end
        if not found then task.wait(1) end
        task.wait(0.1)
    end
end)
