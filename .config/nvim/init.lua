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
-- vim.o.showmode = false

-- enable undofile
vim.opt.undofile = true

-- Case insensitive search unless \C or uppercase explicitly used
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Add signcolumn to the left which is used to show errors
vim.opt.signcolumn = "yes"

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

-- Clear the highlighted results of the previous search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Highlight the text that was yanked
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("dbk-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
require("config.lazy")
