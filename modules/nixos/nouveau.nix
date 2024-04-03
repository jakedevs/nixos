{ config, lib, pkgs, input, ... }: {
  # Enable all 'git' packages and options for bleeding edge
  boot.initrd.kernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nouveau" ];
  chaotic.mesa-git.enable = false;

  environment.systemPackages = with pkgs;
    [
      libva
      libva-utils
      vaapiVdpau
      vulkan-tools
      egl-wayland
      libglvnd
      glxinfo
    ];

  environment.sessionVariables = {
    NOUVEAU_USE_ZINK = "1";
  };
}
