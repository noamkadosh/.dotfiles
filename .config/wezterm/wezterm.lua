local wezterm = require("wezterm")
require("tabs")
require("datetime")

local config = {}

config.term = "wezterm"

config.font = wezterm.font("LeagueMono Nerd Font")
config.font_size = 18.0
config.line_height = 1.25
config.color_scheme = "tokyonight_night"

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 24

return config
