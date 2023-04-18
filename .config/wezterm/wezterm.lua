local wezterm = require("wezterm")
local config = {}

config.term = "wezterm"

config.font = wezterm.font("LeagueMono Nerd Font")
config.font_size = 18.0
config.line_height = 1.25
config.color_scheme = "tokyonight_night"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = "#7aa2f7",
			fg_color = "#1a1b26",
			intensity = "Bold",
		},
	},
}

return config
