{ config, lib, pkgs, input, ... }: {
  # Enable all 'git' packages and options for bleeding edge
  boot.initrd.kernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nouveau" ];
  chaotic.mesa-git.enable = true;

  environment.systemPackages = with pkgs;
    [
      libva
      mesa_git
      mesa32_git
      libva-utils
      libdrm_git
      libdrm32_git
      vaapiVdpau
      vulkan-tools
      egl-wayland
      libglvnd
      glxinfo
    ];

  environment.sessionVariables = {
    NOUVEAU_USE_ZINK = "0";
  };
}
