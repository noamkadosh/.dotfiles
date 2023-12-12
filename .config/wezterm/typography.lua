local wezterm = require("wezterm")

local M = {}

-- Weights
local REGULAR = "Regular"
local MEDIUM = "Medium"
local BOLD = "Bold"
local EXTRA_BOLD = "ExtraBold"
-- Styles
local NORMAL = "Normal"
local ITALIC = "Italic"
-- Ligatures features
local HARFBUZZ_FEATURES = {
    "calt",
    "liga",
    "dlig",
    "ss01",
    "ss02",
    "ss03",
    "ss04",
    "ss05",
    "ss06",
    "ss07",
    "ss08",
}

local MONASPACE_NEON = "Monaspace Neon"
local MONASPACE_ARGON = "Monaspace Argon"
local MONASPACE_KRYPTON = "Monaspace Krypton"
local MONASPACE_XENON = "Monaspace Xenon"
local MONASPACE_RADON = "Monaspace Radon"
local JETBRAINS_MONO = "JetBrains Mono Nerd Font"
local LEAGUE_MONO = "LeagueMono Nerd Font"

M.fonts = {
    monaspace_neon = {
        family = MONASPACE_NEON,
        weight = MEDIUM,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_argon = {
        family = MONASPACE_ARGON,
        weight = MEDIUM,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_krypton = {
        family = MONASPACE_KRYPTON,
        weight = MEDIUM,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_xenon = {
        family = MONASPACE_XENON,
        weight = MEDIUM,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    monaspace_radon = {
        family = MONASPACE_RADON,
        weight = MEDIUM,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    jetbrains_mono = {
        family = JETBRAINS_MONO,
        weight = REGULAR,
        harfbuzz_features = HARFBUZZ_FEATURES,
    },
    league_mono = {
        family = LEAGUE_MONO,
        weight = REGULAR,
    },
}

M.font_rules = {
    monaspace_neon = {
        {
            intensity = BOLD,
            italic = false,
            font = wezterm.font(
                MONASPACE_NEON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = NORMAL }
            ),
        },
        {
            intensity = BOLD,
            italic = true,
            font = wezterm.font(
                MONASPACE_NEON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = ITALIC }
            ),
        },
    },
    monaspace_argon = {
        {
            intensity = BOLD,
            italic = false,
            font = wezterm.font(
                MONASPACE_ARGON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = NORMAL }
            ),
        },
        {
            intensity = BOLD,
            italic = true,
            font = wezterm.font(
                MONASPACE_ARGON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = ITALIC }
            ),
        },
    },
    monaspace_krypton = {
        {
            intensity = BOLD,
            italic = false,
            font = wezterm.font(
                MONASPACE_KRYPTON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = NORMAL }
            ),
        },
        {
            intensity = BOLD,
            italic = true,
            font = wezterm.font(
                MONASPACE_KRYPTON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = ITALIC }
            ),
        },
    },
    monaspace_xenon = {
        {
            intensity = BOLD,
            italic = false,
            font = wezterm.font(
                MONASPACE_XENON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = NORMAL }
            ),
        },
        {
            intensity = BOLD,
            italic = true,
            font = wezterm.font(
                MONASPACE_XENON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = ITALIC }
            ),
        },
    },
    monaspace_radon = {
        {
            intensity = BOLD,
            italic = false,
            font = wezterm.font(
                MONASPACE_RADON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = NORMAL }
            ),
        },
        {
            intensity = BOLD,
            italic = true,
            font = wezterm.font(
                MONASPACE_RADON,
                { weight = EXTRA_BOLD, stretch = NORMAL, style = ITALIC }
            ),
        },
    },
}

return M
