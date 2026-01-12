return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { { "nvim-mini/mini.icons", opts = {} } },
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
		config=function()
			require("oil").setup({
				columns = {
					"permissions",
					"size",
					"mtime",
					"icon"
				},
				view_options = {
					show_hidden =true
				},
				constrain_cursor = "name",
			})
			vim.keymap.set("n", "-", "<cmd>Oil<CR>")
		end
	}
}
