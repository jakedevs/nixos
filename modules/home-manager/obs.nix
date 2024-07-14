{ inputs, pkgs, ... }:
{
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
}
