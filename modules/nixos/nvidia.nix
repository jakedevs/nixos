{ config, lib, pkgs, input, ... }: {
  boot = {
    initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    blacklistedKernelModules = [ "nouveau" ];
    extraModprobeConfig = ''
      blacklist nouveau
      options nvidia-drm modeset=1
    '';
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;
}
