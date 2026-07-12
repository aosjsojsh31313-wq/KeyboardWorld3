-- Delta Optimized Script - Clean Version
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/-back-ups-for-libs/main/wall%20v3"))()

local Window = Library:CreateWindow("🏆 AI Farming Hub", Color3.fromRGB(0, 255, 170))
local Tab1 = Window:NewTab("🚀 Main Farm")
local section1 = Tab1:NewSection("Automation")

_G.IsFarming = false

section1:NewButton("Toggle Auto Farm", "Starts the farming loop", function()
    _G.IsFarming = not _G.IsFarming
    if _G.IsFarming then
        task.spawn(function()
            while _G.IsFarming do
                pcall(function()
                    local target = nil
                    local dist = math.huge
                    for _, v in pairs(game.Workspace:GetDescendants()) do
                        if v:IsA("BasePart") and (v.Name == "WinPart" or v.Name == "EndZone" or v.Name:match("Cup")) then
                            local mag = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude
                            if mag < dist then
                                dist = mag
                                target = v
                            end
                        end
                    end
                    if target then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.CFrame
                    end
                end)
                task.wait(0.2)
            end
        end)
    end
end)

