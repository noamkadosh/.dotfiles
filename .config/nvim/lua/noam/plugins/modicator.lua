return {
  'mawkler/modicator.nvim',
  dependencies = 'folke/tokyonight.nvim',
  init = function()
    vim.o.cursorline = true
    vim.o.number = true
    vim.o.termguicolors = true
  end,
  config = function()
    require('modicator').setup({})
  end,
}
