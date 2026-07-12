-- // المحرك الشامل - كيبورد الخالد (الإصدار النهائي المدمج) //
local Player = game.Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- [1] الزر الدائري (الريمبو)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.Size = UDim2.new(0, 60, 0, 60); ToggleBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
ToggleBtn.BackgroundColor3 = Color3.new(0,0,0); ToggleBtn.Text = "⚡"
ToggleBtn.TextColor3 = Color3.new(1,1,1); Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)
local Border = Instance.new("UIStroke", ToggleBtn); Border.Thickness = 3
task.spawn(function() while true do for i=0,1,0.01 do Border.Color=Color3.fromHSV(i,1,1) task.wait(0.02) end end end)

-- [2] الواجهة الرئيسية
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 300, 0, 400); MainFrame.Position = UDim2.new(0.2, 0, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); MainFrame.Visible = false

-- أزرار التحكم (X للإغلاق، - للتصغير)
local CloseBtn = Instance.new("TextButton", MainFrame); CloseBtn.Text = "X"; CloseBtn.Size = UDim2.new(0,30,0,30); CloseBtn.Position = UDim2.new(0.85, 0, 0, 5); CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
local MinBtn = Instance.new("TextButton", MainFrame); MinBtn.Text = "-"; MinBtn.Size = UDim2.new(0,30,0,30); MinBtn.Position = UDim2.new(0.7, 0, 0, 5); MinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

ToggleBtn.MouseButton1Click:Connect(function() MainFrame.Visible = true end)
MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() _G.IsRunning = false; ScreenGui:Destroy() end)

-- [3] الإحصائيات والسرعة
local StatsLabel = Instance.new("TextLabel", MainFrame); StatsLabel.Size = UDim2.new(0.9, 0, 0, 50); StatsLabel.Position = UDim2.new(0.05, 0, 0, 50); StatsLabel.Text = "بانتظار البدء..."
local Speed = 150
local SpeedSlider = Instance.new("TextButton", MainFrame); SpeedSlider.Size = UDim2.new(0.9, 0, 0, 30); SpeedSlider.Position = UDim2.new(0.05, 0, 0, 120); SpeedSlider.Text = "السرعة: 150 (اسحب لتعديل)"
SpeedSlider.MouseButton1Click:Connect(function()
    local mouse = Player:GetMouse()
    local rel = (mouse.X - SpeedSlider.AbsolutePosition.X) / SpeedSlider.AbsoluteSize.X
    Speed = math.min(math.floor(rel * 300), 300)
    SpeedSlider.Text = "السرعة: " .. Speed .. " (الحد الأقصى 300)"
end)

-- [4] منطق العمل (الذكاء الاصطناعي الخالد)
_G.IsRunning = false
local function StartSmartFarm()
    task.spawn(function()
        while _G.IsRunning do
            local Count = 0
            for _, obj in pairs(Workspace:GetDescendants()) do
                if _G.IsRunning and obj:IsA("BasePart") and (obj.Name:lower():find("win") or obj.Name:lower():find("cup")) then
                    Count = Count + 1
                    StatsLabel.Text = "عدد الكؤوس في عالمك: " .. Count
                    
                    if Player.Character and Player.Character:FindFirstChild("Humanoid") then
                        Player.Character.Humanoid.Health = 1000
                        Player.Character.Humanoid.WalkSpeed = Speed
                        Player.Character.Humanoid:MoveTo(obj.Position)
                        Player.Character.Humanoid.MoveToFinished:Wait()
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

-- زر التفعيل
local StartBtn = Instance.new("TextButton", MainFrame); StartBtn.Text = "تفعيل التفريم الخالد"; StartBtn.Size = UDim2.new(0.8,0,0,50); StartBtn.Position = UDim2.new(0.1,0,0,200)
StartBtn.MouseButton1Click:Connect(function() 
    _G.IsRunning = not _G.IsRunning
    StartBtn.Text = _G.IsRunning and "جاري العمل..." or "تفعيل التفريم الخالد"
    if _G.IsRunning then StartSmartFarm() end
end)

