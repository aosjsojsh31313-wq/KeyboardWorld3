-- مكتبة Fluent للواجهة الفخمة
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Player = game.Players.LocalPlayer

-- إنشاء الواجهة
local Window = Fluent:CreateWindow({Title = "AI Auto-Farmer Pro", SubTitle = "الوضع الخفي", TabWidth = 160, Size = UDim2.fromOffset(500, 300), Theme = "Dark"})
local Tab = Window:AddTab({ Title = "التحكم", Icon = "" })

-- متغيرات النظام
_G.AutoFarm = false
_G.CollectedCount = 0

-- حماية ضد الموت
local function MakeImmortal()
    local Hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if Hum then
        Hum:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
        Hum.Health = 1000
    end
end
MakeImmortal()
Player.CharacterAdded:Connect(MakeImmortal)

-- عداد الكؤوس
local Label = Tab:AddLabel("الكؤوس التي تم تجميعها: 0")

-- الذكاء الاصطناعي الخفي (يقرأ العالم تلقائياً)
Tab:AddToggle("AutoFarm", {Title = "تفعيل التفريم التلقائي (ذكي)", Callback = function(Value)
    _G.AutoFarm = Value
    if Value then
        task.spawn(function()
            while _G.AutoFarm do
                -- البحث عن أي كأس في العالم الحالي (سواء عالم 1 أو 2 أو 3)
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if _G.AutoFarm and obj:IsA("BasePart") and (string.find(obj.Name:lower(), "win") or string.find(obj.Name:lower(), "cup")) then
                        local Hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
                        if Hum then
                            -- المشي للمسار الصحيح
                            Hum:MoveTo(obj.Position)
                            Hum.MoveToFinished:Wait()
                            _G.CollectedCount = _G.CollectedCount + 1
                            Label:SetText("الكؤوس التي تم تجميعها: " .. _G.CollectedCount)
                            task.wait(0.5)
                        end
                    end
                end
                task.wait(1)
            end
        end)
    end
end})

Fluent:Notify({Title = "النظام يعمل", Content = "تم تحديد العالم تلقائياً والبدء بالتفريم", Duration = 3})
