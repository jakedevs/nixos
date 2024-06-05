{ config, pkgs, ... }:
{
  imports = [ ../../modules/home-manager/modules.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  # Custom configs
  hyprConfig.enable = true;
  fishConfig.enable = true;
  zshConfig.enable = false;
  firefoxConfig.enable = true;
  qtConfig.enable = true;
  gtkConfig.enable = true;

  home = {
    username = "jake";
    homeDirectory = "/home/jake";
    stateVersion = "24.05";
  };

  home.file = {
    "waybar".source = ../../dots/waybar;
  "waybar".target = "/home/jake/.config/waybar";
  };

  home.packages = with pkgs; [
    # davinci-resolve
    # tenacity
    dolphin
    manuskript
    obsidian
    obs-studio
    deluge-gtk
    krita
    hakuneko
    okular
    foliate
    mdbook

    neovide

    qalculate-gtk

    vesktop
    alacritty_git
    foot
  ];

  home.file = { };
  home.sessionVariables = {
    ANKI_WAYLAND = "1";
    EDITOR = "hx";
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_STUDY_DIR = "${config.home.homeDirectory}/Study";
      XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      XDG_SERVERS_DIR = "${config.home.homeDirectory}/Servers";
      XDG_NOTES_DIR = "${config.home.homeDirectory}/Notes";
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
    git = {
      enable = true;
      userEmail = "main@jakedevs.net";
      userName = "jakedevs";
    };
    git.extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
