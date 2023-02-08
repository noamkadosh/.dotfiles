return {
    "folke/zen-mode.nvim",
    config = function()
        vim.keymap.set("n", "<leader>z", vim.cmd.ZenMode, {})
        require("which-key").register({
            z = "Zen Mode",
        }, { prefix = "<leader>" })
        require("zen-mode").setup({
            plugins = {
                alacritty = {
                    enabled = true,
                    font = "20",
                },
            },
        })
    end
}

