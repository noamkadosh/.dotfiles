local wezterm = require("wezterm")
local typography = require("typography")
local fonts = typography.fonts
local font_rules = typography.font_rules

local config = {
    term = "wezterm",
    font = wezterm.font_with_fallback({
        fonts.monaspace_neon,
        fonts.jetbrains_mono,
    }),
    font_rules = {
        table.unpack(font_rules.monaspace_neon),
    },
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0,
    },
    window_background_opacity = 0.9,
    font_size = 18.0,
    line_height = 1.22,
    cell_width = 0.95,
    color_scheme = "tokyonight_night",
    enable_tab_bar = false,
    send_composed_key_when_right_alt_is_pressed = false,
    hyperlink_rules = {
        table.unpack(wezterm.default_hyperlink_rules()),
        -- Linkify things that look like URLs with numeric addresses as hosts.
        -- E.g. http://127.0.0.1:8000 for a local development server,
        -- or http://192.168.1.1 for the web interface of many routers.
        {
            regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
            format = "$0",
        },
        -- Make task numbers clickable
        -- The first matched regex group is captured in $1.
        {
            regex = [[\b[tT](\d+)\b]],
            format = "https://example.com/tasks/?t=$1",
        },
        -- Make username/project paths clickable. This implies paths like the following are for GitHub.
        -- ( "nvim-treesitter/nvim-treesitter" | wbthomason/packer.nvim | wez/wezterm | "wez/wezterm.git" )
        -- As long as a full URL hyperlink regex exists above this it should not match a full URL to
        -- GitHub or GitLab / BitBucket (i.e. https://gitlab.com/user/project.git is still a whole clickable URL)
        {
            regex = [[["]?([\w\d]{1}[-\w\d]+)(/){1}([-\w\d\.]+)["]?]],
            format = "https://www.github.com/$1/$3",
        },
    },
}

return config
