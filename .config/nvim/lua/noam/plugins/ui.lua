return {
	{
		"nvim-lualine/lualine.nvim",
		-- event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
		dependencies = {},
		config = function()
			local noice = require("noice")
			local colors = require("tokyonight.colors").setup({})
			local navic = require("nvim-navic")

			require("lualine").setup({
				options = {
					theme = "tokyonight",
					component_separators = { left = "", right = "" },
					section_separators = { left = "    ", right = "    " },
				},
				sections = {
					lualine_b = {
						{
							noice.api.status.command.get,
							cond = noice.api.status.command.has,
							padding = { left = 0, right = 4 },
						},
					},
					lualine_c = {
						"branch",
						"diff",
						{
							"diagnostics",
							symbols = {
								error = " ",
								warn = " ",
								hint = " ",
								info = " ",
							},
                            update_in_insert = true,
							padding = { left = 4, right = 0 },
							separator = "%#StatusLineSeparator# · %#StatusLine#",
						},
						{
							require("noam.plugins.utils.utils").lsp_breakdown,
							padding = { left = 0, right = 0 },
						},
						{
							noice.api.status.search.get,
							cond = noice.api.status.search.has,
							color = { fg = colors.orange },
							padding = { left = 4, right = 0 },
						},
					},
					lualine_x = {
						{ "encoding", separator = "%#StatusLineSeparator#·%#StatusLine#" },
						{ "fileformat", separator = "%#StatusLineSeparator#·%#StatusLine#" },
						{ "filetype", separator = "    " },
						{
							"progress",
							separator = "%#StatusLineSeparator# · %#StatusLine#",
							padding = { right = 0, left = 1 },
						},
						{
							"location",
							fmt = function(str)
								return str:match("^%s*(.-)%s*$")
							end,
							padding = 0,
						},
					},
					lualine_y = {},
					lualine_z = {
						function()
							local day = tonumber(os.date("%d"):match("^%d*"))
							local hour = tonumber(os.date("%I"))
							local dateTime = " "
								.. os.date("%a, %b ")
								.. day
								.. (day % 10 == 1 and day % 100 ~= 11 and "st" or (day % 10 == 2 and day % 100 ~= 12 and "nd" or (day % 10 == 3 and day % 100 ~= 13 and "rd" or "th")))
								.. " 󱑇 "
								.. hour
								.. os.date(":%M %p")
							return dateTime
						end,
					},
				},
				winbar = {
					lualine_a = {
						{
							function()
								return vim.api.nvim_get_current_buf()
							end,
						},
						{
							"filename",
							file_status = true,
							path = 1,
						},
					},
					lualine_c = {
						{
							function()
								return navic.get_location() .. "%#StatusLine#"
							end,
							cond = navic.is_available,
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
