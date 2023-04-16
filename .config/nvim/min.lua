require("manager")

require("remap")
require("set")

local options = require("options")
local theme = require("plugins.theme")
local treesitter = require("plugins.treesitter")
local ui = require("plugins.ui")
local cmp = require("plugins.completion")

require("lazy").setup({
    theme,
    treesitter,
    ui,
    { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    { "tzachar/fuzzy.nvim" },
    cmp,
}, options)
