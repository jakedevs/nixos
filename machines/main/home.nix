{
  config,
  pkgs,
  username,
  inputs,
  ...
}:
let
  link = config.lib.file.mkOutOfStoreSymlink;
  dots = /home/jake/.config/nixos/dots;
in
{
  imports = [ ../../modules/home-manager/modules.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  fishConfig.enable = true;
  zshConfig.enable = true;
  firefoxConfig.enable = true;
  qtConfig.enable = true;
  gtkConfig.enable = true;

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
  };

  home.packages = with pkgs; [
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
    foliate
    easyeffects
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
      delta.enable = true;
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
