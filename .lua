local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local VentyLib = {
    Tabs = {},
    CurrentTabIndex = 0,
    Gui = nil,
    MainFrame = nil,
    Visible = true,
    OpenBind = Enum.KeyCode.F1, 
    IsListening = false 
}

function VentyLib:CreateWindow(Config)
    local WindowName = Config.Name or "Venty UI"
    local UserTrans = Config.BackgroundTransparency or 0
    local ActualTrans = math.clamp(UserTrans, 0, 1)

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "VentyLib_UI"
    ScreenGui.Parent = (RunService:IsStudio() and game.Players.LocalPlayer:WaitForChild("PlayerGui") or game:GetService("CoreGui"))
    ScreenGui.ResetOnSpawn = false
    self.Gui = ScreenGui

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 350, 0, 450) 
    MainFrame.Position = UDim2.new(0, 10, 0, 10)
    MainFrame.AnchorPoint = Vector2.new(0, 0)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.BackgroundTransparency = ActualTrans
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true
    MainFrame.Parent = ScreenGui
    self.MainFrame = MainFrame

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
    local Stroke = Instance.new("UIStroke", MainFrame)
    Stroke.Thickness = 1
    Stroke.Color = Color3.fromRGB(40, 40, 40)
    Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    local HeaderLayout = Instance.new("UIListLayout", MainFrame)
    HeaderLayout.SortOrder = Enum.SortOrder.LayoutOrder
    HeaderLayout.Padding = UDim.new(0, 8)

    local TitleFrame = Instance.new("Frame")
    TitleFrame.Size = UDim2.new(1, 0, 0, 35)
    TitleFrame.BackgroundTransparency = 1
    TitleFrame.LayoutOrder = 1
    TitleFrame.Parent = MainFrame

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, 15, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = WindowName
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = TitleFrame

    local MinButton = Instance.new("TextButton")
    MinButton.Name = "MinButton"
    MinButton.Size = UDim2.new(0, 25, 0, 25)
    MinButton.Position = UDim2.new(1, -35, 0.5, -12)
    MinButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MinButton.Text = "-"
    MinButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinButton.Font = Enum.Font.GothamBold
    MinButton.TextSize = 18
    MinButton.Parent = TitleFrame
    Instance.new("UICorner", MinButton).CornerRadius = UDim.new(0, 4)

    local BannerContainer = Instance.new("Frame")
    BannerContainer.Size = UDim2.new(1, 0, 0, 0)
    BannerContainer.BackgroundTransparency = 1
    BannerContainer.LayoutOrder = 2
    BannerContainer.Parent = MainFrame

    local TabHolder = Instance.new("Frame")
    TabHolder.Size = UDim2.new(1, 0, 0, 35)
    TabHolder.BackgroundTransparency = 1
    TabHolder.LayoutOrder = 3
    TabHolder.Parent = MainFrame
    local TabListLayout = Instance.new("UIListLayout", TabHolder)
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.Padding = UDim.new(0, 15)
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    Instance.new("UIPadding", TabHolder).PaddingLeft = UDim.new(0, 15)

    local ContainerHolder = Instance.new("Frame")
    ContainerHolder.Size = UDim2.new(1, -20, 1, -130)
    ContainerHolder.BackgroundTransparency = 1
    ContainerHolder.LayoutOrder = 4
    ContainerHolder.Parent = MainFrame
    Instance.new("UIPadding", ContainerHolder).PaddingLeft = UDim.new(0, 15)

    local IsMinimized = false
    local FullSize = UDim2.new(0, 350, 0, 450)
    local MinSize = UDim2.new(0, 350, 0, 35)

    MinButton.MouseButton1Click:Connect(function()
        IsMinimized = not IsMinimized
        MinButton.Text = IsMinimized and "+" or "-"
        local TargetSize = IsMinimized and MinSize or FullSize
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = TargetSize}):Play()

        BannerContainer.Visible = not IsMinimized
        TabHolder.Visible = not IsMinimized
        ContainerHolder.Visible = not IsMinimized
    end)

    UserInputService.InputBegan:Connect(function(input, gp)
        if not gp and not self.IsListening and self.OpenBind and input.KeyCode == self.OpenBind then
            self.Visible = not self.Visible
            MainFrame.Visible = self.Visible
        end
    end)

    function self:AddBanner(BConfig)
        BannerContainer.Size = UDim2.new(1, 0, 0, 65)
        local BannerImg = Instance.new("ImageLabel")
        BannerImg.Size = UDim2.new(1, -30, 1, 0)
        BannerImg.Position = UDim2.new(0, 15, 0, 0)
        BannerImg.BackgroundTransparency = 1
        BannerImg.Image = BConfig.Icon
        BannerImg.ScaleType = Enum.ScaleType.Fit
        BannerImg.Parent = BannerContainer
    end

    function self:AddTab(TConfig)
        local TabColor = TConfig.Color or Color3.fromRGB(255, 255, 255)
        local Container = Instance.new("ScrollingFrame")
        Container.Size = UDim2.new(1, 0, 1, 0)
        Container.BackgroundTransparency = 1
        Container.Visible = false
        Container.BorderSizePixel = 0
        Container.ScrollBarThickness = 0
        Container.Parent = ContainerHolder

        local UIList = Instance.new("UIListLayout", Container)
        UIList.Padding = UDim.new(0, 6)
        UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Container.CanvasSize = UDim2.new(0, 0, 0, UIList.AbsoluteContentSize.Y + 10)
        end)

        local TabBtn = Instance.new("TextButton")
        TabBtn.Size = UDim2.new(0, 65, 1, 0)
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = TConfig.Name
        TabBtn.Font = Enum.Font.GothamBold
        TabBtn.TextSize = 13
        TabBtn.TextColor3 = Color3.fromRGB(130, 130, 130)
        TabBtn.Parent = TabHolder

        local Indicator = Instance.new("Frame")
        Indicator.Size = UDim2.new(1, 0, 0, 2)
        Indicator.Position = UDim2.new(0, 0, 1, -2)
        Indicator.BackgroundColor3 = TabColor
        Indicator.BorderSizePixel = 0
        Indicator.BackgroundTransparency = 1
        Indicator.Parent = TabBtn

        table.insert(VentyLib.Tabs, {Button = TabBtn, Container = Container, Indicator = Indicator})
        local tabIndex = #VentyLib.Tabs
        TabBtn.MouseButton1Click:Connect(function() VentyLib:SelectTab(tabIndex) end)

        local TabFunctions = {}
        
        function TabFunctions:AddToggle(TConfig)
            local Toggled = TConfig.Default or false
            local ToggleColor = TConfig.Color or Color3.fromRGB(76, 217, 100)
            local ToggleBtn = Instance.new("TextButton")
            ToggleBtn.Size = UDim2.new(1, -5, 0, 38)
            ToggleBtn.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            ToggleBtn.Text = ""
            ToggleBtn.AutoButtonColor = false
            ToggleBtn.Parent = Container
            Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)

            local Label = Instance.new("TextLabel", ToggleBtn)
            Label.Size = UDim2.new(1, -60, 1, 0)
            Label.Position = UDim2.new(0, 12, 0, 0)
            Label.BackgroundTransparency = 1
            Label.Text = TConfig.Name
            Label.TextColor3 = Color3.fromRGB(220, 220, 220)
            Label.Font = Enum.Font.Gotham
            Label.TextSize = 13
            Label.TextXAlignment = Enum.TextXAlignment.Left

            local Switch = Instance.new("Frame", ToggleBtn)
            Switch.Size = UDim2.new(0, 36, 0, 20)
            Switch.Position = UDim2.new(1, -48, 0.5, -10)
            Switch.BackgroundColor3 = Toggled and ToggleColor or Color3.fromRGB(60, 60, 60)
            Instance.new("UICorner", Switch).CornerRadius = UDim.new(1, 0)

            local Dot = Instance.new("Frame", Switch)
            Dot.Size = UDim2.new(0, 16, 0, 16)
            Dot.Position = Toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
            Dot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Instance.new("UICorner", Dot).CornerRadius = UDim.new(1, 0)

            ToggleBtn.MouseButton1Click:Connect(function()
                Toggled = not Toggled
                TweenService:Create(Dot, TweenInfo.new(0.25), {Position = Toggled and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
                TweenService:Create(Switch, TweenInfo.new(0.2), {BackgroundColor3 = Toggled and ToggleColor or Color3.fromRGB(60, 60, 60)}):Play()
                TConfig.Callback(Toggled)
            end)
            return TabFunctions
        end

        function TabFunctions:AddSlider(SConfig)
            local Min, Max, Def = SConfig.Minimal or 0, SConfig.Maximum or 100, SConfig.Default or 0
            local SliderColor = SConfig.Color or Color3.fromRGB(0, 150, 255)
            
            local SliderHolder = Instance.new("Frame")
            SliderHolder.Size = UDim2.new(1, -5, 0, 42)
            SliderHolder.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            SliderHolder.Parent = Container
            Instance.new("UICorner", SliderHolder).CornerRadius = UDim.new(0, 6)

            local SliderLabel = Instance.new("TextLabel", SliderHolder)
            SliderLabel.Size = UDim2.new(1, -20, 0, 18)
            SliderLabel.Position = UDim2.new(0, 12, 0, 4)
            SliderLabel.BackgroundTransparency = 1
            SliderLabel.Text = SConfig.Name
            SliderLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            SliderLabel.Font = Enum.Font.GothamBold
            SliderLabel.TextSize = 13
            SliderLabel.TextXAlignment = Enum.TextXAlignment.Left

            local ValueLabel = Instance.new("TextLabel", SliderHolder)
            ValueLabel.Size = UDim2.new(0, 60, 0, 18)
            ValueLabel.Position = UDim2.new(1, -72, 0, 4)
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Text = tostring(Def) .. (SConfig.Increment or "")
            ValueLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            ValueLabel.Font = Enum.Font.Gotham
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

            local SliderBarBG = Instance.new("TextButton", SliderHolder)
            SliderBarBG.Size = UDim2.new(1, -24, 0, 12)
            SliderBarBG.Position = UDim2.new(0, 12, 0, 24)
            SliderBarBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            SliderBarBG.Text = ""
            SliderBarBG.AutoButtonColor = false
            Instance.new("UICorner", SliderBarBG).CornerRadius = UDim.new(1, 0)

            local SliderBarFill = Instance.new("Frame", SliderBarBG)
            SliderBarFill.Size = UDim2.new((Def - Min) / (Max - Min), 0, 1, 0)
            SliderBarFill.BackgroundColor3 = SliderColor
            SliderBarFill.BorderSizePixel = 0
            Instance.new("UICorner", SliderBarFill).CornerRadius = UDim.new(1, 0)

            local function UpdateSlider(input)
                local pos = math.clamp((input.Position.X - SliderBarBG.AbsolutePosition.X) / SliderBarBG.AbsoluteSize.X, 0, 1)
                local val = math.floor(Min + (Max - Min) * pos)
                SliderBarFill.Size = UDim2.new(pos, 0, 1, 0)
                ValueLabel.Text = tostring(val) .. (SConfig.Increment or "")
                SConfig.Callback(val)
            end

            local Dragging = false
            SliderBarBG.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = true UpdateSlider(input) end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then UpdateSlider(input) end
            end)
            return TabFunctions
        end

        if #VentyLib.Tabs == 1 then
            task.spawn(function() VentyLib:SelectTab(1) end)
        end
        return TabFunctions
    end

    return self
end

function VentyLib:SelectTab(index)
    self.CurrentTabIndex = index
    for i, tab in ipairs(self.Tabs) do
        local isSelected = (i == index)
        tab.Container.Visible = isSelected
        TweenService:Create(tab.Button, TweenInfo.new(0.2), {
            TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(130, 130, 130)
        }):Play()
        TweenService:Create(tab.Indicator, TweenInfo.new(0.2), {
            BackgroundTransparency = isSelected and 0 or 1
        }):Play()
    end
end

return VentyLib
