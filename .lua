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
    OpenBind = Enum.KeyCode.F1
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
    Instance.new("UICorner", BarBack).CornerRadius = UDim.new(0, 6)

    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BarFill.BorderSizePixel = 0
    BarFill.Parent = BarBack
    Instance.new("UICorner", BarFill).CornerRadius = UDim.new(0, 6)

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
    MainFrame.Size = UDim2.new(0, 500, 0, 500) 
    MainFrame.Position = UDim2.new(0.5, -250, 0.5, -250)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10) 
    MainFrame.BackgroundTransparency = 0.1
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true 
    MainFrame.Parent = ScreenGui
    self.MainFrame = MainFrame

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

    local Banner = Instance.new("ImageLabel")
    Banner.Name = "Banner"
    Banner.Size = UDim2.new(1, 0, 0, 45)
    Banner.BorderSizePixel = 0
    Banner.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Banner.ScaleType = Enum.ScaleType.Crop
    Banner.ZIndex = 1
    Banner.Parent = MainFrame
    Instance.new("UICorner", Banner).CornerRadius = UDim.new(0, 10)

    local CornerLabel = Instance.new("TextLabel")
    CornerLabel.Size = UDim2.new(0, 250, 0, 45)
    CornerLabel.Position = UDim2.new(0, 15, 0, 0)
    CornerLabel.BackgroundTransparency = 1
    CornerLabel.Text = WindowName
    CornerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CornerLabel.Font = Enum.Font.GothamBold
    CornerLabel.TextSize = 14
    CornerLabel.TextXAlignment = Enum.TextXAlignment.Left
    CornerLabel.ZIndex = 10
    CornerLabel.Parent = MainFrame

    local CurrentTabTitle = Instance.new("TextLabel")
    CurrentTabTitle.Size = UDim2.new(1, 0, 0, 30)
    CurrentTabTitle.Position = UDim2.new(0, 0, 0, 45)
    CurrentTabTitle.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    CurrentTabTitle.BackgroundTransparency = 0.2
    CurrentTabTitle.Text = "MAIN"
    CurrentTabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    CurrentTabTitle.Font = Enum.Font.GothamMedium
    CurrentTabTitle.TextSize = 12
    CurrentTabTitle.ZIndex = 2
    CurrentTabTitle.Parent = MainFrame

    local TabBarScroll = Instance.new("ScrollingFrame")
    TabBarScroll.Size = UDim2.new(1, 0, 0, 40)
    TabBarScroll.Position = UDim2.new(0, 0, 0, 75)
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
    ContainerHolder.Size = UDim2.new(1, 0, 1, -115) 
    ContainerHolder.Position = UDim2.new(0, 0, 0, 115)
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

    function self:SelectTab(index)
        for i, tab in ipairs(self.Tabs) do
            tab.Visible = (i == index)
            tab.Button.TextColor3 = (i == index) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(150, 150, 150)
            tab.Container.Visible = (i == index)
        end
    end

    function self:AddBanner(BConfig)
        if BConfig.Icon then Banner.Image = BConfig.Icon end
    end

    function self:AddTab(TConfig)
        local TabName = TConfig.Name or "Tab"
        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 120, 1, 0) 
        TabBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        TabBtn.BorderSizePixel = 0
        TabBtn.Text = TabName
        TabBtn.Font = Enum.Font.GothamSemibold
        TabBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabBtn.TextSize = 12
        TabBtn.ZIndex = 4
        TabBtn.Parent = TabBarScroll

        local Container = Instance.new("ScrollingFrame")
        Container.Size = UDim2.new(1, -15, 1, -15)
        Container.Position = UDim2.new(0, 7.5, 0, 7.5)
        Container.BackgroundTransparency = 1
        Container.Visible = false
        Container.BorderSizePixel = 0
        Container.ScrollBarThickness = 4
        Container.ZIndex = 2
        Container.Parent = ContainerHolder

        local UIList = Instance.new("UIListLayout", Container)
        UIList.SortOrder = Enum.SortOrder.LayoutOrder
        UIList.Padding = UDim.new(0, 8) 

        local localUpdateCanvas = function()
            Container.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
        end
        UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(localUpdateCanvas)
        self.UpdateCanvas = localUpdateCanvas

        table.insert(self.Tabs, {Button = TabBtn, Container = Container, Name = TabName})
        local index = #self.Tabs
        
        if index == 1 then
            self:SelectTab(1)
            CurrentTabTitle.Text = TabName:upper()
        end

        TabBtn.MouseButton1Click:Connect(function()
            self:SelectTab(index)
            CurrentTabTitle.Text = TabName:upper()
        end)

        local TabFunctions = {}

        function TabFunctions:AddSection(SConfig)
            local SFrame = Instance.new("Frame")
            SFrame.Size = UDim2.new(1, -10, 0, 28)
            SFrame.BackgroundTransparency = 1
            SFrame.Parent = Container
            local SLbl = Instance.new("TextLabel")
            SLbl.Size = UDim2.new(1, -12, 1, 0)
            SLbl.Position = UDim2.new(0, 12, 0, 0)
            SLbl.BackgroundTransparency = 1
            SLbl.Text = SConfig.Name:upper()
            SLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            SLbl.Font = Enum.Font.GothamBold
            SLbl.TextSize = 11
            SLbl.TextXAlignment = Enum.TextXAlignment.Left
            SLbl.Parent = SFrame
            return TabFunctions
        end

        function TabFunctions:AddLabel(LConfig)
            local LFrame = Instance.new("Frame")
            LFrame.Size = UDim2.new(1, -10, 0, 35)
            LFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            LFrame.Parent = Container
            Instance.new("UICorner", LFrame).CornerRadius = UDim.new(0, 8)

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -24, 1, 0)
            lbl.Position = UDim2.new(0, 12, 0, 0)
            lbl.Text = LConfig.Text or "Label"
            lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
            lbl.Font = Enum.Font.GothamMedium
            lbl.TextSize = 13
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.BackgroundTransparency = 1
            lbl.Parent = LFrame
            return TabFunctions
        end

        function TabFunctions:AddButton(BConfig)
            local BFrame = Instance.new("Frame")
            BFrame.Size = UDim2.new(1, -10, 0, 45)
            BFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) 
            BFrame.Parent = Container
            Instance.new("UICorner", BFrame).CornerRadius = UDim.new(0, 8)
            
            local RightLabel = Instance.new("TextLabel")
            RightLabel.Size = UDim2.new(0, 60, 1, 0)
            RightLabel.Position = UDim2.new(1, -72, 0, 0)
            RightLabel.Text = "Button"
            RightLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            RightLabel.Font = Enum.Font.GothamMedium
            RightLabel.TextSize = 13
            RightLabel.TextXAlignment = Enum.TextXAlignment.Right
            RightLabel.BackgroundTransparency = 1
            RightLabel.Parent = BFrame

            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -140, 1, 0)
            lbl.Position = UDim2.new(0, 15, 0, 0)
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
            TFrame.Size = UDim2.new(1, -10, 0, 45)
            TFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            TFrame.Parent = Container
            Instance.new("UICorner", TFrame).CornerRadius = UDim.new(0, 8)
            
            local lbl = Instance.new("TextLabel")
            lbl.Size = UDim2.new(1, -80, 1, 0)
            lbl.Position = UDim2.new(0, 15, 0, 0)
            lbl.Text = TConfig.Name
            lbl.TextColor3 = Toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
            lbl.Font = Enum.Font.GothamMedium
            lbl.TextSize = 13
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.BackgroundTransparency = 1
            lbl.Parent = TFrame

            local SwitchBG = Instance.new("Frame")
            SwitchBG.Size = UDim2.new(0, 40, 0, 22)
            SwitchBG.Position = UDim2.new(1, -52, 0.5, -11)
            SwitchBG.BackgroundColor3 = Toggled and Color3.fromRGB(48, 209, 88) or Color3.fromRGB(45, 45, 45)
            SwitchBG.Parent = TFrame
            Instance.new("UICorner", SwitchBG).CornerRadius = UDim.new(1, 0)

            local Thumb = Instance.new("Frame")
            Thumb.Size = UDim2.new(0, 18, 0, 18)
            Thumb.Position = Toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)
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
                TweenService:Create(Thumb, TweenInfo.new(0.2), {Position = Toggled and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9)}):Play()
                lbl.TextColor3 = Toggled and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(200, 200, 200)
                if TConfig.Callback then task.spawn(TConfig.Callback, Toggled) end
            end)
            return TabFunctions
        end

        function TabFunctions:AddSlider(SConfig)
            local Min = SConfig.Min or 0
            local Max = SConfig.Max or 100
            local Default = SConfig.Default or Min
            local Suffix = SConfig.Suffix or "" 
            local Value = Default

            local SFrame = Instance.new("Frame")
            SFrame.Size = UDim2.new(1, -10, 0, 70) 
            SFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            SFrame.Parent = Container
            Instance.new("UICorner", SFrame).CornerRadius = UDim.new(0, 8)

            local Lbl = Instance.new("TextLabel")
            Lbl.Size = UDim2.new(1, -24, 0, 28)
            Lbl.Position = UDim2.new(0, 15, 0, 5)
            Lbl.Text = SConfig.Name or "Slider"
            Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            Lbl.Font = Enum.Font.GothamBold 
            Lbl.TextSize = 13
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
            Lbl.BackgroundTransparency = 1
            Lbl.Parent = SFrame

            local ValLbl = Instance.new("TextLabel")
            ValLbl.Size = UDim2.new(0, 150, 0, 28)
            ValLbl.Position = UDim2.new(1, -162, 0, 8)
            ValLbl.Text = tostring(Value) .. " " .. Suffix
            ValLbl.TextColor3 = Color3.fromRGB(150, 150, 150)
            ValLbl.Font = Enum.Font.GothamBold
            ValLbl.TextSize = 13
            ValLbl.TextXAlignment = Enum.TextXAlignment.Right
            ValLbl.BackgroundTransparency = 1
            ValLbl.Parent = SFrame

            local SliderBack = Instance.new("Frame")
            SliderBack.Size = UDim2.new(1, -30, 0, 16) 
            SliderBack.Position = UDim2.new(0, 15, 0, 40)
            SliderBack.BackgroundColor3 = Color3.fromRGB(45, 48, 53) 
            SliderBack.BorderSizePixel = 0
            SliderBack.Parent = SFrame

            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new(math.clamp((Value - Min) / (Max - Min), 0, 1), 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(120, 124, 133) 
            SliderFill.BorderSizePixel = 0
            SliderFill.Parent = SliderBack

            local SliderBtn = Instance.new("TextButton")
            SliderBtn.Size = UDim2.new(1, 0, 1, 0)
            SliderBtn.BackgroundTransparency = 1
            SliderBtn.Text = ""
            SliderBtn.Parent = SliderBack

            local function update()
                local mousePos = UserInputService:GetMouseLocation().X
                local sliderPos = SliderBack.AbsolutePosition.X
                local sliderSize = SliderBack.AbsoluteSize.X
                local percentage = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
                
                Value = math.floor((Min + ((Max - Min) * percentage)) * 10) / 10
                ValLbl.Text = tostring(Value) .. " " .. Suffix
                
                TweenService:Create(SliderFill, TweenInfo.new(0.05), {Size = UDim2.new(percentage, 0, 1, 0)}):Play()
                
                if SConfig.Callback then task.spawn(SConfig.Callback, Value) end
            end

            local dragging = false
            SliderBtn.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    update()
                end
            end)

            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)

            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    update()
                end
            end)

            return TabFunctions
        end

        function TabFunctions:AddDropdown(DConfig)
            local Options = DConfig.Options or {}
            local Current = DConfig.Default or Options[1] or ""
            local DFrame = Instance.new("Frame")
            DFrame.Size = UDim2.new(1, -10, 0, 45)
            DFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            DFrame.ClipsDescendants = true
            DFrame.Parent = Container
            Instance.new("UICorner", DFrame).CornerRadius = UDim.new(0, 8)

            local Lbl = Instance.new("TextLabel")
            Lbl.Size = UDim2.new(1, -24, 0, 45)
            Lbl.Position = UDim2.new(0, 15, 0, 0)
            Lbl.Text = DConfig.Name or "Dropdown"
            Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            Lbl.Font = Enum.Font.GothamMedium
            Lbl.TextSize = 13
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
            Lbl.BackgroundTransparency = 1
            Lbl.Parent = DFrame

            local SelectedLbl = Instance.new("TextLabel")
            SelectedLbl.Size = UDim2.new(0, 120, 0, 45)
            SelectedLbl.Position = UDim2.new(1, -132, 0, 0)
            SelectedLbl.Text = Current
            SelectedLbl.TextColor3 = Color3.fromRGB(150, 150, 150)
            SelectedLbl.Font = Enum.Font.GothamMedium
            SelectedLbl.TextSize = 12
            SelectedLbl.TextXAlignment = Enum.TextXAlignment.Right
            SelectedLbl.BackgroundTransparency = 1
            SelectedLbl.Parent = DFrame

            local DropBtn = Instance.new("TextButton")
            DropBtn.Size = UDim2.new(1, 0, 0, 45)
            DropBtn.BackgroundTransparency = 1
            DropBtn.Text = ""
            DropBtn.Parent = DFrame

            local OptionContainer = Instance.new("Frame")
            OptionContainer.Size = UDim2.new(1, 0, 1, -45)
            OptionContainer.Position = UDim2.new(0, 0, 0, 45)
            OptionContainer.BackgroundTransparency = 1
            OptionContainer.Parent = DFrame
            
            local OptionList = Instance.new("UIListLayout", OptionContainer)
            OptionList.SortOrder = Enum.SortOrder.LayoutOrder

            local open = false
            local function Toggle()
                open = not open
                local targetSize = open and UDim2.new(1, -10, 0, 45 + (#Options * 35)) or UDim2.new(1, -10, 0, 45)
                TweenService:Create(DFrame, TweenInfo.new(0.2), {Size = targetSize}):Play()
                self:UpdateCanvas()
            end
            DropBtn.MouseButton1Click:Connect(Toggle)

            for i, opt in ipairs(Options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, -30, 0, 35)
                OptBtn.Position = UDim2.new(0, 15, 0, 0)
                OptBtn.BackgroundTransparency = 1
                OptBtn.Text = opt
                OptBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextSize = 12
                OptBtn.TextXAlignment = Enum.TextXAlignment.Left
                OptBtn.Parent = OptionContainer

                OptBtn.MouseButton1Click:Connect(function()
                    Current = opt
                    SelectedLbl.Text = Current
                    Toggle()
                    if DConfig.Callback then task.spawn(DConfig.Callback, Current) end
                end)
            end
            return TabFunctions
        end

        function TabFunctions:AddColorpicker(CConfig)
            local CurrentColor = Color3.fromRGB(255, 255, 255)
            
            local CFrame = Instance.new("Frame")
            CFrame.Size = UDim2.new(1, -10, 0, 45)
            CFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            CFrame.ClipsDescendants = true
            CFrame.Parent = Container
            Instance.new("UICorner", CFrame).CornerRadius = UDim.new(0, 8)

            local Lbl = Instance.new("TextLabel")
            Lbl.Size = UDim2.new(1, -24, 0, 45)
            Lbl.Position = UDim2.new(0, 15, 0, 0)
            Lbl.Text = CConfig.Name or "Colorpicker"
            Lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
            Lbl.Font = Enum.Font.GothamMedium
            Lbl.TextSize = 13
            Lbl.TextXAlignment = Enum.TextXAlignment.Left
            Lbl.BackgroundTransparency = 1
            Lbl.Parent = CFrame

            local ColorDisplay = Instance.new("Frame")
            ColorDisplay.Size = UDim2.new(0, 28, 0, 28)
            ColorDisplay.Position = UDim2.new(1, -40, 0, 8.5)
            ColorDisplay.BackgroundColor3 = CurrentColor
            ColorDisplay.Parent = CFrame
            Instance.new("UICorner", ColorDisplay).CornerRadius = UDim.new(0, 6)

            local CBtn = Instance.new("TextButton")
            CBtn.Size = UDim2.new(1, 0, 0, 45)
            CBtn.BackgroundTransparency = 1
            CBtn.Text = ""
            CBtn.Parent = CFrame

            local PickerContainer = Instance.new("Frame")
            PickerContainer.Size = UDim2.new(1, 0, 0, 120)
            PickerContainer.Position = UDim2.new(0, 0, 0, 45)
            PickerContainer.BackgroundTransparency = 1
            PickerContainer.Parent = CFrame

            local open = false
            CBtn.MouseButton1Click:Connect(function()
                open = not open
                TweenService:Create(CFrame, TweenInfo.new(0.2), {Size = open and UDim2.new(1, -10, 0, 165) or UDim2.new(1, -10, 0, 45)}):Play()
                self:UpdateCanvas()
            end)

            local SVBox = Instance.new("Frame")
            SVBox.Size = UDim2.new(1, -60, 0, 110)
            SVBox.Position = UDim2.new(0, 15, 0, 5)
            SVBox.BackgroundColor3 = Color3.fromHSV(0, 1, 1)
            SVBox.Parent = PickerContainer
            Instance.new("UICorner", SVBox).CornerRadius = UDim.new(0, 6)

            local WhiteOverlay = Instance.new("Frame")
            WhiteOverlay.Size = UDim2.new(1, 0, 1, 0)
            WhiteOverlay.Parent = SVBox
            Instance.new("UICorner", WhiteOverlay).CornerRadius = UDim.new(0, 6)
            local WhiteGrad = Instance.new("UIGradient", WhiteOverlay)
            WhiteGrad.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1)}

            local BlackOverlay = Instance.new("Frame")
            BlackOverlay.Size = UDim2.new(1, 0, 1, 0)
            BlackOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            BlackOverlay.Parent = SVBox
            Instance.new("UICorner", BlackOverlay).CornerRadius = UDim.new(0, 6)
            local BlackGrad = Instance.new("UIGradient", BlackOverlay)
            BlackGrad.Rotation = 90
            BlackGrad.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)}

            local SVIndicator = Instance.new("Frame")
            SVIndicator.Size = UDim2.new(0, 14, 0, 14)
            SVIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
            SVIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SVIndicator.BackgroundTransparency = 1 
            SVIndicator.Parent = SVBox
            Instance.new("UICorner", SVIndicator).CornerRadius = UDim.new(1, 0)
            local SVStroke = Instance.new("UIStroke", SVIndicator)
            SVStroke.Color = Color3.fromRGB(255, 255, 255)
            SVStroke.Thickness = 2

            local HueSlider = Instance.new("Frame")
            HueSlider.Size = UDim2.new(0, 16, 0, 110)
            HueSlider.Position = UDim2.new(1, -30, 0, 5)
            HueSlider.Parent = PickerContainer
            Instance.new("UICorner", HueSlider).CornerRadius = UDim.new(1, 0)

            local HueGradient = Instance.new("UIGradient", HueSlider)
            HueGradient.Rotation = 90
            HueGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
                ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
                ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
            }

            local HueIndicator = Instance.new("Frame")
            HueIndicator.Size = UDim2.new(0, 22, 0, 6)
            HueIndicator.Position = UDim2.new(0.5, -11, 0, 0)
            HueIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueIndicator.Parent = HueSlider
            Instance.new("UICorner", HueIndicator)

            local function UpdateColor(h, s, v)
                CurrentColor = Color3.fromHSV(h, s, v)
                ColorDisplay.BackgroundColor3 = CurrentColor
                SVBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                SVIndicator.Position = UDim2.new(s, 0, 1-v, 0)
                HueIndicator.Position = UDim2.new(0.5, -11, h, -3)
                if CConfig.Callback then task.spawn(CConfig.Callback, CurrentColor) end
            end

            local h, s, v = 0, 1, 1
            UpdateColor(h, s, v)

            local svDragging = false
            SVBox.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    svDragging = true
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    svDragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if svDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local mousePos = UserInputService:GetMouseLocation()
                    local boxPos = SVBox.AbsolutePosition
                    local boxSize = SVBox.AbsoluteSize
                    local localX = math.clamp((mousePos.X - boxPos.X) / boxSize.X, 0, 1)
                    local localY = math.clamp((mousePos.Y - boxPos.Y) / boxSize.Y, 0, 1)
                    s = localX
                    v = 1-localY
                    UpdateColor(h, s, v)
                end
            end)

            local hueDragging = false
            HueSlider.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    hueDragging = true
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    hueDragging = false
                end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if hueDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local mousePos = UserInputService:GetMouseLocation()
                    local sliderPos = HueSlider.AbsolutePosition.Y
                    local sliderSize = HueSlider.AbsoluteSize.Y
                    local localY = math.clamp((mousePos.Y - sliderPos) / sliderSize, 0, 1)
                    h = localY
                    UpdateColor(h, s, v)
                end
            end)
            return TabFunctions
        end

        return TabFunctions
    end

    return self
end

return VentyLib
