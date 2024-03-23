{ config, pkgs, lib, inputs, ... }:

{

  imports = [
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/hyprland
    ../../modules/home-manager/themes/gtk.nix
    ../../modules/home-manager/themes/qt.nix
    inputs.ags.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.username = "jake";
  home.homeDirectory = "/home/jake";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    wl-clipboard
    wl-clipboard-x11
    yadm
    pandoc
    cmark-gfm
    ghostwriter
    wget
    ueberzugpp
    davinci-resolve
    inputs.nixvim.packages.${system}.default
    neovide
    fuzzel
    okular
    xdg-utils
    vesktop
    sway_git
    dmenu
    wofi
    niri
    wezterm
    vial
    xfce.tumbler
    libappindicator
    yarn
    wezterm
    abaddon
    babelfish
    lxqt.lxqt-policykit
    gnome.gnome-keyring
    pijul
    gitoxide
    patool
    kdePackages.qtstyleplugin-kvantum
    libsForQt5.qtstyleplugin-kvantum
    rnote
    tenacity
    obsidian
    obs-studio
    zettlr
    hyprlock
    vscode-fhs
    gsettings-desktop-schemas
    xorg.xeyes
    manuskript
    qalculate-gtk
    swaybg
    flameshot
    gh
    imv
    wev
    grim
    slurp
    satty
    fd
    ripgrep
    outils
    deluge-gtk
    fzf
    libsForQt5.qt5ct
    qt6Packages.qt6ct
    qt6.qtwayland
    libsForQt5.qt5.qtwayland
    nwg-look
    mission-center
    btop
    lxqt.pavucontrol-qt
    fastfetch
    zoxide
    alacritty_git
    foot
    dunst
    bemenu
    hyprpaper
    hyprpicker
    protonup-qt
  ];


  home.file = { };
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  xdg = {
    userDirs.enable = true;
    userDirs.createDirectories = true;
    userDirs.extraConfig = {
      XDG_STUDY_DIR = "${config.home.homeDirectory}/Study";
    };
  };



  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.home-manager.enable = true;

  services = {
    gnome-keyring.enable = true;
  };

  programs =
    {
      ags.enable = true;
      ags.configDir = null;
      ags.extraPackages = with pkgs; [
        gtksourceview
        webkitgtk
        accountsservice
      ];
    };
}
