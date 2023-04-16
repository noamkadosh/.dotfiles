require("manager")

require("remap")
require("set")

local options = require("options")
local theme = require("plugins.theme")
local treesitter = require("plugins.treesitter")
local ui = require("plugins.ui")

require("lazy").setup({
    theme,
    treesitter,
    ui,
}, options)
