{ config, pkgs, inputs, ... }:

{

  imports = [
    ./modules/home-manager/zsh.nix
    #    ./modules/home-manager/fish.nix
    ./modules/home-manager/hyprland.nix
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
    zettlr
    hyprlock
    jujutsu_git
    vscode-fhs
    gsettings-desktop-schemas
    gtk-engine-murrine
    gnome.gnome-themes-extra
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
  xdg.portal.configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk pkgs.xdg-desktop-portal-hyprland ];

  home.file = { };
  home.sessionVariables = {
    EDITOR = "nvim";
    NIX_OZONE_WL = "1";
  };

  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;
  xdg.userDirs.extraConfig = {
    XDG_STUDY_DIR = "${config.home.homeDirectory}/Study";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Colloid-Dark";
      package = pkgs.colloid-gtk-theme;
    };

    iconTheme = {
      name = "Tela";
      package = pkgs.tela-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme = "qtct";
    style.package = pkgs.materia-kde-theme;
  };


  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.google-cursor;
    name = "GoogleDot-Blue";
    size = 24;
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.home-manager.enable = true;

  programs =
    {
      yazi.enable = true;
      yazi.enableZshIntegration = true;

      firefox.enable = true;
      firefox.profiles.default.name = "main";
      firefox.profiles.default.extensions = with pkgs.nur.repos.rycee.firefox-addons; [ ublock-origin bitwarden fastforwardteam ];
    };
}
