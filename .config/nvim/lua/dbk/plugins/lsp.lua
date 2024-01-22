--local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
--
--local lsp_formatting = function(bufnr)
--    vim.lsp.buf.format({
--        filter = function(client)
--            -- apply whatever logic you want (in this example, we'll only use null-ls)
--            return client.name == "null-ls"
--        end,
--        bufnr = bufnr,
--    })
--end
--local lsp_attach = function(client, bufnr)
--    local opts = { buffer = bufnr, remap = false }
--    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
--    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
--    --vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
--    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
--    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
--    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
--    vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, opts)
--    vim.keymap.set("n", "f", vim.lsp.buf.format, opts)
--    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
--    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
--
--    if client.supports_method("textDocument/formatting") then
--        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--        vim.api.nvim_create_autocmd("BufWritePre", {
--            group = augroup,
--            buffer = bufnr,
--            callback = function()
--                lsp_formatting(bufnr)
--            end,
--        })
--    end
--end


return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },
    config = function()
        require("fidget").setup({
            notification = {
                window = {
                    winblend = 0, -- Transparency
                }
            }
        })
        require("mason").setup()
        require("mason-lspconfig").setup()
        local cmp = require "cmp"
        cmp.setup({
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
                ["<C-d>"] = cmp.mapping.scroll_docs(-4),
                ["<C-u>"] = cmp.mapping.scroll_docs(4),
                ["<CR>"] = cmp.mapping.confirm {
                    behavior = cmp.ConfirmBehavior.Insert,
                    select = true },
                ["<C-e>"] = cmp.mapping.abort(),
                ["<tab>"] = cmp.config.disable,
            }),
            sources = cmp.config.sources({
                { name = "luasnip" }, -- For luasnip users.
                { name = "nvim_lua" },
                { name = "nvim_lsp" },
            }, {
                { name = "path" },
                { name = "buffer", keyword_length = 3 },
            }),
            experimental = {
                ghost_text = true,
            },
            window = {
                completion = {
                    winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
                    col_offset = -3,
                    side_padding = 0,
                },
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                fields = { "kind", "abbr", "menu" },
                format = function(entry, vim_item)
                    local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 25 })(entry, vim_item)
                    local strings = vim.split(kind.kind, "%s", { trimempty = true })
                    kind.kind = " " .. (strings[1] or "") .. " "
                    kind.menu = "    (" .. (strings[2] or "") .. ")"
                    return kind
                end,
            },
        })
        local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

        -- Automatically setup lsp servers
        local lspconfig = require('lspconfig')

        require("mason-lspconfig").setup_handlers({
            function(server_name)
                lspconfig[server_name].setup({
                    --on_attach = lsp_attach,
                    capabilities = lsp_capabilities,
                })
            end,

            ["lua_ls"] = function()
                lspconfig.lua_ls.setup({
                    settings = {
                        Lua = {
                            diagnostics = {
                                globals = {
                                    "vim",
                                }
                            }
                        }
                    },
                    workspace = {
                        -- Make the server aware of Neovim runtime files
                        library = vim.api.nvim_get_runtime_file("", true),
                    },
                })
            end
        })
    end
}


--require("mason-null-ls").setup({
--    ensure_installed = { "black" }
--})
--
--local null_ls = require("null-ls")
--
--null_ls.setup({
--    sources = {
--        null_ls.builtins.formatting.black,
--        null_ls.builtins.formatting.sql_formatter,
--        null_ls.builtins.formatting.prettierd,
--    },
--})
