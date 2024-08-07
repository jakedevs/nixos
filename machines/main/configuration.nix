{
  pkgs,
  inputs,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./disk.nix
    ../../modules/nixos/modules.nix
  ];

  nvidiaConfig = {
    enable = true;
    version = "official";
  };

  hyprConfig.enable = true;
  idleConfig.enable = false;
  artConfig.enable = true;

  boot = {
    loader.systemd-boot = {
      enable = true;
      # netbootxyz.enable = true;
      editor = false;
      configurationLimit = 20;
    };

    kernelPackages = pkgs.linuxPackages_cachyos;

  };

  networking = {
    hostName = username;
    networkmanager.enable = true;
  };

  hardware = {
    enableAllFirmware = true;
    keyboard.qmk.enable = true;
  };

  time.timeZone = "US/Eastern";

  i18n = {
    defaultLocale = "ko_KR.UTF-8";
    supportedLocales = [
      "ko_KR.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
    ];
    inputMethod = {
      type = "fcitx5";
      enable = true;
      fcitx5 = {
        plasma6Support = true;
        addons = with pkgs; [
          fcitx5-hangul
          fcitx5-gtk
        ];
        waylandFrontend = true;
      };
    };
    extraLocaleSettings = {
      LC_ADDRESS = "ko_KR.UTF-8";
      LC_IDENTIFICATION = "ko_KR.UTF-8";
      LC_MEASUREMENT = "ko_KR.UTF-8";
      LC_MONETARY = "ko_KR.UTF-8";
      LC_NAME = "ko_KR.UTF-8";
      LC_NUMERIC = "ko_KR.UTF-8";
      LC_PAPER = "ko_KR.UTF-8";
      LC_TELEPHONE = "ko_KR.UTF-8";
      LC_TIME = "ko_KR.UTF-8";
    };
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    trusted-users = [
      "root"
      "jake"
    ];
  };

  services = {
    watchdogd.enable = false;
    resolved = {
      enable = true;
      extraConfig = ''
          [Resolve]
        nameserver 1.1.1.1
      '';
    };
    gvfs.enable = true;

    # flatpak.enable = true;
  };

  programs = {
    # Necessary
    dconf.enable = true;

    # Version Control
    git.enable = true;

    #Files
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [
      thunar-archive-plugin
      thunar-volman
    ];

    # Utility
    nix-ld.enable = true;
    nix-ld.package = pkgs.nix-ld-rs;
    # nix-ld.libraries = with pkgs; [ ];
    appimage.enable = true;
    appimage.binfmt = true;
  };

  fonts.packages = with pkgs; [
    hermit
    baekmuk-ttf
    fira-code-nerdfont
    hack-font
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
  ];

  fonts.enableDefaultPackages = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;
  programs.fish.useBabelfish = true;
  users.defaultUserShell = pkgs.fish;
  users.users.${username} = {
    isNormalUser = true;
    description = "jake";
    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
    useDefaultShell = true;
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    users = {
      ${username} = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ ];

  services.udev.packages = with pkgs; [
    vial
    via
  ];

  environment.systemPackages = with pkgs; [
    libsForQt5.dolphin
    geoclue2
    inputs.helix.packages.${pkgs.system}.helix
    nix-fast-build
    qmk
    xdg-utils
    distrobox
    vial
    via
    libclang
    clang
    gparted
    eza
    bat
    pinentry-qt
  ];
  environment.sessionVariables = {
    EDITOR = "hx";
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "24.05";
}
