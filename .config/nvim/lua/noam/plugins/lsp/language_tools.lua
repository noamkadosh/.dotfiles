local M = {}

function M.setup_rust(lsp)
	local rt = require("rust-tools")

	local rust_lsp = lsp.build_options("rust_analyzer", {
		single_file_support = false,
		on_attach = function(_, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { desc = "", buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { desc = "", buffer = bufnr })
		end,
	})

	rt.setup({
		server = { rust_lsp },
	})
end

function M.setup_typescript()
	require("typescript").setup({
		disable_commands = false,
	})
end

function M.setup_go()
	require("go").setup({})
end

function M.setup_lua(lsp)
	-- Fix Undefined global "vim"
	lsp.configure("lua_ls", {
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim" },
				},
				completion = {
					callSnippet = "Replace",
				},
			},
		},
	})
end

function M.setup_json(lsp)
	lsp.configure("jsonls", {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	})
end

return M
