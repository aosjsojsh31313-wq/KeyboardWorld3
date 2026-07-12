if not game:IsLoaded() then game.Loaded:Wait() end

-- 1. بناء القائمة السوداء الملكية المزينة والموفرة للمساحة
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("TextButton")
local MinimizeButton = Instance.new("TextButton")
local IconFrame = Instance.new("ImageButton")

local FarmCupsButton = Instance.new("TextButton")
local InfoLabel = Instance.new("TextLabel")
local CupsCorner = Instance.new("UICorner")

ScreenGui.Parent = game.CoreGui

-- تصميم أيقونة الكيبورد الدائرية عند تصغير السكربت لتوفر المساحة
IconFrame.Name = "KeyboardMiniIcon"
IconFrame.Parent = ScreenGui
IconFrame.Size = UDim2.new(0, 55, 0, 55)
IconFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
IconFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
IconFrame.Image = "rbxassetid://14455552317"
IconFrame.Visible = false

local IconCorner = Instance.new("UICorner")
IconCorner.CornerRadius = UDim.new(1, 0)
IconCorner.Parent = IconFrame

local IconStroke = Instance.new("UIStroke")
IconStroke.Color = Color3.fromRGB(0, 255, 200)
IconStroke.Thickness = 2
IconStroke.Parent = IconFrame

-- تصميم القائمة السوداء الداكنة
MainFrame.Name = "UniversalAIPanel"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Size = UDim2.new(0, 320, 0, 180)
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true -- سحب اللوحة بسلاسة بالإصبع

UICorner.CornerRadius = UDim.new(0, 14)
UICorner.Parent = MainFrame

UIStroke.Color = Color3.fromRGB(30, 40, 60)
UIStroke.Thickness = 2
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 240, 0, 45)
Title.Text = "  🔄 جاري فحص هوية اللعبة الحالية برمجياً..."
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 12
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left

-- أزرار التحكم بالقائمة (X و -)
CloseButton.Parent = MainFrame
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(0, 285, 0, 8)
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 75, 75)
CloseButton.BackgroundTransparency = 1
CloseButton.TextSize = 16
CloseButton.Font = Enum.Font.GothamBold

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

MinimizeButton.Parent = MainFrame
MinimizeButton.Size = UDim2.new(0, 30, 0, 30)
MinimizeButton.Position = UDim2.new(0, 255, 0, 8)
MinimizeButton.Text = "─"
MinimizeButton.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeButton.BackgroundTransparency = 1
MinimizeButton.TextSize = 14
MinimizeButton.Font = Enum.Font.GothamBold

MinimizeButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    IconFrame.Visible = true
end)

IconFrame.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    IconFrame.Visible = false
end)

InfoLabel.Parent = MainFrame
InfoLabel.BackgroundTransparency = 1
InfoLabel.Position = UDim2.new(0, 15, 0, 50)
InfoLabel.Size = UDim2.new(0, 290, 0, 30)
InfoLabel.Text = "🔍 نظام الأمان يفحص ملفات السيرفر..."
InfoLabel.TextColor3 = Color3.fromRGB(241, 196, 15)
InfoLabel.TextSize = 11
InfoLabel.Font = Enum.Font.GothamBold

-- 2. محرك قراءة الألعاب التلقائي (Game Detection Engine)
local player = game.Players.LocalPlayer
local placeId = game.PlaceId
local isKeyboardMap = false

pcall(function()
    -- التحقق إذا كان معرف اللعبة يتطابق مع ماب الكيبورد المشهور
    if placeId == 109080788695843 or game.MarketplaceService:GetProductInfo(placeId).Name:lower():match("keyboard") then
        isKeyboardMap = true
        Title.Text = "  🧠 تم التعرف على: ماب الكيبورد الذكي"
        InfoLabel.Text = "🛡️ تم تفعيل درع الحماية الفورية والمشي التلقائي"
    else
        Title.Text = "  🧠 تم التعرف على لعبة عامة في روبلوكس"
        InfoLabel.Text = "📌 ميزه التجميع مخصصة حالياً لماب الكيبورد"
    end
end)

-- 3. نظام الحماية الشاملة ضد الموت والتسونامي
task.spawn(function()
    while true do
        pcall(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                for _, obj in pairs(game.Workspace:GetDescendants()) do
                    if obj:IsA("TouchTransmitter") then
                        local n = obj.Parent.Name:lower()
                        if n:match("tsunami") or n:match("monster") or n:match("lava") or n:match("kill") then
                            obj:Destroy()
                        end
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)

-- 4. زر التجميع الذكي المتكيف مع محاكي LuxyHub للأرض وبدون باند
FarmCupsButton.Parent = MainFrame
FarmCupsButton.Size = UDim2.new(0, 280, 0, 50)
FarmCupsButton.Position = UDim2.new(0, 20, 0, 100)
FarmCupsButton.Text = "بدء التجميع التلقائي الذكي 🚀"
FarmCupsButton.BackgroundColor3 = Color3.fromRGB(20, 45, 25)
FarmCupsButton.TextColor3 = Color3.fromRGB(200, 255, 200)
FarmCupsButton.TextSize = 13
FarmCupsButton.Font = Enum.Font.GothamBold

CupsCorner.CornerRadius = UDim.new(0, 8)
CupsCorner.Parent = FarmCupsButton

local CupsStroke = Instance.new("UIStroke")
CupsStroke.Color = Color3.fromRGB(40, 100, 50)
CupsStroke.Thickness = 1
CupsStroke.Parent = FarmCupsButton

_G.AutoCups = false
FarmCupsButton.MouseButton1Click:Connect(function()
    _G.AutoCups = not _G.AutoCups
    if _G.AutoCups then
        FarmCupsButton.Text = "جاري الحصد التلقائي على الأرض بأمان... ⚡"
        FarmCupsButton.BackgroundColor3 = Color3.fromRGB(45, 20, 20)
        FarmCupsButton.TextColor3 = Color3.fromRGB(255, 200, 200)
        CupsStroke.Color = Color3.fromRGB(100, 40, 40)
        
        task.spawn(function()
            while _G.AutoCups do
                pcall(function()
                    if isKeyboardMap and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        -- البحث الذكي عن بلوكة الفوز المتواجدة في عالمك الحالي وتحديث الأرقام تلقائياً
                        local winPad = game.Workspace:FindFirstChild("WinPart")
                            or game.Workspace:FindFirstChild("EndZone")
                            or game.Workspace:FindFirstChild("WinPad")
                            or (game.Workspace:FindFirstChild("Worlds") and game.Workspace.Worlds:FindFirstChild("EndZone"))
                        
                        if not winPad then
                            for _, v in pairs(game.Workspace:GetDescendants()) do
                                if v:IsA("Part") and (v.Name:lower():match("win") or v.Name:lower():match("end") or v.Name:lower():match("finish")) then
                                    winPad = v
                                    break
                                end
                            end
                        end
                        
                        if winPad then
                            -- رفع سرعة المشي التلقائي بشكل آمن لحسابك لتجميع ملايين الكؤوس والسرعة معاً على الأرض
                            player.Character.Humanoid.WalkSpeed = 45 -- السرعة القصوى الآمنة ضد كاشف الباند التلقائي
                            
                            -- محاكاة اللمس الفوري للبلوكة المتواجدة أمامك لتعطيك كؤوس عالمك الحالي كاملة
                            for i = 1, 30 do
                                firetouchinterest(player.Character.HumanoidRootPart, winPad, 0)
                                firetouchinterest(player.Character.HumanoidRootPart, winPad, 1)
                            end
                        end
                    end
                end)
                task.wait(0.02) -- وقت تأخير ذكي جداً لحماية الحساب من طرد السيرفر
            end
        end)
    else
        FarmCupsButton.Text = "بدء التجميع التلقائي الذكي 🚀"
        FarmCupsButton.BackgroundColor3 = Color3.fromRGB(20, 45, 25)
        FarmCupsButton.TextColor3 = Color3.fromRGB(200, 255, 200)
        CupsStroke.Color = Color3.fromRGB(40, 100, 50)
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = 16 -- إعادة السرعة للطبيعي عند الإيقاف
        end
    end
end)

