local wezterm = require("wezterm")
local colors = require("theme")

local cells = {} -- wezterm FormatItems (ref: https://wezfurlong.org/wezterm/config/lua/wezterm/format.html)

local function push(text, icon, fg, bg)
	table.insert(cells, { Foreground = { Color = fg } })
	table.insert(cells, { Background = { Color = bg } })
	table.insert(cells, { Attribute = { Intensity = "Bold" } })
	table.insert(cells, { Text = " " .. icon .. " " .. text })

	table.insert(cells, "ResetAttributes")
end

local function set_date()
	local day = wezterm.strftime("%-d")
	local day_suffix = day % 10 == 1 and day % 100 ~= 11 and "st"
		or (day % 10 == 2 and day % 100 ~= 12 and "nd" or (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th"))

	local date = wezterm.strftime("%a, %b " .. day .. day_suffix)
	push(date, "", colors.bg, colors.blue)
end

local function set_time()
	local date = wezterm.strftime("%-I:%M %p")
	push(date, "", colors.bg, colors.blue)
end

wezterm.on("update-right-status", function(window, pane)
	cells = {}
	set_date()
	set_time()

	window:set_right_status(wezterm.format(cells))
end)
