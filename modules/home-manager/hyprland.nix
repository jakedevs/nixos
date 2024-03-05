{ inputs, pkgs, hyprland, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];


    settings = {
      "source" = "~/.config/hyprland.conf";
    };

  };
  #  xdg.portal = {
  #    extraPortals = [ pkgs.inputs.hyprland.xdg-desktop-portal-hyprland ];
  #    configPackages = [ pkgs.inputs.hyprland.hyprland ];
  #  };
}
