{
programs.nixvim = {
plugins.cmp.enable = true;
plugins.cmp.settings = {
  mapping = {
    __raw = ''
      cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
      })
    '';
  };
  snippet = {
    expand = "luasnip";
  };
  sources = [
  {name = "nvim_lsp";}
  {name = "luasnip";}
  {name = "path";}
  {name = "buffer";}

  ];
}
;
plugins.cmp.cmdline = {
  "/" = {
    mapping = {
      __raw = "cmp.mapping.preset.cmdline()";
    };
    sources = [
      {
        name = "buffer";
      }
    ];
  };
  ":" = {
    mapping = {
      __raw = "cmp.mapping.preset.cmdline()";
    };
    sources = [
      {
        name = "path";
      }
      {
        name = "cmdline";
        option = {
          ignore_cmds = [
            "Man"
            "!"
          ];
        };
      }
    ];
  };
}
;
plugins.cmp.autoEnableSources = true;

};
}
