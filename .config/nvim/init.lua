vim.g.mapleader = " "
-- leader that is local to a buffer. I am not going to use this.
-- So setting it to be the same as global leader
vim.g.maplocalleader = " "

-- For pretty icons and glyphs
vim.g.have_nerd_font = true

-- Enable line numbers
vim.opt.number = true

-- Disable the mouse. Duh
vim.opt.mouse = ""

-- Status line already shows the mode. So vim doesn't have to show it again
vim.o.showmode = false

-- enable undofile
vim.opt.undofile = true

-- Case insensitive search unless \C or uppercase explicitly used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Add signcolumn to the left which is used to show errors
vim.opt.signcolumn = "yes"

-- Show the 80 char limit column
vim.opt.colorcolumn = "80"

vim.opt.showmatch = true

-- Time to wait before writing to disk. Default of 4s is way too long.
-- In case of a crash you may lose data if it is that long.
vim.opt.updatetime = 250

-- Mapped sequence time to complete. Default of 1s is too long.
-- Just type fast or have small sequences(Don't be like emacs)
vim.opt.timeoutlen = 300

-- vsplit opens window to the right
vim.opt.splitright = true
-- hsplit opens window below
vim.opt.splitbelow = true

-- Substituition live preview
vim.o.inccommand = "nosplit"

-- Highlight the line that you are currently on
vim.o.cursorline = false

-- Always keep 5 lines above/below the cursor. This makes it so that
-- scrolling starts 5 lines before the end. Cursor is always near the center
-- of the screen
vim.o.scrolloff = 5

-- Ask for confirmation before executing commands that may fail due to unsaved buffer
vim.o.confirm = true

vim.o.termguicolors = true

vim.o.wrap = false

vim.o.incsearch = true
vim.o.hlsearch = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv("HOME") .. "/.local/share/nvim/undodir"
vim.o.undofile = true

-- Clear the highlighted results of the previous search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Use "J" to move the below line up without moving the cursor
vim.keymap.set("n", "J", "mzJ`z")

-- Key cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- By default if you select a text in visual mode and replace it by pasting
-- something, your cut buffer is now filled with the replaced text.
-- This keymap retains the contents of the cut buffer and discards the replaced
-- text
vim.keymap.set("x", "<leader>p", '"_dP')
-- Delete without altering the cut buffer
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')

-- Yank into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Highlight the text that was yanked
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("dbk-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

require("config.lazy")
