vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Use "J" to move the below line up without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")
-- Key cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Delete but don't put the deleted turn in the cut buffer
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)
