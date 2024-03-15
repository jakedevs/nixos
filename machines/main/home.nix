{ config, pkgs, inputs, ... }:

{

  imports = [
    ../../modules/home-manager/firefox.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/hyprland/default.nix
    inputs.ags.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.username = "jake";
  home.homeDirectory = "/home/jake";

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    #davinci-resolve
    wl-clipboard
    wl-clipboard-x11
    yadm
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
    jujutsu_git
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
    waybar
    outils
    deluge-gtk
    fzf
    google-cursor
    libsForQt5.qt5ct
    qt6Packages.qt6ct
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
