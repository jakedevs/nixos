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

  hyprConfig.enable = true;
  idleConfig.enable = true;

  boot = {
    loader = {
      systemd-boot.enable = true;
      systemd-boot.consoleMode = "max";
      systemd-boot.configurationLimit = 25;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_cachyos;
  };

  networking = {
    hostName = username;
    networkmanager.enable = true;
  };

  time.timeZone = "US/Eastern";

  i18n = {

    defaultLocale = "en_US.UTF-8";
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
      username
    ];
    auto-optimise-store = true;
  };

  hardware.graphics = {
    enable = true;
  };

  services = {

    tlp.enable = true;
    tlp.settings = {
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    };

    gvfs.enable = true;

    fwupd = {
      enable = true;
    };

    libinput.enable = true;

    upower.enable = true;

    # flatpak.enable = true;

    resolved = {
      enable = true;
      extraConfig = ''
        [Resolve]
        DNS=45.90.28.0#ca43df.dns.nextdns.io
        DNS=2a07:a8c0::#ca43df.dns.nextdns.io
        DNS=45.90.30.0#ca43df.dns.nextdns.io
        DNS=2a07:a8c1::#ca43df.dns.nextdns.io
        DNSOverTLS=yes
      '';

    };
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
    # nix-ld.enable = true;
    # # nix-ld.libraries = with pkgs; [];
    # appimage.enable = true;
    # appimage.binfmt = true;
  };

  fonts.packages = with pkgs; [
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
    description = username;
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

  hardware.enableAllFirmware = true;

  environment.systemPackages = with pkgs; [
    poweralertd
    helix
    gnome-firmware
    gparted
    eza
    bat
    pinentry-qt
  ];
  environment.sessionVariables = {
    FLAKE = "/home/${username}/.config/nixos";
    NIXOS_OZONE_WL = "1";
    NIXPKGS_ALLOW_UNFREE = "1";
    TLP_ENABLE = 1;
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = true;
  system.stateVersion = "24.05";
}
