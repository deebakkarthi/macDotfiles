return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Install everything. auto_install from the master branch is now deprecated.
		require("nvim-treesitter").install({ "all" })
		-- Manually enable treesitter highlighting
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "<filetype>" },
			callback = function()
				vim.treesitter.start()
			end,
		})
		-- Manually enable treesitter indentation
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
}
