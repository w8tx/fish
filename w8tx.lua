--====================================================
--  🎣 FISH IT — MOD MENU W8TX (FULL VERSION)
--====================================================

local UIS = game:GetService("UserInputService")
local RS = game:GetService("ReplicatedStorage")
local Player = game.Players.LocalPlayer

local FishingEvent = RS:WaitForChild("RemoteEvents"):WaitForChild("FishingEvent")

_G.AutoFish = false
_G.SpeedMultiplier = 1

------------------------------------------------------
-- UI MOD MENU
------------------------------------------------------

local Gui = Instance.new("ScreenGui", Player.PlayerGui)
Gui.ResetOnSpawn = false

local Frame = Instance.new("Frame", Gui)
Frame.Size = UDim2.new(0, 300, 0, 250)
Frame.Position = UDim2.new(0.7, 0, 0.2, 0)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
Frame.Active = true
Frame.Draggable = true
Frame.Visible = false

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(70, 70, 120)
Title.Text = "🎣 MOD MENU — W8TX"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local function MakeButton(text, order)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, 40 + (order * 45))
	btn.BackgroundColor3 = Color3.fromRGB(60, 60, 90)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Font = Enum.Font.GothamSemibold
	btn.TextSize = 16
	btn.Text = text
	return btn
end

local AutoBtn = MakeButton("Auto Fishing: OFF", 0)
local SpeedBtn = MakeButton("Speed x1", 1)
local CloseBtn = MakeButton("Close Menu", 4)

AutoBtn.MouseButton1Click:Connect(function()
	_G.AutoFish = not _G.AutoFish
	AutoBtn.Text = _G.AutoFish and "Auto Fishing: ON" or "Auto Fishing: OFF"
end)

SpeedBtn.MouseButton1Click:Connect(function()
	if _G.SpeedMultiplier == 1 then
		_G.SpeedMultiplier = 10
		SpeedBtn.Text = "Speed x10"
	else
		_G.SpeedMultiplier = 1
		SpeedBtn.Text = "Speed x1"
	end
end)

CloseBtn.MouseButton1Click:Connect(function()
	Frame.Visible = false
end)

UIS.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.M then
		Frame.Visible = not Frame.Visible
	end
end)

------------------------------------------------------
-- UI PROGRESS BAR
------------------------------------------------------

local Progress = Instance.new("Frame", Gui)
Progress.Size = UDim2.new(0, 250, 0, 25)
Progress.Position = UDim2.new(0.5, -125, 0.8, 0)
Progress.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
Progress.Visible = true

local Fill = Instance.new("Frame", Progress)
Fill.Size = UDim2.new(0, 0, 1, 0)
Fill.BackgroundColor3 = Color3.fromRGB(80, 120, 250)

------------------------------------------------------
-- SISTEM MANCING
------------------------------------------------------

local fishing = false

function StartFishing()
	if fishing then return end
	fishing = true

	local timeRequired = 2 / (_G.SpeedMultiplier or 1)

	Fill.Size = UDim2.new(0, 0, 1, 0)

	for i = 1, 100 do
		task.wait(timeRequired / 100)
		Fill.Size = UDim2.new(i/100, 0, 1, 0)
	end

	FishingEvent:FireServer()
end

FishingEvent.OnClientEvent:Connect(function(fish)
	print("Kamu mendapatkan:", fish)

	fishing = false

	if _G.AutoFish then
		task.wait(0.1)
		StartFishing()
	end
end)

------------------------------------------------------
-- KLIK UNTUK MANCING (HP & PC)
------------------------------------------------------

UIS.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		StartFishing()
	end
end)