{
  config,
  pkgs,
  username,
  inputs,
  ...
}:
{
  imports = [ ../../modules/home-manager/modules.nix ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  fishConfig.enable = true;
  zshConfig.enable = true;
  firefoxConfig.enable = true;
  qtConfig.enable = true;
  gtkConfig.enable = true;
  emacsConfig.enable = false;

  home = {
    username = username;
    homeDirectory = "/home/${username}";
    stateVersion = "24.05";
  };

  home.file = {
    "waybar".source = ../../dots/waybar;
    "waybar".target = "/home/${username}/.config/waybar";
    "dunst".source = ../../dots/dunst;
    "dunst".target = "/home/${username}/.config/dunst";
    "alacritty".source = ../../dots/alacritty;
    "alacritty".target = "/home/${username}/.config/alacritty";
    "foot".source = ../../dots/foot;
    "foot".target = "/home/${username}/.config/foot";
    "rofi".source = ../../dots/rofi;
    "rofi".target = "/home/${username}/.config/rofi";
  };

  home.packages = with pkgs; [
    rnote
    krita
    qutebrowser
    # Desktop
    gitui
    prismlauncher

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
    EDITOR = "hx";
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
      enable = true;
      userEmail = "main@jakedevs.net";
      userName = "jakedevs";
    };
    git.extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
