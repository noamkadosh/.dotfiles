return {
	{
		"mfussenegger/nvim-dap",
		lazy = true,
		dependencies = {
			{ "rcarriga/nvim-dap-ui" },
			{ "theHamsta/nvim-dap-virtual-text" },
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			require("nvim-dap-virtual-text").setup({})

			vim.keymap.set("n", "<F5>", function()
				dap.continue()
			end, { desc = "Debugger: Start" })
			vim.keymap.set("n", "<F17>", function()
				dap.terminate()
			end, { desc = "Debugger: Stop" }) -- Shift+F5
			vim.keymap.set("n", "<F29>", function()
				dap.restart_frame()
			end, { desc = "Debugger: Restart" }) -- Control+F5
			vim.keymap.set("n", "<F6>", function()
				dap.pause()
			end, { desc = "Debugger: Pause" })
			vim.keymap.set("n", "<F9>", function()
				dap.toggle_breakpoint()
			end, { desc = "Debugger: Toggle Breakpoint" })
			vim.keymap.set("n", "<F10>", function()
				dap.step_over()
			end, { desc = "Debugger: Step Over" })
			vim.keymap.set("n", "<F11>", function()
				dap.step_into()
			end, { desc = "Debugger: Step Into" })
			vim.keymap.set("n", "<F23>", function()
				dap.step_out()
			end, { desc = "Debugger: Step Out" }) -- Shift+F11
			vim.keymap.set("n", "<leader>Db", function()
				dap.toggle_breakpoint()
			end, { desc = "Toggle Breakpoint (F9)" })
			vim.keymap.set("n", "<leader>DB", function()
				dap.clear_breakpoints()
			end, { desc = "Clear Breakpoints" })
			vim.keymap.set("n", "<leader>Dc", function()
				dap.continue()
			end, { desc = "Start/Continue (F5)" })
			vim.keymap.set("n", "<leader>Di", function()
				dap.step_into()
			end, { desc = "Step Into (F11)" })
			vim.keymap.set("n", "<leader>Do", function()
				dap.step_over()
			end, { desc = "Step Over (F10)" })
			vim.keymap.set("n", "<leader>DO", function()
				dap.step_out()
			end, { desc = "Step Out (S-F11)" })
			vim.keymap.set("n", "<leader>Dq", function()
				dap.close()
			end, { desc = "Close Session" })
			vim.keymap.set("n", "<leader>DQ", function()
				dap.terminate()
			end, { desc = "Terminate Session (S-F5)" })
			vim.keymap.set("n", "<leader>Dp", function()
				dap.pause()
			end, { desc = "Pause (F6)" })
			vim.keymap.set("n", "<leader>Dr", function()
				dap.restart_frame()
			end, { desc = "Restart (C-F5)" })
			vim.keymap.set("n", "<leader>DR", function()
				dap.repl.toggle()
			end, { desc = "Toggle REPL" })
			vim.keymap.set("n", "<leader>Du", function()
				dapui.toggle()
			end, { desc = "Toggle Debugger UI" })
			vim.keymap.set("n", "<leader>Dh", function()
				dap.ui.widgets.hover()
			end, { desc = "Debugger Hover" })
		end,
	},
}
