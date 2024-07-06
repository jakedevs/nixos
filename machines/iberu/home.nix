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
  zshConfig.enable = false;
  firefoxConfig.enable = true;
  qtConfig.enable = true;
  gtkConfig.enable = true;

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
    # Desktop
    alacritty_git
    foot
    telegram-desktop
    anki-bin
    mpv
    yt-dlp
    obsidian
    okular
    qalculate-gtk
    libreoffice-qt6-fresh
    ungoogled-chromium

    foliate

    # CLI
    cmatrix
    mdbook
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
