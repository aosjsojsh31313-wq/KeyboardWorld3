-- // نظام الخالد الفائق - سرعة قصوى //
local Player = game.Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- [1] الواجهة الاحترافية (تصغير + إغلاق + ترتيب سهم)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 250, 0, 450)
MainFrame.Position = UDim2.new(0.5, -125, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BackgroundTransparency = 0.2
MainFrame.Active = true
MainFrame.Draggable = true

local Border = Instance.new("UIStroke", MainFrame)
Border.Thickness = 2
task.spawn(function() while true do for i=0,1,0.01 do Border.Color=Color3.fromHSV(i,1,1) task.wait(0.02) end end end)

-- أزرار التحكم (تصغير/إغلاق)
local CloseBtn = Instance.new("TextButton", MainFrame)
CloseBtn.Size = UDim2.new(0, 30, 0, 30); CloseBtn.Position = UDim2.new(0.85, 0, 0, 5); CloseBtn.Text = "X"; CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0, 30, 0, 30); MinBtn.Position = UDim2.new(0.70, 0, 0, 5); MinBtn.Text = "-"; MinBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
MinBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- [2] العداد الذكي (أذكى ذكاء اصطناعي لفحص الملفات)
local CounterLabel = Instance.new("TextLabel", MainFrame)
CounterLabel.Size = UDim2.new(1, 0, 0, 50); CounterLabel.Position = UDim2.new(0, 0, 0, 40)
CounterLabel.Text = "جاري فحص المليون ملف..."; CounterLabel.TextColor3 = Color3.new(1,1,1); CounterLabel.BackgroundTransparency = 1

-- [3] العقول الفائقة (السرعة القصوى)
local function UltraFastFarm()
    task.spawn(function()
        while true do
            -- الحماية الخالدة (لا تموت أبداً)
            local Hum = Player.Character and Player.Character:FindFirstChild("Humanoid")
            if Hum then Hum.Health = 1000 end
            
            -- فحص فائق السرعة
            local count = 0
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("BasePart") and (obj.Name:lower():find("win") or obj.Name:lower():find("cup")) then
                    count = count + 1
                    -- ربط البارت بالمسار (سرعة انتقال فائقة)
                    Hum:MoveTo(obj.Position)
                    -- لا ننتظر المرة هذي عشان نكون أسرع (تجاوز الانتظار)
                end
            end
            CounterLabel.Text = "عدد الكؤوس المكتشفة: " .. count
            task.wait(0.01) -- سرعة تنفيذ خيالية
        end
    end)
end

-- زر التشغيل (شكل سهم)
local StartBtn = Instance.new("TextButton", MainFrame)
StartBtn.Size = UDim2.new(0.9, 0, 0, 50); StartBtn.Position = UDim2.new(0.05, 0, 0, 100)
StartBtn.Text = "➤ تشغيل وضع الخالد الفائق"; StartBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
StartBtn.MouseButton1Click:Connect(UltraFastFarm)
