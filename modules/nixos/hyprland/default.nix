{
  inputs,
  pkgs,
  lib,
  config,
  username,
  ...
}:
{

  options.hyprConfig.enable = lib.mkEnableOption "enable hyprland config";

  config = lib.mkIf config.hyprConfig.enable {

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    home-manager.users.${username} = {

      home.packages = with pkgs; [
        hyprpaper
        hyprpicker
        hyprlock
        grimblast
        waybar
        dunst
        killall
      ];

      wayland.windowManager.hyprland = {
        enable = true;

        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        # package = pkgs.hyprland;

        # plugins = [ inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars ];

        settings = {
          "source" = "~/.config/nixos/modules/nixos/hyprland/hyprland.conf";
        };
      };

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = false;
        configPackages = [ inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland ];
        extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
      };
    };
  };
}
