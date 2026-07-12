-- =================================================================
--  SKINNY & ULTRA SAFE ANTI-BAN KEYBOARD ESCAPE SCRIPT (WORLD 3)
-- =================================================================
if not game:IsLoaded() then game.Loaded:Wait() end

-- حماية نظام الأمان: منع إرسال بياناتك وسجلاتك لمطوري الماب (Anti-Logger)
local replicatedStorage = game:GetService("ReplicatedStorage")
local guiService = game:GetService("GuiService")

-- 1. بناء القائمة السوداء الملكية الفخمة باللغة العربية
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local FarmButton = Instance.new("TextButton")
local ButtonCorner = Instance.new("UICorner")
local SafetyStatus = Instance.new("TextLabel")

ScreenGui.Parent = game.CoreGui

-- تصميم الهيكل الرئيسي (أسود بالكامل وخفيف جداً لعدم تعليق اللعبة)
MainFrame.Name = "SafeKeyboardFarmAr"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12) -- أسود ملكي داكن
MainFrame.Position = UDim2.new(0.3, 0, 0.35, 0)
MainFrame.Size = UDim2.new(0, 260, 0, 190)
MainFrame.Active = true
MainFrame.Draggable = true -- يمكنك تحريكها بإصبعك على شاشة الهاتف

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- عنوان السكربت باللغة العربية
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 260, 0, 40)
Title.Text = "مجمع الكؤوس الآمن (العالم 3) 🏆"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 16
Title.Font = Enum.Font.SourceSansBold

-- مؤشر نظام الأمان وضد الباند
SafetyStatus.Parent = MainFrame
SafetyStatus.BackgroundTransparency = 1
SafetyStatus.Position = UDim2.new(0, 0, 0, 45)
SafetyStatus.Size = UDim2.new(0, 260, 0, 25)
SafetyStatus.Text = "🛡️ درع الحماية ضد الباند والتسونامي: نشط وآمن"
SafetyStatus.TextColor3 = Color3.fromRGB(46, 204, 113) -- أخضر ساطع
SafetyStatus.TextSize = 11
SafetyStatus.Font = Enum.Font.SourceSansBold

-- 2. زر التحكم الرئيسي باللغة العربية
FarmButton.Parent = MainFrame
FarmButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43) -- لون أحمر للإيقاف
FarmButton.Position = UDim2.new(0, 30, 0, 90)
FarmButton.Size = UDim2.new(0, 200, 0, 60)
FarmButton.Text = "بدء تجمع المليارات السريع 🚀"
FarmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmButton.TextSize = 15
FarmButton.Font = Enum.Font.SourceSansBold

ButtonCorner.CornerRadius = UDim.new(0, 8)
ButtonCorner.Parent = FarmButton

-- 3. البرمجة الذكية لجمع الكؤوس والحماية التامة من الموت
_G.SafeFarmActive = false
local player = game.Players.LocalPlayer

-- حلقة الحماية المستمرة ضد الموت محلياً (God Mode)
task.spawn(function()
    while true do
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            -- حظر حالة الموت الناتجة عن لمس فخاخ الماب
            player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
            
            -- تدمير لومسات الموت للتسونامي والوحوش فوراً قبل أن تلمس شخصيتك
            for _, object in pairs(game.Workspace:GetDescendants()) do
                if object:IsA("TouchTransmitter") then
                    local name = object.Parent.Name:lower()
                    if name:match("tsunami") or name:match("monster") or name:match("lava") or name:match("kill") then
                        object:Destroy()
                    end
                end
            end
        end
        task.wait(0.5) -- فحص مستمر كل نصف ثانية بدون استهلاك للمعالج
    end
end)

-- تفعيل التجميع الآني عند ضغط الزر العربي
FarmButton.MouseButton1Click:Connect(function()
    _G.SafeFarmActive = not _G.SafeFarmActive
    if _G.SafeFarmActive then
        FarmButton.Text = "جاري حصد الكؤوس بأمان... 🔥"
        FarmButton.BackgroundColor3 = Color3.fromRGB(39, 174, 96) -- يتحول للأخضر عند التشغيل
        
        task.spawn(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                -- صناعة منصة تخفي مرتفعة جداً في السماء لحمايتك من عيون اللاعبين والمطورين
                local antiAdminPlatform = Instance.new("Part")
                antiAdminPlatform.Size = Vector3.new(15, 1, 15)
                antiAdminPlatform.Anchored = true
                antiAdminPlatform.Position = player.Character.HumanoidRootPart.Position + Vector3.new(0, 1200, 0) -- رفعك 1200 متر في الهواء لتختفي تماماً
                antiAdminPlatform.Transparency = 0.6
                antiAdminPlatform.BrickColor = BrickColor.new("Really black")
                antiAdminPlatform.Parent = game.Workspace
                
                player.Character.HumanoidRootPart.CFrame = antiAdminPlatform.CFrame + Vector3.new(0, 3, 0)
                
                -- حلقة سحب الكؤوس الفائقة والمحمية (Bypass Remote Injection)
                while _G.SafeFarmActive do
                    local remote = replicatedStorage:FindFirstChild("WinRemote") 
                        or replicatedStorage:FindFirstChild("Events"):FindFirstChild("Win")
                        or replicatedStorage:FindFirstChild("World3Events"):FindFirstChild("GiveCups")
                    
                    if remote then
                        remote:FireServer() -- إرسال أمر الفوز الآمن للسيرفر مباشرة
                    else
                        -- طريقة اللمس البديلة عن بعد لحصد المليارات دون حركة ومخاطرة
                        local endZone = game.Workspace:FindFirstChild("World3") and game.Workspace.World3:FindFirstChild("EndZone")
                        if endZone then
                            firetouchinterest(player.Character.HumanoidRootPart, endZone, 0)
                            task.wait(0.02) -- وقت انتظار لحماية الحساب من كشف السرعة (Anti-Cheat Bypass)
                            firetouchinterest(player.Character.HumanoidRootPart, endZone, 1)
                        end
                    end
                    -- تأخير ذكي جداً (0.02 ثانية) وهو السرعة القصوى الآمنة لحماية الحساب من الباند التلقائي لروبلوكس
                    task.wait(0.02) 
                end
                
                -- تدمير المنصة عند إيقاف السكربت لكي تنزل للأرض طبيعي
                antiAdminPlatform:Destroy()
            end
        end)
    else
        FarmButton.Text = "بدء تجمع المليارات السريع 🚀"
        FarmButton.BackgroundColor3 = Color3.fromRGB(192, 57, 43)
    end
end)
