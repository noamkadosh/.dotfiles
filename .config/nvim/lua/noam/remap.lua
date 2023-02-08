vim.g.mapleader = " ";

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set({ "n", "v" }, "<leader>P", [["_dP]])

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("n", "Q", "<nop>")

-- zellij doesn't support a similar command at tho moment
-- vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

local keymap_docs = {}
keymap_docs.normal_mode = {
    ["J"] = "Paste at the end of line, cursor stays in place",
    ["<C-d>"] = "Scroll half page down",
    ["<C-u>"] = "Scroll half page up",
    ["n"] = "Next search term",
    ["N"] = "Previous search term",
    ["<leader>P"] = "Paste, keep buffer",
    ["<leader>y"] = "Yank to system clipboard",
    ["<leader>Y"] = "Yank line to system clipboard",
    ["<leader>d"] = "Delete, keep buffer",
    ["<leader>f"] = "Format",
    ["<C-k>"] = "Next error in quickfix",
    ["<C-j>"] = "Previous error in quickfix",
    ["<leader>k"] = "Next error in the current file",
    ["<leader>j"] = "Previous error in the current file",
    ["<leader>s"] = "Replace all instances of word under cursor",
    ["<leader>x"] = "Make executable",
}
keymap_docs.visual_mode = {
    ["J"] = "Move highlighted line down",
    ["K"] = "Move highlighted line up",
    ["<leader>P"] = "Paste, keep buffer",
    ["<leader>y"] = "Yank to system clipboard",
    ["<leader>d"] = "Delete, keep buffer",
}

return keymap_docs
