-- Script UI - AI Keyboard Master
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3"))()

-- تصميم الواجهة: أسود شفاف مع حواف ريمبو
local Window = Library:CreateWindow("🏆 نظام تجميع الكؤوس - AI", Color3.fromRGB(0, 0, 0)) 
local Tab = Window:NewTab("⚙️ التحكم")
local Section = Tab:NewSection("أدوات التجميع التلقائي")

_G.Farming = false

-- زر التفعيل
Section:NewButton("بدء تجميع الكؤوس (تلقائي)", "سيبحث السكربت عن أي كأس ويذهب إليه", function()
    _G.Farming = not _G.Farming
    if _G.Farming then
        Library:Notify("نظام AI", "تم تفعيل التجميع - جاري المسح...", Color3.fromRGB(0, 255, 0))
        task.spawn(function()
            while _G.Farming do
                pcall(function()
                    local closest = nil
                    local minDistance = math.huge
                    
                    -- مسح شامل لكل الكائنات في الماب
                    for _, obj in pairs(game.Workspace:GetDescendants()) do
                        -- نبحث عن أي جزء (Part) ملموس في الماب
                        if obj:IsA("BasePart") then
                            local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - obj.Position).Magnitude
                            if mag < minDistance then
                                minDistance = mag
                                closest = obj
                            end
                        end
                    end
                    
                    -- التحرك للهدف
                    if closest then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = closest.CFrame
                    end
                end)
                task.wait(0.1) -- سرعة عالية جداً
            end
        end)
    else
        Library:Notify("نظام AI", "تم إيقاف التجميع", Color3.fromRGB(255, 0, 0))
    end
end)

-- ميزة إضافية أسطورية: إزالة الضباب أو تسريع اللاعب
Section:NewToggle("سرعة المشي (سريع جداً)", "يساعدك في التنقل بين الكؤوس", function(state)
    if state then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
    else
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end
end)
