{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # Statistics & Diagnostics
    mission-center
    (pkgs.btop.override { cudaSupport = true; })
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
