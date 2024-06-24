{
  lib,
  config,
  username,
  ...
}:
{

  options.idleConfig.enable = lib.mkEnableOption "enable idle config";

  config = lib.mkIf config.idleConfig.enable {

    security.pam.services.hyprlock = { };

    home-manager.users.${username} = {
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            disable_loading_bar = false;
            grace = 0;
            hide_cursor = true;
            no_fade_in = false;
          };

          background = [
            {
              blur_passes = 3;
              blur_size = 8;
            }
          ];

          input-field = [
            {
              size = "200, 50";
              position = "0, -80";
              monitor = "";
              dots_center = true;
              fade_on_empty = false;
              font_color = "rgb(202, 211, 245)";
              inner_color = "rgb(91, 96, 120)";
              outer_color = "rgb(24, 25, 38)";
              outline_thickness = 5;
              placeholder_text = "pass...";
              shadow_passes = 2;
            }
          ];
        };
      };
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            ignore_dbus_inhibit = false;
            ignore_systemd_ihibit = false;
            before_sleep_cmd = "loginctl lock-session";
            lock_cmd = "pidof hyprlock || hyprlock";
            unlock_cmd = "pkill -USR1 hyprlock";
          };

          listener = [
            {
              timeout = 300;
              on-timeout = "loginctl lock-session";
            }
          ];
        };
      };
    };
  };
}
