{
  config,
  pkgs,
  # lib,
  inputs,
  ...
}:

{

  imports = [ ../../modules/home-manager/modules.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Custom configs
  hyprConfig.enable = true;
  fishConfig.enable = true;
	firefoxConfig.enable = true;

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
    krita

    inputs.nixvim.packages.${system}.default
    neovide

    qalculate-gtk
    vial
    via

    vesktop
    alacritty_git
    foot
  ];

  home.file = { };
  home.sessionVariables = {
    ANKI_WAYLAND = "1";
  };

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
  };
}
