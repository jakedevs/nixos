{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Statistics & Diagnostics
    mission-center
    btop
    xorg.xeyes
    fastfetch
    tokei
    qdirstat

    # File Operations
    fd
    ripgrep
    fzf
    zoxide
    atool
  ];
}
