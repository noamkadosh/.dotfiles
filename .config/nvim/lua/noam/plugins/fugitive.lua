return {
    "tpope/vim-fugitive",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
        require("which-key").register({
            ["<leader>gs"] = "Git",
        })
    end,
  }
