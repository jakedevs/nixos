require('mini.files').setup()
vim.keymap.set("n", "<leader>fm", MiniFiles.open, { desc = "file manager" })
