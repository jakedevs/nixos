{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/disk.nix
    ../../cache.nix
    # Official Nvidia drivers, fast
    # ../../modules/nixos/nvidia.nix
    # 3rd party Nouveau Nvidia driver, stable
    ../../modules/nixos/nouveau.nix
    #      ../../modules/nixos/vscodeserver.nix
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    loader.systemd-boot.configurationLimit = 3;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking.hostName = "jake";
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

  hardware = {
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
  };

  # systemd = {
  #   # Fix opening links in apps like vscode
  #   user.extraConfig = ''
  #     DefaultEnvironment="PATH=/run/current-system/sw/bin:/run/wrappers/bin:/var/lib/flatpak/exports/bin:/nix/profile/bin:/etc/profiles/per-user/jake/bin:/nix/var/nix/profiles/default/bin:/home/jake/.local/share/applications/"
  #   '';
  # };

  services = {

		gvfs.enable = true;

    flatpak.enable = true;

    xserver = {
      xkb.layout = "us";
      xkb.variant = "";
    };

    openssh.enable = true;
    self-deploy.sshKeyFile = /home/jake/.ssh;

    passSecretService.enable = true;

    syncthing = {
      enable = true;
      user = "jake";
      dataDir = "/home/jake/Sync";
      configDir = "/home/jake/.config/syncthing";
      overrideDevices = true;
      overrideFolders = true;
      settings = {
        devices = {
          "SM-G991U" = {
            id =
              "4XQYBAU-RVG24HB-2FMFRXC-KISKNWJ-CLRFPKV-HLPJM3C-BVTV7VU-7JWBSA5";
          };
        };
        folders = {
          "Sync" = {
            path = "/home/jake/Sync";
            devices = [ "SM-G991U" ];
          };
          "Notes" = {
            path = "/home/jake/Notes";
            devices = [ "SM-G991U" ];
          };
        };
        gui = {
          user = "jake";
          password = "1907";
        };
      };
    };
  };

  programs = {
    # Necessary
    dconf.enable = true;

    # Version Control
    git.enable = true;

    # Compositor
    hyprland.enable = true;

    #Files
    thunar.enable = true;
    thunar.plugins = with pkgs.xfce; [ thunar-archive-plugin thunar-volman ];

    # Utility
    nix-ld.enable = true;
    nix-ld.libraries = with pkgs; [ ];

    steam.enable = true;
    steam.remotePlay.openFirewall = true;
    steam.dedicatedServer.openFirewall = true;
  };

  fonts.packages = with pkgs; [ hermit fira-code-nerdfont hack-font ];
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
  users.users.jake = {
    isNormalUser = true;
    description = "jake";
    ignoreShellProgramCheck = true;
    shell = pkgs.fish;
    useDefaultShell = true;
    extraGroups = [ "networkmanager" "wheel" ];
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = { "jake" = import ./home.nix; };
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ ];

  environment.systemPackages = with pkgs; [
    inputs.nixvim.packages.${system}.default
    rustup
    gccgo13
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
    pinentry-qt
  ];
  environment.sessionVariables = { NIXOS_OZONE_WL = "1"; };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  networking.firewall.enable = false;
  system.stateVersion = "23.11";
}
