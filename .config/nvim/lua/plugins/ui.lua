return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {},
        config = function()
            local noice = require("noice")
            local colors = require("tokyonight.colors").setup({})
            local navic = require("nvim-navic")

            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = " ", right = " " },
                },
                sections = {
                    lualine_b = {
                        "branch",
                        "diff",
                    },
                    lualine_c = {
                        {
                            "diagnostics",
                            symbols = {
                                error = " ",
                                warn = " ",
                                hint = " ",
                                info = " ",
                            },
                            update_in_insert = true,
                            separator = "%#StatusLineSeparator#·%#StatusLine#",
                        },
                        {
                            require("plugins.tools.helpers").lsp_breakdown,
                            separator = "    ",
                        },
                        {
                            noice.api.status.search.get,
                            cond = noice.api.status.search.has,
                            color = { fg = colors.orange },
                        },
                    },
                    lualine_x = {
                        {
                            "encoding",
                            separator = "%#StatusLineSeparator#·%#StatusLine#",
                            padding = 1,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "fileformat",
                            separator = "%#StatusLineSeparator#·%#StatusLine#",
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "filetype",
                            padding = 1,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                    },
                    lualine_y = {
                        {
                            noice.api.status.command.get,
                            cond = noice.api.status.command.has,
                            padding = { right = 0, left = 1 },
                        },
                    },
                    lualine_z = {
                        {
                            "progress",
                            separator = "·",
                            padding = { right = 0, left = 1 },
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "location",
                            fmt = function(str)
                                return str:match("^%s*(.-)%s*$")
                            end,
                            padding = { left = 0, right = 1 },
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                    },
                },
                winbar = {
                    lualine_a = {
                        {
                            function()
                                return vim.api.nvim_get_current_buf()
                            end,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                        {
                            "filename",
                            file_status = true,
                            path = 1,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                    },
                    lualine_c = {
                        {
                            function()
                                return (navic.get_location() or "")
                                    .. "%#StatusLine#"
                            end,
                            cond = function()
                                return vim.api.nvim_get_current_buf() > 1
                            end,
                        },
                    },
                },
            })
        end,
    },

    {
        "SmiteshP/nvim-navic",
        lazy = true,
        opts = {
            highlight = true,
        },
    },

    {
        "yamatsum/nvim-cursorline",
        event = "VeryLazy",
        config = function()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    timeout = 0,
                    number = false,
                },
                cursorword = {
                    enable = false,
                },
            })
        end,
    },

    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        event = "VeryLazy",
        config = function()
            local colors = require("tokyonight.colors").setup({})

            require("notify").setup({
                background_colour = colors.bg,
            })

            require("noice").setup({
                lsp = {
                    hover = {
                        enabled = false,
                    },
                    signature = {
                        enabled = false,
                    },
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
            end, { desc = "Last message in popup" })

            vim.keymap.set("n", "<leader>nh", function()
                require("noice").cmd("history")
            end, { desc = "Message history" })

            vim.keymap.set("c", "<S-Enter>", function()
                require("noice").redirect(vim.fn.getcmdline())
            end, { desc = "Redirect Cmdline" })

            vim.keymap.set({ "n", "i", "s" }, "<c-f>", function()
                if not require("noice.lsp").scroll(4) then
                    return "<c-f>"
                end
            end, {
                silent = true,
                expr = true,
                desc = "Scroll history forward (LSP)",
            })

            vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
                if not require("noice.lsp").scroll(-4) then
                    return "<c-b>"
                end
            end, {
                silent = true,
                expr = true,
                desc = "Scroll history backward (LSP)",
            })
        end,
    },

    {
        "nmac427/guess-indent.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("guess-indent").setup({})
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            vim.opt.list = true

            local color_list = {
                "RainbowLight1",
                "RainbowLight2",
                "RainbowLight3",
                "RainbowLight4",
                "RainbowLight5",
                "RainbowLight6",
                "RainbowLight7",
            }

            local context_color_list = {
                "Rainbow1",
                "Rainbow2",
                "Rainbow3",
                "Rainbow4",
                "Rainbow5",
                "Rainbow6",
                "Rainbow7",
            }

            require("indent_blankline").setup({
                char_highlight_list = color_list,
                -- show_trailing_blankline_indent = false,
                -- indent_blankline_show_trailing_blankline_indent = true,
                -- space_char_highlight_list = color_list,
                use_treesitter = true,
                context_char = "┃",
                context_highlight_list = context_color_list,
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("todo-comments").setup({
                sign_priority = 10,
            })

            vim.keymap.set("n", "]t", function()
                require("todo-comments").jump_next()
            end, { desc = "Next todo comment" })

            vim.keymap.set("n", "[t", function()
                require("todo-comments").jump_prev()
            end, { desc = "Previous todo comment" })
        end,
    },

    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("colorizer").setup({})
        end,
    },

    {
        "Bekaboo/deadcolumn.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },

    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- {
    --     "akinsho/bufferline.nvim",
    --     tag = "v3.1.0",
    --     event = "VeryLazy",
    --     config = function()
    --         vim.opt.termguicolors = true
    --         require("bufferline").setup({
    --             options = {
    --                 diagnostics = "nvim_lsp",
    --                 indicator = { style = "underline" },
    --                 separator_style = "thick",
    --                 show_close_icon = false,
    --                 hover = { enabled = true, reveal = { "close" } },
    --             },
    --         })
    --     end,
    -- },
}
