local M = {}

function M.setup_null_ls()
	local null_ls = require("null-ls")

	null_ls.setup({
		sources = {
			null_ls.builtins.formatting.stylua,
			require("typescript.extensions.null-ls.code-actions"),
		},
	})

	require("mason-null-ls").setup({
		ensure_installed = nil,
		automatic_installation = true,
		automatic_setup = false,
	})
end

return M
