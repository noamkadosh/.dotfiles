return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "tsakirist/telescope-lazy.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "debugloop/telescope-undo.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "jvgrootveld/telescope-zoxide",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            { "tzachar/fuzzy.nvim" },
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local themes = require("telescope.themes")
            local trouble = require("trouble.providers.telescope")

            -- not sure it works, missing mapping which-key description
            telescope.setup({
                defaults = {
                    prompt_prefix = " ",
                    sorting_strategy = "ascending",
                    dynamic_preview_title = true,
                    layout_config = {
                        horizontal = {
                            preview_cutoff = 40,
                            preview_width = 0.618,
                        },
                    },
                    mappings = {
                        i = { ["<leader>tr"] = trouble.open_with_trouble },
                        n = { ["<leader>tr"] = trouble.open_with_trouble },
                    },
                },
                extensions = {
                    ["ui-select"] = {
                        require("telescope.themes").get_dropdown({}),
                    },
                    file_browser = {
                        -- hidden = true,
                        hijack_netrw = true,
                        path = "%:p:h",
                        cwd_to_path = true,
                    },
                    fzf = {
                        override_generic_sorter = true,
                        override_file_sorter = true,
                    },
                    undo = {
                        use_delta = true,
                        side_by_side = true,
                        layout_strategy = "vertical",
                        layout_config = {
                            preview_height = 0.8,
                        },
                    },
                },
            })

            telescope.load_extension("fzf")
            telescope.load_extension("ui-select")
            telescope.load_extension("lazy")
            telescope.load_extension("file_browser")
            telescope.load_extension("undo")
            telescope.load_extension("zoxide")
            telescope.load_extension("projects")
            telescope.load_extension("noice")
            telescope.load_extension("aerial")

            vim.keymap.set(
                "n",
                "<leader>pv",
                telescope.extensions.file_browser.file_browser,
                { desc = "File browser" }
            )
            vim.keymap.set(
                "n",
                "<leader>pf",
                builtin.find_files,
                { desc = "Find file" }
            )
            vim.keymap.set(
                "n",
                "<leader>pg",
                builtin.git_files,
                { desc = "Find file (Git)" }
            )
            vim.keymap.set(
                "n",
                "<leader>ps",
                builtin.grep_string,
                { desc = "Find file (Grep)" }
            )
            vim.keymap.set(
                "n",
                "<leader>cd",
                telescope.extensions.zoxide.list,
                { desc = "Jump list (Zoxide)" }
            )
            vim.keymap.set(
                "n",
                "<leader>ca",
                vim.lsp.buf.code_action,
                { desc = "Line code actions" }
            )
            vim.keymap.set(
                "n",
                "<leader>u",
                "<cmd>Telescope undo<cr>",
                { desc = "Undo" }
            )
            vim.keymap.set("n", "<leader>sb", function()
                local opt =
                    themes.get_dropdown({ height = 10, previewer = false })
                builtin.current_buffer_fuzzy_find(opt)
            end, { desc = "Fuzzy find current buffer" })

            require("which-key").register({
                ["<leader>tr"] = "Open file with issues",
            })
        end,
    },
}
