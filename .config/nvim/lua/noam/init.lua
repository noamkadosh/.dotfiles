local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local remap_info = require("noam.remap")
require("noam.set")

local options = require("noam.options")

require("lazy").setup("noam.plugins", options)

local which_key = require("which-key")
which_key.register(remap_info.normal_mode)
which_key.register(remap_info.visual_mode, { mode = "v" })

