{ config, lib, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./cachix.nix

      # Official Nvidia drivers
      #      ./modules/nixos/nvidia.nix
      # 3rd party Nouveau Nvidia driver
      ./modules/nixos/nouveau.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
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

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.trusted-users = [ "root" "jake" ];
  nix.settings.auto-optimise-store = true;

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  services.openssh.enable = true;
  services.self-deploy.sshKeyFile = /home/jake/.ssh;

  hardware = {
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
  };

  programs =
    {
      #Necessary
      dconf.enable = true;

      #Editor
      neovim.enable = true;
      neovim.vimAlias = true;
      neovim.viAlias = true;
      neovim.defaultEditor = true;

      #Compositor

      #Version Control
      git.enable = true;

      #Files
      thunar.enable = true;

      #Utility
      nix-ld.enable = true;
      nix-ld.libraries = with pkgs; [ ];
    };

  services.syncthing = {
    enable = true;
    user = "jake";
    dataDir = "/home/jake/Sync";
    settings = {
      folders = {
        "Sync" = {
          path = "/home/jake/Sync";
        };
      };
    };
    configDir = "/home/jake/.config/syncthing";
  };

  fonts.packages = [ pkgs.hermit pkgs.nerdfonts ];
  fonts.enableDefaultPackages = true;

  services.xserver = {
    xkb.layout = "us";
    xkb.variant = "";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };


  users.users.jake = {
    isNormalUser = true;
    description = "jake";
    ignoreShellProgramCheck = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "jake" = import ./home.nix;
    };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ ];

  environment.systemPackages = with pkgs;
    [
      gnumake
      nodejs_21
      nil
      nixpkgs-fmt
      cargo
      meson
      cmake
      cachix
      ccls
      eza
      bat
      python3
    ];

  environment.sessionVariables =
    {
      NIXOS_OZONE_WL = "1";
    };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  system.stateVersion = "23.11";

}
