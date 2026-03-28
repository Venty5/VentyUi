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
    local ScreenGuiName = "Venty_UI"
    local ParentBase = (RunService:IsStudio() and LocalPlayer:WaitForChild("PlayerGui") or game:GetService("CoreGui"))

    local Existing = ParentBase:FindFirstChild(ScreenGuiName)
    if Existing then
        Existing:Destroy()
    end

    local LoadingGui = Instance.new("ScreenGui")
    LoadingGui.Name = "Venty_Loading"
    LoadingGui.Parent = ParentBase

    local LoadFrame = Instance.new("Frame")
    LoadFrame.Size = UDim2.new(0, 280, 0, 90)
    LoadFrame.Position = UDim2.new(0.5, -140, 0.5, -45)
    LoadFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    LoadFrame.BorderSizePixel = 0
    LoadFrame.Parent = LoadingGui
    Instance.new("UICorner", LoadFrame).CornerRadius = UDim.new(0, 8)
    Instance.new("UIStroke", LoadFrame).Color = Color3.fromRGB(40, 40, 40)

    local LoadLabel = Instance.new("TextLabel")
    LoadLabel.Size = UDim2.new(1, 0, 0, 35)
    LoadLabel.Position = UDim2.new(0, 0, 0, 5)
    LoadLabel.BackgroundTransparency = 1
    LoadLabel.Text = "Venty Library"
    LoadLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoadLabel.Font = Enum.Font.GothamBold
    LoadLabel.TextSize = 16
    LoadLabel.Parent = LoadFrame

    local PercentageLabel = Instance.new("TextLabel")
    PercentageLabel.Size = UDim2.new(1, 0, 0, 20)
    PercentageLabel.Position = UDim2.new(0, 0, 0, 40)
    PercentageLabel.BackgroundTransparency = 1
    PercentageLabel.Text = "0%"
    PercentageLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    PercentageLabel.Font = Enum.Font.GothamMedium
    PercentageLabel.TextSize = 12
    PercentageLabel.Parent = LoadFrame

    local BarBack = Instance.new("Frame")
    BarBack.Size = UDim2.new(0.8, 0, 0, 4)
    BarBack.Position = UDim2.new(0.1, 0, 0.75, 0)
    BarBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    BarBack.BorderSizePixel = 0
    BarBack.Parent = LoadFrame
    Instance.new("UICorner", BarBack)

    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BarFill.BorderSizePixel = 0
    BarFill.Parent = BarBack
    Instance.new("UICorner", BarFill)

    local loadTime = 1.5
    local info = TweenInfo.new(loadTime, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local loadTween = TweenService:Create(BarFill, info, {Size = UDim2.new(1, 0, 1, 0)})
    
    loadTween:Play()

    task.spawn(function()
        local start = tick()
        while tick() - start < loadTime do
            local progress = math.min(math.floor(((tick() - start) / loadTime) * 100), 100)
            PercentageLabel.Text = progress .. "%"
            task.wait()
        end
        PercentageLabel.Text = "100%"
    end)
    
    task.wait(loadTime + 0.1) 
    LoadingGui:Destroy()

    local WindowName = Config.Name or "Venty.cc"
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = ScreenGuiName
    ScreenGui.Parent = ParentBase
    ScreenGui.ResetOnSpawn = false
    self.Gui = ScreenGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 350, 0, 450) 
    MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10) 
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true 
    MainFrame.Parent = ScreenGui
    self.MainFrame = MainFrame

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

    local CornerLabel = Instance.new("TextLabel")
    CornerLabel.Size = UDim2.new(0, 200, 0, 25)
    CornerLabel.Position = UDim2.new(0, 12, 0, 5)
    CornerLabel.BackgroundTransparency = 1
    CornerLabel.Text = WindowName
    CornerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CornerLabel.Font = Enum.Font.GothamBold
    CornerLabel.TextSize = 12
    CornerLabel.TextXAlignment = Enum.TextXAlignment.Left
    CornerLabel.ZIndex = 10
    CornerLabel.Parent = MainFrame

    local Banner = Instance.new("ImageLabel")
    Banner.Name = "Banner"
    Banner.Size = UDim2.new(1, 0, 0, 120)
    Banner.BorderSizePixel = 0
    Banner.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Banner.ScaleType = Enum.ScaleType.Crop
    Banner.ZIndex = 1
    Banner.Parent = MainFrame
    Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 10)

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

    local dragToggle = false
    local dragStart, startPos
    local targetPos = MainFrame.Position

    Banner.InputBegan:Connect(function(input)
        if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
            dragToggle = true
            dragStart = input.Position
            startPos = MainFrame.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragToggle = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            targetPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local renderConnection
    renderConnection = RunService.RenderStepped:Connect(function()
        if not MainFrame or not MainFrame.Parent then 
            renderConnection:Disconnect() 
            return 
        end
        if MainFrame.Position ~= targetPos then
            MainFrame.Position = MainFrame.Position:Lerp(targetPos, 0.15)
        end
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
        TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
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
            SFrame.Size = UDim2.new(1, -10, 0, 25)
            SFrame.BackgroundTransparency = 1
            SFrame.Parent = Container
            local SLbl = Instance.new("TextLabel")
            SLbl.Size = UDim2.new(1, -12, 1, 0)
            SLbl.Position = UDim2.new(0, 12, 0, 0)
            SLbl.BackgroundTransparency = 1
            SLbl.Text = SConfig.Name:upper()
            SLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            SLbl.Font = Enum.Font.GothamBold
            SLbl.TextSize = 10
            SLbl.TextXAlignment = Enum.TextXAlignment.Left
            SLbl.Parent = SFrame
            return TabFunctions
        end

        function TabFunctions:AddButton(BConfig)
            local BFrame = Instance.new("Frame")
            BFrame.Size = UDim2.new(1, -10, 0, 40)
            BFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) 
            BFrame.Parent = Container
            Instance.new("UICorner", BFrame).CornerRadius = UDim.new(0, 8)
            
            local RightLabel = Instance.new("TextLabel")
            RightLabel.Size = UDim2.new(0, 50, 1, 0)
            RightLabel.Position = UDim2.new(1, -62, 0, 0)
            RightLabel.Text = "Button"
            RightLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            RightLabel.Font = Enum.Font.GothamMedium
            RightLabel.TextSize = 12
            RightLabel.TextXAlignment = Enum.TextXAlignment.Right
            RightLabel.BackgroundTransparency = 1
            RightLabel.Parent = BFrame

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -120, 1, 0)
            lbl.Position = UDim2.new(0, 12, 0, 0)
            lbl.Text = BConfig.Name or "Button"
            lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            lbl.Font = Enum.Font.GothamMedium 
            lbl.TextSize = 13
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.BackgroundTransparency = 1
            lbl.Parent = BFrame

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = BFrame
            
            btn.MouseButton1Click:Connect(function()
                TweenService:Create(BFrame, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
                task.wait(0.1)
                TweenService:Create(BFrame, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(15, 15, 15)}):Play()
                if BConfig.Callback then task.spawn(BConfig.Callback) end
            end)
            return TabFunctions
        end

        function TabFunctions:AddToggle(TConfig)
            local Toggled = TConfig.Default or false
            local TFrame = Instance.new("Frame")
            TFrame.Size = UDim2.new(1, -10, 0, 40)
            TFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            TFrame.Parent = Container
            Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 8)
            
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -70, 1, 0)
            lbl.Position = UDim2.new(0, 12, 0, 0)
            lbl.Text = TConfig.Name
            lbl.TextColor3 = Toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
            lbl.Font = Enum.Font.GothamMedium
            lbl.TextSize = 13
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.BackgroundTransparency = 1
            lbl.Parent = TFrame

            local SwitchBG = Instance.new("Frame")
            SwitchBG.Size = UDim2.new(0, 36, 0, 20)
            SwitchBG.Position = UDim2.new(1, -48, 0.5, -10)
            SwitchBG.BackgroundColor3 = Toggled and Color3.fromRGB(48, 209, 88) or Color3.fromRGB(45, 45, 45)
            SwitchBG.Parent = TFrame
            Instance.new("UICorner", SwitchBG).CornerRadius = UDim.new(1, 0)

            local Thumb = Instance.new("Frame")
            Thumb.Size = UDim2.new(0, 16, 0, 16)
            Thumb.Position = Toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            Thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Thumb.Parent = SwitchBG
            Instance.new("UICorner", Thumb).CornerRadius = UDim.new(1, 0)

            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 1, 0)
            btn.BackgroundTransparency = 1
            btn.Text = ""
            btn.Parent = TFrame
            
            btn.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                TweenService:Create(SwitchBG, TweenInfo.new(0.2), {BackgroundColor3 = Toggled and Color3.fromRGB(48, 209, 88) or Color3.fromRGB(45, 45, 45)}):Play()
                TweenService:Create(Thumb, TweenInfo.new(0.2), {Position = Toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
                if TConfig.Callback then task.spawn(TConfig.Callback, Toggled) end
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
