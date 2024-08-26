{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # VCS
    pijul
    gitoxide
    gitu
    gh

    # Toolchains, Languages
    rustup
    bun
    python3
    cmucl_binary

    # LSP, Formatters, Linters
    hyprls
    markdown-oxide
    taplo
    nixd
    nixfmt-rfc-style
    nil
    lua-language-server
    nodePackages_latest.typescript-language-server
    biome
    svelte-language-server
    prettierd
    languagetool
    ltex-ls
    pyright
    vscode-langservers-extracted
  ];
}
