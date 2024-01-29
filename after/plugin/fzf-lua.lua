vim.keymap.set("n", "<leader>pf",
    "<cmd>lua require('fzf-lua').files()<CR>", { silent = true })
vim.keymap.set("n", "<leader>pF",
    "<cmd>lua require('fzf-lua').files({ resume = true })<CR>", { silent = true })
vim.keymap.set("n", "<leader>ps",
    "<cmd>lua require('fzf-lua').live_grep()<CR>")
vim.keymap.set("n", "<leader>pS",
    "<cmd>lua require('fzf-lua').live_grep({ resume = true })<CR>")

