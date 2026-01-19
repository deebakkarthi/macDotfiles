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
				opts = {
					ui = {
						border = "single"
					}
				},
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
			{ "j-hui/fidget.nvim", opts = {} },
		},
		config = function()
			-- Register nvim-cmp lsp capabilities
			vim.lsp.config("*", { capabilities = require("cmp_nvim_lsp").default_capabilities() })

			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf })
					vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf })
					vim.keymap.set("n", "K", function()
						vim.lsp.buf.hover({ border = "single" })
					end, { buffer = event.buf })
					vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
					vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf })
					vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = event.buf })
					vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { buffer = event.buf })
				end,
			})
			vim.diagnostic.config({
				underline = false,
				severity_sort = true,
				float = { border = "single", source = "if_many" },
			})
		end,
	},
}
