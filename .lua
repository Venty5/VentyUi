local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local VentyLib = {}
local UI_NAME = "Venty_UI_Instance"

local isDraggingSlider = false 
local isPickingColor = false 

function VentyLib:CreateWindow(options)
    local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    if playerGui:FindFirstChild(UI_NAME) then playerGui[UI_NAME]:Destroy() end

    local windowName = options.Name or "Venty"
    local introText = options.Intro or "Loading Venty..."
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = UI_NAME
    ScreenGui.Parent = playerGui
    ScreenGui.ResetOnSpawn = false

    local LoadingFrame = Instance.new("Frame")
    LoadingFrame.Size = UDim2.new(0, 250, 0, 250)
    LoadingFrame.Position = UDim2.new(0.5, -125, 0.5, -125)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    LoadingFrame.ZIndex = 500
    LoadingFrame.Parent = ScreenGui
    Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 15)

    local L_Text = Instance.new("TextLabel")
    L_Text.Size = UDim2.new(1, 0, 0, 30)
    L_Text.Position = UDim2.new(0, 0, 0.45, 0)
    L_Text.BackgroundTransparency = 1
    L_Text.Text = introText
    L_Text.TextColor3 = Color3.fromRGB(255, 255, 255)
    L_Text.Font = Enum.Font.GothamBold
    L_Text.TextSize = 16
    L_Text.ZIndex = 501
    L_Text.Parent = LoadingFrame

    local BarBack = Instance.new("Frame")
    BarBack.Size = UDim2.new(0, 150, 0, 4)
    BarBack.Position = UDim2.new(0.5, -75, 0.6, 0)
    BarBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    BarBack.ZIndex = 501
    BarBack.Parent = LoadingFrame
    Instance.new("UICorner", BarBack)

    local BarFill = Instance.new("Frame")
    BarFill.Size = UDim2.new(0, 0, 1, 0)
    BarFill.BackgroundColor3 = Color3.fromRGB(0, 122, 255)
    BarFill.ZIndex = 502
    BarFill.Parent = BarBack
    Instance.new("UICorner", BarFill)

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 340, 0, 420)
    MainFrame.Position = UDim2.new(0, 20, 0, 20) 
    MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

    local WindowTitle = Instance.new("TextLabel")
    WindowTitle.Size = UDim2.new(0, 200, 0, 30)
    WindowTitle.Position = UDim2.new(0, 15, 0, 10)
    WindowTitle.BackgroundTransparency = 1
    WindowTitle.Text = windowName
    WindowTitle.TextColor3 = Color3.fromRGB(120, 120, 120)
    WindowTitle.Font = Enum.Font.Gotham
    WindowTitle.TextSize = 12
    WindowTitle.TextXAlignment = Enum.TextXAlignment.Left
    WindowTitle.Parent = MainFrame

    local CurrentTabLabel = Instance.new("TextLabel")
    CurrentTabLabel.Size = UDim2.new(1, 0, 0, 30)
    CurrentTabLabel.Position = UDim2.new(0, 0, 0, 35)
    CurrentTabLabel.BackgroundTransparency = 1
    CurrentTabLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    CurrentTabLabel.Font = Enum.Font.GothamBold
    CurrentTabLabel.TextSize = 16
    CurrentTabLabel.Parent = MainFrame

    local TabBar = Instance.new("ScrollingFrame")
    TabBar.Size = UDim2.new(1, 0, 0, 35)
    TabBar.Position = UDim2.new(0, 0, 0, 70)
    TabBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
    TabBar.BorderSizePixel = 0
    TabBar.ScrollBarThickness = 0
    TabBar.Parent = MainFrame

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabBar
    TabListLayout.FillDirection = Enum.FillDirection.Horizontal
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 20)
    Instance.new("UIPadding", TabBar).PaddingLeft = UDim.new(0, 15)

    TabListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        TabBar.CanvasSize = UDim2.new(0, TabListLayout.AbsoluteContentSize.X + 30, 0, 0)
    end)

    local PageContainer = Instance.new("Frame")
    PageContainer.Size = UDim2.new(1, -30, 1, -150)
    PageContainer.Position = UDim2.new(0, 15, 0, 115)
    PageContainer.BackgroundTransparency = 1
    PageContainer.Parent = MainFrame

    task.spawn(function()
        for i = 0, 100, 2 do BarFill.Size = UDim2.new(i/100, 0, 1, 0) task.wait(0.01) end
        LoadingFrame:Destroy()
        MainFrame.Visible = true
    end)

    local Window = {}
    local tabsCount = 0

    function Window:AddTab(tabOptions)
        tabsCount = tabsCount + 1
        local tabName = tabOptions.Name or "Tab"
        
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.Visible = (tabsCount == 1)
        TabPage.ScrollBarThickness = 0
        TabPage.ClipsDescendants = true
        TabPage.Parent = PageContainer

        local TabList = Instance.new("UIListLayout")
        TabList.Parent = TabPage
        TabList.Padding = UDim.new(0, 8)
        TabList.SortOrder = Enum.SortOrder.LayoutOrder

        TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabPage.CanvasSize = UDim2.new(0, 0, 0, TabList.AbsoluteContentSize.Y + 10)
        end)

        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(0, 0, 1, 0)
        TabButton.AutomaticSize = Enum.AutomaticSize.X
        TabButton.BackgroundTransparency = 1
        TabButton.Text = tabName:upper()
        TabButton.TextColor3 = (tabsCount == 1) and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(120, 120, 120)
        TabButton.Font = Enum.Font.GothamBold
        TabButton.TextSize = 11
        TabButton.Parent = TabBar

        if tabsCount == 1 then CurrentTabLabel.Text = tabName end

        TabButton.MouseButton1Click:Connect(function()
            for _, p in pairs(PageContainer:GetChildren()) do if p:IsA("ScrollingFrame") then p.Visible = false end end
            for _, b in pairs(TabBar:GetChildren()) do if b:IsA("TextButton") then b.TextColor3 = Color3.fromRGB(120, 120, 120) end end
            TabPage.Visible = true
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            CurrentTabLabel.Text = tabName
        end)

        local TabObj = {}
        local elementOrder = 0

        function TabObj:AddToggle(tglOptions)
            elementOrder = elementOrder + 1
            local enabled = tglOptions.Default or false
            
            local TglBtn = Instance.new("TextButton")
            TglBtn.Size = UDim2.new(1, 0, 0, 40)
            TglBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            TglBtn.Text = ""
            TglBtn.LayoutOrder = elementOrder
            TglBtn.Parent = TabPage
            Instance.new("UICorner", TglBtn).CornerRadius = UDim.new(0, 6)

            local TglLabel = Instance.new("TextLabel")
            TglLabel.Size = UDim2.new(1, -60, 1, 0)
            TglLabel.Position = UDim2.new(0, 12, 0, 0)
            TglLabel.BackgroundTransparency = 1
            TglLabel.Text = tglOptions.Name
            TglLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            TglLabel.Font = Enum.Font.GothamBold
            TglLabel.TextSize = 13
            TglLabel.TextXAlignment = Enum.TextXAlignment.Left
            TglLabel.Parent = TglBtn

            local TglFrame = Instance.new("Frame")
            TglFrame.Size = UDim2.new(0, 34, 0, 18)
            TglFrame.Position = UDim2.new(1, -46, 0.5, -9)
            TglFrame.BackgroundColor3 = enabled and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(30, 30, 30)
            TglFrame.Parent = TglBtn
            Instance.new("UICorner", TglFrame).CornerRadius = UDim.new(1, 0)

            local TglDot = Instance.new("Frame")
            TglDot.Size = UDim2.new(0, 12, 0, 12)
            TglDot.Position = enabled and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
            TglDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TglDot.Parent = TglFrame
            Instance.new("UICorner", TglDot).CornerRadius = UDim.new(1, 0)

            TglBtn.MouseButton1Click:Connect(function()
                enabled = not enabled
                local targetPos = enabled and UDim2.new(1, -15, 0.5, -6) or UDim2.new(0, 3, 0.5, -6)
                local targetCol = enabled and Color3.fromRGB(0, 122, 255) or Color3.fromRGB(30, 30, 30)
                TweenService:Create(TglDot, TweenInfo.new(0.2), {Position = targetPos}):Play()
                TweenService:Create(TglFrame, TweenInfo.new(0.2), {BackgroundColor3 = targetCol}):Play()
                if tglOptions.Callback then tglOptions.Callback(enabled) end
            end)
        end

        function TabObj:AddDropdown(ddOptions)
            elementOrder = elementOrder + 1
            local expanded = false
            local options = ddOptions.Options or {}
            
            local DdMain = Instance.new("Frame")
            DdMain.Size = UDim2.new(1, 0, 0, 40)
            DdMain.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            DdMain.LayoutOrder = elementOrder
            DdMain.ClipsDescendants = true
            DdMain.Parent = TabPage
            Instance.new("UICorner", DdMain).CornerRadius = UDim.new(0, 6)

            local DdBtn = Instance.new("TextButton")
            DdBtn.Size = UDim2.new(1, 0, 0, 40)
            DdBtn.BackgroundTransparency = 1
            DdBtn.Text = ""
            DdBtn.Parent = DdMain

            local DdLabel = Instance.new("TextLabel")
            DdLabel.Size = UDim2.new(1, -40, 0, 40)
            DdLabel.Position = UDim2.new(0, 12, 0, 0)
            DdLabel.BackgroundTransparency = 1
            DdLabel.Text = ddOptions.Name .. " : " .. (ddOptions.Default or "None")
            DdLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            DdLabel.Font = Enum.Font.GothamBold
            DdLabel.TextSize = 13
            DdLabel.TextXAlignment = Enum.TextXAlignment.Left
            DdLabel.Parent = DdMain

            local DdContainer = Instance.new("Frame")
            DdContainer.Size = UDim2.new(1, -20, 0, #options * 30)
            DdContainer.Position = UDim2.new(0, 10, 0, 40)
            DdContainer.BackgroundTransparency = 1
            DdContainer.Parent = DdMain
            
            local DdList = Instance.new("UIListLayout")
            DdList.Parent = DdContainer

            for _, opt in pairs(options) do
                local OptBtn = Instance.new("TextButton")
                OptBtn.Size = UDim2.new(1, 0, 0, 30)
                OptBtn.BackgroundTransparency = 1
                OptBtn.Text = opt
                OptBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
                OptBtn.Font = Enum.Font.Gotham
                OptBtn.TextSize = 12
                OptBtn.Parent = DdContainer
                
                OptBtn.MouseButton1Click:Connect(function()
                    DdLabel.Text = ddOptions.Name .. " : " .. opt
                    expanded = false
                    TweenService:Create(DdMain, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                    if ddOptions.Callback then ddOptions.Callback(opt) end
                end)
            end

            DdBtn.MouseButton1Click:Connect(function()
                expanded = not expanded
                local targetSize = expanded and UDim2.new(1, 0, 0, 45 + (#options * 30)) or UDim2.new(1, 0, 0, 40)
                TweenService:Create(DdMain, TweenInfo.new(0.3), {Size = targetSize}):Play()
            end)
        end

        function TabObj:AddBind(bindOptions)
            elementOrder = elementOrder + 1
            local currentKey = bindOptions.Default or Enum.KeyCode.F
            local listening = false

            local BindBtn = Instance.new("TextButton")
            BindBtn.Size = UDim2.new(1, 0, 0, 40)
            BindBtn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            BindBtn.Text = ""
            BindBtn.LayoutOrder = elementOrder
            BindBtn.Parent = TabPage
            Instance.new("UICorner", BindBtn).CornerRadius = UDim.new(0, 6)

            local BindLabel = Instance.new("TextLabel")
            BindLabel.Size = UDim2.new(1, -100, 1, 0)
            BindLabel.Position = UDim2.new(0, 12, 0, 0)
            BindLabel.BackgroundTransparency = 1
            BindLabel.Text = bindOptions.Name
            BindLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            BindLabel.Font = Enum.Font.GothamBold
            BindLabel.TextSize = 13
            BindLabel.TextXAlignment = Enum.TextXAlignment.Left
            BindLabel.Parent = BindBtn

            local KeyLabel = Instance.new("TextLabel")
            KeyLabel.Size = UDim2.new(0, 70, 0, 24)
            KeyLabel.Position = UDim2.new(1, -82, 0.5, -12)
            KeyLabel.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            KeyLabel.Text = currentKey.Name
            KeyLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            KeyLabel.Font = Enum.Font.GothamBold
            KeyLabel.TextSize = 11
            KeyLabel.Parent = BindBtn
            Instance.new("UICorner", KeyLabel).CornerRadius = UDim.new(0, 4)

            BindBtn.MouseButton1Click:Connect(function()
                listening = true
                KeyLabel.Text = "..."
            end)

            UserInputService.InputBegan:Connect(function(input)
                if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                    currentKey = input.KeyCode
                    KeyLabel.Text = currentKey.Name
                    listening = false
                    if bindOptions.Callback then bindOptions.Callback(currentKey) end
                elseif not listening and input.KeyCode == currentKey then
                    if bindOptions.Callback then bindOptions.Callback(currentKey) end
                end
            end)
        end

        TabObj.Addbind = TabObj.AddBind

        function TabObj:AddSection(secOptions)
            elementOrder = elementOrder + 1
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Size = UDim2.new(1, 0, 0, 30)
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.LayoutOrder = elementOrder
            SectionFrame.Parent = TabPage

            local ColorLine = Instance.new("Frame")
            ColorLine.Size = UDim2.new(0, 2, 0, 14)
            ColorLine.Position = UDim2.new(0, 2, 0.5, -2)
            ColorLine.BackgroundColor3 = secOptions.Color or Color3.fromRGB(255, 255, 255)
            ColorLine.BorderSizePixel = 0
            ColorLine.Parent = SectionFrame

            local SecLabel = Instance.new("TextLabel")
            SecLabel.Size = UDim2.new(1, -15, 1, 0)
            SecLabel.Position = UDim2.new(0, 12, 0, 5)
            SecLabel.BackgroundTransparency = 1
            SecLabel.Text = secOptions.Name
            SecLabel.TextColor3 = secOptions.Color or Color3.fromRGB(255, 255, 255)
            SecLabel.Font = Enum.Font.GothamBold
            SecLabel.TextSize = 12
            SecLabel.TextXAlignment = Enum.TextXAlignment.Left
            SecLabel.Parent = SectionFrame
        end

        function TabObj:AddSlider(sldOptions)
            elementOrder = elementOrder + 1
            local min = sldOptions.Minimal or 0
            local max = sldOptions.Maximum or 100
            local default = sldOptions.Default or min
            
            local SliderFrame = Instance.new("Frame")
            SliderFrame.Size = UDim2.new(1, 0, 0, 65)
            SliderFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            SliderFrame.LayoutOrder = elementOrder
            SliderFrame.Parent = TabPage
            Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 6)

            local SldLabel = Instance.new("TextLabel")
            SldLabel.Size = UDim2.new(1, -24, 0, 25)
            SldLabel.Position = UDim2.new(0, 12, 0, 8)
            SldLabel.BackgroundTransparency = 1
            SldLabel.Text = sldOptions.Name
            SldLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            SldLabel.Font = Enum.Font.GothamBold
            SldLabel.TextSize = 14
            SldLabel.TextXAlignment = Enum.TextXAlignment.Left
            SldLabel.Parent = SliderFrame

            local ValLabel = Instance.new("TextLabel")
            ValLabel.Size = UDim2.new(0, 80, 0, 25)
            ValLabel.Position = UDim2.new(1, -92, 0, 8)
            ValLabel.BackgroundTransparency = 1
            ValLabel.Text = tostring(default) .. (sldOptions.Increment or "")
            ValLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
            ValLabel.Font = Enum.Font.GothamBold
            ValLabel.TextSize = 13
            ValLabel.TextXAlignment = Enum.TextXAlignment.Right
            ValLabel.Parent = SliderFrame

            local SliderBack = Instance.new("Frame")
            SliderBack.Size = UDim2.new(1, -24, 0, 18)
            SliderBack.Position = UDim2.new(0, 12, 0, 38)
            SliderBack.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
            SliderBack.Parent = SliderFrame
            Instance.new("UICorner", SliderBack).CornerRadius = UDim.new(0, 6)

            local SliderFill = Instance.new("Frame")
            SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            SliderFill.BackgroundColor3 = Color3.fromRGB(120, 125, 130)
            SliderFill.Parent = SliderBack
            Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(0, 6)

            local function updateSlider(input)
                local pos = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
                local value = math.floor(((max - min) * pos) + min)
                SliderFill.Size = UDim2.new(pos, 0, 1, 0)
                ValLabel.Text = tostring(value) .. (sldOptions.Increment or "")
                if sldOptions.Callback then sldOptions.Callback(value) end
            end

            SliderFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                    isDraggingSlider = true
                    local move; move = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input) end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                            isDraggingSlider = false
                            move:Disconnect() 
                        end
                    end)
                    updateSlider(input)
                end
            end)
        end

        function TabObj:AddButton(btnOptions)
            elementOrder = elementOrder + 1
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, 0, 0, 40)
            Btn.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            Btn.Text = ""
            Btn.LayoutOrder = elementOrder
            Btn.Parent = TabPage
            Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

            local BtnLabel = Instance.new("TextLabel")
            BtnLabel.Size = UDim2.new(0.7, 0, 1, 0)
            BtnLabel.Position = UDim2.new(0, 12, 0, 0)
            BtnLabel.BackgroundTransparency = 1
            BtnLabel.Text = btnOptions.Name
            BtnLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
            BtnLabel.Font = Enum.Font.GothamBold
            BtnLabel.TextSize = 13
            BtnLabel.TextXAlignment = Enum.TextXAlignment.Left
            BtnLabel.Parent = Btn

            Btn.MouseButton1Click:Connect(btnOptions.Callback)
        end

        function TabObj:AddColopick(cpOptions)
            elementOrder = elementOrder + 1
            local defaultColor = cpOptions.Default or Color3.fromRGB(255, 255, 255)
            local h, s, v = defaultColor:ToHSV()

            local PickerMain = Instance.new("Frame")
            PickerMain.Size = UDim2.new(1, 0, 0, 100)
            PickerMain.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            PickerMain.LayoutOrder = elementOrder
            PickerMain.Parent = TabPage
            Instance.new("UICorner", PickerMain).CornerRadius = UDim.new(0, 6)

            local Title = Instance.new("TextLabel")
            Title.Size = UDim2.new(0.6, 0, 0, 35)
            Title.Position = UDim2.new(0, 12, 0, 0)
            Title.BackgroundTransparency = 1
            Title.Text = cpOptions.Name
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.Font = Enum.Font.GothamBold
            Title.TextSize = 13
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Parent = PickerMain

            local Preview = Instance.new("Frame")
            Preview.Size = UDim2.new(0, 18, 0, 18)
            Preview.Position = UDim2.new(1, -30, 0, 8)
            Preview.BackgroundColor3 = defaultColor
            Preview.Parent = PickerMain
            Instance.new("UICorner", Preview).CornerRadius = UDim.new(0, 4)

            local SatFrame = Instance.new("ImageLabel")
            SatFrame.Size = UDim2.new(1, -55, 0, 50)
            SatFrame.Position = UDim2.new(0, 12, 0, 38)
            SatFrame.Image = "rbxassetid://4155801252"
            SatFrame.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
            SatFrame.Parent = PickerMain
            Instance.new("UICorner", SatFrame).CornerRadius = UDim.new(0, 4)

            local SatCursor = Instance.new("Frame")
            SatCursor.Size = UDim2.new(0, 6, 0, 6)
            SatCursor.Position = UDim2.new(s, -3, 1-v, -3)
            SatCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SatCursor.BorderSizePixel = 1
            SatCursor.BorderColor3 = Color3.fromRGB(0,0,0)
            SatCursor.Parent = SatFrame
            Instance.new("UICorner", SatCursor).CornerRadius = UDim.new(1, 0)

            local HueFrame = Instance.new("ImageLabel")
            HueFrame.Size = UDim2.new(0, 15, 0, 50)
            HueFrame.Position = UDim2.new(1, -30, 0, 38)
            HueFrame.Image = "rbxassetid://3641079629"
            HueFrame.Parent = PickerMain
            Instance.new("UICorner", HueFrame).CornerRadius = UDim.new(0, 4)

            local HueCursor = Instance.new("Frame")
            HueCursor.Size = UDim2.new(1, 4, 0, 2)
            HueCursor.Position = UDim2.new(0.5, -2, 1-h, 0)
            HueCursor.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueCursor.BorderSizePixel = 1
            HueCursor.BorderColor3 = Color3.fromRGB(0,0,0)
            HueCursor.Parent = HueFrame

            local function update()
                local color = Color3.fromHSV(h, s, v)
                Preview.BackgroundColor3 = color
                SatFrame.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                if cpOptions.Callback then cpOptions.Callback(color) end
            end

            SatFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isPickingColor = true
                    local move; move = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            s = math.clamp((input.Position.X - SatFrame.AbsolutePosition.X) / SatFrame.AbsoluteSize.X, 0, 1)
                            v = 1 - math.clamp((input.Position.Y - SatFrame.AbsolutePosition.Y) / SatFrame.AbsoluteSize.Y, 0, 1)
                            SatCursor.Position = UDim2.new(s, -3, 1-v, -3)
                            update()
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                            isPickingColor = false
                            move:Disconnect() 
                        end
                    end)
                end
            end)

            HueFrame.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    isPickingColor = true
                    local move; move = UserInputService.InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            h = 1 - math.clamp((input.Position.Y - HueFrame.AbsolutePosition.Y) / HueFrame.AbsoluteSize.Y, 0, 1)
                            HueCursor.Position = UDim2.new(0.5, -2, 1-h, 0)
                            update()
                        end
                    end)
                    UserInputService.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then 
                            isPickingColor = false
                            move:Disconnect() 
                        end
                    end)
                end
            end)
        end

        return TabObj
    end

    return Window
end

return VentyLib
