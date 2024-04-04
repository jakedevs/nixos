{ inputs, pkgs, ... }: {
  home.packages = with pkgs; [ hyprpaper hyprpicker hyprlock grimblast ];

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.system}.hyprland;

    plugins = [
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars
      inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
    ];

    settings = {
      "source" = "~/.config/nixos/modules/home-manager/hyprland/hyprland.conf";
    };

  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    configPackages =
      [ inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland ];
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
}
