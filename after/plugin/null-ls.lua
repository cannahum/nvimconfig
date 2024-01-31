local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

null_ls.setup({
  sources = {
    null_ls.builtins.diagnostics.eslint.with({
      diagnostics_format = "[eslint] #{m} (#{c})"
    }),
    null_ls.builtins.diagnostics.fish,
    null_ls.builtins.formatting.prettierd.with({
      filetypes = {
        "css",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "json",
        "scss",
        "less",
        "tsx"
      }
    }),
  },
  attach = function(client, bufnr)
    vim.api.nvim_command("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)")
  end,
  autostart = true, -- Set autostart to true
})

