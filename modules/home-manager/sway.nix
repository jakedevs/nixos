{ config, lib, pkgs, input, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  home.sessionVariables = { };

}
