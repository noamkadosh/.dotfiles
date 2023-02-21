return {
	"VonHeikemen/lsp-zero.nvim",
	dependencies = {
		-- LSP Support
		{
			"folke/neoconf.nvim",
			cmd = "Neoconf",
			config = true,
		},
		{
			"folke/neodev.nvim",
			opts = {
				experimental = { pathStrict = true },
			},
		},
		{ "neovim/nvim-lspconfig" },

		-- DAP
		{ "mfussenegger/nvim-dap" },
		{ "rcarriga/nvim-dap-ui" },
		{ "theHamsta/nvim-dap-virtual-text" },

		-- null-ls
		{ "jose-elias-alvarez/null-ls.nvim" },

		-- Mason
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },
		{ "jay-babu/mason-nvim-dap.nvim" },
		{ "jay-babu/mason-null-ls.nvim" },

		-- Language tools
		{ "simrat39/rust-tools.nvim" },
		{ "jose-elias-alvarez/typescript.nvim" },
		{
			"ray-x/go.nvim",
			dependencies = {
				"ray-x/guihua.lua",
			},
			ft = { "go", "gomod" },
			build = ':lua require("go.install").update_all_sync()',
		},
		{ "b0o/schemastore.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "hrsh7th/cmp-cmdline" },
		{ "petertriho/cmp-git" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },

		-- Github copilot
		{ "zbirenbaum/copilot.lua" },
		{ "zbirenbaum/copilot-cmp" },

		-- LSP Icons
		{ "onsails/lspkind.nvim" },

		-- Navic
		{ "SmiteshP/nvim-navic" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
	},
	event = { "BufReadPre", "BufNewFile", "InsertEnter", "CmdlineEnter" },
	config = function()
		require("neodev").setup({
			library = { plugins = { "nvim-dap-ui" }, types = true },
		})

		local lsp = require("lsp-zero")
		require("noam.plugins.lsp.lsp").setup_lsp_zero(lsp)
		require("noam.plugins.lsp.completion").setup_cmp(lsp)
		require("noam.plugins.lsp.null-ls").setup_null_ls()
		require("noam.plugins.lsp.debug").setup_dap()

		local language_tools = require("noam.plugins.lsp.language_tools")
		language_tools.setup_rust(lsp)
		language_tools.setup_typescript()
		language_tools.setup_go()
		language_tools.setup_lua(lsp)
		language_tools.setup_json(lsp)

		lsp.setup()

		require("noice").setup({
			lsp = {
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true,
				},
			},
		})
	end,
}
