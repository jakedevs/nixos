require('nvim-treesitter.install').compilers = { 'clang++' }
require("nvim-treesitter.configs").setup({
  highlight = {
    enable = true,
  },
})

vim.filetype.add({
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})
