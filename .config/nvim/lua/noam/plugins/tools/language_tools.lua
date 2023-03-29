local M = {}

local function setup_null_ls()
    local null_ls = require("null-ls")

    null_ls.setup({
        sources = {
            -- Git
            null_ls.builtins.code_actions.gitsigns,

            -- Rust
            null_ls.builtins.formatting.rustfmt,

            -- TS, JS
            null_ls.builtins.code_actions.eslint_d,
            require("typescript.extensions.null-ls.code-actions"),
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.formatting.eslint_d,
            null_ls.builtins.formatting.prettierd,

            -- HTML
            null_ls.builtins.diagnostics.tidy,
            null_ls.builtins.formatting.tidy,

            -- CSS
            null_ls.builtins.diagnostics.stylelint,
            null_ls.builtins.formatting.stylelint,

            -- Go
            null_ls.builtins.diagnostics.golangci_lint,
            null_ls.builtins.formatting.gofmt,
            null_ls.builtins.formatting.goimports,

            -- Lua
            null_ls.builtins.diagnostics.selene,
            null_ls.builtins.formatting.stylua,

            -- Docker
            null_ls.builtins.diagnostics.hadolint,

            -- Nix
            null_ls.builtins.code_actions.statix,
            null_ls.builtins.diagnostics.statix,
            null_ls.builtins.formatting.alejandra,

            -- Yaml
            null_ls.builtins.diagnostics.actionlint,
            null_ls.builtins.diagnostics.yamllint,
            null_ls.builtins.formatting.yamlfmt,

            -- Markdown
            null_ls.builtins.diagnostics.markdownlint,

            -- Spellcheck
            -- null_ls.builtins.diagnostics.cspell,
            -- null_ls.builtins.code_actions.cspell,
        },
    })
end

local function setup_rust()
    local rt = require("rust-tools")

    local path = vim.fn.glob(
        vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/"
    ) or ""
    local codelldb_path = path .. "adapter/codelldb"
    local liblldb_path = path .. "lldb/lib/liblldb.dylib"

    rt.setup({
        tools = {
            inlay_hints = {
                parameter_hints_prefix = " <- ",
                other_hints_prefix = " => ",
            },
            hover_actions = {
                max_width = nil,
                max_height = nil,
                auto_focus = true,
            },
        },
        server = {
            on_attach = function(_, bufnr)
                -- Hover actions
                vim.keymap.set(
                    "n",
                    "<leader>rh",
                    rt.hover_actions.hover_actions,
                    { desc = "Rust hover actions", buffer = bufnr }
                )
                -- Code action groups
                vim.keymap.set(
                    "n",
                    "<leader>rc",
                    rt.code_action_group.code_action_group,
                    { desc = "Rust code actions", buffer = bufnr }
                )
            end,
        },
        dap = {
            adapter = require("rust-tools.dap").get_codelldb_adapter(
                codelldb_path,
                liblldb_path
            ),
        },
    })
end

local function setup_typescript()
    require("typescript").setup({
        disable_commands = false,
        server = {
            on_attach = function(_, bufnr)
                vim.keymap.set(
                    "n",
                    "<leader>ci",
                    "<cmd>TypescriptAddMissingImports<cr>",
                    { buffer = bufnr }
                )
            end,
        },
    })
end

local function setup_golang()
    require("go").setup({})
end

local function setup_lua(lsp)
    require("lspconfig").lua_ls.setup(lsp.nvim_lua_ls())
end

function M.setup_language_tools(lsp)
    setup_null_ls()
    setup_rust()
    setup_typescript()
    setup_golang()
    setup_lua(lsp)
end

return M
