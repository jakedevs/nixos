{
  config,
  lib,
  pkgs,
  input,
  ...
}:
{
  options.nouveauConfig.enable = lib.mkEnableOption "enable nouveau config";

  config = lib.mkIf config.nouveauConfig.enable {
    # Enable all 'git' packages and options for bleeding edge
    boot.initrd.kernelModules = [ "nouveau" ];
    services.xserver.videoDrivers = [ "nouveau" ];
    chaotic.mesa-git.enable = false;

    environment.systemPackages = with pkgs; [
      libva
      libva-utils
      vaapiVdpau
      vulkanPackages_latest.vulkan-tools
      egl-wayland
      libglvnd
      glxinfo
    ];

    environment.sessionVariables = {
      NOUVEAU_USE_ZINK = "1";
    };
  };
}
