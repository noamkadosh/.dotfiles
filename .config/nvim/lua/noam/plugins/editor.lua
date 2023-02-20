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
		event = "BufReadPre",
		config = function()
			require("persistence").setup({})

			vim.api.nvim_set_keymap(
				"n",
				"<leader>qs",
				[[<cmd>lua require("persistence").load()<cr>]],
				{ desc = "Restore session (Current Dir)" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>ql",
				[[<cmd>lua require("persistence").load({ last = true })<cr>]],
				{ desc = "Restore last session" }
			)
			vim.api.nvim_set_keymap(
				"n",
				"<leader>qd",
				[[<cmd>lua require("persistence").stop()<cr>]],
				{ desc = "Stop Persistence" }
			)
		end,
	},

	{
		"Lilja/zellij.nvim",
		config = function()
			require("zellij").setup({
				vimTmuxNavigatorKeybinds = true,
			})
		end,
	},

	{
		"windwp/nvim-spectre",
		lazy = true,
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
		"theprimeagen/harpoon",
		lazy = true,
		keys = function()
			local mark = require("harpoon.mark")
			local ui = require("harpoon.ui")

			-- There is a problem in alacritty where the Alt (Option) key is not working properly
			-- The appropriate keymap is commented out
			-- (https://github.com/alacritty/alacritty/issues/62)
			-- (https://github.com/alacritty/alacritty/issues/93)
			vim.keymap.set("n", "<leader>h", mark.add_file, { desc = "Add file to Harpoon" })
			vim.keymap.set("n", "´", ui.toggle_quick_menu, { desc = "Toggle Harpoon panel" }) -- <A-e>
			vim.keymap.set("n", "˙", function()
				ui.nav_file(1)
			end, { desc = "Navigate to file 1" }) -- <A-h>
			vim.keymap.set("n", "†", function()
				ui.nav_file(2)
			end, { desc = "Navigate to file 2" }) -- <A-t>
			vim.keymap.set("n", "˜", function()
				ui.nav_file(3)
			end, { desc = "Navigate to file 3" }) -- <A-n>
			vim.keymap.set("n", "ß", function()
				ui.nav_file(4)
			end, { desc = "Navigate to file 4" }) -- <A-s>
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
					vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
					vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
				end,
			})

			vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>", { desc = "Toggle Aerial view" })
			vim.keymap.set(
				"n",
				"<leader>ds",
				"<cmd>call aerial#fzf()<cr>",
				{ silent = true, desc = "Trigger fuzzy finding for Aerial" }
			)
		end,
	},

	{
		"folke/trouble.nvim",
		event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
		config = function()
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
				{ silent = true, noremap = true, desc = "Workspace diagnostics (Trouble)" }
			)
			vim.keymap.set(
				"n",
				"<leader>td",
				"<cmd>TroubleToggle document_diagnostics<cr>",
				{ silent = true, noremap = true, desc = "Document diagnostics (Trouble)" }
			)
			vim.keymap.set(
				"n",
				"<leader>tl",
				"<cmd>TroubleToggle loclist<cr>",
				{ silent = true, noremap = true, desc = "Location list (Trouble)" }
			)
			vim.keymap.set(
				"n",
				"<leader>tq",
				"<cmd>TroubleToggle quickfix<cr>",
				{ silent = true, noremap = true, desc = "Quickfix list (Trouble)" }
			)
			vim.keymap.set(
				"n",
				"gR",
				"<cmd>TroubleToggle lsp_references<cr>",
				{ silent = true, noremap = true, desc = "LSP references" }
			)
			require("trouble").setup({})
		end,
	},

	{
		"numToStr/Comment.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("Comment").setup({
				pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
			})
		end,
	},

	{ "RRethy/vim-illuminate", event = { "BufReadPost", "BufNewFile" } },

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
}
