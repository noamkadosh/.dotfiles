require("noam")

-- send the last working directory to the shell, other part of the solution is in zsh config.
vim.fn.mkdir(vim.fn.expand('$HOME/.temp/nvim'), 'p')
vim.cmd([[autocmd VimLeave * call writefile([getcwd()], expand('$HOME/.temp/nvim/cwd'))]])

