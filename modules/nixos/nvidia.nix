{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{

  options.nvidiaConfig = {
    enable = lib.mkEnableOption "Nvidia Drivers";
    version = lib.mkOption {
      type = lib.types.enum [
        "official"
        "nouveau"
      ];
      default = "official";
      example = "official";
      description = "Sets driver type. `official` is for the proprietary Nvidia drivers, while Nouveau is the fully open source driver. ";
    };
  };

  config = lib.mkIf config.nvidiaConfig.enable (
    lib.mkMerge [
      (lib.mkIf (config.nvidiaConfig.version == "nouveau") {
        boot.initrd.kernelModules = [ "nouveau" ];
        boot.kernelParams = [
          "nouveau.config=NvGspRm=1"
          "nouveau.debug=info,VBIOS=info,gsp=info"
        ];
        services.xserver.videoDrivers = [ "nouveau" ];
        chaotic.mesa-git.enable = false;

        environment.systemPackages = with pkgs; [
          lshw
          libva
          libva-utils
          vaapiVdpau
          vulkanPackages_latest.vulkan-tools
          glxinfo
        ];

        hardware.graphics = {
          enable = true;
          enable32Bit = true;
        };

        environment.sessionVariables = {
          NOUVEAU_USE_ZINK = "1";
        };
      })

      (lib.mkIf (config.nvidiaConfig.version == "official") {

        environment.systemPackages = with pkgs; [ lshw ];
        boot = {
          initrd.kernelModules = [
            "nvidia"
            "nvidia_modeset"
            "nvidia_uvm"
            "nvidia_drm"
          ];
          kernelParams = [
            "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
            "nvidia_drm.fbdev=1"
          ];
          # blacklistedKernelModules = [ "nouveau" ];
          extraModprobeConfig = ''
            options nvidia-drm modeset=1
          '';
        };

        services.xserver.videoDrivers = [ "nvidia" ];

        hardware = {
          graphics = {
            enable = true;
            enable32Bit = true;
          };

          nvidia = {
            powerManagement.enable = false;
            open = false;
            modesetting.enable = true;
            nvidiaSettings = true;
            package = config.boot.kernelPackages.nvidiaPackages.beta;
          };
        };
      })
    ]
  );

}
