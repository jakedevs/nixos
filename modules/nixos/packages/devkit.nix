{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # VCS
    pijul
    gitoxide
    gitu

    # Toolchains, Languages
    rustup
    bun
    python3
    cmucl_binary
    godot_4

    # LSP, Formatters, Linters
    markdown-oxide
    nixd
    nixfmt-rfc-style
    nil
    lua-language-server
    nodePackages_latest.typescript-language-server
    prettierd
    languagetool
    ltex-ls
  ];
}
