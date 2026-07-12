-- مكتبة الواجهة
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Window = Rayfield:CreateWindow({Name = "🏆 AI Keyboard Master - النمط الخالد", Theme = "Default"})
local Tab = Window:CreateTab("🛡️ الحماية والتحكم الذاتي", nil)

-- 1. الحماية المطلقة (تعطيل حالة الموت برمجياً)
local function MakeImmortal()
    local Player = game.Players.LocalPlayer
    if Player.Character then
        local Humanoid = Player.Character:FindFirstChild("Humanoid")
        if Humanoid then
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            Humanoid.Health = 1000
        end
    end
end
MakeImmortal()
game.Players.LocalPlayer.CharacterAdded:Connect(MakeImmortal)

-- 2. الذكاء الاصطناعي لقراءة بيانات العوالم
local TargetCup = nil
local Dropdown = Tab:CreateDropdown({
   Name = "اختر الكأس (يتم قراءة الملفات تلقائياً)",
   Options = {"جاري قراءة بيانات العالم..."},
   Callback = function(Option) TargetCup = Option end,
})

task.spawn(function()
    while true do
        local newOptions = {}
        -- يقرأ كل شيء في Workspace ويفهم أسماء الملفات التي تحتوي على win
        for _, obj in pairs(game.Workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj:FindFirstChild("TouchInterest") and string.find(obj.Name:lower(), "win") then
                table.insert(newOptions, obj.Name)
            end
        end
        Dropdown:Refresh(newOptions, true)
        task.wait(2)
    end
end)

-- 3. التفريم الذكي بالسرعة القصوى 300
Tab:CreateToggle({
    Name = "تفعيل التفريم الذاتي (لا يمكن أن تموت)",
    CurrentValue = false,
    Callback = function(Value)
        _G.AutoFarm = Value
        task.spawn(function()
            while _G.AutoFarm do
                if TargetCup then
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
                        if _G.AutoFarm and obj.Name == TargetCup and obj:IsA("BasePart") then
                            local Root = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                            if Root then
                                local dist = (Root.Position - obj.Position).Magnitude
                                local tween = game:GetService("TweenService"):Create(Root, TweenInfo.new(dist / 300), {CFrame = obj.CFrame})
                                tween:Play()
                                tween.Completed:Wait()
                            end
                        end
                    end
                end
                task.wait(0.1)
            end
        end)
    end,
})
