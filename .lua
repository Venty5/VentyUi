local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local VentyLib = {
    Tabs = {},
    CurrentTabIndex = 0,
    Gui = nil,
    MainFrame = nil,
    Visible = true,
    OpenBind = Enum.KeyCode.RightShift
}

function VentyLib:CreateWindow(Config)
    local WindowName = Config.Name or "Venty.cc"
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "Venty_UI"
    ScreenGui.Parent = (RunService:IsStudio() and LocalPlayer:WaitForChild("PlayerGui") or game:GetService("CoreGui"))
    ScreenGui.ResetOnSpawn = false
    self.Gui = ScreenGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 350, 0, 450) 
    MainFrame.Position = UDim2.new(0, 20, 0, 20)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.BackgroundTransparency = 0.2
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true 
    MainFrame.Parent = ScreenGui
    self.MainFrame = MainFrame

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

    local Banner = Instance.new("ImageLabel")
    Banner.Name = "Banner"
    Banner.Size = UDim2.new(1, 0, 0, 120)
    Banner.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Banner.ScaleType = Enum.ScaleType.Crop
    Banner.ZIndex = 1
    Banner.Parent = MainFrame
    Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 10)

    local CornerLabel = Instance.new("TextLabel")
    CornerLabel.Size = UDim2.new(0, 100, 0, 25)
    CornerLabel.Position = UDim2.new(0, 12, 0, 5)
    CornerLabel.BackgroundTransparency = 1
    CornerLabel.Text = WindowName
    CornerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CornerLabel.Font = Enum.Font.GothamBold
    CornerLabel.TextSize = 12
    CornerLabel.TextXAlignment = Enum.TextXAlignment.Left
    CornerLabel.ZIndex = 5
    CornerLabel.Parent = MainFrame

    local CurrentTabTitle = Instance.new("TextLabel")
    CurrentTabTitle.Size = UDim2.new(1, 0, 0, 25)
    CurrentTabTitle.Position = UDim2.new(0, 0, 0, 120)
    CurrentTabTitle.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    CurrentTabTitle.BackgroundTransparency = 0.2
    CurrentTabTitle.Text = "MAIN"
    CurrentTabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    CurrentTabTitle.Font = Enum.Font.GothamMedium
    CurrentTabTitle.TextSize = 11
    CurrentTabTitle.ZIndex = 2
    CurrentTabTitle.Parent = MainFrame

    local TabBarScroll = Instance.new("ScrollingFrame")
    TabBarScroll.Size = UDim2.new(1, 0, 0, 35)
    TabBarScroll.Position = UDim2.new(0, 0, 0, 145)
    TabBarScroll.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TabBarScroll.BorderSizePixel = 0
    TabBarScroll.ScrollBarThickness = 0
    TabBarScroll.ZIndex = 3
    TabBarScroll.Parent = MainFrame

    local TabBarLayout = Instance.new("UIListLayout", TabBarScroll)
    TabBarLayout.FillDirection = Enum.FillDirection.Horizontal
    TabBarLayout.SortOrder = Enum.SortOrder.LayoutOrder

    TabBarLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBarScroll.CanvasSize = UDim2.new(0, TabBarLayout.AbsoluteContentSize.X, 0, 0)
    end)

    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Size = UDim2.new(1, 0, 1, -180) 
    ContainerHolder.Position = UDim2.new(0, 0, 0, 180)
    ContainerHolder.BackgroundTransparency = 1
    ContainerHolder.ZIndex = 2
    ContainerHolder.Parent = MainFrame

    local dragToggle, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragToggle = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragToggle then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragToggle = false end
    end)

    function self:AddBanner(BConfig)
        if BConfig.Icon then Banner.Image = BConfig.Icon end
    end

    function self:AddTab(TConfig)
        local TabName = TConfig.Name or "Tab"
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 116, 1, 0) 
        TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = TabName
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.TextSize = 12
        TabBtn.ZIndex = 4
        TabBtn.Parent = TabBarScroll

        local Container = Instance.new("ScrollingFrame")
        Container.Size = UDim2.new(1, -10, 1, -10)
        Container.Position = UDim2.new(0, 5, 0, 5)
        Container.BackgroundTransparency = 1
        Container.Visible = false
        Container.BorderSizePixel = 0
        Container.ScrollBarThickness = 2
        Container.ZIndex = 2
        Container.Parent = ContainerHolder

        local UIList = Instance.new("UIListLayout", Container)
        UIList.SortOrder = Enum.SortOrder.LayoutOrder
        UIList.Padding = UDim.new(0, 5) 

        table.insert(self.Tabs, {Button = TabBtn, Container = Container, Name = TabName})
        local index = #self.Tabs
        
        TabBtn.MouseButton1Click:Connect(function()
            self:SelectTab(index)
            CurrentTabTitle.Text = TabName:upper()
        end)

        local TabFunctions = {}
        function TabFunctions:AddSection(SConfig)
            local SFrame = Instance.new("Frame")
            SFrame.Size = UDim2.new(1, -10, 0, 25); SFrame.BackgroundTransparency = 1; SFrame.Parent = Container
            local SLbl = Instance.new("TextLabel")
            SLbl.Size = UDim2.new(1, -12, 1, 0); SLbl.Position = UDim2.new(0, 12, 0, 0); SLbl.BackgroundTransparency = 1; SLbl.Text = SConfig.Name:upper(); SLbl.TextColor3 = Color3.fromRGB(255, 255, 255); SLbl.Font = Enum.Font.GothamBold; SLbl.TextSize = 10; SLbl.TextXAlignment = Enum.TextXAlignment.Left; SLbl.Parent = SFrame
            return TabFunctions
        end

        function TabFunctions:AddToggle(TConfig)
            local Toggled = TConfig.Default or false
            local TFrame = Instance.new("Frame")
            TFrame.Size = UDim2.new(1, -10, 0, 35); TFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15); TFrame.Parent = Container; Instance.new("UICorner", TFrame)
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1,0,1,0); btn.BackgroundTransparency = 1; btn.Text = ""; btn.Parent = TFrame
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1,-60,1,0); lbl.Position = UDim2.new(0,12,0,0); lbl.Text = TConfig.Name; lbl.TextColor3 = Color3.fromRGB(200,200,200); lbl.Font = Enum.Font.GothamMedium; lbl.TextSize = 12; lbl.TextXAlignment = Enum.TextXAlignment.Left; lbl.BackgroundTransparency = 1; lbl.Parent = TFrame
            
            local function Update()
                lbl.TextColor3 = Toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
                if TConfig.Callback then TConfig.Callback(Toggled) end
            end

            btn.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                Update()
            end)

            return TabFunctions
        end

        if #self.Tabs == 1 then self:SelectTab(1) end
        return TabFunctions
    end

    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == self.OpenBind then
            self.Visible = not self.Visible
            self.MainFrame.Visible = self.Visible
        end
    end)

    return self
end

function VentyLib:SelectTab(index)
    for i, tab in ipairs(self.Tabs) do
        local active = (i == index)
        tab.Container.Visible = active
        tab.Button.BackgroundColor3 = active and Color3.fromRGB(30, 30, 30) or Color3.fromRGB(20, 20, 20)
        tab.Button.TextColor3 = active and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
    end
end

return VentyLib
