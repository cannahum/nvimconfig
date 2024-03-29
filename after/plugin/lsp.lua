local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
    vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

require('mason').setup({})
require('mason-tool-installer').setup({
    ensure_installed = { 'eslint_d', 'prettierd' }
})
require('mason-lspconfig').setup({
    ensure_installed = { 'tsserver', 'rust_analyzer', 'cssls', 'dockerls', 'golangci_lint_ls', 'gopls', 'graphql', 'html', 'htmx', 'jsonls', 'jqls', 'kotlin_language_server', 'lua_ls', 'marksman', 'spectral', 'jedi_language_server', 'sqlls', 'svelte', 'tailwindcss', 'templ', 'yamlls' },
    handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
        end,
        templ = function()
            require('lspconfig').templ.setup({})
        end,
        html = function()
            require('lspconfig').html.setup({
                filetypes = { "html", "templ" },
            })
        end,
        htmx = function()
            require('lspconfig').html.setup({
                filetypes = { "html", "templ" },
            })
        end,
        tailwindcss = function()
            require('lspconfig').tailwindcss.setup({
                filetypes = { "html", "templ" },
                init_options = {
                    userLanguages = {
                        templ = "html"
                    }
                }
            })
        end,
        gopls = function()
            require('lspconfig').gopls.setup({
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                        },
                        staticcheck = true,
                        gofumpt = true,
                        completeUnimported = true,
                        usePlaceholders = true,
                    },
                    dap_debug = true,
                    dap_debug_gui = true
                },
            })
        end,
        tsserver = function()
            local on_attach = function(client, bufnr)
                if client.server_capabilities.documentFormattingProvider then
                    vim.api.nvim_create_autocmd("BufWritePre", {
                        group = vim.api.nvim_create_augroup("Format", { clear = true }),
                        buffer = bufnr,
                        callback = function() vim.lsp.buf.format() end
                    })
                end
            end
            require('lspconfig').tsserver.setup({
                on_attach = on_attach,
                filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "typescript.tsx", "jsx" },
                cmd = { "typescript-language-server", "--stdio" }
            })
        end
    }
})

local cmp = require('cmp')
local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
    sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'nvim_lua' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
    },
    formatting = lsp_zero.cmp_format(),
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<C-Space>'] = cmp.mapping.complete(),
    }),
})

vim.filetype.add({ extension = { templ = "templ" } })
