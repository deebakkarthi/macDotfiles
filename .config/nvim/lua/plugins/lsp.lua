return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- See the configuration section for more details
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},
			{
				"mason-org/mason.nvim",
				opts = {},
			},
			{
				"mason-org/mason-lspconfig.nvim",
				opts = {},
				dependencies = {
					{ "mason-org/mason.nvim", opts = {} },
					"neovim/nvim-lspconfig",
				},
			},
			{
				"WhoIsSethDaniel/mason-tool-installer.nvim",
				config = function()
					require("mason-tool-installer").setup({
						ensure_installed = { "lua_ls", "stylua" },
					})
				end,
			},
		},
	},
}
