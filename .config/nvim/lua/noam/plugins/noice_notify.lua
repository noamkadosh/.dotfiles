return {
    'folke/noice.nvim',
    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify",
    },
    config = function()
        require("notify").setup({
            background_colour = "#000000",
        })

        require("noice").setup({
            lsp = {
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true,
                },
            },
            presets = {
                bottom_search = true,
                command_palette = true,
                long_message_to_split = true,
                inc_rename = false,
                lsp_doc_border = false,
            },
        })

        vim.keymap.set("n", "<leader>nl", function()
            require("noice").cmd("last")
        end)

        vim.keymap.set("n", "<leader>nh", function()
            require("noice").cmd("history")
        end)

        vim.keymap.set("c", "<S-Enter>", function()
            require("noice").redirect(vim.fn.getcmdline())
        end, { desc = "Redirect Cmdline" })

        vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
            if not require("noice.lsp").scroll(4) then
                return "<c-f>"
            end
        end, { silent = true, expr = true })

        vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
            if not require("noice.lsp").scroll(-4) then
                return "<c-b>"
            end
        end, { silent = true, expr = true })

        local which_key = require("which-key")
        which_key.register({
            ["<leader>nl"] = "Last message in popup",
            ["<leader>nh"] = "Message history",
            ["<c-f>"] = "Lsp scroll history forward",
            ["<c-b>"] = "Lsp scroll history back",
        })
        which_key.register({
            ["<c-f>"] = "Lsp scroll history forward",
            ["<c-b>"] = "Lsp scroll history back",
        }, { mode = "i" })
        which_key.register({
            ["<c-f>"] = "Lsp scroll history forward",
            ["<c-b>"] = "Lsp scroll history back",
        }, { mode = "s" })
    end,
}
