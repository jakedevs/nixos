{
  pkgs,
  inputs,
  username,
  lib,
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
  gamingConfig.enable = true;
  idleConfig.enable = false;
  syncthingConfig.enable = false;

  boot = {
    loader.systemd-boot = {
      enable = true;
      netbootxyz.enable = true;
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
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enabled = "fcitx5";
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
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
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
    auto-optimise-store = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services = {
    resolved = {
      enable = true;
      extraConfig = ''
          [Resolve]
        nameserver 1.1.1.1
      '';
    };
    gvfs.enable = true;

    mpd.enable = true;

    # flatpak.enable = true;
  };

  programs = {
    neovim = {
      viAlias = true;
      vimAlias = true;
      enable = true;
      defaultEditor = true;
    };

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
    # nix-ld.libraries = with pkgs; [];
    appimage.enable = true;
    appimage.binfmt = true;
  };

  fonts.packages = with pkgs; [
    hermit
    fira-code-nerdfont
    hack-font
    noto-fonts-cjk-serif
    noto-fonts-cjk-sans
  ];

  fonts.enableDefaultPackages = true;

  sound.enable = true;
  hardware.pulseaudio.enable = false;
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
    qmk
    xdg-utils
    distrobox
    helix
    vial
    via
    gparted
    eza
    bat
    pinentry-qt
  ];
  environment.sessionVariables = {
    FLAKE = "/home/jake/.config/nixos";
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "24.05";
}
