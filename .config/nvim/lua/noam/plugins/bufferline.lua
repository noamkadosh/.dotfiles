return {
    "akinsho/bufferline.nvim",
    tag = "v3.1.0",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function ()
        vim.opt.termguicolors = true
        require("bufferline").setup({
                options = {
                diagnostics = "nvim_lsp",
                indicator = { style = 'underline' },
                separator_style = "thick",
                show_close_icon = false,
                hover = { enabled = true, reveal = { 'close' } },
            }
        })
    end
}

