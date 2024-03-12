{ config, pkgs, inputs, ... }:

{

  imports = [
    #  ../../modules/home-manager/zsh.nix
    ../../modules/home-manager/fish.nix
    #    ../../modules/home-manager/nushell.nix
    ../../modules/home-manager/hyprland/default.nix
    ../../modules/home-manager/themes/qt.nix
    ../../modules/home-manager/themes/gtk.nix
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
    vial
    xfce.tumbler
    libappindicator
    yarn
    abaddon
    babelfish
    kdePackages.polkit-kde-agent-1
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
    alacritty
    alacritty-theme
    foot
    dunst
    bemenu
    hyprpaper
    hyprpicker
    protonup-qt
  ];

  xdg.portal.enable = true;
  xdg.portal.xdgOpenUsePortal = true;

  home.file = { };
  home.sessionVariables = {
    EDITOR = "nvim";
    #    NIX_OZONE_WL = "1";
  };

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.extraConfig = {
    XDG_STUDY_DIR = "${config.home.homeDirectory}/Study";
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
      firefox.enable = true;
      firefox.profiles.default.name = "main";
      firefox.profiles.default.extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin bitwarden fastforwardteam ];
    };
}
