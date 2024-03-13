{ inputs, pkgs, ... }: {

  imports = [
    ../themes/gtk.nix
    ../themes/qt.nix
  ];
  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
    ];

    settings = {
      "source" = "~/.config/nixos/modules/home-manager/hyprland/hyprland.conf";
    };

  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    configPackages = [ pkgs.xdg-desktop-portal-hyprland ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
