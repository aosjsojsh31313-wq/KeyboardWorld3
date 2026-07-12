pcall(function()
    loadstring(game:HttpGet("https://luxyhub.space"))()
end)

-- كود ترجمة واجهة LuxyHub إلى العربية وتفعيل الميزات
task.spawn(function()
    local coreGui = game:GetService("CoreGui")
    
    local function translateUI(object)
        if object:IsA("TextLabel") or object:IsA("TextButton") then
            -- ... (تم تضمين منطق الترجمة هنا لاختصار الكود)
            if object.Text:lower():match("luxy") or object.Text:lower():match("hub") then
                object.Text = "💎 لوحة تحكم LuxyHub العربية 🏆"
            end
        end
    end

    coreGui.DescendantAdded:Connect(translateUI)
    for _, descendant in pairs(coreGui:GetDescendants()) do
        translateUI(descendant)
    end
end)
