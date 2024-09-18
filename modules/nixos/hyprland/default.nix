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

    programs = {
      # uwsm = {
      #   enable = true;
      #   waylandCompositors = {
      #     hyprland = {
      #       prettyName = "Hyprland";
      #       comment = "Hyprland compositor managed by UWSM";
      #       binPath = "/run/current-system/sw/bin/Hyprland";
      #     };
      #   };
      # };

      hyprland = {
        enable = true;
        systemd.setPath.enable = true;
        # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        package = pkgs.hyprland;
      };
    };

    # Host agnostic
    home-manager.users.${username} = {

      # services = {};

      home.packages = with pkgs; [
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

        # package = inputs.hyprland.packages.${pkgs.system}.hyprland;
        package = pkgs.hyprland;

        # plugins = [ inputs.hyprland-plugins.packages.${pkgs.system}.hyprbars ];

        settings = {
          "source" = "~/.config/nixos/modules/nixos/hyprland/${username}.conf";
        };
      };

      # xdg.portal = {
      #   enable = false;
      #   xdgOpenUsePortal = false;
      #   configPackages = [
      #     inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland
      #   ];
      #   extraPortals = [ pkgs.xdg-desktop-portal-kde ];
      # };
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
