return {
	"hrsh7th/nvim-cmp",
	lazy = false,
	priority = 1000,
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lua",
		{ "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
		"saadparwaiz1/cmp_luasnip",
		-- Format the completion buffer
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		cmp.setup({
			view = {
				entries = {
					name = "custom",
					-- The top selection is always near
					-- the cursor. This is useful when near
					-- the bottom of the screen.
					selection_order = "near_cursor",
				},
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body)
				end,
			},
			window = {
				completion = cmp.config.window.bordered({
					border = "single",
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None,CursorLine:Visual",
					col_offset = -3,
					side_padding = 0,
				}),
				documentation = cmp.config.window.bordered({
					border = "rounded",
				}),
			},
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item({
					behavior = cmp.SelectBehavior.Insert,
				}),
				["<C-p>"] = cmp.mapping.select_prev_item({
					behavior = cmp.SelectBehavior.Insert,
				}),
				["<CR>"] = cmp.mapping.confirm({
					behavior = cmp.ConfirmBehavior.Insert,
					select = true,
				}),
				["<tab>"] = cmp.config.disable,
			}),
			sources = cmp.config.sources({
				{ name = "lazydev" },
				{ name = "nvim_lua" },
				{ name = "nvim_lsp" },
				{ name = "luasnip" },
			}, {
				{ name = "path" },
				{ name = "buffer" },
			}),
			formatting = {
				fields = { "icon", "abbr", "kind", "menu" },
				format = function(entry, vim_item)
					local tmp = lspkind.cmp_format({
						preset = "default",
						menu = {
							lazydev = "LAZYDEV",
							nvim_lua = "LUA",
							nvim_lsp = "LSP",
							luasnip = "LUASNIP",
							buffer = "BUFFER",
							path = "PATH",
						},
					})(entry, vim_item)
					tmp.kind = " (" .. tmp.kind .. ") "
					tmp.menu = " [" .. tmp.menu .. "] "
					return tmp
				end,
			},
		})
	end,
}
