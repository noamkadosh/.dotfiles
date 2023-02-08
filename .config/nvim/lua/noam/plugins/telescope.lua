return {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.0",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        },
    },
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
                        preview_width = 0.618
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
            }
        })
        telescope.load_extension("fzf")
        telescope.load_extension("file_browser")
        telescope.load_extension("projects")

        vim.keymap.set("n", "<leader>pv", telescope.extensions.file_browser.file_browser)
        vim.keymap.set("n", "<leader>pf", builtin.find_files, {})
        vim.keymap.set("n", "<leader>pg", builtin.git_files, {})
        vim.keymap.set("n", "<leader>ps", function()
            builtin.grep_string({
                search = vim.fn.input("Grep > ")
            })
        end)

        require("which-key").register({
            ["<leader>pv"] = "File browser",
            ["<leader>pf"] = "Find file",
            ["<leader>pg"] = "Find file in repository",
            ["<leader>ps"] = "Find file with grep",
            ["<leader>tr"] = "Open file with issues",
        })
    end
}
