return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	keys = {
		{
			-- Customize or remove this keymap to your liking
			"<leader>f",
			function()
				require("conform").format({ async = true, lsp_fallback = true })
			end,
			mode = "",
			desc = "Format buffer",
		},
	},
	-- Everything in opts will be passed to setup()
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "black" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			javascriptreact = { "prettierd" },
			yaml = { "prettierd" },
			c = { "clang_format" },
			cpp = { "clang_format" },
			css = { "prettierd" },
			scss = { "prettierd" },
			tex = { "tex-fmt" },
		},
		formatters = {
			clang_format = {
				-- Disabling this temporarily
				-- There is no way to specify a default style
				-- for clang-format. --fallback-style=<STYLE>
				-- only allows for presets and not custom
				-- files.
				-- prepend_args = {
				-- 	"--fallback-style=file:/Users/deebakkarthi/.local/share/nvim/clang-format",
				-- },
			},
			black = {
				prepend_args = {
					"--line-length=79",
				},
			},
		},
	},
	init = function()
		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
