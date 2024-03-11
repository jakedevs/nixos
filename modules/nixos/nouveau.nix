{ config, lib, pkgs, input, ... }: {
  boot.initrd.kernelModules = [ "nouveau" ];
  services.xserver.videoDrivers = [ "nouveau" ];
  chaotic.mesa-git.enable = true;

  environment.systemPackages = with pkgs;
    [
      libdrm_git
      libdrm32_git
      libva
      libva-utils
      mesa_git
      mesa32_git
      mesa-demos
      vaapiVdpau
      vulkan-tools
      egl-wayland
      libglvnd
    ];
}
