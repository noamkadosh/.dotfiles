return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        dependencies = {
            "tsakirist/telescope-lazy.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "debugloop/telescope-undo.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
            "jvgrootveld/telescope-zoxide",
            "nvim-telescope/telescope-dap.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
        },
        -- Lazy load Telescope, can't do that now
        -- cmd = "Telescope",
        -- keys = function()
        -- 	local telescope = require("telescope")
        -- 	local builtin = require("telescope.builtin")

        -- 	return {
        -- 		{ "<leader>pv", telescope.extensions.file_browser.file_browser, { desc = "File browser" } },
        -- 		{ "<leader>pf", builtin.find_files, { desc = "Find file" } },
        -- 		{ "<leader>pg", builtin.git_files, { desc = "Find file (Git)" } },
        -- 		{
        -- 			"<leader>ps",
        -- 			function()
        -- 				builtin.grep_string({
        -- 					search = vim.fn.input({ " Grep > " }),
        -- 				})
        -- 			end,
        -- 			{ desc = "Find file (Grep)" },
        -- 		},
        -- 		{ "<leader>cd", telescope.extensions.zoxide.list, { desc = "Jump list (Zoxide)" } },
        -- 	}
        -- end,
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
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
                    file_browser = {
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
            telescope.load_extension("lazy")
            telescope.load_extension("file_browser")
            telescope.load_extension("undo")
            telescope.load_extension("dap")
            telescope.load_extension("zoxide")
            telescope.load_extension("projects")
            telescope.load_extension("noice")
            telescope.load_extension("aerial")
            telescope.load_extension("ui-select")

            vim.keymap.set("n", "<leader>pv", telescope.extensions.file_browser.file_browser, { desc = "File browser" })
            vim.keymap.set("n", "<leader>pf", builtin.find_files, { desc = "Find file" })
            vim.keymap.set("n", "<leader>pg", builtin.git_files, { desc = "Find file (Git)" })
            vim.keymap.set("n", "<leader>ps", function()
                builtin.grep_string({
                    search = vim.fn.input({ " Grep > " }),
                })
            end, { desc = "Find file (Grep)" })
            vim.keymap.set("n", "<leader>cd", telescope.extensions.zoxide.list, { desc = "Jump list (Zoxide)" })
            vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>", { desc = "Undo" })

            require("which-key").register({
                    ["<leader>tr"] = "Open file with issues",
            })
        end,
    },

    {
        "nvim-telescope/telescope-dap.nvim",
        lazy = true,
        dependencies = {
            "mfussenegger/nvim-dap",
        },
    },
}
