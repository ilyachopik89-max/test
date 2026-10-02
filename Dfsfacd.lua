if not getgenv().SCRIPT_KEY then
	if not SCRIPT_KEY then
		r = "No script key provided, please pass a SCRIPT_KEY!"
		loadstring(game:HttpGet("https://jnkie.com"))()
		return
	end

	local v = SCRIPT_KEY
	getgenv().SCRIPT_KEY = v
end

if getgenv().EXECUTING == "true" then
	warn("There is already an execution in progress. Please wait before executing another script.")
	return
end

getgenv().EXECUTING = "true"

spawn(function()
	task.wait(5)
	getgenv().EXECUTING = "false"
end)

if pcall(setmetatable, game, {}) or pcall(setfenv, 1, {}) then
	LPH_CRASH()
end

if pcall(function()
	game:GetService("RunsServices")
end) then
	LPH_CRASH()
end

if Faces.new(Enum.NormalId.Front, Enum.NormalId.Left, 1, 2).Front ~= true then
	LPH_CRASH()
end

if Faces.new(Enum.NormalId.Front, Enum.NormalId.Left, 1, 2).Back ~= false then
	LPH_CRASH()
end

do
	local ok, result = pcall(function()
		return pcall()
	end)

	if ok or result and not tostring(result):match("missing argument") then
		LPH_CRASH()
	end
end

if typeof(game:GetService("RunService").Heartbeat:Wait()) ~= "number" or game:GetService("RunService").Heartbeat:Wait() <= 0 then
	LPH_CRASH()
end

do
	local ok, result = pcall(function()
		return debug and debug.info and debug.info(2, "f")
	end)

	if not (ok and result) then
		LPH_CRASH()
	end
end

if debug.setmemorycategory("X") == debug.setmemorycategory("X") then
	LPH_CRASH()
end

if not utf8.graphemes then
	LPH_CRASH()
end

do
	local ok, result = pcall(function()
		return game:GetService("HttpService"):GetSecret("JUNKIE-DEVELOPMENT")
	end)

	if not result:match("Can't find secret with given key") then
		LPH_CRASH()
	end
end

if not SharedTable.new() then
	LPH_CRASH()
end

if #(function(arg)
	local v = Random.new(tick() * math.random() * math.random())
	local str = ""

	for i = 1, v:NextNumber(20, 30) do
		str ..= utf8.char(v:NextNumber(97, 8000))
	end

	return ("\0"):rep(25) .. str .. arg .. ("\0"):rep(25) .. str
end)("hi") < 150 then
	LPH_CRASH()
end

do
	local flag = not setmetatable or not pcall or not debug or not rawget or not rawset or not pcall(rawset, {}, " ", " ") or not select or not select(2, pcall(rawget, debug, "info"))

	if not flag then
		local v = print
		flag = not select(2, pcall(rawget, debug, "info"))(v, "s") == "[C]"
	end

	local flag2

	if flag then
		flag2 = flag
	else
		local v = require
		flag2 = not select(2, pcall(rawget, debug, "info"))(v, "s") == "[C]"
	end

	if flag2 then
		LPH_CRASH()
	end
end

local fn

fn = function(arg, arg2)
	r = arg2 and arg2 .. "\n\nError code: " .. arg or arg
	loadstring(game:HttpGet("https://jnkie.com"))()
	task.wait(3)
end

local v
v = debug.info(1, "l")
local v2 = debug.info(1, "l")

if isfunctionhooked then
	local flag = false

	pcall(function()
		flag = isfunctionhooked(math.randomseed) or isfunctionhooked(loadstring) or isfunctionhooked(os.time) or isfunctionhooked(request) or isfunctionhooked(game.HttpGet)
	end)

	pcall(function()
		if hookfunction and type(hookfunction) == "function" then
			local function fn2()
			end

			hookfunction(fn2, function()
				print("hellow")
			end)

			if not isfunctionhooked(fn2) then
				while true do
				end
			end
		end
	end)

	if flag then
		LPH_CRASH()
	end
end

if isreadonly then
	if not isreadonly(string) and not identifyexecutor():match("^Velocity") then
		LPH_CRASH()
	end

	if not isreadonly(math) then
		LPH_CRASH()
	end

	if not isreadonly(os) then
		LPH_CRASH()
	end

	if not isreadonly(table) then
		LPH_CRASH()
	end
end

if getrenv then
	if os.time ~= getrenv().os.time then
		LPH_CRASH()
	end

	if math.random ~= getrenv().math.random then
		LPH_CRASH()
	end

	if math.randomseed ~= getrenv().math.randomseed then
		LPH_CRASH()
	end

	if os.clock ~= getrenv().os.clock then
		LPH_CRASH()
	end

	if tostring ~= getrenv().tostring then
		LPH_CRASH()
	end

	if tonumber ~= getrenv().tonumber then
		LPH_CRASH()
	end
end

if os.time() < 1790011487 then
	fn("J2_116")
	LPH_CRASH()
end

if debug.info(1, "l") ~= v2 or debug.info(1, "l") ~= v then
	LPH_CRASH()
end

local v3
v3 = debug.info(1, "l")

do
	local function fn2(arg)
		for i = 1, 197 do
			local ok, result = pcall(function()
				return coroutine.wrap(arg)
			end)

			if not ok then
				fn("J2_205")
				LPH_CRASH()
			end

			if type(result) == "function" then
				arg = result
			end
		end

		local ok, result = pcall(arg)
		if tostring(result or ""):find("C stack overflow") then
			return true
		end
		return false
	end

	if fn2(math.abs) then
		fn("J2_151")
		LPH_CRASH()
	end

	local flag = fn2(request) and not identifyexecutor():match("^Hydrogen") and not identifyexecutor():match("^Xeno") and not identifyexecutor():match("^Solara")

	if flag then
		fn("J2_260", "Executor compatibility error (" .. tostring(identifyexecutor()) .. ")")
		LPH_CRASH()
	end

	if fn2(task.spawn) then
		fn("J2_022")
		LPH_CRASH()
	end

	if fn2(math.random) then
		fn("J2_065")
		LPH_CRASH()
	end

	if fn2(math.min) then
		fn("J2_003")
		LPH_CRASH()
	end

	if fn2(os.clock) then
		fn("J2_216")
		LPH_CRASH()
	end

	if fn2(math.floor) then
		fn("J2_093")
		LPH_CRASH()
	end

	if fn2(math.max) then
		fn("J2_173")
		LPH_CRASH()
	end

	if fn2(os.time) then
		fn("J2_022")
		LPH_CRASH()
	end
end

if pcall(function()
	return getfenv()["pr" .. nil .. "nt"]
end) then
	fn("J2_113")
	LPH_CRASH()
end

do
	local flag = false

	local tbl = {
		__tostring = function()
			flag = true
			return ""
		end,
		__eq = function()
			flag = true
			return false
		end,
		__index = function()
			flag = true

			return function()
				return ""
			end
		end,
		__concat = function()
			flag = true
			return ""
		end,
		__len = function()
			flag = true
			return 0
		end,
	}

	local tbl2 = {
		Url = setmetatable({}, tbl),
		Method = "GET",
		Headers = { Accept = "*/*", ["User-Agent"] = "Roblox/WinInet" },
	}

	setmetatable(tbl2, setmetatable({}, { __index = function()
		flag = true
		return nil
	end }))

	tbl2.Headers[setmetatable({}, tbl)] = "1"
	pcall(request, tbl2)

	if flag then
		fn("J2_260", "Executor compatibility error (" .. tostring(identifyexecutor()) .. ")")
		LPH_CRASH()
	end
end

local n
n = 0
local tbl

tbl = {
	_c313d2fb18af = "" .. math.random(800, 999),
	_7ed1f3b18d18 = 88658,
	_aaed96cc0524 = 4192847692,
	_1666ef0a3ec3 = true,
	_2aa9b28f15f2 = "amwdkmVP",
	_558f1cbaec25 = false,
	_f82a17e1e93f = game:GetService("MemStorageService"),
	["\u{B9D}ఓ೧ທ\u{17DF}ိ၌ૃ\u{EEB}"] = game:GetService("TeleportService"),
	_156de3ade8b0 = 1890966365,
	_9476057ee5db = 135433,
	_3afb60034877 = 769852361,
	_ccffae666fc3 = "WWoT6x",
	_5b184af4883e = game:GetService("HapticService"),
	_2366d73289d6 = 81935,
	_5abbffa00af6 = "lLSdl7XuR",
	_031ffd9172b7 = "01l26BNq6EAZ",
	_38089230bfe9 = 1096335315,
	_027495a0f60f = 72409,
}

tbl._f384d4a8a36d = "_2e4cd75d5864" .. tostring(tbl)
tbl._9caf61ada1e6 = {}
getfenv()[3717773] = 0
local n2
n2 = 2867
tbl["\u{B9D}ఓ೧ທ\u{17DF}ိ၌ૃ\u{EEB}"]:SetTeleportSetting("ॳઽጬဧখቂॡ", "")
tbl["\u{B9D}ఓ೧ທ\u{17DF}ိ၌ૃ\u{EEB}"]:SetTeleportSetting("ଈ၁៉ౝా\u{CCE}", getgenv().SCRIPT_KEY)

if tbl["\u{B9D}ఓ೧ທ\u{17DF}ိ၌ૃ\u{EEB}"]:GetTeleportSetting("ଈ၁៉ౝా\u{CCE}") ~= getgenv().SCRIPT_KEY then
	LPH_CRASH()
end

local heartbeat
heartbeat = game:GetService("RunService").Heartbeat
local flag
flag = true
local tbl2
tbl2 = {}
local tbl3
tbl3 = {}
local fn2

fn2 = function(arg, arg2, arg3, arg4)
	if arg4 ~= nil and arg4 == tbl2 then
		return tbl3
	end
	local flag2 = type(arg3) ~= "number"
	local flag3

	if flag2 then
		flag3 = flag2
	else
		local v4 = tostring
		flag3 = tostring(arg3) ~= v4((1 - 2 * (4070269888 + 224697408 + 0) % 4294967296) * (1 + ((2594789476 + 1392209888 + 361876924) % 4294967296 * 67108864 + (5702870834 + 2887063758 + 0) % 4294967296) / 4503599627370496) * 2 ^ ((1334145948 + 245630092 + 2715192297) % 4294967296 - 1023))
	end

	if flag3 then
		LPH_CRASH()
	end

	local v4 = table.pack(27135)

	if arg3 - (1 - 2 * (4635963972 + 3953970620 + 0) % 4294967296) * (1 + ((2147483647 + 0 + bit32.band(65535 * v4[1] + bit32.lshift(bit32.band(4240966455 + 32767 * v4[1], 65535), 16), 4294967295) % 4294967296) % 4294967296 * 67108864 + (1071193370 + 2492262558 + 731511368) % 4294967296) / 4503599627370496) * 2 ^ ((6291640927 + 3604699004 + 2988562998) % 4294967296 - 1023) ~= 0 then
		LPH_CRASH()
	end

	if arg3 ~= 472726 == true then
		LPH_CRASH()
	end

	if not rawequal(arg3, 472726) == true then
		LPH_CRASH()
	end

	if not ({ [arg3] = true })[472726] then
		LPH_CRASH()
	end

	local kind = type(arg)
	local kind2 = type(arg2)
	if kind ~= typeof(arg2) or typeof(arg) ~= kind2 then
		return false
	end
	local str = tostring(arg)
	local str2 = tostring(arg2)
	if #str ~= #str2 or str < str2 or str > str2 then
		return false
	end

	if not (rawequal(arg, arg2) and rawequal(arg2, arg) and rawequal(str, str2)) then
		return false
	end

	if arg == nil or arg2 == nil then
		if arg ~= arg2 then
			return false
		end
	end

	local tbl4 = {}
	rawset(tbl4, arg, arg2)
	if not rawequal(rawget(tbl4, arg2), arg2) then
		return false
	end
	rawset(tbl4, arg, nil)

	if arg ~= nil and arg2 ~= nil then
		local tbl5 = { [arg2] = arg }
		if not rawequal(({ [arg] = arg2 })[arg2], arg2) or not rawequal(tbl5[arg], arg) then
			return false
		end
	end

	local flag4 = type(arg) == type(arg2) and (type(arg) == "number" or type(arg) == "string")

	if flag4 then
		flag4 = not (arg >= arg2 and arg2 >= arg and arg <= arg2 and arg2 <= arg)
	end

	if flag4 then
		return false
	end

	if not (not arg ~= arg2 == true) or not (arg ~= arg2 == false) then
		return false
	end

	if tostring(arg == arg2) ~= "true" then
		return false
	end

	if tostring(arg ~= arg2) ~= "false" then
		return false
	end
	local flag5 = type(arg) == type(arg2)
	local flag6

	if flag5 then
		flag6 = type(arg) == "number" or type(arg) == "string"
	else
		flag6 = flag5
	end

	if flag6 then
		flag6 = {}
		local flag7 = arg == arg2
		local flag8 = arg2 == arg
		local v5 = rawequal(arg, arg2)
		local v6 = rawequal(arg2, arg)
		local flag9 = not (arg ~= arg2)local flag10 = arg2 >= arg and arg2 <= arg
local flag11 = arg2 == arg
local flag12 = arg <= arg2
local flag13 = arg2 >= arg
local flag14 = not (arg ~= arg2)
local flag15 = arg >= arg2 and arg <= arg2
local flag16 = arg2 >= arg and arg2 <= arg
local v7 = rawequal(arg, arg2)
local flag17 = arg <= arg2
local flag18 = arg2 >= arg
local flag19 = arg == arg2
local flag20 = arg >= arg2 and arg <= arg2
flag6[1] = flag7
flag6 = flag8
flag6[3] = v5
flag6[4] = v6
flag6[5] = flag9
flag6[6] = flag10
flag6[7] = flag11
flag6[8] = flag12
flag6[9] = flag13
flag6[10] = flag14
flag6[11] = flag15
flag6[12] = flag16
flag6[13] = v7
flag6[14] = flag17
flag6[15] = flag18
flag6[16] = flag19
flag6[17] = flag20
end
if not flag6 then
flag6 = {}
local v5 = rawequal(arg, arg2)
local v6 = rawequal(arg2, arg)
local v7 = rawequal(arg, arg2)
flag6[1] = arg == arg2
flag6 = arg2 == arg
flag6[3] = v5
flag6[4] = v6
flag6[5] = not (arg ~= arg2)
flag6[6] = true
flag6[7] = arg2 == arg
flag6[8] = true
flag6[9] = true
flag6[10] = not (arg ~= arg2)
flag6[11] = true
flag6[12] = true
flag6[13] = v7
flag6[14] = true
flag6[15] = true
flag6[16] = arg == arg2
flag6[17] = true
end
local flag7 = false
setmetatable(flag6, {
__newindex = function()
flag7 = true
end,
__metatable = {},
})
local n3 = 1
while n3 <= #flag6 do
if flag6[n3] ~= true then
return false
end
n3 += 1
end
flag6.WAu12J9e18A2IuQe = true
if not flag7 or n3 - 1 ~= 17 then
return false
end
return true
end
local fn3
fn3 = function(arg, arg2, arg3, arg4)
if arg4 ~= nil and arg4 == tbl2 then
return tbl3
end
local flag2 = type(arg3) ~= "number"
local flag3
if flag2 then
flag3 = flag2
else
local v4 = tostring
flag3 = tostring(arg3) ~= v4(207353)
end
if flag3 then
LPH_CRASH()
end
if arg3 ~= 207353 then
LPH_CRASH()
end
if not rawequal(arg3, 207353) == true then
LPH_CRASH()
end
if not ({ [arg3] = true })[207353] then
LPH_CRASH()
end
if arg3 - 207353 ~= 0 == true then
LPH_CRASH()
end
n2 += 22
if flag then
tbl["\u{B9D}ఓ೧ທ\u{17DF}ိ၌ૃ\u{EEB}"]:SetTeleportSetting("ॳઽጬဧখቂॡ", tbl["\u{B9D}ఓ೧ທ\u{17DF}ိ၌ૃ\u{EEB}"]:GetTeleportSetting("ॳઽጬဧখቂॡ") .. "2RZkLUPa3iceLEKRscSoAaU")
end
local flag4 = type(arg) == type(arg2) and (type(arg) == "number" or type(arg) == "string")
if flag4 then
flag4 = {}
local flag5 = arg == arg2
local flag6 = arg2 == arg
local v4 = rawequal(arg, arg2)
local v5 = rawequal(arg2, arg)
local flag7 = not (arg ~= arg2)
local flag8 = arg2 >= arg and arg2 <= arg
local flag9 = arg2 == arg
local flag10 = arg <= arg2
local flag11 = arg2 >= arg
local flag12 = not (arg ~= arg2)
local flag13 = arg >= arg2 and arg <= arg2
flag4[1] = flag5
flag4 = flag6
flag4[3] = v4
flag4[4] = v5
flag4[5] = flag7
flag4[6] = flag8
flag4[7] = flag9
flag4[8] = flag10
flag4[9] = flag11
flag4[10] = flag12
flag4[11] = flag13
end
local v4
if flag4 then
v4 = flag4
else
local tbl4 = {}
local v5 = rawequal(arg, arg2)
local v6 = rawequal(arg2, arg)
tbl4[1] = arg == arg2
tbl4 = arg2 == arg
tbl4[3] = v5
tbl4[4] = v6
tbl4[5] = not (arg ~= arg2)
tbl4[6] = true
tbl4[7] = arg2 == arg
tbl4[8] = true
tbl4[9] = true
tbl4[10] = not (arg ~= arg2)
tbl4[11] = true
v4 = tbl4
end
local flag5 = false
setmetatable(v4, {
__newindex = function()
flag5 = true
end,
__metatable = {},
})
local n3 = 1
while n3 <= #v4 do
if v4[n3] ~= true then
return false
end
n3 += 1
end
v4.N1bwhUHYw1o6QQMH = true
if not flag5 or n3 - 1 ~= 11 then
return false
end
local flag6 = type(arg) == type(arg2)
local flag7
if flag6 then
flag7 = type(arg) == "number" or type(arg) == "string"
else
flag7 = flag6
end
if flag7 then
if not (arg >= arg2) or not (arg2 >= arg) or not (arg <= arg2) or not (arg2 <= arg) then
return false
end
end
if arg ~= nil and arg2 ~= nil then
local tbl4 = { [arg2] = arg }
if not rawequal(({ [arg] = arg2 })[arg2], arg2) or not rawequal(tbl4[arg], arg) then
return false
end
end
if not (not arg ~= arg2 == true) then
return false
end
if not (arg ~= arg2 == false) then
return false
end
local kind = type(arg)
local kind2 = type(arg2)
if kind ~= typeof(arg2) or typeof(arg) ~= kind2 then
return false
end
local str = tostring(arg)
local str2 = tostring(arg2)
if #str ~= #str2 or str < str2 or str > str2 then
return false
end
if not (rawequal(arg, arg2) and rawequal(arg2, arg) and rawequal(str, str2)) then
return false
end
if tostring(arg == arg2) ~= "true" or tostring(arg ~= arg2) ~= "false" then
return false
end
if arg == nil or arg2 == nil then
if arg ~= arg2 then
return false
end
end
local tbl4 = { [arg] = true }
if rawget(tbl4, arg2) ~= true then
return false
end
rawset(tbl4, arg, nil)
return true
end
if not fn3(207353, 207353, 207353) then
fn("J2_202")
LPH_CRASH()
end
if not fn3(207353, 207353, 207353) then
fn("J2_MS12")
LPH_CRASH()
end
spawn(function()
local now = os.clock()
local now2 = os.clock()
task.wait(0.1)
if now == now2 and now2 == os.clock() and fn2(now, now2, 472726) then
LPH_CRASH()
end
local now3 = tick()
local now4 = tick()
task.wait(0.1)
if now3 == now4 and now4 == tick() and fn2(now3, now4, 472726) then
LPH_CRASH()
end
end)
if debug.info(1, "l") ~= v3 or debug.info(1, "l") ~= v then
LPH_CRASH()
end
local v4, v5, v6, fn4, fn5, fn6, fn7, fn8, fn9
do
local v7 = debug.info(1, "l")
local function fn10()
local byte = string.byte
local char_ = string.char
local sub = string.sub
local concat = table.concat
local huge = math.huge
local function fn11()
error("J", 0)
end
local function fn12(arg)
if arg >= 48 and arg <= 57 then
return arg - 48
end
if arg >= 65 and arg <= 70 then
return arg - 55
end
if arg >= 97 and arg <= 102 then
return arg - 87
end
fn11()
end
local function fn13(arg, arg2, arg3)
if arg2 + 3 > arg3 then
fn11()
end
return fn12(byte(arg, arg2)) * 4096 + fn12(byte(arg, arg2 + 1)) * 256 + fn12(byte(arg, arg2 + 2)) * 16 + fn12(byte(arg, arg2 + 3)), arg2 + 4
end
local function fn14(arg)
if arg < 128 then
return char_(arg)
end
if arg < 2048 then
return char_(192 + arg // 64, 128 + arg % 64)
end
if arg < 65536 then
return char_(224 + arg // 4096, 128 + arg // 64 % 64, 128 + arg % 64)
end
return char_(240 + arg // 262144, 128 + arg // 4096 % 64, 128 + arg // 64 % 64, 128 + arg % 64)
end
local tbl4 = {
[34] = """,
[47] = "/",
[92] = "\",
[98] = "\8",
[102] = "\12",
[110] = "\n",
[114] = "\r",
[116] = "\t",
}
local function fn15(arg, arg2, arg3)
local tbl5 = {}
local n3 = arg2 + 1
local n4 = 0
local v8 = n3
while n3 <= arg3 do
local v9 = byte(arg, n3)
if v9 == 34 then
if v8 < n3 then
n4 += 1
tbl5[n4] = sub(arg, v8, n3 - 1)
end
if n4 == 0 then
return "", n3 + 1
end
if n4 == 1 then
return tbl5[1], n3 + 1
end
return concat(tbl5), n3 + 1
end
if v9 == 92 then
if v8 < n3 then
n4 += 1
tbl5[n4] = sub(arg, v8, n3 - 1)
end
n3 += 1
if arg3 < n3 then
fn11()
end
local v10 = byte(arg, n3)
local v11 = tbl4[v10]
if v11 then
n3 += 1
elseif v10 == 117 then
local n5, v12 = fn13(arg, n3 + 1, arg3)
if n5 >= 55296 and n5 <= 56319 and v12 + 5 <= arg3 and byte(arg, v12) == 92 and byte(arg, v12 + 1) == 117 then
local v13
v13, n3 = fn13(arg, v12 + 2, arg3)
if v13 >= 56320 and v13 <= 57343 then
n5 = 65536 + (n5 - 55296) * 1024 + v13 - 56320
else
n3 = v12
end
else
n3 = v12
end
v11 = fn14(n5)
else
fn11()
end
n4 += 1
tbl5[n4] = v11
v8 = n3
else
if v9 < 32 then
fn11()
end
n3 += 1
end
end
fn11()
end
local function fn16(arg, arg2, arg3)
local n3
if byte(arg, arg2) ~= 45 then
n3 = arg2
else
n3 = arg2 + 1
end
if arg3 < n3 then
fn11()
end
local v8 = byte(arg, n3)
if v8 == 48 then
local n4 = n3 + 1
local v9 = byte(arg, n4)
if v9 and v9 >= 48 and v9 <= 57 then
fn11()
n3 = n4
else
n3 = n4
end
elseif v8 >= 49 and v8 <= 57 then
local v9 = n3
while true do
n3 = v9 + 1
local v10 = byte(arg, n3)
if not (not v10 or v10 < 48 or v10 > 57) then
v9 = n3
continue
end
break
end
else
fn11()
end
local num = tonumber(sub(arg, arg2, n3 - 1))
if not num or num ~= num or num <= -huge or num >= huge then
fn11()
end
return num, n3
end
local fn17 = nil
local function fn18(arg, arg2, arg3, arg4)
local tbl5 = {}
local n3 = arg2 + 1
local n4 = 0
if byte(arg, n3) == 93 then
return tbl5, n3 + 1
end
local v8
while true do
local v9
v9, v8 = fn17(arg, n3, arg3, arg4)
n4 += 1
tbl5[n4] = v9
local v10 = byte(arg, v8)
if v10 == 93 then
break
else
if v10 ~= 44 then
fn11()
end
