{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Desktop
    wl-clipboard
    wl-clipboard-x11
    yadm
    libnotify
    libappindicator
    lxqt.pavucontrol-qt
    grim
    slurp
    satty
    imv
    swaybg
    flameshot
    rofi-wayland
    telegram-desktop
    anki-bin
    mpv

    # Miscellaneous
    pandoc
    wget
    ueberzugpp
    xdg-utils
    xfce.tumbler
    babelfish
    lxqt.lxqt-policykit
    gnome.gnome-keyring
    wev

    # Statistics & Diagnostics
    mission-center
    btop
    xorg.xeyes
    fastfetch
    tokei
    qdirstat

    # Programming
    nixfmt-rfc-style
    bun
    prettierd
    pijul
    gitoxide
    vscode-fhs
    gh

    # File Management
    fd
    ripgrep
    fzf
    zoxide
    atool

    # Eyecandy
    cmatrix

  ];
}
