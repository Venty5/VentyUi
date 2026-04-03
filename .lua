--V3

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Library = {
    Elements = {},
    ThemeObjects = {},
    Connections = {},
    Flags = {},
    Themes = {
        Default = {
            Main = Color3.fromRGB(6, 8, 12),
            Second = Color3.fromRGB(10, 12, 18),
            Stroke = Color3.fromRGB(28, 35, 50),
            Divider = Color3.fromRGB(20, 25, 36),
            Text = Color3.fromRGB(230, 240, 255),
            TextDark = Color3.fromRGB(140, 155, 185),
            Accent = Color3.fromRGB(0, 120, 255),
            AccentDark = Color3.fromRGB(0, 90, 200),
            Card = Color3.fromRGB(14, 17, 26)
        }
    },
    SelectedTheme = "Default",
    Folder = nil,
    SaveCfg = false,
    Font = Enum.Font.Gotham
}

function Library:CleanupInstance()
    for _, instance in pairs(game:GetService("CoreGui"):GetChildren()) do
        if instance:IsA("ScreenGui") and instance.Name:match("^[A-Z]%d%d%d$") then
            instance:Destroy()
        end
    end
end

Library:CleanupInstance()
local Container = Instance.new("ScreenGui")
Container.Name = string.char(math.random(65, 90))..tostring(math.random(100, 999))
Container.DisplayOrder = 2147483647
Container.Parent = game:GetService("CoreGui")

function Library:IsRunning()
    return Container and Container.Parent == game:GetService("CoreGui")
end

local function AddConnection(Signal, Function)
    if (not Library:IsRunning()) then
        return
    end
    local SignalConnect = Signal:Connect(Function)
    table.insert(Library.Connections, SignalConnect)
    return SignalConnect
end

task.spawn(function()
    while (Library:IsRunning()) do
        wait()
    end
    for _, Connection in next, Library.Connections do
        Connection:Disconnect()
    end
end)

local function MakeDraggable(DragPoint, Main)
    local IsResizing = false
    pcall(function()
        local Dragging, DragInput, MousePos, FramePos = false
        DragPoint.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if not IsResizing then
                    Dragging = true
                    MousePos = Input.Position
                    FramePos = Main.Position
                end
                Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                    end
                end)
            end
        end)
        DragPoint.InputChanged:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                DragInput = Input
            end
        end)
        UserInputService.InputChanged:Connect(function(Input)
            if Input == DragInput and Dragging and not IsResizing then
                local Delta = Input.Position - MousePos
                TweenService:Create(Main, TweenInfo.new(0.65, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
                }):Play()
            end
        end)
    end)
    return function(resizing)
        IsResizing = resizing
        if resizing then
            Dragging = false
        end
    end
end

local function MakeResizable(ResizeButton, Main, MinSize, MaxSize, SetResizingCallback)
    pcall(function()
        local Resizing = false
        local StartSize, StartPos
        ResizeButton.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                Resizing = true
                if SetResizingCallback then SetResizingCallback(true) end
                StartSize = Main.Size
                StartPos = Vector2.new(Mouse.X, Mouse.Y)
            end
        end)
        ResizeButton.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                Resizing = false
                if SetResizingCallback then SetResizingCallback(false) end
            end
        end)
        UserInputService.InputChanged:Connect(function()
            if Resizing then
                local CurrentPos = Vector2.new(Mouse.X, Mouse.Y)
                local Delta = CurrentPos - StartPos
                local NewWidth = math.clamp(StartSize.X.Offset + Delta.X, MinSize.X, MaxSize.X)
                local NewHeight = math.clamp(StartSize.Y.Offset + Delta.Y, MinSize.Y, MaxSize.Y)
                Main.Size = UDim2.new(0, NewWidth, 0, NewHeight)
            end
        end)
    end)
end

local function Create(Name, Properties, Children)
    local Object = Instance.new(Name)
    for i, v in next, Properties or {} do
        Object[i] = v
    end
    for i, v in next, Children or {} do
        v.Parent = Object
    end
    return Object
end

local function CreateElement(ElementName, ElementFunction)
    Library.Elements[ElementName] = function(...)
        return ElementFunction(...)
    end
end

local function MakeElement(ElementName, ...)
    local NewElement = Library.Elements[ElementName](...)
    return NewElement
end

local function SetProps(Element, Props)
    table.foreach(Props, function(Property, Value)
        Element[Property] = Value
    end)
    return Element
end

local function SetChildren(Element, Children)
    table.foreach(Children, function(_, Child)
        Child.Parent = Element
    end)
    return Element
end

local function Round(Number, Factor)
    local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
    if Result < 0 then Result = Result + Factor end
    return Result
end

local function ReturnProperty(Object)
    if Object:IsA("Frame") or Object:IsA("TextButton") then
        return "BackgroundColor3"
    end
    if Object:IsA("ScrollingFrame") then
        return "ScrollBarImageColor3"
    end
    if Object:IsA("UIStroke") then
        return "Color"
    end
    if Object:IsA("TextLabel") or Object:IsA("TextBox") then
        return "TextColor3"
    end
    if Object:IsA("ImageLabel") or Object:IsA("ImageButton") then
        return "ImageColor3"
    end
end

local function AddThemeObject(Object, Type)
    if not Library.ThemeObjects[Type] then
        Library.ThemeObjects[Type] = {}
    end
    table.insert(Library.ThemeObjects[Type], Object)
    Object[ReturnProperty(Object)] = Library.Themes[Library.SelectedTheme][Type]
    return Object
end

local function SetTheme()
    for Name, Type in pairs(Library.ThemeObjects) do
        for _, Object in pairs(Type) do
            Object[ReturnProperty(Object)] = Library.Themes[Library.SelectedTheme][Name]
        end
    end
end

local function PackColor(Color)
    return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end

local function UnpackColor(Color)
    return Color3.fromRGB(Color.R, Color.G, Color.B)
end

local function LoadCfg(Config)
    local Data = HttpService:JSONDecode(Config)
    table.foreach(Data, function(a, b)
        if Library.Flags[a] then
            spawn(function()
                if Library.Flags[a].Type == "Colorpicker" then
                    Library.Flags[a]:Set(UnpackColor(b))
                else
                    Library.Flags[a]:Set(b)
                end
            end)
        else
            warn("Library Config Loader - Could not find ", a, b)
        end
    end)
end

local function SaveCfg(Name)
    local Data = {}
    for i, v in pairs(Library.Flags) do
        if v.Save then
            if v.Type == "Colorpicker" then
                Data[i] = PackColor(v.Value)
            else
                Data[i] = v.Value
            end
        end
    end
end

local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2, Enum.UserInputType.MouseButton3, Enum.UserInputType.Touch}
local BlacklistedKeys = {Enum.KeyCode.Unknown, Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D, Enum.KeyCode.Up, Enum.KeyCode.Left, Enum.KeyCode.Down, Enum.KeyCode.Right, Enum.KeyCode.Slash, Enum.KeyCode.Tab, Enum.KeyCode.Backspace, Enum.KeyCode.Escape}

local function CheckKey(Table, Key)
    for _, v in next, Table do
        if v == Key then return true end
    end
end

CreateElement("Corner", function(Scale, Offset)
    return Create("UICorner", {CornerRadius = UDim.new(Scale or 0, Offset or 8)})
end)

CreateElement("Stroke", function(Color, Thickness)
    return Create("UIStroke", {Color = Color or Color3.fromRGB(255, 255, 255), Thickness = Thickness or 1})
end)

CreateElement("List", function(Scale, Offset)
    return Create("UIListLayout", {SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(Scale or 0, Offset or 0)})
end)

CreateElement("Padding", function(Bottom, Left, Right, Top)
    return Create("UIPadding", {
        PaddingBottom = UDim.new(0, Bottom or 4),
        PaddingLeft = UDim.new(0, Left or 4),
        PaddingRight = UDim.new(0, Right or 4),
        PaddingTop = UDim.new(0, Top or 4)
    })
end)

CreateElement("TFrame", function()
    return Create("Frame", {BackgroundTransparency = 1})
end)

CreateElement("Frame", function(Color)
    return Create("Frame", {BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255), BorderSizePixel = 0})
end)

CreateElement("RoundFrame", function(Color, Scale, Offset)
    return Create("Frame", {
        BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
        BorderSizePixel = 0
    }, {
        Create("UICorner", {CornerRadius = UDim.new(Scale, Offset)})
    })
end)

CreateElement("Button", function()
    return Create("TextButton", {
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        BorderSizePixel = 0
    })
end)

CreateElement("ScrollFrame", function(Color, Width)
    return Create("ScrollingFrame", {
        BackgroundTransparency = 1,
        ScrollBarImageColor3 = Color,
        BorderSizePixel = 0,
        ScrollBarThickness = Width,
        CanvasSize = UDim2.new(0, 0, 0, 0)
    })
end)

CreateElement("Image", function(ImageID)
    return Create("ImageLabel", {Image = ImageID, BackgroundTransparency = 1})
end)

CreateElement("ImageButton", function(ImageID)
    return Create("ImageButton", {Image = ImageID, BackgroundTransparency = 1})
end)

CreateElement("Label", function(Text, TextSize, Transparency)
    return Create("TextLabel", {
        Text = Text or "",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextTransparency = Transparency or 0,
        TextSize = TextSize or 15,
        Font = Enum.Font.GothamSemibold,
        RichText = true,
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
end)

local NotificationHolder = SetProps(SetChildren(MakeElement("TFrame"), {
    SetProps(MakeElement("List"), {
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        VerticalAlignment = Enum.VerticalAlignment.Bottom,
        Padding = UDim.new(0, 5)
    })
}), {
    Position = UDim2.new(1, -25, 1, -25),
    Size = UDim2.new(0, 300, 1, -25),
    AnchorPoint = Vector2.new(1, 1),
    Parent = Container
})

function Library:MakeNotification(NotificationConfig)
    spawn(function()
        NotificationConfig.Name = NotificationConfig.Name or "Notification"
        NotificationConfig.Content = NotificationConfig.Content or "Test"
        NotificationConfig.Image = NotificationConfig.Image or "rbxassetid://4384403532"
        NotificationConfig.Time = NotificationConfig.Time or 15

        local NotificationParent = SetProps(MakeElement("TFrame"), {
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Parent = NotificationHolder
        })

        local NotificationFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(25, 25, 35), 0, 10), {
            Parent = NotificationParent,
            Size = UDim2.new(1, 0, 0, 0),
            Position = UDim2.new(1, -55, 0, 0),
            BackgroundTransparency = 0,
            AutomaticSize = Enum.AutomaticSize.Y
        }), {
            MakeElement("Stroke", Color3.fromRGB(50, 60, 80), 1.2),
            MakeElement("Padding", 12, 12, 12, 12),
            SetProps(MakeElement("Image", NotificationConfig.Image), {
                Size = UDim2.new(0, 20, 0, 20),
                ImageColor3 = Library.Themes.Default.Accent,
                Name = "Icon"
            }),
            SetProps(MakeElement("Label", NotificationConfig.Name, 15), {
                Size = UDim2.new(1, -30, 0, 20),
                Position = UDim2.new(0, 30, 0, 0),
                Font = Enum.Font.FredokaOne,
                Name = "Title"
            }),
            SetProps(MakeElement("Label", NotificationConfig.Content, 14), {
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 25),
                Font = Enum.Font.FredokaOne,
                Name = "Content",
                AutomaticSize = Enum.AutomaticSize.Y,
                TextColor3 = Color3.fromRGB(200, 210, 230),
                TextWrapped = true
            })
        })
        TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        wait(NotificationConfig.Time - 0.88)
        TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
        TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.6}):Play()
        wait(0.3)
        TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0.9}):Play()
        TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
        TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
        wait(0.05)
        NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0), 'In', 'Quint', 0.8, true)
        wait(1.35)
        NotificationFrame:Destroy()
    end)
end

function Library:Init()
    if Library.SaveCfg then
        pcall(function()
            if isfile(Library.Folder .. "/" .. game.GameId .. ".txt") then
                LoadCfg(readfile(Library.Folder .. "/" .. game.GameId .. ".txt"))
                Library:MakeNotification({
                    Name = "Configuration",
                    Content = "Auto-loaded configuration for the game " .. game.GameId .. ".",
                    Time = 5
                })
            end
        end)
    end
end

function Library:MakeWindow(WindowConfig)
    local FirstTab = true
    local Minimized = false
    local Loaded = false
    local UIHidden = false

    WindowConfig = WindowConfig or {}
    WindowConfig.Name = WindowConfig.Name or "Venty Hub"
    WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
    WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
    WindowConfig.HidePremium = WindowConfig.HidePremium or false
    WindowConfig.IntroEnabled = WindowConfig.IntroEnabled == nil and true or WindowConfig.IntroEnabled
    WindowConfig.IntroToggleIcon = WindowConfig.IntroToggleIcon or "rbxassetid://125829575723612"
    WindowConfig.IntroText = WindowConfig.IntroText or "Launching Venty"
    WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
    WindowConfig.ShowIcon = WindowConfig.ShowIcon or false
    WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://125829575723612"
    WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://125829575723612"
    Library.Folder = WindowConfig.ConfigFolder
    Library.SaveCfg = WindowConfig.SaveConfig

    if WindowConfig.SaveConfig then
        if not isfolder(WindowConfig.ConfigFolder) then
            makefolder(WindowConfig.ConfigFolder)
        end
    end

    -- Linke Icon-Leiste
    local IconBar = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {
        Size = UDim2.new(0, 70, 1, -50),
        Position = UDim2.new(0, 0, 0, 50),
        BackgroundTransparency = 0
    }), {
        MakeElement("List", 0, 8),
        MakeElement("Padding", 12, 0, 0, 12)
    }), "Second")

    AddConnection(IconBar.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        IconBar.CanvasSize = UDim2.new(0, 0, 0, IconBar.UIListLayout.AbsoluteContentSize.Y + 16)
    end)

    -- Hauptbereich für Sections (volle Breite ohne RightPanel)
    local MainArea = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
        Size = UDim2.new(1, -80, 1, -50),
        Position = UDim2.new(0, 80, 0, 50),
        BackgroundTransparency = 0
    }), {
        MakeElement("List", 0, 12),
        MakeElement("Padding", 16, 16, 16, 16)
    }), "Second")

    AddConnection(MainArea.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
        MainArea.CanvasSize = UDim2.new(0, 0, 0, MainArea.UIListLayout.AbsoluteContentSize.Y + 30)
    end)

    -- Header Buttons
    local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {
        Size = UDim2.new(0.33, 0, 1, 0),
        Position = UDim2.new(0.66, 0, 0, 0),
        BackgroundTransparency = 1
    }), {
        AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), {
            Position = UDim2.new(0, 9, 0, 6),
            Size = UDim2.new(0, 18, 0, 18)
        }), "Text")
    })

    local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {
        Size = UDim2.new(0.33, 0, 1, 0),
        Position = UDim2.new(0.33, 0, 0, 0),
        BackgroundTransparency = 1
    }), {
        AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), {
            Position = UDim2.new(0, 9, 0, 6),
            Size = UDim2.new(0, 18, 0, 18),
            Name = "Ico"
        }), "Text")
    })

    local ResizeBtn = SetChildren(SetProps(MakeElement("Button"), {
        Size = UDim2.new(0.33, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1
    }), {
        AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://117273761878755"), {
            Position = UDim2.new(0, 9, 0, 6),
            Size = UDim2.new(0, 18, 0, 18)
        }), "Text")
    })

    local DragPoint = SetProps(MakeElement("TFrame"), {
        Size = UDim2.new(1, 0, 0, 50)
    })

    local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), {
        Size = UDim2.new(1, -30, 2, 0),
        Position = UDim2.new(0, 25, 0, -24),
        Font = Enum.Font.GothamBlack,
        TextSize = 20
    }), "Text")

    local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 1, -1)
    }), "Stroke")

    local TopBar = SetProps(MakeElement("TFrame"), {
        Size = UDim2.new(1, 0, 0, 50),
        Name = "TopBar",
        ClipsDescendants = false
    })

    local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
        Parent = Container,
        Position = UDim2.new(0.5, -450, 0.5, -350),
        Size = UDim2.new(0, 900, 0, 700),
        ClipsDescendants = true,
        BackgroundTransparency = 0
    }), {
        SetChildren(TopBar, {
            WindowName,
            WindowTopBarLine,
            AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
                Size = UDim2.new(0, 105, 0, 30),
                Position = UDim2.new(1, -125, 0, 10)
            }), {
                AddThemeObject(MakeElement("Stroke"), "Stroke"),
                AddThemeObject(SetProps(MakeElement("Frame"), {
                    Size = UDim2.new(0, 1, 1, 0),
                    Position = UDim2.new(0.33, 0, 0, 0)
                }), "Stroke"),
                AddThemeObject(SetProps(MakeElement("Frame"), {
                    Size = UDim2.new(0, 1, 1, 0),
                    Position = UDim2.new(0.66, 0, 0, 0)
                }), "Stroke"),
                ResizeBtn,
                MinimizeBtn,
                CloseBtn
            }), "Second"),
        }),
        DragPoint,
        IconBar,
        MainArea
    }), "Main")

    if WindowConfig.ShowIcon then
        WindowName.Position = UDim2.new(0, 60, 0, -24)
        local WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), {
            Size = UDim2.new(0, 30, 0, 30),
            Position = UDim2.new(0, 20, 0, 10)
        })
        WindowIcon.Parent = TopBar
    end

    local SetResizingCallback = MakeDraggable(DragPoint, MainWindow)
    MakeResizable(ResizeBtn, MainWindow, Vector2.new(700, 500), Vector2.new(1400, 900), SetResizingCallback)

    local MobileReopenButton = SetChildren(SetProps(MakeElement("Button"), {
        Parent = Container,
        Size = UDim2.new(0, 40, 0, 40),
        Position = UDim2.new(0.5, -20, 0, 20),
        BackgroundTransparency = 0,
        BackgroundColor3 = Library.Themes[Library.SelectedTheme].Main,
        Visible = false
    }), {
        AddThemeObject(SetProps(MakeElement("Image", WindowConfig.IntroToggleIcon or "http://www.roblox.com/asset/?id=8834748103"), {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.5, 0),
            Size = UDim2.new(0.7, 0, 0.7, 0),
        }), "Text"),
        MakeElement("Corner", 1)
    })

    AddConnection(CloseBtn.MouseButton1Up, function()
        MainWindow.Visible = false
        if UserInputService.TouchEnabled then
            MobileReopenButton.Visible = true
        end
        UIHidden = true
        Library:MakeNotification({
            Name = "Interface Hidden",
            Content = UserInputService.TouchEnabled and "Tap the button or Left Control to reopen" or "Press Left Control to reopen",
            Time = 5
        })
        WindowConfig.CloseCallback()
    end)

    AddConnection(UserInputService.InputBegan, function(Input)
        if Input.KeyCode == Enum.KeyCode.LeftControl and UIHidden == true then
            MainWindow.Visible = true
            MobileReopenButton.Visible = false
        end
    end)

    AddConnection(MobileReopenButton.Activated, function()
        MainWindow.Visible = true
        MobileReopenButton.Visible = false
    end)

    AddConnection(MinimizeBtn.MouseButton1Up, function()
        if Minimized then
            TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 900, 0, 700)}):Play()
            MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
            wait(.02)
            MainWindow.ClipsDescendants = false
            IconBar.Visible = true
            MainArea.Visible = true
            WindowTopBarLine.Visible = true
        else
            MainWindow.ClipsDescendants = true
            WindowTopBarLine.Visible = false
            MinimizeBtn.Ico.Image = "rbxassetid://7072720870"
            TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
            wait(0.1)
            IconBar.Visible = false
            MainArea.Visible = false
        end
        Minimized = not Minimized
    end)

    local function LoadSequence()
        MainWindow.Visible = false
        local LoadSequenceLogo = SetProps(MakeElement("Image", WindowConfig.IntroIcon), {
            Parent = Container,
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 0, 0.4, 0),
            Size = UDim2.new(0, 28, 0, 28),
            ImageColor3 = Library.Themes.Default.Accent,
            ImageTransparency = 1
        })
        local LoadSequenceText = SetProps(MakeElement("Label", WindowConfig.IntroText, 14), {
            Parent = Container,
            Size = UDim2.new(1, 0, 1, 0),
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.new(0.5, 19, 0.5, 0),
            TextXAlignment = Enum.TextXAlignment.Center,
            Font = Enum.Font.GothamBold,
            TextTransparency = 1
        })
        TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0, Position = UDim2.new(0.5, 0, 0.5, 0)}):Play()
        wait(0.8)
        TweenService:Create(LoadSequenceLogo, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, -(LoadSequenceText.TextBounds.X/2), 0.5, 0)}):Play()
        wait(0.3)
        TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
        wait(2)
        TweenService:Create(LoadSequenceText, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 1}):Play()
        MainWindow.Visible = true
        LoadSequenceLogo:Destroy()
        LoadSequenceText:Destroy()
    end

    if WindowConfig.IntroEnabled then
        LoadSequence()
    end

    local TabFunction = {}
    local sectionContainers = {}

    function TabFunction:MakeTab(TabConfig)
        TabConfig = TabConfig or {}
        TabConfig.Name = TabConfig.Name or "Tab"
        TabConfig.Icon = TabConfig.Icon or ""
        TabConfig.PremiumOnly = TabConfig.PremiumOnly or false

        local TabButton = SetChildren(SetProps(MakeElement("Button"), {
            Size = UDim2.new(0, 44, 0, 44),
            Parent = IconBar,
            BackgroundTransparency = 1
        }), {
            AddThemeObject(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
                Size = UDim2.new(1, 0, 1, 0),
                BackgroundTransparency = 0.01
            }), "Second"),
            AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {
                AnchorPoint = Vector2.new(0.5, 0.5),
                Size = UDim2.new(0, 24, 0, 24),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                ImageTransparency = 0.4,
                Name = "Ico"
            }), "Text"),
            AddThemeObject(MakeElement("Stroke"), "Stroke")
        })

        local TabContainer = SetProps(MakeElement("TFrame"), {
            Parent = MainArea,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Visible = false,
            Name = TabConfig.Name
        })

        sectionContainers[TabConfig.Name] = TabContainer

        local sectionList = SetChildren(SetProps(MakeElement("TFrame"), {
            Parent = TabContainer,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y
        }), {
            MakeElement("List", 0, 12)
        })

        if FirstTab then
            FirstTab = false
            TabButton.Ico.ImageTransparency = 0
            TabButton.BackgroundColor3 = Library.Themes.Default.Accent
            TabButton.UIStroke.Color = Library.Themes.Default.Accent
            TabButton.Ico.ImageColor3 = Color3.fromRGB(255, 255, 255)
            TabContainer.Visible = true
        end

        AddConnection(TabButton.MouseButton1Click, function()
            for _, btn in next, IconBar:GetChildren() do
                if btn:IsA("TextButton") then
                    TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                        BackgroundColor3 = Library.Themes.Default.Second
                    }):Play()
                    if btn:FindFirstChildWhichIsA("UIStroke") then
                        TweenService:Create(btn.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            Color = Library.Themes.Default.Stroke
                        }):Play()
                    end
                    if btn:FindFirstChild("Ico") then
                        TweenService:Create(btn.Ico, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                            ImageTransparency = 0.4,
                            ImageColor3 = Library.Themes.Default.Text
                        }):Play()
                    end
                end
            end
            for name, container in pairs(sectionContainers) do
                container.Visible = false
            end
            TweenService:Create(TabButton, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                BackgroundColor3 = Library.Themes.Default.Accent
            }):Play()
            if TabButton:FindFirstChildWhichIsA("UIStroke") then
                TweenService:Create(TabButton.UIStroke, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                    Color = Library.Themes.Default.Accent
                }):Play()
            end
            TweenService:Create(TabButton.Ico, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                ImageTransparency = 0,
                ImageColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            TabContainer.Visible = true
        end)

        local function GetElements(ItemParent)
            local ElementFunction = {}

            function ElementFunction:AddSection(SectionConfig)
                SectionConfig = SectionConfig or {}
                SectionConfig.Name = SectionConfig.Name or "Section"

                local SectionContent = SetChildren(SetProps(MakeElement("TFrame"), {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Name = "Content"
                }), {
                    MakeElement("List", 0, 8),
                    MakeElement("Padding", 12, 16, 16, 12)
                })

                local SectionCard = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 12), {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 0,
                    Parent = ItemParent
                }), {
                    SetChildren(SetProps(MakeElement("TFrame"), {
                        Size = UDim2.new(1, 0, 0, 40),
                        Name = "Header"
                    }), {
                        AddThemeObject(SetProps(MakeElement("Frame"), {
                            Size = UDim2.new(0, 3, 0, 20),
                            Position = UDim2.new(0, 12, 0.5, 0),
                            AnchorPoint = Vector2.new(0, 0.5)
                        }), "Accent"),
                        AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 16), {
                            Size = UDim2.new(1, -30, 1, 0),
                            Position = UDim2.new(0, 25, 0, 0),
                            Font = Enum.Font.GothamBold
                        }), "Text")
                    }),
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                    SectionContent
                }), "Card")

                local SectionFunction = {}
                for i, v in next, GetElements(SectionContent) do
                    SectionFunction[i] = v
                end
                return SectionFunction
            end

            function ElementFunction:AddLabel(Text)
                local LabelContent = AddThemeObject(SetProps(MakeElement("Label", Text, 14), {
                    Size = UDim2.new(1, -24, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Position = UDim2.new(0, 12, 0, 0),
                    Font = Enum.Font.GothamMedium,
                    TextWrapped = true,
                    Name = "Content"
                }), "Text")

                local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 6), {
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 0,
                    Parent = ItemParent
                }), {
                    MakeElement("Padding", 10, 12, 12, 10),
                    LabelContent,
                    AddThemeObject(MakeElement("Stroke"), "Stroke")
                }), "Card")

                local LabelFunction = {}
                function LabelFunction:Set(ToChange)
                    LabelContent.Text = ToChange
                end
                return LabelFunction
            end

            function ElementFunction:AddButton(ButtonConfig)
                ButtonConfig = ButtonConfig or {}
                ButtonConfig.Name = ButtonConfig.Name or "Button"
                ButtonConfig.Callback = ButtonConfig.Callback or function() end

                local Click = SetProps(MakeElement("Button"), {Size = UDim2.new(1, 0, 1, 0)})

                local ButtonAccentLine = Instance.new("Frame")
                ButtonAccentLine.Size = UDim2.new(0, 3, 0, 18)
                ButtonAccentLine.Position = UDim2.new(0, 0, 0.5, 0)
                ButtonAccentLine.AnchorPoint = Vector2.new(0, 0.5)
                ButtonAccentLine.BackgroundColor3 = Library.Themes.Default.Accent
                ButtonAccentLine.BorderSizePixel = 0
                local _btnCorner = Instance.new("UICorner")
                _btnCorner.CornerRadius = UDim.new(0, 2)
                _btnCorner.Parent = ButtonAccentLine

                local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 38),
                    Parent = ItemParent,
                    BackgroundTransparency = 0
                }), {
                    ButtonAccentLine,
                    AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 14), {
                        Size = UDim2.new(1, -40, 1, 0),
                        Position = UDim2.new(0, 18, 0, 0),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content"
                    }), "Text"),
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                    Click
                }), "Card")

                AddConnection(Click.MouseEnter, function()
                    TweenService:Create(ButtonFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(22, 26, 38)}):Play()
                end)
                AddConnection(Click.MouseLeave, function()
                    TweenService:Create(ButtonFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Library.Themes.Default.Card}):Play()
                end)
                AddConnection(Click.MouseButton1Up, function()
                    TweenService:Create(ButtonFrame, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(20, 24, 36)}):Play()
                    spawn(function()
                        ButtonConfig.Callback()
                    end)
                end)

                function ButtonFrame:Set(ButtonText)
                    ButtonFrame.Content.Text = ButtonText
                end
                return ButtonFrame
            end

            function ElementFunction:AddToggle(ToggleConfig)
                ToggleConfig = ToggleConfig or {}
                ToggleConfig.Name = ToggleConfig.Name or "Toggle"
                ToggleConfig.Default = ToggleConfig.Default or false
                ToggleConfig.Callback = ToggleConfig.Callback or function() end
                ToggleConfig.Color = ToggleConfig.Color or Library.Themes.Default.Accent
                ToggleConfig.Flag = ToggleConfig.Flag or nil
                ToggleConfig.Save = ToggleConfig.Save or false

                local Toggle = {Value = ToggleConfig.Default, Save = ToggleConfig.Save}
                local Click = SetProps(MakeElement("Button"), {Size = UDim2.new(1, 0, 1, 0)})

                local ToggleTrack = Instance.new("Frame")
                ToggleTrack.Size = UDim2.new(0, 40, 0, 22)
                ToggleTrack.Position = UDim2.new(1, -52, 0.5, 0)
                ToggleTrack.AnchorPoint = Vector2.new(0, 0.5)
                ToggleTrack.BackgroundColor3 = Color3.fromRGB(30, 34, 48)
                ToggleTrack.BorderSizePixel = 0
                local _trackCorner = Instance.new("UICorner")
                _trackCorner.CornerRadius = UDim.new(1, 0)
                _trackCorner.Parent = ToggleTrack

                local ToggleThumb = Instance.new("Frame")
                ToggleThumb.Size = UDim2.new(0, 16, 0, 16)
                ToggleThumb.Position = UDim2.new(0, 3, 0.5, 0)
                ToggleThumb.AnchorPoint = Vector2.new(0, 0.5)
                ToggleThumb.BackgroundColor3 = Color3.fromRGB(180, 190, 210)
                ToggleThumb.BorderSizePixel = 0
                local _thumbCorner = Instance.new("UICorner")
                _thumbCorner.CornerRadius = UDim.new(1, 0)
                _thumbCorner.Parent = ToggleThumb
                ToggleThumb.Parent = ToggleTrack

                local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 44),
                    Parent = ItemParent,
                    BackgroundTransparency = 0
                }), {
                    AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 14), {
                        Size = UDim2.new(1, -70, 1, 0),
                        Position = UDim2.new(0, 16, 0, 0),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content"
                    }), "Text"),
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                    ToggleTrack,
                    Click
                }), "Card")

                function Toggle:Set(Value)
                    Toggle.Value = Value
                    if Toggle.Value then
                        TweenService:Create(ToggleTrack, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = ToggleConfig.Color}):Play()
                        TweenService:Create(ToggleThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 21, 0.5, 0), BackgroundColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                    else
                        TweenService:Create(ToggleTrack, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(30, 34, 48)}):Play()
                        TweenService:Create(ToggleThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 3, 0.5, 0), BackgroundColor3 = Color3.fromRGB(180, 190, 210)}):Play()
                    end
                    ToggleConfig.Callback(Toggle.Value)
                end

                Toggle:Set(Toggle.Value)

                AddConnection(Click.MouseButton1Up, function()
                    Toggle:Set(not Toggle.Value)
                    SaveCfg(game.GameId)
                end)

                if ToggleConfig.Flag then
                    Library.Flags[ToggleConfig.Flag] = Toggle
                end
                return Toggle
            end

            function ElementFunction:AddSlider(SliderConfig)
                SliderConfig = SliderConfig or {}
                SliderConfig.Name = SliderConfig.Name or "Slider"
                SliderConfig.Min = SliderConfig.Min or 0
                SliderConfig.Max = SliderConfig.Max or 100
                SliderConfig.Increment = SliderConfig.Increment or 1
                SliderConfig.Default = SliderConfig.Default or 50
                SliderConfig.Callback = SliderConfig.Callback or function() end
                SliderConfig.ValueName = SliderConfig.ValueName or ""
                SliderConfig.Color = SliderConfig.Color or Library.Themes.Default.Accent

                local Slider = {Value = SliderConfig.Default}
                local Dragging = false

                local SliderDrag = SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 6), {
                    Size = UDim2.new(0, 0, 1, 0),
                    BackgroundTransparency = 0,
                    ZIndex = 2
                })

                local SliderBar = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(30, 34, 48), 0, 6), {
                    Size = UDim2.new(1, -32, 0, 6),
                    Position = UDim2.new(0, 16, 0, 32),
                    BackgroundTransparency = 0,
                    ClipsDescendants = true
                }), {SliderDrag})

                local SliderValueLabel = AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
                    Size = UDim2.new(1, -32, 0, 14),
                    Position = UDim2.new(0, 16, 0, 18),
                    Font = Enum.Font.GothamMedium,
                    Name = "Value",
                    TextXAlignment = Enum.TextXAlignment.Right
                }), "TextDark")

                local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 56),
                    Parent = ItemParent,
                    BackgroundTransparency = 0
                }), {
                    AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 14), {
                        Size = UDim2.new(1, -100, 0, 14),
                        Position = UDim2.new(0, 16, 0, 10),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content"
                    }), "Text"),
                    SliderValueLabel,
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                    SliderBar
                }), "Card")

                SliderBar.InputBegan:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = true end
                end)
                SliderBar.InputEnded:Connect(function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end
                end)
                UserInputService.InputChanged:Connect(function(Input)
                    if Dragging then
                        local SizeScale = math.clamp((Mouse.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        Slider:Set(SliderConfig.Min + ((SliderConfig.Max - SliderConfig.Min) * SizeScale))
                        SaveCfg(game.GameId)
                    end
                end)

                function Slider:Set(Value)
                    self.Value = math.clamp(Round(Value, SliderConfig.Increment), SliderConfig.Min, SliderConfig.Max)
                    TweenService:Create(SliderDrag, TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.fromScale((self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1)}):Play()
                    SliderValueLabel.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
                    SliderConfig.Callback(self.Value)
                end

                Slider:Set(Slider.Value)
                if SliderConfig.Flag then Library.Flags[SliderConfig.Flag] = Slider end
                return Slider
            end

            function ElementFunction:AddDropdown(DropdownConfig)
                DropdownConfig = DropdownConfig or {}
                DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
                DropdownConfig.Options = DropdownConfig.Options or {}
                DropdownConfig.Default = DropdownConfig.Default or ""

                local Dropdown = {Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, Toggled = false}

                if not table.find(Dropdown.Options, Dropdown.Value) then
                    Dropdown.Value = "..."
                end

                local DropdownList = MakeElement("List")
                local DropdownContainer = SetProps(MakeElement("ScrollFrame", Color3.fromRGB(80, 90, 120), 4), {
                    Parent = nil,
                    Position = UDim2.new(0, 0, 0, 44),
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    ClipsDescendants = true,
                    Visible = false
                })
                DropdownList.Parent = DropdownContainer

                local Click = SetProps(MakeElement("Button"), {Size = UDim2.new(1, 0, 1, 0)})

                local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 44),
                    Parent = ItemParent,
                    BackgroundTransparency = 0,
                    ClipsDescendants = true,
                    AutomaticSize = Enum.AutomaticSize.Y
                }), {
                    DropdownContainer,
                    SetProps(SetChildren(MakeElement("TFrame"), {
                        AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 14), {
                            Size = UDim2.new(1, -80, 1, 0),
                            Position = UDim2.new(0, 16, 0, 0),
                            Font = Enum.Font.GothamMedium,
                            Name = "Content"
                        }), "Text"),
                        AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
                            Size = UDim2.new(0, 16, 0, 16),
                            AnchorPoint = Vector2.new(0, 0.5),
                            Position = UDim2.new(1, -16, 0.5, 0),
                            Name = "Ico"
                        }), "TextDark"),
                        AddThemeObject(SetProps(MakeElement("Label", "", 13), {
                            Size = UDim2.new(0, 100, 1, 0),
                            Position = UDim2.new(1, -120, 0, 0),
                            Font = Enum.Font.GothamMedium,
                            Name = "Selected",
                            TextXAlignment = Enum.TextXAlignment.Right
                        }), "TextDark"),
                        Click
                    }), {
                        Size = UDim2.new(1, 0, 0, 44),
                        Name = "F"
                    }),
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                }), "Card")

                AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                    DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
                    DropdownFrame.Size = UDim2.new(1, 0, 0, 44 + DropdownList.AbsoluteContentSize.Y)
                end)

                local function AddOptions(Options)
                    for _, Option in pairs(Options) do
                        local OptionBtn = AddThemeObject(SetChildren(SetProps(MakeElement("Button"), {
                            Parent = DropdownContainer,
                            Size = UDim2.new(1, 0, 0, 32),
                            BackgroundTransparency = 1
                        }), {
                            AddThemeObject(SetProps(MakeElement("Label", Option, 13), {
                                Position = UDim2.new(0, 12, 0, 0),
                                Size = UDim2.new(1, -12, 1, 0),
                                Font = Enum.Font.GothamMedium,
                                Name = "Title"
                            }), "Text")
                        }), "Card")

                        AddConnection(OptionBtn.MouseButton1Click, function()
                            Dropdown:Set(Option)
                            Dropdown.Toggled = false
                            DropdownContainer.Visible = false
                            DropdownFrame.F.Ico.Rotation = 0
                            DropdownFrame.Size = UDim2.new(1, 0, 0, 44)
                            SaveCfg(game.GameId)
                        end)
                        Dropdown.Buttons[Option] = OptionBtn
                    end
                end

                function Dropdown:Set(Value)
                    if not table.find(Dropdown.Options, Value) then
                        Dropdown.Value = "..."
                        DropdownFrame.F.Selected.Text = Dropdown.Value
                        return
                    end
                    Dropdown.Value = Value
                    DropdownFrame.F.Selected.Text = Dropdown.Value
                    DropdownConfig.Callback(Dropdown.Value)
                end

                AddConnection(Click.MouseButton1Click, function()
                    Dropdown.Toggled = not Dropdown.Toggled
                    DropdownContainer.Visible = Dropdown.Toggled
                    TweenService:Create(DropdownFrame.F.Ico, TweenInfo.new(.15), {Rotation = Dropdown.Toggled and 180 or 0}):Play()
                    if Dropdown.Toggled then
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 44 + DropdownList.AbsoluteContentSize.Y)
                    else
                        DropdownFrame.Size = UDim2.new(1, 0, 0, 44)
                    end
                end)

                AddOptions(Dropdown.Options)
                Dropdown:Set(Dropdown.Value)
                if DropdownConfig.Flag then Library.Flags[DropdownConfig.Flag] = Dropdown end
                return Dropdown
            end

            function ElementFunction:AddBind(BindConfig)
                BindConfig = BindConfig or {}
                BindConfig.Name = BindConfig.Name or "Bind"
                BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
                BindConfig.Hold = BindConfig.Hold or false
                BindConfig.Callback = BindConfig.Callback or function() end

                local Bind = {Value = BindConfig.Default, Binding = false}
                local Holding = false
                local Click = SetProps(MakeElement("Button"), {Size = UDim2.new(1, 0, 1, 0)})

                local BindBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 6), {
                    Size = UDim2.new(0, 80, 0, 28),
                    Position = UDim2.new(1, -16, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5)
                }), {
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                    AddThemeObject(SetProps(MakeElement("Label", "", 13), {
                        Size = UDim2.new(1, 0, 1, 0),
                        Font = Enum.Font.GothamMedium,
                        TextXAlignment = Enum.TextXAlignment.Center,
                        Name = "Value"
                    }), "Text")
                }), "Card")

                local BindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 44),
                    Parent = ItemParent,
                    BackgroundTransparency = 0
                }), {
                    AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 14), {
                        Size = UDim2.new(1, -100, 1, 0),
                        Position = UDim2.new(0, 16, 0, 0),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content"
                    }), "Text"),
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                    BindBox,
                    Click
                }), "Card")

                AddConnection(Click.InputEnded, function(Input)
                    if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if Bind.Binding then return end
                        Bind.Binding = true
                        BindBox.Value.Text = "..."
                    end
                end)

                AddConnection(UserInputService.InputBegan, function(Input)
                    if UserInputService:GetFocusedTextBox() then return end
                    if (Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value) and not Bind.Binding then
                        if BindConfig.Hold then
                            Holding = true
                            BindConfig.Callback(Holding)
                        else
                            BindConfig.Callback()
                        end
                    elseif Bind.Binding then
                        local Key
                        pcall(function()
                            if not CheckKey(BlacklistedKeys, Input.KeyCode) then
                                Key = Input.KeyCode
                            end
                        end)
                        pcall(function()
                            if CheckKey(WhitelistedMouse, Input.UserInputType) and not Key then
                                Key = Input.UserInputType
                            end
                        end)
                        Key = Key or Bind.Value
                        Bind:Set(Key)
                        SaveCfg(game.GameId)
                    end
                end)

                AddConnection(UserInputService.InputEnded, function(Input)
                    if Input.KeyCode.Name == Bind.Value or Input.UserInputType.Name == Bind.Value then
                        if BindConfig.Hold and Holding then
                            Holding = false
                            BindConfig.Callback(Holding)
                        end
                    end
                end)

                function Bind:Set(Key)
                    Bind.Binding = false
                    Bind.Value = Key or Bind.Value
                    Bind.Value = Bind.Value.Name or Bind.Value
                    BindBox.Value.Text = string.upper(Bind.Value)
                end

                Bind:Set(BindConfig.Default)
                if BindConfig.Flag then Library.Flags[BindConfig.Flag] = Bind end
                return Bind
            end

            function ElementFunction:AddTextbox(TextboxConfig)
                TextboxConfig = TextboxConfig or {}
                TextboxConfig.Name = TextboxConfig.Name or "Textbox"
                TextboxConfig.Default = TextboxConfig.Default or ""
                TextboxConfig.Callback = TextboxConfig.Callback or function() end

                local Click = SetProps(MakeElement("Button"), {Size = UDim2.new(1, 0, 1, 0)})
                local TextboxActual = AddThemeObject(Create("TextBox", {
                    Size = UDim2.new(1, 0, 1, 0),
                    BackgroundTransparency = 1,
                    TextColor3 = Color3.fromRGB(255, 255, 255),
                    PlaceholderColor3 = Color3.fromRGB(140, 150, 180),
                    PlaceholderText = "Enter text...",
                    Font = Enum.Font.GothamMedium,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    TextSize = 13,
                    ClearTextOnFocus = false
                }), "Text")

                local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 6), {
                    Size = UDim2.new(0, 100, 0, 28),
                    Position = UDim2.new(1, -16, 0.5, 0),
                    AnchorPoint = Vector2.new(1, 0.5)
                }), {
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                    TextboxActual
                }), "Card")

                local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                    Size = UDim2.new(1, 0, 0, 44),
                    Parent = ItemParent,
                    BackgroundTransparency = 0
                }), {
                    AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 14), {
                        Size = UDim2.new(1, -120, 1, 0),
                        Position = UDim2.new(0, 16, 0, 0),
                        Font = Enum.Font.GothamMedium,
                        Name = "Content"
                    }), "Text"),
                    AddThemeObject(MakeElement("Stroke"), "Stroke"),
                    TextContainer,
                    Click
                }), "Card")

                AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function()
                    TextContainer.Size = UDim2.new(0, math.max(80, TextboxActual.TextBounds.X + 20), 0, 28)
                end)
                AddConnection(TextboxActual.FocusLost, function()
                    TextboxConfig.Callback(TextboxActual.Text)
                end)

                TextboxActual.Text = TextboxConfig.Default
                TextContainer.Size = UDim2.new(0, math.max(80, TextboxActual.TextBounds.X + 20), 0, 28)

                AddConnection(Click.MouseButton1Up, function()
                    TextboxActual:CaptureFocus()
                end)
            end

            return ElementFunction
        end

        local ElementFunction = {}
        for i, v in next, GetElements(sectionList) do
            ElementFunction[i] = v
        end

        return ElementFunction
    end

    return TabFunction
end

function Library:Destroy()
    Container:Destroy()
end

return Library
