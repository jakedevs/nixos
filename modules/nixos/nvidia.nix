{ config, lib, pkgs, input, ... }: {
  boot = {
    initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    kernelParams = [ "nvidia.NVreg_PreserveVideoMemoryAllocations=1" ];
    blacklistedKernelModules = [ "nouveau" ];
    extraModprobeConfig = ''
      options nvidia-drm modeset=1
      blacklist nouveau
      options nouveau modeset=0
    '';
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    powerManagement.enable = true;
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };
}
