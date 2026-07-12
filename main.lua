-- تعريف المكتبة والحماية
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- نافذة التحكم
local Window = Rayfield:CreateWindow({Name = "🏆 AI Master - نظام التصحيح الذاتي", Theme = "Default"})
local Tab = Window:CreateTab("⚙️ التحكم", nil)

-- الحماية من الموت (مدمجة)
RunService.Heartbeat:Connect(function()
    local Char = Player.Character
    if Char and Char:FindFirstChild("Humanoid") and Char.Humanoid.Health < 100 then
        Char.Humanoid.Health = 1000
    end
end)

_G.AutoFarm = false

-- الذكاء الاصطناعي للتصحيح الذاتي والتفريم
Tab:CreateToggle({
    Name = "تفعيل التجميع الذاتي (مع تصحيح الأخطاء)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        task.spawn(function()
            while _G.AutoFarm do
                -- نظام التصحيح الذاتي: يقوم بمحاولة التنفيذ داخل pcall لتجنب توقف السكربت
                local success, err = pcall(function()
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
                        if _G.AutoFarm and obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and string.find(obj.Name:lower(), "win") then
                            local Root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                            if Root then
                                local dist = (Root.Position - obj.Position).Magnitude
                                local tween = TweenService:Create(Root, TweenInfo.new(dist / 300), {CFrame = obj.CFrame})
                                tween:Play()
                                tween.Completed:Wait()
                            end
                        end
                    end
                end)
                
                -- إذا حدث خطأ، "الذكاء الاصطناعي" يصححه فوراً
                if not success then
                    warn("خطأ تم تصحيحه بواسطة AI: " .. tostring(err))
                    task.wait(1)
                end
                task.wait(0.1)
            end
        end)
    end,
})

