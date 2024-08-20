{
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true;
          # tsserver.enable = true;
          # html.enable = true;
          # cssls.enable = true;
        };
      };

      conform-nvim.enable = true;
      conform-nvim.formattersByFt = {
        nix = [ "nixfmt" ];
        javascript = [ "prettierd" ];
        rust = [ "rustfmt" ];
      };
    };

  };
}
