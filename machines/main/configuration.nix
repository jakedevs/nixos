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
  gamingConfig.enable = true;

  boot = {
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot = {
      enable = true;
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
  };

  services = {

    dbus.implementation = "broker";

    getty.autologinUser = username;

    watchdogd.enable = false;
    resolved = {
      enable = true;
      extraConfig = ''
          [Resolve]
        nameserver 1.1.1.1
      '';
    };

    gvfs.enable = true;

    flatpak.enable = true;
  };

  programs = {

    corectrl = {
      enable = true;
      gpuOverclock.enable = true;
    };

    # coolercontrol = {
    #   enable = true;
    #   nvidiaSupport = true;
    # };

    npm.enable = true;

    # gpu-screen-recorder.enable = true;
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
    font-awesome
    jetbrains-mono
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

  security.pam.services.hyprlock = { };

  environment.systemPackages = with pkgs; [
    nodejs
    pulseaudio
    pamixer
    python3
    python312Packages.gpustat
    libsForQt5.dolphin
    geoclue2
    inputs.zen-browser.packages."${system}".default
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
  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
      "https://cuda-maintainers.cachix.org"
      "https://cache.garnix.io"
      "https://helix.cachix.org"
      "https://ezkea.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="
    ];
  };

  nixpkgs.config.permittedInsecurePackages = [
    "nix-2.24.5"
  ];

}
