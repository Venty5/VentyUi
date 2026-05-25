local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local Library = {
        Elements = {},
        ThemeObjects = {},
        FontObjects = {},
        Connections = {},
        Flags = {},
        Themes = {
                Dark = {
                        Main = Color3.fromRGB(5, 5, 5),
                        Second = Color3.fromRGB(12, 12, 12),
                        Stroke = Color3.fromRGB(40, 40, 40),
                        Divider = Color3.fromRGB(40, 40, 40),
                        Text = Color3.fromRGB(240, 240, 240),
                        TextDark = Color3.fromRGB(150, 150, 150),
                        Accent = Color3.fromRGB(203, 213, 217)
                },
                Light = {
                        Main = Color3.fromRGB(235, 235, 240),
                        Second = Color3.fromRGB(248, 248, 252),
                        Stroke = Color3.fromRGB(200, 200, 210),
                        Divider = Color3.fromRGB(200, 200, 210),
                        Text = Color3.fromRGB(30, 30, 35),
                        TextDark = Color3.fromRGB(100, 100, 115),
                        Accent = Color3.fromRGB(160, 130, 255)
                },
                Midnight = {
                        Main = Color3.fromRGB(15, 15, 25),
                        Second = Color3.fromRGB(25, 25, 40),
                        Stroke = Color3.fromRGB(60, 60, 90),
                        Divider = Color3.fromRGB(60, 60, 90),
                        Text = Color3.fromRGB(230, 230, 255),
                        TextDark = Color3.fromRGB(140, 140, 180),
                        Accent = Color3.fromRGB(100, 80, 255)
                },
                Crimson = {
                        Main = Color3.fromRGB(30, 15, 15),
                        Second = Color3.fromRGB(45, 20, 20),
                        Stroke = Color3.fromRGB(90, 50, 50),
                        Divider = Color3.fromRGB(90, 50, 50),
                        Text = Color3.fromRGB(255, 230, 230),
                        TextDark = Color3.fromRGB(180, 140, 140),
                        Accent = Color3.fromRGB(255, 60, 60)
                },
                Forest = {
                        Main = Color3.fromRGB(15, 25, 15),
                        Second = Color3.fromRGB(20, 35, 20),
                        Stroke = Color3.fromRGB(50, 80, 50),
                        Divider = Color3.fromRGB(50, 80, 50),
                        Text = Color3.fromRGB(230, 255, 230),
                        TextDark = Color3.fromRGB(140, 180, 140),
                        Accent = Color3.fromRGB(60, 200, 100)
                },
                Ocean = {
                        Main = Color3.fromRGB(8, 14, 20),
                        Second = Color3.fromRGB(12, 24, 36),
                        Stroke = Color3.fromRGB(30, 90, 140),
                        Divider = Color3.fromRGB(15, 45, 70),
                        Text = Color3.fromRGB(210, 235, 255),
                        TextDark = Color3.fromRGB(100, 170, 220),
                        Accent = Color3.fromRGB(50, 150, 200)
                },
                Gold = {
                        Main = Color3.fromRGB(15, 12, 5),
                        Second = Color3.fromRGB(28, 22, 8),
                        Stroke = Color3.fromRGB(160, 120, 30),
                        Divider = Color3.fromRGB(60, 45, 10),
                        Text = Color3.fromRGB(255, 245, 200),
                        TextDark = Color3.fromRGB(210, 175, 90),
                        Accent = Color3.fromRGB(220, 180, 50)
                },
                Purple = {
                        Main = Color3.fromRGB(14, 8, 20),
                        Second = Color3.fromRGB(28, 16, 40),
                        Stroke = Color3.fromRGB(120, 60, 200),
                        Divider = Color3.fromRGB(50, 25, 80),
                        Text = Color3.fromRGB(245, 230, 255),
                        TextDark = Color3.fromRGB(180, 140, 220),
                        Accent = Color3.fromRGB(160, 100, 255)
                },
                Cyan = {
                        Main = Color3.fromRGB(5, 16, 20),
                        Second = Color3.fromRGB(10, 30, 38),
                        Stroke = Color3.fromRGB(40, 170, 200),
                        Divider = Color3.fromRGB(20, 60, 75),
                        Text = Color3.fromRGB(220, 250, 255),
                        TextDark = Color3.fromRGB(120, 200, 220),
                        Accent = Color3.fromRGB(50, 200, 230)
                },
                Pink = {
                        Main = Color3.fromRGB(20, 10, 18),
                        Second = Color3.fromRGB(38, 18, 32),
                        Stroke = Color3.fromRGB(220, 80, 160),
                        Divider = Color3.fromRGB(75, 25, 60),
                        Text = Color3.fromRGB(255, 230, 245),
                        TextDark = Color3.fromRGB(220, 140, 190),
                        Accent = Color3.fromRGB(255, 100, 200)
                },
                Mint = {
                        Main = Color3.fromRGB(8, 20, 16),
                        Second = Color3.fromRGB(14, 36, 28),
                        Stroke = Color3.fromRGB(60, 200, 150),
                        Divider = Color3.fromRGB(20, 65, 50),
                        Text = Color3.fromRGB(225, 255, 245),
                        TextDark = Color3.fromRGB(130, 220, 185),
                        Accent = Color3.fromRGB(80, 220, 160)
                },
                Sunset = {
                        Main = Color3.fromRGB(22, 12, 8),
                        Second = Color3.fromRGB(40, 22, 14),
                        Stroke = Color3.fromRGB(230, 120, 50),
                        Divider = Color3.fromRGB(80, 40, 20),
                        Text = Color3.fromRGB(255, 235, 215),
                        TextDark = Color3.fromRGB(230, 170, 110),
                        Accent = Color3.fromRGB(255, 150, 80)
                },
                Blurple = {
                        Main = Color3.fromRGB(10, 10, 20),
                        Second = Color3.fromRGB(20, 20, 45),
                        Stroke = Color3.fromRGB(80, 80, 160),
                        Divider = Color3.fromRGB(40, 40, 80),
                        Text = Color3.fromRGB(240, 240, 255),
                        TextDark = Color3.fromRGB(150, 150, 220),
                        Accent = Color3.fromRGB(114, 137, 218)
                },
                Red = {
                        Main = Color3.fromRGB(15, 8, 8),
                        Second = Color3.fromRGB(28, 12, 12),
                        Stroke = Color3.fromRGB(140, 40, 40),
                        Divider = Color3.fromRGB(60, 20, 20),
                        Text = Color3.fromRGB(255, 230, 230),
                        TextDark = Color3.fromRGB(200, 130, 130),
                        Accent = Color3.fromRGB(220, 50, 50)
                },
                Lavender = {
                        Main = Color3.fromRGB(220, 215, 235),
                        Second = Color3.fromRGB(205, 198, 225),
                        Stroke = Color3.fromRGB(140, 120, 190),
                        Divider = Color3.fromRGB(190, 182, 215),
                        Text = Color3.fromRGB(40, 25, 70),
                        TextDark = Color3.fromRGB(100, 80, 140),
                        Accent = Color3.fromRGB(170, 140, 230)
                },
                Slate = {
                        Main = Color3.fromRGB(20, 22, 26),
                        Second = Color3.fromRGB(32, 36, 42),
                        Stroke = Color3.fromRGB(110, 120, 140),
                        Divider = Color3.fromRGB(50, 56, 64),
                        Text = Color3.fromRGB(230, 235, 245),
                        TextDark = Color3.fromRGB(160, 170, 185),
                        Accent = Color3.fromRGB(100, 140, 200)
                },
                Aqua = {
                        Main = Color3.fromRGB(6, 18, 22),
                        Second = Color3.fromRGB(10, 32, 38),
                        Stroke = Color3.fromRGB(20, 200, 180),
                        Divider = Color3.fromRGB(18, 60, 60),
                        Text = Color3.fromRGB(220, 255, 250),
                        TextDark = Color3.fromRGB(110, 210, 200),
                        Accent = Color3.fromRGB(30, 220, 200)
                },
                Rose = {
                        Main = Color3.fromRGB(22, 10, 14),
                        Second = Color3.fromRGB(40, 18, 26),
                        Stroke = Color3.fromRGB(230, 100, 130),
                        Divider = Color3.fromRGB(80, 30, 45),
                        Text = Color3.fromRGB(255, 230, 235),
                        TextDark = Color3.fromRGB(220, 150, 170),
                        Accent = Color3.fromRGB(255, 120, 160)
                },
                Mono = {
                        Main = Color3.fromRGB(0, 0, 0),
                        Second = Color3.fromRGB(15, 15, 15),
                        Stroke = Color3.fromRGB(255, 255, 255),
                        Divider = Color3.fromRGB(40, 40, 40),
                        Text = Color3.fromRGB(255, 255, 255),
                        TextDark = Color3.fromRGB(180, 180, 180),
                        Accent = Color3.fromRGB(200, 200, 200)
                },
                Matrix = {
                        Main = Color3.fromRGB(0, 8, 0),
                        Second = Color3.fromRGB(0, 18, 0),
                        Stroke = Color3.fromRGB(0, 220, 50),
                        Divider = Color3.fromRGB(0, 45, 0),
                        Text = Color3.fromRGB(180, 255, 180),
                        TextDark = Color3.fromRGB(60, 180, 60),
                        Accent = Color3.fromRGB(0, 255, 60)
                }
        },
        Fonts = {
                Gotham = Enum.Font.Gotham,
                GothamBold = Enum.Font.GothamBold,
                GothamBlack = Enum.Font.GothamBlack,
                FredokaOne = Enum.Font.FredokaOne,
                SourceSans = Enum.Font.SourceSans,
                SourceSansBold = Enum.Font.SourceSansBold,
                Roboto = Enum.Font.Roboto,
                RobotoMono = Enum.Font.RobotoMono,
                Nunito = Enum.Font.Nunito,
                Ubuntu = Enum.Font.Ubuntu,
                Cartoon = Enum.Font.Cartoon,
                Code = Enum.Font.Code,
                SciFi = Enum.Font.SciFi,
                Fantasy = Enum.Font.Fantasy,
                Arial = Enum.Font.Arial
        },
        SelectedTheme = "Dark",
        SelectedFont = "Gotham",
        Folder = nil,
        SaveCfg = false,
        Font = Enum.Font.Gotham
}

local function GetIcon(IconName)
        return nil
end

function Library:CleanupInstance()
        for _, instance in pairs(game:GetService("CoreGui"):GetChildren()) do
                if instance:IsA("ScreenGui") and
                        instance.Name:match("^[A-Z]%d%d%d$") then
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
        pcall(function()
                local Dragging, DragInput, MousePos, FramePos = false
                DragPoint.InputBegan:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                                Dragging = true
                                MousePos = Input.Position
                                FramePos = Main.Position

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
                        if Input == DragInput and Dragging then
                                local Delta = Input.Position - MousePos
                                Main.Position = UDim2.new(FramePos.X.Scale, FramePos.X.Offset + Delta.X, FramePos.Y.Scale, FramePos.Y.Offset + Delta.Y)
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
                        pcall(function()
                                Object[ReturnProperty(Object)] = Library.Themes[Library.SelectedTheme][Name]
                        end)
                end
        end
end

local function AddFontObject(Object)
        table.insert(Library.FontObjects, Object)
        Object.Font = Library.Fonts[Library.SelectedFont] or Library.Font
        return Object
end

local function SetFont()
        local FontEnum = Library.Fonts[Library.SelectedFont] or Library.Font
        for _, Object in pairs(Library.FontObjects) do
                pcall(function()
                        Object.Font = FontEnum
                end)
        end
end

function Library:SetTheme(ThemeName)
        if not Library.Themes[ThemeName] then
                warn("Theme '" .. ThemeName .. "' not found")
                return
        end
        Library.SelectedTheme = ThemeName
        SetTheme()
end

function Library:SetFont(FontName)
        if not Library.Fonts[FontName] then
                warn("Font '" .. FontName .. "' not found")
                return
        end
        Library.SelectedFont = FontName
        Library.Font = Library.Fonts[FontName]
        SetFont()
end

local function PackColor(Color)
        return {R = Color.R * 255, G = Color.G * 255, B = Color.B * 255}
end

local function UnpackColor(Color)
        return Color3.fromRGB(Color.R, Color.G, Color.B)
end

local function LoadCfg(Config)
        local success, err = pcall(function()
                local Data = HttpService:JSONDecode(Config)
                table.foreach(Data, function(a,b)
                        if Library.Flags[a] then
                                spawn(function()
                                        if Library.Flags[a].Type == "Colorpicker" then
                                                Library.Flags[a]:Set(UnpackColor(b))
                                        else
                                                Library.Flags[a]:Set(b)
                                        end
                                end)
                        else
                                warn("Config Loader - Could not find ", a ,b)
                        end
                end)
        end)
        
        if not success then
                warn("Config Load Error:", err)
        end
end

local function SaveCfg(Name)
        if not writefile or not makefolder or not isfolder then
                return false
        end
        
        local success, err = pcall(function()
                if not isfolder(Library.Folder) then
                        makefolder(Library.Folder)
                end
                
                local Data = {}
                for i,v in pairs(Library.Flags) do
                        if v.Save then
                                if v.Type == "Colorpicker" then
                                        Data[i] = PackColor(v.Value)
                                else
                                        Data[i] = v.Value
                                end
                        end
                end
                
                writefile(Library.Folder .. "/" .. Name .. ".txt", HttpService:JSONEncode(Data))
        end)
        
        if not success then
                warn("Config Save Error:", err)
                return false
        end
        
        return true
end

local WhitelistedMouse = {Enum.UserInputType.MouseButton1, Enum.UserInputType.MouseButton2,Enum.UserInputType.MouseButton3,Enum.UserInputType.Touch}
local BlacklistedKeys = {Enum.KeyCode.Unknown,Enum.KeyCode.W,Enum.KeyCode.A,Enum.KeyCode.S,Enum.KeyCode.D,Enum.KeyCode.Up,Enum.KeyCode.Left,Enum.KeyCode.Down,Enum.KeyCode.Right,Enum.KeyCode.Slash,Enum.KeyCode.Tab,Enum.KeyCode.Backspace,Enum.KeyCode.Escape}

local function CheckKey(Table, Key)
        for _, v in next, Table do
                if v == Key then
                        return true
                end
        end
end

CreateElement("Corner", function(Scale, Offset)
        local Corner = Create("UICorner", {
                CornerRadius = UDim.new(Scale or 0, Offset or 10)
        })
        return Corner
end)

CreateElement("Stroke", function(Color, Thickness)
        local Stroke = Create("UIStroke", {
                Color = Color or Color3.fromRGB(255, 255, 255),
                Thickness = Thickness or 1,
                Transparency = 0.3
        })
        return Stroke
end)

CreateElement("List", function(Scale, Offset)
        local List = Create("UIListLayout", {
                SortOrder = Enum.SortOrder.LayoutOrder,
                Padding = UDim.new(Scale or 0, Offset or 0)
        })
        return List
end)

CreateElement("Padding", function(Bottom, Left, Right, Top)
        local Padding = Create("UIPadding", {
                PaddingBottom = UDim.new(0, Bottom or 4),
                PaddingLeft = UDim.new(0, Left or 4),
                PaddingRight = UDim.new(0, Right or 4),
                PaddingTop = UDim.new(0, Top or 4)
        })
        return Padding
end)

CreateElement("TFrame", function()
        local TFrame = Create("Frame", {
                BackgroundTransparency = 1
        })
        return TFrame
end)

CreateElement("Frame", function(Color)
        local Frame = Create("Frame", {
                BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                BackgroundTransparency = 0.15
        })
        return Frame
end)

CreateElement("RoundFrame", function(Color, Scale, Offset)
        local Frame = Create("Frame", {
                BackgroundColor3 = Color or Color3.fromRGB(255, 255, 255),
                BorderSizePixel = 0,
                BackgroundTransparency = 0.15
        }, {
                Create("UICorner", {
                        CornerRadius = UDim.new(Scale, Offset)
                })
        })
        return Frame
end)

CreateElement("Button", function()
        local Button = Create("TextButton", {
                Text = "",
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0
        })
        return Button
end)

CreateElement("ScrollFrame", function(Color, Width)
        local ScrollFrame = Create("ScrollingFrame", {
                BackgroundTransparency = 1,
                MidImage = "rbxassetid://7445543667",
                BottomImage = "rbxassetid://7445543667",
                TopImage = "rbxassetid://7445543667",
                ScrollBarImageColor3 = Color,
                BorderSizePixel = 0,
                ScrollBarThickness = Width,
                CanvasSize = UDim2.new(0, 0, 0, 0)
        })
        return ScrollFrame
end)

CreateElement("Image", function(ImageID)
        local ImageNew = Create("ImageLabel", {
                Image = ImageID,
                BackgroundTransparency = 1,
                ImageTransparency = 0.1
        })

        if GetIcon(ImageID) ~= nil then
                ImageNew.Image = GetIcon(ImageID)
        end     

        return ImageNew
end)

CreateElement("ImageButton", function(ImageID)
        local Image = Create("ImageButton", {
                Image = ImageID,
                BackgroundTransparency = 1,
                ImageTransparency = 0.1
        })
        return Image
end)

CreateElement("Label", function(Text, TextSize, Transparency)
        local Label = Create("TextLabel", {
                Text = Text or "",
                TextColor3 = Color3.fromRGB(240, 240, 240),
                TextTransparency = Transparency or 0.05,
                TextSize = TextSize or 15,
                Font = Library.Fonts[Library.SelectedFont] or Library.Font,
                RichText = true,
                BackgroundTransparency = 1,
                TextXAlignment = Enum.TextXAlignment.Left
        })
        AddFontObject(Label)
        return Label
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

                local NotificationFrame = SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(12, 12, 12), 0, 10), {
                        Parent = NotificationParent, 
                        Size = UDim2.new(1, 0, 0, 0),
                        Position = UDim2.new(1, -55, 0, 0),
                        BackgroundTransparency = 0.1,
                        AutomaticSize = Enum.AutomaticSize.Y
                }), {
                        MakeElement("Stroke", Color3.fromRGB(60, 60, 60), 1.2),
                        MakeElement("Padding", 12, 12, 12, 12),
                        SetProps(MakeElement("Image", NotificationConfig.Image), {
                                Size = UDim2.new(0, 20, 0, 20),
                                ImageColor3 = Color3.fromRGB(240, 240, 240),
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
                                TextColor3 = Color3.fromRGB(180, 180, 180),
                                TextWrapped = true
                        })
                })
                TweenService:Create(NotificationFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, 0)}):Play()
                wait(NotificationConfig.Time - 0.88)
                TweenService:Create(NotificationFrame.Icon, TweenInfo.new(0.4, Enum.EasingStyle.Quint), {ImageTransparency = 1}):Play()
                TweenService:Create(NotificationFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint), {BackgroundTransparency = 0.8}):Play()
                wait(0.3)
                TweenService:Create(NotificationFrame.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {Transparency = 0.9}):Play()
                TweenService:Create(NotificationFrame.Title, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.4}):Play()
                TweenService:Create(NotificationFrame.Content, TweenInfo.new(0.6, Enum.EasingStyle.Quint), {TextTransparency = 0.5}):Play()
                wait(0.05)
                NotificationFrame:TweenPosition(UDim2.new(1, 20, 0, 0),'In','Quint',0.8,true)
                wait(1.35)
                NotificationFrame:Destroy()
        end)
end

function Library:Init()
        if Library.SaveCfg then
                if not isfile or not readfile or not isfolder then
                        warn("File functions not available")
                        return
                end
                
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

        pcall(function()
                if not Library.Folder or not isfile or not readfile or not isfolder then return end
                local autoPath = Library.Folder .. "/autoload.txt"
                if isfile(autoPath) then
                        local name = readfile(autoPath)
                        if name and name ~= "" then
                                local cfgPath = Library.Folder .. "/configs/" .. name .. ".txt"
                                if isfile(cfgPath) then
                                        LoadCfg(readfile(cfgPath))
                                        Library:MakeNotification({
                                                Name = "Configuration",
                                                Content = "Auto-loaded config: " .. name,
                                                Time = 5
                                        })
                                end
                        end
                end
        end)
end

function Library:MakeWindow(WindowConfig)
        local FirstTab = true
        local Minimized = false
        local Loaded = false
        local UIHidden = false

        WindowConfig = WindowConfig or {}
        WindowConfig.Name = WindowConfig.Name or "T"
        WindowConfig.ConfigFolder = WindowConfig.ConfigFolder or WindowConfig.Name
        WindowConfig.SaveConfig = WindowConfig.SaveConfig or false
        WindowConfig.HidePremium = WindowConfig.HidePremium or false
        if WindowConfig.IntroEnabled == nil then
                WindowConfig.IntroEnabled = true
        end
        WindowConfig.IntroToggleIcon = WindowConfig.IntroToggleIcon or "rbxassetid://8834748103"
        WindowConfig.IntroText = WindowConfig.IntroText or "Xeioa"
        WindowConfig.CloseCallback = WindowConfig.CloseCallback or function() end
        WindowConfig.ShowIcon = WindowConfig.ShowIcon or false
        WindowConfig.Icon = WindowConfig.Icon or "rbxassetid://8834748103"
        WindowConfig.IntroIcon = WindowConfig.IntroIcon or "rbxassetid://8834748103"
        Library.Folder = WindowConfig.ConfigFolder
        Library.SaveCfg = WindowConfig.SaveConfig

        if WindowConfig.SaveConfig then
                if not isfolder(WindowConfig.ConfigFolder) then
                        makefolder(WindowConfig.ConfigFolder)
                end     
        end

        local TabHolder = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 4), {
                Size = UDim2.new(1, 0, 1, -50)
        }), {
                MakeElement("List"),
                MakeElement("Padding", 8, 0, 0, 8)
        }), "Divider")

        AddConnection(TabHolder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                TabHolder.CanvasSize = UDim2.new(0, 0, 0, TabHolder.UIListLayout.AbsoluteContentSize.Y + 16)
        end)

        local CloseBtn = SetChildren(SetProps(MakeElement("Button"), {
                Size = UDim2.new(0.5, 0, 1, 0),
                Position = UDim2.new(0.5, 0, 0, 0),
                BackgroundTransparency = 1
        }), {
                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072725342"), {
                        Position = UDim2.new(0, 9, 0, 6),
                        Size = UDim2.new(0, 18, 0, 18)
                }), "Text")
        })

        local MinimizeBtn = SetChildren(SetProps(MakeElement("Button"), {
                Size = UDim2.new(0.5, 0, 1, 0),
                BackgroundTransparency = 1
        }), {
                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072719338"), {
                        Position = UDim2.new(0, 9, 0, 6),
                        Size = UDim2.new(0, 18, 0, 18),
                        Name = "Ico"
                }), "Text")
        })

        local DragPoint = SetProps(MakeElement("TFrame"), {
                Size = UDim2.new(1, 0, 0, 50)
        })

        local WindowStuff = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
                Size = UDim2.new(0, 150, 1, -50),
                Position = UDim2.new(0, 0, 0, 50),
                BackgroundTransparency = 0.025
        }), {
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(1, 0, 0, 10),
                        Position = UDim2.new(0, 0, 0, 0),
                        BackgroundTransparency = 0.25
                }), "Second"), 
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(0, 10, 1, 0),
                        Position = UDim2.new(1, -10, 0, 0),
                        BackgroundTransparency = 0.25
                }), "Second"), 
                AddThemeObject(SetProps(MakeElement("Frame"), {
                        Size = UDim2.new(0, 1, 1, 0),
                        Position = UDim2.new(1, -1, 0, 0),
                        BackgroundTransparency = 0.4
                }), "Stroke"), 
                TabHolder,
                SetChildren(SetProps(MakeElement("TFrame"), {
                        Size = UDim2.new(1, 0, 0, 50),
                        Position = UDim2.new(0, 0, 1, -50)
                }), {
                        AddThemeObject(SetProps(MakeElement("Frame"), {
                                Size = UDim2.new(1, 0, 0, 1),
                                BackgroundTransparency = 0.4
                        }), "Stroke"), 
                        AddThemeObject(SetChildren(SetProps(MakeElement("Frame"), {
                                AnchorPoint = Vector2.new(0, 0.5),
                                Size = UDim2.new(0, 32, 0, 32),
                                Position = UDim2.new(0, 10, 0.5, 0),
                                BackgroundTransparency = 0.3
                        }), {
                                SetProps(MakeElement("Image", "https://www.roblox.com/headshot-thumbnail/image?userId=".. LocalPlayer.UserId .."&width=420&height=420&format=png"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                }),
                                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4031889928"), {
                                        Size = UDim2.new(1, 0, 1, 0),
                                }), "Second"),
                                MakeElement("Corner", 1)
                        }), "Divider"),
                        SetChildren(SetProps(MakeElement("TFrame"), {
                                AnchorPoint = Vector2.new(0, 0.5),
                                Size = UDim2.new(0, 32, 0, 32),
                                Position = UDim2.new(0, 10, 0.5, 0)
                        }), {
                                AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                MakeElement("Corner", 1)
                        }),
                        AddThemeObject(SetProps(MakeElement("Label", "Xeioa", WindowConfig.HidePremium and 14 or 13), {
                                Size = UDim2.new(1, -60, 0, 13),
                                Position = WindowConfig.HidePremium and UDim2.new(0, 50, 0, 19) or UDim2.new(0, 50, 0, 12),
                                Font = Enum.Font.FredokaOne,
                                ClipsDescendants = true
                        }), "Text"),
                        AddThemeObject(SetProps(MakeElement("Label", "Join Xeioa", 12), {
                                Size = UDim2.new(1, -60, 0, 12),
                                Position = UDim2.new(0, 50, 1, -25),
                                Visible = not WindowConfig.HidePremium
                        }), "TextDark")
                }),
        }), "Second")

        local WindowName = AddThemeObject(SetProps(MakeElement("Label", WindowConfig.Name, 14), {
                Size = UDim2.new(1, -30, 2, 0),
                Position = UDim2.new(0, 25, 0, -24),
                Font = Enum.Font.GothamBlack,
                TextSize = 20
        }), "Text")

        local WindowTopBarLine = AddThemeObject(SetProps(MakeElement("Frame"), {
                Size = UDim2.new(1, 0, 0, 1),
                Position = UDim2.new(0, 0, 1, -1),
                BackgroundTransparency = 0.4
        }), "Stroke")

        local MainWindow = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 10), {
                Parent = Container,
                Position = UDim2.new(0.5, -307, 0.5, -172),
                Size = UDim2.new(0, 615, 0, 344),
                ClipsDescendants = true,
                BackgroundTransparency = 0.09
        }), {
                SetChildren(SetProps(MakeElement("TFrame"), {
                        Size = UDim2.new(1, 0, 0, 50),
                        Name = "TopBar"
                }), {
                        WindowName,
                        WindowTopBarLine,
                        AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 7), {
                                Size = UDim2.new(0, 70, 0, 30),
                                Position = UDim2.new(1, -90, 0, 10),
                                BackgroundTransparency = 0.25
                        }), {
                                AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                AddThemeObject(SetProps(MakeElement("Frame"), {
                                        Size = UDim2.new(0, 1, 1, 0),
                                        Position = UDim2.new(0.5, 0, 0, 0),
                                        BackgroundTransparency = 0.4
                                }), "Stroke"), 
                                CloseBtn,
                                MinimizeBtn
                        }), "Second"), 
                }),
                DragPoint,
                WindowStuff
        }), "Main")

        local TopBarGradient = Create("UIGradient", {
                Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(8, 8, 8))
                }),
                Rotation = 90
        })
        TopBarGradient.Parent = MainWindow.TopBar

        if WindowConfig.ShowIcon then
                WindowName.Position = UDim2.new(0, 50, 0, -24)
                local WindowIcon = SetProps(MakeElement("Image", WindowConfig.Icon), {
                        Size = UDim2.new(0, 20, 0, 20),
                        Position = UDim2.new(0, 25, 0, 15)
                })
                WindowIcon.Parent = MainWindow.TopBar
        end     

        MakeDraggable(DragPoint, MainWindow)

        local MobileReopenButton = SetChildren(SetProps(MakeElement("Button"), {
                Parent = Container,
                Size = UDim2.new(0, 40, 0, 40),
                Position = UDim2.new(0.5, -20, 0, 20),
                BackgroundTransparency = 0.2,
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
                        Content = UserInputService.TouchEnabled and "Tap the button or Left Control to reopen the interface" or "Press Left Control to reopen the interface",
                        Time = 5
                })
                WindowConfig.CloseCallback()
        end)

        AddConnection(CloseBtn.MouseButton1Down, function()
                local SoundService = game:GetService("SoundService")
                local sound = Instance.new("Sound", SoundService)
                sound.SoundId = "rbxassetid://6895079853"
                sound.Volume = 1
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 3)
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

        AddConnection(MobileReopenButton.MouseButton1Down, function()
                local SoundService = game:GetService("SoundService")
                local sound = Instance.new("Sound", SoundService)
                sound.SoundId = "rbxassetid://6895079853"
                sound.Volume = 1
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 3)
        end)

        AddConnection(MinimizeBtn.MouseButton1Up, function()
                if Minimized then
                        TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 615, 0, 344)}):Play()
                        MinimizeBtn.Ico.Image = "rbxassetid://7072719338"
                        wait(.02)
                        MainWindow.ClipsDescendants = false
                        WindowStuff.Visible = true
                        WindowTopBarLine.Visible = true
                else
                        MainWindow.ClipsDescendants = true
                        WindowTopBarLine.Visible = false
                        MinimizeBtn.Ico.Image = "rbxassetid://7072720870"

                        TweenService:Create(MainWindow, TweenInfo.new(0.5, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, WindowName.TextBounds.X + 140, 0, 50)}):Play()
                        wait(0.1)
                        WindowStuff.Visible = false     
                end
                Minimized = not Minimized   
        end)

        AddConnection(MinimizeBtn.MouseButton1Down, function()
                local SoundService = game:GetService("SoundService")
                local sound = Instance.new("Sound", SoundService)
                sound.SoundId = "rbxassetid://6895079853"
                sound.Volume = 1
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 3)
        end)

        local function LoadSequence()
                MainWindow.Visible = false

                local IntroScreenGui = Instance.new("ScreenGui")
                IntroScreenGui.Name = "Intro"
                IntroScreenGui.DisplayOrder = 2147483647
                IntroScreenGui.IgnoreGuiInset = true
                IntroScreenGui.Parent = game:GetService("CoreGui")

                local IntroContainer = Create("Frame", {
                        Parent = IntroScreenGui,
                        Size = UDim2.new(1, 0, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
                        BorderSizePixel = 0,
                        BackgroundTransparency = 0
                })

                local BgGradient = Create("UIGradient", {
                        Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(18, 18, 18)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(5, 5, 5)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 12))
                        }),
                        Rotation = 135
                })
                BgGradient.Parent = IntroContainer

                local CenterGlow = Create("ImageLabel", {
                        Parent = IntroContainer,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 0),
                        Size = UDim2.new(0, 400, 0, 400),
                        BackgroundTransparency = 1,
                        Image = "rbxassetid://5028857084",
                        ImageColor3 = Color3.fromRGB(80, 80, 80),
                        ImageTransparency = 0.85,
                        ScaleType = Enum.ScaleType.Fit
                })

                local TopLine = Create("Frame", {
                        Parent = IntroContainer,
                        Size = UDim2.new(0, 0, 0, 1),
                        Position = UDim2.new(0.5, 0, 0.38, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 0.7,
                        BorderSizePixel = 0
                })
                Create("UIGradient", {
                        Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))
                        })
                }).Parent = TopLine

                local BottomLine = Create("Frame", {
                        Parent = IntroContainer,
                        Size = UDim2.new(0, 0, 0, 1),
                        Position = UDim2.new(0.5, 0, 0.62, 0),
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 0.7,
                        BorderSizePixel = 0
                })
                Create("UIGradient", {
                        Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 50)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 50, 50))
                        })
                }).Parent = BottomLine

                local LogoFrame = Create("ImageLabel", {
                        Parent = IntroContainer,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, -22),
                        Size = UDim2.new(0, 36, 0, 36),
                        BackgroundTransparency = 1,
                        Image = WindowConfig.IntroIcon,
                        ImageColor3 = Color3.fromRGB(255, 255, 255),
                        ImageTransparency = 1
                })

                local TitleLabel = Create("TextLabel", {
                        Parent = IntroContainer,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 22),
                        Size = UDim2.new(0, 300, 0, 36),
                        BackgroundTransparency = 1,
                        Text = WindowConfig.IntroText,
                        TextColor3 = Color3.fromRGB(255, 255, 255),
                        TextTransparency = 1,
                        Font = Enum.Font.GothamBlack,
                        TextSize = 32,
                        TextXAlignment = Enum.TextXAlignment.Center
                })
                local TitleBg = Create("Frame", {
                        Parent = IntroContainer,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 22),
                        Size = UDim2.new(0, 300, 0, 36),
                        BackgroundTransparency = 0.9,
                        BorderSizePixel = 0,
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                })
                Create("UIGradient", {
                        Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                                ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 255, 255)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0))
                        }),
                        Transparency = NumberSequence.new({
                                NumberSequenceKeypoint.new(0, 1),
                                NumberSequenceKeypoint.new(0.5, 0.8),
                                NumberSequenceKeypoint.new(1, 1)
                        })
                }).Parent = TitleBg
                Create("UICorner", {CornerRadius = UDim.new(0, 4)}).Parent = TitleBg

                local SubLabel = Create("TextLabel", {
                        Parent = IntroContainer,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 52),
                        Size = UDim2.new(0, 300, 0, 20),
                        BackgroundTransparency = 1,
                        Text = "Loading...",
                        TextColor3 = Color3.fromRGB(160, 160, 160),
                        TextTransparency = 1,
                        Font = Enum.Font.Gotham,
                        TextSize = 13,
                        TextXAlignment = Enum.TextXAlignment.Center
                })

                local BarBg = Create("Frame", {
                        Parent = IntroContainer,
                        AnchorPoint = Vector2.new(0.5, 0.5),
                        Position = UDim2.new(0.5, 0, 0.5, 80),
                        Size = UDim2.new(0, 160, 0, 2),
                        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                        BackgroundTransparency = 0,
                        BorderSizePixel = 0
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0)}).Parent = BarBg

                local BarFill = Create("Frame", {
                        Parent = BarBg,
                        Size = UDim2.new(0, 0, 1, 0),
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        BackgroundTransparency = 0,
                        BorderSizePixel = 0
                })
                Create("UICorner", {CornerRadius = UDim.new(1, 0)}).Parent = BarFill
                Create("UIGradient", {
                        Color = ColorSequence.new({
                                ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 180)),
                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                        })
                }).Parent = BarFill

                TweenService:Create(TopLine, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 220, 0, 1)}):Play()
                TweenService:Create(BottomLine, TweenInfo.new(0.6, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, 220, 0, 1)}):Play()
                wait(0.3)

                TweenService:Create(LogoFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
                wait(0.2)

                TweenService:Create(TitleLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0}):Play()
                wait(0.15)

                TweenService:Create(SubLabel, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {TextTransparency = 0.3}):Play()
                wait(0.1)

                TweenService:Create(BarFill, TweenInfo.new(0.9, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(1, 0, 1, 0)}):Play()
                wait(1.0)

                SubLabel.Text = "Ready"
                TweenService:Create(SubLabel, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                wait(0.3)

                local SoundService = game:GetService("SoundService")
                local startSound = Instance.new("Sound")
                startSound.SoundId = "rbxassetid://106804504297292"
                startSound.Volume = 1
                startSound.Parent = SoundService
                startSound:Play()

                TweenService:Create(TitleLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
                TweenService:Create(SubLabel, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {TextTransparency = 1}):Play()
                TweenService:Create(LogoFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
                TweenService:Create(TitleBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
                TweenService:Create(CenterGlow, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {ImageTransparency = 1}):Play()
                TweenService:Create(TopLine, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 1)}):Play()
                TweenService:Create(BottomLine, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 1)}):Play()
                TweenService:Create(IntroContainer, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {BackgroundTransparency = 1}):Play()
                wait(0.5)

                MainWindow.Visible = true
                IntroScreenGui:Destroy()
        end 

        if WindowConfig.IntroEnabled then
                LoadSequence()
        end     

        local TabFunction = {}
        function TabFunction:MakeTab(TabConfig)
                TabConfig = TabConfig or {}
                TabConfig.Name = TabConfig.Name or "Tab"
                TabConfig.Icon = TabConfig.Icon or ""
                TabConfig.PremiumOnly = TabConfig.PremiumOnly or false

                local TabFrame = SetChildren(SetProps(MakeElement("Button"), {
                        Size = UDim2.new(1, 0, 0, 30),
                        Parent = TabHolder
                }), {
                        AddThemeObject(SetProps(MakeElement("Image", TabConfig.Icon), {
                                AnchorPoint = Vector2.new(0, 0.5),
                                Size = UDim2.new(0, 18, 0, 18),
                                Position = UDim2.new(0, 10, 0.5, 0),
                                ImageTransparency = 0.4,
                                Name = "Ico"
                        }), "Text"),
                        AddThemeObject(SetProps(MakeElement("Label", TabConfig.Name, 14), {
                                Size = UDim2.new(1, -35, 1, 0),
                                Position = UDim2.new(0, 35, 0, 0),
                                Font = Library.Fonts[Library.SelectedFont] or Library.Font,
                                TextTransparency = 0.4,
                                Name = "Title"
                        }), "Text")
                })

                if GetIcon(TabConfig.Icon) ~= nil then
                        TabFrame.Ico.Image = GetIcon(TabConfig.Icon)
                end     

                local Container = AddThemeObject(SetChildren(SetProps(MakeElement("ScrollFrame", Color3.fromRGB(255, 255, 255), 5), {
                        Size = UDim2.new(1, -150, 1, -50),
                        Position = UDim2.new(0, 150, 0, 50),
                        Parent = MainWindow,
                        Visible = false,
                        Name = "ItemContainer"
                }), {
                        MakeElement("List", 0, 6),
                        MakeElement("Padding", 15, 10, 10, 15)
                }), "Divider")

                AddConnection(Container.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                        Container.CanvasSize = UDim2.new(0, 0, 0, Container.UIListLayout.AbsoluteContentSize.Y + 30)
                end)

                if FirstTab then
                        FirstTab = false
                        TabFrame.Ico.ImageTransparency = 0
                        TabFrame.Title.TextTransparency = 0
                        TabFrame.Title.Font = Library.Fonts[Library.SelectedFont] or Library.Font
                        Container.Visible = true
                end   

                AddConnection(TabFrame.MouseButton1Click, function()
                        for _, Tab in next, TabHolder:GetChildren() do
                                if Tab:IsA("TextButton") then
                                        Tab.Title.Font = Library.Fonts[Library.SelectedFont] or Library.Font
                                        TweenService:Create(Tab.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0.4, ImageColor3 = Color3.fromRGB(240, 240, 240)}):Play()
                                        TweenService:Create(Tab.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0.4, TextColor3 = Color3.fromRGB(240, 240, 240)}):Play()
                                end
                        end
                        for _, ItemContainer in next, MainWindow:GetChildren() do
                                if ItemContainer.Name == "ItemContainer" then
                                        ItemContainer.Visible = false
                                end
                        end
                        TweenService:Create(TabFrame.Ico, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {ImageTransparency = 0, ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                        TweenService:Create(TabFrame.Title, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {TextTransparency = 0, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
                        TabFrame.Title.Font = Library.Fonts[Library.SelectedFont] or Library.Font
                        Container.Visible = true
                end)

                AddConnection(TabFrame.MouseButton1Down, function()
                        local SoundService = game:GetService("SoundService")
                        local sound = Instance.new("Sound", SoundService)
                        sound.SoundId = "rbxassetid://6895079853"
                        sound.Volume = 1
                        sound:Play()
                        game:GetService("Debris"):AddItem(sound, 3)
                end)

                local function GetElements(ItemParent)
                        local ElementFunction = {}

                        function ElementFunction:AddLabel(Text)
                                local LabelFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 30),
                                        BackgroundTransparency = 0.8,
                                        Parent = ItemParent
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke")
                                }), "Second")

                                local LabelFunction = {}
                                function LabelFunction:Set(ToChange)
                                        LabelFrame.Content.Text = ToChange
                                end
                                return LabelFunction
                        end

                        function ElementFunction:AddParagraph(Text, Content)
                                Text = Text or "Text"
                                Content = Content or "Content"

                                local ParagraphFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 30),
                                        BackgroundTransparency = 0.8,
                                        Parent = ItemParent
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", Text, 15), {
                                                Size = UDim2.new(1, -12, 0, 14),
                                                Position = UDim2.new(0, 12, 0, 10),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Title"
                                        }), "Text"),
                                        AddThemeObject(SetProps(MakeElement("Label", "", 13), {
                                                Size = UDim2.new(1, -24, 0, 0),
                                                Position = UDim2.new(0, 12, 0, 26),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Content",
                                                TextWrapped = true
                                        }), "TextDark"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke")
                                }), "Second")

                                AddConnection(ParagraphFrame.Content:GetPropertyChangedSignal("Text"), function()
                                        ParagraphFrame.Content.Size = UDim2.new(1, -24, 0, ParagraphFrame.Content.TextBounds.Y)
                                        ParagraphFrame.Size = UDim2.new(1, 0, 0, ParagraphFrame.Content.TextBounds.Y + 35)
                                end)

                                ParagraphFrame.Content.Text = Content

                                local ParagraphFunction = {}
                                function ParagraphFunction:Set(ToChange)
                                        ParagraphFrame.Content.Text = ToChange
                                end
                                return ParagraphFunction
                        end   

                        function ElementFunction:AddButton(ButtonConfig)
                                ButtonConfig = ButtonConfig or {}
                                ButtonConfig.Name = ButtonConfig.Name or "Button"
                                ButtonConfig.Callback = ButtonConfig.Callback or function() end
                                ButtonConfig.Icon = ButtonConfig.Icon or "rbxassetid://3944703587"

                                local Button = {}

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local ButtonFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 33),
                                        Parent = ItemParent,
                                        BackgroundTransparency = 0.25
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", ButtonConfig.Name, 15), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(SetProps(MakeElement("Image", ButtonConfig.Icon), {
                                                Size = UDim2.new(0, 20, 0, 20),
                                                Position = UDim2.new(1, -30, 0, 7),
                                        }), "TextDark"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        Click
                                }), "Second")

                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(22, 22, 22))
                                        }),
                                        Rotation = 90
                                }).Parent = ButtonFrame

                                AddConnection(Click.MouseEnter, function()
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
                                end)

                                AddConnection(Click.MouseLeave, function()
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.25}):Play()
                                end)

                                AddConnection(Click.MouseButton1Up, function()
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
                                        spawn(function()
                                                ButtonConfig.Callback()
                                        end)
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        TweenService:Create(ButtonFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.05}):Play()
                                        local SoundService = game:GetService("SoundService")
                                        local sound = Instance.new("Sound", SoundService)
                                        sound.SoundId = "rbxassetid://6895079853"
                                        sound.Volume = 1
                                        sound:Play()
                                        game:GetService("Debris"):AddItem(sound, 3)
                                end)

                                function Button:Set(ButtonText)
                                        ButtonFrame.Content.Text = ButtonText
                                end     

                                return Button
                        end   

                        function ElementFunction:AddToggle(ToggleConfig)
                                ToggleConfig = ToggleConfig or {}
                                ToggleConfig.Name = ToggleConfig.Name or "Toggle"
                                ToggleConfig.Default = ToggleConfig.Default or false
                                ToggleConfig.Callback = ToggleConfig.Callback or function() end
                                ToggleConfig.Flag = ToggleConfig.Flag or nil
                                ToggleConfig.Save = ToggleConfig.Save or false

                                local Toggle = {Value = ToggleConfig.Default, Type = "Toggle", Save = ToggleConfig.Save}

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local SwitchTrack = Create("Frame", {
                                        Size = UDim2.new(0, 40, 0, 20),
                                        Position = UDim2.new(1, -50, 0.5, 0),
                                        AnchorPoint = Vector2.new(0.5, 0.5),
                                        BackgroundColor3 = Color3.fromRGB(40, 40, 40),
                                        BorderSizePixel = 0
                                })
                                Create("UICorner", {CornerRadius = UDim.new(1, 0)}).Parent = SwitchTrack
                                Create("UIStroke", {
                                        Color = Color3.fromRGB(70, 70, 70),
                                        Thickness = 1,
                                        Transparency = 0.4
                                }).Parent = SwitchTrack

                                local SwitchGradient = Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 55))
                                        }),
                                        Rotation = 90
                                })
                                SwitchGradient.Parent = SwitchTrack

                                local SwitchKnob = Create("Frame", {
                                        Size = UDim2.new(0, 14, 0, 14),
                                        Position = UDim2.new(0, 3, 0.5, 0),
                                        AnchorPoint = Vector2.new(0, 0.5),
                                        BackgroundColor3 = Color3.fromRGB(200, 200, 200),
                                        BorderSizePixel = 0
                                })
                                Create("UICorner", {CornerRadius = UDim.new(1, 0)}).Parent = SwitchKnob
                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 190, 190))
                                        }),
                                        Rotation = 90
                                }).Parent = SwitchKnob
                                SwitchKnob.Parent = SwitchTrack

                                local ToggleFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent,
                                        BackgroundTransparency = 0.25
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", ToggleConfig.Name, 15), {
                                                Size = UDim2.new(1, -60, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        SwitchTrack,
                                        Click
                                }), "Second")

                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                                        }),
                                        Rotation = 90
                                }).Parent = ToggleFrame

                                function Toggle:Set(Value)
                                        Toggle.Value = Value
                                        if Toggle.Value then
                                                TweenService:Create(SwitchKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                        Position = UDim2.new(1, -17, 0.5, 0),
                                                        BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                                }):Play()
                                                TweenService:Create(SwitchTrack, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                        BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                                                }):Play()
                                                SwitchGradient.Color = ColorSequence.new({
                                                        ColorSequenceKeypoint.new(0, Color3.fromRGB(70, 70, 70)),
                                                        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 100, 100))
                                                })
                                        else
                                                TweenService:Create(SwitchKnob, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                        Position = UDim2.new(0, 3, 0.5, 0),
                                                        BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                                                }):Play()
                                                TweenService:Create(SwitchTrack, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                                                        BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                                                }):Play()
                                                SwitchGradient.Color = ColorSequence.new({
                                                        ColorSequenceKeypoint.new(0, Color3.fromRGB(35, 35, 35)),
                                                        ColorSequenceKeypoint.new(1, Color3.fromRGB(55, 55, 55))
                                                })
                                        end
                                        ToggleConfig.Callback(Toggle.Value)
                                end   

                                Toggle:Set(Toggle.Value)

                                AddConnection(Click.MouseEnter, function()
                                        TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
                                end)

                                AddConnection(Click.MouseLeave, function()
                                        TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.25}):Play()
                                end)

                                AddConnection(Click.MouseButton1Up, function()
                                        TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
                                        SaveCfg(game.GameId)
                                        Toggle:Set(not Toggle.Value)
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        TweenService:Create(ToggleFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.05}):Play()
                                        local SoundService = game:GetService("SoundService")
                                        local sound = Instance.new("Sound", SoundService)
                                        sound.SoundId = "rbxassetid://6895079853"
                                        sound.Volume = 1
                                        sound:Play()
                                        game:GetService("Debris"):AddItem(sound, 3)
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
                                SliderConfig.Color = SliderConfig.Color or Color3.fromRGB(220, 220, 220)
                                SliderConfig.Flag = SliderConfig.Flag or nil
                                SliderConfig.Save = SliderConfig.Save or false

                                local Slider = {Value = SliderConfig.Default, Type = "Slider", Save = SliderConfig.Save}
                                local Dragging = false

                                local SliderDrag = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 6), {
                                        Size = UDim2.new(0, 0, 1, 0),
                                        BackgroundTransparency = 0.3,
                                        ClipsDescendants = true
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
                                                Size = UDim2.new(1, -12, 0, 14),
                                                Position = UDim2.new(0, 12, 0, 6),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Value",
                                                TextTransparency = 0,
                                                TextColor3 = Color3.fromRGB(0, 0, 0)
                                        }), "Main")
                                })
                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 180, 180)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 255, 255))
                                        })
                                }).Parent = SliderDrag

                                local SliderBar = SetChildren(SetProps(MakeElement("RoundFrame", SliderConfig.Color, 0, 6), {
                                        Size = UDim2.new(1, -24, 0, 26),
                                        Position = UDim2.new(0, 12, 0, 30),
                                        BackgroundTransparency = 0.85
                                }), {
                                        SetProps(MakeElement("Stroke"), {
                                                Color = SliderConfig.Color,
                                                Transparency = 0.5
                                        }),
                                        AddThemeObject(SetProps(MakeElement("Label", "value", 13), {
                                                Size = UDim2.new(1, -12, 0, 14),
                                                Position = UDim2.new(0, 12, 0, 6),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Value",
                                                TextTransparency = 0.6
                                        }), "Text"),
                                        SliderDrag
                                })

                                local SliderFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 65),
                                        Parent = ItemParent,
                                        BackgroundTransparency = 0.25
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", SliderConfig.Name, 15), {
                                                Size = UDim2.new(1, -12, 0, 14),
                                                Position = UDim2.new(0, 12, 0, 10),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        SliderBar
                                }), "Second")

                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                                        }),
                                        Rotation = 90
                                }).Parent = SliderFrame

                                SliderBar.InputBegan:Connect(function(Input)
                                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                                                local SoundService = game:GetService("SoundService")
                                                local sound = Instance.new("Sound", SoundService)
                                                sound.SoundId = "rbxassetid://6895079853"
                                                sound.Volume = 1
                                                sound:Play()
                                                game:GetService("Debris"):AddItem(sound, 3)
                                                Dragging = true 
                                        end 
                                end)
                                SliderBar.InputEnded:Connect(function(Input) 
                                        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then 
                                                Dragging = false 
                                        end 
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
                                        TweenService:Create(SliderDrag,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.fromScale((self.Value - SliderConfig.Min) / (SliderConfig.Max - SliderConfig.Min), 1)}):Play()
                                        SliderBar.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
                                        SliderDrag.Value.Text = tostring(self.Value) .. " " .. SliderConfig.ValueName
                                        SliderConfig.Callback(self.Value)
                                end    

                                Slider:Set(Slider.Value)
                                if SliderConfig.Flag then                               
                                        Library.Flags[SliderConfig.Flag] = Slider
                                end
                                return Slider
                        end  

                        function ElementFunction:AddDropdown(DropdownConfig)
                                DropdownConfig = DropdownConfig or {}
                                DropdownConfig.Name = DropdownConfig.Name or "Dropdown"
                                DropdownConfig.Options = DropdownConfig.Options or {}
                                DropdownConfig.Default = DropdownConfig.Default or ""
                                DropdownConfig.Callback = DropdownConfig.Callback or function() end
                                DropdownConfig.Flag = DropdownConfig.Flag or nil
                                DropdownConfig.Save = DropdownConfig.Save or false

                                local Dropdown = {Value = DropdownConfig.Default, Options = DropdownConfig.Options, Buttons = {}, Toggled = false, Type = "Dropdown", Save = DropdownConfig.Save}
                                local MaxElements = 5

                                if not table.find(Dropdown.Options, Dropdown.Value) then
                                        Dropdown.Value = "..."
                                end

                                local DropdownList = MakeElement("List")

                                local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
                                        DropdownList
                                }), {
                                        Parent = ItemParent,
                                        Position = UDim2.new(0, 0, 0, 38),
                                        Size = UDim2.new(1, 0, 1, -38),
                                        ClipsDescendants = true
                                }), "Divider")

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent,
                                        ClipsDescendants = true,
                                        BackgroundTransparency = 0.25
                                }), {
                                        DropdownContainer,
                                        SetProps(SetChildren(MakeElement("TFrame"), {
                                                AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
                                                        Size = UDim2.new(1, -12, 1, 0),
                                                        Position = UDim2.new(0, 12, 0, 0),
                                                        Font = Enum.Font.FredokaOne,
                                                        Name = "Content"
                                                }), "Text"),
                                                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
                                                        Size = UDim2.new(0, 20, 0, 20),
                                                        AnchorPoint = Vector2.new(0, 0.5),
                                                        Position = UDim2.new(1, -30, 0.5, 0),
                                                        ImageColor3 = Color3.fromRGB(240, 240, 240),
                                                        Name = "Ico"
                                                }), "TextDark"),
                                                AddThemeObject(SetProps(MakeElement("Label", "Selected", 13), {
                                                        Size = UDim2.new(1, -40, 1, 0),
                                                        Font = Enum.Font.FredokaOne,
                                                        Name = "Selected",
                                                        TextXAlignment = Enum.TextXAlignment.Right
                                                }), "TextDark"),
                                                AddThemeObject(SetProps(MakeElement("Frame"), {
                                                        Size = UDim2.new(1, 0, 0, 1),
                                                        Position = UDim2.new(0, 0, 1, -1),
                                                        Name = "Line",
                                                        Visible = false,
                                                        BackgroundTransparency = 0.4
                                                }), "Stroke"), 
                                                Click
                                        }), {
                                                Size = UDim2.new(1, 0, 0, 38),
                                                ClipsDescendants = true,
                                                Name = "F"
                                        }),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        MakeElement("Corner")
                                }), "Second")

                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                                        }),
                                        Rotation = 90
                                }).Parent = DropdownFrame

                                AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                                        DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
                                end)  

                                local function AddOptions(Options)
                                        for _, Option in pairs(Options) do
                                                local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
                                                        MakeElement("Corner", 0, 6),
                                                        AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), {
                                                                Position = UDim2.new(0, 8, 0, 0),
                                                                Size = UDim2.new(1, -8, 1, 0),
                                                                Name = "Title"
                                                        }), "Text")
                                                }), {
                                                        Parent = DropdownContainer,
                                                        Size = UDim2.new(1, 0, 0, 28),
                                                        BackgroundTransparency = 0.8,
                                                        ClipsDescendants = true
                                                }), "Divider")

                                                AddConnection(OptionBtn.MouseButton1Click, function()
                                                        local SoundService = game:GetService("SoundService")
                                                        local sound = Instance.new("Sound", SoundService)
                                                        sound.SoundId = "rbxassetid://6895079853"
                                                        sound.Volume = 1
                                                        sound:Play()
                                                        game:GetService("Debris"):AddItem(sound, 3)
                                                        Dropdown:Set(Option)
                                                        SaveCfg(game.GameId)
                                                end)

                                                AddConnection(OptionBtn.MouseButton1Down, function()
                                                        local SoundService = game:GetService("SoundService")
                                                        local sound = Instance.new("Sound", SoundService)
                                                        sound.SoundId = "rbxassetid://6895079853"
                                                        sound.Volume = 1
                                                        sound:Play()
                                                        game:GetService("Debris"):AddItem(sound, 3)
                                                end)

                                                Dropdown.Buttons[Option] = OptionBtn
                                        end
                                end     

                                function Dropdown:Refresh(Options, Delete)
                                        if Delete then
                                                for _,v in pairs(Dropdown.Buttons) do
                                                        v:Destroy()
                                                end   
                                                table.clear(Dropdown.Options)
                                                table.clear(Dropdown.Buttons)
                                        end
                                        Dropdown.Options = Options
                                        AddOptions(Dropdown.Options)
                                end  

                                function Dropdown:Set(Value)
                                        if not table.find(Dropdown.Options, Value) then
                                                Dropdown.Value = "..."
                                                DropdownFrame.F.Selected.Text = Dropdown.Value
                                                for _, v in pairs(Dropdown.Buttons) do
                                                        TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0.8}):Play()
                                                        TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
                                                end     
                                                return
                                        end

                                        Dropdown.Value = Value
                                        DropdownFrame.F.Selected.Text = Dropdown.Value

                                        for _, v in pairs(Dropdown.Buttons) do
                                                TweenService:Create(v,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0.8}):Play()
                                                TweenService:Create(v.Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0.4}):Play()
                                        end     
                                        TweenService:Create(Dropdown.Buttons[Value],TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{BackgroundTransparency = 0.3}):Play()
                                        TweenService:Create(Dropdown.Buttons[Value].Title,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{TextTransparency = 0}):Play()
                                        return DropdownConfig.Callback(Dropdown.Value)
                                end

                                AddConnection(Click.MouseButton1Click, function()
                                        Dropdown.Toggled = not Dropdown.Toggled
                                        DropdownFrame.F.Line.Visible = Dropdown.Toggled
                                        TweenService:Create(DropdownFrame.F.Ico,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Rotation = Dropdown.Toggled and 180 or 0}):Play()
                                        if #Dropdown.Options > MaxElements then
                                                TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28)) or UDim2.new(1, 0, 0, 38)}):Play()
                                        else
                                                TweenService:Create(DropdownFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Dropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38)}):Play()
                                        end
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        local SoundService = game:GetService("SoundService")
                                        local sound = Instance.new("Sound", SoundService)
                                        sound.SoundId = "rbxassetid://6895079853"
                                        sound.Volume = 1
                                        sound:Play()
                                        game:GetService("Debris"):AddItem(sound, 3)
                                end)

                                Dropdown:Refresh(Dropdown.Options, false)
                                Dropdown:Set(Dropdown.Value)
                                if DropdownConfig.Flag then                             
                                        Library.Flags[DropdownConfig.Flag] = Dropdown
                                end
                                return Dropdown
                        end

                        function ElementFunction:AddMultiDropdown(DropdownConfig)
                                DropdownConfig = DropdownConfig or {}
                                DropdownConfig.Name = DropdownConfig.Name or "MultiDropdown"
                                DropdownConfig.Options = DropdownConfig.Options or {}
                                DropdownConfig.Default = DropdownConfig.Default or {}
                                DropdownConfig.Callback = DropdownConfig.Callback or function() end
                                DropdownConfig.Flag = DropdownConfig.Flag or nil
                                DropdownConfig.Save = DropdownConfig.Save or false

                                local MultiDropdown = {
                                        Value = {},
                                        Options = DropdownConfig.Options,
                                        Buttons = {},
                                        Toggled = false,
                                        Type = "MultiDropdown",
                                        Save = DropdownConfig.Save
                                }

                                for _, v in pairs(DropdownConfig.Default) do
                                        if table.find(DropdownConfig.Options, v) then
                                                MultiDropdown.Value[v] = true
                                        end
                                end

                                local MaxElements = 5

                                local DropdownList = MakeElement("List")

                                local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
                                        DropdownList
                                }), {
                                        Parent = ItemParent,
                                        Position = UDim2.new(0, 0, 0, 38),
                                        Size = UDim2.new(1, 0, 1, -38),
                                        ClipsDescendants = true
                                }), "Divider")

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local function GetSelectedText()
                                        local selected = {}
                                        for k, v in pairs(MultiDropdown.Value) do
                                                if v then table.insert(selected, k) end
                                        end
                                        if #selected == 0 then return "None" end
                                        if #selected > 2 then return tostring(#selected) .. " selected" end
                                        return table.concat(selected, ", ")
                                end

                                local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent,
                                        ClipsDescendants = true,
                                        BackgroundTransparency = 0.25
                                }), {
                                        DropdownContainer,
                                        SetProps(SetChildren(MakeElement("TFrame"), {
                                                AddThemeObject(SetProps(MakeElement("Label", DropdownConfig.Name, 15), {
                                                        Size = UDim2.new(1, -12, 1, 0),
                                                        Position = UDim2.new(0, 12, 0, 0),
                                                        Font = Enum.Font.FredokaOne,
                                                        Name = "Content"
                                                }), "Text"),
                                                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
                                                        Size = UDim2.new(0, 20, 0, 20),
                                                        AnchorPoint = Vector2.new(0, 0.5),
                                                        Position = UDim2.new(1, -30, 0.5, 0),
                                                        ImageColor3 = Color3.fromRGB(240, 240, 240),
                                                        Name = "Ico"
                                                }), "TextDark"),
                                                AddThemeObject(SetProps(MakeElement("Label", "None", 13), {
                                                        Size = UDim2.new(1, -40, 1, 0),
                                                        Font = Enum.Font.FredokaOne,
                                                        Name = "Selected",
                                                        TextXAlignment = Enum.TextXAlignment.Right
                                                }), "TextDark"),
                                                AddThemeObject(SetProps(MakeElement("Frame"), {
                                                        Size = UDim2.new(1, 0, 0, 1),
                                                        Position = UDim2.new(0, 0, 1, -1),
                                                        Name = "Line",
                                                        Visible = false,
                                                        BackgroundTransparency = 0.4
                                                }), "Stroke"),
                                                Click
                                        }), {
                                                Size = UDim2.new(1, 0, 0, 38),
                                                ClipsDescendants = true,
                                                Name = "F"
                                        }),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        MakeElement("Corner")
                                }), "Second")

                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                                        }),
                                        Rotation = 90
                                }).Parent = DropdownFrame

                                AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                                        DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
                                end)

                                local function RefreshSelectedDisplay()
                                        DropdownFrame.F.Selected.Text = GetSelectedText()
                                end

                                local function AddOptions(Options)
                                        for _, Option in pairs(Options) do
                                                local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
                                                        MakeElement("Corner", 0, 6),
                                                        AddThemeObject(SetProps(MakeElement("Label", Option, 13, 0.4), {
                                                                Position = UDim2.new(0, 8, 0, 0),
                                                                Size = UDim2.new(1, -40, 1, 0),
                                                                Name = "Title"
                                                        }), "Text")
                                                }), {
                                                        Parent = DropdownContainer,
                                                        Size = UDim2.new(1, 0, 0, 28),
                                                        BackgroundTransparency = 0.8,
                                                        ClipsDescendants = true
                                                }), "Divider")

                                                local CheckBox = Create("Frame", {
                                                        Size = UDim2.new(0, 14, 0, 14),
                                                        Position = UDim2.new(1, -22, 0.5, 0),
                                                        AnchorPoint = Vector2.new(0.5, 0.5),
                                                        BackgroundColor3 = Color3.fromRGB(50, 50, 50),
                                                        BorderSizePixel = 0,
                                                        Parent = OptionBtn
                                                })
                                                Create("UICorner", {CornerRadius = UDim.new(0, 3)}).Parent = CheckBox
                                                Create("UIStroke", {
                                                        Color = Color3.fromRGB(80, 80, 80),
                                                        Thickness = 1,
                                                        Transparency = 0.3
                                                }).Parent = CheckBox

                                                local CheckIcon = Create("ImageLabel", {
                                                        Size = UDim2.new(0, 10, 0, 10),
                                                        AnchorPoint = Vector2.new(0.5, 0.5),
                                                        Position = UDim2.new(0.5, 0, 0.5, 0),
                                                        BackgroundTransparency = 1,
                                                        Image = "rbxassetid://3944680095",
                                                        ImageColor3 = Color3.fromRGB(255, 255, 255),
                                                        ImageTransparency = 1,
                                                        Parent = CheckBox
                                                })

                                                local function UpdateCheck()
                                                        local isSelected = MultiDropdown.Value[Option] == true
                                                        TweenService:Create(CheckBox, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                                BackgroundColor3 = isSelected and Color3.fromRGB(100, 100, 100) or Color3.fromRGB(50, 50, 50)
                                                        }):Play()
                                                        TweenService:Create(CheckIcon, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                                ImageTransparency = isSelected and 0 or 1
                                                        }):Play()
                                                        TweenService:Create(OptionBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                                BackgroundTransparency = isSelected and 0.3 or 0.8
                                                        }):Play()
                                                        TweenService:Create(OptionBtn.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                                                TextTransparency = isSelected and 0 or 0.4
                                                        }):Play()
                                                end

                                                UpdateCheck()

                                                AddConnection(OptionBtn.MouseButton1Click, function()
                                                        local SoundService = game:GetService("SoundService")
                                                        local sound = Instance.new("Sound", SoundService)
                                                        sound.SoundId = "rbxassetid://6895079853"
                                                        sound.Volume = 1
                                                        sound:Play()
                                                        game:GetService("Debris"):AddItem(sound, 3)

                                                        MultiDropdown.Value[Option] = not MultiDropdown.Value[Option]
                                                        UpdateCheck()
                                                        RefreshSelectedDisplay()
                                                        DropdownConfig.Callback(MultiDropdown.Value)
                                                        SaveCfg(game.GameId)
                                                end)

                                                AddConnection(OptionBtn.MouseButton1Down, function()
                                                        local SoundService = game:GetService("SoundService")
                                                        local sound = Instance.new("Sound", SoundService)
                                                        sound.SoundId = "rbxassetid://6895079853"
                                                        sound.Volume = 1
                                                        sound:Play()
                                                        game:GetService("Debris"):AddItem(sound, 3)
                                                end)

                                                MultiDropdown.Buttons[Option] = {Btn = OptionBtn, UpdateCheck = UpdateCheck}
                                        end
                                end

                                function MultiDropdown:Refresh(Options, Delete)
                                        if Delete then
                                                for _, v in pairs(MultiDropdown.Buttons) do
                                                        v.Btn:Destroy()
                                                end
                                                table.clear(MultiDropdown.Options)
                                                table.clear(MultiDropdown.Buttons)
                                                table.clear(MultiDropdown.Value)
                                        end
                                        MultiDropdown.Options = Options
                                        AddOptions(MultiDropdown.Options)
                                        RefreshSelectedDisplay()
                                end

                                function MultiDropdown:Set(Values)
                                        table.clear(MultiDropdown.Value)
                                        for _, v in pairs(Values) do
                                                if table.find(MultiDropdown.Options, v) then
                                                        MultiDropdown.Value[v] = true
                                                end
                                        end
                                        for _, btnData in pairs(MultiDropdown.Buttons) do
                                                btnData.UpdateCheck()
                                        end
                                        RefreshSelectedDisplay()
                                        DropdownConfig.Callback(MultiDropdown.Value)
                                end

                                AddConnection(Click.MouseButton1Click, function()
                                        MultiDropdown.Toggled = not MultiDropdown.Toggled
                                        DropdownFrame.F.Line.Visible = MultiDropdown.Toggled
                                        TweenService:Create(DropdownFrame.F.Ico, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = MultiDropdown.Toggled and 180 or 0}):Play()
                                        if #MultiDropdown.Options > MaxElements then
                                                TweenService:Create(DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = MultiDropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28)) or UDim2.new(1, 0, 0, 38)}):Play()
                                        else
                                                TweenService:Create(DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = MultiDropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38)}):Play()
                                        end
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        local SoundService = game:GetService("SoundService")
                                        local sound = Instance.new("Sound", SoundService)
                                        sound.SoundId = "rbxassetid://6895079853"
                                        sound.Volume = 1
                                        sound:Play()
                                        game:GetService("Debris"):AddItem(sound, 3)
                                end)

                                MultiDropdown:Refresh(MultiDropdown.Options, false)
                                RefreshSelectedDisplay()

                                if DropdownConfig.Flag then
                                        Library.Flags[DropdownConfig.Flag] = MultiDropdown
                                end
                                return MultiDropdown
                        end

                        function ElementFunction:AddBind(BindConfig)
                                BindConfig.Name = BindConfig.Name or "Bind"
                                BindConfig.Default = BindConfig.Default or Enum.KeyCode.Unknown
                                BindConfig.Hold = BindConfig.Hold or false
                                BindConfig.Callback = BindConfig.Callback or function() end
                                BindConfig.Flag = BindConfig.Flag or nil
                                BindConfig.Save = BindConfig.Save or false

                                local Bind = {Value = BindConfig.Default, Binding = false, Type = "Bind", Save = BindConfig.Save}
                                local Holding = false

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local BindBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 6), {
                                        Size = UDim2.new(0, 24, 0, 24),
                                        Position = UDim2.new(1, -12, 0.5, 0),
                                        AnchorPoint = Vector2.new(1, 0.5),
                                        BackgroundTransparency = 0.2
                                }), {
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 14), {
                                                Size = UDim2.new(1, 0, 1, 0),
                                                Font = Enum.Font.FredokaOne,
                                                TextXAlignment = Enum.TextXAlignment.Center,
                                                Name = "Value"
                                        }), "Text")
                                }), "Main")

                                local BindFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent,
                                        BackgroundTransparency = 0.25
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", BindConfig.Name, 15), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        BindBox,
                                        Click
                                }), "Second")

                                AddConnection(BindBox.Value:GetPropertyChangedSignal("Text"), function()
                                        TweenService:Create(BindBox, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, BindBox.Value.TextBounds.X + 16, 0, 24)}):Play()
                                end)

                                AddConnection(Click.InputEnded, function(Input)
                                          if UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled then
                                                  return
                                          end
                                          if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                                                  if Bind.Binding then return end
                                                  Bind.Binding = true
                                                  BindBox.Value.Text = ""
                                          end
                                  end)

                                  AddConnection(UserInputService.InputBegan, function(Input)
                                          if UserInputService:GetFocusedTextBox() then return end
                                          if Input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                                          if Input.KeyCode.Name == Bind.Value and not Bind.Binding then
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
                                                  Key = Key or Bind.Value
                                                  Bind:Set(Key)
                                                  SaveCfg(game.GameId)
                                          end
                                  end)

                                  AddConnection(UserInputService.InputEnded, function(Input)
                                          if Input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                                          if Input.KeyCode.Name == Bind.Value then
                                                  if BindConfig.Hold and Holding then
                                                          Holding = false
                                                          BindConfig.Callback(Holding)
                                                  end
                                          end
                                  end)

                                                                  AddConnection(Click.MouseEnter, function()
                                        TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
                                end)

                                AddConnection(Click.MouseLeave, function()
                                        TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.25}):Play()
                                end)

                                AddConnection(Click.MouseButton1Up, function()
                                        TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        TweenService:Create(BindFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.05}):Play()
                                        local SoundService = game:GetService("SoundService")
                                        local sound = Instance.new("Sound", SoundService)
                                        sound.SoundId = "rbxassetid://6895079853"
                                        sound.Volume = 1
                                        sound:Play()
                                        game:GetService("Debris"):AddItem(sound, 3)
                                end)

                                function Bind:Set(Key)
                                        Bind.Binding = false
                                        Bind.Value = Key or Bind.Value
                                        Bind.Value = Bind.Value.Name or Bind.Value
                                        BindBox.Value.Text = Bind.Value
                                end

                                Bind:Set(BindConfig.Default)
                                if BindConfig.Flag then                         
                                        Library.Flags[BindConfig.Flag] = Bind
                                end
                                return Bind
                        end  

                        function ElementFunction:AddTextbox(TextboxConfig)
                                TextboxConfig = TextboxConfig or {}
                                TextboxConfig.Name = TextboxConfig.Name or "Textbox"
                                TextboxConfig.Default = TextboxConfig.Default or ""
                                TextboxConfig.TextDisappear = TextboxConfig.TextDisappear or false
                                TextboxConfig.Callback = TextboxConfig.Callback or function() end

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local TextboxActual = AddFontObject(AddThemeObject(Create("TextBox", {
                                        Size = UDim2.new(1, 0, 1, 0),
                                        BackgroundTransparency = 1,
                                        TextColor3 = Color3.fromRGB(255, 255, 255),
                                        PlaceholderColor3 = Color3.fromRGB(180,180,180),
                                        PlaceholderText = "Input",
                                        Font = Library.Fonts[Library.SelectedFont] or Library.Font,
                                        TextXAlignment = Enum.TextXAlignment.Center,
                                        TextSize = 14,
                                        ClearTextOnFocus = false
                                }), "Text"))

                                local TextContainer = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 6), {
                                        Size = UDim2.new(0, 24, 0, 24),
                                        Position = UDim2.new(1, -12, 0.5, 0),
                                        AnchorPoint = Vector2.new(1, 0.5),
                                        BackgroundTransparency = 0.2
                                }), {
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        TextboxActual
                                }), "Main")

                                local TextboxFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent,
                                        BackgroundTransparency = 0.25
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", TextboxConfig.Name, 15), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 12, 0, 0),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Content"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        TextContainer,
                                        Click
                                }), "Second")

                                AddConnection(TextboxActual:GetPropertyChangedSignal("Text"), function()
                                        TweenService:Create(TextContainer, TweenInfo.new(0.45, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Size = UDim2.new(0, TextboxActual.TextBounds.X + 16, 0, 24)}):Play()
                                end)

                                AddConnection(TextboxActual.FocusLost, function()
                                        TextboxConfig.Callback(TextboxActual.Text)
                                        if TextboxConfig.TextDisappear then
                                                TextboxActual.Text = ""
                                        end     
                                end)

                                TextboxActual.Text = TextboxConfig.Default

                                AddConnection(Click.MouseEnter, function()
                                        TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
                                end)

                                AddConnection(Click.MouseLeave, function()
                                        TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.25}):Play()
                                end)

                                AddConnection(Click.MouseButton1Up, function()
                                        TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.15}):Play()
                                        TextboxActual:CaptureFocus()
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        TweenService:Create(TextboxFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {BackgroundTransparency = 0.05}):Play()
                                        local SoundService = game:GetService("SoundService")
                                        local sound = Instance.new("Sound", SoundService)
                                        sound.SoundId = "rbxassetid://6895079853"
                                        sound.Volume = 1
                                        sound:Play()
                                        game:GetService("Debris"):AddItem(sound, 3)
                                end)
                        end 

                        function ElementFunction:AddColorpicker(ColorpickerConfig)
                                ColorpickerConfig = ColorpickerConfig or {}
                                ColorpickerConfig.Name = ColorpickerConfig.Name or "Colorpicker"
                                ColorpickerConfig.Default = ColorpickerConfig.Default or Color3.fromRGB(255,255,255)
                                ColorpickerConfig.Callback = ColorpickerConfig.Callback or function() end
                                ColorpickerConfig.Flag = ColorpickerConfig.Flag or nil
                                ColorpickerConfig.Save = ColorpickerConfig.Save or false

                                local ColorH, ColorS, ColorV = 1, 1, 1
                                local Colorpicker = {Value = ColorpickerConfig.Default, Toggled = false, Type = "Colorpicker", Save = ColorpickerConfig.Save}

                                local ColorSelection = Create("ImageLabel", {
                                        Size = UDim2.new(0, 18, 0, 18),
                                        Position = UDim2.new(select(3, Color3.toHSV(Colorpicker.Value))),
                                        ScaleType = Enum.ScaleType.Fit,
                                        AnchorPoint = Vector2.new(0.5, 0.5),
                                        BackgroundTransparency = 1,
                                        Image = "http://www.roblox.com/asset/?id=4805639000"
                                })

                                local HueSelection = Create("ImageLabel", {
                                        Size = UDim2.new(0, 18, 0, 18),
                                        Position = UDim2.new(0.5, 0, 1 - select(1, Color3.toHSV(Colorpicker.Value))),
                                        ScaleType = Enum.ScaleType.Fit,
                                        AnchorPoint = Vector2.new(0.5, 0.5),
                                        BackgroundTransparency = 1,
                                        Image = "http://www.roblox.com/asset/?id=4805639000"
                                })

                                local Color = Create("ImageLabel", {
                                        Size = UDim2.new(1, -25, 1, 0),
                                        Visible = false,
                                        Image = "rbxassetid://4155801252"
                                }, {
                                        Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
                                        ColorSelection
                                })

                                local Hue = Create("Frame", {
                                        Size = UDim2.new(0, 20, 1, 0),
                                        Position = UDim2.new(1, -20, 0, 0),
                                        Visible = false
                                }, {
                                        Create("UIGradient", {Rotation = 270, Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)), ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)), ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)), ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)), ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)), ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))},}),
                                        Create("UICorner", {CornerRadius = UDim.new(0, 5)}),
                                        HueSelection
                                })

                                local ColorpickerContainer = Create("Frame", {
                                        Position = UDim2.new(0, 0, 0, 32),
                                        Size = UDim2.new(1, 0, 1, -32),
                                        BackgroundTransparency = 1,
                                        ClipsDescendants = true
                                }, {
                                        Hue,
                                        Color,
                                        Create("UIPadding", {
                                                PaddingLeft = UDim.new(0, 35),
                                                PaddingRight = UDim.new(0, 35),
                                                PaddingBottom = UDim.new(0, 10),
                                                PaddingTop = UDim.new(0, 17)
                                        })
                                })

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local ColorpickerBox = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 6), {
                                        Size = UDim2.new(0, 24, 0, 24),
                                        Position = UDim2.new(1, -12, 0.5, 0),
                                        AnchorPoint = Vector2.new(1, 0.5),
                                        BackgroundTransparency = 0.2
                                }), {
                                        AddThemeObject(MakeElement("Stroke"), "Stroke")
                                }), "Main")

                                local ColorpickerFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent,
                                        BackgroundTransparency = 0.25
                                }), {
                                        SetProps(SetChildren(MakeElement("TFrame"), {
                                                AddThemeObject(SetProps(MakeElement("Label", ColorpickerConfig.Name, 15), {
                                                        Size = UDim2.new(1, -12, 1, 0),
                                                        Position = UDim2.new(0, 12, 0, 0),
                                                        Font = Enum.Font.FredokaOne,
                                                        Name = "Content"
                                                }), "Text"),
                                                ColorpickerBox,
                                                Click,
                                                AddThemeObject(SetProps(MakeElement("Frame"), {
                                                        Size = UDim2.new(1, 0, 0, 1),
                                                        Position = UDim2.new(0, 0, 1, -1),
                                                        Name = "Line",
                                                        Visible = false,
                                                        BackgroundTransparency = 0.4
                                                }), "Stroke"), 
                                        }), {
                                                Size = UDim2.new(1, 0, 0, 38),
                                                ClipsDescendants = true,
                                                Name = "F"
                                        }),
                                        ColorpickerContainer,
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                }), "Second")

                                AddConnection(Click.MouseButton1Click, function()
                                        Colorpicker.Toggled = not Colorpicker.Toggled
                                        TweenService:Create(ColorpickerFrame,TweenInfo.new(.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = Colorpicker.Toggled and UDim2.new(1, 0, 0, 148) or UDim2.new(1, 0, 0, 38)}):Play()
                                        Color.Visible = Colorpicker.Toggled
                                        Hue.Visible = Colorpicker.Toggled
                                        ColorpickerFrame.F.Line.Visible = Colorpicker.Toggled
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        local SoundService = game:GetService("SoundService")
                                        local sound = Instance.new("Sound", SoundService)
                                        sound.SoundId = "rbxassetid://6895079853"
                                        sound.Volume = 1
                                        sound:Play()
                                        game:GetService("Debris"):AddItem(sound, 3)
                                end)

                                local function UpdateColorPicker()
                                        ColorpickerBox.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                                        Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)
                                        Colorpicker:Set(ColorpickerBox.BackgroundColor3)
                                        ColorpickerConfig.Callback(ColorpickerBox.BackgroundColor3)
                                        SaveCfg(game.GameId)
                                end

                                ColorH = 1 - (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)
                                ColorS = (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
                                ColorV = 1 - (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)

                                AddConnection(Color.InputBegan, function(input)
                                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                                                local SoundService = game:GetService("SoundService")
                                                local sound = Instance.new("Sound", SoundService)
                                                sound.SoundId = "rbxassetid://6895079853"
                                                sound.Volume = 1
                                                sound:Play()
                                                game:GetService("Debris"):AddItem(sound, 3)
                                                if ColorInput then
                                                        ColorInput:Disconnect()
                                                end
                                                ColorInput = AddConnection(RunService.RenderStepped, function()
                                                        local ColorX = (math.clamp(Mouse.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) / Color.AbsoluteSize.X)
                                                        local ColorY = (math.clamp(Mouse.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) / Color.AbsoluteSize.Y)
                                                        ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                                                        ColorS = ColorX
                                                        ColorV = 1 - ColorY
                                                        UpdateColorPicker()
                                                end)
                                        end
                                end)

                                AddConnection(Color.InputEnded, function(input)
                                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                                                if ColorInput then
                                                        ColorInput:Disconnect()
                                                end
                                        end
                                end)

                                AddConnection(Hue.InputBegan, function(input)
                                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                                                local SoundService = game:GetService("SoundService")
                                                local sound = Instance.new("Sound", SoundService)
                                                sound.SoundId = "rbxassetid://6895079853"
                                                sound.Volume = 1
                                                sound:Play()
                                                game:GetService("Debris"):AddItem(sound, 3)
                                                if HueInput then
                                                        HueInput:Disconnect()
                                                end

                                                HueInput = AddConnection(RunService.RenderStepped, function()
                                                        local HueY = (math.clamp(Mouse.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) / Hue.AbsoluteSize.Y)

                                                        HueSelection.Position = UDim2.new(0.5, 0, HueY, 0)
                                                        ColorH = 1 - HueY

                                                        UpdateColorPicker()
                                                end)
                                        end
                                end)

                                AddConnection(Hue.InputEnded, function(input)
                                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                                                if HueInput then
                                                        HueInput:Disconnect()
                                                end
                                        end
                                end)

                                function Colorpicker:Set(Value)
                                        Colorpicker.Value = Value
                                        ColorpickerBox.BackgroundColor3 = Colorpicker.Value
                                        ColorpickerConfig.Callback(Colorpicker.Value)
                                end

                                Colorpicker:Set(Colorpicker.Value)
                                if ColorpickerConfig.Flag then                          
                                        Library.Flags[ColorpickerConfig.Flag] = Colorpicker
                                end
                                return Colorpicker
                        end

                        function ElementFunction:AddThemePicker()
                                local ThemeNames = {}
                                for name, _ in pairs(Library.Themes) do
                                        table.insert(ThemeNames, name)
                                end
                                table.sort(ThemeNames)

                                local PickerFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255,255,255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 60),
                                        Parent = ItemParent,
                                        BackgroundTransparency = 0.25
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Label", "Theme", 15), {
                                                Size = UDim2.new(1, -12, 0, 18),
                                                Position = UDim2.new(0, 12, 0, 6),
                                                Font = Enum.Font.FredokaOne,
                                                Name = "Title"
                                        }), "Text"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke")
                                }), "Second")

                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                                        }),
                                        Rotation = 90
                                }).Parent = PickerFrame

                                local ButtonRow = Create("ScrollingFrame", {
                                        Size = UDim2.new(1, -16, 0, 28),
                                        Position = UDim2.new(0, 8, 0, 28),
                                        BackgroundTransparency = 1,
                                        ScrollBarThickness = 0,
                                        CanvasSize = UDim2.new(0, 0, 0, 0),
                                        Parent = PickerFrame
                                })
                                local RowLayout = Create("UIListLayout", {
                                        FillDirection = Enum.FillDirection.Horizontal,
                                        SortOrder = Enum.SortOrder.LayoutOrder,
                                        Padding = UDim.new(0, 5),
                                        Parent = ButtonRow
                                })

                                RowLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                                        ButtonRow.CanvasSize = UDim2.new(0, RowLayout.AbsoluteContentSize.X + 8, 0, 0)
                                end)

                                for _, name in ipairs(ThemeNames) do
                                        local ThemeColor = Library.Themes[name].Accent or Library.Themes[name].Main
                                        local Btn = Create("TextButton", {
                                                Size = UDim2.new(0, 26, 0, 26),
                                                BackgroundColor3 = ThemeColor,
                                                BorderSizePixel = 0,
                                                Text = "",
                                                AutoButtonColor = false,
                                                Parent = ButtonRow
                                        })
                                        Create("UICorner", {CornerRadius = UDim.new(0, 6)}).Parent = Btn
                                        Create("UIStroke", {
                                                Color = Color3.fromRGB(255, 255, 255),
                                                Thickness = Library.SelectedTheme == name and 2 or 0,
                                                Transparency = 0.3,
                                                Name = "Outline"
                                        }).Parent = Btn

                                        local ThemeLabel = Create("TextLabel", {
                                                Size = UDim2.new(1, 0, 0, 10),
                                                Position = UDim2.new(0, 0, 1, 2),
                                                BackgroundTransparency = 1,
                                                Text = name,
                                                TextSize = 8,
                                                Font = Enum.Font.Gotham,
                                                TextColor3 = Color3.fromRGB(200, 200, 200),
                                                TextXAlignment = Enum.TextXAlignment.Center,
                                                Parent = Btn
                                        })

                                        Btn.MouseButton1Click:Connect(function()
                                                for _, child in pairs(ButtonRow:GetChildren()) do
                                                        if child:IsA("TextButton") then
                                                                local outline = child:FindFirstChild("Outline")
                                                                if outline then outline.Thickness = 0 end
                                                        end
                                                end
                                                Btn.Outline.Thickness = 2
                                                Library:SetTheme(name)
                                                local SoundService = game:GetService("SoundService")
                                                local sound = Instance.new("Sound", SoundService)
                                                sound.SoundId = "rbxassetid://6895079853"
                                                sound.Volume = 1
                                                sound:Play()
                                                game:GetService("Debris"):AddItem(sound, 3)
                                        end)
                                end
                        end

                        function ElementFunction:AddFontPicker()
                                local FontNames = {}
                                for name, _ in pairs(Library.Fonts) do
                                        table.insert(FontNames, name)
                                end
                                table.sort(FontNames)

                                local FontDropdown = {Toggled = false}
                                local MaxElements = 5

                                local DropdownList = MakeElement("List")

                                local DropdownContainer = AddThemeObject(SetProps(SetChildren(MakeElement("ScrollFrame", Color3.fromRGB(40, 40, 40), 4), {
                                        DropdownList
                                }), {
                                        Parent = ItemParent,
                                        Position = UDim2.new(0, 0, 0, 38),
                                        Size = UDim2.new(1, 0, 1, -38),
                                        ClipsDescendants = true
                                }), "Divider")

                                local Click = SetProps(MakeElement("Button"), {
                                        Size = UDim2.new(1, 0, 1, 0)
                                })

                                local DropdownFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 38),
                                        Parent = ItemParent,
                                        ClipsDescendants = true,
                                        BackgroundTransparency = 0.25
                                }), {
                                        DropdownContainer,
                                        SetProps(SetChildren(MakeElement("TFrame"), {
                                                AddThemeObject(SetProps(MakeElement("Label", "Font", 15), {
                                                        Size = UDim2.new(1, -12, 1, 0),
                                                        Position = UDim2.new(0, 12, 0, 0),
                                                        Font = Enum.Font.FredokaOne,
                                                        Name = "Content"
                                                }), "Text"),
                                                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://7072706796"), {
                                                        Size = UDim2.new(0, 20, 0, 20),
                                                        AnchorPoint = Vector2.new(0, 0.5),
                                                        Position = UDim2.new(1, -30, 0.5, 0),
                                                        ImageColor3 = Color3.fromRGB(240, 240, 240),
                                                        Name = "Ico"
                                                }), "TextDark"),
                                                AddThemeObject(SetProps(MakeElement("Label", Library.SelectedFont, 13), {
                                                        Size = UDim2.new(1, -40, 1, 0),
                                                        Font = Enum.Font.FredokaOne,
                                                        Name = "Selected",
                                                        TextXAlignment = Enum.TextXAlignment.Right
                                                }), "TextDark"),
                                                AddThemeObject(SetProps(MakeElement("Frame"), {
                                                        Size = UDim2.new(1, 0, 0, 1),
                                                        Position = UDim2.new(0, 0, 1, -1),
                                                        Name = "Line",
                                                        Visible = false,
                                                        BackgroundTransparency = 0.4
                                                }), "Stroke"),
                                                Click
                                        }), {
                                                Size = UDim2.new(1, 0, 0, 38),
                                                ClipsDescendants = true,
                                                Name = "F"
                                        }),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        MakeElement("Corner")
                                }), "Second")

                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                                        }),
                                        Rotation = 90
                                }).Parent = DropdownFrame

                                AddConnection(DropdownList:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                                        DropdownContainer.CanvasSize = UDim2.new(0, 0, 0, DropdownList.AbsoluteContentSize.Y)
                                end)

                                local Buttons = {}
                                for _, name in ipairs(FontNames) do
                                        local OptionBtn = AddThemeObject(SetProps(SetChildren(MakeElement("Button", Color3.fromRGB(40, 40, 40)), {
                                                MakeElement("Corner", 0, 6),
                                                AddThemeObject(SetProps(MakeElement("Label", name, 13, 0.4), {
                                                        Position = UDim2.new(0, 8, 0, 0),
                                                        Size = UDim2.new(1, -8, 1, 0),
                                                        Name = "Title",
                                                        Font = Library.Fonts[name] or Enum.Font.Gotham
                                                }), "Text")
                                        }), {
                                                Parent = DropdownContainer,
                                                Size = UDim2.new(1, 0, 0, 28),
                                                BackgroundTransparency = Library.SelectedFont == name and 0.3 or 0.8,
                                                ClipsDescendants = true
                                        }), "Divider")

                                        OptionBtn.Title.TextTransparency = Library.SelectedFont == name and 0 or 0.4

                                        AddConnection(OptionBtn.MouseButton1Click, function()
                                                local SoundService = game:GetService("SoundService")
                                                local sound = Instance.new("Sound", SoundService)
                                                sound.SoundId = "rbxassetid://6895079853"
                                                sound.Volume = 1
                                                sound:Play()
                                                game:GetService("Debris"):AddItem(sound, 3)

                                                for _, v in pairs(Buttons) do
                                                        TweenService:Create(v.btn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.8}):Play()
                                                        TweenService:Create(v.btn.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {TextTransparency = 0.4}):Play()
                                                end
                                                TweenService:Create(OptionBtn, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {BackgroundTransparency = 0.3}):Play()
                                                TweenService:Create(OptionBtn.Title, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {TextTransparency = 0}):Play()
                                                DropdownFrame.F.Selected.Text = name
                                                Library:SetFont(name)
                                        end)

                                        Buttons[name] = {btn = OptionBtn}
                                end

                                AddConnection(Click.MouseButton1Click, function()
                                        FontDropdown.Toggled = not FontDropdown.Toggled
                                        DropdownFrame.F.Line.Visible = FontDropdown.Toggled
                                        TweenService:Create(DropdownFrame.F.Ico, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = FontDropdown.Toggled and 180 or 0}):Play()
                                        if #FontNames > MaxElements then
                                                TweenService:Create(DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = FontDropdown.Toggled and UDim2.new(1, 0, 0, 38 + (MaxElements * 28)) or UDim2.new(1, 0, 0, 38)}):Play()
                                        else
                                                TweenService:Create(DropdownFrame, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = FontDropdown.Toggled and UDim2.new(1, 0, 0, DropdownList.AbsoluteContentSize.Y + 38) or UDim2.new(1, 0, 0, 38)}):Play()
                                        end
                                end)

                                AddConnection(Click.MouseButton1Down, function()
                                        local SoundService = game:GetService("SoundService")
                                        local sound = Instance.new("Sound", SoundService)
                                        sound.SoundId = "rbxassetid://6895079853"
                                        sound.Volume = 1
                                        sound:Play()
                                        game:GetService("Debris"):AddItem(sound, 3)
                                end)
                        end

                        function ElementFunction:AddSearch(SearchConfig)
                                SearchConfig = SearchConfig or {}
                                SearchConfig.Placeholder = SearchConfig.Placeholder or "Search..."

                                local SearchActual = AddFontObject(AddThemeObject(Create("TextBox", {
                                        Size = UDim2.new(1, -16, 1, 0),
                                        Position = UDim2.new(0, 8, 0, 0),
                                        BackgroundTransparency = 1,
                                        TextColor3 = Color3.fromRGB(255, 255, 255),
                                        PlaceholderColor3 = Color3.fromRGB(160, 160, 160),
                                        PlaceholderText = SearchConfig.Placeholder,
                                        Font = Library.Fonts[Library.SelectedFont] or Library.Font,
                                        TextXAlignment = Enum.TextXAlignment.Left,
                                        TextSize = 14,
                                        ClearTextOnFocus = false,
                                        Text = ""
                                }), "Text"))

                                local SearchFrame = AddThemeObject(SetChildren(SetProps(MakeElement("RoundFrame", Color3.fromRGB(255, 255, 255), 0, 8), {
                                        Size = UDim2.new(1, 0, 0, 32),
                                        Parent = ItemParent,
                                        BackgroundTransparency = 0.25,
                                        LayoutOrder = -9999
                                }), {
                                        AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3926305904"), {
                                                Size = UDim2.new(0, 16, 0, 16),
                                                Position = UDim2.new(1, -24, 0.5, 0),
                                                AnchorPoint = Vector2.new(0, 0.5),
                                                ImageRectOffset = Vector2.new(964, 324),
                                                ImageRectSize = Vector2.new(36, 36),
                                                ImageTransparency = 0.4
                                        }), "TextDark"),
                                        AddThemeObject(MakeElement("Stroke"), "Stroke"),
                                        SearchActual
                                }), "Second")

                                Create("UIGradient", {
                                        Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(28, 28, 28)),
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 20))
                                        }),
                                        Rotation = 90
                                }).Parent = SearchFrame

                                local function getElementText(child)
                                        for _, lbl in ipairs(child:GetDescendants()) do
                                                if lbl:IsA("TextLabel") and (lbl.Name == "Content" or lbl.Name == "Title") then
                                                        return lbl.Text or ""
                                                end
                                        end
                                        return ""
                                end

                                AddConnection(SearchActual:GetPropertyChangedSignal("Text"), function()
                                        local query = string.lower(SearchActual.Text or "")
                                        for _, child in ipairs(ItemParent:GetChildren()) do
                                                if child ~= SearchFrame and (child:IsA("Frame") or child:IsA("TextButton")) then
                                                        if query == "" then
                                                                child.Visible = true
                                                        else
                                                                local txt = string.lower(getElementText(child))
                                                                child.Visible = txt ~= "" and string.find(txt, query, 1, true) ~= nil
                                                        end
                                                end
                                        end
                                end)

                                local SearchObj = {}
                                function SearchObj:Set(text)
                                        SearchActual.Text = text or ""
                                end
                                function SearchObj:Clear()
                                        SearchActual.Text = ""
                                end
                                return SearchObj
                        end

                        function ElementFunction:AddConfigSection(ConfigSectionConfig)
                                ConfigSectionConfig = ConfigSectionConfig or {}

                                local currentName    = ""
                                local selectedConfig = ""
                                local currentId      = ""
                                local saveAsName     = ""

                                local function getList()
                                        local list = Library:ListConfigs() or {}
                                        if #list == 0 then list = {"(no configs)"} end
                                        return list
                                end

                                ElementFunction:AddTextbox({
                                        Name = "New Config Name",
                                        Default = "",
                                        TextDisappear = false,
                                        Callback = function(text) currentName = text end
                                })

                                ElementFunction:AddButton({
                                        Name = "Save Current Config",
                                        Callback = function()
                                                if currentName == "" then
                                                        Library:MakeNotification({Name = "Config", Content = "Enter a config name first.", Time = 4})
                                                        return
                                                end
                                                Library:CreateConfig(currentName)
                                                if _G.__XeioaConfigDropdown then
                                                        _G.__XeioaConfigDropdown:Refresh(getList(), true)
                                                end
                                        end
                                })

                                local configDropdown = ElementFunction:AddDropdown({
                                        Name = "Saved Configs",
                                        Default = "",
                                        Options = getList(),
                                        Callback = function(value)
                                                if value == "(no configs)" then
                                                        selectedConfig = ""
                                                else
                                                        selectedConfig = value or ""
                                                end
                                        end
                                })
                                _G.__XeioaConfigDropdown = configDropdown

                                ElementFunction:AddButton({
                                        Name = "Refresh List",
                                        Callback = function()
                                                configDropdown:Refresh(getList(), true)
                                                Library:MakeNotification({Name = "Config", Content = "Config list refreshed.", Time = 3})
                                        end
                                })

                                ElementFunction:AddButton({
                                        Name = "Load Selected",
                                        Callback = function()
                                                if selectedConfig == "" then
                                                        Library:MakeNotification({Name = "Config", Content = "Pick a config from the dropdown first.", Time = 4})
                                                        return
                                                end
                                                Library:UseConfig(selectedConfig)
                                        end
                                })

                                ElementFunction:AddButton({
                                        Name = "Delete Selected",
                                        Callback = function()
                                                if selectedConfig == "" then
                                                        Library:MakeNotification({Name = "Config", Content = "Pick a config from the dropdown first.", Time = 4})
                                                        return
                                                end
                                                Library:DeleteConfig(selectedConfig)
                                                selectedConfig = ""
                                                configDropdown:Refresh(getList(), true)
                                        end
                                })

                                ElementFunction:AddButton({
                                        Name = "Auto-Load Selected",
                                        Callback = function()
                                                if selectedConfig == "" then
                                                        Library:MakeNotification({Name = "Config", Content = "Pick a config from the dropdown first.", Time = 4})
                                                        return
                                                end
                                                Library:AutoLoadConfig(selectedConfig)
                                        end
                                })

                                ElementFunction:AddButton({
                                        Name = "Disable Auto-Load",
                                        Callback = function()
                                                Library:UnAutoLoadConfig()
                                        end
                                })

                                ElementFunction:AddButton({
                                        Name = "Share Selected (copy ID)",
                                        Callback = function()
                                                if selectedConfig == "" then
                                                        Library:MakeNotification({Name = "Config", Content = "Pick a config from the dropdown first.", Time = 4})
                                                        return
                                                end
                                                Library:ShareConfigId(selectedConfig)
                                        end
                                })

                                ElementFunction:AddTextbox({
                                        Name = "Config ID",
                                        Default = "",
                                        TextDisappear = false,
                                        Callback = function(text) currentId = text end
                                })

                                ElementFunction:AddButton({
                                        Name = "Use Config ID",
                                        Callback = function()
                                                if currentId == "" then
                                                        Library:MakeNotification({Name = "Config", Content = "Paste a Config ID first.", Time = 4})
                                                        return
                                                end
                                                Library:UseConfigId(currentId)
                                        end
                                })

                                ElementFunction:AddTextbox({
                                        Name = "Save ID As",
                                        Default = "",
                                        TextDisappear = false,
                                        Callback = function(text) saveAsName = text end
                                })

                                ElementFunction:AddButton({
                                        Name = "Save Config from ID",
                                        Callback = function()
                                                if saveAsName == "" or currentId == "" then
                                                        Library:MakeNotification({Name = "Config", Content = "Need both a Config ID and a 'Save As' name.", Time = 4})
                                                        return
                                                end
                                                Library:SaveConfigId(saveAsName, currentId)
                                                configDropdown:Refresh(getList(), true)
                                        end
                                })

                                return {
                                        SetName    = function(_, n) currentName = n end,
                                        SetId      = function(_, i) currentId = i end,
                                        Refresh    = function() configDropdown:Refresh(getList(), true) end,
                                        Dropdown   = configDropdown
                                }
                        end

                        return ElementFunction  
                end     

                local ElementFunction = {}

                function ElementFunction:AddSection(SectionConfig)
                        if type(SectionConfig) == "string" then
                                SectionConfig = {Name = SectionConfig}
                        end
                        SectionConfig = SectionConfig or {}
                        SectionConfig.Name = SectionConfig.Name or "Section"

                        local StrichFrame = Instance.new("Frame")
                        StrichFrame.Size = UDim2.new(0, 3, 0, 14)
                        StrichFrame.Position = UDim2.new(0, 0, 0.5, 0)
                        StrichFrame.AnchorPoint = Vector2.new(0, 0.5)
                        StrichFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        StrichFrame.BorderSizePixel = 0
                        StrichFrame.BackgroundTransparency = 0
                        Create("UIGradient", {
                                Color = ColorSequence.new({
                                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                                        ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160))
                                }),
                                Rotation = 90
                        }).Parent = StrichFrame
                        local StrichCorner = Instance.new("UICorner")
                        StrichCorner.CornerRadius = UDim.new(0, 100)
                        StrichCorner.Parent = StrichFrame

                        local SectionFrame = SetChildren(SetProps(MakeElement("TFrame"), {
                                Size = UDim2.new(1, 0, 0, 26),
                                Parent = Container
                        }), {
                                SetChildren(SetProps(MakeElement("TFrame"), {
                                        Size = UDim2.new(1, 0, 0, 16),
                                        Position = UDim2.new(0, 0, 0, 3),
                                }), {
                                        StrichFrame,
                                        AddThemeObject(SetProps(MakeElement("Label", SectionConfig.Name, 14), {
                                                Size = UDim2.new(1, -12, 1, 0),
                                                Position = UDim2.new(0, 10, 0, 0),
                                                Font = Enum.Font.FredokaOne
                                        }), "TextDark"),
                                }),
                                SetChildren(SetProps(MakeElement("TFrame"), {
                                        AnchorPoint = Vector2.new(0, 0),
                                        Size = UDim2.new(1, 0, 1, -24),
                                        Position = UDim2.new(0, 0, 0, 23),
                                        Name = "Holder"
                                }), {
                                        MakeElement("List", 0, 6)
                                }),
                        })

                        AddConnection(SectionFrame.Holder.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"), function()
                                SectionFrame.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y + 31)
                                SectionFrame.Holder.Size = UDim2.new(1, 0, 0, SectionFrame.Holder.UIListLayout.AbsoluteContentSize.Y)
                        end)

                        local SectionFunction = {}
                        for i, v in next, GetElements(SectionFrame.Holder) do
                                SectionFunction[i] = v 
                        end
                        return SectionFunction
                end

                for i, v in next, GetElements(Container) do
                        ElementFunction[i] = v 
                end

                if TabConfig.PremiumOnly then
                        for i, v in next, ElementFunction do
                                ElementFunction[i] = function() end
                        end   
                        Container:FindFirstChild("UIListLayout"):Destroy()
                        Container:FindFirstChild("UIPadding"):Destroy()
                        SetChildren(SetProps(MakeElement("TFrame"), {
                                Size = UDim2.new(1, 0, 1, 0),
                                Parent = ItemParent
                        }), {
                                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://3610239960"), {
                                        Size = UDim2.new(0, 18, 0, 18),
                                        Position = UDim2.new(0, 15, 0, 15),
                                        ImageTransparency = 0.4
                                }), "Text"),
                                AddThemeObject(SetProps(MakeElement("Label", "Unauthorised Access", 14), {
                                        Size = UDim2.new(1, -38, 0, 14),
                                        Position = UDim2.new(0, 38, 0, 18),
                                        TextTransparency = 0.4
                                }), "Text"),
                                AddThemeObject(SetProps(MakeElement("Image", "rbxassetid://4483345875"), {
                                        Size = UDim2.new(0, 56, 0, 56),
                                        Position = UDim2.new(0, 84, 0, 110),
                                }), "Text"),
                                AddThemeObject(SetProps(MakeElement("Label", "Premium Features", 14), {
                                        Size = UDim2.new(1, -150, 0, 14),
                                        Position = UDim2.new(0, 150, 0, 112),
                                        Font = Enum.Font.FredokaOne
                                }), "Text"),
                                AddThemeObject(SetProps(MakeElement("Label", "This part of the script is locked. Join the Discord for access.", 12), {
                                        Size = UDim2.new(1, -200, 0, 14),
                                        Position = UDim2.new(0, 150, 0, 138),
                                        TextWrapped = true,
                                        TextTransparency = 0.4
                                }), "Text")
                        })
                end
                return ElementFunction  
        end  

        return TabFunction
end

function Library:MakeNotifi(Configs)
        local Title = Configs.Title or "Title!"
        local text = Configs.Text or "Notification content..."
        local timewait = Configs.Time or 5

        local Frame1 = Create2("Frame", Menu_Notifi, {
                Size = UDim2.new(2, 0, 0, 0),
                BackgroundTransparency = 1,
                AutomaticSize = "Y",
                Name = "Title"
        })

        local Frame2 = Create2("Frame", Frame1, {
                Size = UDim2.new(0, Menu_Notifi.Size.X.Offset - 50, 0, 0),
                BackgroundColor3 = Configs_HUB.Cor_Hub,
                Position = UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0),
                AutomaticSize = "Y",
                BackgroundTransparency = 0.1
        })
        Corner2(Frame2)

        local notifGrad = Create2("UIGradient", Frame2, {
                Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 20)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(5, 5, 5))
                }),
                Rotation = 90
        })

        local TextLabel1 = AddFontObject(Create2("TextLabel", Frame2, {
                Size = UDim2.new(1, 0, 0, 25),
                Font = Library.Fonts[Library.SelectedFont] or Library.Font,
                BackgroundTransparency = 1,
                Text = Title,
                TextSize = 20,
                Position = UDim2.new(0, 20, 0, 5),
                TextXAlignment = "Left",
                TextColor3 = Configs_HUB.Cor_Text
        }))

        local TextButton = AddFontObject(Create2("TextButton", Frame2, {
                Text = "X",
                Font = Library.Fonts[Library.SelectedFont] or Library.Font,
                TextSize = 20,
                BackgroundTransparency = 1,
                TextColor3 = Color3.fromRGB(180, 180, 180),
                Position = UDim2.new(1, -5, 0, 5),
                AnchorPoint = Vector2.new(1, 0),
                Size = UDim2.new(0, 25, 0, 25)
        }))
        Corner2(TextButton, {CornerRadius = UDim.new(0, 6)})

        AddConnection(TextButton.MouseButton1Down, function()
                local SoundService = game:GetService("SoundService")
                local sound = Instance.new("Sound", SoundService)
                sound.SoundId = "rbxassetid://6895079853"
                sound.Volume = 1
                sound:Play()
                game:GetService("Debris"):AddItem(sound, 3)
        end)

        local TextLabel2 = AddFontObject(Create2("TextLabel", Frame2, {
                Size = UDim2.new(1, -30, 0, 0),
                Position = UDim2.new(0, 20, 0, TextButton.Size.Y.Offset + 10),
                TextSize = 15,
                TextColor3 = Configs_HUB.Cor_DarkText,
                TextXAlignment = "Left",
                TextYAlignment = "Top",
                AutomaticSize = "Y",
                Text = text,
                Font = Library.Fonts[Library.SelectedFont] or Library.Font,
                BackgroundTransparency = 1,
                TextWrapped = true
        }))

        local FrameSize = Create2("Frame", Frame2, {
                Size = UDim2.new(1, 0, 0, 2),
                BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                Position = UDim2.new(0, 2, 0, 30),
                BorderSizePixel = 0,
                BackgroundTransparency = 0.5
        })
        Create2("UIGradient", FrameSize, {
                Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
                })
        })
        Corner2(FrameSize, {CornerRadius = UDim.new(0, 4)})
        Create2("Frame", Frame2, {
                Size = UDim2.new(0, 0, 0, 5),
                Position = UDim2.new(0, 0, 1, 5),
                BackgroundTransparency = 1
        })

        task.spawn(function()
                CreateTween(FrameSize, "Size", UDim2.new(0, 0, 0, 2), timewait, true)
        end)

        TextButton.MouseButton1Click:Connect(function()
                CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
                CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
                Frame1:Destroy()
        end)
        task.spawn(function()
                CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.5, true)
                CreateTween(Frame2, "Position", UDim2.new(), 0.1, true)
                task.wait(timewait)
                if Frame2 then
                        CreateTween(Frame2, "Position", UDim2.new(0, -20, 0, 0), 0.1, true)
                        CreateTween(Frame2, "Position", UDim2.new(0, Menu_Notifi.Size.X.Offset, 0, 0), 0.5, true)
                        Frame1:Destroy()
                end
        end)
end

function Library:Destroy()
        Container:Destroy()
end

local function _b64_encode(data)
        local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        return ((data:gsub('.', function(x)
                local r, byte = '', x:byte()
                for i = 8, 1, -1 do r = r .. (byte % 2 ^ i - byte % 2 ^ (i - 1) > 0 and '1' or '0') end
                return r
        end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
                if (#x < 6) then return '' end
                local c = 0
                for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0) end
                return b:sub(c + 1, c + 1)
        end) .. ({ '', '==', '=' })[#data % 3 + 1])
end

local function _b64_decode(data)
        local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
        data = string.gsub(data, '[^' .. b .. '=]', '')
        return (data:gsub('.', function(x)
                if (x == '=') then return '' end
                local r, f = '', (b:find(x) - 1)
                for i = 6, 1, -1 do r = r .. (f % 2 ^ i - f % 2 ^ (i - 1) > 0 and '1' or '0') end
                return r
        end):gsub('%d%d%d?%d?%d?%d?%d?%d?', function(x)
                if (#x ~= 8) then return '' end
                local c = 0
                for i = 1, 8 do c = c + (x:sub(i, i) == '1' and 2 ^ (8 - i) or 0) end
                return string.char(c)
        end))
end

local function _checkExecutor()
        if not writefile or not readfile or not isfile or not isfolder or not makefolder then
                warn("Config: executor file functions are not available")
                return false
        end
        if not Library.Folder then
                warn("Config: Library.Folder is not set (call MakeWindow first)")
                return false
        end
        return true
end

local function _ensureFolders()
        if not isfolder(Library.Folder) then makefolder(Library.Folder) end
        if not isfolder(Library.Folder .. "/configs") then makefolder(Library.Folder .. "/configs") end
end

local function _configPath(name)
        return Library.Folder .. "/configs/" .. tostring(name) .. ".txt"
end

local function _serializeFlags()
        local Data = {}
        for i, v in pairs(Library.Flags) do
                if v.Type == "Colorpicker" then
                        Data[i] = PackColor(v.Value)
                else
                        Data[i] = v.Value
                end
        end
        return HttpService:JSONEncode(Data)
end

function Library:CreateConfig(name)
        if not name or name == "" then
                warn("CreateConfig: name is required")
                return false
        end
        if not _checkExecutor() then return false end
        local ok, err = pcall(function()
                _ensureFolders()
                writefile(_configPath(name), _serializeFlags())
        end)
        if not ok then
                warn("CreateConfig error:", err)
                return false
        end
        Library:MakeNotification({
                Name = "Config Saved",
                Content = "Config '" .. name .. "' was created.",
                Time = 4
        })
        return true
end

function Library:UseConfig(name)
        if not name or name == "" then
                warn("UseConfig: name is required")
                return false
        end
        if not _checkExecutor() then return false end
        local path = _configPath(name)
        if not isfile(path) then
                warn("UseConfig: config '" .. name .. "' does not exist")
                Library:MakeNotification({
                        Name = "Config Error",
                        Content = "Config '" .. name .. "' was not found.",
                        Time = 4
                })
                return false
        end
        local ok, err = pcall(function()
                LoadCfg(readfile(path))
        end)
        if not ok then
                warn("UseConfig error:", err)
                return false
        end
        Library:MakeNotification({
                Name = "Config Loaded",
                Content = "Loaded config '" .. name .. "'.",
                Time = 4
        })
        return true
end

function Library:DeleteConfig(name)
        if not name or name == "" then
                warn("DeleteConfig: name is required")
                return false
        end
        if not _checkExecutor() then return false end
        local path = _configPath(name)
        if not isfile(path) then
                warn("DeleteConfig: config '" .. name .. "' does not exist")
                return false
        end
        local ok, err = pcall(function()
                if delfile then
                        delfile(path)
                else
                        writefile(path, "")
                end
                local autoPath = Library.Folder .. "/autoload.txt"
                if isfile(autoPath) and readfile(autoPath) == name then
                        if delfile then delfile(autoPath) else writefile(autoPath, "") end
                end
        end)
        if not ok then
                warn("DeleteConfig error:", err)
                return false
        end
        Library:MakeNotification({
                Name = "Config Deleted",
                Content = "Config '" .. name .. "' was removed.",
                Time = 4
        })
        return true
end

function Library:AutoLoadConfig(name)
        if not name or name == "" then
                warn("AutoLoadConfig: name is required")
                return false
        end
        if not _checkExecutor() then return false end
        if not isfile(_configPath(name)) then
                warn("AutoLoadConfig: config '" .. name .. "' does not exist")
                return false
        end
        local ok, err = pcall(function()
                _ensureFolders()
                writefile(Library.Folder .. "/autoload.txt", name)
        end)
        if not ok then
                warn("AutoLoadConfig error:", err)
                return false
        end
        Library:MakeNotification({
                Name = "Auto-Load Set",
                Content = "Config '" .. name .. "' will auto-load on next launch.",
                Time = 4
        })
        return true
end

function Library:UnAutoLoadConfig()
        if not _checkExecutor() then return false end
        local autoPath = Library.Folder .. "/autoload.txt"
        if not isfile(autoPath) then
                return true
        end
        local ok, err = pcall(function()
                if delfile then
                        delfile(autoPath)
                else
                        writefile(autoPath, "")
                end
        end)
        if not ok then
                warn("UnAutoLoadConfig error:", err)
                return false
        end
        Library:MakeNotification({
                Name = "Auto-Load Cleared",
                Content = "Auto-load was disabled.",
                Time = 4
        })
        return true
end

function Library:ShareConfigId(name)
        if not name or name == "" then
                warn("ShareConfigId: name is required")
                return nil
        end
        if not _checkExecutor() then return nil end
        local path = _configPath(name)
        if not isfile(path) then
                warn("ShareConfigId: config '" .. name .. "' does not exist")
                return nil
        end
        local id
        local ok, err = pcall(function()
                local raw = readfile(path)
                id = _b64_encode(raw)
                if setclipboard then setclipboard(id) end
        end)
        if not ok then
                warn("ShareConfigId error:", err)
                return nil
        end
        Library:MakeNotification({
                Name = "Config Shared",
                Content = setclipboard and "Config ID copied to clipboard." or "Config ID generated.",
                Time = 4
        })
        return id
end

function Library:UseConfigId(id)
        if not id or id == "" then
                warn("UseConfigId: id is required")
                return false
        end
        local ok, err = pcall(function()
                local raw = _b64_decode(id)
                LoadCfg(raw)
        end)
        if not ok then
                warn("UseConfigId error:", err)
                Library:MakeNotification({
                        Name = "Config Error",
                        Content = "Invalid config ID.",
                        Time = 4
                })
                return false
        end
        Library:MakeNotification({
                Name = "Config Loaded",
                Content = "Loaded config from shared ID.",
                Time = 4
        })
        return true
end

function Library:SaveConfigId(name, id)
        if not name or name == "" then
                warn("SaveConfigId: name is required")
                return false
        end
        if not id or id == "" then
                warn("SaveConfigId: id is required")
                return false
        end
        if not _checkExecutor() then return false end
        local ok, err = pcall(function()
                _ensureFolders()
                local raw = _b64_decode(id)
                HttpService:JSONDecode(raw)
                writefile(_configPath(name), raw)
        end)
        if not ok then
                warn("SaveConfigId error:", err)
                Library:MakeNotification({
                        Name = "Config Error",
                        Content = "Failed to save config ID.",
                        Time = 4
                })
                return false
        end
        Library:MakeNotification({
                Name = "Config Saved",
                Content = "Config '" .. name .. "' was saved from ID.",
                Time = 4
        })
        return true
end

function Library:ListConfigs()
        if not _checkExecutor() then return {} end
        local list = {}
        if not listfiles then return list end
        local ok, files = pcall(listfiles, Library.Folder .. "/configs")
        if not ok or not files then return list end
        for _, file in ipairs(files) do
                local n = file:match("([^/\\]+)%.txt$")
                if n then table.insert(list, n) end
        end
        return list
end

-- ============ ZUSÄTZLICHE FUNKTIONEN FÜR NOTIFIKATIONEN ============

local Configs_HUB = {
        Cor_Hub = Color3.fromRGB(10, 10, 10),
        Cor_Options = Color3.fromRGB(10, 10, 10),
        Cor_Stroke = Color3.fromRGB(55, 55, 55),
        Cor_Text = Color3.fromRGB(240, 240, 240),
        Cor_DarkText = Color3.fromRGB(140, 140, 140),
        Corner_Radius = UDim.new(0, 4),
        Text_Font = Library.Font
}

local TweenService2 = game:GetService("TweenService")

local function Create2(instance, parent, props)
        local new = Instance.new(instance, parent)
        if props then
                table.foreach(props, function(prop, value)
                        new[prop] = value
                end)
        end
        return new
end

local function SetProps2(instance, props)
        if instance and props then
                table.foreach(props, function(prop, value)
                        instance[prop] = value
                end)
        end
        return instance
end

local function Corner2(parent, props)
        local new = Create2("UICorner", parent)
        new.CornerRadius = Configs_HUB.Corner_Radius
        if props then
                SetProps2(new, props)
        end
        return new
end

local function Stroke2(parent, props)
        local new = Create2("UIStroke", parent)
        new.Color = Configs_HUB.Cor_Stroke
        new.ApplyStrokeMode = "Border"
        new.Transparency = 0.3
        if props then
                SetProps2(new, props)
        end
        return new
end

local function CreateTween(instance, prop, value, time, tweenWait)
        local tween = TweenService2:Create(instance,
                TweenInfo.new(time, Enum.EasingStyle.Linear),
                {[prop] = value})
        tween:Play()
        if tweenWait then
                tween.Completed:Wait()
        end
end

local Menu_Notifi = Create2("Frame", Container, {
        Size = UDim2.new(0, 300, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1
})

Create2("UIPadding", Menu_Notifi, {
        PaddingLeft = UDim.new(0, 25),
        PaddingTop = UDim.new(0, 25),
        PaddingBottom = UDim.new(0, 50)
})

Create2("UIListLayout", Menu_Notifi, {
        Padding = UDim.new(0, 15),
        VerticalAlignment = "Bottom"
})

return Library
