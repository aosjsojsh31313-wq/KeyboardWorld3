-- مكتبة الواجهة (Rayfield)
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local RunService = game:GetService("RunService")
local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")

-- إنشاء الواجهة الاحترافية
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - النمط الكامل", Theme = "Default"})
local Tab = Window:CreateTab("⚡ التحكم الذكي", nil)

-- نظام الحماية الأبدية (God Mode)
RunService.Heartbeat:Connect(function()
    local Char = Player.Character
    if Char and Char:FindFirstChild("Humanoid") and Char.Humanoid.Health < 100 then
        Char.Humanoid.Health = 1000
    end
end)

_G.AutoFarm = false

-- زر التفريم مع نظام التصحيح الذاتي (AI)
Tab:CreateToggle({
    Name = "تفعيل المسح والتجميع الذاتي (شامل لكل العوالم)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        task.spawn(function()
            while _G.AutoFarm do
                -- الـ pcall هو الذكاء الذي يمنع السكربت من الفشل ويصحح المسار فوراً
                local success, err = pcall(function()
                    -- يقرأ بيانات أي عالم تتواجد فيه حالياً
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
                        if _G.AutoFarm and obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and string.find(obj.Name:lower(), "win") then
                            local Root = Player.Character and Player.Character:FindFirstChild("HumanoidRootPart")
                            if Root then
                                local dist = (Root.Position - obj.Position).Magnitude
                                -- سرعة ثابتة عند 300 (الحد الأقصى المسموح)
                                local tween = TweenService:Create(Root, TweenInfo.new(dist / 300), {CFrame = obj.CFrame})
                                tween:Play()
                                tween.Completed:Wait()
                            end
                        end
                    end
                end)
                
                -- إذا واجهت اللعبة أي خطأ، الذكاء الاصطناعي يتجاهله ويكمل عمله
                if not success then task.wait(0.1) end
                task.wait(0.1)
            end
        end)
    end,
})
