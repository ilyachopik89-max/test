local U62, U63, U64, U65, U66, U67, U68, U69, U70, U71
local U72, U73, U74, U75, U76, U77, U78, U79, U80, U81
local U82, U83, U84, U85, U86, L0_312, U87, U88, U89, U90
local U91, U92, U93, U94, U95, U96, U97, U98, U99, U100

do
	do
		if game.PlaceId ~= 6961824067 then
			-- game:GetService("Players").LocalPlayer:Kick("FTAP SCRIPT")
			-- return
		end

		pcall(function()
			if getgenv then
				if typeof(getgenv().SilentTarget_Unload) == "function" then
					pcall(getgenv().SilentTarget_Unload)
					getgenv().SilentTarget_Unload = nil
				end

				if getgenv().SilentTarget_Library and typeof(getgenv().SilentTarget_Library.Unload) == "function" then
					pcall(function()
						getgenv().SilentTarget_Library:Unload()
					end)

					getgenv().SilentTarget_Library = nil
				end
			end

			local L97_1 = typeof(gethui) == "function" and gethui() or game:GetService("CoreGui")

			if L97_1 then
				for I41, I42 in ipairs(L97_1:GetChildren()) do
					if I42.Name == "ST_WatermarkFrame" or I42.Name == "ST_IronManHUD" or I42.Name == "Obsidian" or I42.Name:find("SilentTarget") or I42.Name:find("Obsidian") or I42.Name == "NeuroniumStickyUI" or I42.Name == "FakePosUI" or I42.Name:find("urban1") then
						pcall(function()
							I42:Destroy()
						end)
					end
				end
			end

			local U101 = workspace:FindFirstChild("ST_IronManSuitContainer")

			if U101 then
				pcall(function()
					U101:Destroy()
				end)
			end
		end)

		loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
		U62 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
		U63 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/ThemeManager.lua"))()
		U64 = loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/addons/SaveManager.lua"))()
		U65 = U62.Options
		U66 = U62.Toggles

		pcall(function()
			local U102 = U62.GetCustomIcon

			U62.GetCustomIcon = function(A102_1, A102_2)
				local L102_1 = U102(A102_1, A102_2)

				if not L102_1 and U62.GetIcon and typeof(A102_2) == "string" then
					L102_1 = U62:GetIcon(A102_2)
				end

				return L102_1
			end
		end)

		U62.CornerRadius = 20

		pcall(function()
			U63:SetLibrary(U62)
			U63:SetFolder("SilentTarget")

			U63:SetDefaultTheme({
				FontColor = Color3.fromHex("ffffff"),
				MainColor = Color3.fromHex("111111"),
				AccentColor = Color3.fromHex("ffffff"),
				BackgroundColor = Color3.fromHex("0a0a0a"),
				OutlineColor = Color3.fromHex("292929"),
				FontFace = Enum.Font.Gotham,
			})

			U62.Scheme.AccentColor = Color3.fromHex("ffffff")
			U62.Scheme.OutlineColor = Color3.fromHex("292929")
			U62.Scheme.MainColor = Color3.fromHex("111111")
			U62.Scheme.BackgroundColor = Color3.fromHex("0a0a0a")
			U62.Scheme.FontColor = Color3.fromHex("ffffff")
			U62:SetFont(Enum.Font.Gotham)
			U62:UpdateColorsUsingRegistry()
		end)

		U67 = game:GetService("Players")
		U68 = U67.LocalPlayer
		U69 = game:GetService("RunService")
		U70 = game:GetService("TweenService")
		U71 = game:GetService("Workspace")
		U72 = game:GetService("Debris")
		U73 = game:GetService("ReplicatedStorage")
		U74 = tick()

		do
			local U103 = {
				Active = false,
				Camera = nil,
				LockedCFrame = nil,
				BindName = "ST_SmoothTPRenderLock",
				Depth = 0,
			}

			local function F_000104(A104_1, A104_2)
				if not A104_1 then
					return
				end

				for I43, I44 in ipairs(A104_1:GetDescendants()) do
					if I44:IsA("BasePart") or I44:IsA("Decal") then
						pcall(function()
							I44.LocalTransparencyModifier = A104_2 and 1 or 0
						end)
					end
				end
			end

			local function F_000106()
				if U103.Depth > 0 then
					U103.Depth = U103.Depth - 1
				end

				if U103.Depth > 0 then
					return
				end

				if not U103.Active then
					return
				end
				U103.Active = false

				pcall(function()
					U69:UnbindFromRenderStep(U103.BindName)
				end)

				F_000104(U68.Character, false)

				if U103.Camera then
					pcall(function()
						U103.Camera.CameraType = Enum.CameraType.Custom
					end)
				end

				U103.Camera = nil
				U103.LockedCFrame = nil
			end

			U68.CharacterAdded:Connect(function()
				if U103.Active then
					U103.Depth = 0
					F_000106()
				end
			end)
		end

		do
			local U104 = 0
			local U105 = ""

			U75 = function(A110_1)
				local L110_1 = tick()
				if A110_1.Title == U105 and L110_1 - U104 < 2 then
					return
				end
				U105 = A110_1.Title
				U104 = L110_1
				A110_1.Duration = A110_1.Duration or 2
				U62:Notify(A110_1)
			end
		end

		U76 = "cpu"
		local U106
		U106 = nil
		local U107
		U107 = false
		local U108
		U108 = true
		U77 = nil
		U78 = nil
		U79 = nil
		U80 = nil
		local U109
		U109 = nil
		local U110
		U110 = nil
		local U111
		U111 = nil
		local U112, U113, U114

		do
			local U115 = nil
			U81 = nil
			U82 = nil
			U83 = nil
			local U116 = nil
			local U117 = true
			U84 = nil
			U85 = nil
			local U118 = nil
			U86 = 0
			local U119 = ""
			local U120 = nil

			U112 = function(A111_1)
				local L111_1 = tostring(A111_1 or ""):gsub("^%s*(.-)%s*$", "%1")
				U119 = L111_1

				if U116 then
					if L111_1 ~= "" then
						if tonumber(L111_1) then
							L111_1 = "rbxassetid://" .. L111_1
						end

						U116.Image = L111_1
					else
						U116.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(U68.UserId) .. "&w=150&h=150"
					end
				end
			end

			U113 = function(A112_1)
				U108 = A112_1

				if not A112_1 then
					U107 = false
				end

				if U120 then
					U120()
				end
			end

			U114 = function()
				if U106 then
					return
				end

				pcall(function()
					local L114_1 = U62.ScreenGui and U62.ScreenGui:FindFirstChild("Floats") or U62.ScreenGui or game:GetService("CoreGui")
					local U121 = Instance.new("Frame")
					U121.Name = "ST_CustomWatermark"
					U121.AutomaticSize = Enum.AutomaticSize.XY
					U121.Size = UDim2.fromOffset(0, 0)
					U121.Position = UDim2.fromOffset(20, 20)
					U121.BackgroundColor3 = U62.Scheme.BackgroundColor or Color3.fromHex("0a0a0a")
					U121.BorderSizePixel = 0
					U121.ZIndex = 50
					U121.Parent = L114_1
					local L114_2 = Instance.new("UICorner")
					L114_2.CornerRadius = UDim.new(0, 9)
					L114_2.Parent = U121

					if U62.Corners then
						table.insert(U62.Corners, L114_2)
					end

					local L114_3 = Instance.new("UIStroke")
					L114_3.Color = U62.Scheme.OutlineColor or Color3.fromHex("292929")
					L114_3.Thickness = 1
					L114_3.Parent = U121
					local L114_4 = Instance.new("UIListLayout")
					L114_4.FillDirection = Enum.FillDirection.Vertical
					L114_4.SortOrder = Enum.SortOrder.LayoutOrder
					L114_4.Padding = UDim.new(0, 0)
					L114_4.HorizontalAlignment = Enum.HorizontalAlignment.Left
					L114_4.Parent = U121
					local L114_5 = Instance.new("UIPadding")
					L114_5.PaddingTop = UDim.new(0, 7)
					L114_5.PaddingBottom = UDim.new(0, 7)
					L114_5.PaddingLeft = UDim.new(0, 10)
					L114_5.PaddingRight = UDim.new(0, 10)
					L114_5.Parent = U121
					local U122 = Instance.new("Frame")
					U122.Name = "TopBar"
					U122.BackgroundTransparency = 1
					U122.AutomaticSize = Enum.AutomaticSize.XY
					U122.Size = UDim2.fromOffset(0, 21)
					U122.LayoutOrder = 1
					U122.Parent = U121
					local L114_6 = Instance.new("UIListLayout")
					L114_6.FillDirection = Enum.FillDirection.Horizontal
					L114_6.SortOrder = Enum.SortOrder.LayoutOrder
					L114_6.VerticalAlignment = Enum.VerticalAlignment.Center
					L114_6.Padding = UDim.new(0, 7)
					L114_6.Parent = U122
					local U123 = Instance.new("ImageLabel")
					U123.Name = "CpuIcon"
					U123.BackgroundTransparency = 1
					U123.Size = UDim2.fromOffset(18, 18)
					U123.ImageColor3 = U62.Scheme.FontColor or Color3.new(1, 1, 1)
					U123.LayoutOrder = 1
					U123.Parent = U122

					pcall(function()
						local L115_1 = U62:GetCustomIcon("cpu")

						if L115_1 then
							U62:ApplyLucideIcon(U123, L115_1)
						end
					end)

					local L114_7 = Instance.new("TextLabel")
					L114_7.Name = "TitleLabel"
					L114_7.BackgroundTransparency = 1
					L114_7.AutomaticSize = Enum.AutomaticSize.XY
					L114_7.Font = Enum.Font.GothamBold
					L114_7.Text = "<b>SILENT TARGET</b>"
					L114_7.RichText = true
					L114_7.TextColor3 = U62.Scheme.FontColor or Color3.new(1, 1, 1)
					L114_7.TextSize = 15
					L114_7.LayoutOrder = 2
					L114_7.Parent = U122
					U109 = L114_7
					local L114_8 = Instance.new("TextLabel")
					L114_8.BackgroundTransparency = 1
					L114_8.AutomaticSize = Enum.AutomaticSize.XY
					L114_8.Font = Enum.Font.Gotham
					L114_8.Text = "|"
					L114_8.TextColor3 = Color3.fromRGB(120, 120, 120)
					L114_8.TextSize = 15
					L114_8.LayoutOrder = 3
					L114_8.Parent = U122
					U84 = L114_8
					local U124 = Instance.new("ImageLabel")
					U124.Name = "FpsWarn"
					U124.BackgroundTransparency = 1
					U124.Size = UDim2.fromOffset(11, 11)
					U124.ScaleType = Enum.ScaleType.Fit
					U124.ImageColor3 = Color3.fromRGB(255, 30, 30)
					U124.Visible = false
					U124.LayoutOrder = 4
					U124.Parent = U122

					pcall(function()
						local L116_1 = U62:GetCustomIcon("info")

						if L116_1 then
							U62:ApplyLucideIcon(U124, L116_1)
							U124.ImageColor3 = Color3.fromRGB(255, 30, 30)
						end
					end)

					U77 = U124
					local L114_9 = Instance.new("TextLabel")
					L114_9.Name = "FpsLabel"
					L114_9.BackgroundTransparency = 1
					L114_9.AutomaticSize = Enum.AutomaticSize.XY
					L114_9.Font = Enum.Font.Gotham
					L114_9.Text = "0 fps"
					L114_9.TextColor3 = U62.Scheme.FontColor or Color3.new(1, 1, 1)
					L114_9.TextSize = 15
					L114_9.LayoutOrder = 5
					L114_9.Parent = U122
					U79 = L114_9
					local L114_10 = Instance.new("TextLabel")
					L114_10.BackgroundTransparency = 1
					L114_10.AutomaticSize = Enum.AutomaticSize.XY
					L114_10.Font = Enum.Font.Gotham
					L114_10.Text = "|"
					L114_10.TextColor3 = Color3.fromRGB(120, 120, 120)
					L114_10.TextSize = 15
					L114_10.LayoutOrder = 6
					L114_10.Parent = U122
					U85 = L114_10
					local U125 = Instance.new("ImageLabel")
					U125.Name = "PingWarn"
					U125.BackgroundTransparency = 1
					U125.Size = UDim2.fromOffset(11, 11)
					U125.ScaleType = Enum.ScaleType.Fit
					U125.ImageColor3 = Color3.fromRGB(255, 30, 30)
					U125.Visible = false
					U125.LayoutOrder = 7
					U125.Parent = U122

					pcall(function()
						local L117_1 = U62:GetCustomIcon("wifi-off")

						if L117_1 then
							U62:ApplyLucideIcon(U125, L117_1)
							U125.ImageColor3 = Color3.fromRGB(255, 30, 30)
						end
					end)

					U78 = U125
					local L114_11 = Instance.new("TextLabel")
					L114_11.Name = "PingLabel"
					L114_11.BackgroundTransparency = 1
					L114_11.AutomaticSize = Enum.AutomaticSize.XY
					L114_11.Font = Enum.Font.Gotham
					L114_11.Text = "0 ms"
					L114_11.TextColor3 = U62.Scheme.FontColor or Color3.new(1, 1, 1)
					L114_11.TextSize = 15
					L114_11.LayoutOrder = 8
					L114_11.Parent = U122
					U80 = L114_11
					local U126 = Instance.new("TextLabel")
					U126.BackgroundTransparency = 1
					U126.AutomaticSize = Enum.AutomaticSize.XY
					U126.Font = Enum.Font.Gotham
					U126.Text = "|"
					U126.TextColor3 = Color3.fromRGB(120, 120, 120)
					U126.TextSize = 15
					U126.LayoutOrder = 9
					U126.Parent = U122
					U118 = U126
					local U127 = Instance.new("Frame")
					U127.Name = "ArrowHolder"
					U127.BackgroundTransparency = 1
					U127.Size = UDim2.fromOffset(18, 18)
					U127.LayoutOrder = 10
					U127.Parent = U122
					local U128 = Instance.new("TextButton")
					U128.Name = "ArrowBtn"
					U128.BackgroundTransparency = 1
					U128.AnchorPoint = Vector2.new(0.5, 0.5)
					U128.Position = UDim2.new(0.5, 0, 0.5, 0)
					U128.Size = UDim2.fromOffset(18, 18)
					U128.Font = Enum.Font.GothamBold
					U128.Text = "▲"
					U128.TextColor3 = U62.Scheme.FontColor or Color3.new(1, 1, 1)
					U128.TextSize = 13
					U128.Rotation = 0
					U128.Parent = U127
					U110 = U128
					local U129 = Instance.new("Frame")
					U129.Name = "DrawerHolder"
					U129.BackgroundTransparency = 1
					U129.ClipsDescendants = true
					U129.BorderSizePixel = 0
					U129.Size = UDim2.fromOffset(0, 0)
					U129.LayoutOrder = 2
					U129.Visible = false
					U129.Parent = U121
					U115 = U129
					local L114_12 = Instance.new("Frame")
					L114_12.Name = "WatermarkDivider"
					L114_12.BackgroundColor3 = U62.Scheme.OutlineColor or Color3.fromHex("292929")
					L114_12.BorderSizePixel = 0
					L114_12.Position = UDim2.fromOffset(0, 7)
					L114_12.Size = UDim2.new(1, 0, 0, 1)
					L114_12.Parent = U129
					U111 = L114_12
					local L114_13 = Instance.new("Frame")
					L114_13.Name = "DrawerContent"
					L114_13.BackgroundTransparency = 1
					L114_13.Position = UDim2.fromOffset(0, 15)
					L114_13.Size = UDim2.new(1, 0, 0, 55)
					L114_13.Parent = U129
					local L114_14 = Instance.new("UIListLayout")
					L114_14.FillDirection = Enum.FillDirection.Horizontal
					L114_14.SortOrder = Enum.SortOrder.LayoutOrder
					L114_14.VerticalAlignment = Enum.VerticalAlignment.Center
					L114_14.Padding = UDim.new(0, 9)
					L114_14.Parent = L114_13
					local L114_15 = Instance.new("ImageLabel")
					L114_15.Name = "ProfileImage"
					L114_15.Size = UDim2.fromOffset(55, 55)
					L114_15.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
					L114_15.Image = U119 ~= "" and U119 or "rbxthumb://type=AvatarHeadShot&id=" .. tostring(U68.UserId) .. "&w=150&h=150"
					L114_15.LayoutOrder = 1
					L114_15.Parent = L114_13
					U116 = L114_15
					local L114_16 = Instance.new("UICorner")
					L114_16.CornerRadius = UDim.new(1, 0)
					L114_16.Parent = L114_15
					local L114_17 = Instance.new("UIStroke")
					L114_17.Color = U62.Scheme.OutlineColor or Color3.fromHex("292929")
					L114_17.Thickness = 1
					L114_17.Parent = L114_15
					local L114_18 = Instance.new("Frame")
					L114_18.Name = "InfoColumn"
					L114_18.BackgroundTransparency = 1
					L114_18.AutomaticSize = Enum.AutomaticSize.XY
					L114_18.Size = UDim2.fromOffset(0, 0)
					L114_18.LayoutOrder = 2
					L114_18.Parent = L114_13
					local L114_19 = Instance.new("UIListLayout")
					L114_19.FillDirection = Enum.FillDirection.Vertical
					L114_19.SortOrder = Enum.SortOrder.LayoutOrder
					L114_19.Padding = UDim.new(0, 4)
					L114_19.Parent = L114_18
					local L114_20 = Instance.new("TextLabel")
					L114_20.Name = "UserLabel"
					L114_20.BackgroundTransparency = 1
					L114_20.AutomaticSize = Enum.AutomaticSize.XY
					L114_20.Font = Enum.Font.Gotham
					L114_20.RichText = true
					L114_20.Text = "User: <b>@" .. U68.Name .. "</b>"
					L114_20.TextColor3 = U62.Scheme.FontColor or Color3.new(1, 1, 1)
					L114_20.TextSize = 14
					L114_20.LayoutOrder = 1
					L114_20.Parent = L114_18
					U83 = L114_20
					local L114_21 = Instance.new("TextLabel")
					L114_21.Name = "KickedLabel"
					L114_21.BackgroundTransparency = 1
					L114_21.AutomaticSize = Enum.AutomaticSize.XY
					L114_21.Font = Enum.Font.Gotham
					L114_21.RichText = true
					L114_21.Text = "Kicked Players: <b>0</b>"
					L114_21.TextColor3 = U62.Scheme.FontColor or Color3.new(1, 1, 1)
					L114_21.TextSize = 14
					L114_21.LayoutOrder = 2
					L114_21.Parent = L114_18
					U82 = L114_21
					local L114_22 = Instance.new("TextLabel")
					L114_22.Name = "ElapsedLabel"
					L114_22.BackgroundTransparency = 1
					L114_22.AutomaticSize = Enum.AutomaticSize.XY
					L114_22.Font = Enum.Font.Gotham
					L114_22.RichText = true
					L114_22.Text = "Elapsed time: <b>00:00:00</b>"
					L114_22.TextColor3 = U62.Scheme.FontColor or Color3.new(1, 1, 1)
					L114_22.TextSize = 14
					L114_22.LayoutOrder = 3
					L114_22.Parent = L114_18
					U81 = L114_22
					local U130 = nil
					local U131 = nil

					local function F_000118()
						if U122 and U122.AbsoluteSize.X > 0 then
							return U122.AbsoluteSize.X
						end
						return 280
					end

					U122:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
						if U122 and U129 and U107 then
							local L119_1 = U122.AbsoluteSize.X

							if L119_1 > 0 then
								U129.Size = UDim2.new(0, L119_1, 0, U129.Size.Y.Offset)
							end
						end
					end)

					U120 = function(A120_1)
						if not U108 then
							if U130 then
								U130:Cancel()
								U130 = nil
							end

							if U131 then
								U131:Cancel()
								U131 = nil
							end

							U127.Visible = false
							U126.Visible = false
							U129.Visible = false
							U129.Size = UDim2.new(0, F_000118(), 0, 0)
							U128.Rotation = 0
							U107 = false
						else
							U127.Visible = true
							U126.Visible = true
							local L120_1 = F_000118()

							if U107 then
								U129.Visible = true

								if A120_1 then
									if U130 then
										U130:Cancel()
									end

									if U131 then
										U131:Cancel()
									end

									U130 = U70:Create(U129, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, L120_1, 0, 70) })
									U131 = U70:Create(U128, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 180 })
									U130:Play()
									U131:Play()
								else
									U129.Size = UDim2.new(0, L120_1, 0, 70)
									U128.Rotation = 180
								end
							elseif A120_1 then
								if U130 then
									U130:Cancel()
								end

								if U131 then
									U131:Cancel()
								end

								U130 = U70:Create(U129, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Size = UDim2.new(0, L120_1, 0, 0) })
								U131 = U70:Create(U128, TweenInfo.new(0.28, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Rotation = 0 })
								U130:Play()
								U131:Play()

								task.spawn(function()
									local L121_1 = U130
									L121_1.Completed:Wait()

									if not U107 and U130 == L121_1 then
										U129.Visible = false
									end
								end)
							else
								U129.Size = UDim2.new(0, L120_1, 0, 0)
								U129.Visible = false
								U128.Rotation = 0
							end
						end
					end

					U128.MouseButton1Click:Connect(function()
						if not U108 then
							return
						end
						U107 = not U107
						U120(true)
					end)

					pcall(function()
						U62:MakeDraggable(U121, U122, true)
					end)

					U106 = U121
					U120(false)
				end)
			end

			U62.SetWatermark = function()
				if not U106 then
					U114()
				end
			end

			U62.SetWatermarkVisibility = function(A125_1, A125_2)
				U117 = A125_2

				if not U106 then
					U114()
				end

				if U106 then
					U106.Visible = A125_2
				end
			end
		end

		local U132

		U132 = {
			Snowball = "snowflake",
			Blobman = "bot",
			Coconut = "nut",
			BallBasketball = "circle",
			BallMagicLight = "sparkles",
			Banana = "banana",
			Burger = "sandwich",
			Pizza = "pizza",
			Hotdog = "utensils",
			Donut = "circle",
			Cake = "cake",
			Fries = "utensils",
			Mushroom = "leaf",
			Mayo = "droplet",
			Mayonnaise = "droplet",
			Poop = "trash-2",
			SparklePoop = "sparkles",
			Bread = "croissant",
			Egg = "egg",
			MeatStick = "beef",
			Pepperoni = "pizza",
			WhiteMug = "coffee",
			BrownMug = "coffee",
			Banjo = "music",
			Violin = "music",
			Ukulele = "music",
			Sax = "music-2",
			Trumpet = "volume-2",
			Vuvuzela = "megaphone",
			Bongos = "disc",
			Snare = "disc",
			Mic = "mic",
			Piano = "music",
			Ocarina = "wind",
			Lyre = "music",
			["Tractor (Invisible)"] = "tractor",
			Tractor = "tractor",
			Train = "train-front",
			Kill = "skull",
			Kick = "user-x",
			Superlock = "lock",
			Grab = "hand",
			["Destroy Gucci"] = "trash-2",
			DestroyGucci = "trash-2",
			["Remove Food"] = "utensils",
			["Death Aura"] = "skull",
			["Fling Aura"] = "wind",
			Fling = "wind",
			["Super Strength"] = "zap",
			["Noclip Grab"] = "ghost",
			["Ragdoll Grab"] = "activity",
			["Kill Grab"] = "skull",
			["Kick Grab"] = "user-x",
			Heart = "heart",
			["Heart-Outline"] = "heart",
			[
