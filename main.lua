-- 1. تشغيل محرك LuxyHub الأصلي بالكامل لضمان نفس الكؤوس والنظام
pcall(function()
    loadstring(game:HttpGet("https://luxyhub.space"))()
end)

-- 2. نظام الترجمة التلقائية الفوري للواجهة إلى اللغة العربية
task.spawn(function()
    local coreGui = game:GetService("CoreGui")
    
    -- دالة فحص النصوص واستبدالها بالعربية في نفس اللحظة
    local function translateUI(object)
        if object:IsA("TextLabel") or object:IsA("TextButton") then
            -- ترجمة العناوين الرئيسية
            if object.Text:lower():match("luxy") or object.Text:lower():match("hub") then
                object.Text = "💎 لوحة تحكم LuxyHub العربية 🏆"
            -- ترجمة أزرار الكؤوس والفوز
            elseif object.Text:lower():match("farm") or object.Text:lower():match("cup") or object.Text:lower():match("win") then
                if object.Text:lower():match("toggle") or object.Text:lower():match("off") then
                    object.Text = "تجميع الكؤوس التلقائي: إيقاف ❌"
                else
                    object.Text = "جاري حصد الكؤوس تلقائياً... 🔥"
                end
            -- ترجمة أنظمة الحماية والأمان
            elseif object.Text:lower():match("anti") or object.Text:lower():match("god") or object.Text:lower():match("bypass") then
                object.Text = "🛡️ درع الحماية ضد الموت والتسونامي: نشط"
            -- ترجمة مؤشرات الفحص
            elseif object.Text:lower():match("status") or object.Text:lower():match("scanning") then
                object.Text = "🔍 نظام الفحص الذاتي يراقب اللعبة الآن..."
            end
        end
    end

    -- فحص العناصر الحالية والمستقبلية التي تفتحها واجهة LuxyHub وترجمتها فوراً
    coreGui.DescendantAdded:Connect(translateUI)
    for _, descendant in pairs(coreGui:GetDescendants()) do
        translateUI(descendant)
    end
end)
