-- CMP Config
local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args) require("luasnip").lsp_expand(args.body) end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping.confirm({ select = true }),
  }),

  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
    { name = "path" },
    { name = "nvim_lsp" },
  }, {
    { name = "buffer" },
  }),
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})
local capabilities = require("cmp_nvim_lsp").default_capabilities()
require("lspconfig").cssls.setup({
  capabilities = capabilities,
})
require("lspconfig").html.setup({
  capabilities = capabilities,
})

-- LSP Config
local lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.tsserver.setup({})
lspconfig.biome.setup({})
lspconfig.typst_lsp.setup({})
lspconfig.nixd.setup({})
lspconfig.markdown_oxide.setup({})

--  -- Formatter config

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    javascript = { "biome" },
    css = { { "prettierd", "prettier" } },
    html = { { "prettierd", "prettier" } },
    nix = { "nixfmt" },
  },
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_format = "fallback", range = range })
end, { range = true })
