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
      systemd.setPath.enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    };

    # Host agnostic
    home-manager.users.${username} = {

      home.packages = with pkgs; [
        hyprpaper
        hyprpicker
        hyprlock
        hyprcursor
        grimblast
        grim
        slurp
        waybar
        dunst
        killall
        lxqt.lxqt-policykit
        wev
        wl-clipboard
        wl-clipboard-x11
        libnotify
        libappindicator
        lxqt.pavucontrol-qt
        rofi-wayland
        imv
        swaybg

        # Laptop specific, move to separate module soon
        brightnessctl
      ];

      wayland.windowManager.hyprland = {
        sourceFirst = true;
        enable = true;

        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        # package = pkgs.hyprland;

        # plugins = [ inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars ];

        settings = {
          "source" = "~/.config/nixos/modules/nixos/hyprland/${username}.conf";
        };
      };

      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = false;
        configPackages = [ inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland ];
        extraPortals = [ pkgs.xdg-desktop-portal-kde ];
      };
      programs.hyprlock = {
        enable = true;
        sourceFirst = true;
        settings = {
          "source" = "~/.config/nixos/modules/nixos/hyprland/hyprlock/hyprlock.conf";
        };
      };
    };
  };
}
