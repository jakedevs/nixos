{ pkgs, ... }: {
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

    # Theming
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum

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

    # Programming
    nixfmt
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
  ];

}
