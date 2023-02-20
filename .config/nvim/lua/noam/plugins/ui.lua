return {
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            local noice = require("noice")
            local colors = require("tokyonight.colors").setup({})

            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                },
                sections = {
                    lualine_c = {
                        {
                            function()
                                return require("nvim-navic").get_location()
                            end,
                            cond = function()
                                return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
                            end,
                        },
                    },
                    lualine_x = {
                        {
                            noice.api.status.message.get_hl,
                            cond = noice.api.status.message.has,
                            color = { fg = colors.red}
                        },
                        {
                            noice.api.status.command.get,
                            cond = noice.api.status.command.has,
                            color = { fg = colors.green },
                        },
                        {
                            noice.api.status.search.get,
                            cond = noice.api.status.search.has,
                            color = { fg = colors.orange },
                        },
                    },
                    lualine_y = { "progress", "location" },
                    lualine_z = {
                        function()
                            local day = tonumber(os.date("%d"):match("^%d*"))
                            local hour = tonumber(os.date("%I"))
                            local dateTime = " "
                                .. os.date("%a, %b ")
                                .. day
                                ..
                                (
                                day % 10 == 1 and day % 100 ~= 11 and "st" or
                                    (
                                    day % 10 == 2 and day % 100 ~= 12 and "nd" or
                                        (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th")))
                                .. "  "
                                .. hour
                                .. os.date(":%M %p")
                            return dateTime
                        end,
                    },
                },
            })
        end,
    },

    {
        "yamatsum/nvim-cursorline",
        event = "VeryLazy",
        config = function()
            require("nvim-cursorline").setup({
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true },
                },
            })
        end,
    },

    {
        "akinsho/bufferline.nvim",
        tag = "v3.1.0",
        event = "VeryLazy",
        config = function()
            vim.opt.termguicolors = true
            require("bufferline").setup({
                options = {
                    diagnostics = "nvim_lsp",
                    indicator = { style = "underline" },
                    separator_style = "thick",
                    show_close_icon = false,
                    hover = { enabled = true, reveal = { "close" } },
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
            require("notify").setup({
                background_colour = "#000000",
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
            end, { silent = true, expr = true, desc = "Scroll history forward (LSP)" })

            vim.keymap.set({ "n", "i", "s" }, "<c-b>", function()
                if not require("noice.lsp").scroll(-4) then
                    return "<c-b>"
                end
            end, { silent = true, expr = true, desc = "Scroll history backward (LSP)" })
        end,
    },

    {
        "stevearc/dressing.nvim",
        lazy = true,
        init = function()
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.select = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.select(...)
            end
            ---@diagnostic disable-next-line: duplicate-set-field
            vim.ui.input = function(...)
                require("lazy").load({ plugins = { "dressing.nvim" } })
                return vim.ui.input(...)
            end
        end,
    },

    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            vim.opt.list = true
            vim.opt.listchars:append("space:⋅")
            vim.opt.listchars:append("eol:↴")

            local colors = require("tokyonight.colors").setup()
            local util = require("tokyonight.util")

            local red = util.blend(colors.red, colors.bg, 0.1)
            local yellow = util.blend(colors.yellow, colors.bg, 0.1)
            local green = util.blend(colors.green, colors.bg, 0.1)
            local teal = util.blend(colors.teal, colors.bg, 0.1)
            local blue = util.blend(colors.blue, colors.bg, 0.1)
            local magenta = util.blend(colors.magenta, colors.bg, 0.1)
            local purple = util.blend(colors.purple, colors.bg, 0.1)

            vim.cmd("highlight Rainbow1 guibg=" .. red .. " gui=nocombine")
            vim.cmd("highlight Rainbow2 guibg=" .. yellow .. " gui=nocombine")
            vim.cmd("highlight Rainbow3 guibg=" .. green .. " gui=nocombine")
            vim.cmd("highlight Rainbow4 guibg=" .. teal .. " gui=nocombine")
            vim.cmd("highlight Rainbow5 guibg=" .. blue .. " gui=nocombine")
            vim.cmd("highlight Rainbow6 guibg=" .. magenta .. " gui=nocombine")
            vim.cmd("highlight Rainbow7 guibg=" .. purple .. " gui=nocombine")

            local color_list = {
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
                show_trailing_blankline_indent = false,
                space_char_blankline = " ",
                show_current_context = true,
                show_current_context_start = true,
            })
        end,
    },

    {
        "folke/todo-comments.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("todo-comments").setup({})

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
        "xiyaowong/virtcolumn.nvim",
        event = { "BufReadPre", "BufNewFile" },
    },

    { "nvim-tree/nvim-web-devicons", lazy = true },
}
