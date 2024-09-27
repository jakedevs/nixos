{
  config,
  pkgs,
  username,
  inputs,
  ...
}:
let
  link = config.lib.file.mkOutOfStoreSymlink;
in
{
  imports = [ ../../modules/home-manager/modules.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  fishConfig.enable = true;
  zshConfig.enable = false;
  firefoxConfig.enable = true;
  qtConfig.enable = false;
  gtkConfig.enable = false;
  emacsConfig.enable = false;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  home.file = {
    ".config/waybar".source = link "/home/${username}/.config/nixos/dots/waybar";
    ".config/dunst".source = link "/home/${username}/.config/nixos/dots/dunst";
    ".config/alacritty".source = link "/home/${username}/.config/nixos/dots/alacritty";
    ".config/foot".source = link "/home/${username}/.config/nixos/dots/foot";
    ".config/rofi".source = link "/home/${username}/.config/nixos/dots/rofi";
    ".config/helix".source = link "/home/${username}/.config/nixos/dots/helix";
    ".icons/GoogleDot-Blue-Hyprcursor".source = link "/home/${username}/.config/nixos/dots/GoogleDot-Blue-Hyprcursor";
  };

  home.packages = with pkgs; [
    nb
    w3m
    deluge-gtk
    steam-run
    godot_4
    vesktop
    peaclock
    wrangler
    obsidian
    marksman
    # Desktop
    gitui

    # Terminals
    alacritty_git
    foot

    # Comms
    telegram-desktop

    # Self Study
    anki-bin
    haruna
    mpv
    lame

    qalculate-gtk
  ];

  home.file = { };
  home.sessionVariables = {
    ANKI_WAYLAND = "1";
  };

  xdg.desktopEntries = {
    obsidian = {
      name = "Obsidian";
      genericName = "Personal Knowledge Management";
      terminal = false;
      categories = [ "Application" ];
      exec = "obsidian --enable-wayland-ime %u";
    };

    godot = {
      name = "Godot Engine 4";
      genericName = "Game Engine";
      terminal = false;
      categories = [ "Application" ];
      exec = "godot4 --display-driver wayland %u";
    };

  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "thunar.desktop" ];
    };
    associations.removed = {
      "inode/directory" = "yazi.desktop";
    };
  };

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    extraConfig = {
      XDG_STUDY_DIR = "${config.home.homeDirectory}/Study";
      XDG_PROJECTS_DIR = "${config.home.homeDirectory}/Projects";
      XDG_SERVERS_DIR = "${config.home.homeDirectory}/Servers";
      XDG_ART_DIR = "${config.home.homeDirectory}/Art";
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  programs.home-manager.enable = true;

  programs = {
    git = {
      lfs.enable = true;
      enable = true;
      userEmail = "main@jakedevs.net";
      userName = "jakedevs";
    };
    git.extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
