return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "nvim-telescope/telescope-dap.nvim" },
            { "theHamsta/nvim-dap-virtual-text" },
            { "mxsdev/nvim-dap-vscode-js" },
            "microsoft/vscode-js-debug",
            { "leoluz/nvim-dap-go" },
        },
        lazy = true,
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")
            dapui.setup({})
            require("telescope").load_extension("dap")
            require("nvim-dap-virtual-text").setup({})

            require("dap-vscode-js").setup({
                debugger_path = vim.fn.glob(
                    vim.fn.stdpath("data") .. "/lazy/vscode-js-debug/"
                ),
                log_file_level = vim.log.levels.TRACE,
            })

            for _, language in ipairs({
                "typescript",
                "javascript",
                "typescriptreact",
                "javascriptreact",
            }) do
                require("dap").configurations[language] = {
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Launch file",
                        program = "${file}",
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "attach",
                        name = "Attach",
                        processId = require("dap.utils").pick_process,
                        cwd = "${workspaceFolder}",
                    },
                    {
                        type = "pwa-node",
                        request = "launch",
                        name = "Debug Jest Tests",
                        -- trace = true, -- include debugger info
                        runtimeExecutable = "node",
                        runtimeArgs = {
                            "./node_modules/jest/bin/jest.js",
                            "--runInBand",
                        },
                        rootPath = "${workspaceFolder}",
                        cwd = "${workspaceFolder}",
                        console = "integratedTerminal",
                        internalConsoleOptions = "neverOpen",
                    },
                }
            end

            local dap_go = require("dap-go")
            dap_go.setup({})

            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            local colors = require("tokyonight.colors").setup()

            vim.api.nvim_set_hl(
                0,
                "DapBreakpoint",
                { ctermbg = 0, fg = colors.red1, bg = colors.bg }
            )
            vim.api.nvim_set_hl(
                0,
                "DapLogPoint",
                { ctermbg = 0, fg = colors.blue, bg = colors.bg }
            )
            vim.api.nvim_set_hl(
                0,
                "DapStopped",
                { ctermbg = 0, fg = colors.green, bg = colors.bg }
            )

            vim.fn.sign_define("DapBreakpoint", {
                text = "",
                texthl = "DapBreakpoint",
                linehl = "DapBreakpoint",
                numhl = "DapBreakpoint",
            })
            vim.fn.sign_define("DapBreakpointCondition", {
                text = "ﳁ",
                texthl = "DapBreakpoint",
                linehl = "DapBreakpoint",
                numhl = "DapBreakpoint",
            })
            vim.fn.sign_define("DapBreakpointRejected", {
                text = "",
                texthl = "DapBreakpoint",
                linehl = "DapBreakpoint",
                numhl = "DapBreakpoint",
            })
            vim.fn.sign_define("DapLogPoint", {
                text = "",
                texthl = "DapLogPoint",
                linehl = "DapLogPoint",
                numhl = "DapLogPoint",
            })
            vim.fn.sign_define("DapStopped", {
                text = "",
                texthl = "DapStopped",
                linehl = "DapStopped",
                numhl = "DapStopped",
            })

            vim.keymap.set(
                "n",
                "<leader>db",
                dap.toggle_breakpoint,
                { desc = "Toggle Breakpoint" }
            )
            vim.keymap.set(
                "n",
                "<leader>dB",
                dap.clear_breakpoints,
                { desc = "Clear Breakpoints" }
            )
            vim.keymap.set(
                "n",
                "<leader>dc",
                dap.continue,
                { desc = "Start/Continue" }
            )
            vim.keymap.set(
                "n",
                "<leader>di",
                dap.step_into,
                { desc = "Step Into" }
            )
            vim.keymap.set(
                "n",
                "<leader>do",
                dap.step_over,
                { desc = "Step Over" }
            )
            vim.keymap.set(
                "n",
                "<leader>dO",
                dap.step_out,
                { desc = "Step Out" }
            )
            vim.keymap.set(
                "n",
                "<leader>dq",
                dap.close,
                { desc = "Close Session" }
            )
            vim.keymap.set(
                "n",
                "<leader>dQ",
                dap.terminate,
                { desc = "Terminate Session" }
            )
            vim.keymap.set("n", "<leader>dp", dap.pause, { desc = "Pause" })
            vim.keymap.set(
                "n",
                "<leader>dr",
                dap.restart_frame,
                { desc = "Restart" }
            )
            vim.keymap.set(
                "n",
                "<leader>dR",
                dap.repl.toggle,
                { desc = "Toggle REPL" }
            )
            vim.keymap.set(
                "n",
                "<leader>du",
                dapui.toggle,
                { desc = "Toggle Debugger UI" }
            )
            vim.keymap.set(
                "n",
                "<leader>dh",
                require("dap.ui.widgets").hover,
                { desc = "Debugger Hover" }
            )
            vim.keymap.set(
                "n",
                "<leader>dt",
                dap_go.debug_test,
                { desc = "Go Debug Test" }
            )
        end,
    },

    {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
    },
}
