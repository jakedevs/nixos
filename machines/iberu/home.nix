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
