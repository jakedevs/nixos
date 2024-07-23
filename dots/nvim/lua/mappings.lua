local wk = require("which-key")
wk.add({
  { "<leader>b", group = "buffer operations" },
  { "<leader>c", group = "code operations" },
  { "<leader>f", group = "file operations" },
  { "<leader>y", group = "clipboard operations" },

}, { prefix = "<leader>" })

function Format() require("conform").format({ async = true, lsp_fallback = true }) end

------------------------------------------------------
vim.keymap.set("n", "<leader>bk", ":q!<cr>", { desc = "kill buffer" })
vim.keymap.set("n", "<leader>bn", ":tabnew<cr>", { desc = "new buffer" })
-- vim.keymap.set("n", "<leader>bh", ":tabprevious<cr>", { desc = "previous buffer" })
--vim.keymap.set("n", "<leader>bl", ":tabnext<cr>", { desc = "next buffer" })
vim.keymap.set("n", "<leader>bo", ":only<cr>", { desc = "next buffer" })

-- Clipboard operations
vim.keymap.set({ "n", "v" }, "<leader>yy", "<cmd> y+<cr>", { desc = "copy line" })
vim.keymap.set({ "n", "v" }, "<leader>yf", "<cmd> %y+<cr>", { desc = "copy file" })

-- LSP
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "show docs" })
vim.keymap.set("n", "<leader>cf", Format, { desc = "format code" })
vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "code actions" })

vim.keymap.set("n", "<leader>mg", ":Neogit kind=auto<cr>", { desc = "open neogit" })

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = "find files" })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = "live grep" })
vim.keymap.set('n', '<leader>bl', builtin.buffers, { desc = "list buffers" })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = "search docs" })
