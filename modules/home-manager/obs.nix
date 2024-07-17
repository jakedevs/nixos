{
  inputs,
  pkgs,
  config,
  lib,
  ...
}:
{
  options.obsConfig.enable = lib.mkEnableOption "enable OBS config";
  config = lib.mkIf config.obsConfig.enable {
    programs.obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-vaapi
        obs-nvfbc
        obs-vkcapture
        input-overlay
        obs-pipewire-audio-capture
      ];
    };
  };
}
