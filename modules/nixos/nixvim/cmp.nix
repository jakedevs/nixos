{
	programs.nixvim = {
  plugins = {
    cmp.enable = true;
		cmp-nvim-lsp.enable = true;
		cmp_luasnip.enable = true;
    luasnip.enable = true;
    cmp.settings = {
      mapping = {
        __raw = ''
          cmp.mapping.preset.insert({
	  ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          })
        '';
      };
      snippet = {
        expand = ''function(args)
    require('luasnip').lsp_expand(args.body)
  end'';
      };
      sources = [
        { name = "nvim_lsp"; }
        { name = "luasnip"; }
        { name = "path"; }
        { name = "buffer"; }

      ];
      window.completion.winhighlight = "CursorLine:PmenuSel";
      window.documentation.winhighlight = "CursorLine:PmenuSel";

    };
    cmp.cmdline = {
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
    };
    cmp.autoEnableSources = true;
  };
};
}
