{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{

  imports = [
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/hyprland

    # Theming
    ../../modules/home-manager/themes/gtk.nix
    ../../modules/home-manager/themes/qt.nix

    # Packages
    ../../modules/home-manager/packages/util.nix
    ../../modules/home-manager/pass.nix

    # Applications
		../../modules/home-manager/browsers/firefox.nix
		../../modules/home-manager/browsers/librewolf.nix

    inputs.ags.homeManagerModules.default
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.username = "jake";
  home.homeDirectory = "/home/jake";

  home.stateVersion = "23.11";

  # home.file = {
  #   "alacritty".source = ./alacritty;
  # "alacritty".target = "/home/jake/.config/alacritty";
  # };

  home.packages = with pkgs; [
    # davinci-resolve
    # tenacity
    dolphin
    manuskript
    obsidian
    okular
    obs-studio
    deluge-gtk
		prismlauncher

    inputs.nixvim.packages.${system}.default
    neovide

    qalculate-gtk
    vial

    vesktop
    alacritty_git
    foot
    heroic
  ];

  home.file = { };
  home.sessionVariables = { };

  xdg = {
    userDirs.enable = true;
    userDirs.createDirectories = true;
    userDirs.extraConfig = {
      XDG_STUDY_DIR = "${config.home.homeDirectory}/Study";
      XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
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

  programs = {
    git.enable = true;
    git.userEmail = "main@jakedevs.net";
    git.userName = "jakedevs";
    git.extraConfig = {
      init.defaultBranch = "main";
    };

    ags.enable = true;
    ags.configDir = null;
    ags.extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };
}
