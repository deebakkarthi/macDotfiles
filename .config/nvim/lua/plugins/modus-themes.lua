return {
	{
		"miikanissi/modus-themes.nvim",
		lazy = false,

		-- This makes the color scheme to load first
		priority = 1000,
		config = function()
			require("modus-themes").setup({
				-- I don't like the nr_column or the sign_column to have
				-- a different color
				line_nr_column_background = false,
				sign_column_background = false,
				styles = {
					comments = { italic = true },
				},
			})
			vim.cmd([[colorscheme modus_vivendi]])
		end,
	},
}
