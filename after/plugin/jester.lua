vim.keymap.set("n", "<leader>tf",
    "<cmd>lua require('jester').run_file()<CR>")


vim.keymap.set("n", "<leader>tu",
    "<cmd>lua require('jester').run({ cmd = \"jest -u -t '$result' -- $file\" })<CR>")
