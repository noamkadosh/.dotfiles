return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            require("which-key").setup({})
        end,
    },

    {
        "folke/persistence.nvim",
        config = function()
            require("persistence").setup({})

            vim.api.nvim_set_keymap(
                "n",
                "<leader>os",
                [[<cmd>lua require("persistence").load()<cr>]],
                { desc = "Restore session (Current Dir)" }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>ol",
                [[<cmd>lua require("persistence").load({ last = true })<cr>]],
                { desc = "Restore last session" }
            )
            vim.api.nvim_set_keymap(
                "n",
                "<leader>od",
                [[<cmd>lua require("persistence").stop()<cr>]],
                { desc = "Stop Persistence" }
            )
        end,
    },

    {
        "windwp/nvim-spectre",
        lazy = true,
        opts = {
            live_update = true,
            is_insert_mode = true,
        },
        keys = {
            {
                "<leader>sr",
                function()
                    require("spectre").open()
                end,
                desc = "Search and replace (Spectre)",
            },
            {
                "<leader>sw",
                function()
                    require("spectre").open_visual({ select_word = true })
                end,
                desc = "Search current word (Spectre)",
            },
            {
                "<leader>sv",
                function()
                    require("spectre").open_visual()
                end,
                desc = "Search current word (Spectre)",
            },
            {
                "<leader>sp",
                function()
                    require("spectre").open_file_search()
                end,
                desc = "Search in current file (Spectre)",
            },
        },
    },

    {
        "j-morano/buffer_manager.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        config = function()
            local keys = "0123456789"

            require("buffer_manager").setup({
                line_keys = keys,
            })

            local buffer_manager_ui = require("buffer_manager.ui")

            vim.keymap.set(
                "n",
                "<leader>bm",
                buffer_manager_ui.toggle_quick_menu,
                { desc = "Toggle buffers list" }
            )
            vim.keymap.set(
                "n",
                "<leader>bk",
                buffer_manager_ui.nav_next,
                { desc = "Next buffer" }
            )
            vim.keymap.set(
                "n",
                "<leader>bj",
                buffer_manager_ui.nav_prev,
                { desc = "Previous buffer" }
            )
            --
            for i = 1, #keys do
                local key = keys:sub(i, i)
                vim.keymap.set("n", "<F" .. key + 2 .. ">", function()
                    buffer_manager_ui.nav_file(i)
                end, { desc = "Navigate to buffer " .. i })
            end
        end,
    },

    {
        "mg979/vim-visual-multi",
        branch = "master",
        event = { "BufReadPost", "BufNewFile" },
    },

    {
        "stevearc/aerial.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("aerial").setup({
                on_attach = function(bufnr)
                    vim.keymap.set(
                        "n",
                        "{",
                        "<cmd>AerialPrev<CR>",
                        { buffer = bufnr }
                    )
                    vim.keymap.set(
                        "n",
                        "}",
                        "<cmd>AerialNext<CR>",
                        { buffer = bufnr }
                    )
                end,
            })

            vim.keymap.set(
                "n",
                "<leader>av",
                "<cmd>AerialToggle!<CR>",
                { desc = "Toggle Aerial view" }
            )
            vim.keymap.set(
                "n",
                "<leader>as",
                "<cmd>call aerial#fzf()<cr>",
                { silent = true, desc = "Trigger fuzzy finding for Aerial" }
            )
        end,
    },

    {
        "folke/trouble.nvim",
        lazy = true,
        keys = function()
            vim.keymap.set(
                "n",
                "<leader>tx",
                "<cmd>TroubleToggle<cr>",
                { silent = true, noremap = true, desc = "Toggle Trouble" }
            )
            vim.keymap.set(
                "n",
                "<leader>tw",
                "<cmd>TroubleToggle workspace_diagnostics<cr>",
                {
                    silent = true,
                    noremap = true,
                    desc = "Workspace diagnostics (Trouble)",
                }
            )
            vim.keymap.set(
                "n",
                "<leader>td",
                "<cmd>TroubleToggle document_diagnostics<cr>",
                {
                    silent = true,
                    noremap = true,
                    desc = "Document diagnostics (Trouble)",
                }
            )
            vim.keymap.set("n", "<leader>tl", "<cmd>TroubleToggle loclist<cr>", {
                silent = true,
                noremap = true,
                desc = "Location list (Trouble)",
            })
            vim.keymap.set("n", "<leader>tq", "<cmd>TroubleToggle quickfix<cr>", {
                silent = true,
                noremap = true,
                desc = "Quickfix list (Trouble)",
            })
            vim.keymap.set(
                "n",
                "gR",
                "<cmd>TroubleToggle lsp_references<cr>",
                { silent = true, noremap = true, desc = "LSP references" }
            )
        end,
        config = function()
            require("trouble").setup({})
        end,
    },

    {
        "numToStr/Comment.nvim",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("Comment").setup({
                pre_hook = require(
                    "ts_context_commentstring.integrations.comment_nvim"
                ).create_pre_hook(),
            })
        end,
    },

    {
        "zbirenbaum/neodim",
        event = "LspAttach",
        config = function()
            require("neodim").setup({
                alpha = 0.4,
                blend_color = "#1A1B26",
            })
        end,
    },

    {
        "echasnovski/mini.bufremove",
        version = false,
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            local bufremove = require("mini.bufremove")
            bufremove.setup({})

            vim.keymap.set("n", "<leader>bd", function()
                require("mini.bufremove").delete(0, false)
            end, { desc = "Delete Buffer" })
            vim.keymap.set("n", "<leader>bD", function()
                require("mini.bufremove").delete(0, true)
            end, { desc = "Delete Buffer (Force)" })
        end,
    },

    -- {
    --     "theprimeagen/harpoon",
    --     lazy = true,
    --     keys = function()
    --         local mark = require("harpoon.mark")
    --         local ui = require("harpoon.ui")
    --
    --         vim.keymap.set("n", "<leader>ha", mark.add_file, { desc = "Add file to Harpoon" })
    --         vim.keymap.set("n", "<leader>he", ui.toggle_quick_menu, { desc = "Toggle Harpoon panel" })
    --         vim.keymap.set("n", "<leader>hh", function()
    --             ui.nav_file(1)
    --         end, { desc = "Navigate to file 1" })
    --         vim.keymap.set("n", "<leader>ht", function()
    --             ui.nav_file(2)
    --         end, { desc = "Navigate to file 2" })
    --         vim.keymap.set("n", "<leader>hn", function()
    --             ui.nav_file(3)
    --         end, { desc = "Navigate to file 3" })
    --         vim.keymap.set("n", "<leader>hs", function()
    --             ui.nav_file(4)
    --         end, { desc = "Navigate to file 4" })
    --     end,
    -- },
}
