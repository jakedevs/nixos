{
  config,
  pkgs,
  username,
  inputs,
  ...
}:
{
  imports = [
    ../../modules/home-manager/modules.nix
    inputs.ags.homeManagerModules.default
  ];

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
    "waybar".target = "/home/jake/.config/waybar";
    "dunst".source = ../../dots/dunst;
    "dunst".target = "/home/jake/.config/dunst";
    "alacritty".source = ../../dots/alacritty;
    "alacritty".target = "/home/jake/.config/alacritty";
  };

  home.packages = with pkgs; [
    # davinci-resolve
    # tenacity
    gitu
    languagetool
    ltex-ls
    markdown-oxide
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
    ungoogled-chromium

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
  programs.ags.enable  = true;

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
